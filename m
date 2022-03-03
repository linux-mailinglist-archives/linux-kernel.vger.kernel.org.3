Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9354CBAB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiCCJw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiCCJwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:52:54 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E15179248
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646301128; x=1677837128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q8qxz42HaO+JR55NT5n/z+nUeTPKq/2B9ARU+jmiFTI=;
  b=qY/FcimnuWBOb+s0wGwglAdoJg7R2sO05mdBB6qDTz15bcTBdhMOyD8r
   aiNrpYh8QgHPfgLArlffCNh0hlB1E6LGVIE3o+v55V+nGRwvz6EEb9mRI
   xEmCqZJdyrbKiUSD4tRRhr7v4vcPBeINIx5LcI1Nlxo+j8e2gV56g+3QS
   kl2sopyKru9/OKLdDMu61iIAdfzLkHy5o7ipV+MUySET+WG3kTJcohheU
   Pxa7dCwM+2xvwYTZ9pedw5Z3fcMHz2Os90DY5WctfYJroT2hEb/Rbyqor
   3MXfbwJUXA+xhqJ6O8GuyYqvo8jNAxnLZjm2A9vZs6eInirKNgR06QVlk
   w==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="199215164"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 17:52:07 +0800
IronPort-SDR: Y0C+5tsbV4LJZj6jlURG66g6iGtElKH4iHmnonMIttJvfE8jdkitMNZGemJs2dqyS01/JX4WHf
 pCSIgoNV7nugFK4/kUjtLYhULi0PXXVGHyxXS3vhh58Rta9J6TbIkzrnuTsDcSYYrmAWGPCvmX
 w73UEeHGu4J0AyWcdyY6EZrGCz8nHk+PYcQhiMCRpULKhG+T2NEF5L5K8NbjG3bPJUbT4FV4ud
 HWd2bRVO+tDYcmAnk1+8OdQ+kUBnPA+JtJrJXqURIRS8+gjKGcupKO7paRpLalOihr01HJ2woO
 uwjr9OUJHA8DjraUafwPHzn8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 01:23:30 -0800
IronPort-SDR: 0UeLeTFhBEP6nN1IiGQotSuBfOQYRBGm/4swLDgWFK5M4bzHXSDtGXmPvKja9XNKpctniGN/mz
 xDxSohRHSnWm9jGKK51Oj+okLnVSsGDdAwWJeJRvXZhRBY3bjrqfcb0Y/SAJUmh2w1GJj3XEIn
 7NldDNZ7tNaAbeuydKF58DGcqgpi5oI9Zw0BgVK3n0aIdHUX4iWXAaiSazBTwTMraJTAdZDD+3
 NUdC8znohdnizL1AiD6rZKip99PkISOeCu0jBGdZGUNEf/gcTI8yXKr07X3vRib6jV/YRRxTnV
 P9s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 01:52:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K8R932JBLz1SVny
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:52:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646301126; x=1648893127; bh=q8qxz42HaO+JR55NT5n/z+nUeTPKq/2B9AR
        U+jmiFTI=; b=V95OPQWNQJcum+7QVTyr3LqR0oYpKPCX0pH0GMuL9NEH5Y37bTf
        yQ4BPBql5jyCK8tNMqh8nWSM0J9qDzhs9cCZu65O0N3R5biJIA7eq2x2skRlHMFx
        6xXI4Lnc5IHpdfvw5Tc+ddFTrOE7DVmG2iArozgwq/dSCMaXWF4F+jUFKcFeruZa
        MRkFiDujZkLJ0cDnB9BnUtFBM1bvQbLy2eXQ597ktlmXPEWEzf3zxSbhjQx9S4E+
        M/wbvMKdpaMW5vUR0m2kx339uA3Dzd1DtM2MowSt48aHxZbyPNHA0wzppNJkiOe/
        uYITJcr7NNTqArVrSTscAW4FF21QFGVDVSA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id csbWqRvD9k2O for <linux-kernel@vger.kernel.org>;
        Thu,  3 Mar 2022 01:52:06 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K8R914Prlz1Rvlx;
        Thu,  3 Mar 2022 01:52:05 -0800 (PST)
Message-ID: <3a8c29c7-515f-6e0e-323c-b2b00a9f9d8c@opensource.wdc.com>
Date:   Thu, 3 Mar 2022 11:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/03 5:49, Mario Limonciello wrote:
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
> Changes from v1->v2:
> * Move deeper into codepaths
> * Reset to MED_POWER rather than ignore
>  drivers/ata/libata-sata.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 071158c0c44c..0dc03888c62b 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -13,6 +13,7 @@
>  #include <scsi/scsi_device.h>
>  #include <linux/libata.h>
>  
> +#include "ahci.h"
>  #include "libata.h"
>  #include "libata-transport.h"
>  
> @@ -368,10 +369,20 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  		      bool spm_wakeup)
>  {
>  	struct ata_eh_context *ehc = &link->eh_context;
> +	struct ata_port *ap = link->ap;
> +	struct ahci_host_priv *hpriv;
>  	bool woken_up = false;
>  	u32 scontrol;
>  	int rc;
>  
> +	hpriv = ap->host->private_data;
> +	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
> +	  !(hpriv->cap & HOST_CAP_SSC)) {

Weird indentation.

> +		dev_warn(ap->host->dev,
> +			"This drive doesn't support slumber; restting policy to MED_POWER\n");

Typo. I would change this to:

"This device does not support slumber; defaulting to MED_POWER policy\n"

> +		policy = ATA_LPM_MED_POWER;
> +	}
> +
>  	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
>  	if (rc)
>  		return rc;


-- 
Damien Le Moal
Western Digital Research
