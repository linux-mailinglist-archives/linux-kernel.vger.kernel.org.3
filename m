Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B205A4AEE69
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiBIJtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiBIJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:49:37 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEBFE01A2E8;
        Wed,  9 Feb 2022 01:49:27 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee30.dynamic.kabel-deutschland.de [95.90.238.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D9D6561EA1923;
        Wed,  9 Feb 2022 10:06:28 +0100 (CET)
Message-ID: <f790f9aa-fcb7-d163-9c1c-9eb107d4b1bd@molgen.mpg.de>
Date:   Wed, 9 Feb 2022 10:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] media: aspeed: Use full swing as JFIF to fix incorrect
 color
Content-Language: en-US
To:     Jammy Huang <jammy_huang@aspeedtech.com>
References: <20220209084225.4456-1-jammy_huang@aspeedtech.com>
Cc:     eajames@linux.ibm.com, mchehab@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220209084225.4456-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jammy,


Am 09.02.22 um 09:42 schrieb Jammy Huang:
> Current settings for video capture rgb-2-yuv is BT.601(studio swing),
> but JFIF uses BT.601(full swing) to deocde. This mismatch will lead
> to incorrect color. For example, input RGB value, (0, 0, 255), will
> become (16, 16, 235) after jpg decoded.
> 
> Add an enum, aspeed_video_capture_format, to define VR008[7:6]
> capture format and correct default settings for video capture to fix
> the problem.

Maybe quote the datasheet:

VR008[7:6] will decide the data format for video capture:
00: CCIR601 studio swing compliant YUV format
01: CCIR601 full swing compliant YUV format
10: RGB format
11: Gray color mode

> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
> v2:
>   - update subject from 'media: aspeed: Fix-incorrect-color' to
>     'media: aspeed: Use full swing as JFIF to fix incorrect'
>   - update commit message
>   - add enum, aspeed_video_capture_format, to define VR008[7:6]
> ---
>   drivers/media/platform/aspeed-video.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index eb9c17ac0e14..5bcf60b4628b 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -86,8 +86,6 @@
>   #define  VE_CTRL_SOURCE			BIT(2)
>   #define  VE_CTRL_INT_DE			BIT(4)
>   #define  VE_CTRL_DIRECT_FETCH		BIT(5)
> -#define  VE_CTRL_YUV			BIT(6)
> -#define  VE_CTRL_RGB			BIT(7)
>   #define  VE_CTRL_CAPTURE_FMT		GENMASK(7, 6)
>   #define  VE_CTRL_AUTO_OR_CURSOR		BIT(8)
>   #define  VE_CTRL_CLK_INVERSE		BIT(11)
> @@ -202,6 +200,15 @@ enum {
>   	VIDEO_CLOCKS_ON,
>   };
>   
> +// for VE_CTRL_CAPTURE_FMT
> +enum aspeed_video_capture_format {
> +	VIDEO_CAP_FMT_YUV_STUDIO = 0,

Maybe also append `_SWING`?

> +	VIDEO_CAP_FMT_YUV_FULL,
> +	VIDEO_CAP_FMT_RGB,
> +	VIDEO_CAP_FMT_GRAY,
> +	VIDEO_CAP_FMT_MAX
> +};
> +
>   struct aspeed_video_addr {
>   	unsigned int size;
>   	dma_addr_t dma;
> @@ -1089,7 +1096,8 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
>   	u32 comp_ctrl = VE_COMP_CTRL_RSVD |
>   		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
>   		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
> -	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR;
> +	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR |
> +		FIELD_PREP(VE_CTRL_CAPTURE_FMT, VIDEO_CAP_FMT_YUV_FULL);
>   	u32 seq_ctrl = video->jpeg_mode;
>   
>   	if (video->frame_rate)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
