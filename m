Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54351D525
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390791AbiEFKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiEFKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:08:18 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5095D5BD22
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651831474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHY4VDg+ah70TicV7Rfgy/3c2lRATR8HIfCmkjcH/Oc=;
        b=EBBF1w/tsdjvq9gqaANcNuvF+dcxYCX8kGzpyOtj10w/7SvIkfwfDBdXvhGA/bWTbEdxJI
        65KY+iLnJwJzhns/l4G0P/rwIYzc3B65IUQady+K5xk5rN58CNOnqhZQUBxChoFntH7NTW
        hbE9AArJ4O6qxvp7i6T9km8bLB3b10k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-M18tM8b2OJy95Q0nzBIyHQ-1; Fri, 06 May 2022 06:04:33 -0400
X-MC-Unique: M18tM8b2OJy95Q0nzBIyHQ-1
Received: by mail-ed1-f70.google.com with SMTP id cf16-20020a0564020b9000b00425d543c75dso3751514edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bHY4VDg+ah70TicV7Rfgy/3c2lRATR8HIfCmkjcH/Oc=;
        b=iOVIlC8Fd2/hB6uwlvae/tTtLxT1iCqum8PyVGFr8qxqKtNPxZx46cr1vqzVGh4HSB
         YdJ+GXzmPM9EtNhkWI9G3+vdcySCUaAUMyDupMXVuP5VvxTRtorZ8Unhai8oq5S+RL1A
         drjhj41PASepcRzOljS0i7FrzyJYbIUlWyrmv+gEn8Z/MLiZwBp74edJCVJXXIwXq3fo
         c/clZPTERnKWgFVoYoaU8H6xvpI2kgWFGUC2zxVlx5jEYitSC+fKa1kQlu12Olfexw5n
         a2dfd3DeR+eVnZ9upHYiRmkvGyDuc6MebQVhlCUd5IM6Gm2DiucxmTfhULSNoTW4GUJ5
         yeHA==
X-Gm-Message-State: AOAM533TN6FgbzpfKTS8zmc5ChPgptam0solxFyvTaoOtY66IfsDvPxK
        cM+1VQFDBRsISPpGG4/y3Z4pjIXKL6LuhpmWEbJoO3sWEghJWnRd/IdVAWUaJOAQv8bR5uAZ3In
        md7F1UUTSzg77Pg6MAgcPz1gf
X-Received: by 2002:a17:906:2989:b0:6f3:a215:8426 with SMTP id x9-20020a170906298900b006f3a2158426mr2179958eje.725.1651831470962;
        Fri, 06 May 2022 03:04:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw00aYNt3RKDL8C1p1bUN4+NsjLxXRo4/823/OnQVTFKXu+rcbvHVRjmFNcVwCoe0MclOGQNA==
X-Received: by 2002:a17:906:2989:b0:6f3:a215:8426 with SMTP id x9-20020a170906298900b006f3a2158426mr2179940eje.725.1651831470771;
        Fri, 06 May 2022 03:04:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id zd9-20020a17090698c900b006f3ef214e28sm1814747ejb.142.2022.05.06.03.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 03:04:30 -0700 (PDT)
Message-ID: <0d048b50-ee27-b5d6-11e2-f2f11ae17b79@redhat.com>
Date:   Fri, 6 May 2022 12:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix compilation without
 CONFIG_SUSPEND
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20220503012700.1273-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220503012700.1273-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/22 03:27, Mario Limonciello wrote:
> When compiled without `CONFIG_SUSPEND` the extra s2idle quirk handling
> doesn't make any sense and causes a kernel build failure.
> 
> Disable the new code with `CONFIG_SUSPEND` not set.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, since the original patch was still in my review-hans
branch (and not yet in for-next) I've squashed this fix into
the original patch.

Regards,

Hans




> ---
>  drivers/platform/x86/thinkpad_acpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index f385450af864..2833609fade7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -4482,6 +4482,7 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
>  	{}
>  };
>  
> +#ifdef CONFIG_SUSPEND
>  /*
>   * Lenovo laptops from a variety of generations run a SMI handler during the D3->D0
>   * transition that occurs specifically when exiting suspend to idle which can cause
> @@ -4517,6 +4518,7 @@ static void thinkpad_acpi_amd_s2idle_restore(void)
>  static struct acpi_s2idle_dev_ops thinkpad_acpi_s2idle_dev_ops = {
>  	.restore = thinkpad_acpi_amd_s2idle_restore,
>  };
> +#endif
>  
>  static const struct pci_device_id fwbug_cards_ids[] __initconst = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24F3) },
> @@ -11569,8 +11571,10 @@ static void thinkpad_acpi_module_exit(void)
>  
>  	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
>  
> +#ifdef CONFIG_SUSPEND
>  	if (tp_features.quirks && tp_features.quirks->s2idle_bug_mmio)
>  		acpi_unregister_lps0_dev(&thinkpad_acpi_s2idle_dev_ops);
> +#endif
>  	if (tpacpi_hwmon)
>  		hwmon_device_unregister(tpacpi_hwmon);
>  	if (tp_features.sensors_pdrv_registered)
> @@ -11743,11 +11747,13 @@ static int __init thinkpad_acpi_module_init(void)
>  	dmi_id = dmi_first_match(fwbug_list);
>  	if (dmi_id) {
>  		tp_features.quirks = dmi_id->driver_data;
> +#ifdef CONFIG_SUSPEND
>  		if (tp_features.quirks->s2idle_bug_mmio) {
>  			if (!acpi_register_lps0_dev(&thinkpad_acpi_s2idle_dev_ops))
>  				pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
>  					dmi_id->ident ? dmi_id->ident : "");
>  		}
> +#endif
>  	}
>  
>  	return 0;

