Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB5C54FED6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382641AbiFQUhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382325AbiFQUfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:35:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7756C5E762;
        Fri, 17 Jun 2022 13:34:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id be31so8522091lfb.10;
        Fri, 17 Jun 2022 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vDd9GRNgXOH4DRh4h4tsEZAUpzvs2GX7UG6ZUxEQU3I=;
        b=lw8A+ey8OiVQ6R8WpbnJEVWi2qreXkw2WJNoZmz9mrILvv42LKWsMb7XfHPbGF9t1c
         aM3PNDZyWMQ+O8On7hKVB/FWNICsdCCPH4Zf4mAHaJqOffK+iNJ0VgzuF1jJXmj3r7Ke
         jJXjuuzdSQVZNLzKeFUOyGNy3PDHO5R1syZRs9a9w2GdCzeOgPgpAWtlYuFH+6oTa7ef
         D8xWauC9rIl61rReFFi6yEwtRugJqqVjZLvIFJVWv2fsnetilEVMP5xbMV86q1V9fRPM
         uFDK3guhTxy4EoRrhTafWPxebRAakvV0pz7ueL707ewiFUPZdhwL/T+90Y+mKMdyaKoU
         /aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vDd9GRNgXOH4DRh4h4tsEZAUpzvs2GX7UG6ZUxEQU3I=;
        b=ODFRSKQlvN4wEYtOWveA8BqECciRqUzynFWmNt/LsNjMXK+TS8vuHL3lSWEpkKIcKA
         BrQe5Hbnm0J0iWnnLHNlRLRLWw0uFvsxMTvQKcpTr2MBVzvtMNplRFUdg5g2Y+lPfmKZ
         VQNhQiCiINKaSdr/PesRi8Rean457qGOaBTWZ8fBY6kS++3QTQEQwNMwmSqSND2uo05x
         KHpGAbcnlZp1CRZ/AKVC99yLvMaA60BfYipZR+uXZcICRFC84pJL4S10XsAfYDYZn7DV
         izmwFE2PztTR05+sJFnFegxojA/J69R0NNew4c0uG8/QqsXzlJQPQPJwvQI32699BqsK
         qzRg==
X-Gm-Message-State: AJIora/G3kuPTgGymbhIdWoPGGdkqCcxoZElqsrRTgkriktE4U9VC6wt
        TAKHO/r8Vg4F+lMQ7EpVeu89dzB6CCYpzhJz
X-Google-Smtp-Source: AGRyM1tQRBiE4Z/onR34yRi4gEu5sqX+Q3/+fniA0+YaHZH6w7FIKnCTx20qlAJqho6h+DruXtFlSw==
X-Received: by 2002:ac2:4e10:0:b0:479:2160:623e with SMTP id e16-20020ac24e10000000b004792160623emr6457849lfr.602.1655498061849;
        Fri, 17 Jun 2022 13:34:21 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id h13-20020a19ca4d000000b0047dbff43a7dsm752862lfj.63.2022.06.17.13.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:34:21 -0700 (PDT)
Date:   Fri, 17 Jun 2022 23:34:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Message-ID: <20220617203419.ksoald7am3677csh@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
 <52c9ca79-769f-4426-db94-7aad05a68258@opensource.wdc.com>
 <20220615214802.ke6owp5cuv5l77hu@mobilestation>
 <5f1edbd8-018a-bcd0-10f2-94767f341b45@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f1edbd8-018a-bcd0-10f2-94767f341b45@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:33:22AM +0900, Damien Le Moal wrote:
> On 2022/06/16 6:48, Serge Semin wrote:
> [...]
> >> MODULE_LICENSE("GPL v2");
> >>
> >> To match the file header SPDX.
> > 
> > No. Please see the commit bf7fbeeae6db ("module: Cure the
> > MODULE_LICENSE "GPL" vs. "GPL v2" bogosity") and what checkpatch.pl
> > says should the "GPL v2" string is used in the module license block.
> > More info regarding this macro and the possible license values are
> > described here:
> > Documentation/process/license-rules.rst
> 

> ah ! OK. I was not 100% sure. Doing a quick grep, there is still a lot of (half
> ?) of "GPL v2" vs "GPL".
> 
> Ignore this then.

Ok.

-Sergey

> 
> > 
> > -Sergey
> > 
> >>
> >>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> >>> index 9b56490ecbc3..8f5572a9f8f1 100644
> >>> --- a/drivers/ata/ahci_platform.c
> >>> +++ b/drivers/ata/ahci_platform.c
> >>> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> >>>  static const struct of_device_id ahci_of_match[] = {
> >>>  	{ .compatible = "generic-ahci", },
> >>>  	/* Keep the following compatibles for device tree compatibility */
> >>> -	{ .compatible = "snps,spear-ahci", },
> >>>  	{ .compatible = "ibm,476gtr-ahci", },
> >>> -	{ .compatible = "snps,dwc-ahci", },
> >>>  	{ .compatible = "hisilicon,hisi-ahci", },
> >>>  	{ .compatible = "cavium,octeon-7130-ahci", },
> >>>  	{ /* sentinel */ }
> >>
> >>
> >> -- 
> >> Damien Le Moal
> >> Western Digital Research
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
