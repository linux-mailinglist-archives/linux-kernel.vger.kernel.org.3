Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0561E4664AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbhLBNsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:48:39 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.167]:15950 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbhLBNsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:48:35 -0500
X-KPN-MessageId: 7a702b34-5374-11ec-9a2e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 7a702b34-5374-11ec-9a2e-005056abbe64;
        Thu, 02 Dec 2021 14:33:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:mime-version:date:message-id:from:to:subject;
        bh=K65nEOH5jY8KakqRM0oHkId8wuLz340TVgKfbNaHU6Q=;
        b=UQ34l+CRkUF5uNCpSO0QVN5bl7RUZQt4nzkeoTnyCVv2upFjKnYUUzp+6B1BSeRZAz+Ecl2ObaRf7
         xDg4EJ+ZV8H8XNR98NoWODeuH89wcXPwYr7CLYSch1+q6xpJUIJ+rEgqD0aKUmI/ry5IUgFKYFiJjt
         8q0k7ODF7e9MG3ZJSaZw47xzIueR0WZVF+nzf8FfQjdE+M06+3G96VI7zEqbjMyBHpZJQF5q1/Ob0z
         uJcU9yHK5TwjaVEdnuMt+X+C4ZiHzOsdc21/CXKiMQT28V7jyjzTaLs6PKvS2ZPjhiAhdUAzEUwo7s
         6sF85ekxSMQoPFDlQHkUO3tOhGGcMXg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|uTaTnKRySdqBsDx4+7xy/b8b6SOMtvAgR6ygjWz03ABwWWr06PSA47n1wqs82Bh
 lzXm+q9ICtIhwNPF7IeCliQ==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 87aabd9d-5374-11ec-81f5-005056ab7447;
        Thu, 02 Dec 2021 14:34:10 +0100 (CET)
Subject: Re: [PATCH] media: saa7146: hexium_gemini: Fix a NULL pointer
 dereference in hexium_attach()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130161538.182313-1-zhou1615@umn.edu>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b0f7ee6e-f6fc-955e-92eb-013cd96f1d1d@xs4all.nl>
Date:   Thu, 2 Dec 2021 14:34:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130161538.182313-1-zhou1615@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 17:15, Zhou Qingyang wrote:
> In hexium_attach(dev, info), saa7146_vv_init() is called to allocate
> a new memory for dev->vv_data. saa7146_vv_release() will be called on
> failure of saa7146_register_device(). There is a dereference of
> dev->vv_data in saa7146_vv_release(), which could lead to a NULL
> pointer dereference on failure of saa7146_vv_init().
> 
> Fix this bug by adding a check of saa7146_vv_init().
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with CONFIG_VIDEO_HEXIUM_GEMINI=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/media/pci/saa7146/hexium_gemini.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/saa7146/hexium_gemini.c b/drivers/media/pci/saa7146/hexium_gemini.c
> index 2214c74bbbf1..549b1ddc59b5 100644
> --- a/drivers/media/pci/saa7146/hexium_gemini.c
> +++ b/drivers/media/pci/saa7146/hexium_gemini.c
> @@ -284,7 +284,11 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
>  	hexium_set_input(hexium, 0);
>  	hexium->cur_input = 0;
>  
> -	saa7146_vv_init(dev, &vv_data);
> +	ret = saa7146_vv_init(dev, &vv_data);
> +	if (ret) {
> +		kfree(hexium);

You need to call i2c_del_adapter(&hexium->i2c_adapter); as well.

Also, saa7146_vv_init() needs be fixed since it can return -1: that should
be -ENOMEM. Otherwise a -1 error code could be returned here, that's not
what you want.

Regards,

	Hans

> +		return ret;
> +	}
>  
>  	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
>  	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
> 

