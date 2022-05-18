Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A467852BCB3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiEROEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiEROEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26DC36C0EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652882681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ws0UMzpM8W/mwRT/2MvRIoJSGATsEFbYU+2G8jUbvqc=;
        b=UzurEGSwkEbY33ZFGcpDpcWwd76DmfzE03uvV8LtGLzjGpElvO5cZ+Y3GlqEROXGZI3FZB
        IHKz3bh2VeQ2Kg7AeLDq9JlRYSTE/WQUlA9L5Z7lhPr2tUq38Ag06uV02p1E/2Xtv75vSs
        Rae7K8FP2mW4Q2kH5G/BOURQ7ki5HSw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-EyI0l6lJOfGmAZ_y0zFilA-1; Wed, 18 May 2022 10:04:37 -0400
X-MC-Unique: EyI0l6lJOfGmAZ_y0zFilA-1
Received: by mail-qk1-f199.google.com with SMTP id o18-20020a05620a2a1200b006a0cc3d8463so1649636qkp.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ws0UMzpM8W/mwRT/2MvRIoJSGATsEFbYU+2G8jUbvqc=;
        b=M9osEKSoOkSdENcn1OVZfHi1aUYMCN2ozayWpPHBBlcShGBw4UBdirsOQWs3GZb41+
         1jROGNRoyogVH2qJH8Qjrso9WYUILr/u+Slj8J0k214JyB9i13wFGgQ485QScnFHnhKo
         ITcNkZcQUn/ScmW7SB123dLJbBCBw0ZDZIhqAlAQFtGOJhUySiFGIfw5U56kR0tSWhuR
         t3VmB2ob0Z9qWnShu6l1DZQ1/esNf5k2trChxGlFgJrXK3WcNi+dhG1yOQuLi5dkaGn/
         h2mMxZVqrZFJywBLtCxJKPSHRTuPge0Plwg0EriPdkXxPBTCufHbISO+wlpeAyeV7RAz
         6iBQ==
X-Gm-Message-State: AOAM533QO+4sPb+D3Xk6oiNqmK/dB5pfR0aJfH1bg6m6OppVlQOwQhDl
        feM4bayyx83lxOaYW/BrLeN0kry9fsRKr2idFrRp40YLce+XZHzh4Ho5k0OSopBqZH75Ud9anVa
        mWAhLDonIWtCyJ26bM2NUPKyx
X-Received: by 2002:a05:620a:2807:b0:67d:6349:2577 with SMTP id f7-20020a05620a280700b0067d63492577mr19701564qkp.785.1652882677115;
        Wed, 18 May 2022 07:04:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRZ07UMFscO0sfQLCiTB2pqLYC57Y6dyEd2sj5Nzl4GQKVhYVFVrDMj/jufvf1lIx1hoenpQ==
X-Received: by 2002:a05:620a:2807:b0:67d:6349:2577 with SMTP id f7-20020a05620a280700b0067d63492577mr19701542qkp.785.1652882676872;
        Wed, 18 May 2022 07:04:36 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id i1-20020a375401000000b006a0462eb091sm1606396qkb.80.2022.05.18.07.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:04:36 -0700 (PDT)
Subject: Re: [PATCH] fpga: altera-cvp: allow interrupt to continue next time
To:     tien.sung.ang@intel.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinh.nguyen@intel.com>
References: <20220518073844.2713722-1-tien.sung.ang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b0fd6c41-f8a4-bb3a-d05a-2ea17d4ffc80@redhat.com>
Date:   Wed, 18 May 2022 07:04:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220518073844.2713722-1-tien.sung.ang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/22 12:38 AM, tien.sung.ang@intel.com wrote:
> From: Dinh Nguyen <dinh.nguyen@intel.com>
>
> CFG_READY signal/bit may time-out due to firmware not responding
> within the given time-out. This time varies due to numerous
> factors like size of bitstream and others.
> This time-out error does not impact the result of the CvP
> previous transactions. The CvP driver shall then, respond with
> EAGAIN instead Time out error.
>
> Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
>   drivers/fpga/altera-cvp.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..d74ff63c61e8 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -309,10 +309,22 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
>   	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
>   	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
>   				     conf->priv->poll_time_us);
> -	if (ret)
> +	if (ret) {
>   		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
> +		goto error_path;
> +	}
>   
>   	return ret;
> +
> +error_path:
> +	/* reset CVP_MODE and HIP_CLK_SEL bit */
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
> +	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
> +	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
> +
> +	return -EAGAIN;

This will set fpga_mgr->state to *_ERR.

Is this ok or do you think we need a couple new of *_BUSY enums ?

Tom

> +
>   }
>   
>   static int altera_cvp_write_init(struct fpga_manager *mgr,

