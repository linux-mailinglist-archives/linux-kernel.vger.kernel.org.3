Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECAD47A2B6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhLSWkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhLSWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:00 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660BDC061574;
        Sun, 19 Dec 2021 14:40:00 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t83so7773381qke.8;
        Sun, 19 Dec 2021 14:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1P6ETO7aqLXjX0zDdE6kR2mudJHqrRCul2hY3DcmrcY=;
        b=FA+Jbu2Fm7XVWj8f87B56ukqeYAX3zl9hqiNNS5NSpHuC8nAPC2KHMeN2GOvXnTP41
         5k6/C2liPkWAteRJVsM3g9rgKvDqjV800UZU/wKu3UTGDxIiDboAG/0o/CTPaWKv7v4y
         OW3YxxcpeWSugXl332I//b+20+YAJv4zP4ppG/o+p++lwGGgwjOWaj7NLhTEJ3I4XjLi
         6wk99Zrh9pzzc1e1lY75VVAyy4o4ECLQnWFLPBDS7Dugin1qS5EA2GdLZhxhRJ+z+B3n
         pwUj5E0skdiBW9CQoSIEiHppglFD+pHSPiAwJ5UrPUKAYIJKQteTsUmIv999dXq3xkqm
         aI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1P6ETO7aqLXjX0zDdE6kR2mudJHqrRCul2hY3DcmrcY=;
        b=bEd3UDZxkjN/++jsd3R4TBTxG78Znxw3K1o0LVCb0D7FHz7UpmskIfL/FfjvFIIwO9
         gP5ATfbBxwI0Zd4dhMYABrk848lrdqj9G8GONy6TcRZGHInUafnJIqoY+Zrt7tI/LEBW
         l+Dqnl6OkB/7h7lt5eKkuRloYVx0lkBOJp98qSfyFEu+LbrRAsX803P8i8QVlK+QVVuv
         AWRi1lfBGqY63rRV5CZaYMfj1DuCYjGEG7+VX9wzGPosdn8ZwnnNvfttFXXVQw+PGdk2
         2j5OZRflNTvnOFYIqAR2FN0cOua2i9MbfgvaROYBEMsyr85bijv5EE4peKUg2FlyspIB
         i4uw==
X-Gm-Message-State: AOAM531X0chfTOrO4ZgIfAzb1BYWNJyXXUsJmGjMNK+UYFbw56PZEnTe
        A2rKIY9Vwwz90mRRhvnUYKqiIxRM3Ew=
X-Google-Smtp-Source: ABdhPJwJiEPSCK/MtZOAQgGhG39WvHETv/9Vv1DB4omEWHH3t46nNKlPfFq1hUA0+xxVgIDKZW8vjg==
X-Received: by 2002:a05:620a:4489:: with SMTP id x9mr7756154qkp.634.1639953599533;
        Sun, 19 Dec 2021 14:39:59 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:39:59 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 00/14] iio: afe: add temperature rescaling support
Date:   Sun, 19 Dec 2021 17:39:39 -0500
Message-Id: <20211219223953.16074-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan, Peter,

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

Thanks for your time,
Liam

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

Liam Beguin (14):
  iio: inkern: apply consumer scale on IIO_VAL_INT cases
  iio: inkern: apply consumer scale when no channel scale is available
  iio: inkern: make a best effort on offset calculation
  iio: afe: rescale: expose scale processing function
  iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
  iio: afe: rescale: add offset support
  iio: afe: rescale: use s64 for temporary scale calculations
  iio: afe: rescale: fix accuracy for small fractional scales
  iio: afe: rescale: reduce risk of integer overflow
  iio: test: add basic tests for the iio-rescale driver
  iio: afe: rescale: add RTD temperature sensor support
  iio: afe: rescale: add temperature transducers
  dt-bindings: iio: afe: add bindings for temperature-sense-rtd
  dt-bindings: iio: afe: add bindings for temperature transducers

 .../iio/afe/temperature-sense-rtd.yaml        | 101 +++
 .../iio/afe/temperature-transducer.yaml       | 114 +++
 drivers/iio/afe/iio-rescale.c                 | 283 ++++++-
 drivers/iio/inkern.c                          |  40 +-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 705 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  34 +
 8 files changed, 1244 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v9:
 -:  ------------ >  1:  ae3cc93baee6 iio: inkern: apply consumer scale on IIO_VAL_INT cases
 -:  ------------ >  2:  06f66e7f7403 iio: inkern: apply consumer scale when no channel scale is available
 -:  ------------ >  3:  2dbf6b3bbaeb iio: inkern: make a best effort on offset calculation
 -:  ------------ >  4:  b083cf307268 iio: afe: rescale: expose scale processing function
 1:  a0bde29ecc8c !  5:  f46b59690e46 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
    @@ Commit message
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
      ## drivers/iio/afe/iio-rescale.c ##
    -@@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
    +@@
    + #include <linux/of_device.h>
    + #include <linux/platform_device.h>
    + #include <linux/property.h>
    ++#include <linux/units.h>
    + 
    + int rescale_process_scale(struct rescale *rescale, int scale_type,
      			  int *val, int *val2)
      {
      	unsigned long long tmp;
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		return scale_type;
     +	case IIO_VAL_INT_PLUS_NANO:
     +	case IIO_VAL_INT_PLUS_MICRO:
    -+		if (scale_type == IIO_VAL_INT_PLUS_NANO)
    -+			mult = 1000000000LL;
    -+		else
    -+			mult = 1000000LL;
    ++		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? NANO : MICRO;
    ++
     +		/*
     +		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
     +		 * OR *val2 is negative the schan scale is negative, i.e.
 2:  c3d0e6248033 =  6:  80701b87cdf4 iio: afe: rescale: add offset support
 3:  2a81fa735103 =  7:  a3d8fb812678 iio: afe: rescale: use s64 for temporary scale calculations
 4:  8315548d0fce <  -:  ------------ iio: afe: rescale: reduce risk of integer overflow
 5:  223ed0569cd2 !  8:  b83947d96676 iio: afe: rescale: fix accuracy for small fractional scales
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		if (!rem)
     +			return scale_type;
     +
    -+		if (scale_type == IIO_VAL_FRACTIONAL)
    -+			tmp = *val2;
    -+		else
    -+			tmp = 1 << *val2;
    ++		tmp = 1 << *val2;
     +
     +		rem2 = *val % (int)tmp;
     +		*val = *val / (int)tmp;
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		return IIO_VAL_INT_PLUS_NANO;
      	case IIO_VAL_INT_PLUS_NANO:
      	case IIO_VAL_INT_PLUS_MICRO:
    - 		if (scale_type == IIO_VAL_INT_PLUS_NANO)
    + 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? NANO : MICRO;
 -:  ------------ >  9:  c42c8121bcdf iio: afe: rescale: reduce risk of integer overflow
 6:  90044efdf8be = 10:  6c87d491a275 iio: test: add basic tests for the iio-rescale driver
 7:  c4ed463e5fb0 = 11:  3f3d1939b17c iio: afe: rescale: add RTD temperature sensor support
 8:  ff2f0dc248a7 = 12:  0c83d15f3b92 iio: afe: rescale: add temperature transducers
 9:  84bc1f7d1ab5 = 13:  55af6c9391f8 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
10:  1b76cfb37e23 = 14:  8f9cd46c702e dt-bindings: iio: afe: add bindings for temperature transducers

base-commit: 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
-- 
2.34.0

