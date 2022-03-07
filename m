Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E234CFFA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbiCGNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242779AbiCGNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:09:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25282D20
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:08:53 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b8so13415955pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FAEIk56iYrAuK3MHoOT3nS4Qb+vOqV2LEpPx2yYRAU=;
        b=UjMZLsDLy9mCu8/dtQDwPqLjHTvTyNUIOUo6ybj/xzbcbHacSb2nQwfeBr+B3BjPcl
         mohyYwuVC1tn5KlIMmCvbleNlC4A1Fqy4LrySAQwkwZSQe9FjDR1sWCmmtSbauF/HwNZ
         EVNiL4Qb7fq3FTb8DdjLQDlAguAnJg3sKhK56EShokt7xobJdH9+KVtKc9C+rBjCjMrO
         ZYS5+r69TrKsEbdZTSPTjFyqjZK1k0/Za0HblRZ3OGdsa+ZP/TRwR7fxfhFGqVf/7wkI
         ZmXJRV3/kro/+He81jlubfv0cCdqHlyx4ThM2Kc4/fr7cv+I3CJLI9CUKEApUNZO+k0A
         /Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FAEIk56iYrAuK3MHoOT3nS4Qb+vOqV2LEpPx2yYRAU=;
        b=EqdA/mDE9BNfLWm7lTSVlsqmAcXJDILwBY1q6TNxoDNrMAPtgB2ZMU4SikR311HC+u
         l1gC5RSBNCNoBYap0Nf0Mmz23lVPkwFwpV9lPvxa3sODQDe+K4n7E6ypfD3Y2z6Wcxvb
         DR8pygwYYrdr5a04UNda5Qui2I8vnxDKR+5Z79YoxPwJg1P/zB90c1VJ60Ue2K/8aSHv
         PXv31pB9mpgVi1lyCFKvR2vD604lzLbdNOembHReSHzP8ApazzO7cX46e2o/5RIr9P51
         Nb66RONcjPLG+HcPTiF/r1ai3441Ou1cBkhuDsd6DRs48U4m8MThaPEyf/1ngDITIl4H
         jDRw==
X-Gm-Message-State: AOAM532JO06930t5op8yeENh46YHCmsebXdkegvFs6ouBHCQ+6EWJq7w
        17wHcOsZDiPeR+touJnPOsakXg==
X-Google-Smtp-Source: ABdhPJxq9zQCb9Rxmm8KdTGq3LEG09tBwTdNh4JsDI4M5Ye2wPb5suJqnSJDNrAzNc8BX+kYsp7OwQ==
X-Received: by 2002:a17:902:ef4c:b0:14f:7548:dae3 with SMTP id e12-20020a170902ef4c00b0014f7548dae3mr11899068plx.92.1646658532607;
        Mon, 07 Mar 2022 05:08:52 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79409000000b004f704d33ca0sm3258528pfo.136.2022.03.07.05.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:08:52 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/4] sysctl: allow to set extra1 to SYSCTL_ONE
Date:   Mon,  7 Mar 2022 21:07:07 +0800
Message-Id: <20220307130708.58771-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220307130708.58771-1-songmuchun@bytedance.com>
References: <20220307130708.58771-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_do_static_key() does not consider the situation where a sysctl is only
allowed to be enabled and cannot be disabled under certain circumstances
since it set "->extra1" to SYSCTL_ZERO unconditionally.  This patch add the
functionality to set "->extra1" accordingly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 64065abf361e..ab3e9c937268 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1631,7 +1631,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.data   = &val,
 		.maxlen = sizeof(val),
 		.mode   = table->mode,
-		.extra1 = SYSCTL_ZERO,
+		.extra1 = table->extra1 == SYSCTL_ONE ? SYSCTL_ONE : SYSCTL_ZERO,
 		.extra2 = SYSCTL_ONE,
 	};
 
-- 
2.11.0

