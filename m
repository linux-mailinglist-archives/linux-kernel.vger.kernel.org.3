Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AED4EB0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbiC2Pl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiC2PlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:41:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E70C11DD31;
        Tue, 29 Mar 2022 08:39:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 998CA1F44125;
        Tue, 29 Mar 2022 16:39:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648568376;
        bh=RmMYegltDNam5mXaZuwSibKGEKbYr+OvryeCrWUQldI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX1M4W77IDWQE4xDV2ibg1R5STraO8nHmsbBMjWiMmMrFz9kTSduuOp04EA3bc6X8
         ErS+VODG0CrL9iVnIcs3VYgBHd878GxiiegO229PcRp8mt4IbCtV+DWBS2g2rUvGxQ
         A5Jw4EzM+PUhzNuXG90Y93f1XHbp0L/AXnsliak2SwYl09LEjZ8HN4F4UUd4b6MSXl
         3IYlMDhAtkENZ4PxzsTo6Z930rCaKqQFed5ILPJoNy8hNCYCi9CUeMXzUeVIGb9AhI
         PTfDl3dt8NNAK2CVl18fR0AoDu6OoqwHdDpeWACoyvMxZNucIci6U9XFaiK4w2mJgm
         wqm6UMb84FCJg==
Date:   Tue, 29 Mar 2022 17:39:33 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 16/24] media: rkvdec: Ensure decoded resolution fit
 coded resolution
Message-ID: <20220329153933.nrbqhayyivqskrcf@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-17-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-17-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>From: Jonas Karlman <jonas@kwiboo.se>
>
>Ensure decoded CAPTURE buffer resolution is larger or equal to the coded
>OPTUPT buffer resolution.

s/OPTUPT/OUTPUT/

>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/staging/media/rkvdec/rkvdec.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>index 05824f1997f7..22c0382c579e 100644
>--- a/drivers/staging/media/rkvdec/rkvdec.c
>+++ b/drivers/staging/media/rkvdec/rkvdec.c
>@@ -269,6 +269,8 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
> 		pix_mp->pixelformat = coded_desc->decoded_fmts[0];
>
> 	/* Always apply the frmsize constraint of the coded end. */

s/frmsize/framesize/
s/constraint/constraints/
s/coded end/coded format/

Greetings,
Sebastian

>+	pix_mp->width = max(pix_mp->width, ctx->coded_fmt.fmt.pix_mp.width);
>+	pix_mp->height = max(pix_mp->height, ctx->coded_fmt.fmt.pix_mp.height);
> 	v4l2_apply_frmsize_constraints(&pix_mp->width,
> 				       &pix_mp->height,
> 				       &coded_desc->frmsize);
>-- 
>2.34.1
>
