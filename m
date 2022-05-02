Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4C5177C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387266AbiEBUMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387324AbiEBULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C256DFC0
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651522086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dyNqZVYhXKJlbY+/8+YtCApI8QKTUCGVr4RjpVxY1Yo=;
        b=KbowrsaqnT2TVaT0F7uCIZN1SGqyHbO4nyS+tdonlpRSo1etP7nI3troBxWFKvW6N4K7Ra
        mlgS2qsqEXjTnyykSh+mMLJ3gB7JZ86agJMQXmHljAukO5lstGMMFoNGi445bb6DpUDUvK
        9DbcHbtkcsNi4hRuNazQCuSQYIF4GHs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-n_ntuXgFNcCAv84Yw-4xng-1; Mon, 02 May 2022 16:08:05 -0400
X-MC-Unique: n_ntuXgFNcCAv84Yw-4xng-1
Received: by mail-qt1-f199.google.com with SMTP id x5-20020a05622a000500b002f37cb8b803so11794706qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyNqZVYhXKJlbY+/8+YtCApI8QKTUCGVr4RjpVxY1Yo=;
        b=DmazpjMNIKInAL+/R1egzmVeGWwlcoI2LyUWNf02Xo0hfH1o1rMvhSvBJu5GtALDNT
         cdakoNnvkMhQoXSalw9ELSMdeN2kn37//D2zKPxPLWPeblbjqr6Pmq3aQA+2jL9eF/2e
         IHK/hGNmoMIMokRegQUfQlh04g05vK+/c3RyquNZB2GeONULnKWImoGko62rRG+pCe1s
         DfbAgmQLWab7IKi4a3RQXqO7dxpK5r9I9aVffbQuTKG2uzTHBl9hMrKp9XFdv9MWUVou
         hNQusRJelglMSIURQx8zfi4ZMnPO7OtMkH3xsoeVV4j7n3OVWvtGPLusnm7/tPq1L0LT
         P4zQ==
X-Gm-Message-State: AOAM532N9mzRdbOxLCZsYpQpfxj+R6d7VtPQf1cQej/65Yak4TbX66SA
        16PtInK3GXJr6sIbG0JMtoBvFCvWq6fdI5tHEhd3iJ3KlFa787VrjQ3E4xAdLJEyQeqAOgkFzDm
        Bfufwf1K9F7BuVLFge0RB5oYc
X-Received: by 2002:a05:620a:269a:b0:680:a5c5:954e with SMTP id c26-20020a05620a269a00b00680a5c5954emr9796525qkp.468.1651522084253;
        Mon, 02 May 2022 13:08:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj8c+z80hss+ixIabk0oiKYyieBgDtrf7tWVNskNJUpr9rdFKwlQ3cEmdyhVtYlp9Ek0zClQ==
X-Received: by 2002:a05:620a:269a:b0:680:a5c5:954e with SMTP id c26-20020a05620a269a00b00680a5c5954emr9796509qkp.468.1651522083972;
        Mon, 02 May 2022 13:08:03 -0700 (PDT)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id b23-20020ac87557000000b002f39b99f6basm4571050qtr.84.2022.05.02.13.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:08:03 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/faddr2line: s/vmlinux.o/vmlinux
Date:   Mon,  2 May 2022 13:07:55 -0700
Message-Id: <8740f545113b132a412ad2a46f382c69e930dda1.1651522024.git.jpoimboe@redhat.com>
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
 scripts/faddr2line | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 2a130134f1e6..564774803b9f 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -202,6 +202,19 @@ LIST=0
 [[ ! -f $objfile ]] && die "can't find objfile $objfile"
 shift
 
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
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
 
-- 
2.34.1

