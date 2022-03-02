Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491BD4CA038
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiCBJDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiCBJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0887DF19
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646211764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5m7KRWlGmGXQPZRa0GAEBXpq42RC/iuN2Lc7+CRIcfQ=;
        b=Y2SxrvRWtsMRzrVSgZm9yc2q+kPR+fXNZTuCPkCj4iXV7tqTuDMNLvPZb1f4lbd7xTpckd
        sdCVLnntdqzkT3zxjTmmPnqNiTlkLCd9lPIYpbkqsJ+b+5fxUhdS8a7syFlB8fyj6YTrc3
        H0CtQlJnhAyV5V9m/vhusXSaGLULDIA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-oUQHEnoIMTi_YNjpXQZOoA-1; Wed, 02 Mar 2022 04:02:44 -0500
X-MC-Unique: oUQHEnoIMTi_YNjpXQZOoA-1
Received: by mail-ed1-f69.google.com with SMTP id f9-20020a0564021e8900b00412d0a6ef0dso628964edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5m7KRWlGmGXQPZRa0GAEBXpq42RC/iuN2Lc7+CRIcfQ=;
        b=jk7xO5whSQ66Sf8MySSjcWbC3hvl3Bw+qpNvqzNi1Y+EHHoHvkYPqNrs/klQEfKDc7
         jrDWQaCh8tmJWTgtKfI+KvBIJ/UDaQ+c2GqtmpkCYPbPVvp2NTfPexEwWz8cZNumDegy
         sxOKIenCyIPL+2WWYA5dK+xVYEQaXf+2FoIowGjImD1Tf54W9X8LDGqnAto/UeWUlvpx
         ZK7Yj1eRyNFts16eWr9G+7dT8XQX5fc/NPwJQk3ouIHWAoKyJnX8GOSQeCEClqWtAOJE
         V+UCjPzN2lgMYnGbWsuyp5a3Cjn+RIT0Z+vof9ugNdtC2H8O+olBfkwLhG9O/vq/BcI1
         ufYA==
X-Gm-Message-State: AOAM533Cn3kcPyn6qs7okdi9Lt248CV0LMTnoz/qWfHq7GkwfY8uZR9d
        VszspGw8b+ohkr/gNjFhOXtau684ujrwT0fWb2RnWiRzsMlkPjI3LS1Dxj3ymBKvlxCe9MCqejr
        Db038whmRYmaP/DmW53sY6kwd
X-Received: by 2002:a17:907:9719:b0:6d9:b294:4b99 with SMTP id jg25-20020a170907971900b006d9b2944b99mr1666681ejc.444.1646211762672;
        Wed, 02 Mar 2022 01:02:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0TwWywbhgLNniN7uMilV2yLr7OxssKA0/Kv/mzgbSSZhxjPaeICrPzEzMI3qq74bwYNQbKw==
X-Received: by 2002:a17:907:9719:b0:6d9:b294:4b99 with SMTP id jg25-20020a170907971900b006d9b2944b99mr1666657ejc.444.1646211762450;
        Wed, 02 Mar 2022 01:02:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id v7-20020a056402348700b00415b38e920bsm712730edc.95.2022.03.02.01.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:02:41 -0800 (PST)
Message-ID: <832a5b2e-d70c-f1a6-e377-7697b1eb7049@redhat.com>
Date:   Wed, 2 Mar 2022 10:02:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ACPI / x86: Work around broken XSDT on Advantech
 DAC-BJ01 board
Content-Language: en-US
To:     Mark Cilissen <mark@yotsuba.nl>, linux-acpi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
References: <20220302040800.10355-1-mark@yotsuba.nl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220302040800.10355-1-mark@yotsuba.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 3/2/22 05:08, Mark Cilissen wrote:
> On this board the ACPI RSDP structure points to both a RSDT and an XSDT,
> but the XSDT points to a truncated FADT. This causes all sorts of trouble
> and usually a complete failure to boot after the following error occurs:
> 
>   ACPI Error: Unsupported address space: 0x20 (*/hwregs-*)
>   ACPI Error: AE_SUPPORT, Unable to initialize fixed events (*/evevent-*)
>   ACPI: Unable to start ACPI Interpreter
> 
> This leaves the ACPI implementation in such a broken state that subsequent
> kernel subsystem initialisations go wrong, resulting in among others
> mismapped PCI memory, SATA and USB enumeration failures, and freezes.
> 
> As this is an older embedded platform that will likely never see any BIOS
> updates to address this issue and its default shipping OS only complies to
> ACPI 1.0, work around this by forcing `acpi=rsdt`. This patch, applied on
> top of Linux 5.10.102, was confirmed on real hardware to fix the issue.
> 
> Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
> Cc: stable@vger.kernel.org
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2:
> - Reduce DMI match count to 4 to not overflow dmi_system_id structure
> Reported-by: kernel test robot <lkp@intel.com>
> - Change board ident to correct name
> - Fix small style issue
> - Fix up subject as per Rafael's changes
> 
> As this patch is CC'd to stable, it seemed wiser to submit a V2 rather
> than an additional fixup patch to process.
> ---
>  arch/x86/kernel/acpi/boot.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 5b6d1a95776f..b47338cd579d 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1328,6 +1328,17 @@ static int __init disable_acpi_pci(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +static int __init disable_acpi_xsdt(const struct dmi_system_id *d)
> +{
> +	if (!acpi_force) {
> +		pr_notice("%s detected: force use of acpi=rsdt\n", d->ident);
> +		acpi_gbl_do_not_use_xsdt = TRUE;
> +	} else {
> +		pr_notice("Warning: DMI blacklist says broken, but acpi XSDT forced\n");
> +	}
> +	return 0;
> +}
> +
>  static int __init dmi_disable_acpi(const struct dmi_system_id *d)
>  {
>  	if (!acpi_force) {
> @@ -1451,6 +1462,19 @@ static const struct dmi_system_id acpi_dmi_table[] __initconst = {
>  		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
>  		     },
>  	 },
> +	/*
> +	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
> +	 */
> +	{
> +	 .callback = disable_acpi_xsdt,
> +	 .ident = "Advantech DAC-BJ01",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
> +		     DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
> +		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
> +		     },
> +	 },

Heh, I should have noticed this new version before replying. I see that
you've dropped the BIOS-date match. But that actually is often more useful
then the BIOS_VERSION, sometimes vendors don't bump the version when
doing a new BIOS build.

If you only want to match the exact BIOS you tested against I would
drop the BIOS_VENDOR check instead.

Regards,

Hans



>  	{}
>  };
>  
> 
> base-commit: 038101e6b2cd5c55f888f85db42ea2ad3aecb4b6

