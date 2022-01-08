Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D99488603
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiAHUxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiAHUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:30 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C70C06173F;
        Sat,  8 Jan 2022 12:53:30 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c10so7871863qte.2;
        Sat, 08 Jan 2022 12:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LgT50u2L1LhL7D5mFr3gqfPtf3g2KUB4mUhB0p/NLoM=;
        b=OJsvfKT2sSlfdYPf1b3oxCUxRy3AkqrgaSPR7Wiby4UvCfKLNVE1K18vG4zSMnko/m
         kGiodSOZjEL6Kl9AvGQXveiyvfezNmtrg8MRf6iGQiXq7+8h1yOxj/nUILTNKJvwAJRr
         wwTriF30ll3oIztmvr4JgijAE+/xUChApcvqfB0yUtwOIO+sbT6/+PjJkYpEnxEmhpgp
         WQoIbEnLMXx3O2Iy55DIBxKAs1y5d4n1RD2+z92ME599H2xFbyvaF19F9XrkVfzFRKkB
         X2fDEvJ14LXOL8sGSkth2rkMH8rLG13zJULieTQ2vKsIiX7ld5+q15Rc3peq7ZHToxI0
         EjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LgT50u2L1LhL7D5mFr3gqfPtf3g2KUB4mUhB0p/NLoM=;
        b=Sfb/IWSaMYGuLi6NoXS2vj/ZlfOjW46Uhh+cXhDKhOsegC7SBz+pzfiDwPt+/REqeA
         4ElxekP/aONKjqEkHgxlZiYDCr8kjRZ/vy6he5r9mN9/vxN221Ju9wlEOJT7iB7ZF3o1
         s75mdRKBpH7tbN5wHivhX6styW2KXYy8ih/qitLBFVCYaAIFsFQQuImMxkVHdDFGrg/c
         yXRKM/HOfbV+7+gx5KK5ubmKLfmTMkd97KPEzv1JHWFBBY/BMTuPj1Yo2KozfG9cwc1e
         liRDkyfBqjFLwOpXuxURlqvO5XTiytD9jMCDVEuWQzuEz1KRNgRL5SxfTkzu0bCn2Ahb
         9vxQ==
X-Gm-Message-State: AOAM533C54wUyfNB7Kefa7MJls5/mZNZn2WD/HRU56r94fl2q3mBXs8p
        BaRHl/3aYx/PoQbUScasHd4=
X-Google-Smtp-Source: ABdhPJxD+6hXecBHF735GyBZ9IkzBXlFxqPqzSEqqZex7EDJvF8fT3QsGJKunqxPu25jGZm+XjQkmA==
X-Received: by 2002:ac8:7d0f:: with SMTP id g15mr3201706qtb.411.1641675208935;
        Sat, 08 Jan 2022 12:53:28 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:28 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 00/16] iio: afe: add temperature rescaling support
Date:   Sat,  8 Jan 2022 15:53:03 -0500
Message-Id: <20220108205319.2046348-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan, Peter, Andy,

I left out IIO_VAL_INT overflows for now, so that I can focus on getting
the rest of these changes pulled in, but I don't mind adding a patch for
that later on.

This series focuses on adding temperature rescaling support to the IIO
Analog Front End (AFE) driver.

The first few patches address minor bugs in IIO inkernel functions, and
prepare the AFE driver for the additional features.

The main changes to the AFE driver include an initial Kunit test suite,
support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
and temperature transducer sensors.

My apologies Andy for misunderstanding your left-shift comments, I don't
know where my head was at... Thanks for your patience!

Thanks you all again for your time, and Happy New Year!
Liam

Changes since v11:
- update commits with my personal email since all this work was done on
  my own time
- apply Peter's Reviewed-by to my local tree
- fix use of units.h
- make use of units.h more consistently in iio-rescale.c and in the
  tests
