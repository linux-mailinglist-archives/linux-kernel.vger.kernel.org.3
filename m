Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301064EB015
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiC2PSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbiC2PSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:18:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3C524CEEF;
        Tue, 29 Mar 2022 08:17:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 725F61F440E4;
        Tue, 29 Mar 2022 16:17:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648567024;
        bh=LlSCtClpCQ+4yHQfFaHiVQc1oJ1WM6l4guj4ciQuaEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZwlbdCEWJBNkfxfxIorTwE5Zxg7xoUpw9KLGnG4pMrphr0j3rJM/aKTa/8tIRhxD
         e/caKpg6IoA703T5soDthiQI9EsDkD2JoOmC+vZZovPyFKyENyRctovz6qponrWPux
         QuYjlxUyT3zNX2rPY3XKtgTAT5Zo/aHOi/+xR0qP81wi0mN126Z+cATNI3fborJ9g8
         VmaC9j4LAMGBrrGUs51uTeIqNSWLx9azGUMjf4PcplB2qdR69ea4FsDrC/1UqTG+b7
         ajp4qhhEfA29lBZPuYnVy74EqTMGmKOWs7op/g0HSheHjbr9bl9O55FSziZcGI6KGH
         dsfzqeTixEIkg==
Date:   Tue, 29 Mar 2022 17:17:01 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/24] media: rkvdec: h264: Fix reference frame_num
 wrap for second field
Message-ID: <20220329151701.nt3fem5cd2nwmerp@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-14-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-14-nicolas.dufresne@collabora.com>
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
>When decoding the second field in a complementary field pair the second
>field is sharing the same frame_num with the first field.
>
>Currently the frame_num for the first field is wrapped when it matches the
>field being decoded, this cause issues to decode the second field in a
>complementary field pair.
>
>Fix this by using inclusive comparison, less than or equal.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Greetings,
Sebastian

>---
> drivers/staging/media/rkvdec/rkvdec-h264.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>index dff89732ddd0..842d8cd80e90 100644
>--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>@@ -752,7 +752,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> 			continue;
>
> 		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
>-		    dpb[i].frame_num < dec_params->frame_num) {
>+		    dpb[i].frame_num <= dec_params->frame_num) {
> 			p[i] = dpb[i].frame_num;
> 			continue;
> 		}
>-- 
>2.34.1
>
