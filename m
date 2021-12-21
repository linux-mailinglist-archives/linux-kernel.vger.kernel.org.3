Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89D47C88F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhLUVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhLUVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:04:53 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD7AC061574;
        Tue, 21 Dec 2021 13:04:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w16so80376edc.11;
        Tue, 21 Dec 2021 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSrLb7dYTHUZA8U11BNaTP57X5ADiKmqVvZf1uPw7SQ=;
        b=OijFmNAqCvQ84K9TWMkoi9WxR/6ItjiN0O9hy/kNwcLP64rhxwDcIkhPKyOucizUM5
         YFNWngrrqXLgEJRA8wmoE3MwyHlZ03E//wvlrcCEU0fN+foLIkrB4JFSV0rNqfBxETkr
         fAgQM8JBExZ2x+qECkqFGivJXXncEns70BPoYOzGxXioQML+eT0HSUVJwUCvFPvEBUnB
         OgXDf9VmX4S+YatUYkAIDZIqibRQQj0eBEgUhJ5bOC23Y+RjTwkqz9+dBuewb38oBvn0
         yQjvn2Ztvvu8+XyMbcJkWvmDyiBVSTgnldupVW/0ZSKNdcr/0dDq/MmtlB6hShsx2VnF
         Xpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSrLb7dYTHUZA8U11BNaTP57X5ADiKmqVvZf1uPw7SQ=;
        b=dNr9SnEWodzAmlxR9mfI3chAfQeGxtrSDejEEdbToJ4wUEEzgGGJ9Ch5rI24f+LDjb
         S/l/1cZB3M3ExXxS0jyqLRkza6PFLvhkk4sfst8/8OhJL4oUJpWt9LyPhlJqGmR9nTAV
         f0lKMemeYmOXyBCEYfs2T7NA5t0/IcVWk3wFWULSgxs+NZUJ+AEZqTtgO3X/DbVAoeg3
         L6EOMNb2/HqSIvX8QdbrBOFXZV63VKrbFxiYL3IS65UKywIrWfKtVhIXOGwlQPDLQN4o
         ohhSGl2nzhFPRiz025eP6kUtKWiVrtSzm4SCqQuea/Ih0BFR1T4FSUS89YasTFAX4CRf
         b7yw==
X-Gm-Message-State: AOAM531P33sMv1Qcd5/YtQL+hgfN/8IacyIirUBwYdwsmlCwCEYyJgg2
        9P5HBTZ40nTxaUQ831g82G0=
X-Google-Smtp-Source: ABdhPJwMlavRpSLSfhCsCGpnMaWbmyBdiORsm+0M4TWM1mH+OZJIb7tPVEMalex6rAxFjjPpWe0uDg==
X-Received: by 2002:a05:6402:5cc:: with SMTP id n12mr101713edx.246.1640120691317;
        Tue, 21 Dec 2021 13:04:51 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm6355041edr.33.2021.12.21.13.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:04:51 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Refactor ADT7X10
Date:   Tue, 21 Dec 2021 23:04:30 +0200
Message-Id: <20211221210438.2637430-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 -> V2:
 * add device managed action for restoring config
 * merge multiple small related patches into a single patch
   that converts the driver to use devm_hwmon_device_register_with_info
 * switch to devm_request_threaded_irq after switching to
   devm_hwmon_device_register_with_info to make sure that it is impossible
   for the interrupt handler to access the freed hwmon device
 * drop core driver remove callback

Cosmin Tanislav (8):
  hwmon: (adt7410) Pass name to core driver
  hwmon: (adt7x10) Store bus_dev in private data
  hwmon: (adt7x10) Add device managed action for restoring config
  hwmon: (adt7x10) Use devm_hwmon_device_register_with_info
  hwmon: (adt7x10) Use devm_request_threaded_irq
  hwmon: (adt7x10) Remove empty driver removal callback
  hwmon: (adt7x10) Pass hwinfo dev to irq handler
  hwmon: (adt7x10) Use hwmon_notify_event

 drivers/hwmon/adt7310.c |   7 -
 drivers/hwmon/adt7410.c |   9 +-
 drivers/hwmon/adt7x10.c | 281 ++++++++++++++++++++--------------------
 drivers/hwmon/adt7x10.h |   1 -
 4 files changed, 144 insertions(+), 154 deletions(-)

-- 
2.34.1

