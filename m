Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397CE521EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbiEJPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbiEJPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:34:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E713C4A0;
        Tue, 10 May 2022 08:28:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ch13so5270373ejb.12;
        Tue, 10 May 2022 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zv1s67X9++8u97ESUQcgdq1IJV6kWayIC8vZbznek8=;
        b=kGqF4R8QIb+Tb8QtT2f7AXe6DA8WGWw7EItVn9hGxoOBIj/WSUwlDw2bU8IakvPWgj
         g8ICmZ6J7rZdkKVjWH1IDi+TM6Zu+Gs05/aCcN2VV7LXPnrKkOckvbSZ6F7UVkOf0Tut
         RVNKDL40zMPKEA8XE0W23M/CA7QiSjtFaUCTUPxEte8BnMqS0wuxOFaKyk28u+XIMO7/
         1e02z97WblFf5HnsTMh+ZI0kyr34WCGzunchTq0HvhQRQaoeJurXhMFC4h4/OTo73MRo
         3BNQ6W8P98mwu8vzj4XEss0Ag8y8vNMSRPLmvLxspm0kiTidJd6PyLYzVYn8kjVANMxS
         JTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zv1s67X9++8u97ESUQcgdq1IJV6kWayIC8vZbznek8=;
        b=Caf4wkRsevw79wbdKrUlKKZIWprhmH64l5eGgF+tKrM2QQ23+JCyV/dNoWa2wPz6rS
         Xd1gvLxJtCx3caXbV0WBM/kPEgSEgscV/oi6LVWh4YAWx4Q25/qLpuxa1urSfEcPyUmR
         jTtpzVp5yTU+L1HZRaXvF5Cf4dKRc9lxv6l2OZixprVGCMS1YRppOSEF8Dc2nRCk8ddK
         tSae3RWa76FvG9kce8s1qDxka+V7WFE8Rpr/k5AmnHPRYT2D+JeHoyvrX0KBqOPCmttX
         upPPWF5aiycN74MbodCDO/rCs4dryJQ/wFU3oenCUc292d73QGsW2MHTh78fbvXpPkZd
         vWgg==
X-Gm-Message-State: AOAM531htgXrScKBFv0pZjui2BqpkRfnnoZy2eiLaTbcBKTBPbfG4Clo
        m1QWZt811Jr4ma6GxJF3zjc=
X-Google-Smtp-Source: ABdhPJxmNDJe474WdhkT9WP72Kr9bcEIaAR/BSjdBWmPGyKOYX4UXD6a53d2l4dd0EvpnlL9vM2HCQ==
X-Received: by 2002:a17:907:7810:b0:6e7:ef73:8326 with SMTP id la16-20020a170907781000b006e7ef738326mr19706751ejc.429.1652196524386;
        Tue, 10 May 2022 08:28:44 -0700 (PDT)
Received: from archbook.localnet (ict-networks-195-176-112-189.fwd-v4.ethz.ch. [195.176.112.189])
        by smtp.gmail.com with ESMTPSA id w26-20020a50fa9a000000b0041d893ed437sm7746703edr.2.2022.05.10.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:28:43 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add Hantro encoder node to rk356x
Date:   Tue, 10 May 2022 17:27:08 +0200
Message-ID: <1959188.DQhRDO7MrQ@archbook>
In-Reply-To: <CAAEAJfC5aoFmk7hKZ-CSv1=RhzO8YU38Abz8PhD26MvV+X0r-Q@mail.gmail.com>
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com> <20220508202544.501981-4-frattaroli.nicolas@gmail.com> <CAAEAJfC5aoFmk7hKZ-CSv1=RhzO8YU38Abz8PhD26MvV+X0r-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Montag, 9. Mai 2022 16:17:03 CEST Ezequiel Garcia wrote:
> Hi Nicolas,
> 
> On Sun, May 8, 2022 at 5:26 PM Nicolas Frattaroli
> <frattaroli.nicolas@gmail.com> wrote:
> >
> > The RK3566 and RK3568 come with a dedicated Hantro instance solely for
> > encoding. This patch adds a node for this to the device tree, along with
> > a node for its MMU.
> >
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > index 7cdef800cb3c..2e3c9e1887e3 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -508,6 +508,27 @@ gpu: gpu@fde60000 {
> >                 status = "disabled";
> >         };
> >
> > +       vepu: video-codec@fdee0000 {
> > +               compatible = "rockchip,rk3568-vepu";
> > +               reg = <0x0 0xfdee0000 0x0 0x800>;
> > +               interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > +               interrupt-names = "vepu";
> 
> It this block "encoder only" and if so, maybe we should remove the
> "interrupt-names" [1]?
> 
> The driver is able to handle it. See:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/hantro/hantro_drv.c#L962
> 
> You might have to adjust the dt-bindings for this.
> 
> [1] https://lore.kernel.org/linux-media/20210324151715.GA3070006@robh.at.kernel.org/

What the Linux driver can handle should not matter to the device tree;
device trees are independent of drivers and kernels.

What does matter though is to be consistent in the bindings.
interrupt-names is a required property even if there's only a vdpu
interrupt. I modelled my vepu-only binding after this case.

If robh thinks there is no value to having the interrupt show up
as anything other than "default" in /proc/interrupts, then I respectfully
disagree with that opinion and point out that this should have been brought
up when the vdpu-only case in the bindings was made to require
interrupt-names also.

Changing the binding now that there theoretically could be drivers out
in the wild (though I doubt it) that do require interrupt-names, because
the binding told them that this is okay to do, seems unwise to me.

Regards,
Nicolas Frattaroli

> 
> Thanks,
> Ezequiel
> 
> > +               clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> > +               clock-names = "aclk", "hclk";
> > +               iommus = <&vepu_mmu>;
> > +               power-domains = <&power RK3568_PD_RGA>;
> > +       };
> > +
> > +       vepu_mmu: iommu@fdee0800 {
> > +               compatible = "rockchip,rk3568-iommu";
> > +               reg = <0x0 0xfdee0800 0x0 0x40>;
> > +               interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> > +               clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> > +               clock-names = "aclk", "iface";
> > +               power-domains = <&power RK3568_PD_RGA>;
> > +               #iommu-cells = <0>;
> > +       };
> > +
> >         sdmmc2: mmc@fe000000 {
> >                 compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
> >                 reg = <0x0 0xfe000000 0x0 0x4000>;
> > --
> > 2.36.0
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 




