Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C15072BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354450AbiDSQP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354456AbiDSQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D759E3878F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650384791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WjFvNg3rU+G0+XnvRDwEILWt438/TIjgJEsWycqF+yE=;
        b=C4QD1QkRYr8ZnBxOWrjMZ5W2guGPm9UFGGVTsnwX1BXZMSxmI1oCBnD+YYfiLnh8mmK2AN
        7erGJ1mBBZfttIgcZyzCTV3Xn/aHAr+2vDZdMq6SUhIs8GEkgXK8LredsPF0iaILOvumot
        RYL/yAmbta0tPCse0yKAuKOWPLUGGEA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-NhBN_5ogMJi28N5UlJwNQw-1; Tue, 19 Apr 2022 12:13:09 -0400
X-MC-Unique: NhBN_5ogMJi28N5UlJwNQw-1
Received: by mail-qv1-f71.google.com with SMTP id u7-20020a0cb407000000b00446687f0b1bso3437849qve.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjFvNg3rU+G0+XnvRDwEILWt438/TIjgJEsWycqF+yE=;
        b=Se64coYN5/QFXw8SPf9/fs1QE63L7/nuQ4p5puIZuz5KR39NLfx3XutRTZGSFIcz6j
         Fi+IwlTs4JqxyjQOHY7dRReAMxT90nIVyh1puQZjfOmECrT5luwC29eBaxWETMnj2b5G
         puN0A/ndQbFS5R6TvZGG/GJdjyUgExlHqlQl8wfSwc9vhkCzgCF0i1fo2PQGBo9YigqN
         XtTROBWufqHtLiVjTAqW65BpEKStymqNCG+A5L+TajJbXpae1kC0TEPptwmDIRHjcbH1
         Gx2wX87gODAwPJ0ncbgj4IN7bqRqGfa8RtNHxJJ1Bc5myH/eQfGGOlvJfL+GjjRDqYXN
         XFYg==
X-Gm-Message-State: AOAM5325uPgWB45A+Y7eX4Joyz24BrpisnqV+YarrfFpwGcztDmGXyx6
        /O9m83kzxsrX7IBesUL+mYBKR42//cov33DdDR0QApXC9T8l+DnE+4zw6VCFf5sY++JNbJqAJI8
        VI/mlpS/OObIPY1FgBBHFoibr
X-Received: by 2002:a05:6214:27c8:b0:446:5172:7014 with SMTP id ge8-20020a05621427c800b0044651727014mr9432859qvb.97.1650384788501;
        Tue, 19 Apr 2022 09:13:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5iuDnPE4GEAao8pc4cNqkiaRwfU8qL6wCsLyTs+BYbxYR0duTZ9Ibt6KolZjDOW6vmto/+Q==
X-Received: by 2002:a05:6214:27c8:b0:446:5172:7014 with SMTP id ge8-20020a05621427c800b0044651727014mr9432837qvb.97.1650384788220;
        Tue, 19 Apr 2022 09:13:08 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a00cc00b002ebdd6ef303sm238633qtw.43.2022.04.19.09.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:13:07 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2] scripts: Create objdump-func helper script
Date:   Tue, 19 Apr 2022 09:12:23 -0700
Message-Id: <fe61d8835ba60ef20920d2d0e6493748c80e4d7e.1650384661.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple script which disassembles a single function from an object
file.  Comes in handy for objtool warnings and kernel stack traces.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v2:
- require gawk

 scripts/objdump-func | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 scripts/objdump-func

diff --git a/scripts/objdump-func b/scripts/objdump-func
new file mode 100755
index 000000000000..67229acfe3a6
--- /dev/null
+++ b/scripts/objdump-func
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Disassemble a single function.
+#
+# usage: objdump-func <file> <func>
+
+set -o errexit
+set -o nounset
+
+OBJDUMP="${CROSS_COMPILE:-}objdump"
+
+command -v gawk >/dev/null 2>&1 || die "gawk isn't installed"
+
+OBJ=$1; shift
+FUNC=$1; shift
+
+${OBJDUMP} -wdr $@ $OBJ | gawk "/^\$/ { P=0; } /$FUNC[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"
-- 
2.34.1

