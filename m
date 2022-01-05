Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC1484CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiAEDNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiAEDNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:13:17 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D39C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 19:13:17 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id r139so36031854qke.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 19:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JHatubtiV924nh1UxFIEahD8wrBVeel+DPI/jX0ljY=;
        b=kcJ5YMDT4L2hFhxJuz1Q3+Z6lSwUpdi0ormavnByQgjUeNCR1gwkZJFwSXaLre8s4U
         6GZu6LSJq1i2NEEoBf9cqiQPRnBPttP16KTiegM3dfLWtYquOzQEGHI0UXuxWL+7dfet
         /1a6KPqNu5mfK3dRl3mwuSn3sMRDKQu0ar2ynguhtaUzZKWXZkOkHclUcbtzMfUJAOBm
         Bl7Ahz026tG4QLomU4q3Xdu+5+bsTniXnbAmq/YyI5PbDOxWBLkBJG6LqQj6+t70fMHJ
         L+IsTpD0vpsjp2sPma8H9qlfwhXX0QT+GIL6KNTwcS2DpTNru7DacpEUxh3nRZ707mb+
         PExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JHatubtiV924nh1UxFIEahD8wrBVeel+DPI/jX0ljY=;
        b=cjCHdPYhdwUrODkkSYGzfLaDgFSFfnp2qQ7ZRwPZWcbMQEleySdKgDujJ4h2FmXGzY
         fj8EvQqh/kqdo/L6qWQLHp/5Iu9DPiBoUkm7q5OshqwhVrstv0tBEse4m12Oz41BnMd2
         tHddfxBxYLQMjJSBtSoCbWpwnL/h3uIN7NEi2BrnzyVRQt4SLkF8mKxUSUqNFQ7kN30X
         rhfx9tGUCH7B/EVWIr7W+AxtTb81SKaIyyBIahV3FSVr5QqFKRQ+TT+inufZkapFxZec
         eYfoman4/nInqrJ3I7aE5GLEBUEU3Whb23CsZ8m6tc0x0WdbF56wThtQZVbbelkj/tIo
         EmWQ==
X-Gm-Message-State: AOAM532gRXNNifbhB4dbKbwqU46P3rT+K5nU9LomxygocOTSZ2+UOFOE
        bkcDxLHPOD+DJ3DsNXs0f/6WtMj+aRNLTQ==
X-Google-Smtp-Source: ABdhPJyMxuY1w6YrTjBadtST2iXLlrQodhQhe+hzNv939NFKx98hdZRpvJIlR7ikifSK+C5wYqgGfA==
X-Received: by 2002:ae9:e905:: with SMTP id x5mr37665782qkf.468.1641352396274;
        Tue, 04 Jan 2022 19:13:16 -0800 (PST)
Received: from rigel.delfino.n.howett.net ([2600:1700:df50:a7cf::725])
        by smtp.googlemail.com with ESMTPSA id s6sm32629632qki.23.2022.01.04.19.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 19:13:15 -0800 (PST)
From:   "Dustin L. Howett" <dustin@howett.net>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>
Subject: [PATCH 0/2] platform/chrome: Add support for the Framework Laptop
Date:   Tue,  4 Jan 2022 21:12:40 -0600
Message-Id: <20220105031242.287751-1-dustin@howett.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Framework Laptop to the cros_ec
LPC driver.

The Framework Laptop is a non-Chromebook laptop that uses the ChromeOS
Embedded Controller. Since the machine was designed to present a more
normal device profile, it does not report all 512 I/O ports that are
typically used by cros_ec_lpcs. Because of this, changes to the driver's
port reservation scheme were required.

Dustin L. Howett (2):
  platform/chrome: cros-ec: detect the Framework Laptop
  platform/chrome: reserve only the I/O ports required for the MEC EC

 drivers/platform/chrome/cros_ec_lpc.c          |   47 ++++++++++-----
 include/linux/platform_data/cros_ec_commands.h |    4 +
 2 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.34.1

