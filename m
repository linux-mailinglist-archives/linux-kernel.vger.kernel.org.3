Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885075A1997
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbiHYTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbiHYTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DBB07EE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661455988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9XR5FVAUqbSLwcJx16FTwnOJqAbBYMljn2kBaUfYTk=;
        b=Fvf757nqhIC+PLTPBXSwIZIl4hPfjwgsMRrgUwuHjdhd7H1iL3HFrEScCohWt+cSXr3nTQ
        qGhQN7yORr0kXI8zYQmY647YrM7Hc3VqU+XbYBsWIQ7rkv+nr/s5fXYGtZetK1u94zV50U
        kj/wWRLc3p60y7vYl3abP+PTxOPm8pI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-VpVleT0WN86RIagFMaKyCw-1; Thu, 25 Aug 2022 15:33:05 -0400
X-MC-Unique: VpVleT0WN86RIagFMaKyCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A0A23800C2D;
        Thu, 25 Aug 2022 19:33:05 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF48D492C3B;
        Thu, 25 Aug 2022 19:33:03 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, omosnace@redhat.com
Subject: [PATCH ghak138 v2 2/4] audit: explicitly check audit_context->context enum value
Date:   Thu, 25 Aug 2022 15:32:38 -0400
Message-Id: <8728d12e4d765aa388602d9bc894bde75d9f476f.1661449312.git.rgb@redhat.com>
In-Reply-To: <cover.1661449312.git.rgb@redhat.com>
References: <cover.1661449312.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be explicit in checking the struct audit_context "context" member enum
value rather than assuming the order of context enum values.

Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 21e50e6d0fc0..d77c9805c6b1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2068,7 +2068,7 @@ void __audit_syscall_exit(int success, long return_code)
 	/* run through both filters to ensure we set the filterkey properly */
 	audit_filter_syscall(current, context);
 	audit_filter_inodes(current, context);
-	if (context->current_state < AUDIT_STATE_RECORD)
+	if (context->current_state != AUDIT_STATE_RECORD)
 		goto out;
 
 	audit_return_fixup(context, success, return_code);
-- 
2.27.0

