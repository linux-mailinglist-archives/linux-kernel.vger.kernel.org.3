Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576ED4A3762
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355474AbiA3QLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344953AbiA3QLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:17 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0882C061714;
        Sun, 30 Jan 2022 08:11:16 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id d8so10584236qvv.2;
        Sun, 30 Jan 2022 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzxhhdUiPgX+hCQgfRaiQzFKENo+0Wnw2QbKi28F/g8=;
        b=M3+lDYYZiWlhuhKELh7VN5Q201mDtkyYNl+rohsfDERgEoV2sJODufPl8vKUli9JJZ
         1PmCBS/QdEyyYF67vgpiI5mTKG+WWqaqB9le6JY2FRfMiLmkyjz5AuPRlbXRJEtoaO0s
         uC5pGbsbHzXOl2j18k6ihH/kZFYLEmAKDISRLX7b9Uuu4UClEGk4nppg0omosovlKg8v
         jIr8elbgkggIIriu2P48B1KdDJP6oca6OeXwWQuFjfGuIOTqkvItia9CXg8jY9GlPGcX
         GYX4I+A4haqF/C+YNk+uF5vGVvjETi6ZDSfLJOkGr9vnCPRzr1mLnVrbaJKuAerMbpJ3
         fJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzxhhdUiPgX+hCQgfRaiQzFKENo+0Wnw2QbKi28F/g8=;
        b=xk6pxEyYwAeeWCcY1g8WPf9mJ1CCizrSZxH0+9f4jazesunVfGL/16cbL69i1OBm7R
         e86NQPG0YLi/Q9Dl/r+8lUARo6IPd3P5JcO6zrkV5ckHIdenqDNmQJEwyK+ga6K7qJj3
         TVzaQQoxBPlQwftoMjc+VrnsljO/CtFVMEykGHN4WCA/sDYGB/f6g4RHD0/2AmWOPMZI
         2HKQ0X9nmav22fiQsVBa+CpCL9bhg0QQYSesWQ7ePJ0Do6yOejVLlACAJd3mdEsUKnFc
         9PRlrCbpBR4ojHPY20ycPKP+Gl+vTGyMwBW6UG6jpU3UVH5e167BUe7ilIpG20jKM7ax
         BUFQ==
X-Gm-Message-State: AOAM530QDizHpyU7eRzLPQnJYnVRUPZ8SaNuhbinxKoE7Hj7leTp6IW/
        PYPpgGW/k35j7tPtmTXuWWdOF0DdOFM=
X-Google-Smtp-Source: ABdhPJxuUGfF40PwYVBOyTGGsbvA77PPU7FZQaF7g877M/0FFIU+bPHnElV2GnCe7fjEYb8Ff0tEHA==
X-Received: by 2002:a05:6214:400f:: with SMTP id kd15mr14249830qvb.69.1643559076008;
        Sun, 30 Jan 2022 08:11:16 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:15 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 00/11] iio: afe: add temperature rescaling support
Date:   Sun, 30 Jan 2022 11:10:50 -0500
Message-Id: <20220130161101.1067691-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan, Peter, Andy,

This series focuses on adding temperature rescaling support to the IIO
Analog Front End (AFE) driver.

The first few patches from previous iterations addressing minor bugs in
IIO inkernel functions have been taken in, and are no longer in v13.

The main changes to the AFE driver include an initial Kunit test suite,
support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
and temperature transducer sensors.

I'm not quite sure what happened with the left-shift change last time,
I had it in my v12 local branch, it seems I got mixed up before sending.

Thanks for your time,
Liam

Changes since v12:
- rebase on latest testing branch
- fix copyright holder in newly created header file
- add myself as a copyright holder of the iio-rescale.c driver at
  Peter's suggestion
- fix undefined behavior on left-shift operation

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


Liam Beguin (11):
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
 drivers/iio/afe/iio-rescale.c                 | 292 ++++++-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 711 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  36 +
 7 files changed, 1226 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v12:
 1:  a8ca9300ef2a <  -:  ------------ iio: inkern: apply consumer scale on IIO_VAL_INT cases
 2:  efaeceac8d87 <  -:  ------------ iio: inkern: apply consumer scale when no channel scale is available
 3:  8131208a4454 <  -:  ------------ iio: inkern: make a best effort on offset calculation
 4:  06202d8f6481 <  -:  ------------ iio: afe: rescale: use s64 for temporary scale calculations
 5:  87b9d77f0d30 <  -:  ------------ iio: afe: rescale: reorder includes
 6:  e9bf09ca9703 !  1:  ee26b0eeac65 iio: afe: rescale: expose scale processing function
    @@ include/linux/iio/afe/rescale.h (new)
     @@
     +/* SPDX-License-Identifier: GPL-2.0-only */
     +/*
    -+ * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
    ++ * Copyright (C) 2018 Axentia Technologies AB
     + */
     +
     +#ifndef __IIO_RESCALE_H__
 7:  865296d2bc4f =  2:  a510097c83f1 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
 8:  aea3159ed169 !  3:  8f2f2699a9b4 iio: afe: rescale: add offset support
    @@ Commit message
         Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
    +@@
    +  * IIO rescale driver
    +  *
    +  * Copyright (C) 2018 Axentia Technologies AB
    ++ * Copyright (C) 2022 Liam Beguin <liambeguin@gmail.com>
    +  *
    +  * Author: Peter Rosin <peda@axentia.se>
    +  */
     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
      	}
      }
 9:  7b518cba1cb5 =  4:  2efa970bad26 iio: afe: rescale: fix accuracy for small fractional scales
10:  79844ae7461c !  5:  201037c0ead8 iio: afe: rescale: reduce risk of integer overflow
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		if (scale_type == IIO_VAL_FRACTIONAL)
     +			tmp = *val2;
     +		else
    -+			tmp = 1 << *val2;
    ++			tmp = ULL(1) << *val2;
      
      		rem2 = *val % (int)tmp;
      		*val = *val / (int)tmp;
11:  19f28d029522 =  6:  0e3bf50d9eb2 iio: afe: rescale: make use of units.h
12:  18b743ae2f8b =  7:  72813d9788e4 iio: test: add basic tests for the iio-rescale driver
13:  240a3f1424fc =  8:  8ee4c16355af iio: afe: rescale: add RTD temperature sensor support
14:  d7dc1e1f8f9c =  9:  36a9bb066369 iio: afe: rescale: add temperature transducers
15:  c0a94061491a = 10:  581962b44cf3 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
16:  b29eed6b4e17 = 11:  d09d377b05ac dt-bindings: iio: afe: add bindings for temperature transducers

base-commit: cd717ac6f69db4953ca701c6220c7cb58e17f35a
-- 
2.35.1.4.g5d01301f2b86

