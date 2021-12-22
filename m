Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ABB47CBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbhLVDq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242171AbhLVDqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:46:54 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E2C061574;
        Tue, 21 Dec 2021 19:46:54 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id a9so1156911qvd.12;
        Tue, 21 Dec 2021 19:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wSONo8KMvwsaMcqHHccDd/rtCcU965zl2hwexcD83PQ=;
        b=qAmqev6VherI+L7d/1G0VCDE0c/JRXgulMKsKj0VvMwj69TiG/Q0vSc4+FkAC9F4K2
         ynze2o4u90J99K8vBOVYVUtny88gd62pjWbp9Q9w9/YpPQwPmakFI0XdBBfC5lEeTEtw
         Zq/HwXvYljcox6EG0VitSO9fto5iv3Ej64bQRkW0fYBGh8/elERBY7q7aT6+7EFwYpYL
         RCxuQndQmgdqJoLoqJ0ip1LoJ5DpV2c4cYCcSaQApbq3BLZI11BnpXHR0iclOfVesan+
         eKlTsLhy1UEKSfaXWOfwixrd76qeB2EvGBrL10IVdZUzBdtjvMYUIw62X06IwvAOUhkO
         yATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wSONo8KMvwsaMcqHHccDd/rtCcU965zl2hwexcD83PQ=;
        b=Fy4sIb2HhlkS87X6wxg6C4s0eiIkcaH6WhEfHgT0DVpxtBBY8Sy7KKbadbwUBhO0eK
         Un2dH8Fw4rjSOfYIQe6IsSnsgkVgNO6Uut4jOsgREGPxI+1OhNeZuIzSs5rqLnf1Q1mt
         3+0ygZUCUlHC4G7LvddM55dLjWw3lDHec9oivq4kzYP8KQI7TNVU16HXuQTwmGpK4NIA
         V5UQPLCNNVTXjE1bxG4qUCPojnLn6u4AG95qpDetwHGHeHF8yU9/PmpNURaeZbeGKTyZ
         0OU8USeIOxzYAxLUanVFK30u546PaeXJiEc+90lxH4wEkh+YnKpPcKXcFMbtzfEJkjpj
         pZ9w==
X-Gm-Message-State: AOAM531bDg1RhNWu9/IMPrXwjWVEZN2LAvR9XWB+4eKHSnZmH93LPvnw
        Jmmm1WV6boVa874N5Bow47A=
X-Google-Smtp-Source: ABdhPJyThjuJ6x6sZPVWe44OEpgWieoWlS0t3ouGPwKBqCVGFxXIwZcIeH0u4aXyAJAihxXNcBTQ0A==
X-Received: by 2002:ad4:4ee3:: with SMTP id dv3mr1120623qvb.8.1640144813732;
        Tue, 21 Dec 2021 19:46:53 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:46:53 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 00/15] iio: afe: add temperature rescaling support
Date:   Tue, 21 Dec 2021 22:46:31 -0500
Message-Id: <20211222034646.222189-1-liambeguin@gmail.com>
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

I applied Peter's Reviewed-by only on the unchanged commits, I wasn't
sure it would be okay to do so on the whole series with the few
changes in v11.

Thanks for your time,
Liam

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

