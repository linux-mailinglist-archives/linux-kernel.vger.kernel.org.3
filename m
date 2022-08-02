Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87285874C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiHBAZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHBAZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:25:23 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D74B6554
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:25:22 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4C95C40D403E;
        Tue,  2 Aug 2022 00:25:20 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 02 Aug 2022 03:25:20 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
In-Reply-To: <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
References: <cover.1659369873.git.baskov@ispras.ru>
 <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <893da11995f93a7ea8f7485d17bf356a@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 19:48, Dave Hansen wrote:
> On 8/1/22 09:38, Evgeniy Baskov wrote:
>> This is the first half of changes aimed to increase security of early
>> boot code of compressed kernel for x86_64 by enforcing memory 
>> protection
>> on page table level.
> 
> Could you share a little more background here?  Hardening is good, but
> you _can_ have too much of a good thing.
> 
> Is this part of the boot cycle becoming a target for attackers in
> trusted boot environments?  Do emerging confidential computing
> technologies like SEV and TDX cause increased reliance on compressed
> kernel security?
> 
> In other words, why is *THIS* important versus all the other patches
> floating around out there?

Now compressed kernel code becomes larger, partially because of adding
SEV and TDX, so it worth adding memory protection here.

First part implements partial memory protection for every way of booting
the kernel, and second adds full W^X implementation specifically for the
UEFI code path. First part also contains prerequisite changes for the
second part like adding explicit memory allocation in extraction code
and adjusting ld-script to produce ELF images suitable for mapping PE
sections on top of them with appropriate access rights.

One of pros for this patch set is that is would reveal invalid memory
accesses by removing implicit memory mapping and reducing access rights
for mapped memory. So it makes further development of the compressed
kernel code less error prone.

Furthermore, memory protection indeed makes it harder to attack kernel
during boot cycle. And unlike TDX and SEV it does not not only aim to
protect kernel from attacks outside of virtualized environments but it
also makes attacking the kernel booting on bare metal harder. If some
code injection vulnerability lives inside compressed kernel code this
will likely make it harder to exploit.

Another thing is that it should not bring any noticeable overhead.
Second part can actually reduce overhead slightly by removing the need
to copy the kernel image around during boot process and extracting the
kernel before exiting EFI boot services.

Second part also makes kernel more spec compliant PE image as a part
of an implementation of memory protection in EFI environment. This will
allow booting the kernel with stricter implementations of PE loaders,
e.g. [1]. And stricter PE loader is really desired, since current EDK II
implementation contains numerous problems [2].

[1] https://github.com/acidanthera/audk/tree/secure_pe
[2] https://arxiv.org/pdf/2012.05471.pdf

Thanks,
Evgeniy Baskov
