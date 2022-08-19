Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A5599197
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbiHSAIr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Aug 2022 20:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbiHSAIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:08:42 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD255A3C6;
        Thu, 18 Aug 2022 17:08:38 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id E437AC017F;
        Fri, 19 Aug 2022 00:08:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id C188860013;
        Fri, 19 Aug 2022 00:08:35 +0000 (UTC)
Message-ID: <72bbd0126162b7f78291d3431d2a8c6730cc4ce7.camel@perches.com>
Subject: Re: [PATCH] iio: Avoid multiple line dereference for mask
From:   Joe Perches <joe@perches.com>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 18 Aug 2022 20:08:27 -0400
In-Reply-To: <20220818125844.60762-1-joetalbott@gmail.com>
References: <20220818125844.60762-1-joetalbott@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Stat-Signature: f1uyboi78t4c1z9e7swib63xprtonpzy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C188860013
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/c2aeq6vYQ0OSQy1gD2yCLIaS3sjK0e/E=
X-HE-Tag: 1660867715-574754
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-18 at 08:58 -0400, Joe Simmons-Talbott wrote:
> Add a mask variable to hold dereferences that span multiple lines.
> Found with checkpatch.pl.
[]
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
[]
> @@ -1301,10 +1302,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  		return ret;
>  	attrcount += ret;
>  
> +	mask = &chan->info_mask_separate_available;
>  	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
> -						  IIO_SEPARATE,
> -						  &chan->
> -						  info_mask_separate_available);
> +						  IIO_SEPARATE, mask);

The issue is the conflict between using 30+ character identifiers and 80 column lines.
Perhaps it's better just to use a longer line instead of a temporary.

	ret = iio_device_add_info_mask_type_avail(indio_dev, chan, IIO_SEPARATE,
						  &chan->info_mask_separate_available);
[]

> @@ -1316,10 +1316,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  		return ret;
>  	attrcount += ret;
>  
> +	mask = &chan->info_mask_shared_by_type_available;
>  	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
> -						  IIO_SHARED_BY_TYPE,
> -						  &chan->
> -						  info_mask_shared_by_type_available);
> +						  IIO_SHARED_BY_TYPE, mask);

	ret = iio_device_add_info_mask_type_avail(indio_dev, chan, IIO_SHARED_BY_TYPE,
						  &chan->info_mask_shared_by_type_available);

etc...


