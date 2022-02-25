Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC44C507F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiBYVUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238279AbiBYVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C16771F081E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645824016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ugb72Q212gn7WpEYqytVF4bxguHX/b09etPHHCFO4RA=;
        b=h3vPx5tuHdft9/KgoEnR22UY9eocf5vxeXw8n73SST0Cc7siCS6BJ6yS/2K9Uozp/eBlJg
        5CTcc33vGAFbt+wtv3yXVyoL8I8EqtKQpOo2QPQrpt3EP9z+ezJJfO/zlW/X4fg43EB52Q
        PaZqq6Q/bKpQC9cF1jmk+tcp6qBHkRE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-ihF3JRt2PjmBWHOhMEEDCg-1; Fri, 25 Feb 2022 16:20:15 -0500
X-MC-Unique: ihF3JRt2PjmBWHOhMEEDCg-1
Received: by mail-ed1-f70.google.com with SMTP id o5-20020a50c905000000b00410effbf65dso2872947edh.17
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ugb72Q212gn7WpEYqytVF4bxguHX/b09etPHHCFO4RA=;
        b=4Rr803TzIoqGw2t1cEbr3xMuUZWMNtqKRrk2W3rzWZ+AOX2LGNdpaU8K5WLrcvU4MG
         00asQZxkeQIJfP5Ly5HjYSv8bu4jBDFLjNxLjGEcwzsl4oTVREOuMC+q3SzoKMSFPvet
         sF5HoD+GMEyur0ogdqpkN9KNu9jiGb1eo0cmSs3dfM7Ektc6OdTspIt4+f4bGTCvAv9u
         g39qwyg8Lf/dJOVBKPWJh0iyy3RfMmkvw1ur+qULlHiOKD+j4aUMPO/CFgfH0vFh636N
         cs8RkuSaS6KZyBDwQXa80nq6zUFVLC56Qbn358b/VYQft+6305YHm/ALtlH3EYuZYcwU
         0KOA==
X-Gm-Message-State: AOAM530NzYGqJ1scRIgoKaRv5eX/VUKag23Z9QCgSuPlTPyuH2szrH6Q
        elV5CgXgJHvIPoBiMbPn4wA+PxTRDQCcBon2Nl7G78frumNJB/M900iHwnULtvXAluvD4AiXtZA
        VI2g/pqzDQEn0CSQzT2y2qo4b
X-Received: by 2002:a17:906:3583:b0:6d1:c07:fac0 with SMTP id o3-20020a170906358300b006d10c07fac0mr7518603ejb.749.1645824013701;
        Fri, 25 Feb 2022 13:20:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7SsVEDi1/MAB8+gG92lpoC4RvLkLfpYUxil0fJrTsJ8dUE7+sBLp6j68kF83ByiyCQXbQOg==
X-Received: by 2002:a17:906:3583:b0:6d1:c07:fac0 with SMTP id o3-20020a170906358300b006d10c07fac0mr7518595ejb.749.1645824013482;
        Fri, 25 Feb 2022 13:20:13 -0800 (PST)
Received: from ?IPV6:2a0e:5700:4:11:334c:7e36:8d57:40cb? ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id u22-20020a170906951600b006cf03c6af99sm1411726ejx.193.2022.02.25.13.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:20:13 -0800 (PST)
Message-ID: <7381d145-ac6f-60f4-296a-7b191296964a@redhat.com>
Date:   Fri, 25 Feb 2022 22:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220225181030.980223-1-mario.limonciello@amd.com>
 <20220225181030.980223-2-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220225181030.980223-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 2/25/22 19:10, Mario Limonciello wrote:
> As the default low power policy applies to more chipsets and drives, it's
> important to make sure that drives actually support the policy that a user
> selected in their kernel configuration.
> 
> If the drive doesn't support slumber, don't let the default policy for the
> ATA port be `min_power` or `min_power_with_partial`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ata/ahci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 17d757ad7111..af8999453084 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1584,8 +1584,16 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>  static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  					   struct ahci_host_priv *hpriv)
>  {
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	int policy = CONFIG_SATA_LPM_POLICY;
>  
> +	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
> +	   !(hpriv->cap & HOST_CAP_SSC)) {
> +		dev_warn(&pdev->dev,
> +			 "This drive doesn't support slumber; ignoring default SATA policy\n");
> +		return;
> +	}
> +

Don't the capabilties get checked later when the policy gets applied ?

At least I think they do get checked later, but I have not looked
at this code for years  ...  ?

Regards,

Hans


>  	/* user modified policy via module param */
>  	if (mobile_lpm_policy != -1) {
>  		policy = mobile_lpm_policy;

