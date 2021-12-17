Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC19E4791B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbhLQQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbhLQQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:43:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E2C061574;
        Fri, 17 Dec 2021 08:43:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z29so10011380edl.7;
        Fri, 17 Dec 2021 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDtKtH7QIr0s5/N2eyY+bTTMkrQ37z21PiXOnmy/hz8=;
        b=gB+maKXisF4et1TOPQCaRr4qooDH47t56Etwqfy4K9kCSOwfyhSVqbnXmQayCmYbwp
         H6NlZsnynO41nw3Btwuquq1nfF3N0XkvL50XQD3BdgK4RKZi9JwIy2UBeO0ZbYZW1e+t
         1xjAnIhuDrh60Pse/DhwW+1WCIVS33+UEWpPHoHO7cpVEw1fEXxPDy/QWLt7LKGPryt6
         xo8XSmob6lW+kEi205aLrcHdfYnVGMi65fn8lno6PEerxKbpelO6vhlFPxzOe6lq7O1W
         pPlu3nc84t4Ao3p/rEEkCMYsrdyxEjgK5pnhzyYvCGYdDy/TEu1IAcvNPSKy2vIfz6DQ
         49sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDtKtH7QIr0s5/N2eyY+bTTMkrQ37z21PiXOnmy/hz8=;
        b=IoiykL2NzJ9a4xGy5APf4XSrp32uJm4rNFbHqAU8Hf5L0ouJzAum5NT9ywNkkBNgC9
         8PKQeMBJ0xdBZFtyxeLIRZSv9xmkepPBmES+4HyMZxh/+QmSHRcBO9UcjqyXA3mQhusE
         roDO52rbVuOFwBqt7aQwVvovbtbSnSLu4MC7iTfxKjrb0Noe6pY6CvREQqPsTLMFixKl
         v4qBXtTcsZPVtJYf+JWd3kwmvy6Nxq7sSgqFVv3AFX71mgVOvfPcOXHAvIpS0vO9ZGxx
         O4yFy5qO9n4gQM1cPhPsZQ9lYt9RWygcsqpQGZWiVxqgsAAmIV7ElmdzLi13eTMoEIwb
         jXkQ==
X-Gm-Message-State: AOAM5317iwRZ2Qv6HGZlkOyt5IHD70cZ2bT9QsmV5QIHZ26vmZof45wy
        YENDYcYtStdKeuvjsX5MYqY=
X-Google-Smtp-Source: ABdhPJz22/mfwgwmCUmtGf7/fWgNLTioKgvF4cwLSXtRXssea4teRV6bQjb+hFrLnHhrTRyVHbHmOA==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr3723414edb.203.1639759410899;
        Fri, 17 Dec 2021 08:43:30 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f34ba00f711d38e28b691af.dip0.t-ipconnect.de. [2003:cf:9f34:ba00:f711:d38e:28b6:91af])
        by smtp.googlemail.com with ESMTPSA id f22sm3955906edf.93.2021.12.17.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:43:30 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: PATCH v2 ASUS EC Sensors
Date:   Fri, 17 Dec 2021 17:43:03 +0100
Message-Id: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
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

Changes in v2:
 - Replace sensor flags enum with bitset
 - Replace module init/probe functions with module_platform_driver_probe
   and ask the platform drivers framework to load the driver when ACPI
   EC is found (ACPI ID "PNP0C09").
 - Extend board data with BIOS version attribute for the mutex path to be
   BIOS version dependent.
 - Add module parameter to override the mutex path.


