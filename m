Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384C34F0D58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 03:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376841AbiDDBMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 21:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358037AbiDDBMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 21:12:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E616632EFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 18:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649034653; x=1680570653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mEnXkc2aXmWFQmJNXsTtqNXWzplpMwoyDFJjQew2C84=;
  b=ccfzpftLJCju58RYWqATcSR4uIoYVrTM4Uva9IXl9J6reEymrdlWuj2O
   pJ53AyhTdJP1qPJfhOrYRYdMsBgD1c/AQNJzFkkEJqyAoqAWe6nc9PSAg
   kyvbhwZ7Hd7FfqAX7y0agdmckQY1fS2zU3SULfZtSZPPMKXTKtGkdsnsN
   eocFk0/8UKGldjAIZX3jp3kxYSZ1Xl+ihl6gD4INAC0a070tFPVSQHA/H
   oirbm73a0nOLmq9xrZB3R+PzOIt1rCS7l6Bpfv7br+nOYfDvqY1uUE+MH
   sUeL8SJzW3aJYPpvO764EDKer/NSgwv1OWAW0Cn1qLAVfd+tX/gZ1s+to
   w==;
X-IronPort-AV: E=Sophos;i="5.90,233,1643644800"; 
   d="scan'208";a="201826505"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2022 09:10:52 +0800
IronPort-SDR: /3xZKHDwSVrxE1aqFKQoBXGkOHWafpHpINp2uGybYNFAhwo4gTgJfrJjl3w0gv3hVXGskAn0Tg
 IQoHUzIex2Y/RV57+HqwOSAZuFQlAeDf68bJHxR9NozPoj9wmWnoaBfk6zUD5R24hL+CeTN5UN
 3U3p0NoUXeODiOYCVQ0XUMIJTkAb2EsRcIk7UoPOvU7HnqPgANFYMRtWT0I+82+KX5Ue/AkTty
 VHWdpXGfrsuiZLKO65uNpjtup4EsCq747jUCw0CZiEZp+fGDCPq5TJR5XHgCDSvdOSTu2eXeCU
 wCgFhFrG0rcdd+UNz2cZXv0b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 17:41:37 -0700
IronPort-SDR: 2c/ioGyjLhoRfuDa6ZyN4zTR0BbsnizNDWl0PwE97OBd0DOTvQ8FRiEVzpEGFwBEMoclk9RruR
 NCbTRxMWIz9ckvxzyWE51qos6qma5F+SWxwPqTKoRXgMbHnKcqd0kYHr/RyZDmEFPaKyXVitR0
 bTzRT06l4/y/HkzZd8kXGlCRYFTSkobMVI86puMTCqBxjePV9LXzkwt0zDuX6Gg9Gq3hG+IkmU
 SPxPNHwOBsAC2MP1z/cgvVp1ieCfseitUZOkQ+KHA4bGZTWWh24gT8l0D/F14wBN562ckgIHMg
 L6g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 18:10:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KWt4r0qVVz1SHwl
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 18:10:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649034651; x=1651626652; bh=mEnXkc2aXmWFQmJNXsTtqNXWzplpMwoyDFJ
        jQew2C84=; b=TO98bMVxe5IFMu7hsYPvsDau4JQ9KxmdfBuCo2m9jawBKVpiAEu
        ZcPkrwMsXYy7S/Kb6/+CFLUw7HvJYkpAypiH9T42AfDgMjOKF1Jx2rYsuYNkd2tT
        Xre5O/nW5VVD/9qzc8S5c3HQLWXhfR1xWjLZ5APWYHWiNXwG2HlNzjKxdAzpZV5R
        XLrgjKyScxtEZS8uQiaIv825+IsZJG7BxwsHC7TwxjWVkHl9kjdFy8GewkNZP3J3
        YnchC424sIKIk2aX8/Z1zbm39vEHH/uPanQE1LvZkcdUXFCv0OtkeIi4Vh86NknD
        w0+0C+nbOtJ2Ar2NZEWqgfxN7qDLeIjMKgw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nOHtY1m4HyIV for <linux-kernel@vger.kernel.org>;
        Sun,  3 Apr 2022 18:10:51 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KWt4q0kGCz1Rvlx;
        Sun,  3 Apr 2022 18:10:50 -0700 (PDT)
Message-ID: <a6a17a22-0cde-9c46-0cd7-127be2cd2792@opensource.wdc.com>
Date:   Mon, 4 Apr 2022 10:10:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220303034912.3615390-1-mario.limonciello@amd.com>
 <20220303034912.3615390-2-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220303034912.3615390-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 12:49, Mario Limonciello wrote:
> As the default low power policy applies to more chipsets and drives, it's
> important to make sure that drives actually support the policy that a user
> selected in their kernel configuration.
> 
> If the drive doesn't support slumber, don't let the default policies
> dependent upon slumber (`min_power` or `min_power_with_partial`) affect the
> disk.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Mario,

Can you resend a rebased version of this, on top of libata for-5.19 branch ?

> ---
> Changes from v1->v2:
> * Move deeper into codepaths
> * Reset to MED_POWER rather than ignore
>   drivers/ata/libata-sata.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 071158c0c44c..0dc03888c62b 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -13,6 +13,7 @@
>   #include <scsi/scsi_device.h>
>   #include <linux/libata.h>
>   
> +#include "ahci.h"
>   #include "libata.h"
>   #include "libata-transport.h"
>   
> @@ -368,10 +369,20 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>   		      bool spm_wakeup)
>   {
>   	struct ata_eh_context *ehc = &link->eh_context;
> +	struct ata_port *ap = link->ap;
> +	struct ahci_host_priv *hpriv;
>   	bool woken_up = false;
>   	u32 scontrol;
>   	int rc;
>   
> +	hpriv = ap->host->private_data;
> +	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
> +	  !(hpriv->cap & HOST_CAP_SSC)) {
> +		dev_warn(ap->host->dev,
> +			"This drive doesn't support slumber; restting policy to MED_POWER\n");

Typo here: s/restting/resetting. Also, s/doesn't/does not.

> +		policy = ATA_LPM_MED_POWER;

Here, shouldn't we use the default policy defined by 
CONFIG_SATA_LPM_POLICY ?

> +	}
> +
>   	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
>   	if (rc)
>   		return rc;


-- 
Damien Le Moal
Western Digital Research
