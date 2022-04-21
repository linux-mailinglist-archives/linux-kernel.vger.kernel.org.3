Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE450AB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442265AbiDUWAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442261AbiDUV75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B0AC4EDD0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650578222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b3F6IsWh0LkQJX9Kt+TRrqzc1cDTYsznRdWe3zbjtGE=;
        b=aqFL0Z9eGMpV+UWmzeCYFqL5ndWp/OHSK/tYJRSEqlieuiyw/cm1hzHu8x4GsT/u+lBNsO
        yhgtM7jQ8lMOBpCNOGcj0g1Gded2EtsDeaxb4SDt3wc+U6eNFep3Nczb5+Nh2TwsAU05C5
        Kl8iEzV5El5e32k1jGdpx29F5tCEmY8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-4v1NVh_UNNCJoT6fJ7Xwlw-1; Thu, 21 Apr 2022 17:57:01 -0400
X-MC-Unique: 4v1NVh_UNNCJoT6fJ7Xwlw-1
Received: by mail-qt1-f199.google.com with SMTP id r16-20020ac87950000000b002f34f162c75so1556794qtt.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3F6IsWh0LkQJX9Kt+TRrqzc1cDTYsznRdWe3zbjtGE=;
        b=0WJ4rrJ+A2Gh53VDZU0yYLVvojkNHCPkrgWyZj4qVF9K0h05KlNHpZ6NPJFni06xru
         WA0zE1ZvUc1bBLcrTIzZ1JlDE/wn+GzYpaRXvrbxc9tDqiTzUoPP+VH2nnDnVA23EDsj
         GcLRnr5HEwFqdIa1NAV3JR35nLdYdaabC5fmS9ABpzw96TI77bAfFYrnT7Q1YU1jWAGX
         IFKTCVtO5BP8VrRwDbknAyL+KIWraB43dZ0cmf3IXydUuPn6Lh10O89544dAA6Eqv4Ag
         U4/ye6281ZQJdTGmKoMk3xZX1aGH0chgalXP4x6wIcZy+5iJ6he350CvlzvuEMfsIXCO
         07YQ==
X-Gm-Message-State: AOAM531e34c1ZbJGHL864ltN1XzyTKEpfnJ8VsAwX94FkMRtJ/2JmOar
        I2PnTQSbtUZo5A/w/8f10NlRnwJoFEi6luOOsUfiEpv8RnGcE9VQa4dLLKHg9sDJRKh9uDXwR+1
        13SpQYBDWgZ6sGT6Pexbd0g8F
X-Received: by 2002:a05:622a:13c8:b0:2f3:5421:d64d with SMTP id p8-20020a05622a13c800b002f35421d64dmr1144665qtk.43.1650578220713;
        Thu, 21 Apr 2022 14:57:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlqT6p8GJTvYLpNgdKfIrwJjw7y9Ih1JMFX4NW2WPy+npSK3dXf57J6Qf9LAd37098YRhwhg==
X-Received: by 2002:a05:622a:13c8:b0:2f3:5421:d64d with SMTP id p8-20020a05622a13c800b002f35421d64dmr1144655qtk.43.1650578220469;
        Thu, 21 Apr 2022 14:57:00 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id w82-20020a376255000000b0069ee3f0ae63sm71493qkb.45.2022.04.21.14.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:57:00 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>
Subject: [PATCH v4] scripts: Create objdump-func helper script
Date:   Thu, 21 Apr 2022 14:56:55 -0700
Message-Id: <3eb3f091fd6bd9caba50392ceab98ce756804f3b.1650578171.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple script which disassembles a single function from an object
file.  Comes in handy for objtool warnings and kernel stack traces.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v4:
- allow extra args to be provided at the end
- match ".cold", etc

 scripts/objdump-func | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 scripts/objdump-func

diff --git a/scripts/objdump-func b/scripts/objdump-func
new file mode 100755
index 000000000000..4eb463dd9f52
--- /dev/null
+++ b/scripts/objdump-func
@@ -0,0 +1,29 @@
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
+[[ $# -lt 2 ]] && usage
+
+OBJ=$1; shift
+FUNC=$1; shift
+
+# Secret feature to allow adding extra objdump args at the end
+EXTRA_ARGS=$@
+
+# Note this also matches compiler-added suffixes like ".cold", etc
+${OBJDUMP} -wdr $EXTRA_ARGS $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f "(\\..*)?>:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'
-- 
2.34.1

