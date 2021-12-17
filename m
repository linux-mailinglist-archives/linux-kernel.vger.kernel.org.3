Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA3478183
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhLQAih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbhLQAiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FsfI+d16ZHT7U20YgR9uB50qmdKHn5s4Pa/859D20hE=;
        b=ETC+eVYktY8fbvq9Ck7l+6tUYLphLSOdUIAIlkppu5UaOFYyK4Gu9rSnkTYxckjEgUQoEu
        TYtbe1RWJ37hVqvoFF+M7g5vtRxqmyIYsV8RCUQpxIntV7wHq2Z97o2zfRqzGNioTICQvd
        20sNpu5DKiKkmeghO+ZwGRCfXP8TJ9w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-5MBe6K7XPee70vvG7Ve4aA-1; Thu, 16 Dec 2021 19:38:17 -0500
X-MC-Unique: 5MBe6K7XPee70vvG7Ve4aA-1
Received: by mail-wm1-f70.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso2075088wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FsfI+d16ZHT7U20YgR9uB50qmdKHn5s4Pa/859D20hE=;
        b=S2ZtIMQ2YM0TZBqo1b8N10aTX3CI7Qeo83A+X44zTPoCJmAdDQ3N8RAOtcZQ09y6ZG
         xIOiQgknQFz3H1Pc87kHTpWbnrsPSvEzOBsVUeV88GcGUWluYFFBO+B4GNeP6LHB3gFg
         +QNLtZc1Gm92YSyjvCDhU5o12uFyEj5ElyIWN6/5brARO65SwYpumFMFmWrWmvHTdW/C
         R3CrrMygWHoqCaEpaRwg+BPI1aKS9k3oHz9PkEyvp/pVcKTDEqCcmIOSwiW6d48Bz+Ae
         nwQrS8pChgUVbP8/kKlO4g1mm/Kn6Ji2bA8qiNrnEQTmHv3vSHjq171svMEMw6bnIMV3
         NbLQ==
X-Gm-Message-State: AOAM5331OiOtV2ICnb0krZwIc76tXTa+Lf7f/+VP58mWwcfCDqCIzSAL
        xolgVlCV1xHbc0ghL4gvf4al+yGs0OGvCIj4RATTE1wwrV3BBpwgUBjLUpSpjKhXrjePQbvUwyZ
        hGBtSShJP6ZlYQ+KQdzBvSovClFO8Kd98C1c92k5JZnBRqsrt4Q6pYndp0hDKlvxxkl0HNu0TGX
        I=
X-Received: by 2002:a05:600c:a4c:: with SMTP id c12mr381246wmq.60.1639701496377;
        Thu, 16 Dec 2021 16:38:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxa21ig9FvI3AJDxyhoutl00Tdje+5AV6C8F9kikVcdCfU1ZAZ7AXOdQDQlpDwvwqi1nM2JQA==
X-Received: by 2002:a05:600c:a4c:: with SMTP id c12mr381233wmq.60.1639701496201;
        Thu, 16 Dec 2021 16:38:16 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:16 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Alexey Brodkin <abrodkin@synopsys.com>
Subject: [PATCH v2 18/37] drm/arc: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:33 +0100
Message-Id: <20211217003752.3946210-19-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro calls to a DRM specific platform driver init handler that checks
whether the driver is allowed to be registered or not.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index f8531c50a072..42c5a7137a47 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -427,7 +427,7 @@ static struct platform_driver arcpgu_platform_driver = {
 		   },
 };
 
-module_platform_driver(arcpgu_platform_driver);
+drm_module_platform_driver(arcpgu_platform_driver);
 
 MODULE_AUTHOR("Carlos Palminha <palminha@synopsys.com>");
 MODULE_DESCRIPTION("ARC PGU DRM driver");
-- 
2.33.1