- fix #include ordering
- treat 04/16 as a fix. Move it, and add a Fixes: tag
- fix undefined behavior on left-shift operation
- add comment about fract_mult with iio_str_to_fixpoint()
- reword commit message for 14/16, based on Andy's comments

Changes since v10:
- apply Andy's suggestion for offset calculations
- make use of units.h more consistently

Changes since v9:
- make use of linux/units.h
- reorder commits, fix fract_log2 before merging fract
- keep fractional representation when not overflowing

Changes since v8:
- reword comment
- fix erroneous 64-bit division
- optimize and use 32-bit divisions when values are know to not overflow
- keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
  point
- add test cases
- use nano precision in test cases
- simplify offset calculation in rtd_props()

Changes since v7:
- drop gcd() logic in rescale_process_scale()
- use div_s64() instead of do_div() for signed 64-bit divisions
- combine IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2 scale cases
- switch to INT_PLUS_NANO when accuracy is lost with FRACTIONAL scales
- rework test logic to allow for small relative error
- rename test variables to align error output messages

Changes since v6:
- rework IIO_VAL_INT_PLUS_{NANO,MICRO} based on Peter's suggestion
- combine IIO_VAL_INT_PLUS_{NANO,MICRO} cases
- add test cases for negative IIO_VAL_INT_PLUS_{NANO,MICRO} corner cases
- force use of positive integers with gcd()
- reduce risk of integer overflow in IIO_VAL_FRACTIONAL_LOG2
- fix duplicate symbol build error
- apply Reviewed-by

Changes since v5:
- add include/linux/iio/afe/rescale.h
- expose functions use to process scale and offset
- add basic iio-rescale kunit test cases
- fix integer overflow case
- improve precision for IIO_VAL_FRACTIONAL_LOG2

Changes since v4:
- only use gcd() when necessary in overflow mitigation
- fix INT_PLUS_{MICRO,NANO} support
- apply Reviewed-by
- fix temperature-transducer bindings

Changes since v3:
- drop unnecessary fallthrough statements
- drop redundant local variables in some calculations
- fix s64 divisions on 32bit platforms by using do_div
- add comment describing iio-rescaler offset calculation
- drop unnecessary MAINTAINERS entry

Changes since v2:
- don't break implicit offset truncations
- make a best effort to get a valid value for fractional types
- drop return value change in iio_convert_raw_to_processed_unlocked()
- don't rely on processed value for offset calculation
- add INT_PLUS_{MICRO,NANO} support in iio-rescale
- revert generic implementation in favor of temperature-sense-rtd and
  temperature-transducer
- add separate section to MAINTAINERS file

Changes since v1:
- rebase on latest iio `testing` branch
- also apply consumer scale on integer channel scale types
- don't break implicit truncation in processed channel offset
  calculation
- drop temperature AFE flavors in favor of a simpler generic
  implementation

