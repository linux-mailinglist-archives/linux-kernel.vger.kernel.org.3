Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDE84C5DD2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiB0Rjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiB0Rjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:39:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF95B3983D;
        Sun, 27 Feb 2022 09:39:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B9B1B80884;
        Sun, 27 Feb 2022 17:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DE8C340EF;
        Sun, 27 Feb 2022 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645983547;
        bh=RlxsNBxWP23xW/4RVjjxHZDE4BG21qefYTNvuOdpYrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BnRFAFvGMoca9d7oCUM2P30xUW2DQtTIu5s6WxGi5BJSKv92sBM2pOLtt0bONJw84
         PUssBow1aejad+JoryXbY3lumR1oHPOLjEcFlL0DiD1q4agnWJEZVCOgMLyufa7eee
         h4mpGQwP2xqEuWDvaitMcuoQqtqLe9ELsecnOm/GCzFyDWh1LSYTnIe4kFc+Ni9Zsz
         AB0gEOOZTM06m5PWFjgq+wnTLJEqiPm3hsYdQBwoan6dTP6d10opDdvM+NVkOm4N3/
         ZTjPCoQhbXInL81vfEM4s/WKlRL9HaLxwQwxflIFugFLA75hhu5x1O8oDxil9Pebcc
         GlYYk4SMQDklw==
Date:   Sun, 27 Feb 2022 17:46:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     trix@redhat.com
Cc:     vilhelm.gray@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] counter: add defaults to switch-statements
Message-ID: <20220227174610.0e0e73e4@jic23-huawei>
In-Reply-To: <20220227161746.82776-1-trix@redhat.com>
References: <20220227161746.82776-1-trix@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 08:17:46 -0800
trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this representative problem
> counter-chrdev.c:482:3: warning: Undefined or garbage value
>   returned to caller
>   return ret;
>   ^~~~~~~~~~
> 
> counter_get_data() has a multilevel switches, some without
> defaults, so ret is sometimes not set.
> Add returning -EINVAL similar to other defaults.
> 
> Fixes: b6c50affda59 ("counter: Add character device interface")
> Signed-off-by: Tom Rix <trix@redhat.com>
I'm fairly sure this one is warning supression rather than a fix as
that type u8 being used in the switch is storing an enum which is
set only by kernel code and all values of the enum are covered.

However, that's not locally visible so to me the addition looks good, I'd
just be tempted to drop the fixes tag as backporting this looks like noise
to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/counter-chrdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> index b7c62f957a6a8..69d340be9c93f 100644
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -477,6 +477,8 @@ static int counter_get_data(struct counter_device *const counter,
>  		case COUNTER_SCOPE_COUNT:
>  			ret = comp->count_u8_read(counter, parent, &value_u8);
>  			break;
> +		default:
> +			return -EINVAL;
>  		}
>  		*value = value_u8;
>  		return ret;
> @@ -496,6 +498,8 @@ static int counter_get_data(struct counter_device *const counter,
>  		case COUNTER_SCOPE_COUNT:
>  			ret = comp->count_u32_read(counter, parent, &value_u32);
>  			break;
> +		default:
> +			return -EINVAL;
>  		}
>  		*value = value_u32;
>  		return ret;

