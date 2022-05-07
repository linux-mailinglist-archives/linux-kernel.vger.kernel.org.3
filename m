Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE051E4F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445921AbiEGG6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiEGG6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:58:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289745DD0C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:54:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p8so7994232pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QReXyHcN++8ZnG2EAL0MCJ6b3jaE9j2fBL439Rjlnbw=;
        b=s+YUi5RX2rfgtaYeELXxYjzxZHhXeqAlxqYW841Loi+QpDbMl5CvQr20fAZ0/+sGh9
         r6ZG2cvgzgePuBm7irTI6/W4JXSG4flFw2g2YtS8llhCdlcV6hjxybpSsf2Rff8VPgIP
         hL5wmIWP8rnKLApA3ZG8UcxzrGJg4iZd8vslmn9fq2xxX9+TiquMWpEVtVsfL5w6WVrq
         zCC/RLz+12TAFjewEH0u0bzgkVYRDGaLF9qGmGHCeTqhsX5iHZwBIR2LoQxEdMH+NqT5
         QWLsDOP2R5W8aOSmStQhtxsen1knaqqEOFNxHVD95UR1vx/5yxQneV9RvWzvVnoA7edS
         WCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QReXyHcN++8ZnG2EAL0MCJ6b3jaE9j2fBL439Rjlnbw=;
        b=j+vnnWdVPPvgwCFGUi8LuVnlmMK45tY3JCMJxBUJuXfHHSS9p1Ollyi1KNh1HWuEVr
         JsVBypCbE2bDHv+8fWlCvFDCKwhX6x4ShOjQ5m/4L+QzqZALmrnsPpzxCSpMZIGCpnHz
         XnaOJZo9HHUkVcaVHWt9XfhfJz2/9GXkXQDkxgQ5S3/1ub277esQAwxjfegCblycY/XY
         Qbrg5fWvjydH6RJ4iV/h2fSyMrYc6LH+ppVuuZFx4exun5o8r/vMZDMjKCpZmTodtAmA
         dnTVL9XbjPsl/+KzZHvykFzX0W9EobdcNUkDOdjfchMrFI0hkkHL8S+hF6ynYoXbUXzF
         MYqQ==
X-Gm-Message-State: AOAM531moFoofBgAqunzGxhe1CQxg6O8Jrk3NUHAubcWU3gMb2DEzd+9
        56yW87A3bncroI9teYDab/XXYg==
X-Google-Smtp-Source: ABdhPJw6SAxt8Mk4xZLntEaQck4s/Gg8DeKj51whay6UwZPAno6fleXHlqMOPIazxWlobmQT4EEXyA==
X-Received: by 2002:a63:4d1:0:b0:3c1:630d:b6b with SMTP id 200-20020a6304d1000000b003c1630d0b6bmr5767272pge.623.1651906465566;
        Fri, 06 May 2022 23:54:25 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709027c9400b0015e8d4eb1ebsm2905162pll.53.2022.05.06.23.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 23:54:25 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kbusch@kernel.org, hch@lst.de
Cc:     sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/3] nvme: introduce bit 5 of smart critical warning
Date:   Sat,  7 May 2022 14:50:24 +0800
Message-Id: <20220507065026.260306-2-pizhenwei@bytedance.com>
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

According to NVM Express v1.4, Section 5.14.1.2 ("SMART / Health
Information"), introduce bit 5 for "Persistent Memory Region has become
read-only or unreliable".

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/linux/nvme.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f626a445d1a8..882ad7523127 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -662,6 +662,7 @@ enum {
 	NVME_SMART_CRIT_RELIABILITY	= 1 << 2,
 	NVME_SMART_CRIT_MEDIA		= 1 << 3,
 	NVME_SMART_CRIT_VOLATILE_MEMORY	= 1 << 4,
+	NVME_SMART_CRIT_PMR_UNRELIABLE	= 1 << 5,
 };
 
 enum {
-- 
2.20.1

