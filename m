Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C43E48B4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242483AbiAKSE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbiAKSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:03:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81BC061756;
        Tue, 11 Jan 2022 10:03:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q8so34410620wra.12;
        Tue, 11 Jan 2022 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mftlL9r4N3wps+FFWUEe19w3d5JIKs0BcAherXHNnjs=;
        b=T8SveW70wrZHKd4VWUubNfrWzp6k8uqiRSHDygnQ3oTpK2gekeingcpFnHGS3pSj1S
         3+f9Exom/gSWgEFfWyr7fEafeWS5apHYehY6/HH9pTEN/lOtuItPgqgYxj7N1GW8UFGc
         iHXDoIzNp3etHuqKNU5Jb9lA6cknwPPjMT0T88PeRlwudQMXTwDOrUBfOBLCk/actqpm
         8h9d2/GNgJPCqvKfbwsdMCHpb/2GUZifS4nejVx3dwuiRqADOIy19dx+D5DipnupM1K/
         zhfnh6Y66Q6odUGNHdLBHIO/y8yLxWpAQb1ANiCB4rMF/toO+ZwA/TOrKa5XgDEKYn0S
         ES/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mftlL9r4N3wps+FFWUEe19w3d5JIKs0BcAherXHNnjs=;
        b=uDnH7+ynuXupTjhP2tzUPQyfYLCEuw9j1KWeExHZzcsje6T8rV6+oJc/WXlPfnA4I9
         INDHCu4YLlu9T17VWixRf+XfIgM1nPlpIwx/b9H8vL2aHsF0NOuqzJwMgM5wmT4C2LCS
         NdGaGAsqLG5QQYyE//E2ki1jdids7kbZLob7VytAgZyEMk5/sJS+K4Uu7n4wVC6OL5/y
         5JNFVJDpYEanc9zXAX4e3U6jCRMmoyj74nCvFeB0Jw/c6dx6VQQMDPL6x6J6Km23qXcj
         3IhofkY5kdWQmKKhPKTWWGv0Ts1jd6VdbTqXx8fGgM0/j5XWRNjkdlNYfB10EEQOwPa2
         Gnqw==
X-Gm-Message-State: AOAM533MsQ9fFUSz+9FcsFWaoQb62a4DCcvUTTKPv0bX9DbsbWOMmtOY
        oRizPxGKyghLWrek2c1Vd1/+RYMSuMZSRmaK
X-Google-Smtp-Source: ABdhPJx6N7UbTHQgDXFYII8mAH8szFbkHFPYTpW3M+r8elP+puzFr7Wak5dSgbjwR8mvFS2TdSEjWQ==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr4671352wrp.125.1641924230908;
        Tue, 11 Jan 2022 10:03:50 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f0b7c00c3a5ee4155775dd9.dip0.t-ipconnect.de. [2003:cf:9f0b:7c00:c3a5:ee41:5577:5dd9])
        by smtp.googlemail.com with ESMTPSA id l6sm2255429wmq.22.2022.01.11.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:03:50 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: PATCH v4 ASUS EC Sensors
Date:   Tue, 11 Jan 2022 19:03:43 +0100
Message-Id: <20220111180347.1245774-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces the HWMON asus_wmi_ec_sensors driver with
an implementation that does not use WMI but queries the embedded
controller directly.

That provides two enhancements: sensor reading became quicker (on some
systems or kernel configuration it took almost a full second to read
all the sensors, that transfers less than 15 bytes of data), the driver
became more fexible. The driver now relies on ACPI mutex to lock access
to the EC, in the same way as the WMI DSDT code does.

Chenges in v5:
 - Place the sensors bitset directly into the driver_data field of the
	 dmi_system_id struct.
 - Replace doc comments with regular ones.

Changes in v4:
 - Deprecate the wmi driver rather than removing it.

Changes in v3:
 - Remove BIOS version checks and BIOS version dependent mutex path.

Changes in v2:
 - Replace sensor flags enum with bitset
 - Replace module init/probe functions with module_platform_driver_probe
   and ask the platform drivers framework to load the driver when ACPI
   EC is found (ACPI ID "PNP0C09").
 - Extend board data with BIOS version attribute for the mutex path to be
   BIOS version dependent.
 - Add module parameter to override the mutex path.

