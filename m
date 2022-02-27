Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39574C5B42
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiB0Mti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiB0Mtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:49:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0C22BE1;
        Sun, 27 Feb 2022 04:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 123BCB80B6F;
        Sun, 27 Feb 2022 12:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432E2C340E9;
        Sun, 27 Feb 2022 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645966136;
        bh=fOtalGurFO0Ty6CaPSM1YkNRaLC3Kf3S9w+JAyC3AEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogzXxTUjfvQjYWlSpYxIWXrTkwMrLpjOP6yc+aHzHud/oaPFaOlPxKocWODvaI/2T
         cqzksM6aK5fqVxUYovKtznLTft9Z4FXPpeGXeCmILWLBdDVyG1Jq9ivY0u4vr6H7+C
         zJBIynY/cOVToLb7CdcLga/xhdYp4XLpYIwlvnYOcAZ7tZKEvY1q1D0vZlcSyJuqET
         HOaBcTzsQEuTSaS6P+qrGooYfIAyp373p1+zUKIXP0hRp8s6vLq7HlbzQOS6LeiOJZ
         9Ah2NkdAI9wmMjSNViUL01UvzEbJHKTiCBXUlAYE/9Sk6xImqiUX5Cgk3noMrYaSjC
         YS/s0pEgOJGwQ==
Date:   Sun, 27 Feb 2022 12:55:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, andy.shevchenko@gmail.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v15 00/10] iio: afe: add temperature rescaling support
Message-ID: <20220227125559.72d5d79a@jic23-huawei>
In-Reply-To: <20220213025739.2561834-1-liambeguin@gmail.com>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
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

On Sat, 12 Feb 2022 21:57:29 -0500
Liam Beguin <liambeguin@gmail.com> wrote:

> Jonathan, Peter, Andy,
> 
> This series focuses on adding temperature rescaling support to the IIO
> Analog Front End (AFE) driver.
> 
> The main changes to the AFE driver include an initial Kunit test suite,
> support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> and temperature transducer sensors.
> 
> Thanks for your time,
> Liam

Hi Liam,

I was waiting for Andy to reply to this. Took a quick look back at
what was outstanding and realised he had given a
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for v13.

I'm assuming there wasn't a strong reason to drop that in the meantime
and it's a simple omission / crossed emails issue.

As such, 

Series applied to the togreg branch of iio.git and pushed out
as testing to get some build coverage from 0-day.

Thanks,

Jonathan

