Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2A59A49F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351264AbiHSRo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354713AbiHSRn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4ABCE0;
        Fri, 19 Aug 2022 10:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEFD2617D0;
        Fri, 19 Aug 2022 17:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0424C433D6;
        Fri, 19 Aug 2022 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660928724;
        bh=QqRwdsza8GJAfdhc+fC/YMNne+B8UrtzLFfv6moaMWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F/Q8Qz2l7l623HUNNDi1K2lGey3wYZFZ/y8mlbz9Zdrju9l9NrtH9Zxgl/I/FHtuz
         0WnZLeTQH11HWANEtMrEKO1+99XwEfcyeEg8YDifsXV1RRLyAp+PCdggDvyLvGpu4X
         /vrP13c9oqt1ysvQvDn6h2ciSSvGBFZ/eKqZPVYZYp9JtriTeWZRrOccIicLUFBhvZ
         ydQ8zfjl3jNyA9xWRggkaYGFf7jte9dRgs+gjqR5ELYKTWo+2/xjyJIP5HKA05YlWV
         IfcdbNxaxgjyVSg189cd1e/0N4Fr8GRSU0hQ85OqivHPbzRB+nV9Ndxt37+OJTZ7qY
         eBpqwHYKSftjw==
Date:   Fri, 19 Aug 2022 18:16:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Avoid multiple line dereference for mask
Message-ID: <20220819181600.638b82e9@jic23-huawei>
In-Reply-To: <72bbd0126162b7f78291d3431d2a8c6730cc4ce7.camel@perches.com>
References: <20220818125844.60762-1-joetalbott@gmail.com>
        <72bbd0126162b7f78291d3431d2a8c6730cc4ce7.camel@perches.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 20:08:27 -0400
Joe Perches <joe@perches.com> wrote:

> On Thu, 2022-08-18 at 08:58 -0400, Joe Simmons-Talbott wrote:
> > Add a mask variable to hold dereferences that span multiple lines.
> > Found with checkpatch.pl.  
> []
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c  
> []
> > @@ -1301,10 +1302,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
> >  		return ret;
> >  	attrcount += ret;
> >  
> > +	mask = &chan->info_mask_separate_available;
> >  	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
> > -						  IIO_SEPARATE,
> > -						  &chan->
> > -						  info_mask_separate_available);
> > +						  IIO_SEPARATE, mask);  
> 
> The issue is the conflict between using 30+ character identifiers and 80 column lines.
> Perhaps it's better just to use a longer line instead of a temporary.
> 
> 	ret = iio_device_add_info_mask_type_avail(indio_dev, chan, IIO_SEPARATE,
> 						  &chan->info_mask_separate_available);

Agreed. Looks nicer to me this way and still under the wider 100 char limit
which is appropriate when readability is improved.

Some unfortunately long identifiers, that I think got there via evolution.
We should consider shortening them that's a job for a separate patch.


> []
> 
> > @@ -1316,10 +1316,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
> >  		return ret;
> >  	attrcount += ret;
> >  
> > +	mask = &chan->info_mask_shared_by_type_available;
> >  	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
> > -						  IIO_SHARED_BY_TYPE,
> > -						  &chan->
> > -						  info_mask_shared_by_type_available);
> > +						  IIO_SHARED_BY_TYPE, mask);  
> 
> 	ret = iio_device_add_info_mask_type_avail(indio_dev, chan, IIO_SHARED_BY_TYPE,
> 						  &chan->info_mask_shared_by_type_available);
> 
> etc...
> 
> 

