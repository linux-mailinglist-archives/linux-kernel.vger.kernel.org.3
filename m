Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7D4EBF82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbiC3LFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiC3LFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:05:35 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D16151
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=BMy5MpLHZ2eMrjRM9df3zSOhU3qkqVEIGDXRzBANghc=;
        b=XBmKv2nW3trthDQKLf382mrokcjes4sje8ugGFHNjU4gZ1LMrIF4weACqqnW4uzK03HdU8uyMjor5
         XOofRYLj0o1aXlqJKUCYl/rVjEyyVHJzslsXD/zha9wdCjveH+MfiMzRcNySySYJzw6srr/xawqZFV
         wPlx9qXuc//wrIot7RApk45blI+S71BdJsA0LlDIVL4a/uGSAVyroer+qRrsUYktdDj5G9mmif0v/4
         iblF7KDuSv4oNUmcOr9tqcHjZn25UH3fhDQ3hOg5gfkc9nVRjz+EAUY088yXfbPdxGOuz3Xbf0ys7F
         /5Zb0lkxbHgwyVKmKHs084js04bij8A==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000008,0.005704)], BW: [Enabled, t: (0.000017,0.000001)], RTDA: [Enabled, t: (0.083100), Hit: No, Details: v2.31.0; Id: 15.52k0as.1fvd7s32n.dt73; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 30 Mar 2022 14:02:45 +0300
Date:   Wed, 30 Mar 2022 14:02:29 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: fix pdev is NULL but dereferenced
Message-ID: <20220330110229.xczp74pd6o4xvfws@h-e2.ddg>
References: <1648635500-12631-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1648635500-12631-1-git-send-email-baihaowen@meizu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Mar 30, 2022 at 06:18:20PM +0800, Haowen Bai wrote:
> pdev is NULL，so we can't dereference it dev_err(&pdev->dev
> 
> Fixes: e6cb540 ("bus: imx-weim: add DT overlay support for WEIM bus")
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/bus/imx-weim.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 60fbd42..31a2213 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -352,9 +352,8 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>  
>  		pdev = of_find_device_by_node(rd->dn);
>  		if (!pdev) {
> -			dev_err(&pdev->dev,
> -				"Could not find platform device for '%pOF'\n",
> -				rd->dn);
> +			pr_err("%s: Could not find platform device for '%pOF'\n",
> +				__func__, rd->dn);
>  
>  			ret = notifier_from_errno(-EINVAL);
>  		} else {
> -- 
> 2.7.4
> 

This is a solid bug, but there is a fix already.

  https://lore.kernel.org/all/20220223035146.412499-1-wanjiabing@vivo.com/

For some reason it was not applied yet.