> 
> Changes since v14:
> - Revert units.h changes in favor of "raw" values
> 
> Changes since v13:
> - fix SI prefix in rescale_temp_sense_rtd_props()
> - add comment explaining SI prefixes are sometimes used as mathematical
>   multipliers with no particular physical meaning associated.
> 
> Changes since v12:
> - rebase on latest testing branch
> - fix copyright holder in newly created header file
> - add myself as a copyright holder of the iio-rescale.c driver at
>   Peter's suggestion
> - fix undefined behavior on left-shift operation
> 
> Changes since v11:
> - update commits with my personal email since all this work was done on
>   my own time
> - apply Peter's Reviewed-by to my local tree
> - fix use of units.h
> - make use of units.h more consistently in iio-rescale.c and in the
>   tests
> - fix #include ordering
> - treat 04/16 as a fix. Move it, and add a Fixes: tag
> - fix undefined behavior on left-shift operation
> - add comment about fract_mult with iio_str_to_fixpoint()
> - reword commit message for 14/16, based on Andy's comments
> 
> Changes since v10:
> - apply Andy's suggestion for offset calculations
> - make use of units.h more consistently
> 
> Changes since v9:
> - make use of linux/units.h
> - reorder commits, fix fract_log2 before merging fract
> - keep fractional representation when not overflowing
> 
> Changes since v8:
> - reword comment
> - fix erroneous 64-bit division
> - optimize and use 32-bit divisions when values are know to not overflow
> - keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
>   point
> - add test cases
> - use nano precision in test cases
> - simplify offset calculation in rtd_props()
> 
> Changes since v7:
> - drop gcd() logic in rescale_process_scale()
> - use div_s64() instead of do_div() for signed 64-bit divisions
> - combine IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2 scale cases
> - switch to INT_PLUS_NANO when accuracy is lost with FRACTIONAL scales
> - rework test logic to allow for small relative error
> - rename test variables to align error output messages
> 
> Changes since v6:
> - rework IIO_VAL_INT_PLUS_{NANO,MICRO} based on Peter's suggestion
> - combine IIO_VAL_INT_PLUS_{NANO,MICRO} cases
> - add test cases for negative IIO_VAL_INT_PLUS_{NANO,MICRO} corner cases
> - force use of positive integers with gcd()
> - reduce risk of integer overflow in IIO_VAL_FRACTIONAL_LOG2
> - fix duplicate symbol build error
> - apply Reviewed-by
> 
> Changes since v5:
> - add include/linux/iio/afe/rescale.h
> - expose functions use to process scale and offset
> - add basic iio-rescale kunit test cases
> - fix integer overflow case
> - improve precision for IIO_VAL_FRACTIONAL_LOG2
> 
> Changes since v4:
> - only use gcd() when necessary in overflow mitigation
> - fix INT_PLUS_{MICRO,NANO} support
> - apply Reviewed-by
> - fix temperature-transducer bindings
> 
> Changes since v3:
> - drop unnecessary fallthrough statements
> - drop redundant local variables in some calculations
> - fix s64 divisions on 32bit platforms by using do_div
> - add comment describing iio-rescaler offset calculation
> - drop unnecessary MAINTAINERS entry
> 
> Changes since v2:
> - don't break implicit offset truncations
> - make a best effort to get a valid value for fractional types
> - drop return value change in iio_convert_raw_to_processed_unlocked()
> - don't rely on processed value for offset calculation
> - add INT_PLUS_{MICRO,NANO} support in iio-rescale
> - revert generic implementation in favor of temperature-sense-rtd and
>   temperature-transducer
> - add separate section to MAINTAINERS file
> 
> Changes since v1:
> - rebase on latest iio `testing` branch
> - also apply consumer scale on integer channel scale types
> - don't break implicit truncation in processed channel offset
>   calculation
> - drop temperature AFE flavors in favor of a simpler generic
>   implementation
> 
> Liam Beguin (10):
>   iio: afe: rescale: expose scale processing function
>   iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
>   iio: afe: rescale: add offset support
>   iio: afe: rescale: fix accuracy for small fractional scales
>   iio: afe: rescale: reduce risk of integer overflow
>   iio: test: add basic tests for the iio-rescale driver
>   iio: afe: rescale: add RTD temperature sensor support
>   iio: afe: rescale: add temperature transducers
>   dt-bindings: iio: afe: add bindings for temperature-sense-rtd
>   dt-bindings: iio: afe: add bindings for temperature transducers
> 
>  .../iio/afe/temperature-sense-rtd.yaml        | 101 +++
>  .../iio/afe/temperature-transducer.yaml       | 114 +++
>  drivers/iio/afe/iio-rescale.c                 | 283 ++++++-
>  drivers/iio/test/Kconfig                      |  10 +
>  drivers/iio/test/Makefile                     |   1 +
>  drivers/iio/test/iio-test-rescale.c           | 710 ++++++++++++++++++
>  include/linux/iio/afe/rescale.h               |  36 +
>  7 files changed, 1220 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
>  create mode 100644 drivers/iio/test/iio-test-rescale.c
>  create mode 100644 include/linux/iio/afe/rescale.h
> 
> Range-diff against v14:
>  -:  ------------ >  1:  ee26b0eeac65 iio: afe: rescale: expose scale processing function
>  1:  a510097c83f1 !  2:  78f9d37575a5 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
>     @@ Commit message
>          Reviewed-by: Peter Rosin <peda@axentia.se>
>      
>       ## drivers/iio/afe/iio-rescale.c ##
>     -@@
>     - #include <linux/of_device.h>
>     - #include <linux/platform_device.h>
>     - #include <linux/property.h>
>     -+#include <linux/units.h>
>     - 
>     - #include <linux/iio/afe/rescale.h>
>     - #include <linux/iio/consumer.h>
>      @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
>       			  int *val, int *val2)
>       {
>     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
>      +		return scale_type;
>      +	case IIO_VAL_INT_PLUS_NANO:
>      +	case IIO_VAL_INT_PLUS_MICRO:
>     -+		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
>     ++		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? 1000000000L : 1000000L;
>      +
>      +		/*
>      +		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
>  2:  8f2f2699a9b4 !  3:  5be82bd72453 iio: afe: rescale: add offset support
>     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
>      +		*val = div_s64(tmp, scale) + schan_off;
>      +		return IIO_VAL_INT;
>      +	case IIO_VAL_INT_PLUS_NANO:
>     -+		tmp = (s64)rescale->offset * GIGA;
>     -+		tmp2 = ((s64)scale * GIGA) + scale2;
>     ++		tmp = (s64)rescale->offset * 1000000000LL;
>     ++		tmp2 = ((s64)scale * 1000000000LL) + scale2;
>      +		*val = div64_s64(tmp, tmp2) + schan_off;
>      +		return IIO_VAL_INT;
>      +	case IIO_VAL_INT_PLUS_MICRO:
>     -+		tmp = (s64)rescale->offset * MEGA;
>     -+		tmp2 = ((s64)scale * MEGA) + scale2;
>     ++		tmp = (s64)rescale->offset * 1000000LL;
>     ++		tmp2 = ((s64)scale * 1000000LL) + scale2;
>      +		*val = div64_s64(tmp, tmp2) + schan_off;
>      +		return IIO_VAL_INT;
>      +	default:
>  3:  2efa970bad26 !  4:  95ec184759f6 iio: afe: rescale: fix accuracy for small fractional scales
>     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
>      +		return IIO_VAL_INT_PLUS_NANO;
>       	case IIO_VAL_INT_PLUS_NANO:
>       	case IIO_VAL_INT_PLUS_MICRO:
>     - 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
>     + 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? 1000000000L : 1000000L;
>  4:  201037c0ead8 =  5:  2e1d41ef69d9 iio: afe: rescale: reduce risk of integer overflow
>  5:  a0037cc3ee90 <  -:  ------------ iio: afe: rescale: make use of units.h
>  6:  f8d47728f482 !  6:  0b6c029dea1d iio: test: add basic tests for the iio-rescale driver
>     @@ drivers/iio/test/iio-test-rescale.c (new)
>      +
>      +#include <linux/gcd.h>
>      +#include <linux/overflow.h>
>     -+#include <linux/units.h>
>      +
>      +#include <linux/iio/afe/rescale.h>
>      +#include <linux/iio/iio.h>
>     @@ drivers/iio/test/iio-test-rescale.c (new)
>      +	if (tmp < 0)
>      +		tmp2 *= -1;
>      +
>     -+	*nano = (s64)tmp * GIGA + tmp2;
>     ++	*nano = (s64)tmp * 1000000000UL + tmp2;
>      +
>      +	return ret;
>      +}
>     @@ drivers/iio/test/iio-test-rescale.c (new)
>      +		return -EINVAL;
>      +	}
>      +
>     -+	err = MEGA * abs(exp - real);
>     ++	err = 1000000UL * abs(exp - real);
>      +
>      +	return (int)div64_u64(err, abs(exp));
>      +}
>  7:  a04685586340 !  7:  951ea44d0f5c iio: afe: rescale: add RTD temperature sensor support
>     @@ drivers/iio/afe/iio-rescale.c: static int rescale_voltage_divider_props(struct d
>      +		return ret;
>      +	}
>      +
>     -+	tmp = r0 * iexc * alpha / MEGA;
>     -+	factor = gcd(tmp, MEGA);
>     -+	rescale->numerator = MEGA / factor;
>     ++	tmp = r0 * iexc * alpha / 1000000;
>     ++	factor = gcd(tmp, 1000000);
>     ++	rescale->numerator = 1000000 / factor;
>      +	rescale->denominator = tmp / factor;
>      +
>     -+	rescale->offset = -1 * ((r0 * iexc) / KILO);
>     ++	rescale->offset = -1 * ((r0 * iexc) / 1000);
>      +
>      +	return 0;
>      +}
>  8:  e3b716aaee50 !  8:  56516fdc67bf iio: afe: rescale: add temperature transducers
>     @@ drivers/iio/afe/iio-rescale.c: static int rescale_temp_sense_rtd_props(struct de
>      +		return ret;
>      +	}
>      +
>     -+	rescale->numerator = MEGA;
>     ++	rescale->numerator = 1000000;
>      +	rescale->denominator = alpha * sense;
>      +
>      +	rescale->offset = div_s64((s64)offset * rescale->denominator,
>  9:  22ae1458eb8b =  9:  8c409050990b dt-bindings: iio: afe: add bindings for temperature-sense-rtd
> 10:  33825ad452d6 = 10:  bb39296590f3 dt-bindings: iio: afe: add bindings for temperature transducers
> 
> base-commit: cd717ac6f69db4953ca701c6220c7cb58e17f35a

