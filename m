Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2F558AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiFWVp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFWVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:45:57 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E25DF10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:45:56 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id y14so1953986qvs.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=0CKIvS9aMMD66vxtqOCpuSRDl9nO4eJxY8IunK0l4JM=;
        b=kiXTECQuqsVsoAs6FW8RtPr1gnI5f+58WVXHXXPoKqUaxVWZz9GwfoZQevO566/mSE
         7rHxJ2QYgzSlhzU/3+ZpZSXb1Yvi/I1+4kp15iCNFLuG0C3DT1mzwz8Oss5Wuwed3uhF
         d+t16nmkRA/RJf/jXj0NhFhDJ5ni5ehsdYBikC5/wL8Ztc8tq+qD3KwRMNVni7NaG8Qs
         7FVpnXKL9BbG52h+JhKp+qBVdZAC60t9hV5omZOSSfD4SaNT4uTRCbC/HgTJYomjI4ya
         clcc2vFCLsK4utYC4jT+BRNtCKb9AvNyVCvnesPtQ1OpHdxPodGQj6KI5sdoKwh010YI
         4xgw==
X-Gm-Message-State: AJIora9hKm0dPTwh60DHuxv3CLm+XGnz7z31RYbwoCai/+gUWUW0DwY8
        pjUkR8tU3/i2FxdzCQDo5mF70iyrpdZ4af/XDFM=
X-Google-Smtp-Source: AGRyM1v2usadGTyZlqb6Ml0femKSWEGiKQVOdlevtUzZRfFJcHhEqUEnKteRGPis2XQ5p5NCS+A1cw==
X-Received: by 2002:a05:6214:e83:b0:470:54c3:e18e with SMTP id hf3-20020a0562140e8300b0047054c3e18emr13015049qvb.3.1656020755830;
        Thu, 23 Jun 2022 14:45:55 -0700 (PDT)
Received: from castiana ([2602:fc62:a:35::50])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a222800b006ab935c1563sm483237qkh.8.2022.06.23.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:45:55 -0700 (PDT)
Date:   Thu, 23 Jun 2022 16:45:52 -0500
From:   =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        stable@vger.kernel.org
Subject: [PATCH RESEND] tools/vm/slabinfo: Handle files in debugfs
Message-ID: <YrTfEHvpysJAVWWr@castiana>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.34.1
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 64dd68497be76 relocated and renamed the alloc_calls and
free_calls files from /sys/kernel/slab/NAME/*_calls over to
/sys/kernel/debug/slab/NAME/*_calls but didn't update the slabinfo tool
with the new location.

This change will now have slabinfo look at the new location (and filenames)
with a fallback to the prior files.

Fixes: 64dd68497be76 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Graber <stgraber@ubuntu.com>
Tested-by: Stéphane Graber <stgraber@ubuntu.com>
---
 tools/vm/slabinfo.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 9b68658b6bb8..5b98f3ee58a5 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -233,6 +233,24 @@ static unsigned long read_slab_obj(struct slabinfo *s, const char *name)
 	return l;
 }
 
+static unsigned long read_debug_slab_obj(struct slabinfo *s, const char *name)
+{
+	char x[128];
+	FILE *f;
+	size_t l;
+
+	snprintf(x, 128, "/sys/kernel/debug/slab/%s/%s", s->name, name);
+	f = fopen(x, "r");
+	if (!f) {
+		buffer[0] = 0;
+		l = 0;
+	} else {
+		l = fread(buffer, 1, sizeof(buffer), f);
+		buffer[l] = 0;
+		fclose(f);
+	}
+	return l;
+}
 
 /*
  * Put a size string together
@@ -409,14 +427,18 @@ static void show_tracking(struct slabinfo *s)
 {
 	printf("\n%s: Kernel object allocation\n", s->name);
 	printf("-----------------------------------------------------------------------\n");
-	if (read_slab_obj(s, "alloc_calls"))
+	if (read_debug_slab_obj(s, "alloc_traces"))
+		printf("%s", buffer);
+	else if (read_slab_obj(s, "alloc_calls"))
 		printf("%s", buffer);
 	else
 		printf("No Data\n");
 
 	printf("\n%s: Kernel object freeing\n", s->name);
 	printf("------------------------------------------------------------------------\n");
-	if (read_slab_obj(s, "free_calls"))
+	if (read_debug_slab_obj(s, "free_traces"))
+		printf("%s", buffer);
+	else if (read_slab_obj(s, "free_calls"))
 		printf("%s", buffer);
 	else
 		printf("No Data\n");
-- 
2.34.1

