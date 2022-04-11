Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FB4FBCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbiDKNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243841AbiDKNNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:13:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2327533A24;
        Mon, 11 Apr 2022 06:11:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j9so18466223lfe.9;
        Mon, 11 Apr 2022 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZurpZPH9/XvTV+q28AqNPKo8HpQJeOPWU72XXWgoA7I=;
        b=mdHpR4mlvLLNHx2AIL60gDkyRDKy5lawfs1NMaLHX8JLolamJQ670QeeOLFjBXmM7F
         oGS5bvQsOYzR/RxeqDPGkgnKHUggGHucVLLYQyLTpJHXwtxrBIepbd8wrnGNfRRcixGz
         UHgcy25T8emd1g1/h7Woom8k2y05zOO3jUviDiY1/P9wDTVi2PiDNmclre/i3593JLAF
         1hMhEkQy3FJDGQtlxnR70WhOaNjKr985UoolK6xKjwsWMCU933C6DYnxWwOKMoAAxRFY
         IWe6cyCdVaWGIHCC9MVJbwGb2FLtXoVdy1YVy/RC/4xVo1sdpmYcCu6fPGWhump+dt+Y
         LLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZurpZPH9/XvTV+q28AqNPKo8HpQJeOPWU72XXWgoA7I=;
        b=8Q6qpv4d8P0Tf9Ib7EgucmqN+njzjzE5Etpq/nbu8bJa919/JVhWhDNhWiD7yh3z2i
         ddfODXr10MwFZfmRYyWeEyvYb+bXA77WmtoCddyWhN3UnZ8r4F4zVv5TUi9cZLjMdVQw
         il1qBgwE+7s5K0xpVklkagQ74Ie4kqNvQR/jg66OU6y0NgclDy1cMh4pHzd3V9d3S6/S
         ce819+l4saj2icwXwCdHVVfaWAxS3OaujjXWIgfpsIe5AmILnLfh+ubgzsMAKjt60hBx
         mWw1cGZOixFCEbe4KVNeklXx4IVp0YRU0ag3QMH4+M7tMT3mgNrB3usmHlgaQc4RuVX7
         ar0A==
X-Gm-Message-State: AOAM531NKc6V8haW8Yfez1qDvakbzPo58cpazi2v4Vs5ajkWowrf4WtX
        xKvkHOMomv2CcFtKBINoY1g=
X-Google-Smtp-Source: ABdhPJzZE4i/TCOQCxwZeUhsIX3TA/RYQPovK58tHRtgSzjaf6SdwCbjKTbbB7guFXEa5oBIRKcdOw==
X-Received: by 2002:a05:6512:2301:b0:44a:394e:2add with SMTP id o1-20020a056512230100b0044a394e2addmr21439210lfu.177.1649682659878;
        Mon, 11 Apr 2022 06:10:59 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id c3-20020a2e9d83000000b0024b5382fef9sm982072ljj.71.2022.04.11.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 06:10:59 -0700 (PDT)
Date:   Mon, 11 Apr 2022 16:10:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/21] ata: libahci_platform: Sanity check the DT child
 nodes number
Message-ID: <20220411131057.c62c3jrfcyc55del@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-8-Sergey.Semin@baikalelectronics.ru>
 <ab7f2a2e-0ca9-ed97-e4ed-bf8ef0ed69a5@opensource.wdc.com>
 <d651ccef-1ba6-3063-66d8-410b5517cc3d@omp.ru>
 <a2597470-8998-92a4-8085-0503974ce237@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2597470-8998-92a4-8085-0503974ce237@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 05:13:45PM +0900, Damien Le Moal wrote:
> On 3/24/22 17:12, Sergey Shtylyov wrote:
> > On 3/24/22 4:40 AM, Damien Le Moal wrote:
> > 
> >>> Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that
> >>> critical from the further AHCI-platform initialization point of view since
> >>> exceeding the ports upper limit will cause allocating more resources than
> >>> will be used afterwards. But detecting too many child DT-nodes doesn't
> >>> seem right since it's very unlikely to have it on an ordinary platform. In
> >>> accordance with the AHCI specification there can't be more than 32 ports
> >>> implemented at least due to having the CAP.NP field of 4 bits wide and the
> >>> PI register of dword size. Thus if such situation is found the DTB must
> >>> have been corrupted and the data read from it shouldn't be reliable. Let's
> >>> consider that as an erroneous situation and halt further resources
> >>> allocation.
> >>>
> >>> Note it's logically more correct to have the nports set only after the
> >>> initialization value is checked for being sane. So while at it let's make
> >>> sure nports is assigned with a correct value.
> >>>
> >>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>> ---
> >>>  drivers/ata/libahci_platform.c | 16 +++++++++++-----
> >>>  1 file changed, 11 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> >>> index 4fb9629c03ab..845042295b97 100644
> >>> --- a/drivers/ata/libahci_platform.c
> >>> +++ b/drivers/ata/libahci_platform.c
> >>> @@ -470,15 +470,21 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >>>  		}
> >>>  	}
> >>>  
> >>> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
> >>> -
> >>>  	/*
> >>> -	 * If no sub-node was found, we still need to set nports to
> >>> -	 * one in order to be able to use the
> >>> +	 * Too many sub-nodes most likely means having something wrong with
> >>> +	 * firmware. If no sub-node was found, we still need to set nports
> >>> +	 * to one in order to be able to use the
> >>>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
> >>>  	 */

> >>> -	if (!child_nodes)
> >>> +	child_nodes = of_get_child_count(dev->of_node);
> >>> +	if (child_nodes > AHCI_MAX_PORTS) {
> >>> +		rc = -EINVAL;
> >>> +		goto err_out;
> >>> +	} else if (!child_nodes) {
> >>
> >> No need for "else" after a return.
> > 
> >    You meant *goto*? :-)
> 
> Yes :) No need for the else after goto.

Personally I prefer having the chained if-else-if-else-etc statement
in such cases from readability and maintainability points of view (it
makes the code reader to more easily perceive that all the variable
value ranges are covered with no reference to the if-else clause
statements). But in this particular case dropping the else word lets
us to convert the afterwards statement into a single line
+	hpriv->nports = child_nodes ?: 1;
So why not. I'll drop 'else' from there then.

-Sergey

> 
> > 
> > [...]
> > 
> > MBR, Sergey
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
