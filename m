Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEC659B531
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiHUPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiHUPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:46:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD81DA67;
        Sun, 21 Aug 2022 08:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECAD8B80923;
        Sun, 21 Aug 2022 15:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B632C433C1;
        Sun, 21 Aug 2022 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661096773;
        bh=8z0FUf5EZEBYCtClKGnP2GetQ1AGqbtC2TykMCaCWY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sk/lPly6AJBSjFq3aL/eNUJv7wYlQIdrBMASFzb9M4dURbbkL/Banh67WbHoEj7c1
         fca1WPkl0jOC20WPDkLefz2XJqyx9tmluq5pFPn3gDQqxbSP5O2ouxQrJTP7HBs10B
         /FjQw/4NtsAzZ4UbitzH3m8Bb24UvnRyVSxtBj45Adk8QY0j3MByBayAle8LkwZbcL
         pqjlOV/p2IewkziPftq1cfeX0z5hGOEevcttmp+jr7L3EfRuNLa2eNGlkyJLhACu9j
         xpVTjg9BpWNCDmqEToZrt8FcMilDQTRbJQGU55B6XyTEANs/+qSQzHN6kruJnh2C1m
         hd0FcTTYroQ2Q==
Received: by pali.im (Postfix)
        id 86CAA828; Sun, 21 Aug 2022 17:46:10 +0200 (CEST)
Date:   Sun, 21 Aug 2022 17:46:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (dell-smm) Improve warning messages
Message-ID: <20220821154610.e2fokkqzytoqm2ba@pali>
References: <20220821151713.11198-1-W_Armin@gmx.de>
 <20220821151713.11198-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821151713.11198-4-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 August 2022 17:17:13 Armin Wolf wrote:
> When dell-smm-hwmon is loaded on a machine with a buggy BIOS
> with the option "force" being enabled, it wrongly prints
> what the buggy features where disabled. This may cause
> users to wrongly assume that the driver still protects them
> from these BIOS bugs even with "force" being enabled.
> Change the warning message to avoid such a misunderstanding.

Should not there be also FW_BUG too?

I'm thinking more about message, would not it be better to print also
information if fan support and fan type call is allowed or disallowed
(based on force argument) when broken BIOS is detected?

> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index f7bab1a91b93..bf13852afe48 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1354,13 +1354,13 @@ static int __init dell_smm_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, data);
> 
>  	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
> -		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan support\n");
> +		dev_warn(&pdev->dev, "BIOS has broken fan support\n");
>  		if (!force)
>  			data->disallow_fan_support = true;
>  	}
> 
>  	if (dmi_check_system(i8k_blacklist_fan_type_dmi_table)) {
> -		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan type call\n");
> +		dev_warn(&pdev->dev, "BIOS has broken fan type call\n");
>  		if (!force)
>  			data->disallow_fan_type_call = true;
>  	}
> --
> 2.30.2
> 
