Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2595C4D880C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbiCNP3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiCNP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55034FEF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647271674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RV12Cq7QK29gZ038+bLNVvj9P+1aG/g3DD7TA/psLBk=;
        b=FhJIuUlmXB/akux1IAiy4f+MVStUmu+mTxSWpsggtgR/Y/vF6N5GJM1LXUG3BNlbE6X1eq
        DdrwSbjL6XGILFE4M6xTWk8G2HiZroC+yqCu5I7EymvXFDh/+CaW+ZpwhG6zXQyWNdYsjr
        P5lRQ8/Oej76olemOMJNDdqAwlX7zX0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-T7UyGnYbPWCsavMGbjzp9Q-1; Mon, 14 Mar 2022 11:27:53 -0400
X-MC-Unique: T7UyGnYbPWCsavMGbjzp9Q-1
Received: by mail-ed1-f70.google.com with SMTP id u28-20020a50d51c000000b004159ffb8f24so8971058edi.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RV12Cq7QK29gZ038+bLNVvj9P+1aG/g3DD7TA/psLBk=;
        b=4gqW3O3/SowT8gd+z2nY64DTmjrAGyanM21AJeV2Ifb38fmP3kuyo+rA8OjD8ga4GR
         RTU0F9kpjEpGk16UsWpldsS2sdMUZ9RoSEtkJtTBSOfTDnuFLKgq/zrV8hZ1zpJuGewv
         HIbVGmdKtCkUjbu/GkPWhiFVyGD7H5zowqx5NAYOsu16dsCvGQfRV9RcJXxpj+BC9wiS
         vH+YlmLvUxuGT0cOdL9G2TW/kvjIcuuO7C1q5U+4UoJFoUnwPx8M0iJmhDJLysIfdbV3
         UNqnWWaDmzfSpfxE7+a9JNjb6rXU223cUGoFSMOs4gOgERMj9x4QAvksqC5YD5L32Tle
         4NYA==
X-Gm-Message-State: AOAM530eD+H3UO5VH/JVNCiBqkyo8KEE381SXZwp89tl+82xJXvLvjRn
        BrR+m78ldd6jnspqK0gwNzgAiCopS2Qof9gRo58Z8SdGwzzwgBsclpjFiMYXOUy+GZLOt+DwUyS
        VaHdQjktJP9cKjHfCJNUK11b/
X-Received: by 2002:a17:907:9689:b0:6db:9df1:f3b5 with SMTP id hd9-20020a170907968900b006db9df1f3b5mr13544597ejc.84.1647271671707;
        Mon, 14 Mar 2022 08:27:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7RwguMMU9g6O0JFByoCGC+3ST7F1n/bL+ohDMqUA1lZUQMm4ZFjDeiRKj8hW8uDzubHV27A==
X-Received: by 2002:a17:907:9689:b0:6db:9df1:f3b5 with SMTP id hd9-20020a170907968900b006db9df1f3b5mr13544581ejc.84.1647271671435;
        Mon, 14 Mar 2022 08:27:51 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id bc14-20020a056402204e00b004186d45f8b2sm3978583edb.43.2022.03.14.08.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:27:51 -0700 (PDT)
Message-ID: <32332118-bf97-e890-7d97-5d4eeab0388b@redhat.com>
Date:   Mon, 14 Mar 2022 16:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] platform/x86: hp-wmi: support omen thermal profile
 policy v1
