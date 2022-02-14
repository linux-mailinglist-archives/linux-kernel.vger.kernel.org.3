Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98B84B4057
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiBNDgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:36:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiBNDgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:36:32 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A860955499;
        Sun, 13 Feb 2022 19:36:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v4so13301122pjh.2;
        Sun, 13 Feb 2022 19:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=f3jKCxZz79yoCVjIE/GhM4SSk5VSPr4MEx9bSap5HVE=;
        b=hu5KrUWCd4RCeN8bABh7BbryxBQjFEsBedmue3Ek/yUQx3JT8iv8SM/gRMY1VlZlJT
         /PiRnXAvxjCb607of/71NYxcO0KF+2Bf8OaVvKeO1lkoJcOJLcaaO2tDQye3GieYyVTY
         LcpapNw+BoXEzPBhTUinJMxLnewptmgjjyw9sgu5TckNdG6f9ptjNlaayXTR6/Uy1owy
         IVD8Rv5n+PSPba62WK3V6k0Yr4P4zNCQypzTOmbX0u+drA/FyjrV8da77Wxz9qIXZk+A
         S5pMiIouPwhQ2WGybyq6S8zsOsloAYs5SQrJ8QnyOtZDDZkPKuojzs03BM2OSHK+huqP
         VcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f3jKCxZz79yoCVjIE/GhM4SSk5VSPr4MEx9bSap5HVE=;
        b=a/nwAh6s5P9y7jkAmjUHtmemN1ET7VTJHEdnC/5aSP84OT9ZZKoQVX/jBxElxzWHlQ
         nyaSNB8yeyRVYk0eKCjUmdll+tBk+ynW957fns9wjWdCdtKEVVck7oVY7FfLw0huiJD7
         J5BbrcQeypVh2bgYcGWejobkHrSgkmBfB86eUBEkWGZjmIp0nYA9kwDGLa1Ob4GVPzJ2
         jkwua6UHxDLeKnG2IrbHq1w1I91FSJwf11/d4Ju+XnaTf7+SIiPk44wYN/qg/LX7rRal
         wh5Obvo8r6MLT2E6FMoCD7G0mskw612qRNslQEpDly1PCG6XCyInWWvwmc+6eDiZbpNK
         HNtg==
X-Gm-Message-State: AOAM5331gr4toMKYsJulS5siUGlGkEWZWUDx2XS8emhRk9xQHzqFqEzu
        z7yAMP9Ks3xnfxJgEGFRG58=
X-Google-Smtp-Source: ABdhPJzLE0eJiTiiQoeFyETOWRfAeP1HZF9TKsnzLgNlg9TPkpXc/mIlJAHFQpPt3kpgz1YB49rhfA==
X-Received: by 2002:a17:902:ba98:: with SMTP id k24mr12140443pls.44.1644809785129;
        Sun, 13 Feb 2022 19:36:25 -0800 (PST)
Received: from localhost.localdomain ([27.7.103.158])
        by smtp.gmail.com with ESMTPSA id me14sm36012pjb.41.2022.02.13.19.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 19:36:24 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iio: potentiometer: Add support for DS3502
Date:   Mon, 14 Feb 2022 09:06:16 +0530
Message-Id: <20220214033620.4059-1-jagathjog1996@gmail.com>
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

Changes since v1:
1. Fixes the alignment to match the open parenthesis in separate patch
2. Adding available functionality for ds1803 driver in separate patch
3. Moving maxim_potentiometer members into ds1803_cfg structure
4. Droping of the INFO_ENABLE channel type
5. Firmware entry with data is used instead of id->driver_data to
   to retrieve the chip specific data.

Jagath Jog J (4):
  iio: potentiometer: Alignment to match the open parenthesis
  iio: potentiometer: Add available functionality
  iio: potentiometer: Add support for Maxim DS3502
  dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/iio/potentiometer/Kconfig             |   6 +-
 drivers/iio/potentiometer/ds1803.c            | 141 +++++++++++++-----
 3 files changed, 106 insertions(+), 43 deletions(-)

-- 
2.17.1

