Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F57509DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388478AbiDUKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388473AbiDUKmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:42:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0494C255BA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650537551; x=1682073551;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pa0ne/3aUicij/MeugTmo1Q1eq7LIlEWXnsP0dcjAG8=;
  b=GAtUwbiKBfnxRRLjCrCeRZcvxwNul0Ue49E7TIrCGh7qPelvdQGjo2Dy
   Gxj3keEc2n+XW5Mox4kVSA096lMBV2NmL/7s+pSC1Ki11hRIOghTZTmaC
   87/I74jOZdW6Athxh7Qk8BKvveOPYfo1zVPulhuHH39Jo5Wzb5aolYJSj
   2+ePtMCUHP3e87VtQ29SmnFIrjJ0cTmiZR9rDmbW+x3+izjSkb6BeHLU6
   lmrnu8A/3ltcRJ9WHNRfrHqqjW8OxF+c6B5SpkX+taQhg5pfq/29PoL7v
   mjJDTksmZZEYJsB9lJNoSnVRG3ZeZn42bYAn1ULgBJn/mU1AUslhRd4BP
   A==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643644800"; 
   d="scan'208";a="199354821"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 18:39:10 +0800
IronPort-SDR: bVdRyMdEI6/NF7tdbL8sQT5Lm94jM+GF6L7Fvevq5tlsK8mr74XCBnVCY8X37hiA3xNB9HFPej
 wM7Q8qhLRTNRw2qgyu7j1msPYC4lfon6XFwoPgIu2G4cy1qRqmZA5qMv/FF0PieiibYib3e1ha
 2NVLMTJetjOMi/AM6YA32Vnnsmtc1v/EzSWE4c3XI0Ay50w2Sp44wSJSw1KPE9UVbQDPtflXXB
 WnYtm3yJFoY4s85PsBlBvPIIA4emNmzSn46oDO3aD40Bfx3VU3tli0LppCH7nkrQX+GOqKi3xZ
 QUuebmpvEU55VcgMdrikiiHF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 03:09:27 -0700
IronPort-SDR: hUfnpyxMDyqWHmS5dj7IqmCmKGnyfZUmFWs4LeO+bc6NLvo2Q0ENAVAXC7A16llB4wbjNXdg3S
 nUUdcJJz4ep4/xZtmxUKj05/vsBZSiSRqaTWMlwvnEP6vm/G9HeoE+w2+h/eX1Pu9ewYtyqkDP
 jcqI1pv9TAhtco7REdGFqnZKI6nQUAl8J3wrsHpVDp2w7uN8SRDYVvaHHK8u8RTxqi5HHYsCiD
 cZcDLi/WCUMO5QUIRjYcq3y3viHTGjlX3OexgBY5VGyoVkqEi49juHGnoixAQ5GFu4TmXe7O6z
 kK4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 03:39:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkYth54Yvz1SVp0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:39:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650537548; x=1653129549; bh=pa0ne/3aUicij/MeugTmo1Q1eq7LIlEWXns
        P0dcjAG8=; b=NJGMrX6XLpx2ug1LFGlz52ERYbTEy7GEbf3UA5yBPcOXwSjMdjY
        dJJXFu6ZOvUkMANbyuFpnuQPgLdH1eQj5osIgd2Edb8EJR3CRK/quGNi5dLeUXPx
        uUOsPKQd8BjhJDlalQmeGO9bNZGXnFsTen18+HK1MMWOIGz5vw5HWcDTCKw3aGOU
        7hTJDIq4Ya8oM1HsRq0mU2u7dMaegqg6Z/SE8ECESCYWqNtRqslZAPGsjb2GeYM3
        Hv8dIN/kplPVtBXiuVAMmAm703kGc2Ty/ejQ5ATSMYmanVjjUXQT+XQZqEd0UdSr
        jTq9W/1bcRlvkyXxOUhfR9/+sVOlTZ39q+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pHaQB3FbStD7 for <linux-kernel@vger.kernel.org>;
        Thu, 21 Apr 2022 03:39:08 -0700 (PDT)
Received: from [10.225.163.19] (unknown [10.225.163.19])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkYtg2ZL4z1Rvlx;
        Thu, 21 Apr 2022 03:39:07 -0700 (PDT)
Message-ID: <244f0c98-13f4-1ac4-9ebe-facdad4ae8b6@opensource.wdc.com>
Date:   Thu, 21 Apr 2022 19:39:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] ahci: Add PhyRdy Change control on actual LPM
 capability
Content-Language: en-US
To:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <1650534217-14052-2-git-send-email-RunaGuo-oc@zhaoxin.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1650534217-14052-2-git-send-email-RunaGuo-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 18:43, Runa Guo-oc wrote:
> On some platform, when OS enables LPM by default (eg, min_power),
> then, PhyRdy Change cannot be detected if ahci supports no LPM.

Do you mean "...if the ahci adapter does not support LPM." ?
If that is what you mean, then min_power should not be set. Mario has
patches to fix that.

> 
> In ahci spec, PhyRdy Change cannot coexist with LPM.
> 
> Adds support to control this case on actual LPM capability.
> 
> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
> ---
>  drivers/ata/ahci.c      | 9 +++++++++
>  drivers/ata/libata-eh.c | 4 ++++
>  include/linux/libata.h  | 4 ++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 397dfd2..03f0cb3 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1870,6 +1870,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	else
>  		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
>  
> +	if (hpriv->cap & HOST_CAP_PART)
> +		host->flags |= ATA_HOST_PART;
> +
> +	if (hpriv->cap & HOST_CAP_SSC)
> +		host->flags |= ATA_HOST_SSC;
> +
> +	if (hpriv->cap2 & HOST_CAP2_SDS)
> +		host->flags |= ATA_HOST_DEVSLP;
> +
>  	if (pi.flags & ATA_FLAG_EM)
>  		ahci_reset_em(host);
>  
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3307ed4..05b1043 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3246,6 +3246,10 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  	unsigned int err_mask;
>  	int rc;
>  
> +	/* if controller does not support lpm, then sets no LPM flags*/
> +	if (!(ap->host->flags & (ATA_HOST_PART | ATA_HOST_SSC | ATA_HOST_DEVSLP)))
> +		link->flags |= ATA_LFLAG_NO_LPM;
> +
>  	/* if the link or host doesn't do LPM, noop */
>  	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
>  	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 732de90..7a243f4 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -216,6 +216,10 @@ enum {
>  	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
>  	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
>  
> +	ATA_HOST_PART		= (1 << 4), /* Host support partial.*/
> +	ATA_HOST_SSC		= (1 << 5), /* Host support slumber.*/
> +	ATA_HOST_DEVSLP		= (1 << 6), /* Host support devslp.*/
> +
>  	/* bits 24:31 of host->flags are reserved for LLD specific flags */
>  
>  	/* various lengths of time */


-- 
Damien Le Moal
Western Digital Research
