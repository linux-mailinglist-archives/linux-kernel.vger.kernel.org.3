Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6DC5577DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiFWK1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiFWK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35C53E5F7;
        Thu, 23 Jun 2022 03:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59AFB61E7B;
        Thu, 23 Jun 2022 10:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F82C3411B;
        Thu, 23 Jun 2022 10:27:07 +0000 (UTC)
Date:   Thu, 23 Jun 2022 11:27:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        liushixin <liushixin2@huawei.com>
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Message-ID: <YrQ/98J5UqPh8K89@arm.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
 <YrIIJkhKWSuAqkCx@arm.com>
 <ba3a97d6-262d-6413-135d-0be9b0af9a6a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba3a97d6-262d-6413-135d-0be9b0af9a6a@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 08:03:21PM +0800, Kefeng Wang wrote:
> On 2022/6/22 2:04, Catalin Marinas wrote:
> > On Tue, Jun 21, 2022 at 02:24:01PM +0800, Kefeng Wang wrote:
> > > On 2022/6/21 13:33, Baoquan He wrote:
> > > > On 06/13/22 at 04:09pm, Zhen Lei wrote:
> > > > > If the crashkernel has both high memory above DMA zones and low memory
> > > > > in DMA zones, kexec always loads the content such as Image and dtb to the
> > > > > high memory instead of the low memory. This means that only high memory
> > > > > requires write protection based on page-level mapping. The allocation of
> > > > > high memory does not depend on the DMA boundary. So we can reserve the
> > > > > high memory first even if the crashkernel reservation is deferred.
> > > > > 
> > > > > This means that the block mapping can still be performed on other kernel
> > > > > linear address spaces, the TLB miss rate can be reduced and the system
> > > > > performance will be improved.
> > > > Ugh, this looks a little ugly, honestly.
> > > > 
> > > > If that's for sure arm64 can't split large page mapping of linear
> > > > region, this patch is one way to optimize linear mapping. Given kdump
> > > > setting is necessary on arm64 server, the booting speed is truly
> > > > impacted heavily.
> > > Is there some conclusion or discussion that arm64 can't split large page
> > > mapping?
> > > 
> > > Could the crashkernel reservation (and Kfence pool) be splited dynamically?
> > > 
> > > I found Mark replay "arm64: remove page granularity limitation from
> > > KFENCE"[1],
> > > 
> > >    "We also avoid live changes from block<->table mappings, since the
> > >    archtitecture gives us very weak guarantees there and generally requires
> > >    a Break-Before-Make sequence (though IIRC this was tightened up
> > >    somewhat, so maybe going one way is supposed to work). Unless it's
> > >    really necessary, I'd rather not split these block mappings while
> > >    they're live."
> > The problem with splitting is that you can end up with two entries in
> > the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
> > for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
> > abort (but can be worse like loss of coherency).
> Thanks for your explanation，
> > Prior to FEAT_BBM (added in ARMv8.4), such scenario was not allowed at
> > all, the software would have to unmap the range, TLBI, remap. With
> > FEAT_BBM (level 2), we can do this without tearing the mapping down but
> > we still need to handle the potential TLB conflict abort. The handler
> > only needs a TLBI but if it touches the memory range being changed it
> > risks faulting again. With vmap stacks and the kernel image mapped in
> > the vmalloc space, we have a small window where this could be handled
> > but we probably can't go into the C part of the exception handling
> > (tracing etc. may access a kmalloc'ed object for example).
> 
> So if without FEAT_BBM，we can only guarantee BBM sequence via
> "unmap the range, TLBI, remap" or the following option,

Yes, that's the break-before-make sequence.

> and with FEAT_BBM (level 2), we could have easy way to avoid TLB
> conflict for some vmalloc space, but still hard to deal with other
> scence?

It's not too hard in theory. Basically there's a small risk of getting a
TLB conflict abort for the mappings you change without a BBM sequence (I
think it's nearly non-existed when going from large block to smaller
pages, though the architecture states that it's still possible). Since
we only want to do this for the linear map and the kernel and stack are
in the vmalloc space, we can handle such trap as an safety measure (it
just needs a TLBI). It may help to tweak a model to force it to generate
such conflict aborts, otherwise we'd not be able to test the code.

It's possible that such trap is raised at EL2 if a guest caused the
conflict abort (the architecture left this as IMP DEF). The hypervisors
may need to be taught to do a TLBI VMALLS12E1 instead of killing the
guest. I haven't checked what KVM does.

-- 
Catalin
