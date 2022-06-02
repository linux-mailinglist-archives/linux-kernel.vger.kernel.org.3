Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8E253B171
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiFBBqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiFBBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:46:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592C129567A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:46:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a10so3602846pju.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 18:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGDn3nszvVQVYVQM4YLEuXbeHQsUmI4dKP895cZuF+0=;
        b=aCMEgp07vBU7N8yXUlqLw6AQSp3jhFFjgVSHULzqy4W8B/q9HtNOyNPBfs+QYiXvA4
         Q4mYkU0I0Uhu5yhUXAhY0IlpdfhskYaimHCkdeVViuAh5Lij/KFZ+oLTZcSyrrZW/SHa
         xEK1q8BqRQ2+ACgYAsoMRYNLwKAY7xnEO/uEGOxZwLsFFWJ/asJS0yjRNkpor9RtPShu
         9el3HCpEydc+7S58Ae8oYZsT8464KeW9HQVpMA7Ex+TrveUImT6Ivppu/sNfU9bHAJJV
         tWmvWbLlmPCaZJxqkRSLgu40XPqXR8kZLf/XLdl3/oAAFGjpqFwbDty7OhJmJ/YzlFW3
         T2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGDn3nszvVQVYVQM4YLEuXbeHQsUmI4dKP895cZuF+0=;
        b=wk5FtnUrMJ4KK+uT9eNcv2efDtTG7c9/UHnlSuc9Tly+nYpB9UXy6NuweKumxqDTAO
         jr+NLb1zsrSaByYvc0mvXaAK6f9wEmOA91kYSg3fIUraGnbeczl2N4WQwubNWkw960vi
         5pCBboGTW778w2ixJi9qfRzMtomQNJAlcBGtXgOHi182y4Oodo075DZ9rFe2CQfLHtWf
         VaCD2OVGSkU+Gcy6mHABQ0HVm6ILvtlwkl5cLlFanMNC3GLx99poTNcCX5cOe+1QqnPG
         HF/c8dcs+i8s5xNkln2miDLdAb8gR8quHIV6F7qHnfSFiYc1yUfSVo/OgOINwuFLtTQf
         LKVw==
X-Gm-Message-State: AOAM532vOGq1XS+9uHuz92EtwMUDJb0cCK8WbbmEgp8G/clfLA8AV7z+
        8o+5TyLmYQrft27EdNdXFCFTDhb2LMs=
X-Google-Smtp-Source: ABdhPJwK9al6esJUDFUBc/e+DpE5U7LQ/svvPdYugzs8etwXJ1mRVnI1OmzCNJxk77WBP1T0VMrLcA==
X-Received: by 2002:a17:90a:a393:b0:1d0:e448:811d with SMTP id x19-20020a17090aa39300b001d0e448811dmr37801695pjp.97.1654134366590;
        Wed, 01 Jun 2022 18:46:06 -0700 (PDT)
Received: from Vostro-5471.. ([2001:288:7001:2708:cee8:633a:13db:6557])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a5d0800b001e303b3b431sm2013103pji.11.2022.06.01.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 18:46:06 -0700 (PDT)
From:   Jui-Tse Huang <juitse.huang@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Bruno Randolf <br1@einfach.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH v3] average: Clarify the restrictions
Date:   Thu,  2 Jun 2022 09:45:57 +0800
Message-Id: <20220602014557.5657-1-juitse.huang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is several restrictions in the EWMA helper macro that the
developers should take care of, but the comment does not mentioned yet,
thus, this patch clarify the restrictions.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
---

Notes:
    v3: fix typo (Randy Dunlap)
    v2: fix spelling and wording (Bruno Randolf)

 include/linux/average.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/average.h b/include/linux/average.h
index a1a8f09631ce..9c3c8b5b518e 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -11,7 +11,10 @@
  *
  * This implements a fixed-precision EWMA algorithm, with both the
  * precision and fall-off coefficient determined at compile-time
- * and built into the generated helper funtions.
+ * and built into the generated helper functions.
+ *
+ * This implementation supports up to 30 bits of precision, and only
+ * the API for fetching non-fractional part is provided for now.
  *
  * The first argument to the macro is the name that will be used
  * for the struct and helper functions.
-- 
2.34.1

