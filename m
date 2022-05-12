Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7CE524CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353768AbiELMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353770AbiELMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:31:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200804AE09;
        Thu, 12 May 2022 05:31:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m23so6342085ljc.0;
        Thu, 12 May 2022 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1nGNpikUs8vk4+aJD/NKpap25jqeBIDRUKybH2Zwqok=;
        b=E4oAmZY4A0ZUSqx3z+F0WjMqHKJSpUkcD683dWO7uCrk1433e1ylnPkIEdJ3n8tv9d
         QFyQQsx72iG73vT3HWD1rKAiXNEcjQWAQxeGKXpmmFQ41loK8I74ot5D7OvPPtFyqlGb
         UR83VoKixoJGUjzGuNgKFTBGLcZxvJjfiDas74G9q8v3CjG/8e6UggEB9RcpvsGWLlyI
         9VG7hHaswyeZt31MVo1xLcFYYIja6fxXUVMqJCCBVpRgFkbeD8E9iEWV/jMNiCnqMsxJ
         JLySwvfm0P0333AvGCcLm54fau8RZPwSziskG2cIOxGlQ4BCSh3ptU+vy+xKEfwcch0r
         tZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1nGNpikUs8vk4+aJD/NKpap25jqeBIDRUKybH2Zwqok=;
        b=DMdvVXqKOXt7itawx5J915+bXmS16EKEo/F6QUgHyPHz4TzQBbxuHFYeLz/JRdFMbE
         GzKP5IeFNEKglN4jkzcKWsTAqAkLRN+Cf2Gbv+WYfSXXdjce5rS8dvMRGv3njAFYVZil
         ZmhW/QUOCRk3p2b1VTnEK9OMXsJ26oAxK8pIO12AKuxOLsSbRf4TKuoioHloW0Yby1+7
         GXnGmHV/HYh1Htv5a8HF8MIsQ27gwOCIsydiU2iDawnWnlvPAwLLWBiIlOc7vnbT7r2D
         bzg2WOIIp08evh0+IK0FfccoT2jQR7ifNzqQYKNjy1U9jDBVoTBcuYt9NkEfpsdHLsnj
         D6LA==
X-Gm-Message-State: AOAM530Ex4WcvReUXlU5OVO3foMUdQSed5z9PqeNcpRmMtX0tnmX5CWV
        1vnKX1Xf13uyKafsa0W1+aA=
X-Google-Smtp-Source: ABdhPJzWOhBlKh2AZ9FLigPh2HroCkxI1czqj30olnv2HQZTPhPzwsTMmKpIgl47dJKBJ34Hg+QrEA==
X-Received: by 2002:a2e:82c3:0:b0:250:c47e:c3ab with SMTP id n3-20020a2e82c3000000b00250c47ec3abmr13518987ljh.393.1652358709589;
        Thu, 12 May 2022 05:31:49 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b0047415cd1ec3sm766340lfe.165.2022.05.12.05.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:31:48 -0700 (PDT)
Date:   Thu, 12 May 2022 15:31:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 05/23] ata: libahci_platform: Explicitly set rc on
 devres_alloc failure
Message-ID: <20220512123146.zkuftdu7fm26r6mp@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-6-Sergey.Semin@baikalelectronics.ru>
 <4bd4318b-a753-6453-a815-716fbfffab3f@suse.de>
 <9a1ad8f4-7f60-a941-940d-eca00b1f533b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a1ad8f4-7f60-a941-940d-eca00b1f533b@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:32:42PM +0200, Damien Le Moal wrote:
> On 2022/05/12 8:27, Hannes Reinecke wrote:
> > On 5/12/22 01:17, Serge Semin wrote:
> >> It's better for readability and maintainability to explicitly assign an
> >> error number to the variable used then as a return value from the method
> >> on the cleanup-on-error path. So adding new code in the method we won't
> >> have to think whether the overridden rc-variable is set afterward in case
> >> of an error. Saving one line of code doesn't worth it especially seeing
> >> the rest of the ahci_platform_get_resources() function errors handling
> >> blocks do explicitly write errno to rc.
> >>
> >> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>
> >> ---
> >>
> >> Changelog v2:
> >> - Drop rc variable initialization (@Damien)
> >> ---
> >>   drivers/ata/libahci_platform.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> >> index 32495ae96567..f7f9bfcfc164 100644
> >> --- a/drivers/ata/libahci_platform.c
> >> +++ b/drivers/ata/libahci_platform.c
> >> @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >>   	struct ahci_host_priv *hpriv;
> >>   	struct clk *clk;
> >>   	struct device_node *child;
> >> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> >> +	int i, enabled_ports = 0, rc, child_nodes;
> >>   	u32 mask_port_map = 0;
> >>   
> >>   	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> >> @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >>   
> >>   	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
> >>   			     GFP_KERNEL);
> >> -	if (!hpriv)
> >> +	if (!hpriv) {
> >> +		rc = -ENOMEM;
> >>   		goto err_out;
> >> +	}
> >>   
> >>   	devres_add(dev, hpriv);
> >>   

> > I disagree.
> > As 'rc' is now only initialized within a conditional we're risking 'rc' 
> > will be left uninitialized.

That's what I told to @Damien in v1.

> > And in the end, it's a matter of style; this patch doesn't change the 
> > flow of events and the benefits are hard to see.

As a first time reader of the module I've saw them. It was hard
to comprehend right from the code context whether rc was properly
initialized especially seeing there are so many local variables
defined. Unified rc-initialization approach makes code easier to read
for sure. In this case the rc variable is re-initialized in each
error-case. So having it defaulted to a value which is relevant to the
code block in the twenty lines below isn't the most optimized design.

> 
> Yes. Let's drop this patch. Not improving anything.

It's up to you to decide after all. Even though I disagree with your
opinions the patch will be dropped in v4.

-Sergey

> 
> > 
> > Cheers,
> > 
> > Hannes
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
