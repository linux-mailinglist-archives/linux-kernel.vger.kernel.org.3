Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB4529E25
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbiEQJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243364AbiEQJgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:36:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CE33E3C;
        Tue, 17 May 2022 02:36:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd25so9015055edb.3;
        Tue, 17 May 2022 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvIkZ+SZSnuVFUBNtp24/kBbyO+aODjZMJiPGY46AQE=;
        b=hZy9xMRoeMjucGbLNTRVbjQzweG34s/HHZiePWY8egY5hToreKw6isov44Nib2PTzO
         FCx66HVsM8Oz2KQXRuHDxzOQXtqMH+LV3yMXZUv/N+96pChUkE6uBNLPmaDmaUY+kkk/
         jC5Rw6dSJvrUNOwdSaFcRnOPNP/CUbBczzmurEOx/d8eSfbLgDBWZZ3Ycl1MhIDD8yUZ
         aYz4hP2TyqCT/DHTDbpO2fLitzhtZbuSbfdkJh0nfeItaekFFZ62BodDTtCIHQr5h1pp
         ooayMP5lqRWWLWDbiA4yjmjUx2XLFxUn1B+qxxZhKlZTrZC1/f4/9Z7uzQJwTlU0Sdp+
         ZsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvIkZ+SZSnuVFUBNtp24/kBbyO+aODjZMJiPGY46AQE=;
        b=WrM4Gvw85v2w+3gFW4y4C0pjchObFrnisnXzsZMfxJZR9v/ItBiaR5S+yM9q6OJ6xB
         mlWNyYefzPq8hGPhJ9/spCH8BuHziTMX+HasTWUQeDRtcxA5mwHoegjyH0RuIAgnStHY
         SVLyJe9b3JRgFSRysKOYmxt2vvMLxH7PQCOcnOCZJxY5l/djBIeDqE55Q5tzuLtdqu0I
         k2oSn2zvu4TAPsXvso9RqLbdmsu3/iVTti9CGxXJvjnzaKpZPuzY7mbHaJdEXRm5W3BN
         wtaxiRnhW8QHM46hS4cu01l3oaoUAEIMxuX4Hd+tcn7lM42tETF1S2QqBKwXJDQrG07I
         aNng==
X-Gm-Message-State: AOAM533JOavgC1O7BjRrlq9iNBpz/VTFv9sQ07TW7mX01shr5K1GiFGE
        5PpRdbL317TUmdzc3FWg3P3zrj+ww+TRWQ==
X-Google-Smtp-Source: ABdhPJzkJ1+hct8RVYLZUQys4gtJGoLHdQdl+zoZJQX+sv/QCfHsqiv5nvS1l/4DtAk/g3zzoROvCA==
X-Received: by 2002:a05:6402:26ca:b0:427:c181:b0ed with SMTP id x10-20020a05640226ca00b00427c181b0edmr17810926edd.400.1652780209084;
        Tue, 17 May 2022 02:36:49 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bx12-20020a170906a1cc00b006f3ef214db7sm827867ejb.29.2022.05.17.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 02:36:48 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs: remove redundant variable idx
Date:   Tue, 17 May 2022 10:36:46 +0100
Message-Id: <20220517093646.93628-2-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517093646.93628-1-colin.i.king@gmail.com>
References: <20220517093646.93628-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable idx is assigned a value and is never read. The variable
is not used and is redundant, remove it.

Cleans up clang scan build warning:
warning: Although the value stored to 'idx' is used in the enclosing
expression, the value is never actually read from 'idx'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e1392a9b8ceb..a8abe2296514 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1772,11 +1772,11 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 	last_vcn = -1;
 	do {
 		VCN vcn;
-		pgoff_t idx, start_idx;
+		pgoff_t start_idx;
 		unsigned ofs, do_pages, u;
 		size_t copied;
 
-		start_idx = idx = pos >> PAGE_SHIFT;
+		start_idx = pos >> PAGE_SHIFT;
 		ofs = pos & ~PAGE_MASK;
 		bytes = PAGE_SIZE - ofs;
 		do_pages = 1;
-- 
2.35.1

