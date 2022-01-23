Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6AE497381
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbiAWRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:15:07 -0500
Received: from m228-6.mailgun.net ([159.135.228.6]:55877 "EHLO
        m228-6.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiAWRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:15:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1642958106; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=KMCKo4cpOIFU5Z2gsr3EOOcDEAmZ5XEZ/k/AX4zaDbA=; b=bBjK088xo1ObtreG6xEsbIqQcjZZvwloJ/7WIwD51x/E9qj1cBQ2HRSZTWhhvCh/sQF2AfcA
 LArShW7hQnzW8U70B+GEPoT1HwLL0LKLnN2x0ntNjQS8mluD4hsWXXbGDat5Nk2QBReNigca
 t+EPclzBoH33dCczyB8+vV3RlR8=
X-Mailgun-Sending-Ip: 159.135.228.6
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61ed8d16e0071250cf5a03b8 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sun, 23 Jan 2022 17:15:02 GMT
Sender: michael@michaelkloos.com
Received: from [192.168.0.104] (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 425B240249;
        Sun, 23 Jan 2022 17:15:01 +0000 (UTC)
Message-ID: <3607326c-9d39-a9e7-8e14-65aaef2094fd@michaelkloos.com>
Date:   Sun, 23 Jan 2022 12:15:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] Fixed: Misaligned memory access. Fixed pointer
 comparison.
Content-Language: en-US
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <20220123034518.3717116-1-michael@michaelkloos.com>
 <485047B2-E566-4679-87CF-C4B3CAFEF108@jrtc27.com>
From:   "Michael T. Kloos" <michael@michaelkloos.com>
In-Reply-To: <485047B2-E566-4679-87CF-C4B3CAFEF108@jrtc27.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, you are correct, but while I am not that knowledgeable in the kernel
build system, I believe that in many build systems, binutils "as" is usually
called by the "gcc" wrapper, rather than being executed directly.  This
allows for the C preprocessor to be easily and automatically run over *.S
files first.  Binutils "as" doesn't care about suffix.  It just assembles.
"gcc" will check and call the other tools as necessary to build.

Perhaps I should have been more specific in my language.  However,
I was trying to refer to the 2 different build systems in their entirety,
not their individually sub-components because I had originally test
built with gcc, not clang.

	Michael

On 1/23/22 10:44, Jessica Clarke wrote:

> On 23 Jan 2022, at 03:45, Michael T. Kloos <michael@michaelkloos.com> wrote:
>> Rewrote the riscv memmove() assembly implementation.  The
>> previous implementation did not check memory alignment and it
>> compared 2 pointers with a signed comparison.  The misaligned
>> memory access would cause the kernel to crash on systems that
>> did not emulate it in firmware and did not support it in hardware.
>> Firmware emulation is slow and may not exist.  Additionally,
>> hardware support may not exist and would likely still run slower
>> than aligned accesses even if it did.  The RISC-V spec does not
>> guarantee that support for misaligned memory accesses will exist.
>> It should not be depended on.
>>
>> This patch now checks for the maximum granularity of co-alignment
>> between the pointers and copies them with that, using single-byte
>> copy for any unaligned data at their terminations.  It also now uses
>> unsigned comparison for the pointers.
>>
>> Added half-word and, if built for 64-bit, double-word copy.
>>
>> Migrated to the	newer assembler annotations from the now deprecated
>> ones.
>>
>> Commit Message Edited on Jan 22 2022: Fixed some typos.
>>
>> [v2]
>>
>> Per kernel test robot, I have fixed the build under clang.  This
>> was broken due to a difference between gcc and clang, clang requiring
>> explict zero offsets the jalr instruction. gcc allowed them to be
>> omitted if zero.
> Unlike LLVM, GCC does not have an assembler, that’s binutils’s GNU as.
>
> Jess
>
