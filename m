Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FC655057A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiFROTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiFROSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 10:18:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A62DF19;
        Sat, 18 Jun 2022 07:18:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f65so6396013pgc.7;
        Sat, 18 Jun 2022 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QiBFbh7JSAwKD6sJ1nf5U4eu547oJ+ADx+EKgoymxCI=;
        b=ViprWoK4uqnklWzTQk+fvnLaUqne0Zd90H9MixB7tRue3RXJ8Lq9n5syAfKrS3dKEA
         HT9z787Xt3UAxhy1S57GgN8644M/bc8r4HbbCn0alGy0UzCj3DFJA1T/Ib9R/pOANPpD
         JEsZ9EU88xvA6ikZqDoFXIXdh9FSFoCuW2IvlKMA3sH/8/OtpizRHSwwmGCZD40FJel+
         yPC0/gi37K8AK2vvZ9a4XDCnlRfqukBCue2IC14lDDNquYrNeKvjLkY6IeQ6lZRcNUCn
         kBjUOoESkgxJ2s2k7cHQTPgYxvOaK1XAtlHrK415aY/0iBlK8oX853OJJXj/Judkpbfd
         yk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QiBFbh7JSAwKD6sJ1nf5U4eu547oJ+ADx+EKgoymxCI=;
        b=VRHAsyu8zMJ0vr1+F+smH2ZCaiiSFd6siwTQrapNIA9cXkqAAORULsYyveg1FHvcew
         RTkW/kYftnheI/u1OU4wH7RLJBvyVWUdOZ9ykCjRZzr5m8fH9NEfscvA8BvxbpFNhmzY
         oCkIkpiwZgRpwySWM/uW29X5Y6HFnAvpuM1EhIqOToWiE1CuJ9t/MCFrDmU0XQ+mDHgt
         hjqLHmqlqCD89ppCMRTDVjOz0AoaP8BUED5bGzjXJ8avffsMdQfp7Mfe/COtla/cKHSj
         J+R0Xf1NWaNGoaEZCERgOOvYXKlu/6kjWfYN3JvlTo6u2d7k1VwPVZCqiOviXlaz60sY
         wQCQ==
X-Gm-Message-State: AJIora+2v3Mn2xnnHCedznRn9kqC4neNwKLrdZrqOF0CRwxndssRacOi
        AeDQ984hWP0m6Yv4Wq5riZE=
X-Google-Smtp-Source: AGRyM1u2mGmi1JJfkT6ExmYQ2dFty+U+or8nDWjHbWZLfPVYWKM8Lx0xSixycdUe6IskWv1L1zV22Q==
X-Received: by 2002:a05:6a00:7d3:b0:51e:740f:8d10 with SMTP id n19-20020a056a0007d300b0051e740f8d10mr15348069pfu.4.1655561887511;
        Sat, 18 Jun 2022 07:18:07 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902650900b00168ba5ac8adsm5425678plk.163.2022.06.18.07.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 07:18:07 -0700 (PDT)
Message-ID: <7bffaa3c-dda8-44f5-8190-9fb5142925bc@gmail.com>
Date:   Sat, 18 Jun 2022 23:18:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] devfreq: exynos-ppmu: Fix refcount leak in
 of_get_devfreq_events
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220526082856.37594-1-linmq006@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220526082856.37594-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 5. 26. 17:28, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> This function only calls of_node_put() in normal path,
> missing it in error paths.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 9b849d781116..a443e7c42daf 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -519,15 +519,19 @@ static int of_get_devfreq_events(struct device_node *np,
>  
>  	count = of_get_child_count(events_np);
>  	desc = devm_kcalloc(dev, count, sizeof(*desc), GFP_KERNEL);
> -	if (!desc)
> +	if (!desc) {
> +		of_node_put(events_np);
>  		return -ENOMEM;
> +	}
>  	info->num_events = count;
>  
>  	of_id = of_match_device(exynos_ppmu_id_match, dev);
>  	if (of_id)
>  		info->ppmu_type = (enum exynos_ppmu_type)of_id->data;
> -	else
> +	else {
> +		of_node_put(events_np);
>  		return -EINVAL;
> +	}
>  
>  	j = 0;
>  	for_each_child_of_node(events_np, node) {

I edited the patch title with 'PM / ' prefix 
in order to keep the consistent style of title as following:

PM / devfreq: exynos-ppmu: Fix refcount leak in of_get_devfreq_events


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
