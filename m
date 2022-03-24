Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23A4E5C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbiCXBAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbiCXBAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:00:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E5BE08
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648083520; x=1679619520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OTBnl5Cs2iyIhyA4xwKnzLy274oypsjBtyCg7TPtK4s=;
  b=h1/qJpPZrkydQNNmhK+2kkRTwqJD5JydAuVvCVRFeBp2oaDpoBNMh+BO
   1UHtjoC6g2TnTddpF4B7soF+Ci/uh7fPc5NVaehNEYkqggF7Fy5Tf0JEr
   JvjFZdozeJ4ZVRv0RqwEALxkrYTmgKuBeRVf4aX0zF3ZdO+wUcfJwJd1f
   sout0uvH3J96RUa7y4GXpusmVYTxktQ3vCLN74UOWBM9bHKOgkRSSvVQr
   FGtIHZjtlYTkilA1HF8F/i0Qg3sglCKIvt7bT+agoERAfnmd/sZ4penja
   SPLE7i4qtquHwEiaStxqVRXVoc4mLFoKP1VSU+Kli+XtYaf8xronQMfLS
   g==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="300264251"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 08:58:38 +0800
IronPort-SDR: RPFNHDPLBhyFG0SiVlmeLSED9PwkpfbQcklPpuyDtjxOCYlMvj/7AyPF9QlA8a62h+Toe9exOY
 /FU4iubEWtpDNJS5ZpFtUhOkMfFDskilzAWiBxihIpKwAo9cb5u7feytB+RoXSLpsfgl+8C7O0
 Y0h4T0Ogwa0RaLxJTQf8i8QKnwfH/vR9VGvIZpDNw6WgvuQUXd44fQlLv8373U0mRUeRmiIYoS
 El/SdtXYvqALjmSOBOUYOl8nemUtUtLWnzvEBFylSmuE5QUqLhORCRkwHPiddUCOeE/G9FZjI9
 v+HuL+fae9prJhyajPD8JdoF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:30:31 -0700
IronPort-SDR: LKAJm25avN9IzWJx2+FqovjCbd4s2+4HtQq8l7YVLesi65kaYUatwTKYDSCOJntQYudubu6Tc5
 LWEDqF/Vo9Utv23vMzDwKZ6511vDqkzpzaVLdULMkvLKe492ymSvnSLWO4lumqUWq8iIvQcg/L
 RHtkY0sOzo62sATDtNBoGLDZ3R2EZEILXstfuRuRstTcGLpJH4sjLQO6Mk6xeMb80AR1MoZFD3
 YPUiYw/fnxvAOm8jj6QN2zcI+4mtK2SdYhCS4eT6xUgiATjE4TXYPRTMUtFqqAS2UY6GmUxzPO
 xLs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:58:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP6Kp2fNMz1SVp3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:58:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648083517; x=1650675518; bh=OTBnl5Cs2iyIhyA4xwKnzLy274oypsjBtyC
        g7TPtK4s=; b=rl0yHPhzOn7IhkdRtQt4dvoLgPKIMRnxDzb4OXrPrqNCcvhNvg1
        52d7VcIVnG1ujALfEOJmJu8BFwHxDMNyHbqG8seEJicX6SiPCPwAG8cyQ+Eixb4+
        IHWufkJa3sgVyJnYkNol2+DuYURUEQ2Rh1xoPYO3J8dIYzXk/Pj32frRWRhJaDZ5
        DdiWPAx83zNCWZfEG8SsFIHLRKBYU4tS7mnOZesdaU5VX1G3CeRubbEHemvXUqjO
        oWm+7IfrXlvl8RvaC8yXM8Ov8FcR0kJENrtXkKlFbDsGETwUl3JLOYTXLlR30nJx
        flXuWh26v0gZPpBz+COs1Q0j7QBRdL6RpGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kbgk9_R5Gpla for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 17:58:37 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP6Km0fgGz1Rvlx;
        Wed, 23 Mar 2022 17:58:35 -0700 (PDT)
Message-ID: <9128f850-fcc1-811e-b781-b7fbcb2403ba@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 09:58:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 03/21] ata: libahci_platform: Explicitly set rc on
 devres_alloc failure
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
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

On 3/24/22 09:16, Serge Semin wrote:
> It's better for readability and maintainability to explicitly assign an
> error number to the variable used then as a return value from the method
> on the cleanup-on-error path. So adding new code in the method we won't

No it is not. On-stack variable initialization is not free. So if
initializing the variable is not needed, do not do it.

> have to think whether the overridden rc-variable is set afterward in case
> of an error. Saving one line of code doesn't worth it especially seeing
> the rest of the ahci_platform_get_resources() function errors handling
> blocks do explicitly write errno to rc.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/libahci_platform.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 18296443ccba..1bd2f1686239 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	struct ahci_host_priv *hpriv;
>  	struct clk *clk;
>  	struct device_node *child;
> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> +	int i, enabled_ports = 0, rc = 0, child_nodes;
>  	u32 mask_port_map = 0;
>  
>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  
>  	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
>  			     GFP_KERNEL);
> -	if (!hpriv)
> +	if (!hpriv) {
> +		rc = -ENOMEM;
>  		goto err_out;
> +	}

If you set rc to -ENOMEM here, then the 0 initialization of rc is not needed.

>  
>  	devres_add(dev, hpriv);
>  


-- 
Damien Le Moal
Western Digital Research
