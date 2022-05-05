Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4597851C249
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380596AbiEEOYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiEEOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:24:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9558915A2D;
        Thu,  5 May 2022 07:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6F82B82D81;
        Thu,  5 May 2022 14:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55907C385A4;
        Thu,  5 May 2022 14:20:22 +0000 (UTC)
Date:   Thu, 5 May 2022 15:20:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
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
Message-ID: <YnPdIvOktZBQYLjg@arm.com>
References: <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
 <YmlphvZVMsGfFksp@arm.com>
 <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
 <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
 <3fc41a94-4247-40f3-14e7-f11e3001ec33@huawei.com>
 <YmtaiJhwIgP6m2Sk@MiWiFi-R3L-srv>
 <a9c736a0-f2b3-5b8a-94d9-80742ccd2700@huawei.com>
 <23e2dcf4-4e9a-5298-d5d8-8761b0bbbe21@huawei.com>
 <YnGmCwaWkvCrJoU2@arm.com>
 <YnM9w69l5dbE+k15@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnM9w69l5dbE+k15@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 11:00:19AM +0800, Baoquan He wrote:
> On 05/03/22 at 11:00pm, Catalin Marinas wrote:
> > So, to recap, IIUC you are fine with:
> > 
> > 	crashkernel=Y		- allocate within ZONE_DMA with fallback
> > 				  above with a default in ZONE_DMA (like
> > 				  x86, 256M or swiotlb size)
> 
>         Ack to this one.
> 
> 
> > 	crashkernel=Y,high	- allocate from above ZONE_DMA
> 
>         Not exactly. If there's only ZONE_DMA, crashkernel,high will
>         be reserved in ZONE_DMA, and crashkernel,low will be ignored.
>         Other than this, ack.

Yes, that's fine.

> > 	crashkernel=Y,low	- allocate within ZONE_DMA
> 
>         Ack to this one.
> > 
> > 'crashkernel' overrides the high and low while the latter two can be
> > passed independently.
> 
>         crashkernel=,high can be passed independently, then a crashkernel=,low
>         is needed implicitly. If people don't want crashkernel=,low
>         explicitly, crashkernel=0,low need be specified.

I find this complicating the interface. I don't know the background to
the x86 implementation but we diverge already on arm64 since we talk
about ZONE_DMA rather than 4G limit (though for most platforms these
would be the same).

I guess we could restate the difference between crashkernel= and
crashkernel=,high as the hint to go for allocation above ZONE_DMA first.

>         An independent crashkernel=,low makes no sense. Crashkernel=,low
>         should be paird with crashkernel=,high.

You could argue that crashkernel=,low gives the current crashkernel=
behaviour, i.e. either all within ZONE_DMA or fail to allocate. So it
may have some value on its own.

>         My personal opinion according to the existed senmantics on x86.
>         Otherwise, the guidance of crashkernel= |,high|,low reservation
>         will be complicated to write.

It's more that I find the current semantics unnecessarily confusing. But
even reading the x86_64 text it's not that clear. For example the
default low allocation for crashkernel= and crashkernel=,high is only
mentioned in the crashkernel=,low description.

-- 
Catalin
