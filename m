Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45D148DFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiAMVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbiAMVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:30:55 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2738C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:30:55 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s22so9629094oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dL7Kyw5R5uEJ5iFptCvOaKv8TqVxuhvnFOanF/ug8Oo=;
        b=hTJNWfpBwWHBXmDAw3gLRIR3djfB+sK2GlFOBYJqrMUl/HiEOQGTQoo9yPe+EWanj8
         09iUccyveauB4v3d65kz1O/ho3Hm/bg/9JXoxX/39geyyvUSYl7Inx2ynNhG0bWLzbpn
         EhhJY776tO9ns0OiI1tOeBENLXIyLkzA684P1WLxGNGqws0uGjPbRBPU5veXOLw9SsuS
         sn3lT/ZzP9jS25qxkumsln1WApOkQJktI9Dttaw8+F4U2YuMu9KuwzQXeQD5eStbo8be
         jFu7gWvEVQSC3a7lZHb8H3fUXEgA5MBfzyC3EvB7UVpfZhnFE+7z3A1haLlxBc5tRlw/
         2s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dL7Kyw5R5uEJ5iFptCvOaKv8TqVxuhvnFOanF/ug8Oo=;
        b=GmkODeMB4D4vkW34sn5Zw1u4W6LDNhXYyW4U8vS4x8p5nKnzSsOkTob//L6TXJYoHe
         +irV/kGHm/QFRge7TwLY7csr8fC8+sjxNfOsgW9pmOIuXRLQ5mN6QhtPvtMOvo0dg5lP
         T7WYzNV6lPwp3eb5acabM8lb4EDWand0GXqHPpx+v7TAMxuPPdMhr2LCUKCHxEhoB3TW
         GqKwGod+1eWi5KYi+XVaZh1KEhq22slC0OFXf0otJbDPz7qd4TsUDCCWXjlP3/weVg2v
         nNG576jcXXbEbLrYmXirMGc62EDo7PBELTLWOxABpmy1U5BnYKHeogtFGsbOQcgTm5uR
         +2aw==
X-Gm-Message-State: AOAM532NJQHZ++qZ4EdK6ALXLfp3N0vgSXuBKXB1HkaaRrLxwjryd8BI
        5vd9QXF59GR6XmksGGSaeq6BitUTabKeoUrbz95hh/mjz1XDol7kUmMAuVT2+Vm0LSpBY4WNt7y
        K0dpYUzB7bpgZea9+Mxwz0w3t6H/e5o7wP0+NHeyr+IZTGTe2UlMWMjt4fMliD4RVZjSlo8n8hP
        O555l4B0nnbWpv+bJ+8wQ=
X-Google-Smtp-Source: ABdhPJzDN1onylDe2EOdadMwtWVnznDi7osDVKOSlKgZ23uvQiFvC/0MpSn76QDva8qLZ5/xZMp8EQ==
X-Received: by 2002:aca:a80d:: with SMTP id r13mr8142853oie.21.1642109454826;
        Thu, 13 Jan 2022 13:30:54 -0800 (PST)
Received: from localhost (115-127-16-190.fibertel.com.ar. [190.16.127.115])
        by smtp.gmail.com with ESMTPSA id i18sm626212oob.41.2022.01.13.13.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 13:30:54 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v5 2/5] mm/mmzone: Tag pg_data_t with crypto capabilities
Date:   Thu, 13 Jan 2022 18:30:24 -0300
Message-Id: <20220113213027.457282-3-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new member in the pg_data_t struct tell whether the node
corresponding to that pg_data_t is able to do hardware memory encryption.

This will be read from sysfs.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/mmzone.h | 3 +++
 mm/page_alloc.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 936dc0b6c226..cec51e7a01d9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -871,6 +871,9 @@ typedef struct pglist_data {
 	struct task_struct *kcompactd;
 	bool proactive_compact_trigger;
 #endif
+
+	bool crypto_capable;
+
 	/*
 	 * This is a per-node reserve of pages that are not available
 	 * to userspace allocations.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..8bcbd6fa0089 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7592,6 +7592,7 @@ static void __init free_area_init_node(int nid)
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
+	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);
 
 	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
 		(u64)start_pfn << PAGE_SHIFT,
-- 
2.30.2

