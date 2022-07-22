Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F083D57DA13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiGVGMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiGVGMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:12:18 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE6F97D5C;
        Thu, 21 Jul 2022 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1658470333; x=1690006333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMcCnSZM+y1jlDzl1FwCGWuLfQVVt2IbZhCmVaEgGe4=;
  b=NKsV0GId/eU+oQGGGfs4PKbzwKBATRnrBVg+7rfGMh0AyVcYB25zvA70
   4UbOOOO3QEOoqUZArVkd3yTFknzER+IEDkvLvVe7xNhnuLBG8wEDJ46BK
   3ik38+q/n/725KqEKqRaA7xfmCuMeGfJKjoHp1NjwpywKZyqaxBDOV1YA
   Kgyc/rF3wrlM9bMUSCmY8O+zOuqF48MONAW4p/0A8NEx6+yuXT7ruiyoq
   2Jw4lah+RLbKiIGlN8rIeDaGMg2hSeE+xp5Caq0iomCQBaWxFxxBhUS3M
   UfTLWBllvxIUYrmzeJsQ4lKvXoKR456SroYoYTmTS+NpaXWDY5/9alcZM
   g==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654552800"; 
   d="scan'208";a="25198961"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Jul 2022 08:12:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 22 Jul 2022 08:12:11 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 22 Jul 2022 08:12:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1658470331; x=1690006331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMcCnSZM+y1jlDzl1FwCGWuLfQVVt2IbZhCmVaEgGe4=;
  b=eRkN1wT7GhJwb6+zYT4XQyYRdK98UEvR2DyqJD7P0CqItrGR7FEnKINE
   VFpsK52Eg/E39o13bmI4/A4jHIr78JZ1PG5RtptmIkjE5hbmQ657cHo0n
   k/fLo+o+DTEUOmc37BK/UGMRfckUGS8PJfmza2WBYzumCPTP/BxLJ5JPd
   axHh4vgMbC744jobci6H7oLlm/hVEfCGyH63DW1eoLjjCZERKSyTqZSQ2
   wdyNF1vHKv4Zf82S0Kyw5z6YqhYFuCIFyZWOjnfv7YXi0dkm+J6mgmg8c
   iDEY4LQK5+ZfllwpCSq7ET8FmKpT4uJmLeLeNa6it55yIdVTNu1EIzCrF
   A==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654552800"; 
   d="scan'208";a="25198960"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Jul 2022 08:12:11 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C2E98280056;
        Fri, 22 Jul 2022 08:12:10 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [PATCH v1 02/12] ARM: dts: imx6qdl-mba6: don't use multiple blank lines
Date:   Fri, 22 Jul 2022 08:12:08 +0200
Message-ID: <3535348.8hb0ThOEGa@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220721195936.1082422-3-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com> <20220721195936.1082422-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Am Donnerstag, 21. Juli 2022, 21:59:25 CEST schrieb Marcel Ziswiler:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Avoid the following checkpatch warning:
> 
> arch/arm/boot/dts/imx6qdl-mba6.dtsi:247: check: Please don't use
>  multiple blank lines
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  arch/arm/boot/dts/imx6qdl-mba6.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-mba6.dtsi
> b/arch/arm/boot/dts/imx6qdl-mba6.dtsi index f4dca20669d6..78555a618851
> 100644
> --- a/arch/arm/boot/dts/imx6qdl-mba6.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
> @@ -244,7 +244,6 @@ &uart2 {
>  	status = "okay";
>  };
> 
> -
>  &uart3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart3>;

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>



