Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB34C1605
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiBWPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiBWPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:00:44 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548AB7176;
        Wed, 23 Feb 2022 07:00:16 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id y7so18565501oih.5;
        Wed, 23 Feb 2022 07:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxVydygDoB9KTpxxDGgWfkoHyxwpvYNL1uFIW7uwN1w=;
        b=lTGdl/IjKd1CebEr17BY47QhDP1zLUGRlrNb4JUA20msKqpC0eIs0bScZ1Yrq0lCh3
         +lj5ewBnoDk09zS4a6+G1UjekJ/x3PemeHcLmzA2pqEgn6vjcdz4w6BEk1b6LqeEhzuw
         PADD8OmaHzFDytolJGcqZqKUlubWcngWNBLwwmodZlvs5gzhwBO93fBypB7zL46DQTun
         8FRIWoed4V81/MpXZ4oW+8Mu5Y3/gXyeIGuQVbkVnsSqUpIrT0jvCjQPBE5Io5EsCcnU
         oVsSbKGUuK2sM+21sboBFNJqVyXMzMf6+sf3zWBriAkPD7BwDLhK7vJlqlHXr6nPpISk
         c6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=AxVydygDoB9KTpxxDGgWfkoHyxwpvYNL1uFIW7uwN1w=;
        b=q3DRbFQQjdwlN8zqRyVf7JjFFXZnbWxDNLWZOaLM7/gBFKbL0gbxtKVWoZxVV9sec0
         ORnC5Te6n5mq5XUGne0kFATFqf6I9vxvmxTDVvHW/JBu4JSHoKB/c/Nk1Mv03u7ifOFZ
         kuxWyMn3b5DTx7ZWvhsdJyXElm2qn4kLo6mWlL5nZ+hcjUpt9quKzimsw/eBhmTFR7M2
         S/zynOY7E7fIj3E/V7Xj/pGRsSzFvwMH9HAuOSsaf0GtAnZDNZD/PjJZztMbR3WnLTjV
         /beUXp/u1juqXb2B0Jkkosuo4cJ6u0As6Dut0ruv+A09s+GEOHCZRujOx1COJInCAz09
         HfVA==
X-Gm-Message-State: AOAM530MCFEsaBxLE+Z0y3nttWUmepnVFP8l4c6BYcFoIqueJnU3x76Q
        3y99wK+6186jnu8GgLEw7+QCAW4U9HpFaQ==
X-Google-Smtp-Source: ABdhPJyEnb6Y1KQkd9rcyq+ivzqptP9ziB5RoAj4I9Kzqk9ed84vZeaj1Bbcpu0z6moFcXz4DqZkgA==
X-Received: by 2002:a05:6808:1693:b0:2d2:4d84:5220 with SMTP id bb19-20020a056808169300b002d24d845220mr4849950oib.146.1645628414718;
        Wed, 23 Feb 2022 07:00:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q32sm6745422oiw.25.2022.02.23.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 07:00:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.17-rc6
Date:   Wed, 23 Feb 2022 07:00:12 -0800
Message-Id: <20220223150012.2176490-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.17-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17-rc6

Thanks,
Guenter
------

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.17-rc6

for you to fetch changes up to 35f165f08950a876f1b95a61d79c93678fba2fd6:

  hwmon: (pmbus) Clear pmbus fault/warning bits after read (2022-02-22 08:15:39 -0800)

----------------------------------------------------------------
hwmon fixes for v5.17-rc6

Fix two old bugs and one new bug in hwmon subsystem.

- In pmbus core, clear pmbus fault/warning status bits after read
  to follow PMBus standard
- In hwmon core, handle failure to register sensor with thermal
  zone correctly
- In ntc_thermal driver, use valid thermistor names for Samsung
  thermistors

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: Handle failure to register sensor with thermal zone correctly

Linus Walleij (1):
      hwmon: (ntc_thermistor) Underscore Samsung thermistor

Vikash Chandola (1):
      hwmon: (pmbus) Clear pmbus fault/warning bits after read

 drivers/hwmon/hwmon.c            | 14 ++++++++------
 drivers/hwmon/ntc_thermistor.c   |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c |  5 +++++
 3 files changed, 14 insertions(+), 7 deletions(-)
