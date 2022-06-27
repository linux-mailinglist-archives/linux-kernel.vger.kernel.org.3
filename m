Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5989F55D548
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbiF0RCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiF0RCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:02:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8818012090;
        Mon, 27 Jun 2022 10:02:15 -0700 (PDT)
Received: from localhost (dynamic-089-204-138-228.89.204.138.pool.telefonica.de [89.204.138.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB3C2660183A;
        Mon, 27 Jun 2022 18:02:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656349334;
        bh=lmMRYe9MYXA/f4BfougC9rcemP8crZR1k5ozH3BKTsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrIv0Of54xYP/F6Lmdygevr0DNJxqqdMGjuOoycrAVM4p2vji5LX0+iwWr7j1my6P
         HXgRzlDBkQrO4YV4KLIoHAUvRcC6sFJIGw+xi40idr69trcjlJ/gNClS+mfl0XYUvj
         EY8gmOtO2zf8L8XjlHgne6qeQNHEY0CXAJItMQnc6mNaKysudGgHsI223nsu6Sn8zu
         FLXghAHJ2xekiRNxlO8DRreHyipNsA8eU1iedH/OLKXAdB7949gBd6Eo2gx5fy/f93
         0y+j7o8iI8gu5fqgyH4uDClc5QvQjCItbEpSgE0NDhljQiNgLoqQRChbxIonqS5lbX
         Qd1WG1Q5e+KoQ==
Date:   Mon, 27 Jun 2022 19:02:09 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel@collabora.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: Fix incorrect P010 chroma order description
Message-ID: <20220627170209.hzf3ezujtrm2ahau@basti-XPS-13-9310>
References: <20220627071224.16787-1-sebastian.fricke@collabora.com>
 <YrltXpTYqMZK/AZV@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YrltXpTYqMZK/AZV@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Laurent,

On 27.06.2022 11:42, Laurent Pinchart wrote:
>Hi Sebastian,
>
>Thank you for the patch.
>
>On Mon, Jun 27, 2022 at 09:12:23AM +0200, Sebastian Fricke wrote:
>> The chroma order of P010 is `CbCr`,
>> match with the descriptions in `include/uapi/linux/videodev2.h` and the
>> documentation.
>>
>> Fixes: 5374d8fb75f31 Add P010 video format
>
>This should be
>
>Fixes: 5374d8fb75f3 ("media: Add P010 video format")

I assume this can probably be fixed while merging it right? So, I don't
have to resend it.

>
>I recommend adding the following to your ~/.gitconfig:
>
>[pretty]
>	fixes = Fixes: %h (\"%s\")
>
>You can then use `git show --pretty=fixes -s` to generate the right
>Fixes: tag. If you fix lots of bugs, an alias in your ~/.bashrc is also
>useful:
>
>gpf() {
>	git show --pretty=fixes -s ${1:-HEAD} | xclip -selection clipboard
>}

Thanks a lot for the advice :).

>
>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>
>Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Greetings,
Sebastian

>
>> ---
>>  drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index e2526701294e..e03362c8aef9 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1306,7 +1306,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
>>  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
>>  	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
>> -	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CrCb 4:2:0"; break;
>> +	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CbCr 4:2:0"; break;
>>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
>>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
>>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
>
>-- 
>Regards,
>
>Laurent Pinchart
