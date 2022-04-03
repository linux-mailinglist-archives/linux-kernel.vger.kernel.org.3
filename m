Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6134F08FA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356925AbiDCLWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356316AbiDCLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:22:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6703585A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:20:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so12372478lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 04:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/nGCKkYfJckWjtQDHrGmqAfeKE621bI4+5SiFBLzr8w=;
        b=P4yB+NzYokpaQuk5EcyxPKue0k3iutinq/kqDEo62aZP+OHjThk/HpKhqNAbOGAr/f
         f+hybWpSpNr5Y2fAAC/G2HHq2MilW2isdChwE0L4fPwgHCQAvnICccinWrfaUIO2cTVy
         +yrx3m8h0KNMCiuUt9GSaoQS8wPezgYPHnIv53yEbA7DtQ4W+UMOttRY9BJyEvBbLIsm
         3qdvaE45RTuqlCNFhnrMsLwM848MbZoeSyR6kLMu/gnRsBtgJLb9x62rFoahc3RCZcQU
         UdYGQpd97ZzUJmB9RyojxvABjMxboI9fiNMhX4dzxXdlO1IuFET6SikbKz6X+RIB59pM
         hjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/nGCKkYfJckWjtQDHrGmqAfeKE621bI4+5SiFBLzr8w=;
        b=iZVm+EMEnjoI0uRguk5iTE1K5QWg5t4Br7M74G5/plPnbj7Jh0/CbyA/2N9JEMFuwl
         lqCyl5hAYKK0Jyp12PpsQ1qCMBzl01MznUIu2fI+r8ZKo/O+k0PQIkkenKZ0yEfHtWtl
         zJL9lgnZgf6rC5KimSRTrNcFbIHNQoJFGhHTrIikddJ8ah6ImmQz7v60a++AFEV9/WE1
         YaWedXrqjVxYQ8QViL9Q2un3UYKkMhQtXrafL5lipt9CPmVbID0+7ArmB9ErHvOEZywG
         kDlFQbJjCXwcFt1WNybkNiMLa3/EFy0lUPimPr5QlEKt5Bhf7Qkt0Jd8K3GdL1+DBNi2
         2NpA==
X-Gm-Message-State: AOAM5300tChxX01EJ+NXC+e3LkAH9j25VKp7hKeGd7pyQNBJBaRxHDmp
        /kLsR/UWXNn5t47aNKD7VsTKy8785dE=
X-Google-Smtp-Source: ABdhPJwipfILAHh1MtoZP7KcMZajG5mHZyIdWjyutVWgLNiaRtxZUKmxZSlYuPYTkXtaQxv6zJzb7Q==
X-Received: by 2002:a05:6512:3184:b0:44a:78f2:500b with SMTP id i4-20020a056512318400b0044a78f2500bmr19313093lfe.434.1648984810166;
        Sun, 03 Apr 2022 04:20:10 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id i13-20020a2e808d000000b0024b0d63079fsm482238ljg.50.2022.04.03.04.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 04:20:09 -0700 (PDT)
Message-ID: <8652baf2-212a-c843-fb69-f4fd4c216775@gmail.com>
Date:   Sun, 3 Apr 2022 14:20:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: Fix unsafe memory access by memcmp.
Content-Language: en-US
To:     Charlie Sands <sandsch@northvilleschools.net>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Ykdcv6Sm3oDE9IEp@sckzor-linux.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <Ykdcv6Sm3oDE9IEp@sckzor-linux.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charlie,

On 4/1/22 23:12, Charlie Sands wrote:
> This patch fixes sparse warnings about the memcmp function unsafely
> accessing userspace memory without first copying it to kernel space.
> 
> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> ---
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 7df213856d66..1cfac1b27eb7 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -3233,23 +3233,27 @@ static int rtw_p2p_get(struct net_device *dev,
>   			       struct iw_request_info *info,
>   			       union iwreq_data *wrqu, char *extra)
>   {
> -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> +	char wrqu_data_ptr[9];
> +	if (copy_from_user(wrqu_data_ptr, wrqu->data.pointer, 9))
> +		return 0;

-EFAULT is standard return value in case of `copy_{to_from}_user` failure



With regards,
Pavel Skripkin
