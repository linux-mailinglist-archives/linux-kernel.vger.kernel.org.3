Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D00515F9C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359492AbiD3RgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbiD3RgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 592303FD80
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651339974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zBSkksDiD0TDmy/DS9njRj20qkfr7G9H5zq25pKi4QM=;
        b=cQREgzcIzyDKUV2V4bA2afZ5TjB569BvMtCF96YfgxXY+H4CnVgPOKmittK2v0G/m0DlyG
        cH2xxlKgpD7D4tRZ3KuDlXtdceDYp/aP96ydoo6pAcEasAcaUX0DL0oaiO3XHrNBy8Nrfl
        oLeW+pyrGkWIoyzbvwqOhghmo89C41U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-XSqKNEChPcSO7sVPkpZ8Qw-1; Sat, 30 Apr 2022 13:32:53 -0400
X-MC-Unique: XSqKNEChPcSO7sVPkpZ8Qw-1
Received: by mail-qt1-f198.google.com with SMTP id a24-20020ac81098000000b002e1e06a72aeso7822020qtj.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBSkksDiD0TDmy/DS9njRj20qkfr7G9H5zq25pKi4QM=;
        b=M/CJMPl71GQOSEw02yk/hxv0iPJtR1aMEAqdQiLgFkLGQSrcnEdfK0ntOilnaRvs+V
         FFyHMmnxPaX2G9+O4RxezH0nzLAJKPeU6WHdXxdJUtZ3+rYMoaQ9DLJVSknAQm8HN4gg
         7TnQlqhhVl6/tdCm2PwonOa2U3HBzEfM2sKLLs5Et/GYgJrkQp69DwRSmZ3UlYBh+fM2
         yLhRYatHZ2jaR7yFp6d+UnPyCX7vOcfKRJOyomt81pWyJ2rvDWRmQYqzammgUhP91leF
         qF5QproufnFlQ+f/zgQfVwzOJ9XdfCgmTsxdhyTRjW1yocSFXX8XvLOFtt4VIhMhtS9+
         afGw==
X-Gm-Message-State: AOAM53059n6aQQwC91o1YVOs07IrR9CAiKC2ABSRDbcUPja5emH4hLsU
        BnAxBy11oXIrXkstlrELmwjM6WIG0EVYIq/+7wEWPBhFx3gUMbPsY7rnTBYgAONdGexjl9lYOU2
        v4+Gej7i65ld/egAcTeFic/N0
X-Received: by 2002:a05:622a:610a:b0:2f1:d998:319b with SMTP id hg10-20020a05622a610a00b002f1d998319bmr4256722qtb.478.1651339972329;
        Sat, 30 Apr 2022 10:32:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8ji7TIms/6lWItU8JkcGNfAWJFnSva0czFszOmvNFr8UkdmXZzxPp+O2FdkFTLXzGXfC6Vg==
X-Received: by 2002:a05:622a:610a:b0:2f1:d998:319b with SMTP id hg10-20020a05622a610a00b002f1d998319bmr4256707qtb.478.1651339972104;
        Sat, 30 Apr 2022 10:32:52 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q73-20020a37a74c000000b0069f879fd52esm1477912qke.0.2022.04.30.10.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 10:32:51 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jpoimboe@redhat.com, peterz@infradead.org, mingo@kernel.org,
        bp@suse.de
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] objtool: rework error handling in objtool_create_backup
Date:   Sat, 30 Apr 2022 13:32:40 -0400
Message-Id: <20220430173240.3346735-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cppcheck reports this issue
[tools/objtool/objtool.c:65]: (error) Memory leak: name

This is a general problem.  When ojbtool_create_backup() fails anywhere it
returns an error without freeing any of the buffers it allocates.  So
rework the error handler to goto the appropriate free level when an error
occurs.

Fixes: 8ad15c690084 ("objtool: Add --backup")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/objtool/objtool.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 512669ce064c..2fd10804e7a7 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -25,6 +25,7 @@ static bool objtool_create_backup(const char *_objname)
 {
 	int len = strlen(_objname);
 	char *buf, *base, *name = malloc(len+6);
+	bool ret = false;
 	int s, d, l, t;
 
 	if (!name) {
@@ -38,19 +39,19 @@ static bool objtool_create_backup(const char *_objname)
 	d = open(name, O_CREAT|O_WRONLY|O_TRUNC, 0644);
 	if (d < 0) {
 		perror("failed to create backup file");
-		return false;
+		goto err1;
 	}
 
 	s = open(_objname, O_RDONLY);
 	if (s < 0) {
 		perror("failed to open orig file");
-		return false;
+		goto err2;
 	}
 
 	buf = malloc(4096);
 	if (!buf) {
 		perror("failed backup data malloc");
-		return false;
+		goto err3;
 	}
 
 	while ((l = read(s, buf, 4096)) > 0) {
@@ -59,7 +60,7 @@ static bool objtool_create_backup(const char *_objname)
 			t = write(d, base, l);
 			if (t < 0) {
 				perror("failed backup write");
-				return false;
+				goto err4;
 			}
 			base += t;
 			l -= t;
@@ -68,15 +69,21 @@ static bool objtool_create_backup(const char *_objname)
 
 	if (l < 0) {
 		perror("failed backup read");
-		return false;
+		goto err4;
 	}
 
-	free(name);
+	ret = true;
+
+err4:
 	free(buf);
-	close(d);
+err3:
 	close(s);
+err2:
+	close(d);
+err1:
+	free(name);
 
-	return true;
+	return ret;
 }
 
 struct objtool_file *objtool_open_read(const char *_objname)
-- 
2.27.0