Liam Beguin (15):
  iio: inkern: apply consumer scale on IIO_VAL_INT cases
  iio: inkern: apply consumer scale when no channel scale is available
  iio: inkern: make a best effort on offset calculation
  iio: afe: rescale: expose scale processing function
  iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
  iio: afe: rescale: add offset support
  iio: afe: rescale: use s64 for temporary scale calculations
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
 drivers/iio/afe/iio-rescale.c                 | 291 +++++++-
 drivers/iio/inkern.c                          |  40 +-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 705 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  34 +
 8 files changed, 1248 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v10:
 -:  ------------ >  1:  ae3cc93baee6 iio: inkern: apply consumer scale on IIO_VAL_INT cases
 -:  ------------ >  2:  06f66e7f7403 iio: inkern: apply consumer scale when no channel scale is available
 1:  2dbf6b3bbaeb !  3:  1717b82460c0 iio: inkern: make a best effort on offset calculation
    @@ drivers/iio/inkern.c: EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
     +			offset_val /= offset_val2;
     +			break;
     +		case IIO_VAL_FRACTIONAL_LOG2:
    -+			offset_val /= (1 << offset_val2);
    ++			offset_val >>= offset_val2;
     +			break;
     +		default:
     +			return -EINVAL;
 2:  b083cf307268 =  4:  6fc26588f651 iio: afe: rescale: expose scale processing function
 3:  f46b59690e46 =  5:  8e63c4036157 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
 4:  80701b87cdf4 !  6:  eea57faec241 iio: afe: rescale: add offset support
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		*val = div_s64(tmp, scale) + schan_off;
     +		return IIO_VAL_INT;
     +	case IIO_VAL_INT_PLUS_NANO:
    -+		tmp = (s64)rescale->offset * 1000000000;
    -+		tmp2 = ((s64)scale * 1000000000L) + scale2;
    ++		tmp = (s64)rescale->offset * NANO;
    ++		tmp2 = ((s64)scale * NANO) + scale2;
     +		*val = div64_s64(tmp, tmp2) + schan_off;
     +		return IIO_VAL_INT;
     +	case IIO_VAL_INT_PLUS_MICRO:
    -+		tmp = (s64)rescale->offset * 1000000L;
    -+		tmp2 = ((s64)scale * 1000000L) + scale2;
    ++		tmp = (s64)rescale->offset * MICRO;
    ++		tmp2 = ((s64)scale * MICRO) + scale2;
     +		*val = div64_s64(tmp, tmp2) + schan_off;
     +		return IIO_VAL_INT;
     +	default:
 5:  a3d8fb812678 =  7:  6bc5dd8c92ac iio: afe: rescale: use s64 for temporary scale calculations
 6:  b83947d96676 =  8:  7d426d67a7fd iio: afe: rescale: fix accuracy for small fractional scales
 7:  c42c8121bcdf =  9:  dbea6ae8fec2 iio: afe: rescale: reduce risk of integer overflow
 -:  ------------ > 10:  9ab1138449d3 iio: afe: rescale: make use of units.h
 8:  6c87d491a275 = 11:  3006151cd193 iio: test: add basic tests for the iio-rescale driver
 9:  3f3d1939b17c ! 12:  d4229e8d7f24 iio: afe: rescale: add RTD temperature sensor support
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_voltage_divider_props(struct d
     +		return ret;
     +	}
     +
    -+	tmp = r0 * iexc * alpha / 1000000;
    -+	factor = gcd(tmp, 1000000);
    -+	rescale->numerator = 1000000 / factor;
    ++	tmp = r0 * iexc * alpha / MICRO;
    ++	factor = gcd(tmp, MICRO);
    ++	rescale->numerator = MICRO / factor;
     +	rescale->denominator = tmp / factor;
     +
    -+	rescale->offset = -1 * ((r0 * iexc) / 1000);
    ++	rescale->offset = -1 * ((r0 * iexc) / MICRO * MILLI);
     +
     +	return 0;
     +}
10:  0c83d15f3b92 ! 13:  b93e303c5e60 iio: afe: rescale: add temperature transducers
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_temp_sense_rtd_props(struct de
     +		return ret;
     +	}
     +
    -+	rescale->numerator = 1000000;
    ++	rescale->numerator = MICRO;
     +	rescale->denominator = alpha * sense;
     +
     +	rescale->offset = div_s64((s64)offset * rescale->denominator,
11:  55af6c9391f8 = 14:  7bdd57435c5c dt-bindings: iio: afe: add bindings for temperature-sense-rtd
12:  8f9cd46c702e = 15:  604ef3e42c07 dt-bindings: iio: afe: add bindings for temperature transducers

base-commit: 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
-- 
2.34.0

