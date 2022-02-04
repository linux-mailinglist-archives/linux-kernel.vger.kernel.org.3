Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7167B4A9CA2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376361AbiBDQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:02:15 -0500
Received: from foss.arm.com ([217.140.110.172]:53824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376340AbiBDQCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:02:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C85B1396;
        Fri,  4 Feb 2022 08:02:14 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872153F718;
        Fri,  4 Feb 2022 08:02:12 -0800 (PST)
Date:   Fri, 4 Feb 2022 16:02:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] perf: Expand perf_branch_entry.type
Message-ID: <Yf1N/EWjlQ/bEA0D@FVFF77S0Q05N>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
 <1643348653-24367-3-git-send-email-anshuman.khandual@arm.com>
 <Yfpxv9+TP9rP72wL@FVFF77S0Q05N>
 <6168f881-92a4-54f8-929a-c2f40a36c112@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6168f881-92a4-54f8-929a-c2f40a36c112@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 10:25:24AM +0530, Anshuman Khandual wrote:
> On 2/2/22 5:27 PM, Mark Rutland wrote:
> > On Fri, Jan 28, 2022 at 11:14:13AM +0530, Anshuman Khandual wrote:
> >> @@ -1370,8 +1376,8 @@ struct perf_branch_entry {
> >>  		in_tx:1,    /* in transaction */
> >>  		abort:1,    /* transaction abort */
> >>  		cycles:16,  /* cycle count to last branch */
> >> -		type:4,     /* branch type */
> >> -		reserved:40;
> >> +		type:6,     /* branch type */
> > 
> > As above, is this a safe-change ABI-wise?
> 
> If the bit fields here cannot be expanded without breaking ABI, then
> there is a fundamental problem. Only remaining option will be to add
> new fields (with new width value) which could accommodate these new
> required branch types.

Unfortunately, I think expanding this does break ABI, and is a fundamental
problem, as:

(a) Any new values in the expanded field will be truncated when read by old
    userspace, and so those may be mis-reported. Maybe we're not too worried
    about this case.

(b) Depending on how the field is placed, existing values might get stored
    differently. This could break any mismatched combination of
    {old,new}-kernel and {old,new}-userspace.

    In practice, I think this means that this is broken for BE, and happens to
    work for LE, but I don't know how bitfields are defined for each
    architecture, so there could be other brokenness.

Consider the test case below:

--------
#include <stdbool.h>

struct bfv1 {
        unsigned long   a:20,
                        b:20,
                        c:4,
                        d:20;
};

struct bfv2 {
        unsigned long   a:20,
                        b:20,
                        c:6,
                        d:18;
};

union bf {
        struct bfv1 v1;
        struct bfv2 v2;
};

bool bfv1_w_r(unsigned char v)
{
        unsigned char v_old = v & ((1UL << 4) - 1);
        unsigned char v_new;
        union bf bf = { 0 };

        bf.v1.c = v_old;
        v_new = bf.v1.c;

        return v_old == v_new;
}

bool bfv2_w_r(unsigned char v)
{
        unsigned char v_old = v & ((1UL << 6) - 1);
        unsigned char v_new;
        union bf bf = { 0 };

        bf.v2.c = v_old;
        v_new = bf.v2.c;

        return v_old == v_new;
}

bool bfv1_w_bfv2_r(unsigned char v)
{
        unsigned char v_old = v & ((1UL << 4) - 1);
        unsigned char v_new;
        union bf bf = { 0 };

        bf.v1.c = v_old;
        v_new = bf.v2.c;

        return v_old == v_new;
}
--------

When compiled for little-endian AArch64, GCC thinks all old values will be
interpreted the same, and optimizes all the round-trip tests to return true:

| [mark@gravadlaks:~]% aarch64-linux-gnu-gcc -c bitfield-test.c -O2 -mlittle-endian
| [mark@gravadlaks:~]% aarch64-linux-gnu-objdump -d bitfield-test.o
|
| bitfield-test.o:     file format elf64-littleaarch64
|
|
| Disassembly of section .text:
|
| 0000000000000000 <bfv1_w_r>:
|    0:   52800020        mov     w0, #0x1                        // #1
|    4:   d65f03c0        ret
|
| 0000000000000008 <bfv2_w_r>:
|    8:   52800020        mov     w0, #0x1                        // #1
|    c:   d65f03c0        ret
|
| 0000000000000010 <bfv1_w_bfv2_r>:
|   10:   52800020        mov     w0, #0x1                        // #1
|   14:   d65f03c0        ret

But when compiled for big-endian AArch64, it doesn't believe that at all:

| [mark@gravadlaks:~]% aarch64-linux-gnu-gcc -c bitfield-test.c -O2 -mbig-endian
| [mark@gravadlaks:~]% aarch64-linux-gnu-objdump -d bitfield-test.o
|
| bitfield-test.o:     file format elf64-bigaarch64
|
|
| Disassembly of section .text:
|
| 0000000000000000 <bfv1_w_r>:
|    0:   52800020        mov     w0, #0x1                        // #1
|    4:   d65f03c0        ret
|
| 0000000000000008 <bfv2_w_r>:
|    8:   52800020        mov     w0, #0x1                        // #1
|    c:   d65f03c0        ret
|
| 0000000000000010 <bfv1_w_bfv2_r>:
|   10:   12001c00        and     w0, w0, #0xff
|   14:   12000c01        and     w1, w0, #0xf
|   18:   531e0c00        ubfiz   w0, w0, #2, #4
|   1c:   6b01001f        cmp     w0, w1
|   20:   1a9f17e0        cset    w0, eq  // eq = none
|   24:   d65f03c0        ret

If we add the following:

| void write_bfv1_c(union bf *bf, unsigned char v)
| {
|         bf->v1.c = v;
| }
| 
| void write_bfv2_c(union bf *bf, unsigned char v)
| {
|         bf->v2.c = v;
| }
| 
| unsigned char read_bfv1_c(union bf *bf)
| {
|         return bf->v1.c;
| }
| 
| unsigned char read_bfv2_c(union bf *bf)
| {
|         return bf->v2.c;
| }

For LE we get:

| 0000000000000018 <write_bfv1_c>:
|   18:   39401402        ldrb    w2, [x0, #5]
|   1c:   33000c22        bfxil   w2, w1, #0, #4
|   20:   39001402        strb    w2, [x0, #5]
|   24:   d65f03c0        ret
| 
| 0000000000000028 <write_bfv2_c>:
|   28:   39401402        ldrb    w2, [x0, #5]
|   2c:   33001422        bfxil   w2, w1, #0, #6
|   30:   39001402        strb    w2, [x0, #5]
|   34:   d65f03c0        ret
| 
| 0000000000000038 <read_bfv1_c>:
|   38:   39401400        ldrb    w0, [x0, #5]
|   3c:   92400c00        and     x0, x0, #0xf
|   40:   d65f03c0        ret
|   44:   d503201f        nop
| 
| 0000000000000048 <read_bfv2_c>:
|   48:   39401400        ldrb    w0, [x0, #5]
|   4c:   92401400        and     x0, x0, #0x3f
|   50:   d65f03c0        ret

... where the low bits of the field stay in the same place, so for all existing
values this happens to work.

For BE we get:

| 0000000000000028 <write_bfv1_c>:
|   28:   39401402        ldrb    w2, [x0, #5]
|   2c:   331c0c22        bfi     w2, w1, #4, #4
|   30:   39001402        strb    w2, [x0, #5]
|   34:   d65f03c0        ret
| 
| 0000000000000038 <write_bfv2_c>:
|   38:   39401402        ldrb    w2, [x0, #5]
|   3c:   331e1422        bfi     w2, w1, #2, #6
|   40:   39001402        strb    w2, [x0, #5]
|   44:   d65f03c0        ret
| 
| 0000000000000048 <read_bfv1_c>:
|   48:   39401400        ldrb    w0, [x0, #5]
|   4c:   53041c00        ubfx    w0, w0, #4, #4
|   50:   d65f03c0        ret
|   54:   d503201f        nop
| 
| 0000000000000058 <read_bfv2_c>:
|   58:   39401400        ldrb    w0, [x0, #5]
|   5c:   53021c00        ubfx    w0, w0, #2, #6
|   60:   d65f03c0        ret

... where the low bits of the field have moved, and so this is broken even for
existing values!

Thanks,
Mark.
