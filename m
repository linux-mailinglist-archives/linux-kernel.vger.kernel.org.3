Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6AD5925BC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiHNREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbiHNREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:04:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19585D50;
        Sun, 14 Aug 2022 10:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5FFFB80B77;
        Sun, 14 Aug 2022 17:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21287C433D6;
        Sun, 14 Aug 2022 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660496685;
        bh=/P+/y5T7E/iO62tMmf7CSjIs1wmxXta+jEI1b6cyvLM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EoVFyOMTO+26aIQf0hxmNlyexW4kLOOoZyrYQIS+9X6Pi0h3CKNEXi44xYAqKA4Gn
         MVjR5PBtVU/zvv6kVMkXaigJfpmPnu2kFEN0UfBcvWuXuLHxHDaLsgTCgXd6yy6ZVg
         aSOlRjnfPIXQDs4TvwxU15l6frXpIZwMXCvXnYJETxMOHf+/8Dkn2riFrATo888Rn6
         9rOXZJg6hBxCCEvh2oSbVsmzBq6hSeokNmEYxFAFpgznSC6zOU95LPe5q6YNr3nRXK
         oXiLqa96fn7NTa3GxGTffrhW/+LQUZ65VzW2diMUDE+QSEBonaJHndRMIOcVRtFtRT
         z6u/v1sQWf9Sg==
Date:   Sun, 14 Aug 2022 18:15:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: pressure: dlhl60d: Don't take garbage into
 consideration when reading data
Message-ID: <20220814181514.3fe1107c@jic23-huawei>
In-Reply-To: <20220731133357.5705df25@jic23-huawei>
References: <20220726142048.4494-1-andriy.shevchenko@linux.intel.com>
        <20220731133357.5705df25@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 13:33:57 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 26 Jul 2022 17:20:48 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Both pressure and temperature are 24-bit long. Use proper accessors
> > instead of overlapping readings.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> Looks correct to me, but it made me scratch my head just enough that I'd
> like Tomislav to take a look if possible.  So give me a poke if this
> hasn't progressed in a few weeks time.

Long enough.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/pressure/dlhl60d.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
> > index 5f6bb3603a8b..f0b0d198c6d4 100644
> > --- a/drivers/iio/pressure/dlhl60d.c
> > +++ b/drivers/iio/pressure/dlhl60d.c
> > @@ -129,9 +129,8 @@ static int dlh_read_direct(struct dlh_state *st,
> >  	if (ret)
> >  		return ret;
> >  
> > -	*pressure = get_unaligned_be32(&st->rx_buf[1]) >> 8;
> > -	*temperature = get_unaligned_be32(&st->rx_buf[3]) &
> > -		GENMASK(DLH_NUM_TEMP_BITS - 1, 0);
> > +	*pressure = get_unaligned_be24(&st->rx_buf[1]);
> > +	*temperature = get_unaligned_be24(&st->rx_buf[4]);
> >  
> >  	return 0;
> >  }  
> 

