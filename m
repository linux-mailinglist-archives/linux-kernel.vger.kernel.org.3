Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0768355017B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383795AbiFRAzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiFRAzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:55:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5281D69B62
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:55:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 78-20020a630051000000b003fe25580679so2942776pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7noSD7v4IsdBpDU6I2ayy4OwDu+mtZnWU906kUPqoWs=;
        b=VUF59ytcj/1/vSlndOI+3rCIb7D928N/4AYitpuXKLOeABUVsrSNYP5CAO/yeiutRO
         doN0ebQQaNUpTaJdO8SPWodDkbJv99OXkxYrJxizwG9Id8xfNZXwWsPQxuB6CNWGTvIl
         4cHuZb0p3WQHfG09ykUPlS6ceMYwPJ6Eoz0ePrO90TTxzHFkaMKMg7mfOO5XWvcc8Jbc
         VCkp0DjD1BgY0LzkLkk1wE+C0UHcDpnedlyAAxV5gsbKNiayvDtL6pqX7rFf2pnqfVm1
         Z7KkvriAdwdrY6/4pwjt/bMBd0DbZWlj5aCshNrVpw5z7+BmPv1WbAHhXT7JvH2CmOOg
         JzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7noSD7v4IsdBpDU6I2ayy4OwDu+mtZnWU906kUPqoWs=;
        b=L+gRDwmDnz+AQyfx5p4Z7I6FeqEIZ3rVpFX+T5vxFsW03pz/I3USP3PGsZ27s3kguq
         yfaIxObBEWArE6erQyWCUP9eBLod+5s62nGSmcsmumDLgNAfzDCtO8G/H5D13KURWGOT
         uhxqCUThxFthckaZzQMf5VV6+t5sxJGqKt3iDtLteURpy3NCmd1Mn1MVWZMWz4CI/TYc
         feRluzEcx/ZaqY99A9TDykpPJM8K+XnjA+n2k/vlU/9q8D6o0jtDQ/0H0sRsERI4cPXR
         zIwpem7+38DEJ1nBm6iZi6fTAajmUuBi6eCfVI9gkMdNmC28Tbx2QFQOQiRGaoEO4Cuq
         eMkQ==
X-Gm-Message-State: AJIora9YjGvA5UF5ADrEQPIB+GPgIKq7OL1u9LDQVukZ2ymisRjJArwP
        0jcLIBn9iGLaU7Rur9jVAQ5lId3SHwaB
X-Google-Smtp-Source: AGRyM1sMQPuYzOm/xwCgTfFCkCOOM/eyuL5W6bnvN5ZWPPiC6JgLo2qsCAd9Tv9peuasP04spIidlAjRS4L5
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr703653pje.0.1655513704455; Fri, 17 Jun
 2022 17:55:04 -0700 (PDT)
Date:   Fri, 17 Jun 2022 17:54:57 -0700
Message-Id: <20220618005457.2379324-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH] scripts/tags.sh: Include tools directory in tags generation
From:   Vipin Sharma <vipinsh@google.com>
To:     gregkh@linuxfoundation.org, rkovhaev@gmail.com
Cc:     dmatlack@google.com, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tools directory in generating tags and quiet the "No such file or
directory" warnings.

It reverts the changes introduced in commit 162343a876f1
("scripts/tags.sh: exclude tools directory from tags generation") while
maintainig the original intent of the patch to get rid of the warnings.
This allows the root level cscope files to include tools source code
besides kernel and a single place to browse the code for both.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---

I have found myself many times to browse tools and other part of the
kernel code together. Excluding tools from the root level cscope makes
it difficult to efficiently move between files and find user api
definitions.

Root cause of these warning is due to generated .cmd files which use
relative paths in some files, I am not sure how to make them absolute
file paths which can satisfy realpath warnings. Also, not sure if those
warnings are helpful and should be kept. Passing "-q" to realpath seems
easier solution. Please, let me know if there is a better alternative.

Thanks

 scripts/tags.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 01fab3d4f90b5..e137cf15aae9d 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -25,13 +25,6 @@ else
 	tree=${srctree}/
 fi
 
-# ignore userspace tools
-if [ -n "$COMPILED_SOURCE" ]; then
-	ignore="$ignore ( -path ./tools ) -prune -o"
-else
-	ignore="$ignore ( -path ${tree}tools ) -prune -o"
-fi
-
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
 	ALLSOURCE_ARCHS=${SRCARCH}
@@ -100,7 +93,7 @@ all_compiled_sources()
 		find $ignore -name "*.cmd" -exec \
 			grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
 		awk '!a[$0]++'
-	} | xargs realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
+	} | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
 	sort -u
 }
 
-- 
2.37.0.rc0.104.g0611611a94-goog

