Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2D4C97B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiCAVYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237410AbiCAVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:24:42 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BAE3A710
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:24:01 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c7so14025132qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 13:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1hxW1EGVkY2JeE6b+2heOI5s0Cr26hXM37u0kOu84ew=;
        b=7EC0WjPjpVXX5wLzTCQ1zWHQ2/F0THAIt3QBUTkc8M8BzqOtaotoaSiloAzG6Nlkr2
         40s87cb4Hz1S7+O6OTGwOk2SNQUND59+6VS/jNMQMGqU6FwPamkdQ15ptWeTjx+5mmK6
         U3rUd6FUkMTRPrdV/TldBhMNv2053+SGa3BvI9gRzDXN/K4jXboBBe4yUqJX1QDeUI2+
         tNwMHZPGaPAkGazIQPoHmaTb14W4jMR/QxsC5f2bwf2CKuGUXiknORvKHDHWa7QwDLHs
         omqlkRTdNXmdoIA4Xbra/XcLzIqigrUZGFO4N08MNqUbv3L7LT2lrrJx+ybY3vLSk/aw
         kq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1hxW1EGVkY2JeE6b+2heOI5s0Cr26hXM37u0kOu84ew=;
        b=8SZHyk3slvBp+vt11LTnbURe1gPqbkNUsMnXqzVKYFvhVN56t15SyFseyMd+aaaRva
         +mLYcdU5OHquLOnBuqZ/zHpDfsJPwjVXwIw2xdoyPBzHBIiMstSBBZtqUJGoymvPMff5
         jlSLtL9Skcz3Ja2ZXXAdcOP9LRxFyDzwpU8sONIKvS6esHzcnCDHa5NdJhWBEyZ48Mtp
         eyIIpODkGem2wGOYNfid818Q62l0e/L8eARDrI+2FYFX/Mb7Mf/tMaPl0wN+lpIvxMW2
         qstuJkZOiC2EbKsumPlHQSCaeTsClFMbbKuvzxi2QTPSM3rFoqjHWKiVEssGI6aX7X0Q
         Oivg==
X-Gm-Message-State: AOAM5303NEQeolHTaW/emt4HMxTBqVjNJvT4c9agSlNuqKVAvDPDHj/Z
        tZqP5a1xRccLCgJZns8mSiHW4g==
X-Google-Smtp-Source: ABdhPJwY0aoBJrEONgibzMk7/y+sRBTD6g5QfO5xkwuHNI8ic+sDHMDAa187VNsVRjQq7qpNq+4P/w==
X-Received: by 2002:a37:5d2:0:b0:5e9:5876:7f0 with SMTP id 201-20020a3705d2000000b005e9587607f0mr14619695qkf.4.1646169840382;
        Tue, 01 Mar 2022 13:24:00 -0800 (PST)
Received: from localhost ([2605:a601:a665:9200:a5cf:2f00:e792:9b5b])
        by smtp.gmail.com with ESMTPSA id g2-20020a37e202000000b00607e264a208sm7072611qki.40.2022.03.01.13.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:24:00 -0800 (PST)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date:   Tue, 1 Mar 2022 16:23:59 -0500
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for 5.17
Message-ID: <Yh6O7wmp8HCjxOn3@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes for 5.17.  Please consider pulling them.

Thanks,
Jon



The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.17-bugfixes

for you to fetch changes up to 9b818634f8e7e0bca3386a50b1fada7a49036408:

  MAINTAINERS: update mailing list address for NTB subsystem (2022-02-02 17:34:18 -0500)

----------------------------------------------------------------
Bug fixes for sparse warning, intel port config offset, and a new
mailing list

----------------------------------------------------------------
Dave Jiang (2):
      ntb: intel: fix port config status offset for SPR
      MAINTAINERS: update mailing list address for NTB subsystem

Gustavo A. R. Silva (1):
      NTB/msi: Use struct_size() helper in devm_kzalloc()

 MAINTAINERS                        |  8 ++++----
 drivers/ntb/hw/intel/ntb_hw_gen4.c | 17 ++++++++++++++++-
 drivers/ntb/hw/intel/ntb_hw_gen4.h | 16 ++++++++++++++++
 drivers/ntb/msi.c                  |  6 ++----
 4 files changed, 38 insertions(+), 9 deletions(-)
