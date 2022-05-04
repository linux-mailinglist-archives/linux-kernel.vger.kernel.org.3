Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DB519CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348103AbiEDKeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348050AbiEDKeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:34:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B03E0C2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:30:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so567923wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQyCiJBrdrzMDjwwN9WliekmLw3BxA/T/sUJGfPV2pU=;
        b=GlSoRAhKxTm0wlcNJin4wlKpZWZ27j0xaRomtWuTo11qoIkK5SatGtTSeuR2pnhzvq
         Jbvjfisurf+nK0vZcPH3rGrW413QqMkTSNFOcSGPkoD12pFDlFLSnF7nanmrckdPUvE+
         dOLlPeIL/KZ6LHCF/QaImO5ysxBIrleqqhnmV9vpAxBYM9x3OLTbnk/l5+DxlYqEonpF
         YYeDNCtXe83jOlyEvRi89Cl88cSrxvnHS+x58CAiYxwukFe1TV5DIaD6r4aalyCqgydt
         6sbjEH4XNwArohH2xCES0ZhIz3JH4/3SBc2zldaikLkq74Y9isSEOUm1lmSl9Wys4dtQ
         bLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQyCiJBrdrzMDjwwN9WliekmLw3BxA/T/sUJGfPV2pU=;
        b=skJge1vthfN5hjFvAbnbkuzqftRwQN4WnxP3h/KDefB20YTIIu2Y+wzFJngnO10nt3
         RIyw8lVUjrvWU6D3tOi0Y8xUeqPeL15MkEGr5QTF1TEVqFHUnJxV9vR6jZXIOScxDUEC
         kH60IX62LsJIFl2o7/4875krSuxAdITjbhXotrTmkjZzfCeWoytR53eiOM8JGkN01ZtS
         abUbMiBM6KgiW3RuRCinxvnZfjgTC9ou5z+q64EyKrM+c9cXEcOq0iQVFfPvPcXKa2SE
         t/uufLQrro/hJ65klHp+xy10wT7TqwaHQRR9VtSIj7fHq9vz/SXeJwVfzU3SyP9fbCGF
         XHIQ==
X-Gm-Message-State: AOAM530BdxlUMRAbVyZ8bZTDFF6VXZgYEIl/azQq1zMCrhqv6BCplTD2
        W6H31FrInLQqbv+yEzG7fJDJNg==
X-Google-Smtp-Source: ABdhPJwyY675il0I7jhl/sTQb/BE8JJS2Vpl0Y6XsNyHUUgFIyouAMieVsl+v2D4vdNsSuoYLwjxjQ==
X-Received: by 2002:a05:600c:1d0f:b0:394:4bd1:e05e with SMTP id l15-20020a05600c1d0f00b003944bd1e05emr7080873wms.103.1651660238441;
        Wed, 04 May 2022 03:30:38 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k6-20020a05600c1c8600b0039429bfebebsm7521395wms.3.2022.05.04.03.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:30:37 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/2] hwmon: acpi_power_meter: convert to new hwmon API
Date:   Wed,  4 May 2022 10:30:26 +0000
Message-Id: <20220504103028.493155-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I dont like warning in my boot log such as:
hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
So I did the conversion to the new API.

The patchset was tested with:
- sensors
- cat all values directly in sysfs (for ones not displayed by sensors like oem_info, model_number, etc..)

But due to missing functionnality on my hardware some code path was not
tested. (Like all cap_xxx)

Regards

Change since v1:
- use really the new API

Corentin Labbe (2):
  hwmon: acpi_power_meter: fix style issue
  hwmon: acpi_power_meter: convert to hwmon_device_register_with_info

 drivers/hwmon/acpi_power_meter.c | 524 +++++++++++++------------------
 1 file changed, 227 insertions(+), 297 deletions(-)

-- 
2.35.1

