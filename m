Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD34E9627
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiC1MEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiC1MES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EE25767C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648468956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4YuSoXEpfKw3CY3q6k+YQSDCe8in/eyYKmmQSSQgag=;
        b=DigmBhJ0gBPPZXtCsm/twMx6KbCEaCo6vGrHqLJr+VMNIO8Y8O8Uv5APRTyO+Pgdn4zMDO
        UBRgXU5nUDNdAI4zPHFIrhNjPhiFEAjQDqakDnovSoj7cciUyVQ7lFnKBTHjmDY6PirPJm
        /QdRODGjHr1vgZfTUf2XLEqeOIp2RGc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-nZU3IyqbM4ePsN-uijznBQ-1; Mon, 28 Mar 2022 08:02:34 -0400
X-MC-Unique: nZU3IyqbM4ePsN-uijznBQ-1
Received: by mail-ed1-f71.google.com with SMTP id u17-20020a05640207d100b00418f00014f8so3561778edy.18
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U4YuSoXEpfKw3CY3q6k+YQSDCe8in/eyYKmmQSSQgag=;
        b=stmzWUkOjha1uOTuJqhmKnCCO4zcyp6suI9yE1dC6e8Wj25HioHvTCducu2M3KTy/V
         gZ0WneZE+p8gBqg3ktVt3kmpCyxbxi49uBr6/pyO8+H3QMJ9X0Od5Jjgzg8KWt+fpmlB
         TTZEgqyD809nWQz4x2vTYm2oDi4L+HbjoqPSJ1YnPLY9cLnl+SHAk4Aax1Im8kVimFWK
         kW7GS3/ruFYJNAPPTowL8Nn8gAIpxCESeKkkFASv/sYNMQzbTWUqej9sMlVaCgw3pFNZ
         TWooxJc2mEmNiBU202rUzOO7Ok5BjcMAtzYvQa8h7IV6aggO1zsOYDvMYBcTxkfvTGF8
         g7cw==
X-Gm-Message-State: AOAM532pfbF0iBKNm7+q+S2e8RoM/l+9x8BBxMH+lrbfRDC2Kf4lNkIK
        58pwE/a+JgEj4aNtDEv0AqMLZzd+KZvKaMYsX4DDjDCSQ9P4NDhazwi1JCDtxijhQSDjHAMB/+7
        n4He2wFiTN2mSd4D+EnXVpju0
X-Received: by 2002:a05:6402:4250:b0:419:5e89:a40f with SMTP id g16-20020a056402425000b004195e89a40fmr15885166edb.319.1648468953575;
        Mon, 28 Mar 2022 05:02:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxQVYA+xa0yLm7c8pheyKZfxqoGvrYk09ZOIa2goIURwU9jniNoOsbE1V3iGYnUMyaACVw7g==
X-Received: by 2002:a05:6402:4250:b0:419:5e89:a40f with SMTP id g16-20020a056402425000b004195e89a40fmr15885144edb.319.1648468953305;
        Mon, 28 Mar 2022 05:02:33 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id u26-20020a05640207da00b00419a14928e5sm4959473edy.28.2022.03.28.05.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:02:32 -0700 (PDT)
Message-ID: <161e7a97-d259-0bd7-431f-6b9f69e7cc37@redhat.com>
Date:   Mon, 28 Mar 2022 14:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/4] input/i8042: Move __initconst to fix code styling
 warning
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220322162125.59838-1-wse@tuxedocomputers.com>
 <20220322162125.59838-2-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220322162125.59838-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/22/22 17:21, Werner Sembach wrote:
> Move __intconst from before i8042_dmi_laptop_table[] to after it for
> consistent code styling.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/input/serio/i8042-x86ia64io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 148a7c5fd0e2..91c6f24b4837 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -791,7 +791,7 @@ static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
>  	{ }
>  };
>  
> -static const struct dmi_system_id __initconst i8042_dmi_laptop_table[] = {
> +static const struct dmi_system_id i8042_dmi_laptop_table[] __initconst = {
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */

