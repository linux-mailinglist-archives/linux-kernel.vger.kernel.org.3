Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB97153CCF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbiFCQKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343635AbiFCQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:09:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441D2CCB6;
        Fri,  3 Jun 2022 09:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9211B82371;
        Fri,  3 Jun 2022 16:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D5CC385A9;
        Fri,  3 Jun 2022 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654272593;
        bh=ktWgG1/7y93sK7zzHW+CpS8gPfNRHYR0DXoQkI/lC3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t3cO7fofzPVq+NXJhff0m7x9HkyS8/55HU7dxXhlawdtoB57uEar4v/WBKUpn8unf
         NIEKTi5yAER/6a2O1S+aVKpChPHbnDo/CmX9sUpwPOx4QvHvdL8GSQP+qRSzGRoZk4
         icd1w14DGrz7R0MBJO7y9ncf08XOdZ+NyODKnrUyni61QKNvQ31eMlOgLyjT5ZOugZ
         fhpgnlx0Y7vOXV5YIDh9XiLUcw77DBJDflNYCl6IvzygDT+ngCGlzkd7sLWuIL2UH3
         pt1aMCE188Mc9QTyG5bViSUZsQ20gq46+3KWviT/nRUYyJV07hizrMo8jSRKk4bcFO
         kCW1sKSp8jaYw==
Date:   Fri, 3 Jun 2022 17:18:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 3/3] iio: adc: meson_saradc: Use temporary variable
 for struct device
Message-ID: <20220603171852.1f4c727f@jic23-huawei>
In-Reply-To: <CAHp75VcSFr+E7_woyw6jx7e9wCeFUUouV_7xJXYO26_y6=fwTQ@mail.gmail.com>
References: <20220602114241.12601-1-andriy.shevchenko@linux.intel.com>
        <20220602114241.12601-3-andriy.shevchenko@linux.intel.com>
        <ad3af033-97f1-3aad-d082-c6ed56185b59@metafoo.de>
        <CAHp75VcSFr+E7_woyw6jx7e9wCeFUUouV_7xJXYO26_y6=fwTQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 15:45:27 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 2, 2022 at 2:08 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 6/2/22 13:42, Andy Shevchenko wrote:  
> 
> ...
> 
> > > -     priv->adc_clk = devm_clk_register(&indio_dev->dev, &priv->clk_gate.hw);
> > > +     priv->adc_clk = devm_clk_register(idev, &priv->clk_gate.hw);  
> >
> > You are not changing anything here.  
> 
> The scope of patch is supposed not to change the current behaviour :-)
> 
> > But we shouldn't be devm'ing on the
> > IIO device. It will get freed eventually, but only when the last
> > reference to the iio device has been dropped, which might be long after
> > the platform device has been removed. devm'ing should happen on the
> > platform_device's device. Might be worth fixing.  
> 
> Thanks for confirming my suspicions (as I mentioned to Martin, using
> an IIO device there feels wrong).
> I will add another patch to v3.
> 

I thought that the iio_dev ends up holding a reference to the platform
device dev so the parent would only be released if the child had already been,
but I may well be wrong on that. 

Either way I don't mind it being tidied up.

Jonathan


