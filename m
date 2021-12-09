Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5046E7E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhLIMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:02:22 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.170]:64615 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhLIMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:02:21 -0500
X-KPN-MessageId: 3e3a5016-58e7-11ec-8a6e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 3e3a5016-58e7-11ec-8a6e-005056ab378f;
        Thu, 09 Dec 2021 12:57:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=9Aq23Wv7tHnCYMpmE5PBJb/8V6Y6YS0/22bQYvWZfms=;
        b=h6WH+9bq26ytYVkLgO+BBRA9djM7TpYc/rglyUJnk7c9magrntvpC9H2y74mkOpN5KvEeVBoTkN+U
         KXLTJ/wW66zpcBt0uaGD2QBZfzeiFS2HBZiy+wQhayLPkx/6OBxrBoaw1yE+tNn1eqoSBYFGpmZjgs
         2bXz04YcB+tV+V9ISpUlymC4Da7OKpIH5BkXw2uFKRUSdPLo8l+D2jp2YNTTjFrjDoj04XIN8qx/Cr
         croH5uYLmc+v1KIk0yTkiGoWWliYK+pdfIW+jC2RFVB4dRaOR59m0eBGr9yfJ2YlHFKOtorRzRu6A3
         ap8U0SM0g8LomM6O4B3VwETxZ1xjNKQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|DDmaztRJmOtayoxqgJybbogxaHcYGuAH/2JQ1k//iXKfxwhLEuAMhU/xDzQBJLy
 fS7hu1KsqPsf0t5psDYTCSA==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 5ce29b6c-58e7-11ec-83ab-005056ab1411;
        Thu, 09 Dec 2021 12:58:46 +0100 (CET)
Message-ID: <bfd1801c-9d1e-0574-a237-711d3d5ae755@xs4all.nl>
Date:   Thu, 9 Dec 2021 12:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH] media: meson: vdec: potential dereference of null pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, narmstrong@baylibre.com,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211209085840.2081024-1-jiasheng@iscas.ac.cn>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211209085840.2081024-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 09:58, Jiasheng Jiang wrote:
> he return value of kzalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.
> 
> Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/staging/media/meson/vdec/vdec_helpers.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
> index 7f07a9175815..025885fcfec6 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
> @@ -234,6 +234,8 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>  	unsigned long flags;
>  
>  	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
> +	if (!new_ts)
> +		return;

While this avoids dereferencing a NULL pointer, this error isn't propagated to the
caller. And I'm not sure if that's right.

Neil, what should be done in this case?

Regards,

	Hans

>  	new_ts->ts = ts;
>  	new_ts->tc = tc;
>  	new_ts->offset = offset;
> 

