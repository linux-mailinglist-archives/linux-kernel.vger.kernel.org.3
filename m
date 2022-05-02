Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103FA5177D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387231AbiEBUSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387197AbiEBUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEDC6B1CC
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651522474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TXBiyFFfeV5K0Iu4xhticdWJMir3Zvug0a8bAMPv/AQ=;
        b=AQx/nDlkJJwHvSxTe/fOFnDu19J0YOToxareD6Up8dIzO7YoJa+xqKuIscyN0GMMgXbLdb
        FFnsff66Cd+bNOwzyZ3Kn0a4hjGvbuvPRodQn/tDHPXYdJkOtnVv8/uUleqem0i1OJs9AD
        NErNkv4rG7HaOFGbxLNWFPmedAXs0bQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-ckAl0X3mOJiZpv_uSsS2bA-1; Mon, 02 May 2022 16:14:32 -0400
X-MC-Unique: ckAl0X3mOJiZpv_uSsS2bA-1
Received: by mail-qt1-f200.google.com with SMTP id h5-20020a05622a170500b002f3a699b92eso2612546qtk.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXBiyFFfeV5K0Iu4xhticdWJMir3Zvug0a8bAMPv/AQ=;
        b=xHs1dZk3n7IEfszbngITqyG1izVmh2r+0NsjOvo3vmYAPsjxTcQz0KRAv2HRtfiR2x
         xGvo+Srs7S7ls7MscExC4usufgW67SYhdgOb+6Lrs8jbMXSEwiZO0GGTL/grt0RfvHzE
         Ge6ZwhIVT1YrS3Yaje5OCPPEJY0jIp8UU/yqRQ5Etom96LP6eLYtsBggJw8CeLi6S5PJ
         ZCrFC4XUszJo9rsI1A+uEWBqoYbbocjoMDlukQcIF98NCtme0wQnYHFjMcy18WIYNVSx
         SaWpWicdnpQaCWWwGYj+NN6RZj+GKGfEHn9Tq+20CPJfAREDNR7hCGGk3OzCYuioB2iD
         7d9A==
X-Gm-Message-State: AOAM533fydbaBzG4fkIblQeZ4h4Phs7mJYjg46FnNr5NyOz0Dw3SyJVj
        twZlQS2pQrocaYmnr22RMPGJr0huTPLTzQFcmmMzSBGtNvRHlwo0CjigX8P98tTARhdizhSK/Gm
        RS4XdlkSYjIY24yXB+na8sifQ
X-Received: by 2002:a0c:a68a:0:b0:443:d22b:cdff with SMTP id t10-20020a0ca68a000000b00443d22bcdffmr10842115qva.47.1651522472232;
        Mon, 02 May 2022 13:14:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyJ/DQdLkdGUymqj94HCfa11e9TDxXNc8zaXNmZl4ha1goljDWNMooVE7Sb85Iyh5dmDiEjA==
X-Received: by 2002:a0c:a68a:0:b0:443:d22b:cdff with SMTP id t10-20020a0ca68a000000b00443d22bcdffmr10842104qva.47.1651522471950;
        Mon, 02 May 2022 13:14:31 -0700 (PDT)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id c27-20020a05620a11bb00b0069fcabfdaebsm3728794qkk.70.2022.05.02.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:14:31 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/faddr2line: s/vmlinux.o/vmlinux
Date:   Mon,  2 May 2022 13:14:17 -0700
Message-Id: <8ace793079a37aefae6838f4c1de6568f8b52ab5.1651522415.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Peter Zijlstra's use case of running faddr2line on vmlinux.o.  This
avoids (for now) the task of having to make this script a lot smarter.

Fixes the following issue:

  $ ./scripts/faddr2line vmlinux.o enter_from_user_mode+0x24
  bad symbol size: base: 0x0000000000005fe0 end: 0x0000000000005fe0

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v2: do rename before checking file existence

 scripts/faddr2line | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 2a130134f1e6..a43cbaa02ce3 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -199,6 +199,19 @@ objfile=$1
 LIST=0
 [[ "$objfile" == "--list" ]] && LIST=1 && shift && objfile=$1
 
+# HACK: s/vmlinux.o/vmlinux
+#
+# peterz likes to run this script on vmlinux.o, which is more likely to run up
+# against the inherent limitations of this script being based on 'nm', which
+# lumps the symbol offsets of all text sections together.  If the offset is
+# valid for multiple text sections, faddr2line will get confused.
+#
+# This issue doesn't *only* affect vmlinux.o, but vmlinux.o is most likely to
+# see it compared to other .o files.  Someday, if necessary, we may need to
+# instead turn this script into a much smarter one which relies on a real tool
+# like readelf which can differentiate between text sections.
+objfile=${objfile/vmlinux.o/vmlinux}
+
 [[ ! -f $objfile ]] && die "can't find objfile $objfile"
 shift
 
-- 
2.34.1

