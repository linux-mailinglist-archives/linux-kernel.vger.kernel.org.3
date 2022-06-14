Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E554BE91
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiFOAEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiFOAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:04:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20AB289A9;
        Tue, 14 Jun 2022 17:04:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x17so13199110wrg.6;
        Tue, 14 Jun 2022 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2/QDJKQUYJdg67+qXw7NrZ4cn1DkdhNkxlezX0Iqcg=;
        b=f9VtERyCX3duWDopI90LJQYHVvSnJljwRZL6y/m2d6HzkM+7yuQIrmgQAuvVvXClCZ
         ZOs4McY4Jo15yzZN7T2b2TuxT9tHcepi/YAvt8LGbHLYMv+6cwB8OMON1yPtzDfFLCB2
         4WALceBcPodYt5QkyOUu16WU2hSaOZ+48qQMFppAOFwFbSRKRNfU8gLP9Ouq2gCX1DtF
         2ALbFUAhdmfqkpmlWyvigeUsWa2dfati4eQ/KMw849pm5N1F881OKrAvESBb2QsFicuZ
         26yVTgOdYcJv/i+BFQJPYz0+13PyBVLUB4GH7chYjrATZrAvuvgqzDm0k7APR4P1Lg+l
         4nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2/QDJKQUYJdg67+qXw7NrZ4cn1DkdhNkxlezX0Iqcg=;
        b=x3umG8N7F26J07QmoKMo90ZncVd22aCAZgir3LRafYimLYUrexMMUSEvbyeWxl6sYF
         n2jSWiwjRg+UaA8hfWae9Dcv98hlegNnzD/IWKKuVCEGiF8yhcPcd9y25P85h3AAbjxw
         yOKg/GkeUOjI0/ynscUe5KXqbHotArenV+Insjo0ylOZ/veWvyUH2cPj6L5bmyv235Pm
         aehqhXp7LoDME1bKepciHFvyDzuBpEjz3pNCAi88x2gzSqijlzDF3vbLGDqIk167kQ0t
         69gFacyIqtg1kr3/882LK2mawlR3TksYBiiBMfNeEgj4mloUdEtOLYaa3QmJ9/uNynJ8
         voVA==
X-Gm-Message-State: AJIora+8ypAFVYpDp431lxUyD/115ZqnawZjq0slefAWSMVF0iK35ZrI
        ry64v/Bxe/O6LUVDRc8OkEM=
X-Google-Smtp-Source: AGRyM1tpYj1qhLCK+1qDQJI/vr8WVmMz2VhWVGj/7ePdBMHIu9jmtZlxhsBhCTcyRFK31WealWrz4w==
X-Received: by 2002:a05:6000:11:b0:210:302d:e787 with SMTP id h17-20020a056000001100b00210302de787mr7084509wrx.535.1655251439110;
        Tue, 14 Jun 2022 17:03:59 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l7-20020a05600c4f0700b00397342e3830sm5546821wmq.0.2022.06.14.17.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:03:58 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 4/4] PM / devfreq: Mute warning on governor PROBE_DEFER
Date:   Wed, 15 Jun 2022 01:09:50 +0200
Message-Id: <20220614230950.426-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614230950.426-1-ansuelsmth@gmail.com>
References: <20220614230950.426-1-ansuelsmth@gmail.com>
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

Don't print warning when a governor PROBE_DEFER as it's not a real
GOV_START fail.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/devfreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2e2b3b414d67..6a39638ed064 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -931,8 +931,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
 						NULL);
 	if (err) {
-		dev_err(dev, "%s: Unable to start governor for the device\n",
-			__func__);
+		dev_err_probe(dev, err,
+			      "%s: Unable to start governor for the device\n",
+			      __func__);
 		goto err_init;
 	}
 	create_sysfs_files(devfreq, devfreq->governor);
-- 
2.36.1

