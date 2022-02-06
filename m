Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7034AB242
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242558AbiBFVNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiBFVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:13:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5FC061353;
        Sun,  6 Feb 2022 13:13:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l25so5470384eda.12;
        Sun, 06 Feb 2022 13:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJr3f+rZTJI0RKlrlQTgFUujK87IQgPE5Gcdhk2SeFg=;
        b=WszPYeSGypoStWneFGADnij5G+3zpYryhb3G9/r7XXYMxlXSETBNnRPhb+lnqA/rl6
         zH6mtx2CtyzLIs/zW9BUEmvE9Q8QgmkIaWhk8mtEB6NwGeED86rOmmelQZRzZSxijPd2
         XFioapmQGu3rToT2k9Za94zH5ZFfzZHMiyY2NGhicuwY0ythEkv51lAlVcWRBi86f2lo
         uBE2ZXS+VhvfQEhpOnQTEIpslmU/RRzafg2g7F00iD59K1740ZbjTpMlvekGnq/JAK4M
         EC+HueuovSLCMQ/6z0g5otWGBOouQIz8PFZsug2XIgIcCHMMc/Gc6ymKq/rm8H4AHWxR
         u3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJr3f+rZTJI0RKlrlQTgFUujK87IQgPE5Gcdhk2SeFg=;
        b=RIHAziC8/ZSnit12JrbwwGSBFTtgXUxzKEx7eZHJogCWc9GRecW8RTWYXd1L/ypmsL
         sBz6waUBI9vXSuwpo3rG0cLL2OspVTFTj9bH9S3TNWGhrEKMp1+y4DIV7j0XAkWkAuhH
         fJdj3ZtnqZ7LOPuv+lnLV0m0FUykB7UVbQ+4yomsQ4tHsaH0mXin/gD6gs39EcgX7Mfy
         8aDyzMZgIbkK2A6Op5ghqokh5ehjKHlw7fHjIaxdZrSWc1pFRV2VqdDRD6rCLV9/XCho
         3sCYb/FASxBNsjoAF3dzkpjd/1IK6L3aUTwKdRjhbbI4BUmNsYDgOryjmr4e4jAD7IM+
         tx3A==
X-Gm-Message-State: AOAM532LaPfc1RLt624NdoaMKgzGP7DkZe3Srhnb3IE6FIWe9QBkhbk4
        Oqezi93Z0lO9cv01v9VL5Vw=
X-Google-Smtp-Source: ABdhPJzsjrGDPMhJepJi9n3sRoHbav3Dn52UVirKTB3zq+5syB1FciIJa1SNEP0GOs9PO2KUGaT76g==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr10377270edd.203.1644182006246;
        Sun, 06 Feb 2022 13:13:26 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id a4sm1248598edr.33.2022.02.06.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:13:25 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] iio: ABI: add note about configuring other attributes during buffer capture
Date:   Sun,  6 Feb 2022 23:13:05 +0200
Message-Id: <20220206211307.1564647-4-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
References: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might be impossible to configure other attributes (e.g.: events, scale,
sampling rate) if they impact the currently active buffer capture session.

On ADXL367, writing to register before 0x2E requires the device to be
placed in standby mode, otherwise the changes might be effective for
only part of a measurement.

To ensure this requirement, the configuration attributes of the IIO
device try to claim direct mode before switching to standby mode.
During a buffer capture, direct mode cannot be claimed, and the
attribute write callback returns -EBUSY.

Describe this behavior in the buffer/enable attribute description.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 41c1e3e1bf30..bc98453bdade 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1278,6 +1278,10 @@ Description:
 		Actually start the buffer capture up.  Will start trigger
 		if first device and appropriate.
 
+		Note that it might be impossible to configure other attributes,
+		(e.g.: events, scale, sampling rate) if they impact the currently
+		active buffer capture session.
+
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
-- 
2.35.0

