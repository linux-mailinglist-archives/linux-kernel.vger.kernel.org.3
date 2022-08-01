Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62185865EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiHAH6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHAH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:58:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C12A419;
        Mon,  1 Aug 2022 00:57:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p10so8868210wru.8;
        Mon, 01 Aug 2022 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=Y3CXIH0jwqqx6A+uwDiGmCDRri5t7Jtz97FJ2TkvUoc=;
        b=kPn3UAvf3iOSs/sSTwGXVFo+znnLOOkx/uczkJka9fLH2Hekoaq0PFNFF0e7cJCM5Z
         8q8sefPQdBYNv5Z9kHzdIEE6+rCUKtLi1lddtGG6g2gO1WKb/VbHk+OZfCgKtMuIhfJH
         vD4IL31OpFaUBw3dzdFXFBzJBonpo+6DY0kC1X415H0uVhs1Anrf9r4Mx4LsEySv+GTN
         oOqLdS4/I4x6SXeFxm0PjPEWOnQujO7rGqf7e1aOOiOdSLDqltw1t82yDVoGRaeJXkgg
         KJK0PIj442xjZ9d526D+Xv+pOI1jcqH4sxvvdVbX55cV19fVWvXQQ6S22920zSeqH1p1
         +nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=Y3CXIH0jwqqx6A+uwDiGmCDRri5t7Jtz97FJ2TkvUoc=;
        b=3ivPr/jzAvP7mlJSTB1Apmql0c+9/hy9nBxP0ilX74UFE/RDqxOIcmAlax3RWRkYHJ
         rYaYL8TDsCCCViiKH9CW7Wu1nUVsAoO48ZFH1RKFGt7x2lyE0AIkQbXvbEY6cTwz3YkG
         YEv12xMOIL7PuZMNpWBrbAO2heiYN4xSJMPh55j6P8+/ibH4tkb6rAyEd3D/iVCi4pVc
         MpKdpXaDPTum9EQmDTYSOEKqcAQe7HqIPBh9QfQjfVmB3g7ijj8FniRxHCGqbe4ZfEIC
         /iClpfhRZ6WS86CWC0NByC+WSI+80t+lF9noRilKt2j4JcptN3wNHBCKLueulxFCTg9w
         lN2w==
X-Gm-Message-State: ACgBeo3Rwdm04+3+VtyQUOUUKHJ4XmHi5Z6/pCYTji16JUJEcBo2dQ8X
        E7vAgrXT8EQn9e1gB0dgJf4=
X-Google-Smtp-Source: AA6agR5hnqPnDz70RK15Qi6W1FFO4MNSInAF5X3HlG2Uzl/9w3ZrXd2tJIIfEGgPI2CCg8OakbR2Og==
X-Received: by 2002:a5d:54c7:0:b0:21e:f007:e67 with SMTP id x7-20020a5d54c7000000b0021ef0070e67mr9503391wrv.382.1659340677946;
        Mon, 01 Aug 2022 00:57:57 -0700 (PDT)
Received: from [192.168.1.126] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id b14-20020a056000054e00b0021f1522c93bsm10029678wrf.45.2022.08.01.00.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 00:57:57 -0700 (PDT)
Message-ID: <38786c4f1217102840eccd50cd9df530caed2add.camel@gmail.com>
Subject: Re: [PATCH v4 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Aug 2022 09:57:56 +0200
In-Reply-To: <20220731171624.3d4bb241@jic23-huawei>
References: <cover.1658597501.git.ang.iglesiasg@gmail.com>
         <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
         <20220731171624.3d4bb241@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On dom, 2022-07-31 at 17:16 +0100, Jonathan Cameron wrote:
> On Sat, 23 Jul 2022 19:39:44 +0200
> Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> 
> > Adds compatibility with the new generation of this sensor, the BMP380
> > 
> > Includes basic sensor initialization to do pressure and temp
> > measurements and allows tuning oversampling settings for each channel.
> > 
> > The compensation algorithms are adapted from the device datasheet and
> > the repository https://github.com/BoschSensortec/BMP3-Sensor-API
> > 
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 
> Hi Angel,
> 
> A comment below. Follows on from comment on previous patch rather than being a
> suggestion to change anything in here (beyond what has already been raised by
> others!)
> 
> Jonathan
> 
> > +static int bmp380_read_calib(struct bmp280_data *data, unsigned int chip)
> > +{
> > +       struct bmp380_calib *calib = &data->calib.bmp380;
> > +       int ret;
> > +       u8 *buf;
> > +
> > +       buf = kmalloc(BMP380_CALIB_REG_COUNT, GFP_KERNEL);
> 
> Ah. The complexity in here explains somewhat why you did it with u8 in the
> previous
> patch.  Probably still better to have a __be16 buffer for that one though
> even though we can't do that here.

Yes, I thought that, although I had to make more cumbersome the conversions and
do the +2 increment on the enum with the index, it would be better to have a
somewhat more uniform structure in each calib reading function.

> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       /* Read temperature calibration values. */
> > +       ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START,
> > buf,
> > +                              BMP380_CALIB_REG_COUNT);
> > +       if (ret < 0) {
> > +               dev_err(data->dev,
> > +                       "failed to read temperature calibration
> > parameters\n");
> > +               kfree(buf);
> > +               return ret;
> > +       }
> > +
> > +       /* Toss the temperature calibration data into the entropy pool */
> > +       add_device_randomness(buf, BMP380_CALIB_REG_COUNT);
> > +
> > +       /* Parse calibration data */
> > +       calib->T1 = get_unaligned_le16(&buf[BMP380_T1]);
> > +       calib->T2 = get_unaligned_le16(&buf[BMP380_T2]);
> > +       calib->T3 = buf[BMP380_T3];
> > +       calib->P1 = get_unaligned_le16(&buf[BMP380_P1]);
> > +       calib->P2 = get_unaligned_le16(&buf[BMP380_P2]);
> > +       calib->P3 = buf[BMP380_P3];
> > +       calib->P4 = buf[BMP380_P4];
> > +       calib->P5 = get_unaligned_le16(&buf[BMP380_P5]);
> > +       calib->P6 = get_unaligned_le16(&buf[BMP380_P6]);
> > +       calib->P7 = buf[BMP380_P7];
> > +       calib->P8 = buf[BMP380_P8];
> > +       calib->P9 = get_unaligned_le16(&buf[BMP380_P9]);
> > +       calib->P10 = buf[BMP380_P10];
> > +       calib->P11 = buf[BMP380_P11];
> > +
> > +       kfree(buf);
> > +       return 0;
> > +}
> > +

Thanks for your comments,

Kind regards,
Angel
