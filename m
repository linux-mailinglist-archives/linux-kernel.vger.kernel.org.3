Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9E4D8192
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiCNLpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbiCNLny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF2694889B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647258111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cW4jyY0ggHWKM//52H4ZSp+MxpMFUr2GDlzHOKOA7Nc=;
        b=DQ9oUauDc0lbGZ3KlOfXED5WHb12cOvAocW3icq95uRWbB9nkuBE2CgqxwkBhdWaNUh1Cv
        XCYquxOtFcvt92LXjgVw7t4geMKXnaXZgLjn1qK2BHBDhRtY9MZ5Jq21HAkH6PpYFqtAHS
        FPWVtzcnHYnuylNJGSXD1VFiJ8NgwfI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-EhVpStTWOjyimOKEEl0qCA-1; Mon, 14 Mar 2022 07:41:50 -0400
X-MC-Unique: EhVpStTWOjyimOKEEl0qCA-1
Received: by mail-ed1-f69.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so8549905edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cW4jyY0ggHWKM//52H4ZSp+MxpMFUr2GDlzHOKOA7Nc=;
        b=TFF8WsnAtXuVOra9SuyD68mkke5FJuXIhcu2hRe0gZCRDm7FZWewxkOx5DaJ1FGI5w
         Xu1fRIi/M5+TPj9u1BFOUGXbaPgnhJhXi0wTVvOC9ugZAlbFWgKV8Roc/ypqpLWZl2M8
         XiHrnekC/0ymo2V/7P0UjZv3IlIBjzo7Ns4UHp9E+eYBsH/jdHwFAzBP20LHTZM2aBQu
         1Btj/vv7CSjFAWz2K6aQ8n0gljHsG3i03LMrrxm+rV47glDMxaCj0x9581rSdqi3KcfJ
         tmIupTcYPlvaCzsY2qOlgOqslsc1Scbdmw/+MfX0ZujOzg3ETsZd7rlxWb+iKw4Cx9Jc
         AVAA==
X-Gm-Message-State: AOAM531p81g0dR1f8Y65Il3ibZN2GoMHK80PWxLZ9FwPjI6pUZcQE0DZ
        Sybip0xz+MDXHL7+UW5RHr8QQqHto3VQzuZxWnZCg27ojy4L89vL7Y2o/YWCKhlloq1ifyWHHpz
        470MpxRL9RdjzJAuoOXAbC/3o
X-Received: by 2002:a17:906:c04d:b0:6b9:252:c51c with SMTP id bm13-20020a170906c04d00b006b90252c51cmr18463874ejb.470.1647258109164;
        Mon, 14 Mar 2022 04:41:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1/PLmBFreOKVpLqYJHlqGRf+raWVhG5509XKiTAb59JuFpATNwStJnj9bzZcI97sPIdSztQ==
X-Received: by 2002:a17:906:c04d:b0:6b9:252:c51c with SMTP id bm13-20020a170906c04d00b006b90252c51cmr18463866ejb.470.1647258108946;
        Mon, 14 Mar 2022 04:41:48 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm7988373edj.49.2022.03.14.04.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 04:41:48 -0700 (PDT)
Message-ID: <1cd105fe-3c63-49f7-cf1c-b86322ff2d37@redhat.com>
Date:   Mon, 14 Mar 2022 12:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] platform/x86: hp-wmi: support omen thermal profile policy
 v1
Content-Language: en-US
To:     Enver Balalic <balalic.enver@gmail.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com
References: <20220313190532.vpeuytz2ergnfsyt@omen>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220313190532.vpeuytz2ergnfsyt@omen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your patch. Some other changes have just landed to
the hp-wmi driver, so for the next version please base your patch
on my review-hans branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

