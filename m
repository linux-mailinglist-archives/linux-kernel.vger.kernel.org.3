Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713A552528B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352838AbiELQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiELQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:29:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC760BB7;
        Thu, 12 May 2022 09:29:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx33so7146734ljb.12;
        Thu, 12 May 2022 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gLe5l9DAolzLphi8/wPvIZln9njciDHas8G30cxiyRE=;
        b=f+myMvIiz2tjwVtbg/kwFeqyRkKhEUyloCObDSYMuAm4tqelGuM/cpPuvE4abEDHe+
         qm+HgiUExaRlIQs4cDQUnEvlh0RUFpxHKSURPyRKEAeQf2AP1iZi8x5Xh8Y3roofRHAD
         2iAu3rnA6ggRtCqTCdqaf6WWpko4Q+Rv7Fs1zgnuSkUAmpz6Nc9O7glhWXixIZvYDQvi
         dQAuRaRUmMj2HLxwtdL+K/g+gfjKPQ80Ai4pn7i/Akk1wptzy9c3TTk5X25l989641OK
         o0V5oLpfH9KkNs6aoRfAFtdf0KYaTOTT4YZiK4wAQIH0I9Uhozm4kuEg3jnUedPuiWd8
         TNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gLe5l9DAolzLphi8/wPvIZln9njciDHas8G30cxiyRE=;
        b=O9BpZomNF3I+8+2yd85mQPlAHpnLXt1+wnGOPJUHcQUfSRGGLFbkIolUSdVuZehCtS
         NPnN4ysNBw9DyZpd1F5vR/aof4crECHraK8aZDoZ4IeIfhAo/xBWtj4mvXHn15DWIgJK
         gaAkAVYfKZsJhHn3sSsrFWiUNWTtmwVO8xG98H9TWsgoqQjv649uIANwxZcCAuV+hE/l
         ZdXAoikDgFnC6u8NbQnTPkLooeqyBSUe84erwHxO7nmIvQIn2n2ncaEndSilOk3C2UEG
         PvHeiKrkp3PeKA/6/D3PXNjcltkWuoD28JXYbkRTqxyACnp5OfghmLsymEH02JCEk9WP
         fXMQ==
X-Gm-Message-State: AOAM531NJTIKtGNXVFW10FxSNyySCbgpDhhb2nkVgNZde1iQN3TW/Avf
        rnVJj40L3YAkzUiNFZY0SIQapEyJsLIDDA==
X-Google-Smtp-Source: ABdhPJw9rrsJElQQstE2Px12+IH9oT7SX+diGL9CcP696w8ibA9VJFrOK2y6+hnOk766xAI059XEXw==
X-Received: by 2002:a2e:9556:0:b0:24f:1c4f:cade with SMTP id t22-20020a2e9556000000b0024f1c4fcademr496981ljh.39.1652372946377;
        Thu, 12 May 2022 09:29:06 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id n11-20020a05651203eb00b0047255d211adsm2738lfq.220.2022.05.12.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:29:05 -0700 (PDT)
Date:   Thu, 12 May 2022 19:29:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 21/23] ata: ahci-dwc: Add platform-specific quirks
 support
Message-ID: <20220512162903.ehqrbqm5wngznwjl@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-22-Sergey.Semin@baikalelectronics.ru>
 <f89f34e6-eb04-4ed4-0323-292c2e332948@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f89f34e6-eb04-4ed4-0323-292c2e332948@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:12:46AM +0200, Hannes Reinecke wrote:
> On 5/12/22 01:18, Serge Semin wrote:
> > Some DWC AHCI SATA IP-core derivatives require to perform small platform
> > or IP-core specific setups. They are too small to be placed in a dedicated
> > driver. It's just much easier to have a set of quirks for them right in
> > the DWC AHCI driver code. Since we are about to add such platform support,
> > as a pre-requisite we introduce a platform-data based DWC AHCI quirks API.
> > The platform data can be used to define the flags passed to the
> > ahci_platform_get_resources() method, additional AHCI host-flags and a set
> > of callbacks to initialize, re-initialize and clear the platform settings.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Change the local objects prefix from 'dwc_ahci_' to 'ahci_dwc_'.
> >    (@Damien)
> > ---
> >   drivers/ata/ahci_dwc.c | 52 ++++++++++++++++++++++++++++++++++++++----
> >   1 file changed, 48 insertions(+), 4 deletions(-)
> > 

> This really could be merged with patch 19; as you're adding a new driver you
> might as well fold this patch in to avoid further modifications.

That merely depends on the development approach. I saw and reviewed
not one kernel patchsets introducing new drivers and adding features
one after another. Moreover there is no kernel patches requirement
which would constitutes not to do so. In this particular case the
modification isn't complicated at all thus can be reviewed as is.

-Sergey

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		           Kernel Storage Architect
> hare@suse.de			                  +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
