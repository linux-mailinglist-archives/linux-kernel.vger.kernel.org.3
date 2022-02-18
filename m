Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4B14BB488
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiBRIq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:46:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiBRIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:46:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B182B31A6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:46:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d27so13304601wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ6qNiHE6Sk52IIqBzCxNgH1aeXYsx0LWdf4PlC0/pM=;
        b=xCZcy10umt1iU95uyF1HDYYAtoQT78wLBto1E1531wwqDoYbBKH0rb15jQuo6LSfIB
         m1XjAakEsHtG9xF+d/yo/bbCpg31K6DwPr1KSF3253UJ1NhZ++v4Cp3TzX3g4w2ql0bB
         DPf2r2TgY1NZVM8KR7Hv/qURaVzT16y8b0dV7R6GrYE/1rhTAVuRhGqbUEiAr/s49nZk
         EjbgKmFEVeZgrGc411xRC5rqnd8h+s0dIFwYCvSvB1Us5W9Ih6tT7qu4YRLUgW+0idr/
         VLQxU8T39OGFGo6KKCsw33/XxIcyUdsXf+TYyNOrCdfc+T+x0CKKsDoDiv4JhuwI5Vcj
         1O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ6qNiHE6Sk52IIqBzCxNgH1aeXYsx0LWdf4PlC0/pM=;
        b=U64JqQxlWgeR3j4mnW9Itn9KiCF/P4xvD2M41hRvi1JlwuEETb6gAwwlXWxwbZQDBp
         Pyj/RT6aoRJFDnwrq5/3FikoiLD4XFHLUBU97FrpMMVT1OkkYq9jecu1qDqAF6PxuDaY
         K1/MXHuJdzPh8VgiAWKH7Hb2COT5s30e3dF+9IpNNhd9F8s/3xTO1yr2wCmAir+SL6aq
         NUlEXHPrBRJ9E9e/sYVda7IoVOrCzZfED6p6qXJDZKfq+u07aXInoAs7Naetc1IS1taS
         HkYqlt7zdhS7AZ5Psl32XK78TPl5Fmo0iyr/nr3o/6JJPv+dnAk0H1EeJPos2tJgKpQZ
         dDAw==
X-Gm-Message-State: AOAM530LMRPZ+E4IkLzW25gsdNnwJ3ZkYd3wp56nfh4H+MsscRxe0TFI
        FyS0CVeDKRWlRuw88ywC0SuAiA==
X-Google-Smtp-Source: ABdhPJx/pRcqGHwuxBzeIEjRMPudhm97e4ozdTUkpYkJ+1+gL+yuW2Vqla8lpknIsa8Rn2BnLDLhSA==
X-Received: by 2002:a05:6000:1809:b0:1e4:b195:7cd7 with SMTP id m9-20020a056000180900b001e4b1957cd7mr5253868wrh.46.1645173969772;
        Fri, 18 Feb 2022 00:46:09 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x7sm33525478wro.21.2022.02.18.00.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 00:46:09 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 0/2] thermal: Add support of multiple sensors
Date:   Fri, 18 Feb 2022 09:46:02 +0100
Message-Id: <20220218084604.1669091-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
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

Following this comment [1], this updates thermal_of to support multiple
sensors.

This has some limitations:
- A sensor must have its own termal zone, even if it is also registered
  inside a thermal zone supporting multiple sensors.
- Some callbacks (such as of_thermal_set_trips) have been updated to support
  multiple sensors but I don't know if this really make sense.
- of_thermal_get_trend have not been updated to support multiple sensors.
  This would probably make sense to support it but I am not sure how to do it,
  especially for the average. 

[1]: https://patchwork.kernel.org/comment/24723927/

Alexandre Bailon (2):
  dt-bindings: thermal: Update the bindings to support multiple sensor
  Thermal: Add support of multi sensor

 .../bindings/thermal/thermal-zones.yaml       |  20 +-
 drivers/thermal/thermal_of.c                  | 491 +++++++++++++++---
 2 files changed, 449 insertions(+), 62 deletions(-)

-- 
2.34.1