Content-Language: en-US
To:     Enver Balalic <balalic.enver@gmail.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com
References: <20220314121453.kjszdciymtg6ctbq@omen>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220314121453.kjszdciymtg6ctbq@omen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/14/22 13:14, Enver Balalic wrote:
> As it turns out, these laptops have 2 thermal profile versions.
> A previous patch added support for v0, this patch adds support
> for v1 thermal policies that are in use on some devices.
> We obtain the thermal policy version by querying the get system
> design data WMI call and looking at the fourth byte it returns,
> except if the system board DMI Board ID is in a specific array
> that the windows command center app overrides to thermal policy
> v0 for some reason.
> 
> - V1
>   Initial Patch
> - V2
>   Rename V0 thermal policy values to HP_OMEN_V0_THERMAL_PROFILE_
>   for consistency with the V1 thermal policy values.
>   Fix issue where instead of forcing certain boards to V0, they
>   were being forced to V1.
>   Drop unnecessary newline additions.
> 
> Signed-off-by: Enver Balalic <balalic.enver@gmail.com>
> ---
>  drivers/platform/x86/hp-wmi.c | 81 +++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index c56c8864961d..0109ddc84be7 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -57,6 +57,14 @@ static const char * const omen_thermal_profile_boards[] = {
>  	"8917", "8918", "8949", "894A", "89EB"
>  };
>  
> +/* DMI Board names of Omen laptops that are specifically set to be thermal
> + * profile version 0 by the Omen Command Center app, regardless of what
> + * the get system design information WMI call returns
> + */
> +static const char *const omen_thermal_profile_force_v0_boards[] = {
> +	"8607", "8746", "8747", "8749", "874A", "8748"
> +};
> +
>  enum hp_wmi_radio {
>  	HPWMI_WIFI	= 0x0,
>  	HPWMI_BLUETOOTH	= 0x1,
> @@ -117,6 +125,7 @@ enum hp_wmi_gm_commandtype {
>  	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
>  	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
>  	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
> +	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
>  };
>  
>  enum hp_wmi_command {
> @@ -151,10 +160,16 @@ enum hp_wireless2_bits {
>  	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
>  };
>  
> -enum hp_thermal_profile_omen {
> -	HP_OMEN_THERMAL_PROFILE_DEFAULT     = 0x00,
> -	HP_OMEN_THERMAL_PROFILE_PERFORMANCE = 0x01,
> -	HP_OMEN_THERMAL_PROFILE_COOL        = 0x02,
> +enum hp_thermal_profile_omen_v1 {
> +	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
> +	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
> +	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
> +};
> +
> +enum hp_thermal_profile_omen_v0 {
> +	HP_OMEN_V0_THERMAL_PROFILE_DEFAULT     = 0x00,
> +	HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE = 0x01,
> +	HP_OMEN_V0_THERMAL_PROFILE_COOL        = 0x02,
>  };

IMHO it would be more logical to list the v0 settings above
the v1 settings, rather then the other way around.

I've fixed this up while merging this patch:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


>  
>  enum hp_thermal_profile {
> @@ -407,9 +422,6 @@ static int omen_thermal_profile_set(int mode)
>  	char buffer[2] = {0, mode};
>  	int ret;
>  
> -	if (mode < 0 || mode > 2)
> -		return -EINVAL;
> -
>  	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
>  				   &buffer, sizeof(buffer), 0);
>  
> @@ -431,6 +443,30 @@ static bool is_omen_thermal_profile(void)
>  			    board_name) >= 0;
>  }
>  
> +static int omen_get_thermal_policy_version(void)
> +{
> +	unsigned char buffer[8] = { 0 };
> +	int ret;
> +
> +	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +
> +	if (board_name) {
> +		int matches = match_string(omen_thermal_profile_force_v0_boards,
> +			ARRAY_SIZE(omen_thermal_profile_force_v0_boards),
> +			board_name);
> +		if (matches >= 0)
> +			return 0;
> +	}
> +
> +	ret = hp_wmi_perform_query(HPWMI_GET_SYSTEM_DESIGN_DATA, HPWMI_GM,
> +				   &buffer, sizeof(buffer), sizeof(buffer));
> +
> +	if (ret)
> +		return ret < 0 ? ret : -EINVAL;
> +
> +	return buffer[3];
> +}
> +
>  static int omen_thermal_profile_get(void)
>  {
>  	u8 data;
> @@ -1053,13 +1089,16 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
>  		return tp;
>  
>  	switch (tp) {
> -	case HP_OMEN_THERMAL_PROFILE_PERFORMANCE:
> +	case HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE:
> +	case HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE:
>  		*profile = PLATFORM_PROFILE_PERFORMANCE;
>  		break;
> -	case HP_OMEN_THERMAL_PROFILE_DEFAULT:
> +	case HP_OMEN_V0_THERMAL_PROFILE_DEFAULT:
> +	case HP_OMEN_V1_THERMAL_PROFILE_DEFAULT:
>  		*profile = PLATFORM_PROFILE_BALANCED;
>  		break;
> -	case HP_OMEN_THERMAL_PROFILE_COOL:
> +	case HP_OMEN_V0_THERMAL_PROFILE_COOL:
> +	case HP_OMEN_V1_THERMAL_PROFILE_COOL:
>  		*profile = PLATFORM_PROFILE_COOL;
>  		break;
>  	default:
> @@ -1072,17 +1111,31 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
>  static int platform_profile_omen_set(struct platform_profile_handler *pprof,
>  				     enum platform_profile_option profile)
>  {
> -	int err, tp;
> +	int err, tp, tp_version;
> +
> +	tp_version = omen_get_thermal_policy_version();
> +
> +	if (tp_version < 0 || tp_version > 1)
> +		return -EOPNOTSUPP;
>  
>  	switch (profile) {
>  	case PLATFORM_PROFILE_PERFORMANCE:
> -		tp = HP_OMEN_THERMAL_PROFILE_PERFORMANCE;
> +		if (tp_version == 0)
> +			tp = HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE;
> +		else
> +			tp = HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE;
>  		break;
>  	case PLATFORM_PROFILE_BALANCED:
> -		tp = HP_OMEN_THERMAL_PROFILE_DEFAULT;
> +		if (tp_version == 0)
> +			tp = HP_OMEN_V0_THERMAL_PROFILE_DEFAULT;
> +		else
> +			tp = HP_OMEN_V1_THERMAL_PROFILE_DEFAULT;
>  		break;
>  	case PLATFORM_PROFILE_COOL:
> -		tp = HP_OMEN_THERMAL_PROFILE_COOL;
> +		if (tp_version == 0)
> +			tp = HP_OMEN_V0_THERMAL_PROFILE_COOL;
> +		else
> +			tp = HP_OMEN_V1_THERMAL_PROFILE_COOL;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;

