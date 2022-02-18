Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8732B4BB0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiBREVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:21:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiBREU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:20:59 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235E1AE902;
        Thu, 17 Feb 2022 20:20:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z16so1387711pfh.3;
        Thu, 17 Feb 2022 20:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1yxUZLK8xuc3jAqkhxQ+Q3b8VX/f+Cpb+qmUUmvVuWA=;
        b=d35aFZ4lQyIgEfravviCbYY5LozfEAnpvcJ+gwwvVLrCSi43dqt3wf+ibHKR0VtT94
         RbmolgnuD9x+1G4LrHPDjTzBaD5OEj5PU8A4W+ukMrUklE+h2Xlr/H7KCldYd94sCwmc
         jGFR9wvTJXQd5sB4YxUysApnpNV9XcIC8DuC6yozXl3jwnWNJJSwGlKOrsh3qySLAnPJ
         +jlgtckV3+lL1HcZWO7OYOXHGWiKyB6DioMk8e3SfPDgW2TrY//LkuKSIrGpof4CkEUU
         qKfsfa8Xdj2Ha5dY6C2m+WZsweJ4CdthlF8uYxrlKwTuqSTW7F66Sj1fXvlTnRQT3EBc
         RHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1yxUZLK8xuc3jAqkhxQ+Q3b8VX/f+Cpb+qmUUmvVuWA=;
        b=QVukaB46wIGB8APoHrKLh58hprkYccUtgBO0oF0atGVIxprHUITmZUq9bJWqtd4lya
         eqLNNIgTZAK95noUZiqQWCJxswfnpbOfbUt7QHfAQ5uTCqGTO86FrYAszt/elpYO+tz7
         ZyWXZvOm9g2eZjE+XMKBZFwtNHnoFdsfU2lu6R5jcP4oc7naYCOU1aCg0bHwRgHbtjtC
         rsWpEILRrJtHINvo84+eAmba7641E96ybtv7PRrrIiyMXVDI3q5jLL+fYYomMAVCjcjo
         6Bu8X6YR/3hPT4sk++PbTK3OvTxprINbht9LiIirsQCOHdRf66n5g0aUfd6bxZHW4w1v
         NJZQ==
X-Gm-Message-State: AOAM532JgxbMIQvJ15AfbTnurmYNsxPq8x+tayS9OAxo3toaXcV+RLnh
        3WQCO9ovyaufG45R0wJiUO8=
X-Google-Smtp-Source: ABdhPJxBBybc7NkmGRPGMr+0OrJC9GN0ZlK4UaEox3wpM+J52sOJvcbKh0RSX29ypwOXGLZxPgn62g==
X-Received: by 2002:a65:6c0d:0:b0:364:ae2e:9708 with SMTP id y13-20020a656c0d000000b00364ae2e9708mr5017386pgu.189.1645158043094;
        Thu, 17 Feb 2022 20:20:43 -0800 (PST)
Received: from localhost.localdomain ([60.243.248.66])
        by smtp.gmail.com with ESMTPSA id h26sm9530300pgm.72.2022.02.17.20.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 20:20:42 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] iio: potentiometer: Add support for DS3502
Date:   Fri, 18 Feb 2022 09:50:32 +0530
Message-Id: <20220218042038.15176-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings and support for Maxim DS3502 into existing ds1803 driver.
DS3502 is a 7 bit Nonvolatile Digital Potentiometer.

Changes since v2:
1. Addressed Andy Shevchenko comments.
2. Adding device name in Kconfig file.
3. Spliting up of patch into 3 patchs.
4. Adding channel info into ds1803_cfg in separate patch.
5. Dropping the use of enum in firmware data instead using previous
   pointer method for accessing device specific data.
6. Separate patch for using firmware provided data instead of 
   id->driver_data.
7. Adding DS3502 support in separate patch.

Changes since v1:
1. Fixes the alignment to match the open parenthesis in separate patch.
2. Adding available functionality for ds1803 driver in separate patch.
3. Moving maxim_potentiometer members into ds1803_cfg structure.
4. Droping of the INFO_ENABLE channel type.
5. Firmware entry with data is used instead of id->driver_data to
   to retrieve the chip specific data.

Jagath Jog J (6):
  iio: potentiometer: Alignment to match the open parenthesis
  iio: potentiometer: Add available functionality
  iio: potentiometer: Add channel information in device data
  iio: potentiometer: Change to firmware provided data
  iio: potentiometer: Add support for Maxim DS3502
  dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/iio/potentiometer/Kconfig             |   6 +-
 drivers/iio/potentiometer/ds1803.c            | 136 +++++++++++++-----
 3 files changed, 103 insertions(+), 41 deletions(-)

-- 
2.17.1

