Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400664ACEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbiBHCJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345412AbiBHCEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:50 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6449C061355;
        Mon,  7 Feb 2022 18:04:48 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id o10so12681899qkg.0;
        Mon, 07 Feb 2022 18:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTJJEVCI8kkMfyPi35GPF06ZfvARMKMpk6nImB4obBM=;
        b=ol+SVqBmUKU/WWdOrKWkzXYxSeNNwTn8Wkk1HlBpCt0pcwsQTgu7MYEFPfzlAElYP1
         dPYwm36VJE20+55jzMbYlwRv+wRSEUEeizaUH+Iq5VFyGDvJVXUZd8tQGHlpExGvmfmT
         bpOWybucP3TBFBZ2bqOnQpEy1g5wjyc4Qc8//uM6G6lFReKVihqIKKPFFiN854G23Usb
         VWli2lIkXULzEbUlrR577JK+ZYCOJAC+1swokhFE2hbKREB7B4aS6/uXIq2jKdijVnc4
         XurpXu/bys02Jx5WwdK8VuLI4wIQBJVHPRasDtkGpYWTHApphZs1GKWYEAuHMoNEgIhD
         hz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTJJEVCI8kkMfyPi35GPF06ZfvARMKMpk6nImB4obBM=;
        b=T8W20yyI1ArXHw1ht+ToA8FI5gbDesUgo9D8JWYJ9kUR1G/+MTbAqJ4jN+fnWSEP7Y
         /spfyYDTdajpAR746HJ267Vp3Nk+O+WVwvp0UZiNjbMA47QbtH/GbX9Qs5x5s3UkKp6/
         m0uGZwqvUi98USPId7UjbB1CShk8UpZFCNfJ+it5ZkgHsaemOSEqztnlAtHwF4vpp5ap
         99K7vwE/ZTRG05WAa9KMvhjcafmmvpsGrW3X9Gg61EiXyYmxJhfUyVeSy4PyV/QYabKQ
         HQ7Fv8zdlDkYhEfKT+nfIscRvZZGcDSLAZJoynVJ3hC3otQ803+ZqPF8OAlM2CnNfmAl
         u//Q==
X-Gm-Message-State: AOAM531yn5cUnRdtdn7RMQk6Je2qq4w9WIpjZHnjDJep2DMJYj8KyASE
        TnI9Wj7Q/vpDRhUFZtwwqN7HErL2Tck=
X-Google-Smtp-Source: ABdhPJymDvWvzaCxJWaQbRqJXQeLT7/4hH0Tx2meu+HV+cj9y/zZC+c+iJFdhTGU8eFdKX7ZZPDA4Q==
X-Received: by 2002:a05:620a:4481:: with SMTP id x1mr1472207qkp.629.1644285888040;
        Mon, 07 Feb 2022 18:04:48 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:47 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 00/11]  iio: afe: add temperature rescaling support
Date:   Mon,  7 Feb 2022 21:04:30 -0500
Message-Id: <20220208020441.3081162-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes since v13:
- fix SI prefix in rescale_temp_sense_rtd_props()
- add comment explaining SI prefixes are sometimes used as mathematical
  multipliers with no particular physical meaning associated.

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
 drivers/iio/afe/iio-rescale.c                 | 297 +++++++-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 711 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  36 +
 7 files changed, 1231 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v13:
 -:  ------------ >  1:  ee26b0eeac65 iio: afe: rescale: expose scale processing function
 -:  ------------ >  2:  a510097c83f1 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
 -:  ------------ >  3:  8f2f2699a9b4 iio: afe: rescale: add offset support
 -:  ------------ >  4:  2efa970bad26 iio: afe: rescale: fix accuracy for small fractional scales
 -:  ------------ >  5:  201037c0ead8 iio: afe: rescale: reduce risk of integer overflow
 1:  0e3bf50d9eb2 !  6:  a0037cc3ee90 iio: afe: rescale: make use of units.h
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
      		fallthrough;
      	case IIO_VAL_FRACTIONAL_LOG2:
     -		tmp = (s64)*val * 1000000000LL;
    ++		/*
    ++		 * GIGA is used here as an arbitrarily large multiplier to avoid
    ++		 * precision loss in the division. It doesn't have any physical
    ++		 * meaning attached to it.
    ++		 */
     +		tmp = (s64)*val * GIGA;
      		tmp = div_s64(tmp, rescale->denominator);
      		tmp *= rescale->numerator;
 2:  72813d9788e4 =  7:  f8d47728f482 iio: test: add basic tests for the iio-rescale driver
 3:  8ee4c16355af !  8:  a04685586340 iio: afe: rescale: add RTD temperature sensor support
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_voltage_divider_props(struct d
     +	rescale->numerator = MEGA / factor;
     +	rescale->denominator = tmp / factor;
     +
    -+	rescale->offset = -1 * ((r0 * iexc) / MEGA * MILLI);
    ++	rescale->offset = -1 * ((r0 * iexc) / KILO);
     +
     +	return 0;
     +}
 4:  36a9bb066369 =  9:  e3b716aaee50 iio: afe: rescale: add temperature transducers
 5:  581962b44cf3 = 10:  22ae1458eb8b dt-bindings: iio: afe: add bindings for temperature-sense-rtd
 6:  d09d377b05ac = 11:  33825ad452d6 dt-bindings: iio: afe: add bindings for temperature transducers

base-commit: cd717ac6f69db4953ca701c6220c7cb58e17f35a
-- 
2.35.1.4.g5d01301f2b86

