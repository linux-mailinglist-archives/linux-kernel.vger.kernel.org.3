Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79790497FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiAXMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbiAXMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:41:27 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5354C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:41:27 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so9989711pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zIZYwwrZXiHAeLvm9jhAYf/+xFidtK3CAhF2X4FAAhU=;
        b=LLYps1Yi9R8pKGogNe4tacGnqapoQzuDIzdksLti9yZzLK2h+Tbf97/vygWrIEW8DL
         /qmHqZ0fts2rZ6x4zwmyDRf5Tf+HIh+l+kLP2PUy6QQzG/fBegHpwy2NK+/ETyxJyYWB
         K8ba1N0BwgYyFFsx4+HiBZfX2aKFaRZVuaqeS8/NCrqLxaHszElmNo8qjo1cjLPbgLlB
         7DIIEE5kp6JtzdugSWd1DVgytkZDVZ92oLiJyqs5EHvWlzmJtlq3asG4RJNH6zLW2OuM
         pFc+U9qoD6uN2loWUFbfRfG95YI+71rcZJlymHXrU1vYWY5Zd5X6Ut29GJdW1U2fQ1El
         jbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zIZYwwrZXiHAeLvm9jhAYf/+xFidtK3CAhF2X4FAAhU=;
        b=RH3hg/k29ZYk82Ap8rCwTTQwIttx1z2QKwcpBJ8AxdH2aQqGrv6kP1KAcFHfFWFZpN
         OLwLqwuLFDv1KFMr9Jr0+ksOcxwGe/U3LprxTX62giheRcW7sRsRrZU0RlHrCcl+WJi8
         L2QCb4DnR+JIAjyL26SdNLF1m3iZdP4VF/VzvHImJfhD3Eeg6D/67oXWJpW+KqmWaNxx
         CItZlUQo2T10czmWz0GdbOBd1CKOvw/SQTgAuNeBKWfpUSzrPoSeL90drJbzjpNKQrC6
         DAVwyOMNNYBirTcto0BXNSm+S2/pGFsPdjdwIivA6DN5+M7X57XS2Lt+W5kAALHR59Ge
         OeYw==
X-Gm-Message-State: AOAM530WDjd4vPgqhthcvVzGVZ0expv2Ug0ZYKtF+UTn9ZDeKM9l/nz/
        x+o2Oe0qGjIMlAyM3VQqKog=
X-Google-Smtp-Source: ABdhPJx27Rs3RIEgZvxl4p+eH0NYd3AJ+F9ztShzY0Cw0TYBdHPGFP3Edw447iCT1Um99dVbqSJ5cQ==
X-Received: by 2002:a63:be49:: with SMTP id g9mr11621904pgo.375.1643028087135;
        Mon, 24 Jan 2022 04:41:27 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ip13sm14262578pjb.29.2022.01.24.04.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 04:41:26 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     mathieu.poirier@linaro.org
Cc:     alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, linmq006@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Subject: [PATCH v2] coresight: syscfg: Fix memleak on registration failure in cscfg_create_device
Date:   Mon, 24 Jan 2022 12:41:21 +0000
Message-Id: <20220124124121.8888-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120182822.GA1342128@p14s>
References: <20220120182822.GA1342128@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() calls device_initialize(),
according to doc of device_initialize:

    Use put_device() to give up your reference instead of freeing
    * @dev directly once you have called this function.

To prevent potential memleak, use put_device() for error handling.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- simply call put_device() instead of cscfg_dev_release() in the error
path of cscfg_create_device.
---
 drivers/hwtracing/coresight/coresight-syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 43054568430f..c30989e0675f 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -791,7 +791,7 @@ static int cscfg_create_device(void)
 
 	err = device_register(dev);
 	if (err)
-		cscfg_dev_release(dev);
+		put_device(dev);
 
 create_dev_exit_unlock:
 	mutex_unlock(&cscfg_mutex);
-- 
2.17.1

