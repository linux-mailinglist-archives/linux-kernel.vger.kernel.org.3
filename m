Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19F51D6D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391432AbiEFLna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiEFLn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:43:28 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 712545F242
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651837184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcB6fBENu4U2sOdYXIyYqxCfjv8pZ5CyuZGdAtWdXiA=;
        b=N9A8/HvbldKClot1RHeLyTJhwAwL7i7JiMsfMCFi4P+DoVHSkiuTAzfvxcEVAi7/LvnKTk
        OOiWkaElyUD64GJGYyjoAEc0UoAikxMcO1a810UXwetTgtUZtZdfY+HoVwJCTusmV5tNSP
        3JjFdlIphyXiuJMg1PpCnmdhA+TfQSU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-uUHXo2N0O4iTn2v3Yo6D1A-1; Fri, 06 May 2022 07:39:43 -0400
X-MC-Unique: uUHXo2N0O4iTn2v3Yo6D1A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 067A3858F14;
        Fri,  6 May 2022 11:39:42 +0000 (UTC)
Received: from localhost (ovpn-13-105.pek2.redhat.com [10.72.13.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D80E1454A5D;
        Fri,  6 May 2022 11:39:39 +0000 (UTC)
Date:   Fri, 6 May 2022 19:39:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
Message-ID: <YnUI+PagSCZ/DnkL@MiWiFi-R3L-srv>
References: <YmlphvZVMsGfFksp@arm.com>
 <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
 <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
 <3fc41a94-4247-40f3-14e7-f11e3001ec33@huawei.com>
 <YmtaiJhwIgP6m2Sk@MiWiFi-R3L-srv>
 <a9c736a0-f2b3-5b8a-94d9-80742ccd2700@huawei.com>
 <23e2dcf4-4e9a-5298-d5d8-8761b0bbbe21@huawei.com>
 <YnGmCwaWkvCrJoU2@arm.com>
 <YnM9w69l5dbE+k15@MiWiFi-R3L-srv>
 <YnPdIvOktZBQYLjg@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnPdIvOktZBQYLjg@arm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/22 at 03:20pm, Catalin Marinas wrote:
> On Thu, May 05, 2022 at 11:00:19AM +0800, Baoquan He wrote:
> > On 05/03/22 at 11:00pm, Catalin Marinas wrote:
> > > So, to recap, IIUC you are fine with:
> > > 
> > > 	crashkernel=Y		- allocate within ZONE_DMA with fallback
> > > 				  above with a default in ZONE_DMA (like
> > > 				  x86, 256M or swiotlb size)
> > 
> >         Ack to this one.
> > 
> > 
> > > 	crashkernel=Y,high	- allocate from above ZONE_DMA
> > 
> >         Not exactly. If there's only ZONE_DMA, crashkernel,high will
> >         be reserved in ZONE_DMA, and crashkernel,low will be ignored.
> >         Other than this, ack.
> 
> Yes, that's fine.
> 
> > > 	crashkernel=Y,low	- allocate within ZONE_DMA
> > 
> >         Ack to this one.
> > > 
> > > 'crashkernel' overrides the high and low while the latter two can be
> > > passed independently.
> > 
> >         crashkernel=,high can be passed independently, then a crashkernel=,low
> >         is needed implicitly. If people don't want crashkernel=,low
> >         explicitly, crashkernel=0,low need be specified.
> 
> I find this complicating the interface. I don't know the background to
> the x86 implementation but we diverge already on arm64 since we talk
> about ZONE_DMA rather than 4G limit (though for most platforms these
> would be the same).
> 
> I guess we could restate the difference between crashkernel= and
> crashkernel=,high as the hint to go for allocation above ZONE_DMA first.

Yes, rethinking about this, we can make a straightforward and simpler
crashkernel=,high|,low on arm64, namely asking for user to clearly
specify them.

During maintenance of crashkernel= parameter in our distros, we found
crashkernel=xM is used mostly since most of systems can be satisfied
with 256M or a little more for kdump. While on some big end servers,
1G or more crashkernel memory is needed. In this case, crashkernel=,high
is taken. We don't want to reserve so much low memory during system
running while just waiting in case rare crash happened. crashkernel=,high
is rarely used, so making it simple and not so flexible is not so bad.
We can improve it later with justification.

> 
> >         An independent crashkernel=,low makes no sense. Crashkernel=,low
> >         should be paird with crashkernel=,high.
> 
> You could argue that crashkernel=,low gives the current crashkernel=
> behaviour, i.e. either all within ZONE_DMA or fail to allocate. So it
> may have some value on its own.

Yes, crashkernel=,low has the same behaviour as the current crashkernel=
if we decide not to add fallback mechanism to it. The purpose of
crahskernel=,low is to assist crashkernel=,high to get kdump kernel
boot up with satisfing DMA allocation. While allowing independent
crashkernel=,low will add it another mission, limiting crashkernel only
reserved in low memory. Up to now, we don't see the need for that.

> 
> >         My personal opinion according to the existed senmantics on x86.
> >         Otherwise, the guidance of crashkernel= |,high|,low reservation
> >         will be complicated to write.
> 
> It's more that I find the current semantics unnecessarily confusing. But
> even reading the x86_64 text it's not that clear. For example the
> default low allocation for crashkernel= and crashkernel=,high is only
> mentioned in the crashkernel=,low description.

Yeah, we can improve those document if insufficiency is found.

By the way, with my observation, crashkernel= with fallback meet
99% of our needs. If people really need more than 512M memory or more,
then please consider crashkernel=,high. Basically on servers, low memory
is limited, while high memory is very big.

So I agree with you that we can make it step by step, firstly adding
basic crashkernel=,high and ,low support. We can add those complicated
cases later. 

