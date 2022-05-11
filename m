Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB8523679
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245514AbiEKO7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245338AbiEKO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378920CDAE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o22so2055642ljp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PO0ibnivlYlQHsSzGsoFDn9GSobE9qvHUHbEZcsOBy0=;
        b=eZKENx22PLLnXCK4/RWqmJUBzs4H+TVmExklvHsjsUlgPBN81qUOsWlzGDaoO3K+Cy
         b0UldU/sshvcS11Ya4efKtzTB/3qoymbAcHWQ5ohd1pUzs6mXaQplzOJP+RkZSg88zZi
         m04gMKBge8gTwQPBwn0ejNIEASf8HrdnnoaeYERmzOfXNw1F371WCYnYEr1wdgBpZj1M
         HESDDiz954jB4oZYQ2ekP/uznn5f5+8J+XIxmCv93rfH42upje90xP5wt++16rYvutpg
         Fqi+XGoRDLEndtES+TCdYJR3dCT9d1odLgs+1JnJ1Zr4PA1puOUi0U1pG9jr84+6Ihwf
         jPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PO0ibnivlYlQHsSzGsoFDn9GSobE9qvHUHbEZcsOBy0=;
        b=jy9V3j7ZlX5HhUIwEjL9oIjUuSaQ2NUodg5QsA7Fv0l742O9agdw8Y8z3sHts1wsnc
         422rEKbFbi90CEErwuYl/Qjm0Q31ZVTBwWfPBen1xpCNMLnd0ko5efMQxZ1pn1SiPCRo
         MtNaYAfIW6IFai+O4lZbaQVWIzwOWd2OwOj4ftu49Fbw36YeReQM7hwfzvAhqJk2A/tD
         opKGIbOWs9sjP7HtSddypR47c1Vc8wo8G7Vkcwudzs+AgEAUL+S8Cvf1aIpGEOM+sMv2
         C7O+4nqA+ZGwp/mdSKuYco6On9uqou0SNR77s+mpuW8MPf8rMA45YvFzb1kTSzwpyM6j
         ynmQ==
X-Gm-Message-State: AOAM531Kav4jagV/LMWPffbhCb2e4J5ubLup0NOSwfKEfm0t2C6hdiu4
        UxRtY15ELo2cVHCIw94VKTRBYw==
X-Google-Smtp-Source: ABdhPJxZphuNVJWtuCo9Ewl3xjNfgWKEwCNvRcPem+7IU9+w73SPhap+pUAL2jolkDfLctkvmSy/6Q==
X-Received: by 2002:a05:651c:1994:b0:250:5b1c:69e7 with SMTP id bx20-20020a05651c199400b002505b1c69e7mr17054484ljb.192.1652281056576;
        Wed, 11 May 2022 07:57:36 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:35 -0700 (PDT)
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
Subject: [PATCH 10/14] PM: domains: Fix initialization of genpd's next_wakeup
Date:   Wed, 11 May 2022 16:57:00 +0200
Message-Id: <20220511145704.698189-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
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

In the genpd governor we walk the list of child-domains to take into
account their next_wakeup. If the child-domain itself, doesn't have a
governor assigned to it, we can end up using the next_wakeup value before
it has been properly initialized. To prevent a possible incorrect behaviour
in the governor, let's initialize next_wakeup to KTIME_MAX.

Fixes: c79aa080fb0f ("PM: domains: use device's next wakeup to determine domain idle state")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 48101232fcb9..9922fd763739 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2007,6 +2007,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = true;
+	genpd->next_wakeup = KTIME_MAX;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
 	genpd->accounting_time = ktime_get_mono_fast_ns();
-- 
2.25.1

