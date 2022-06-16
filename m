Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7154E59A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377826AbiFPPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377782AbiFPPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D334248FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655391801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sU1/eCcg6yRW4nibZ27Ei/SlX0WtSksIdirbQsLBVsA=;
        b=hojGSdSyaK1vsJTr71s5pvf2J+zVRVXOrMrr2YivsELWg2f2p3sAX5HC7Thh5C4K2aTHhG
        Ns2CX+EhU0mvIGu+ZnTvh7v3OsWvEghtm4kOy6RhJRvhfsgSU8WzT/AStQ6b+spAcdTh13
        DLWn+tPDc6V+R/HYRVS6Iafgd0JA/1Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-1kl-aHTLO-6Oxs9iFrzb5A-1; Thu, 16 Jun 2022 11:03:19 -0400
X-MC-Unique: 1kl-aHTLO-6Oxs9iFrzb5A-1
Received: by mail-wm1-f70.google.com with SMTP id l4-20020a05600c1d0400b0039c60535405so754946wms.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sU1/eCcg6yRW4nibZ27Ei/SlX0WtSksIdirbQsLBVsA=;
        b=mIMq+nxMKSbdXBw8Cj/6Lc+3G03PK3RpbQj8opM1FtwpEh6nyUBlGld4e17l4c6Anq
         IskjBHe+S74Y/ET9HqjZjjfr1QMGBXcwjsUydr2ErRuwy1pAJkcUTAkly46oe07I5gi9
         3zTNE7xJh7rYtLpWFI2uvdpUNt2k6hUHrR10EI3sU/lDd6pKKabKmPZVh3OQEY6q5ti2
         J0R/vrebwVULI+6ZcuW+lBiinkPJL/eNUe4nKU6iaXKdSrX/9pKmOMZVOM+CpWI8Wl37
         KFwErRzViRd8EHUKdinQDCtcb/cAPflgSuRTFD8LcxCeYINppXwrzv87m6b2XA7wXXn3
         6bsg==
X-Gm-Message-State: AJIora8LBtr/a9gi55x/Sbfp6UWXG0tOVA3OJEWq0HLvswkh0jor4VA4
        Fk/WWP7loA9kl47ISGbim9UN1sa0iaiqiIsAjxxHnMlduiCF3ZXaUArsgMmUNjQ+dkbsrtdfmth
        o3ptZd2gj5aq7s6T8QbpVWa/l
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id t17-20020a05600c199100b0039c88ba2869mr5389420wmq.14.1655391797685;
        Thu, 16 Jun 2022 08:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1un6/x5EK3gX2NjOv2Ng9CzA86bVIABMgzjcFEcizAaklAzsMgY7pQ1TOk+gIpJce1/3+sDgw==
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id t17-20020a05600c199100b0039c88ba2869mr5389407wmq.14.1655391797463;
        Thu, 16 Jun 2022 08:03:17 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 64-20020a1c1943000000b0039c6390730bsm6107323wmz.29.2022.06.16.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:03:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vit Kabele <vit.kabele@sysgo.com>, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        kys@microsoft.com
Subject: Re: [RFC PATCH] Hyper-V: Initialize crash reporting before vmbus
In-Reply-To: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
References: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
Date:   Thu, 16 Jun 2022 17:03:16 +0200
Message-ID: <874k0kirbf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vit Kabele <vit.kabele@sysgo.com> writes:

> The Hyper-V crash reporting feature is initialized after a successful
> vmbus setup. The reporting feature however does not require vmbus at all
> and Windows guests can indeed use the reporting capabilities even with
> the minimal Hyper-V implementation (as described in the Minimal
> Requirements document).
>
> Reorder the initialization callbacks so that the crash reporting
> callbacks are registered before the vmbus initialization starts.
>
> Nevertheless, I am not sure about following:
>
> 1/ The vmbus_initiate_unload function is called within the panic handler
> even when the vmbus initialization does not finish (there might be no
> vmbus at all). This should probably not be problem because the vmbus
> unload function always checks for current connection state and does
> nothing when this is "DISCONNECTED". For better readability, it might be
> better to add separate panic notifier for vmbus and crash reporting.
>
> 2/ Wouldn't it be better to extract the whole reporting capability out
> of the vmbus module, so that it stays present in the kernel even when
> the vmbus module is possibly unloaded?

IMHO yes but as you mention hyperv_panic_event() currently does to
things:
1) Initiates VMBus unload
2) Reports panic to the hypervisor

I think untangling them moving the later to arch/x86/hyper-v (and
arch/arm64/hyperv/) makes sense.

>
> Signed-off-by: Vit Kabele <vit.kabele@sysgo.com>
>
> ---
>  drivers/hv/vmbus_drv.c | 77 +++++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 714d549b7b46..97873f03aa7a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1509,41 +1509,6 @@ static int vmbus_bus_init(void)
>  	if (hv_is_isolation_supported())
>  		sysctl_record_panic_msg = 0;
>  
> -	/*
> -	 * Only register if the crash MSRs are available
> -	 */
> -	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> -		u64 hyperv_crash_ctl;
> -		/*
> -		 * Panic message recording (sysctl_record_panic_msg)
> -		 * is enabled by default in non-isolated guests and
> -		 * disabled by default in isolated guests; the panic
> -		 * message recording won't be available in isolated
> -		 * guests should the following registration fail.
> -		 */
> -		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
> -		if (!hv_ctl_table_hdr)
> -			pr_err("Hyper-V: sysctl table register error");
> -
> -		/*
> -		 * Register for panic kmsg callback only if the right
> -		 * capability is supported by the hypervisor.
> -		 */
> -		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
> -		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> -			hv_kmsg_dump_register();
> -
> -		register_die_notifier(&hyperv_die_block);
> -	}
> -
> -	/*
> -	 * Always register the panic notifier because we need to unload
> -	 * the VMbus channel connection to prevent any VMbus
> -	 * activity after the VM panics.
> -	 */
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -			       &hyperv_panic_block);
> -
>  	vmbus_request_offers();
>  
>  	return 0;
> @@ -2675,6 +2640,46 @@ static struct syscore_ops hv_synic_syscore_ops = {
>  	.resume = hv_synic_resume,
>  };
>  
> +static void __init crash_reporting_init(void)
> +{
> +	/*
> +	 * Only register if the crash MSRs are available
> +	 */
> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> +		u64 hyperv_crash_ctl;
> +		/*
> +		 * Panic message recording (sysctl_record_panic_msg)
> +		 * is enabled by default in non-isolated guests and
> +		 * disabled by default in isolated guests; the panic
> +		 * message recording won't be available in isolated
> +		 * guests should the following registration fail.
> +		 */
> +		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
> +		if (!hv_ctl_table_hdr)
> +			pr_err("Hyper-V: sysctl table register error");
> +
> +		/*
> +		 * Register for panic kmsg callback only if the right
> +		 * capability is supported by the hypervisor.
> +		 */
> +		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> +			hv_kmsg_dump_register();
> +
> +		register_die_notifier(&hyperv_die_block);
> +	}
> +
> +	/*
> +	 * Always register the panic notifier because we need to unload
> +	 * the VMbus channel connection to prevent any VMbus
> +	 * activity after the VM panics.
> +	 */
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +			       &hyperv_panic_block);
> +
> +
> +}
> +
>  static int __init hv_acpi_init(void)
>  {
>  	int ret, t;
> @@ -2687,6 +2692,8 @@ static int __init hv_acpi_init(void)
>  
>  	init_completion(&probe_event);
>  
> +	crash_reporting_init();
> +
>  	/*
>  	 * Get ACPI resources first.
>  	 */

-- 
Vitaly

