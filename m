Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F121552E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348787AbiFUJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347043AbiFUJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E3B7300
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655803670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/6eJspt/AVzBoz5mItJSgxql1F5f7nb/z62lzZC//s=;
        b=h92MBdQ60YyfZtTbeTYIsHZWShRLkjKqTjvj2+fhkEzm8r35rgkMIsdzQo3u8IA9caCYqf
        5pxhNmMkM6OnewRaPK1fLodCkqUaE5yz1EyXfayLo9+RONtmB/JSoZisruRS5D5+BQzVE2
        ixudyhNSW9jUk8rYMuFumpZtVxYWyig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-MQve9TMLMYyX3G1gVtvhfA-1; Tue, 21 Jun 2022 05:27:47 -0400
X-MC-Unique: MQve9TMLMYyX3G1gVtvhfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 539A280B70F;
        Tue, 21 Jun 2022 09:27:46 +0000 (UTC)
Received: from localhost (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A52A540CFD0A;
        Tue, 21 Jun 2022 09:27:44 +0000 (UTC)
Date:   Tue, 21 Jun 2022 17:27:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <YrGPDLea0ALMOqFV@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/22 at 02:24pm, Kefeng Wang wrote:
> 
> On 2022/6/21 13:33, Baoquan He wrote:
> > Hi,
> > 
> > On 06/13/22 at 04:09pm, Zhen Lei wrote:
> > > If the crashkernel has both high memory above DMA zones and low memory
> > > in DMA zones, kexec always loads the content such as Image and dtb to the
> > > high memory instead of the low memory. This means that only high memory
> > > requires write protection based on page-level mapping. The allocation of
> > > high memory does not depend on the DMA boundary. So we can reserve the
> > > high memory first even if the crashkernel reservation is deferred.
> > > 
> > > This means that the block mapping can still be performed on other kernel
> > > linear address spaces, the TLB miss rate can be reduced and the system
> > > performance will be improved.
> > Ugh, this looks a little ugly, honestly.
> > 
> > If that's for sure arm64 can't split large page mapping of linear
> > region, this patch is one way to optimize linear mapping. Given kdump
> > setting is necessary on arm64 server, the booting speed is truly
> > impacted heavily.
> 
> Is there some conclusion or discussion that arm64 can't split large page
> mapping?

Yes, please see below commit log. 
commit d27cfa1fc823 ("arm64: mm: set the contiguous bit for kernel mappings where appropriate")

> 
> Could the crashkernel reservation (and Kfence pool) be splited dynamically?

For crashkernel region, we have arch_kexec_protect_crashkres() to secure
the region, and crash_shrink_memory() could be called to shrink it.
While crahshkernel region could be crossig part of a block mapping or section
mapping and the mapping need be splitted, that will cause TLB conflicts.

> 
> I found Mark replay "arm64: remove page granularity limitation from
> KFENCE"[1],
> 
>   "We also avoid live changes from block<->table mappings, since the
>   archtitecture gives us very weak guarantees there and generally requires
>   a Break-Before-Make sequence (though IIRC this was tightened up
>   somewhat, so maybe going one way is supposed to work). Unless it's
>   really necessary, I'd rather not split these block mappings while
>   they're live."
> 
> Hi Mark and Catalin,  could you give some comment,  many thanks.
> 
> [1] https://lore.kernel.org/lkml/20210920101938.GA13863@C02TD0UTHF1T.local/T/#m1a7f974593f5545cbcfc0d21560df4e7926b1381
> 
> 
> > 
> > However, I would suggest letting it as is with below reasons:
> > 
> > 1) The code will complicate the crashkernel reservatoin code which
> > is already difficult to understand.
> > 2) It can only optimize the two cases, first is CONFIG_ZONE_DMA|DMA32
> >    disabled, the other is crashkernel=,high is specified. While both
> >    two cases are corner case, most of systems have CONFIG_ZONE_DMA|DMA32
> >    enabled, and most of systems have crashkernel=xM which is enough.
> >    Having them optimized won't bring benefit to most of systems.
> > 3) Besides, the crashkernel=,high can be handled earlier because
> >    arm64 alwasys have memblock.bottom_up == false currently, thus we
> >    don't need worry arbout the lower limit of crashkernel,high
> >    reservation for now. If memblock.bottom_up is set true in the future,
> >    this patch doesn't work any more.
> > 
> > 
> > ...
> >          crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >                                                 crash_base, crash_max);
> > 
> > So, in my opinion, we can leave the current NON_BLOCK|SECT mapping as
> > is caused by crashkernel reserving, since no regression is brought.
> > And meantime, turning to check if there's any way to make the contiguous
> > linear mapping and later splitting work. The patch 4, 5 in this patchset
> > doesn't make much sense to me, frankly speaking.
> > 
> > Thanks
> > Baoquan
> 

