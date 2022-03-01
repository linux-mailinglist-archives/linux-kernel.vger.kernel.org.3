Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1C4C8D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiCAOP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiCAOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:15:55 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50027B546
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646144114; x=1677680114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3g6eocEvwM/SZQuy0tditVfU8hMIWb2DcnPeQGqJviE=;
  b=pLAzGjeqYs2Pthx4W9jX5MkQA6yTzfU+FrC2B4gorTuu+COgVaezARrd
   NNs9nw25y5i2De0VBvViNR/QCwMpu44LHaaBozwQ5BIPbhw2xe76rdWir
   pakf228WlffuxBbrqHtZVRzf+rXICQFpFiIEHk7BaRkgrJ5DahSFDNaO8
   OZlArkUjbTsU5npPVujkaaeYVaczGNsiEORGEBxM3DyEGNCaj2Jf7FpZe
   g0u1h+FqwI/BnYXNetjpG9ZEZBN1UWzzz5q5pOfRl2ejGml99fLYvjeZw
   NAwsX3Er4593gFyLnq/WAI/cowZmZuLc4rUnyWWBIfOxWQSYDm/LPgu1C
   A==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643644800"; 
   d="scan'208";a="193127223"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2022 22:15:13 +0800
IronPort-SDR: +RFIMzGC4fUdpcdYIh0RIC8ZuQnCMliViXXNdAGeS4eMUBNxznwe9VaRY5rJnPiSt2Rf3dfncx
 oPcJGDNx77CemyRHT2Pt6wEsAlcV9Kd96BtyjVM2SYdRVqzJwqjvSGaTHK++gMDbuSAsC4Cr7q
 kyPkqK3OrlqzckGZiKB83pNye1TEr4njK2JRkv9tCZjy7fxKEXTeNCRQ87/e1OWEbebZf0fgMj
 HEHm+IBJe2cbCBIIgjlQbn95e9f7xWm1DhdLFGhnVEbLJBEhaPkVxUo9NrPZXjD38GqhDeyk0Q
 eoiBGW5eMDlZhGxyQ+NdbOyO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:46:38 -0800
IronPort-SDR: pKnYw4zc0ok1/clWeGRahmvxd0Orrto8RiAiy7RUY/yCNW5/U3BEGRrxwmBH6ZgwCMapLgFjG1
 B55KCRG2Fjh0jjnAX7fK5v0gz3OdfD0OToE0995oQdOsJsur5HLDOt6ln51NBkWb9ANa48etmp
 1N5w9W35Ucdw4ApfdFQWBp5x9w1WV4xSnt8yuCVVvrvrqohEE9kcehsubBI9Px2KBDBvBR4Ngb
 KnqVM+/O/3zJj6Qg6YIg+u53by7NWnGR5VKGHSM2zSw9/SOIZuQnOzxCLUC3obtqEp6cXck2qD
 KrM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 06:15:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7K5Y6RBlz1SHwl
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:15:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646144113; x=1648736114; bh=3g6eocEvwM/SZQuy0tditVfU8hMIWb2DcnP
        eQGqJviE=; b=rHvBtNKTJoa7w2DKPDeeiqUfa37f0gxLanjn6h1E7MVHhx4LUy8
        rwGFux9BBvfd3Gq1lX6Nfh26Anqbq7GBWf2mPxnkJ+Ibxn5RcSBI4A9S5jO0DssD
        7gCgUWeCKjbOhe3yJzN9VD67o0kVfxpb7k/DubUHvluzv1OEsf+UjQga990TmKHb
        6Paddtl6VuKBjd98PZEPPMjFa0JAvSUwrK4ocw0FdqzGq6cEagfI4t4Wvp/MVJ3/
        eXdaTUTluyQ1BM4LFuRnVysW45uEW+y2B/QC8oTBgrkfF9fHuFY7/gSaxqcdZDMr
        RP6TzReuiwfWs9a0cEAK0Fn3ecBQGtK79dA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d-avMcA-VQF4 for <linux-kernel@vger.kernel.org>;
        Tue,  1 Mar 2022 06:15:13 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7K5W6wKDz1Rvlx;
        Tue,  1 Mar 2022 06:15:11 -0800 (PST)
Message-ID: <925e48e5-87ab-09b1-3524-4b9914f0b88d@opensource.wdc.com>
Date:   Tue, 1 Mar 2022 16:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
 <20220228213302.2915071-2-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220228213302.2915071-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/28 23:33, Mario Limonciello wrote:
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

Wouldn't it be safer to have the HOST_CAP_SSC check inside sata_link_scr_lpm() ?
There are other caller sites...

> +			struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +
> +			dev_warn(&pdev->dev,
> +				 "This drive doesn't support slumber; ignoring SATA policy\n"> +		} else {
> +			sata_link_scr_lpm(link, policy, false);
> +		}
>  	}
>  
>  	if (hpriv->cap & HOST_CAP_ALPM) {


-- 
Damien Le Moal
Western Digital Research
