Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE25236C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiEKPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbiEKPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:12:35 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27426211B;
        Wed, 11 May 2022 08:12:34 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e93bbb54f9so3125324fac.12;
        Wed, 11 May 2022 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bHIvRwbZy2PU2tVG2MsolIs4vwnuxHm9cCZ7s9+0ag=;
        b=h/qSCPk7bxX2NqGK8OaRIVXDvJuBiq0CsuQWDMquStjFRfFsc0gahwRh0gxctRtK4D
         OGUT81NVBOzRes8TQJQyvzIRQZ1SNsNxblFnupyjKVUpIGnv2aKHHTckBDafFhcMW1aB
         nMkNQT1mglT+xuY1rHJfW5iJPmS31XTnzF5JVISLpz5/7tYTS8iVTUDMdjqkLrmwDN0x
         o43TdIJ3D/QqygEsWPc82LzQLKOuvS+1GF/fjF+nN2NKSeBZ1lea9yvvLkX3OeBdkncm
         0SRSyhAqNkGOVwcui0MRBwcqKVKs488x4+nIu9KfSCnteVu+BB+dP4TtyQFAzzcz+zDc
         f9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+bHIvRwbZy2PU2tVG2MsolIs4vwnuxHm9cCZ7s9+0ag=;
        b=rYlHjOMzlBuSNm4lp8KbX549/J4y9zva2r6vmwVPHT7EEb9iynyMRFCqj1OSfjJUJs
         fuZf87eQyC5AlpFCSsLS4wDgDocJV9hDGJ/AWjZVUa5zIBRh6Pi9BgqwR0RtkqgI6yzn
         gMlxzzoZ81Kr3yu0E+ikFSex6qdhmiUgLuCpXEnZ+0tlajUcdkkvIWF2+o5O3Xpf+U0B
         /q4w7lTJMV7P3CK9d/AoPTGedZgCxlLLc2qFDoiLleTA5d+8QfbEEzHIKOiKTWlFg39G
         F9AuEMn7loaE5grXI0LYlMfZ/EJvFffue6bDUko8MsUS1qcbAV8s3rwrcaHhOqR4SO12
         JmJQ==
X-Gm-Message-State: AOAM533MkKw6aTj2IqiBpnEYFAe1knqU4pXeOL9vt9oca34IEhXqZta6
        5UFvHmvvrVl76RQ6VrLxBHs=
X-Google-Smtp-Source: ABdhPJyPGhcynPWtpfjk8Hqhg2tYOLdv7xwnSqCnr8ZN1EmY6T3rWTO0jq87FeL7LHsJHqRGe/Iovg==
X-Received: by 2002:a05:6870:3488:b0:de:eaa5:260b with SMTP id n8-20020a056870348800b000deeaa5260bmr2942141oah.281.1652281954175;
        Wed, 11 May 2022 08:12:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b42-20020a056870392a00b000e686d13887sm641007oap.33.2022.05.11.08.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:12:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/3] hwmon: Introduce and use hwmon_device_register_for_thermal
Date:   Wed, 11 May 2022 08:12:27 -0700
Message-Id: <20220511151230.2983227-1-linux@roeck-us.net>
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

The thermal subsystem registers a hwmon driver without providing
chip information or sysfs group information. This is for legacy reasons
and would be difficult to change.

At the same time, several attempts have been made to convert hwmon
drivers using the deprecated hwmon_device_register() to use
hwmon_device_register_with_info() by just providing NULL parameters.
This is an abuse of the hwmon API. To prevent this abuse, we want to
enforce that a parent device pointer as well as chip information is
provided when registering a hwmon device using
hwmon_device_register_with_info().

To be able to do this, introduce and use a special API for use only by
the thermal subsystem (patches 1 and 2). Patch 3 makes the 'dev' and 'chip'
parameters of hwmon_device_register_with_info() mandatory.

----------------------------------------------------------------
Guenter Roeck (3):
      hwmon: Introduce hwmon_device_register_for_thermal
      thermal/drivers/thermal_hwmon: Use hwmon_device_register_for_thermal()
      hwmon: Make chip parameter for with_info API mandatory

 Documentation/hwmon/hwmon-kernel-api.rst |  2 +-
 drivers/hwmon/hwmon.c                    | 41 ++++++++++++++++++++++++++++++++---------
 drivers/thermal/thermal_hwmon.c          |  6 ++++--
 include/linux/hwmon.h                    |  3 +++
 4 files changed, 40 insertions(+), 12 deletions(-)
