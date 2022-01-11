Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3273148B2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbiAKQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiAKQ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:56:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05870C06173F;
        Tue, 11 Jan 2022 08:56:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z22so24687136edd.12;
        Tue, 11 Jan 2022 08:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TERvzUf9uIUyGg0LGKPGRLYrJ3+E4IOdstXkWvp2g4M=;
        b=SmbcPHueGNntq6wAtdWO5GseAQwo6wtTq2ZMv+25/ccOtXrwWdmjpqfkhmKKCJYZGI
         YNpOsqSW3HOPI/J3FG9gz/6ahrv+a6EXfVAqvtz5+niu4xxbJtAEb+W+7a7hFEGga9KJ
         U291iYIajYM78YEkdDPlvtFzQ3K/P6ZRZkAUUlQR5/ZuvECiPJIUAkHxErdsZ4pxvt9e
         3ctBynzKHFLfhsLrAoUE0GQog2krQZ4rW9ESIfUERE73Bb4kKMHjOqtR4t6ksw31jjsE
         crsdXtKW+GXH4zoQ+Wt0tlmIOqk8GXiiVyAoEKrcc2G+fwD050jwW8HUR+Q/wzmpwrOI
         ZEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TERvzUf9uIUyGg0LGKPGRLYrJ3+E4IOdstXkWvp2g4M=;
        b=KOypuJZVBJCRfaiTFtOtSdjsTANxAPA6ki1zqQYBjeg8YltfKbhBvFA1RR3//nRCJg
         ZqxW2a80wdlHdaCvYvTHC8pFGnlLP+LkLDnu5fj8zBeFdlcqEGSzlvRLs7tQCQ/QrQwt
         Jafh9ybclpBzr2pjqJh117OnFXE/e0BfdQ8gwGi4K9yJ2ZFa5xjBjgqc5PLamPMH9Hnp
         PfaLyg0aLTPTEaBSpiYrNK2fvKkzkgeeNUu27OTGBRZ2Gl4DDK4MfkEBzUtue/rmoUc6
         oHYuGeKqH3cikcoZ4ugYUTwCDqvvkgcw5mtH/P5NgQjLlAqDj4MVVFMWhRYSY0dp+fDv
         EbRw==
X-Gm-Message-State: AOAM530t/kBJt4OcTz+8KAmq7e0LxngWOhfAKpn337/mcch9qN+RRsQh
        h1OYWGO4rRmHUa6OI/2+1N/pY1ybPH8xNqok
X-Google-Smtp-Source: ABdhPJyICy/6mjfM3gPCbmC/afRDS8KdzOxNHVzhC5tC7dY6JLJAHdqb01lvA9UFeCVsnoCxPxWV1g==
X-Received: by 2002:a50:9dc1:: with SMTP id l1mr5032281edk.231.1641920204557;
        Tue, 11 Jan 2022 08:56:44 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f0b7c00c3a5ee4155775dd9.dip0.t-ipconnect.de. [2003:cf:9f0b:7c00:c3a5:ee41:5577:5dd9])
        by smtp.googlemail.com with ESMTPSA id d14sm5220986edu.57.2022.01.11.08.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:56:44 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: PATCH v4 ASUS EC Sensors
Date:   Tue, 11 Jan 2022 17:56:24 +0100
Message-Id: <20220111165630.1155135-1-eugene.shalygin@gmail.com>
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


