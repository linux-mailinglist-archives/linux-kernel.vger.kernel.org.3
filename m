Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2409B518F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbiECU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbiECU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:58:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFA43B29F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:55:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j70so4010038pge.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdPS+6ovNgbIR6W/BvJieSFy4bz2cMdTMxnCOUR1BJQ=;
        b=bHU4VjAzp8C1M1XvHG68mTOvyMkOTXD8Q8IxxwTh/pA96lQ08ploXyPVuewqneNz7I
         BTQ66bsHXECQh9Ps4JwaMRw3GdAoyRlyvhHlbP2L7nt77gqS2adyofBziaB45Vm2D4Ez
         x0zbBoaGMSU5UEzo8IM1GgUfpoiiajG6cYGco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdPS+6ovNgbIR6W/BvJieSFy4bz2cMdTMxnCOUR1BJQ=;
        b=2Oimo/6Hxia98Q1wOc9IuJSfAWda2JIvnU9V298T5AFWnKVGP//UXNsUYRRzpVxt6Q
         /UqoUEh1uNar3CGfjTUer5QTcbE7iYROQWhLzDpqIVeGj74RdcuNO0NhnAqYqEG0CWdX
         XLEnUDT1aeI4UAtQY1cADoD7IAYcFbFqZxfZwf6aX6Tawb62p3wwhBck1/oDWfMeJP5y
         kdo8xZ6qQpfw1Aircez0eXTJ56WeDaidXajNO/Kzz/GSVyDohDLL+YPctQeUnUZo8iT6
         9dUAqRnht8s/nYouMW9TavJwVDsqoS/fZ3ep8THm5OiSYI33shCdWIMYBRXtGa/vUE2E
         FLSw==
X-Gm-Message-State: AOAM530REbSknyj+HU2AZZUFCTXa8AzVEQ8dt7XiKBuQR2EbfPfJpJJ8
        MMurkpInORj8HijzxawoyxfVBw==
X-Google-Smtp-Source: ABdhPJy3MRDXrmUhZUJX+fO+Iudo78mE4XAjOuV5u2/RFaENGy2ohzpd4UwzaRV08TDRJgxybO+Kig==
X-Received: by 2002:a05:6a00:124f:b0:50d:efb8:6afa with SMTP id u15-20020a056a00124f00b0050defb86afamr10587579pfi.14.1651611309415;
        Tue, 03 May 2022 13:55:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20-20020a630a54000000b003c219c0871asm3933040pgk.74.2022.05.03.13.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/6] netfs: Eliminate Clang randstruct warning
Date:   Tue,  3 May 2022 13:54:58 -0700
Message-Id: <20220503205503.3054173-2-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503205503.3054173-1-keescook@chromium.org>
References: <20220503205503.3054173-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; h=from:subject; bh=bEl5c+oL0DHs9c0JKOjQVQhGUtntych2+mEKBNpt6+0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicZaljMui7HM5C2nUhMVbY5QZL7cXs2WS/tnBqO2w QmtevbyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnGWpQAKCRCJcvTf3G3AJj7nD/ 9EN/kMgbEYlp++FHvHW8ma1iM+kP7FMs+DalBiKQfkIeScig0IVM5Q3dbvmXF1a26tX7uVVdilImNn hZvggBQj2ca6FXKUR60ZWvagiS3PrqNy/RdFhO4F29yx6c6gWrFJmsx2c25jJ1sJXp5sx6onOD64Dc eLXJPFVDQrMssMfu9+SQCRfcf3SDsKHcV5PRjOp5aiWqKI9yR6dWUheY3Sa4bsBYn645OAdQI93Z5k kmYosamsbYqGm9Xa2wWXalmB3W9x5Licr6O86aeeCfhuL8q12lrebTGwLo2PwpigLCbIgHrxSqJXIn stPRkOoWqNufv4kkQbewUAitGsMC6vT/2o7MylXDzRnKJujUZQY5wRBekBslXliKHtkxBb6ZGF8RQU fmbUaDHA9aKUMgMVHjzacxPBbJPV7oycgCPiRwbOBOmJNg3sYJQ0Y306ki6v+dOHLcj7wedfcPM0OU uolaHrzpi63qdj96tcn1R6hMdI166zDodVrQQ+NERYFJkdvfL7eSA+a6nfJ1GhI8W7R6HKS7CcJ+Xg Jj+pEWxNzyJ2Ee+WfxBM1qdcLOfVN64qrjDWaK0A6LKoH+NVZUbT5pYEv2eoow+Rll6b+uSLhDaqWX uVOm6X9q1dBcMoZx5a3JgZpzg9B8yHotQF8ovOWc5X15GHixJg4Er4sXOCkg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang's structure layout randomization feature gets upset when it sees
struct inode (which is randomized) cast to struct netfs_i_context. This
is due to seeing the inode pointer as being treated as an array of inodes,
rather than "something else, following struct inode".

Since netfs can't use container_of() (since it doesn't know what the
true containing struct is), it uses this direct offset instead. Adjust
the code to better reflect what is happening: an arbitrary pointer is
being adjusted and cast to something else: use a "void *" for the math.
The resulting binary output is the same, but Clang no longer sees an
unexpected cross-structure cast:

In file included from ../fs/nfs/inode.c:50:
In file included from ../fs/nfs/fscache.h:15:
In file included from ../include/linux/fscache.h:18:
../include/linux/netfs.h:298:9: error: casting from randomized structure pointer type 'struct inode *' to 'struct netfs_i_context *'
        return (struct netfs_i_context *)(inode + 1);
               ^
1 error generated.

Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/netfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c7bf1eaf51d5..0c33b715cbfd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -295,7 +295,7 @@ extern void netfs_stats_show(struct seq_file *);
  */
 static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
 {
-	return (struct netfs_i_context *)(inode + 1);
+	return (void *)inode + sizeof(*inode);
 }
 
 /**
@@ -307,7 +307,7 @@ static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
  */
 static inline struct inode *netfs_inode(struct netfs_i_context *ctx)
 {
-	return ((struct inode *)ctx) - 1;
+	return (void *)ctx - sizeof(struct inode);
 }
 
 /**
-- 
2.32.0

