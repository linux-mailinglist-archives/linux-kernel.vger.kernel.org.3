Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA29508E49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380985AbiDTRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiDTRTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A78762AE03
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650475021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JRTQdz7k3QyXl1nguutC/5GuEnESB/6++gRUTGvX3dg=;
        b=a+SLJMSL3y8oiUwFTrnlecWblTAGBs0fgWKSdoRFxodqwAJL1WXxS6O7R8cfULt3p05I0C
        shXUEGB/rtZ+/0nSWZutcrMjpsyCx/0QeqbgogibiH7iCN+4YjyN7rvKKmL9D7uYqPZiIt
        7FgzIdkoRyeQroTDkxOxxZ5A0D4dCrs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-XShcPS7oO3KXqEEQgu9M8w-1; Wed, 20 Apr 2022 13:17:00 -0400
X-MC-Unique: XShcPS7oO3KXqEEQgu9M8w-1
Received: by mail-qv1-f71.google.com with SMTP id eo13-20020ad4594d000000b004466661ece9so2043029qvb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRTQdz7k3QyXl1nguutC/5GuEnESB/6++gRUTGvX3dg=;
        b=m8Yo720LiIlzbGIujc7IURo2djKCqcXkhqdz80XAjq4t0bhefgS2KYJr/mplrugNj5
         CrltQUSOS4ENwptE+R8FanyateICy1o5rBaXGaDHhUtdWXfj3YFiYVXg4Le3su1fcmnR
         1rby/QwlTgzNL3D16pNoQaS0YTZJOkQ/1W6tIufjRu/IbuAnRpBiKegPcMOOTfD7HIv0
         ycsk4uL6sOhHeuEJVuRb+SxglYMVzxOud38L8epf+tx+7ClDoNb3FICPrf8EvtG2Uk2H
         J3mjvTkKOulFl9V8hBpzywA7BxCszgPAYJeB4y7FHAytVoCiIe3C4BIz1yPCMKBKzqPe
         q4TQ==
X-Gm-Message-State: AOAM532d8lhrEaMzmszw4CQZueawaN7H+BloWV6R/rn9wo6zQ1kFAthL
        pTb+OLTjNhxP/zlSLx7LOaSBTmKCOrcV+zhzG7WBOOsdZdIXOj5brXbthjQjewP4KHYabRY1Sar
        Vy3wlHPVUpGcKeiYNvyqHM43q
X-Received: by 2002:a05:6214:20af:b0:446:787a:e748 with SMTP id 15-20020a05621420af00b00446787ae748mr6247886qvd.79.1650475019579;
        Wed, 20 Apr 2022 10:16:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhOb2zgeMG0T9KiPewT+EWwvGUOcYT3XD5i0EH16FGy+E8cOWTCAUE7r8/woeT/FOxsruxFQ==
X-Received: by 2002:a05:6214:20af:b0:446:787a:e748 with SMTP id 15-20020a05621420af00b00446787ae748mr6247865qvd.79.1650475019233;
        Wed, 20 Apr 2022 10:16:59 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id k66-20020a37ba45000000b0069c5adb2f2fsm1805751qkf.6.2022.04.20.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:16:58 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v3] scripts: Create objdump-func helper script
Date:   Wed, 20 Apr 2022 10:16:36 -0700
Message-Id: <4d3ab1f17230f0188698cfbc7ba08696fe1abfe9.1650474927.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
v3:
- Add usage
- Fix vmlinux

 scripts/objdump-func | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 scripts/objdump-func

diff --git a/scripts/objdump-func b/scripts/objdump-func
new file mode 100755
index 000000000000..0908f9f616c3
--- /dev/null
+++ b/scripts/objdump-func
@@ -0,0 +1,25 @@
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
+usage() {
+	echo "usage: objdump-func <file> <func>" >&2
+	exit 1
+}
+
+[[ $# -ne 2 ]] && usage
+
+OBJ=$1; shift
+FUNC=$1; shift
+
+${OBJDUMP} -wdr $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f ">:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'
-- 
2.34.1

