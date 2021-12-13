Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB48547379A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbhLMWeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbhLMWdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:52 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80456C0698C5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id a23so11178221pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8+A8j+rHqGqyjhORZtmUC3k/Ykd9LwWvt9gM1sSL4w=;
        b=kPXWVDA0OJANDtqdXFbmdQsXPuuCRUljPLu9jVDUb27KhXMUSfnQ7NszvriWJ6IMK7
         SMbL1Z3QHK4YewylqF0YKv1c6t5cOcKNtzpz6y0rDbz/iAPpR5/jLjq24IjoB2sBbvub
         vwTy8UEhHG7pBH4ZajunTO2Wud8RYIN0fm2LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8+A8j+rHqGqyjhORZtmUC3k/Ykd9LwWvt9gM1sSL4w=;
        b=ywc5mUM2KurrPnuv5xV3bJTe4oQdZInFDZfTTuiZSwc2zi1R/joMpU8jvtfzmSo70t
         oPPhIxqnDSQgTKKKc41l6jd5GKfBl+iSbwnZ7ZliKcZ/UkDe7kLzqSf70Q5Edz/yZgyp
         rGzBJFVCVhc6vXuNWGh+jRt40YRWIGpoISf1aR+J8CpfSU9aSHZ02vMsKSdnreId3Nlo
         BT4D4N5KvlIz+XYsRulDsIJiuy6RANl2MsK3rSlpj+Eky1Vo46gvbEtwISqJFJ+/PKSS
         TM0bAhKtUz0KcguV055KfILVJVZuo75td1evoHRTLbXkXkuVWjarrH+uh/+83R76VPg3
         ooTw==
X-Gm-Message-State: AOAM530Ekl4ZmUnInDmx1Dxfm5N/B9uDsaD1AtGjrxzIDPviXXV32VVJ
        +PYvTMpU+i94TvLP6UbO0fD6+ZEYBy994Q==
X-Google-Smtp-Source: ABdhPJwBI2iaQHFjGvjj4FyJPu+fMCNUjCFJGq92nzr+YvN+bE7msvk3+bvx25fGOD7/kc5Kh0YxMw==
X-Received: by 2002:a63:5558:: with SMTP id f24mr1048941pgm.484.1639434822054;
        Mon, 13 Dec 2021 14:33:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14sm12033100pfh.71.2021.12.13.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] intel_th: msu: Use memset_startat() for clearing hw header
Date:   Mon, 13 Dec 2021 14:33:27 -0800
Message-Id: <20211213223331.135412-14-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; h=from:subject; bh=qzlGCD27XMuNH9MVQmXMgZG1FIe/7icBY6kWSF3V5Ls=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o5GcgQhBrn1k+xwCA75oPF9uYLmzGzqWG3IWZz 8oqbDWKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOQAKCRCJcvTf3G3AJu1aD/ wPFTMglugeDMGxl4jGeZRJ/NtSXFKSP8H8O6u4BzjwNShgpWo84ekZkJHheNvk8CnoSn5FNLus5e3P mWktIcs3jp+xez1X8a9VuYSaRjG5spFUfLE9bS6okbk4cmD3H4lMnaPXiF8NZ5OiTZdTKYrccea7cv N7/rQFDiXxTbe5nwr1lGVqjIvzwWuOPsT5QUyg2+02zYQEkO6TWmIkx1j95pFze7sWjJMH57+6Cpce x5QTIBlq8GNtsboZyZmAwV497VvlHhXa1MuiDMTrwDca4A8Mi/Sjj+mDg6KZyMHjYA5VYm00iX6I2A vfGv9smEkypeG0dx/5V38r+xiL4baYddhUfmUkuRyamtvP4ElAstVFFxu8qeQr3WNBXSIrHN0VWWRc dytgrygPt7Z2skMjD45Q7/GM3Yt7PhwSrdm4wMmAvRYnG4wZUjUVfdVshDjpvSm1u+WA0GvW9oFpWe B64AjsAARw/NpTXLPt6WS8mor+Csq00TPXGO9hYyVvfevnS/wY3Yk+uSI/Yhwyaa5fbzE7tSbXmBHQ 34TGvaigWLvczP+2AiwfxEFAUtZUAh8lNywtM/mAizXQ5kYldCY9AdLftI2a3ttOBNE7dxcp/KV0AN nYi+zhnaL80KM9EUoYT9D5bEdDqElZh5yoNDPl9xAzG+i2HscRBS8uD7bYSQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lore.kernel.org/lkml/87sfyzi97l.fsf@ashishki-desk.ger.corp.intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hwtracing/intel_th/msu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 432ade0842f6..70a07b4e9967 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -658,13 +658,11 @@ static void msc_buffer_clear_hw_header(struct msc *msc)
 
 	list_for_each_entry(win, &msc->win_list, entry) {
 		unsigned int blk;
-		size_t hw_sz = sizeof(struct msc_block_desc) -
-			offsetof(struct msc_block_desc, hw_tag);
 
 		for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
 			struct msc_block_desc *bdesc = sg_virt(sg);
 
-			memset(&bdesc->hw_tag, 0, hw_sz);
+			memset_startat(bdesc, 0, hw_tag);
 		}
 	}
 }
-- 
2.30.2

