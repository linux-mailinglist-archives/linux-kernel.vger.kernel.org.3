Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35B04F86B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbiDGR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiDGR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F3CA15D3B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649354249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O+vrRrqMFJ6b+4wLQ7xCWgEu9n79uQKRvZqKAsaERm8=;
        b=JDOTIFBlhu7NCWOq6/Olacm2Ki0hLzBKuN1XfvSjdSq2t/gCnZCcY7josb4lluGCpt16+u
        KPB75h00iSFTzKqZas9eDRu/KGbR+oZro4qwo8Uk7fMU2E2o7/vy8jvEMQp+tgW4iwBwLW
        qmuXWM3gdAX8Mhh9E8OoCLpy3laBnVA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-_ljffqeaNbackdCX-SRr1Q-1; Thu, 07 Apr 2022 13:57:28 -0400
X-MC-Unique: _ljffqeaNbackdCX-SRr1Q-1
Received: by mail-pj1-f71.google.com with SMTP id m8-20020a17090aab0800b001cb1320ef6eso1561596pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+vrRrqMFJ6b+4wLQ7xCWgEu9n79uQKRvZqKAsaERm8=;
        b=DzSKkiiXftXl5hmsIQ/wzY+6qsbxXgBaAMiVsfoExi19Bkpt0l+r6qehKMgxpkOJTB
         lRACrBPMddjBdQpL5zALfe73kCv/659WrhbGjudojnrVVwiKtdvwVMt8MtFLQfnn8hAM
         I9RsR26kQLLB6oQOQzJ1lDQ5ftv6sOE3n4QSrJrd5JAP84bJtXqb1Bb+qwOzwYBH8qaa
         kjDnrsxW+HKf5YkWXGqAV0YeSNp8HUTIngj1byRZL/uGc+klopAES5Eswf+NOiPRL6TY
         c3fhucG9gdyWPA5ljyn8A+Ym/LRXOU+V9w4vhyYHTsAlFT1Zu64uzibpARomgAYj5O2X
         fN7g==
X-Gm-Message-State: AOAM530XtyoRANh6EgNLumo0xcGzrjHurp2XHvAi5wXZOXcAQapotV+l
        4NccpOZW8RvDxWH2UNR3nBlGWjuKDYixJak6sxt48VtfeMB7+pOk1ZB5uReqr1cYQCHveNAgSnV
        trpyrgC6lOGmjtQk2ahmOFF50
X-Received: by 2002:a17:902:b696:b0:156:b63:6bed with SMTP id c22-20020a170902b69600b001560b636bedmr15170877pls.24.1649354246891;
        Thu, 07 Apr 2022 10:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNzTcYdHFGPl0COruEjo6CBToCwrgo4PXx1tooB7gWfGh27A2vqET7wjpjd/MxtAvdfg/cYw==
X-Received: by 2002:a17:902:b696:b0:156:b63:6bed with SMTP id c22-20020a170902b69600b001560b636bedmr15170865pls.24.1649354246675;
        Thu, 07 Apr 2022 10:57:26 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id gb5-20020a17090b060500b001c6d46f7e75sm10013363pjb.30.2022.04.07.10.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:57:26 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: add self as clang reviewer
Date:   Thu,  7 Apr 2022 13:57:15 -0400
Message-Id: <20220407175715.3378998-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been helping with build breaks and
other clang things and would like to help
with the reviews.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ebfc93d8f0d..8da670067a34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4797,6 +4797,7 @@ F:	.clang-format
 CLANG/LLVM BUILD SUPPORT
 M:	Nathan Chancellor <nathan@kernel.org>
 M:	Nick Desaulniers <ndesaulniers@google.com>
+R:	Tom Rix <trix@redhat.com>
 L:	llvm@lists.linux.dev
 S:	Supported
 W:	https://clangbuiltlinux.github.io/
-- 
2.27.0

