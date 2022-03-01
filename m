Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8D4C8990
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiCAKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiCAKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 885F321BD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646131355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8A5OtxkczfYcacviZFl/lBLkt8cByyhfx0j2HTJtBH4=;
        b=JTxuTCRBirc55ao4DS38ydzrVGTw/SDiMRHaKGzwH/kGW6FM1UzRfSjNrlpnWuq178em3Y
        aUM9L4AXIDETmIHvkYqfkYF/LZdMPiMoz7RsanGt7JdyGD3Fw0MrLdKLQw8+P0WNOhigKv
        jk8GCV1O9aFayTle447p566c2Gyo0Pc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-VR73O-gnOziRwRji5d5UQg-1; Tue, 01 Mar 2022 05:42:34 -0500
X-MC-Unique: VR73O-gnOziRwRji5d5UQg-1
Received: by mail-ej1-f69.google.com with SMTP id m12-20020a1709062acc00b006cfc98179e2so6648975eje.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8A5OtxkczfYcacviZFl/lBLkt8cByyhfx0j2HTJtBH4=;
        b=mRyS717Ez/X3P4zpeMuuivcyJsnFu9aBQYJI/OQ6iNXDFLiyeqe3kBcjoGIAMrqxAu
         7KyztHErLt97Gdf47wXV0uupB9zmWHgITxsdsVk2mEkoivstXd8kPbFHL/8YE475I1vD
         lqh2yAOMAP9SlyUB3JQrdKwXxpicX7WAKy/RUJv/2zzysVOPCQt1OAdUMzJ0ADoYyj3d
         o1lRgPMBOLJs2qDsE2DTsEIPBBoTtWJ/G3NSouditoyyHiTvP4CX0IbjHEV/eFy5b+U0
         1u3zQmDuepabrnen3ltm39/ZBvXu3+GJcCeFwTnUvwidFWvWxG0pwz/FhkfpMi14TTzl
         eKoQ==
X-Gm-Message-State: AOAM533S9WwBRvmQMxIrp2d2quuu38jYFWxk8tBeYA2Zq/SPn6+ePfvR
        y1AP+7uDYDGpi+NH+x4AyQrz2Itqbmsx0CMD1ZoW6EfRLbIu0AjrRNwPt3qlp0YgZyqXwg+SQf1
        Mj2Evy35pVGktaM/mQ+wgmP/g
X-Received: by 2002:a05:6402:845:b0:412:ad14:863e with SMTP id b5-20020a056402084500b00412ad14863emr23959722edz.380.1646131353417;
        Tue, 01 Mar 2022 02:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzogE2u6NQu+4q0ZdJGdPrDMHERcNJvQyX44NVgti8SbKFON5h23iuLW6O8K96++Z4QvZPumQ==
X-Received: by 2002:a05:6402:845:b0:412:ad14:863e with SMTP id b5-20020a056402084500b00412ad14863emr23959702edz.380.1646131353059;
        Tue, 01 Mar 2022 02:42:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm1788061edw.72.2022.03.01.02.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:42:32 -0800 (PST)
Message-ID: <5bb89e60-91ab-3d20-4ea8-86fd50925b9e@redhat.com>
Date:   Tue, 1 Mar 2022 11:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
 <20220228213302.2915071-2-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220228213302.2915071-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/28/22 22:33, Mario Limonciello wrote:
> As the default low power policy applies to more chipsets and drives, it's
> important to make sure that drives actually support the policy that a user
> selected in their kernel configuration.
> 
> If the drive doesn't support slumber, don't let the default policies
> dependent upon slumber (`min_power` or `min_power_with_partial`) affect the
> disk.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes from RFC v1 -> PATCH v1:
> * Move the warning and protection from drives that don't support slumber further
>   into the calling path.
>  drivers/ata/libahci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 0ed484e04fd6..9dee721ed1fe 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -785,7 +785,15 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  		pp->intr_mask &= ~PORT_IRQ_PHYRDY;
>  		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
>  
> -		sata_link_scr_lpm(link, policy, false);
> +		if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
> +		   !(hpriv->cap & HOST_CAP_SSC)) {
> +			struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +
> +			dev_warn(&pdev->dev,
> +				 "This drive doesn't support slumber; ignoring SATA policy\n");

Not sure if completely ignoring the policy here is a good idea. IMHO it would
be better to fallback to MED_POWER_WITH_DIPM at least for the haswell - skylake(++++)
generations having MED_POWER_WITH_DIPM is important to allow the package to
go the higher PC states.

> +		} else {
> +			sata_link_scr_lpm(link, policy, false);
> +		}
>  	}
>  
>  	if (hpriv->cap & HOST_CAP_ALPM) {

Regards,

Hans