Liam Beguin (16):
  iio: inkern: apply consumer scale on IIO_VAL_INT cases
  iio: inkern: apply consumer scale when no channel scale is available
  iio: inkern: make a best effort on offset calculation
  iio: afe: rescale: use s64 for temporary scale calculations
  iio: afe: rescale: reorder includes
  iio: afe: rescale: expose scale processing function
  iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
  iio: afe: rescale: add offset support
  iio: afe: rescale: fix accuracy for small fractional scales
  iio: afe: rescale: reduce risk of integer overflow
  iio: afe: rescale: make use of units.h
  iio: test: add basic tests for the iio-rescale driver
  iio: afe: rescale: add RTD temperature sensor support
  iio: afe: rescale: add temperature transducers
  dt-bindings: iio: afe: add bindings for temperature-sense-rtd
  dt-bindings: iio: afe: add bindings for temperature transducers

 .../iio/afe/temperature-sense-rtd.yaml        | 101 +++
 .../iio/afe/temperature-transducer.yaml       | 114 +++
 drivers/iio/afe/iio-rescale.c                 | 296 +++++++-
 drivers/iio/inkern.c                          |  40 +-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 711 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  36 +
 8 files changed, 1259 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v11:
 1:  ae3cc93baee6 !  1:  a8ca9300ef2a iio: inkern: apply consumer scale on IIO_VAL_INT cases
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: inkern: apply consumer scale on IIO_VAL_INT cases
    @@ Commit message
         Make sure to always apply the scaling factor requested by the consumer.
     
         Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/inkern.c ##
     @@ drivers/iio/inkern.c: static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 2:  06f66e7f7403 !  2:  efaeceac8d87 iio: inkern: apply consumer scale when no channel scale is available
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: inkern: apply consumer scale when no channel scale is available
    @@ Commit message
         Make sure to always apply the scaling factor requested by the consumer.
     
         Fixes: adc8ec5ff183 ("iio: inkern: pass through raw values if no scaling")
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/inkern.c ##
     @@ drivers/iio/inkern.c: static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 3:  1717b82460c0 !  3:  8131208a4454 iio: inkern: make a best effort on offset calculation
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: inkern: make a best effort on offset calculation
    @@ Commit message
         cases without breaking implicit truncations.
     
         Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/inkern.c ##
     @@ drivers/iio/inkern.c: EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 -:  ------------ >  4:  06202d8f6481 iio: afe: rescale: use s64 for temporary scale calculations
 -:  ------------ >  5:  87b9d77f0d30 iio: afe: rescale: reorder includes
 4:  6fc26588f651 !  6:  e9bf09ca9703 iio: afe: rescale: expose scale processing function
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: afe: rescale: expose scale processing function
    @@ Commit message
         In preparation for the addition of kunit tests, expose the logic
         responsible for combining channel scales.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
     @@
    - #include <linux/gcd.h>
    - #include <linux/iio/consumer.h>
    - #include <linux/iio/iio.h>
    -+#include <linux/iio/afe/rescale.h>
    - #include <linux/module.h>
    - #include <linux/of.h>
    - #include <linux/of_device.h>
      #include <linux/platform_device.h>
      #include <linux/property.h>
      
    ++#include <linux/iio/afe/rescale.h>
    + #include <linux/iio/consumer.h>
    + #include <linux/iio/iio.h>
    + 
     -struct rescale;
     -
     -struct rescale_cfg {
    @@ drivers/iio/afe/iio-rescale.c
     +int rescale_process_scale(struct rescale *rescale, int scale_type,
     +			  int *val, int *val2)
     +{
    -+	unsigned long long tmp;
    ++	s64 tmp;
      
     -struct rescale {
     -	const struct rescale_cfg *cfg;
    @@ drivers/iio/afe/iio-rescale.c
     +		*val2 = rescale->denominator;
     +		return IIO_VAL_FRACTIONAL;
     +	case IIO_VAL_FRACTIONAL_LOG2:
    -+		tmp = *val * 1000000000LL;
    -+		do_div(tmp, rescale->denominator);
    ++		tmp = (s64)*val * 1000000000LL;
    ++		tmp = div_s64(tmp, rescale->denominator);
     +		tmp *= rescale->numerator;
    -+		do_div(tmp, 1000000000LL);
    ++		tmp = div_s64(tmp, 1000000000LL);
     +		*val = tmp;
     +		return scale_type;
     +	default:
    @@ drivers/iio/afe/iio-rescale.c
      			    int *val, int *val2, long mask)
      {
      	struct rescale *rescale = iio_priv(indio_dev);
    --	unsigned long long tmp;
    +-	s64 tmp;
      	int ret;
      
      	switch (mask) {
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
     -			*val2 = rescale->denominator;
     -			return IIO_VAL_FRACTIONAL;
     -		case IIO_VAL_FRACTIONAL_LOG2:
    --			tmp = *val * 1000000000LL;
    --			do_div(tmp, rescale->denominator);
    +-			tmp = (s64)*val * 1000000000LL;
    +-			tmp = div_s64(tmp, rescale->denominator);
     -			tmp *= rescale->numerator;
    --			do_div(tmp, 1000000000LL);
    +-			tmp = div_s64(tmp, 1000000000LL);
     -			*val = tmp;
     -			return ret;
     -		default:
    @@ include/linux/iio/afe/rescale.h (new)
     +#ifndef __IIO_RESCALE_H__
     +#define __IIO_RESCALE_H__
     +
    ++#include <linux/types.h>
     +#include <linux/iio/iio.h>
     +
    ++struct device;
     +struct rescale;
     +
     +struct rescale_cfg {
 5:  8e63c4036157 !  7:  865296d2bc4f iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
    @@ Commit message
         Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
         Add support for these to allow using the iio-rescaler with them.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
     @@
    @@ drivers/iio/afe/iio-rescale.c
      #include <linux/property.h>
     +#include <linux/units.h>
      
    - int rescale_process_scale(struct rescale *rescale, int scale_type,
    + #include <linux/iio/afe/rescale.h>
    + #include <linux/iio/consumer.h>
    +@@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
      			  int *val, int *val2)
      {
    - 	unsigned long long tmp;
    + 	s64 tmp;
     +	s32 rem;
     +	u32 mult;
     +	u32 neg;
    @@ drivers/iio/afe/iio-rescale.c
      	case IIO_VAL_FRACTIONAL:
     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
      		tmp *= rescale->numerator;
    - 		do_div(tmp, 1000000000LL);
    + 		tmp = div_s64(tmp, 1000000000LL);
      		*val = tmp;
     +		return scale_type;
     +	case IIO_VAL_INT_PLUS_NANO:
     +	case IIO_VAL_INT_PLUS_MICRO:
    -+		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? NANO : MICRO;
    ++		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
     +
     +		/*
     +		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
 6:  eea57faec241 !  8:  aea3159ed169 iio: afe: rescale: add offset support
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: afe: rescale: add offset support
    @@ Commit message
         This is a preparatory change required for the addition of temperature
         sensing front ends.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		*val = div_s64(tmp, scale) + schan_off;
     +		return IIO_VAL_INT;
     +	case IIO_VAL_INT_PLUS_NANO:
    -+		tmp = (s64)rescale->offset * NANO;
    -+		tmp2 = ((s64)scale * NANO) + scale2;
    ++		tmp = (s64)rescale->offset * GIGA;
    ++		tmp2 = ((s64)scale * GIGA) + scale2;
     +		*val = div64_s64(tmp, tmp2) + schan_off;
     +		return IIO_VAL_INT;
     +	case IIO_VAL_INT_PLUS_MICRO:
    -+		tmp = (s64)rescale->offset * MICRO;
    -+		tmp2 = ((s64)scale * MICRO) + scale2;
    ++		tmp = (s64)rescale->offset * MEGA;
    ++		tmp2 = ((s64)scale * MEGA) + scale2;
     +		*val = div64_s64(tmp, tmp2) + schan_off;
     +		return IIO_VAL_INT;
     +	default:
 7:  6bc5dd8c92ac <  -:  ------------ iio: afe: rescale: use s64 for temporary scale calculations
 8:  7d426d67a7fd !  9:  7b518cba1cb5 iio: afe: rescale: fix accuracy for small fractional scales
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: afe: rescale: fix accuracy for small fractional scales
    @@ Commit message
         integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
         cases to maintain accuracy.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		return IIO_VAL_INT_PLUS_NANO;
      	case IIO_VAL_INT_PLUS_NANO:
      	case IIO_VAL_INT_PLUS_MICRO:
    - 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? NANO : MICRO;
    + 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
 9:  dbea6ae8fec2 ! 10:  4310bb2153e2 iio: afe: rescale: reduce risk of integer overflow
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: afe: rescale: reduce risk of integer overflow
    @@ Commit message
         a 64-bit integer. Since the rescaling is only performed on *val, reuse
         the IIO_VAL_FRACTIONAL_LOG2 case.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		if (scale_type == IIO_VAL_FRACTIONAL)
     +			tmp = *val2;
     +		else
    -+			tmp = 1 << *val2;
    ++			tmp = ULL(1) << *val2;
      
      		rem2 = *val % (int)tmp;
      		*val = *val / (int)tmp;
10:  9ab1138449d3 ! 11:  fd794683186a iio: afe: rescale: make use of units.h
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: afe: rescale: make use of units.h
     
         Make use of well-defined SI metric prefixes to improve code readability.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
     
      ## drivers/iio/afe/iio-rescale.c ##
     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
      		fallthrough;
      	case IIO_VAL_FRACTIONAL_LOG2:
     -		tmp = (s64)*val * 1000000000LL;
    -+		tmp = (s64)*val * NANO;
    ++		tmp = (s64)*val * GIGA;
      		tmp = div_s64(tmp, rescale->denominator);
      		tmp *= rescale->numerator;
      
     -		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
    -+		tmp = div_s64_rem(tmp, NANO, &rem);
    ++		tmp = div_s64_rem(tmp, GIGA, &rem);
      		*val = tmp;
      
      		if (!rem)
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
      		*val2 = rem / (int)tmp;
      		if (rem2)
     -			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
    -+			*val2 += div_s64((s64)rem2 * NANO, tmp);
    ++			*val2 += div_s64((s64)rem2 * GIGA, tmp);
      
      		return IIO_VAL_INT_PLUS_NANO;
      	case IIO_VAL_INT_PLUS_NANO:
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_current_sense_amplifier_props(
      	 */
     -	factor = gcd(sense, 1000000);
     -	rescale->numerator = 1000000 / factor;
    -+	factor = gcd(sense, MICRO);
    -+	rescale->numerator = MICRO / factor;
    ++	factor = gcd(sense, MEGA);
    ++	rescale->numerator = MEGA / factor;
      	rescale->denominator = sense / factor;
      
      	factor = gcd(rescale->numerator, gain_mult);
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_current_sense_shunt_props(stru
      
     -	factor = gcd(shunt, 1000000);
     -	rescale->numerator = 1000000 / factor;
    -+	factor = gcd(shunt, MICRO);
    -+	rescale->numerator = MICRO / factor;
    ++	factor = gcd(shunt, MEGA);
    ++	rescale->numerator = MEGA / factor;
      	rescale->denominator = shunt / factor;
      
      	return 0;
11:  3006151cd193 ! 12:  5053bcff8445 iio: test: add basic tests for the iio-rescale driver
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: test: add basic tests for the iio-rescale driver
    @@ Commit message
         Then run:
                 $ ./tools/testing/kunit/kunit.py run --kunitconfig .kunitconfig
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/test/Kconfig ##
     @@
    @@ drivers/iio/test/iio-test-rescale.c (new)
     + * Copyright (c) 2021 Liam Beguin <liambeguin@gmail.com>
     + */
     +
    -+#include <kunit/test.h>
     +#include <linux/gcd.h>
    ++#include <linux/overflow.h>
    ++#include <linux/units.h>
    ++
     +#include <linux/iio/afe/rescale.h>
     +#include <linux/iio/iio.h>
    -+#include <linux/overflow.h>
    ++
    ++#include <kunit/test.h>
     +
     +struct rescale_tc_data {
     +	const char *name;
    @@ drivers/iio/test/iio-test-rescale.c (new)
     + */
     +static int iio_str_to_nano(const char *str, s64 *nano)
     +{
    -+	int fract_mult = 100000000LL;
     +	int tmp, tmp2;
     +	int ret = 0;
     +
    -+	ret = iio_str_to_fixpoint(str, fract_mult, &tmp, &tmp2);
    ++	/*
    ++	 * iio_str_to_fixpoint() uses 10^8 here instead of 10^9 as fract_mult is
    ++	 * the multiplier for the first decimal place.
    ++	 */
    ++	ret = iio_str_to_fixpoint(str, 100000000, &tmp, &tmp2);
     +	if (ret < 0)
     +		return ret;
     +
     +	if (tmp < 0)
     +		tmp2 *= -1;
     +
    -+	*nano = (s64)tmp * 10 * fract_mult + tmp2;
    ++	*nano = (s64)tmp * GIGA + tmp2;
     +
     +	return ret;
     +}
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		return -EINVAL;
     +	}
     +
    -+	err = 1000000 * abs(exp - real);
    -+	err = div64_u64(err, abs(exp));
    -+	return (int)err;
    ++	err = MEGA * abs(exp - real);
    ++
    ++	return (int)div64_u64(err, abs(exp));
     +}
     +
     +static void iio_rescale_test_scale(struct kunit *test)
12:  d4229e8d7f24 ! 13:  aec4f7e44277 iio: afe: rescale: add RTD temperature sensor support
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: afe: rescale: add RTD temperature sensor support
    @@ Commit message
         give range (usually 0 to 100 degrees Celsius). Common types of RTDs
         include PT100, PT500, and PT1000.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
     @@ drivers/iio/afe/iio-rescale.c: static int rescale_voltage_divider_props(struct device *dev,
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_voltage_divider_props(struct d
     +		return ret;
     +	}
     +
    -+	tmp = r0 * iexc * alpha / MICRO;
    -+	factor = gcd(tmp, MICRO);
    -+	rescale->numerator = MICRO / factor;
    ++	tmp = r0 * iexc * alpha / MEGA;
    ++	factor = gcd(tmp, MEGA);
    ++	rescale->numerator = MEGA / factor;
     +	rescale->denominator = tmp / factor;
     +
    -+	rescale->offset = -1 * ((r0 * iexc) / MICRO * MILLI);
    ++	rescale->offset = -1 * ((r0 * iexc) / MEGA * MILLI);
     +
     +	return 0;
     +}
13:  b93e303c5e60 ! 14:  e5467185f3b3 iio: afe: rescale: add temperature transducers
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         iio: afe: rescale: add temperature transducers
     
         A temperature transducer is a device that converts a thermal quantity
    -    into any other physical quantity. This patch add support for temperature
    -    to voltage (like the LTC2997) and temperature to current (like the
    -    AD590) linear transducers.
    +    into any other physical quantity. This patch adds support for
    +    temperature to voltage (like the LTC2997) and temperature to current
    +    (like the AD590) linear transducers.
         In both cases these are assumed to be connected to a voltage ADC.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
     @@ drivers/iio/afe/iio-rescale.c: static int rescale_temp_sense_rtd_props(struct device *dev,
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_temp_sense_rtd_props(struct de
     +		return ret;
     +	}
     +
    -+	rescale->numerator = MICRO;
    ++	rescale->numerator = MEGA;
     +	rescale->denominator = alpha * sense;
     +
     +	rescale->offset = div_s64((s64)offset * rescale->denominator,
14:  7bdd57435c5c ! 15:  3d16dc359e35 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         dt-bindings: iio: afe: add bindings for temperature-sense-rtd
    @@ Commit message
         binding describe one case, the measurement of a temperature through the
         voltage across an RTD resistor such as a PT1000.
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
         Reviewed-by: Rob Herring <robh@kernel.org>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml (new) ##
     @@
15:  604ef3e42c07 ! 16:  b70fb25c3643 dt-bindings: iio: afe: add bindings for temperature transducers
    @@
      ## Metadata ##
    -Author: Liam Beguin <lvb@xiphos.com>
    +Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
         dt-bindings: iio: afe: add bindings for temperature transducers
    @@ Commit message
         This binding describe one case, the measurement of a temperature
         through a temperature transducer (either voltage or current).
     
    -    Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Signed-off-by: Liam Beguin <liambeguin@gmail.com>
         Reviewed-by: Rob Herring <robh@kernel.org>
    +    Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml (new) ##
     @@

base-commit: 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
-- 
2.34.0

