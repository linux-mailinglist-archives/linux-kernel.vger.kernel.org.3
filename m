Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D431654AE02
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiFNKMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiFNKMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2717A22BC9;
        Tue, 14 Jun 2022 03:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3D9860AEA;
        Tue, 14 Jun 2022 10:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C89FC3411B;
        Tue, 14 Jun 2022 10:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655201553;
        bh=OU/NN+viO7AEHR96HAV2XGs7BeFoWc8CIQP0hQgj6vU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N0h9lZRJmQuixNqG6kalxSCRX53PXSuiPfVYsOlhI8XrzjFCEBMrsy427hsL/bzUa
         nM/e5pkmu6fOdd7zZJTwHbjipGLTPtj191vmJi/3aFaGrbPAzTwxyKm2iRCLcIU4P5
         0W1UPsirm5b3jLJLQB5nO2oAe2mFBBx/Uxy+Ut72hOrEDS0zluBfBV10ussQJFdX5k
         YC3oJC7l13zFtvUvhHcc7y9kQbsx+etzhD9zmWelnUdASAmKnOL5nRgoZOVWi7V8El
         Oa7P6VbFTmnCbRdpuHJEMoV3JbqmnxOFqlImK18KaWBdDghwG+7RM7Azl4aKS0gGky
         1GJdoKQuuR7Rw==
Date:   Tue, 14 Jun 2022 11:21:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 1/6] iio: adc: meson_saradc: Don't attach managed
 resource to IIO device object
Message-ID: <20220614112142.3eb70a8d@jic23-huawei>
In-Reply-To: <Ypo80/NpWLLP43jm@smile.fi.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
        <20220603170612.561edfbf@jic23-huawei>
        <20220603172307.5d2f3c52@jic23-huawei>
        <20220603172920.3239bbd6@jic23-huawei>
        <Ypo80/NpWLLP43jm@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 19:54:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Jun 03, 2022 at 05:29:20PM +0100, Jonathan Cameron wrote:
> > On Fri, 3 Jun 2022 17:23:07 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> ...
> 
> > Andy, put a cover letter on these larger series - if nothing else it gives
> > somewhere convenient for people to give tags for the whole series, or 
> > maintainer to say what they are doing with it.  
> 
> I'll try to remember this. The series was started from only a couple of patches
> and grew to this big, and I forgot to add a cover letter when it seems not
> anymore obvious what has been done.
> 
> > Anyhow, I'm fine with the series, but will leave it on list for a while
> > longer, particularly to get patch 6 some eyes + testing.
> > 
> > Currently I plan to drop the fixes tag from this first patch, but I'm prepared
> > to be convinced it's a bug fix rather than a consistency cleanup.  
> 
> Fine with me, thanks!
> 
Applied to the togreg branch of iio.git and pushed out as testing for all the normal
reasons.

Thanks,

Jonathan

