Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327A854BE30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbiFNXLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbiFNXLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:11:00 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219F950B2D;
        Tue, 14 Jun 2022 16:11:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d129so9819951pgc.9;
        Tue, 14 Jun 2022 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=aC7SlEgutkK6nNndiLRs1ZU+5bWdOtSnQ080c2sn5Y8=;
        b=DBy7wEr0LniS3ghdD3k7msjkEm9mpmsO2xUumhJoxQrGMpYcJIJoqxYek4CarR7ctt
         0PFbBFm9mN16OSi0lWRR6butRkiFnnya45K83Rd0gSnPDpqanHX5+kLhI1a00WMaaEOw
         VN4OEZ7d+eL+/VXy8VcmyX+YXZppRBU+iDIBrWDsiZBWhlHVNIIvzwLz2ZutREe1EExR
         XBFRczkmxbKI1/dZcumAnRrJJBboeQq8HBUaIo1KKgdyQsg4HPa8LX/0B420EGfWqyVu
         VT8btBbMy9KosyB7Hbrx0Q9iYT4p95gzSOFS4yWy8K9hfLEpMm2R2xRKhMFxnUAStB28
         K3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aC7SlEgutkK6nNndiLRs1ZU+5bWdOtSnQ080c2sn5Y8=;
        b=o1TzmTyLbXGup8yeOu0AZdVSNiroEAr6SdgA2trnUrpocusKYXWEZPz9IFcfaL6iM0
         jak1v7OgvKfqb5hmbvdlWaKljzpzegUwCFVV8alvhR18oYVBSbhZEqqgBI/NbvXF0ehO
         xYaH4zWQxjQSobmDJ5yWTxOPUnjsx1IVPzTKj8JRcggL/tJDiyaZ589fF+jouv+kkwwS
         KO75rz2Jdf4lYeP4Kp6ZcjSAs5CvYtUDCGa1IWmMi7SOPtANiQIoWkVz2c/2SX2N05rU
         ACkU1TZ/zmqHhnwo3oQ0OtxPXMWQTJ1DPsLHLKOvtAYOtPqJc8x1wpfoaZXxCo7za4hu
         FIpA==
X-Gm-Message-State: AOAM531lRNy/bjqxnp/oQIemOdTpVthZIaK49Qf9IXTpoFXuCvgCp78t
        87yDBs37PYgz4uLw4ZcePEM=
X-Google-Smtp-Source: ABdhPJw2cNW+IuDKHR+D/cq1ouqdbZL+qPykU7ffbZGKjHo2c9EZQ1rMw81JdKwP+Q/ndfizhIvcCg==
X-Received: by 2002:a05:6a00:1992:b0:51c:391f:6ff5 with SMTP id d18-20020a056a00199200b0051c391f6ff5mr6913888pfl.16.1655248259612;
        Tue, 14 Jun 2022 16:10:59 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a428700b001e2f383110bsm146822pjg.11.2022.06.14.16.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 16:10:59 -0700 (PDT)
Message-ID: <dd320cfa-18fc-ef82-c25e-2652fd5cafbf@gmail.com>
Date:   Wed, 15 Jun 2022 08:10:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 5/5] PM / devfreq: Mute warning on governor PROBE_DEFER
Content-Language: en-US
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614110701.31240-1-ansuelsmth@gmail.com>
 <20220614110701.31240-6-ansuelsmth@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220614110701.31240-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 14. 20:07, Christian 'Ansuel' Marangi wrote:
> Don't print warning when a governor PROBE_DEFER as it's not a real
> GOV_START fail.
> 
> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2e2b3b414d67..df6972bb0ce8 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -931,8 +931,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
>  						NULL);
>  	if (err) {
> -		dev_err(dev, "%s: Unable to start governor for the device\n",
> -			__func__);
> +		dev_err_probe(dev, -EPROBE_DEFER, "%s: Unable to start governor for the device\n",
> +			      __func__);

Should use 'err' instead of -EPROBE_DEFER and please this line
as following in order to keep the 80 line indentation.

+               dev_err_probe(dev, err,
+                       "%s: Unable to start governor for the device\n",
+                       __func__)



>  		goto err_init;
>  	}
>  	create_sysfs_files(devfreq, devfreq->governor);


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
