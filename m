Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138594BCEA4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbiBTNbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:31:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbiBTNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:30:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DECF53723
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:30:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9D82B80D43
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444CAC340F3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645363836;
        bh=lVGKars3UOdCl//7LKU/BqgNXSAU0gBEYzedjFnc06Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p1FZaPFpCzGhzlml2yffcvVvW5md9R6P9sD1R4oMM0wySnjgbxYdRcPrukKSg8ZcW
         C49yptSWfSmmzpmGsUz8CCXcg1l+yQ78O9PM91U/e/Zi3D6pZEn8lO8LVFFmVnkcPS
         wXDrvnpO6l17acvca5UF8iWZl7J8JVwvPxhfs4Ib0LjBBVyZn38/n92ZQ2tDDeMe2P
         zKMqQmKwZtmtL/J7YlkuNb3gwfIMbglg7GMT5ttJmqESFNw4u70WHH7VhapxLL4SjQ
         6I+6YnJU7uNy8RexusWyontBAPBtkcIp0LnvFezNPms9sPecvffynXCADjdhXRWqZp
         6/tt5p2GsTQzA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2d07ae0b1c4so111498197b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:30:36 -0800 (PST)
X-Gm-Message-State: AOAM532gFjgiH8j0u1cUsdIpclPaKgTeJdFDcCEZdpBgsrAIqKE4jT8L
        OPyQ5U2BQGzOwIzhjw4Lw83Wi5H3RX5s0I5SeeY=
X-Google-Smtp-Source: ABdhPJxFgCo4AReAx7FF8ks6HOjKAtTmnOTCixdLdoUBR8NYwvVe4K0WLYmokx9kwZhRga3/wg18OHXG+qR8iaPwIZA=
X-Received: by 2002:a81:84d5:0:b0:2d1:e85:bf04 with SMTP id
 u204-20020a8184d5000000b002d10e85bf04mr15790221ywf.465.1645363835400; Sun, 20
 Feb 2022 05:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20220218215549.4274-1-song.bao.hua@hisilicon.com> <6432e7e97b828d887da8794c150161c4@kernel.org>
In-Reply-To: <6432e7e97b828d887da8794c150161c4@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 20 Feb 2022 14:30:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF14uEM=eTsqKR8MBWYS_yebMQF5kca86gGyuXkjs+GRg@mail.gmail.com>
Message-ID: <CAMj1kXF14uEM=eTsqKR8MBWYS_yebMQF5kca86gGyuXkjs+GRg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp
 before issuing ipi
To:     Marc Zyngier <maz@kernel.org>
Cc:     Barry Song <21cnbao@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2022 at 10:57, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-02-18 21:55, Barry Song wrote:
> > dsb(ishst) should be enough here as we only need to guarantee the
> > visibility of data to other CPUs in smp inner domain before we
> > send the ipi.
> >
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c
> > b/drivers/irqchip/irq-gic-v3.c
> > index 5e935d97207d..0efe1a9a9f3b 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data
> > *d, const struct cpumask *mask)
> >        * Ensure that stores to Normal memory are visible to the
> >        * other CPUs before issuing the IPI.
> >        */
> > -     wmb();
> > +     dsb(ishst);
> >
> >       for_each_cpu(cpu, mask) {
> >               u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
>
> I'm not opposed to that change, but I'm pretty curious whether this
> makes
> any visible difference in practice. Could you measure the effect of this
> change
> for any sort of IPI heavy workload?
>

Does this have to be a DSB ?
