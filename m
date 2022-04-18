Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128AD505CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbiDRQzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346503AbiDRQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CA863388A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBebpsVkjJ1lSSa3e/sJjGT51LMTkXLQURCTyHp5Tag=;
        b=YxhW9qowef3VrOsmhhk/TUtI36X0oxQWmFoIAakfz1J2/dsIe/ZsAkeBoSj1DVJM3g6kYh
        V309yypF0zZueXVLoZQrr/mLi0dpbbiNTTJPRBY8NXcFx0Fxsdroip5usEAwuTqGWD5Tux
        mOVduBEc0kSJBJEiWowpnYWlfBO1AZ0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-j7K3T6i4MMOS4KqbY4YEqQ-1; Mon, 18 Apr 2022 12:51:12 -0400
X-MC-Unique: j7K3T6i4MMOS4KqbY4YEqQ-1
Received: by mail-qt1-f200.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso8837700qtm.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBebpsVkjJ1lSSa3e/sJjGT51LMTkXLQURCTyHp5Tag=;
        b=nxI1vAny+DGZvz1FidcaZ/vMy6xUMVlWw8V0RBDQRg0wVjkvgRamnMKyTz7IYl05xM
         /d3c698WuNNOOJPtjr9K0+mnFas7MA30f0KcP6axWyvonxMIVmdhpZvZb8DQW6t6CAxK
         DmAZXFnkbOMXE4Gi2JUupW8wOVzEY68S+0p2EL6mDFKGzEPPAspWJGJPsvpvGxnTIEk+
         JSoYo7whc1+bB7Zm1XlmBdjl5s8goJIFdmfHHp+RCBnoWKf91m5uBRXaQrgCc650pcKQ
         K6bUfpBEdghasBYD/qhH2BqWRtCbKOT2Hlu0GyME9sURaXael7eRbL0rP7/WjC3qjZgV
         E6kg==
X-Gm-Message-State: AOAM531cjEiMPkoTwsyzxkDEZ24Uka8o9hHLjRTW1iDs2tbYR+zLT09X
        w2HlilKV1Nj4iHq3fxrHWO1njsmFqBuUsQskhUeLtYdRhcfRcZe6a87qlGX7QdleNAFhLDwRfCr
        DsB8Rufu/vrLerA/Mhr5/kjhG
X-Received: by 2002:a05:6214:1cc4:b0:431:4cbc:1d91 with SMTP id g4-20020a0562141cc400b004314cbc1d91mr8819870qvd.64.1650300672338;
        Mon, 18 Apr 2022 09:51:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdHQjzckS1sAzf8DfFbGiChE/dpSmAb18xOXxE4bOzMjLBlU1ffPU/tvpAO7aja87iutMc5g==
X-Received: by 2002:a05:6214:1cc4:b0:431:4cbc:1d91 with SMTP id g4-20020a0562141cc400b004314cbc1d91mr8819852qvd.64.1650300672090;
        Mon, 18 Apr 2022 09:51:12 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:11 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 13/25] scripts: Create objdump-func helper script
Date:   Mon, 18 Apr 2022 09:50:32 -0700
Message-Id: <ab37c23d28a8b9cf7a6707cc5af5e1aef80ba4a3.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
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
 scripts/objdump-func | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 scripts/objdump-func

diff --git a/scripts/objdump-func b/scripts/objdump-func
new file mode 100755
index 000000000000..140646c456fc
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
+command -v awk >/dev/null 2>&1 || die "awk isn't installed"
+
+OBJ=$1; shift
+FUNC=$1; shift
+
+${OBJDUMP} -wdr $@ $OBJ | awk "/^\$/ { P=0; } /$FUNC[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"
-- 
2.34.1

