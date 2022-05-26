Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA9D535054
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbiEZOCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbiEZOCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA2882CDF6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653573754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t/NjQKnGqjNPpF942YZJrFLnAbWe3CnyInwbwktGydg=;
        b=JBImV1Nl94tFyYz61GaFnNzXr70jEqOYsZGijtCA0jspXKK1X2LPw/rb+5WWRYdHrjrbK2
        N9pC687i7eFcEZF7+4YCPP1SiW9Kn0Ahp/iTwXsoElHesM5miu1ZwfORXS7syY+quQWMrq
        gBFGkmnGqQD28d2/P3fRaVNXCnwn3Fw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-uWZRvlglNlWvEh-0PGHs5A-1; Thu, 26 May 2022 10:02:33 -0400
X-MC-Unique: uWZRvlglNlWvEh-0PGHs5A-1
Received: by mail-qv1-f70.google.com with SMTP id kk13-20020a056214508d00b004622b4b8762so1665457qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/NjQKnGqjNPpF942YZJrFLnAbWe3CnyInwbwktGydg=;
        b=I470wKSd42GAFq96dSIvMeLHy25V4U/qdmZMCVWWLrHa4nCLbOlgbSmDVCgM1oepb/
         B1VZRLa12LOg8BNI4QftlrMaGzY/BJvEG5Ov2Rhl91vUyeqGVZxyfWpI2p9VqaAMCubw
         OxItCnWfaaKmnliXaGYTAPN5IU1YHZ5kQ5GUdvJPtDpFwKKKakNoix1I8NNDaFOEwDcz
         QmxodphI12hRYqg1m7NEjOnHSuw/P+zInjfgO7x9IeTYuIrzi0VYEZgFTZaN1t6Ag0Pe
         dIyUvOyUnaB5VADn63yN8VxsawcQNPwNv7yss+xUDoorwwMvh+BsbhXxfkPn3ZirYI1T
         9oWA==
X-Gm-Message-State: AOAM530xpLTTBYViT4/YHXAZJ7/tfyQYxz7jOTRd+qZW9q7BRRl1tYfB
        RozhqMZNHyv/Z8a0+ENKuInZscLUpzu1ig1k9mXMhITkXWYUg16I9DV0RVdiB/x7U6JSNhZRT/o
        ZNfpfJPAiyzTAlWH6yrJo9UI0
X-Received: by 2002:a05:620a:199d:b0:6a3:a2d2:abee with SMTP id bm29-20020a05620a199d00b006a3a2d2abeemr12128634qkb.549.1653573751835;
        Thu, 26 May 2022 07:02:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx32tHOhTv7CHF4lQP4Z7dwEs3OmKH8agO67I1d5hvC5IwQ4wIyFmYszbKurImtJrG3LOJmcw==
X-Received: by 2002:a05:620a:199d:b0:6a3:a2d2:abee with SMTP id bm29-20020a05620a199d00b006a3a2d2abeemr12128604qkb.549.1653573751507;
        Thu, 26 May 2022 07:02:31 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u6-20020a05622a17c600b002f3dc9ebb4bsm950014qtk.65.2022.05.26.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:02:31 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sfrench@samba.org, nathan@kernel.org, ndesaulniers@google.com,
        dhowells@redhat.com
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cifs: set length when cifs_copy_pages_to_iter is successful
Date:   Thu, 26 May 2022 10:02:26 -0400
Message-Id: <20220526140226.2648689-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang build fails with
fs/cifs/smb2ops.c:4984:7: error: variable 'length' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
  if (rdata->result != 0) {
      ^~~~~~~~~~~~~~~~~~

handle_read_data() returns the number of bytes handled by setting the length variable.
This only happens in the copy_to_iter() branch, it needs to also happen in the
cifs_copy_pages_to_iter() branch.  When cifs_copy_pages_to_iter() is successful,
its parameter data_len is how many bytes were handled, so set length to data_len.

Fixes: 67fd8cff2b0f ("cifs: Change the I/O paths to use an iterator rather than a page list")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/cifs/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3630e132781f..bfad482ec186 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4988,7 +4988,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 				dequeue_mid(mid, rdata->result);
 			return 0;
 		}
-		rdata->got_bytes = pages_len;
+		length = rdata->got_bytes = pages_len;
 
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
-- 
2.27.0

