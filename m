Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5451E4F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445948AbiEGG6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445927AbiEGG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:58:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA95DD0C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:54:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e24so8869889pjt.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ea/7f8A4NPQmZCTH61ttxUc8ZcgpbXzjfNgGF4s2Ed8=;
        b=HV26AlNcvQjy5U6VCD2LyHjl66aup0wiyAv9NbIbjwNj4A5rzlYWDAopGzbQlgCHfn
         Vtt3dcN9sXGKfTkYkc45A3mkD7SLE8qP5yBaZOcWvPOpXLl0pCde87ILhrDTavB7RPHY
         1WZgvdHqkKBBHxxDGvd7vOWgSCxEQE23wKXyC9XTKCg4WvSIitFpgtQjpdLZxsUfw8Bo
         gJaSFkbXfhu52lZKOthl/9Q010pvSdraynadbyaEs6C153grIWgpOiu8ShONZIwTrJZE
         D3VR55j8kTGmwxu/muldSinB74Z7u0/9P0we/UsSBfPy1k+xOb4ZIWEyTs+J1RcQlIzE
         VrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ea/7f8A4NPQmZCTH61ttxUc8ZcgpbXzjfNgGF4s2Ed8=;
        b=5lnY2U75AhA1cPhxdm74kFd2Q0/1Es/ZeLYJHtd91mfAOUY2p/qWyHe26pjpJouKJl
         O1A5qs5EbQmOf4jQkFEjlHI04WPjypyBMUoX7S+8889Z9j4ceEMu89JcbyyYwBCHfv04
         SYRVkWh+/PLbw6JX3U2cEpBG/COwA+c1WLcQLELsPMVEFhmntdQNtOXz2SPWM+1NmTHR
         M0tnQh1DM91W8ZEpFL/CLh8pwukvG88NQII4j4Nt8BW5ZksBZp9gUAkHr9O4KXkUmqHO
         iDAevT0mQ+jyxhw9zviQlOJIcOdUj7pzxFglenyxA24CPg3PwxhoBDX7oA1o5jQ01xF5
         c16Q==
X-Gm-Message-State: AOAM530XAUkE5qjFt2y7XYQJUVq+eyCN9hdIZ6pNPOuujneLdsQ4/EHZ
        RZXizZa7qP7x/7pCL5Cked0WwU4TWuVLZg==
X-Google-Smtp-Source: ABdhPJwVFbDKu1C1H66AqhkbJbo0SmUKfhgk9fiE1NUon3vtipkhLVIjMHrAkhfw3aRf2T0XRpo4oA==
X-Received: by 2002:a17:902:e742:b0:15e:9a7b:24c3 with SMTP id p2-20020a170902e74200b0015e9a7b24c3mr7311641plf.17.1651906473207;
        Fri, 06 May 2022 23:54:33 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709027c9400b0015e8d4eb1ebsm2905162pll.53.2022.05.06.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 23:54:32 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kbusch@kernel.org, hch@lst.de
Cc:     sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 3/3] nvme: enable smart AEN
Date:   Sat,  7 May 2022 14:50:26 +0800
Message-Id: <20220507065026.260306-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to enable AEN on host side, this is helpful to minitor the
critical warning from the NVMe controller.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e1846d04817f..f386a4f1d434 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1490,8 +1490,12 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
+#define NVME_AEN_SMART \
+	(NVME_AEN_CFG_SMART_CRIT_SPARE | NVME_AEN_CFG_SMART_CRIT_TEMPERATURE | \
+	 NVME_AEN_CFG_SMART_CRIT_RELIABILITY | NVME_AEN_CFG_SMART_CRIT_MEDIA | \
+	 NVME_AEN_CFG_SMART_CRIT_VOLATILE_MEMORY | NVME_AEN_CFG_SMART_CRIT_PMR_UNRELIABLE)
 #define NVME_AEN_SUPPORTED \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
+	(NVME_AEN_SMART | NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
 	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
-- 
2.20.1

