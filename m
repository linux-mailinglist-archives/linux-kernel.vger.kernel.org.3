Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05564F0440
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355821AbiDBOtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356830AbiDBOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3B635EBF3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648910837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqApVrPdjslDmWfRvgur7TJHNjvAC66Z2QZ7pF2j1Zg=;
        b=VNxDye/E0nGZo7Es4tsN28C3Y3Mf59e/U2D4LjA71slBIt19GVQEu1tvSlV6quKu7Zhbyh
        oUPM7pal/sHl3vOHtb4QO/Yp/sR23ugA1siHTc2DkvgmIlm5EjzMRtQhmlnAa2Qy9iX/qX
        o5+a+SiFQAUaO5/P0XkcVO8Ii7uFyy0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-P2yrInjZOuOcnTCZzPcKmQ-1; Sat, 02 Apr 2022 10:47:17 -0400
X-MC-Unique: P2yrInjZOuOcnTCZzPcKmQ-1
Received: by mail-qv1-f70.google.com with SMTP id cf13-20020a05621403ed00b004412de7b1ffso4144192qvb.19
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 07:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jqApVrPdjslDmWfRvgur7TJHNjvAC66Z2QZ7pF2j1Zg=;
        b=6M0AbWpAOfJ+hSdhiGxV76tV0QDORUCWuMr3zgo1yRXF3Q4Y3kka32B13ukR3Z7TBE
         2EZBFFI6To3Y2kMBBNCWnd+kzSJtUxFeV1kbKX4lI3pyawhNcY5zGblcJ6rdB4XAjyTy
         Qt/+aYFvMW4yjGMXRD/aGxFjkrc2VaoDjwHIl2SvvVl1aleCShadmz/H9lj3zO7STv9O
         UJ0fh5PDaHAlC4LHAe3O5dJXK21aF153fNdnrdSWrYaafb2JurImkslT04oWidq3o/Dv
         qQtfGSj1kFXUc18Vh7Zax66tilJsbiPEiEyMFxbgiIKOu4OhvyUhxFv8grRBm7Qb04vU
         CUGg==
X-Gm-Message-State: AOAM532zB7D/japRfh1jAxV1zt4MWmdh9WAOrQstCKEh6Y3lPwJ27Bxg
        tCPhtBkmPftauocGZYZD7AvDAlDO6RrtqGDe6sKYVitTl4z8fdL1RtTSMwblnUKgCRf09kfHqRR
        tvxVzV1k+7VjWMKuo0XnA52Wb
X-Received: by 2002:a05:620a:1084:b0:67b:2d99:8ac4 with SMTP id g4-20020a05620a108400b0067b2d998ac4mr9611202qkk.257.1648910836317;
        Sat, 02 Apr 2022 07:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzAI/t6pR1lb41OmemnjEULPjAVjC6PNxHBzoyu565kc8rISmGW310ZgGGwigre9HGRLBO4g==
X-Received: by 2002:a05:620a:1084:b0:67b:2d99:8ac4 with SMTP id g4-20020a05620a108400b0067b2d998ac4mr9611193qkk.257.1648910835866;
        Sat, 02 Apr 2022 07:47:15 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id l18-20020a05622a051200b002e1e5e57e0csm4127451qtx.11.2022.04.02.07.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 07:47:15 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 2/8] firmware_loader: Check fw_state_is_done in
 loading_store
To:     Russ Weight <russell.h.weight@intel.com>, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, basheer.ahmed.muddebihal@intel.com,
        tianfei.zhang@intel.com
References: <20220323233331.155121-1-russell.h.weight@intel.com>
 <20220323233331.155121-3-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0dc2d770-176f-9c58-e875-cb65ff38509c@redhat.com>
Date:   Sat, 2 Apr 2022 07:47:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220323233331.155121-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/22 4:33 PM, Russ Weight wrote:
> Add the fw_state_is_done() function and exit early from
> firmware_loading_store() if the state is already "done". This is being done
> in preparation for supporting persistent sysfs nodes to allow userspace to
> upload firmware to a device, potentially reusing the sysfs loading and data
> files multiple times.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v1:
>    - No change from RFC patch
> ---
>   drivers/base/firmware_loader/fallback.c | 2 +-
>   drivers/base/firmware_loader/firmware.h | 5 +++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 4afb0e9312c0..d82e055a4297 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -250,7 +250,7 @@ static ssize_t firmware_loading_store(struct device *dev,
>   
>   	mutex_lock(&fw_lock);
>   	fw_priv = fw_sysfs->fw_priv;
> -	if (fw_state_is_aborted(fw_priv))
> +	if (fw_state_is_aborted(fw_priv) || fw_state_is_done(fw_priv))
>   		goto out;
>   
>   	switch (loading) {
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index 2889f446ad41..58768d16f8df 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -149,6 +149,11 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
>   	__fw_state_set(fw_priv, FW_STATUS_DONE);
>   }
>   
> +static inline bool fw_state_is_done(struct fw_priv *fw_priv)
> +{
> +	return __fw_state_check(fw_priv, FW_STATUS_DONE);

This looks like the fw_sysfs_done() in fallback.c

IMO this one and similar wrappers should move to firmware.h and use the 
*_is_* naming.

Tom

> +}
> +
>   int assign_fw(struct firmware *fw, struct device *device);
>   
>   #ifdef CONFIG_FW_LOADER

