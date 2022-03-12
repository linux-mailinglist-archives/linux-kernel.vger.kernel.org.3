Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847894D70A6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiCLT7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 14:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCLT72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:59:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3C19F6CE;
        Sat, 12 Mar 2022 11:58:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l20so20607538lfg.12;
        Sat, 12 Mar 2022 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XKl/d0mo7z+8QanaXzNtR7ZkSnHh49IBxZx284NoA9c=;
        b=i7PFwUrFM/0FCz4V5WaUwSmG8F2XqdbJKfN4mDPwRAy+jxtOOG9KXbMY+qqKe9ZgC2
         84nILEWiWM+8UoX44b6TL2RsNXnHE1JhOTTt+JXR8F8au9f7Fg4qG4GoQZRNsYrmiyQh
         hNkWraJElFh9jVkGABwlMW3HdJJIQfljsdOyH29TzPNCsJFpnkBU1rzsfgM0hbqh4Qtd
         BWQBW0yD45z59wDpP8JcYtfV8XEpR6yTaamxr+LaJnPrEzkUKr813OhiWb69RnJQttpX
         AWDxlOyvaj9fZpX4CiR3yZsJPYa2w/ZQ/Z6PpimQOJe2T4LAlID4/+/E/4vBmo+2If8L
         aEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XKl/d0mo7z+8QanaXzNtR7ZkSnHh49IBxZx284NoA9c=;
        b=JeP7X7N0t8sr9b7mSvLpPcIiakJT8PGLwejIb6HycylUBdTFLVBVXZH/+uOvpsdiAJ
         DhgE5jFCNIMZtGqsvnF1PR+n08dVzcrQ5Eitu7XuvDhfWkIGl0BqBZgvYBRoloh7Wn9a
         dUV0oP3ySG2N0P6a/WAgnO8K+217n8OwjwmhnTRljqjfC/aKM389pNOu3K7FUmwhE6zf
         PhaH38yBPhesotQX3b3G+oOsQDmVLImTle8qXB+NcKrhQlpjLwfZmFTS3MlSAvwQn0EX
         0XYbBNkyMXAfS+ADvsc13+zabDaKO/v6H+UVr+Zn7bqgGB2QFzo6kkLd8jZlYBbZi9kn
         E3bA==
X-Gm-Message-State: AOAM532LFnllncFgCDHW/z6kKJCoBE1mC+q7IV3cjsLKAvXZcFCOueRQ
        B4sCxGxdygguZ7p+2SoJAjQ=
X-Google-Smtp-Source: ABdhPJw6zsEpxNadwPPyYVuiG5kuEju3IZ06xTbxP19NlBDB/v7kGj8kxT7Ib0JvNH/r9nKU5aZhVA==
X-Received: by 2002:a05:6512:16a7:b0:445:862e:a1ba with SMTP id bu39-20020a05651216a700b00445862ea1bamr8947033lfb.85.1647115100439;
        Sat, 12 Mar 2022 11:58:20 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id x10-20020a19f60a000000b0044858b2ec41sm2136727lfe.187.2022.03.12.11.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 11:58:19 -0800 (PST)
Message-ID: <65a1d178-8511-a023-2655-94540114086c@gmail.com>
Date:   Sat, 12 Mar 2022 22:58:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: stkwebcam: move stk_camera_read_reg() scratch
 buffer to struct stk_camera
Content-Language: en-US
To:     trix@redhat.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        cai.huoqing@linux.dev, xose.vazquez@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312173049.1410977-1-trix@redhat.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220312173049.1410977-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/22 20:30, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> In stk_camera_read_reg() a single byte buffer is alloc-ed and
> freed on every function call.  Since the size is known,
> move the buffer to the struct stk_camera where it will be alloc-ed
> and freed once.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/media/usb/stkwebcam/stk-webcam.c | 11 ++---------
>   drivers/media/usb/stkwebcam/stk-webcam.h |  2 ++
>   2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/usb/stkwebcam/stk-webcam.c b/drivers/media/usb/stkwebcam/stk-webcam.c
> index 5b822214ccc5c..787edb3d47c23 100644
> --- a/drivers/media/usb/stkwebcam/stk-webcam.c
> +++ b/drivers/media/usb/stkwebcam/stk-webcam.c
> @@ -150,25 +150,18 @@ int stk_camera_write_reg(struct stk_camera *dev, u16 index, u8 value)
>   int stk_camera_read_reg(struct stk_camera *dev, u16 index, u8 *value)

And just random note: there are 4 possible uninit value bugs.

stk_start_stream() calls stk_camera_read_reg 4 times, but ignores return 
values.

stk_camera_read_reg() should have __must_check annotation and return 
value should be checked on each call.


If you have time you can take care of it :) Or I will fix it one day...





With regards,
Pavel Skripkin
