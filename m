Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C959509E16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388601AbiDUK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388575AbiDUK4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:56:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B326120
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650538423; x=1682074423;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0nT52HKSD5XypZFB6WpRQMozkp5u7xkY6Ho5vUtY7Z4=;
  b=Gs9tX0xHpPLUsnqUcrshC7uNT4q4LNVGAWENMfCOuYGAGtnyPPdNBEL+
   QbuWTPrhBN0mq0V1334Aivp91ABJ3pi7gFnbHHece/UuuErcSMUD/Pv35
   Ze9oYsk0oXkmsSFc5OHz9w4JtnIziRbTqiVDkD9qXMOWvgQDUz36nfYFT
   I9KMPK40OCFrXsQKgCYInEQ96EALHdN1G6o+FIPmiRQICs5sNgsE8PFuS
   GXafi1loZTng+KSxjAAPnCFOzU4i3+1i6Fch0zwAeIxRpJMzcEqDPB8Lh
   DbyXroVDCnnrYhK13hrsk2SzIIzbXf+5+cP1Z24vCY7ozeZS8/Hy4Rtd6
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643644800"; 
   d="scan'208";a="203326034"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 18:53:42 +0800
IronPort-SDR: HqtdZ8A9iiaP9/LN+LREO2zvcCWuKB1+SXgmKRzUa2Ibks+uaqWpN0KUoTjXovBGQFxCR+3OTl
 uvLjAadFwcVHFxdgUXGsDoM/Kq/4DT6ne6apWmoZlfS+n0IRZPvvudNNQeqTYk1gbPIv1aHy77
 teusf+Mx0ekdwEn31rIXQNOvS/Rdvxzln+UMH/VQtqjUDakJDdCF+EerpVL6eBsY/8ez1ZPaLs
 HmSr3fr2kLqQbKjLLrvcp6IbjItYZ3pflo7EbLFMtQsHpx0Rp7m5v5xbneHjsD/qtKf+yEuQuO
 nx1R0y3JXJF2Wj/DqORyqMdt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 03:24:46 -0700
IronPort-SDR: kvv/E00mRuyhNNa/D+W2Fcs3vTLKuh0qLFC8m5WvMRQ0ZM/WksGqhtUah+1AW4t9N0MD2YXf3U
 bxZSS0S866qSIEPWU7NPQKVZ2KceDejvhyy+dvDqgkUlQ4TrDgXuA1uc2UHsbZ29uGHeSNo5Ra
 Mnh4WUlJuM/SUh/bVxCsopSzlz5R2ta8BQ1j580N4knYUFzweykAu4wDrckR0ZItUzhKFTju3N
 krKDeAoeOPus74f93LD1Dlao0WFWwQZL6FxEyitur842g6dIWILbCh7bi8zg5r5A3cqUqafDMh
 ynQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 03:53:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkZCW1Tj2z1Rwrw
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:53:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650538422; x=1653130423; bh=0nT52HKSD5XypZFB6WpRQMozkp5u7xkY6Ho
        5vUtY7Z4=; b=PJSAJ94Sidw8yMw9AuQXjz9svpVAhgbuIURjHykJUKORTQuUXW0
        4Du2esjM+fEzXnqLN52ZKoLR+44B44DApc8dypMvTK1IVKo1NWy5DAkMdWu+MbMV
        4vMbMYg7RjAx0ckv6GkgOSdbzBecn8RtD8k+SOuFE65mfuyWmT3ok/cTV3TQu8UN
        5glzKGmmcL3qixBGPUBJmlAk002ZirptET3M9g+6wab8O8k3NUjzA+Y8Yd1vSSex
        b8eLpiE1Js8fLOWCWG4kVb7cw01qNiwxQRwrAyL0OWL/0UnfllZcl1pBsCc7lwEJ
        u5icw1GsjPHbLJIdkR03jV2Ao3KotktgHFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WPbVtd-JX9nj for <linux-kernel@vger.kernel.org>;
        Thu, 21 Apr 2022 03:53:42 -0700 (PDT)
Received: from [10.225.163.19] (unknown [10.225.163.19])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkZCV28tHz1Rvlx;
        Thu, 21 Apr 2022 03:53:42 -0700 (PDT)
Message-ID: <2a91c02d-4f7c-535b-e047-889df87ebebd@opensource.wdc.com>
Date:   Thu, 21 Apr 2022 19:53:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] ahci: Add PxSCTL.IPM control on actual LPM capability
Content-Language: en-US
To:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <1650534217-14052-3-git-send-email-RunaGuo-oc@zhaoxin.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1650534217-14052-3-git-send-email-RunaGuo-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 18:43, Runa Guo-oc wrote:
> On some platform, when OS enables LPM by default (eg, min_power),
> then, DIPM slumber request cannot be disallowed if ahci's CAP.PSC
> is set to '1' and CAP.SSC is cleared to '0', which may cause ahci
> to be an uncertain state (same for Partial).
> 
> In ahci spec, when CAP.PSC/SSC is cleared to '0', the PxSCTL.IPM
> field must be programmed to disallow device initiated Partial/
> Slumber request.
> 
> Adds support to control this case on actual LPM capability.

s/Adds/Add

Overall, I need to reread the specs to confirm all this.

> 
> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
> ---
>  drivers/ata/libata-sata.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 7a5fe41..e6195cf 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -394,9 +394,19 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  	case ATA_LPM_MED_POWER_WITH_DIPM:
>  	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
>  	case ATA_LPM_MIN_POWER:
> -		if (ata_link_nr_enabled(link) > 0)
> +		if (ata_link_nr_enabled(link) > 0) {
>  			/* no restrictions on LPM transitions */>  			scontrol &= ~(0x7 << 8);

Given that the added code below adds restrictions, this comment is
strange. Better change it to something like:

			/* Assume no restrictions on LPM transitions */

> +
> +			/* if controller does not support partial, then disallows it,
> +			 * the same for slumber
> +			 */

Please correctly format the comment and check the grammar. Some like below
is easier to read.

			/*
			 * If the controller does not support partial or
			 * slumber then disallow these transitions.
			 */

> +			if (!(link->ap->host->flags & ATA_HOST_PART))
> +				scontrol |= (0x1 << 8);
> +
> +			if (!(link->ap->host->flags & ATA_HOST_SSC))
> +				scontrol |= (0x2 << 8);
> +		}
>  		else {

Please do not leave this else here. Put it on the same line as the closing
bracket and enclose the below statements in brackets too.

>  			/* empty port, power off */
>  			scontrol &= ~0xf;

		} else {
			/* empty port, power off */
 			scontrol &= ~0xf;
		}


-- 
Damien Le Moal
Western Digital Research