On 3/13/22 20:05, Enver Balalic wrote:
> As it turns out, these laptops have 2 thermal profile versions.
> A previous patch added support for v0, this patch adds support
> for v1 thermal policies that are in use on some devices.
> We obtain the thermal policy version by querying the get system
> design data WMI call and looking at the fourth byte it returns,
> except if the system board DMI Board ID is in a specific array
> that the windows command center app overrides to thermal policy
> v0 for some reason.
> 
> Signed-off-by: Enver Balalic <balalic.enver@gmail.com>
> ---
>  drivers/platform/x86/hp-wmi.c | 69 +++++++++++++++++++++++++++++++----
>  1 file changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 48a46466f086..ed5c729f8da1 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -61,6 +61,14 @@ static const char * const omen_thermal_profile_boards[] = {
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
> @@ -115,6 +123,7 @@ enum hp_wmi_gm_commandtype {
>  	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
>  	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
>  	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
> +	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
>  };
>  
>  enum hp_wmi_command {
> @@ -149,6 +158,12 @@ enum hp_wireless2_bits {
>  	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
>  };
>  
> +enum hp_thermal_profile_omen_v1 {
> +	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
> +	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
> +	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
> +};
> +

Maybe also rename the V0 values to HP_OMEN_V0_THERMAL_PROFILE_?
for consistency ?

>  enum hp_thermal_profile_omen {
>  	HP_OMEN_THERMAL_PROFILE_DEFAULT     = 0x00,
>  	HP_OMEN_THERMAL_PROFILE_PERFORMANCE = 0x01,
> @@ -360,9 +375,6 @@ static int omen_thermal_profile_set(int mode)
>  	char buffer[2] = {0, mode};
>  	int ret;
>  
> -	if (mode < 0 || mode > 2)
> -		return -EINVAL;
> -
>  	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
>  				   &buffer, sizeof(buffer), sizeof(buffer));
>  
> @@ -384,6 +396,30 @@ static bool is_omen_thermal_profile(void)
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
> +			return 1;

This seems wrong, shouldn't this be "return 0" so that the v0 interface
actually gets used, rather then the v1 interface?

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
> @@ -1009,12 +1045,15 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
>  
>  	switch (tp) {
>  	case HP_OMEN_THERMAL_PROFILE_PERFORMANCE:
> +	case HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE:
>  		*profile = PLATFORM_PROFILE_PERFORMANCE;
>  		break;
>  	case HP_OMEN_THERMAL_PROFILE_DEFAULT:
> +	case HP_OMEN_V1_THERMAL_PROFILE_DEFAULT:
>  		*profile = PLATFORM_PROFILE_BALANCED;
>  		break;
>  	case HP_OMEN_THERMAL_PROFILE_COOL:
> +	case HP_OMEN_V1_THERMAL_PROFILE_COOL:
>  		*profile = PLATFORM_PROFILE_COOL;
>  		break;
>  	default:
> @@ -1027,23 +1066,38 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
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
> +			tp = HP_OMEN_THERMAL_PROFILE_PERFORMANCE;
> +		else
> +			tp = HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE;
>  		break;
>  	case PLATFORM_PROFILE_BALANCED:
> -		tp = HP_OMEN_THERMAL_PROFILE_DEFAULT;
> +		if (tp_version == 0)
> +			tp = HP_OMEN_THERMAL_PROFILE_DEFAULT;
> +		else
> +			tp = HP_OMEN_V1_THERMAL_PROFILE_DEFAULT;
>  		break;
>  	case PLATFORM_PROFILE_COOL:
> -		tp = HP_OMEN_THERMAL_PROFILE_COOL;
> +		if (tp_version == 0)
> +			tp = HP_OMEN_THERMAL_PROFILE_COOL;
> +		else
> +			tp = HP_OMEN_V1_THERMAL_PROFILE_COOL;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
>  
>  	err = omen_thermal_profile_set(tp);
> +

Please drop this unnecessary blank-line addition.

>	if (err < 0)
>  		return err;
>  
> @@ -1128,6 +1182,7 @@ static int thermal_profile_setup(void)
>  		 */
>  
>  		err = omen_thermal_profile_set(tp);
> +

Please drop this unnecessary blank-line addition.

>  		if (err < 0)
>  			return err;
>  

Regards,

Hans

