Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D314A3630
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354763AbiA3MY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 07:24:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56526 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354425AbiA3MY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 07:24:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAD15B80DEF;
        Sun, 30 Jan 2022 12:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414C7C340E4;
        Sun, 30 Jan 2022 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643545463;
        bh=pwp+GnroCdFEJWcK92qTVzMBdnxk6NQt6J0zB3LNVFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MKwSQ4Kc2eZERUl547NyXjpkmgDhFlbBAXPMGgkB/2IF1avODl8A5zheoOiuhdvBK
         PUkZ/XHPlQ3tw6XTJy5ib8Qq3tkemLckKabLfO0+iXpwBeP2JOP/1udQ4zHYCNKIVc
         QCcU8V6K04kNc0Y7+uwicf0LZ4otCFrL99yTkqMW+N6dwzb7ldYFRMQLewoi2Gs0Pd
         UepBAywLrbMA7nsrzatHNRnuRAtCJ1pB8WTLMja4xXECRmb6kXbhORfWunr6qJkpom
         QkJbEmSGkCR+w57Xt9LWGGHhXbWNnzrJxwDoV5rTjdRO17ox4L0xhiUDmXInSTU/EP
         ItvlnGt61ip0Q==
Date:   Sun, 30 Jan 2022 12:30:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 1/4] math.h: Introduce data types for fractional
 numbers
Message-ID: <20220130123034.708543ad@jic23-huawei>
In-Reply-To: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
References: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 15:53:50 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Introduce a macro to produce data types like
> 
> 	struct TYPE_fract {
> 		__TYPE numerator;
> 		__TYPE denominator;
> 	};
> 
> to be used in the code wherever it's needed.
> 
> In the following changes convert some users to it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm not 100% sold on this, but I'm going to give them the benefit
of the doubt as to long term usefulness and apply them.

Basically I'm taking the view Andy is often right :)

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if we missed anything.

Thanks,

Jonathan

> ---
> 
> May be pulled via IIO tree.
> 
> v4: no changes
> v3: no changes
> v2: no changes
> 
>  include/linux/math.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/math.h b/include/linux/math.h
> index 53674a327e39..439b8f0b9ebd 100644
> --- a/include/linux/math.h
> +++ b/include/linux/math.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_MATH_H
>  #define _LINUX_MATH_H
>  
> +#include <linux/types.h>
>  #include <asm/div64.h>
>  #include <uapi/linux/kernel.h>
>  
> @@ -106,6 +107,17 @@
>  }							\
>  )
>  
> +#define __STRUCT_FRACT(type)				\
> +struct type##_fract {					\
> +	__##type numerator;				\
> +	__##type denominator;				\
> +};
> +__STRUCT_FRACT(s16)
> +__STRUCT_FRACT(u16)
> +__STRUCT_FRACT(s32)
> +__STRUCT_FRACT(u32)
> +#undef __STRUCT_FRACT
> +
>  /*
>   * Multiplies an integer by a fraction, while avoiding unnecessary
>   * overflow or loss of precision.

