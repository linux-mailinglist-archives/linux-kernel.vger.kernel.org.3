Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3BD52365C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbiEKO5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245238AbiEKO5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:21 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3098168FB2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bx33so2926648ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTwD4gLKmHN7E/fbQzayCb4Ey3ryS/IVDOIHFJLYaw0=;
        b=Oa3p0Qcx0Xv/C4eTI1R6LW+r61z+jhCZtmwCVCCxydrf7aeTXGjaIWeCKMQWKoFqau
         TR5Bb5WErQwCiPW1Jn9SNNORu8NFnVMpxWczs7EPkrBy4rdEOBnn/TBTjs0K95+Y+f7o
         5monH/kS9VuBHbqJ65Jaj2gN4HaVFN2utFAmxw/gWZ264tzD5y49kilaVDSRu5jmwrNL
         0SqvT+F5G5yIV1t/8cM+fnaePvLbOwZQikMwRGULaBRdyYVS5A0jYSfSp1wTf6gsG05+
         X+GM5dndMrI1YlF+8SdcOfAT+69kwwTwwFupZgTAQQQtyt0LdRD7OI/qX1uwPUUJNSSk
         PCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTwD4gLKmHN7E/fbQzayCb4Ey3ryS/IVDOIHFJLYaw0=;
        b=DX+PQb/Fvyz4EkMO8wzKsGAo57XFwGCykR+IQXLgDMe/YamVQhIS6tUj5ciyob3ZJq
         b4D00QJXUVJrOWRNltw86ROqEvevD4m9sRZq9M9zjHzcj8C7wNfY25kRUI9n8xNyjbYV
         mM0Wo7Uuj+prWpovPCvb6ybbLx4oyeUUt6taeBfcTUnptW1hx9D1Bo5kFHC9g/sx7TJc
         E/TyKkaNP80c2+EUNdNrKKUgXytFRXo31MpRnRLH+i+LxYJsjEMGwEoy3dkg7b1PYwk4
         mFAmwhjxd5O+z7/EuXpzLDT7/wrnFAZGUYO4JwC3AxaUliXRpsoPRgMjEgi7OlWuZLlH
         grZQ==
X-Gm-Message-State: AOAM530MMDoRufRmkw6TUx3QdUkMKw30h+bU2GIVNJNNfHU70PH7xIUa
        lyDbrjV7GSoqJpelJXurgV8Llg==
X-Google-Smtp-Source: ABdhPJyPDaLPh052/eGE9GBsFch7tnDr/+2QhvcD8efEkQsXZp+785gms7IyGXQ28Z0bhO/LniKWjw==
X-Received: by 2002:a2e:9617:0:b0:250:896e:3d25 with SMTP id v23-20020a2e9617000000b00250896e3d25mr17485503ljh.526.1652281038522;
        Wed, 11 May 2022 07:57:18 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:17 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] PM: domains: Various improvements for genpd
Date:   Wed, 11 May 2022 16:56:50 +0200
Message-Id: <20220511145704.698189-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal with this series is to improve the way genpd deals with its
governor(s). Especially it turns allocation of governor related data to be
dynamically allocated. It also improves the execution path for runtime-
suspend/resume of devices (attached to a genpd of course) and the similar is
also done for genpd's power-on/off path.

Note that, patch 1->3 have already been sent before in a separate series [1],
but for simplicity I have included them here again.

Tests/reviews are as usual highly appreciated!

Kind regards
Ulf Hansson

[1]
https://www.spinics.net/lists/kernel/msg4335838.html

Ulf Hansson (14):
  PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
  PM: domains: Drop redundant code for genpd always-on governor
  PM: domains: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
  PM: domains: Rename irq_safe_dev_in_no_sleep_domain() in genpd
  PM: domains: Skip another warning in irq_safe_dev_in_sleep_domain()
  PM: domains: Allocate gpd_timing_data dynamically based on governor
  PM: domains: Move the next_wakeup variable into the struct
    gpd_timing_data
  PM: domains: Measure suspend/resume latencies in genpd based on
    governor
  PM: domains: Fixup QoS latency measurements for IRQ safe devices in
    genpd
  PM: domains: Fix initialization of genpd's next_wakeup
  PM: domains: Clean up some code in pm_genpd_init() and genpd_remove()
  PM: domains: Allocate governor data dynamically based on a genpd
    governor
  PM: domains: Measure power-on/off latencies in genpd based on a
    governor
  PM: domains: Trust domain-idle-states from DT to be correct by genpd

 drivers/base/power/domain.c          | 201 +++++++++++++++++----------
 drivers/base/power/domain_governor.c |  65 +++++----
 include/linux/pm_domain.h            |  18 ++-
 3 files changed, 173 insertions(+), 111 deletions(-)

-- 
2.25.1

