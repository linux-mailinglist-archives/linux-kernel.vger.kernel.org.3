Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA859DFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357640AbiHWLie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357971AbiHWLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:32:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4CC760F4;
        Tue, 23 Aug 2022 02:26:21 -0700 (PDT)
X-UUID: 9ae1a94b30e04a288145f9bc64f03866-20220823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/TbxRyzdztn1NiJp5R3HW5/9g2+zp5DPvsdzpL6ZGWw=;
        b=UWQ861MW8eG1JE2iMpavk3CeEF1HT7lm6Y4YVx1ZrRPSTXWQxvhXlfqFejKfFjeMb2GjyRiLAx1UTPi/vmOXHQkNYCpNBe8VJQMd0MvD+jo/6Jfu2ahI97QiKOjinEQsLs8OCldY4FOtKB7/xbCWzqIIXxEhaSEz3aCVMOhbUY8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:503480c3-383d-4958-9c17-0626e565c039,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:036958cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
        l,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9ae1a94b30e04a288145f9bc64f03866-20220823
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1248388900; Tue, 23 Aug 2022 17:26:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 23 Aug 2022 17:26:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 23 Aug 2022 17:26:15 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <xinlei.lee@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH,2/2] pwm: mtk-disp: Fix the parameters calculated by the enabled flag of disp_pwm.
Date:   Tue, 23 Aug 2022 17:26:15 +0800
Message-ID: <20220823092615.1765-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1661239875-19841-3-git-send-email-xinlei.lee@mediatek.com>
References: <1661239875-19841-3-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the original mtk_disp_pwm_get_state() function, the result of reading
> con0 & BIT(0) is enabled as disp_pwm. 
> In order to conform to the register table, we should use the disp_pwm 
> base address as the enabled judgment.
> 
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index c605013e4114..50425cd1de61 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -197,7 +197,7 @@ static void mtk_disp_pwm_get_state(struct pwm_chip *chip,
>  	rate = clk_get_rate(mdp->clk_main);
>  	con0 = readl(mdp->base + mdp->data->con0);
>  	con1 = readl(mdp->base + mdp->data->con1);
> -	state->enabled = !!(con0 & BIT(0));
> +	state->enabled = !!(readl(mdp->base) & BIT(0));
>  	clk_div = FIELD_GET(PWM_CLKDIV_MASK, con0);
>  	period = FIELD_GET(PWM_PERIOD_MASK, con1);
>  	/*

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

