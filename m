Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D34EBD34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiC3JIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbiC3JHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:07:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D1B19B04D;
        Wed, 30 Mar 2022 02:06:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:d:7e3f:91e1:4be5:4001:fd80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A82C61F413F2;
        Wed, 30 Mar 2022 10:06:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648631163;
        bh=RoXU/zRTOsprxcVyL8cesrL4y5J+39EDv2zM0wrojSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsYrTMkvC3ZG5fswH35ZdQ3YJ8wUwCx9HwSKpoVveS1P4plUbJMOOmxfZcOgWvrtq
         y/RvpouQH4alULASbqTjPnjMZO2Tfhkkd/khgWKywZGyTz/owP6fgxrMLvSY+9QE61
         mPuLXz8ItZ5004fOL7E7WB1tcoo8ieQn0m6XQrHw8YEUehwEd4voOlrYqzjf5LYs9u
         wZQmzb36WzWMm/ZKrkr0M0bZT1uQlK+ga0YELbaDNBM8Q++6tdEiE0VbxwrgepElDu
         Y9VgeOSh5yjgwCV2KyPS5zAS0wXDxOhJsDizR1oH4driNsA5WZdMaI6WaNtyxecJpY
         hcHiKcagipUzA==
Date:   Wed, 30 Mar 2022 11:06:00 +0200
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
Message-ID: <20220330090600.blvhjzqnklu6zrnd@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-17-nicolas.dufresne@collabora.com>
 <20220329153933.nrbqhayyivqskrcf@basti-XPS-13-9310>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220329153933.nrbqhayyivqskrcf@basti-XPS-13-9310>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

Also typo in title:
s/Ensure decoded resolution fit coded resolution/
   Ensure decoded resolution fits coded resolution/

Greetings,
Sebastian

On 29.03.2022 17:39, Sebastian Fricke wrote:
>Hey Nicolas,
>
>On 28.03.2022 15:59, Nicolas Dufresne wrote:
>>From: Jonas Karlman <jonas@kwiboo.se>
>>
>>Ensure decoded CAPTURE buffer resolution is larger or equal to the coded
>>OPTUPT buffer resolution.
>
>s/OPTUPT/OUTPUT/
>
>>
>>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>
>>---
>>drivers/staging/media/rkvdec/rkvdec.c | 2 ++
>>1 file changed, 2 insertions(+)
>>
>>diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>>index 05824f1997f7..22c0382c579e 100644
>>--- a/drivers/staging/media/rkvdec/rkvdec.c
>>+++ b/drivers/staging/media/rkvdec/rkvdec.c
>>@@ -269,6 +269,8 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
>>		pix_mp->pixelformat = coded_desc->decoded_fmts[0];
>>
>>	/* Always apply the frmsize constraint of the coded end. */
>
>s/frmsize/framesize/
>s/constraint/constraints/
>s/coded end/coded format/
>
>Greetings,
>Sebastian
>
>>+	pix_mp->width = max(pix_mp->width, ctx->coded_fmt.fmt.pix_mp.width);
>>+	pix_mp->height = max(pix_mp->height, ctx->coded_fmt.fmt.pix_mp.height);
>>	v4l2_apply_frmsize_constraints(&pix_mp->width,
>>				       &pix_mp->height,
>>				       &coded_desc->frmsize);
>>-- 
>>2.34.1
>>
