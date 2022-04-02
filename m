Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69624EFEB4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 06:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiDBElr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 00:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiDBElp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 00:41:45 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D6691AC5;
        Fri,  1 Apr 2022 21:39:55 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p25so3649537qkj.10;
        Fri, 01 Apr 2022 21:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCKP32vula9w3akN0CgQn1wv1m6mI2NCAYew8yna2+A=;
        b=MZM44T2r8GY6VZfMI7e1jA0uzXdZ8rRb8JpboGeTuvoffDKJSb3G3caji4/TD0iKkN
         hXUh9SOaZnhryXzmdltO1aS2mjPortVm7nq4harb1nW5m6UXQ/rXnudTyeGaoFjOyW1x
         /kcgQQu6M/8Q6D3cbs/StOJ2MRuQCtlkj3W33ayIeQLA5mU1H55/LA/Ndih5YkAFzQT6
         OR0dvDctnU7Y4y75kGhouFwb1SXL91xF9jXBZElTeIxJoi+Hz74TXjewnZgC4d2Wcx/M
         Wf9Lr7JgpS0GsuSAUAYZJz7FUjms8wbCl6xWXM6/kjiXdikgbX9B1/DZrAem/Bc8Aewf
         bbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZCKP32vula9w3akN0CgQn1wv1m6mI2NCAYew8yna2+A=;
        b=WfheBACkP+WGsIN7BMsEbJRfy6FGtOixi4sllHnMr6T+39ENF1+b9ggWmEDLNtVvlt
         2OB/bKW3HjExOCzdSRcpqlEIi5hRlzDRMzXbHqQ4UIUlxWgQXvG65hpQFfrmoHWWdLbV
         GNPPFTdO6PAm30TfySPjTYeMSVkSgcPs9H3P3N07tdx1kf+N1aB+VSCIzdKh1TAOluNB
         SS8Ig/Hb2OfHqP1O5fd+xxoG7kKw671foM1bctRrw3L5dzCAyalMETRjIVji41rnVUnB
         K36ah7oSQ/V50906cWln/QGvB4izJeA4aBnb8/mp0t7Fdq/IBZB/QP15WiTERpgrs77K
         avbg==
X-Gm-Message-State: AOAM532dnAv0tBtKTh/PMseN/krzJITtAp6FHp5D8b/rOp2Rxl3wWQkD
        GxQlbZnP5KHtGM2dCbclv3t86XBD6iI=
X-Google-Smtp-Source: ABdhPJy0ncxq7pro34tBQvYd2nBebkRRDY2ZVNDwH00/Zli1Z4Z9nablrPNAOB0PUPdV4H/rdffghA==
X-Received: by 2002:a05:620a:c08:b0:67d:3b4e:229f with SMTP id l8-20020a05620a0c0800b0067d3b4e229fmr8639178qki.550.1648874394236;
        Fri, 01 Apr 2022 21:39:54 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id e15-20020a05622a110f00b002e1ed105652sm2996957qty.2.2022.04.01.21.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 21:39:53 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveria <bristot@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rtla: Don't overwrite existing directory mode
Date:   Sat,  2 Apr 2022 00:39:38 -0400
Message-Id: <20220402043939.6962-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode on /usr/bin is often 555 these days,
but make install on rtla overwrites this with 755

Fix this by preserving the current directory if it exists.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 11fb417abb42..5a3226e436ef 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -23,6 +23,7 @@ $(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
 $(call allow-override,LDCONFIG,ldconfig)
 
 INSTALL	=	install
+MKDIR	=	mkdir
 FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection
 WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
@@ -68,7 +69,7 @@ static: $(OBJ)
 
 .PHONY: install
 install: doc_install
-	$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
+	$(MKDIR) -p $(DESTDIR)$(BINDIR)
 	$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
 	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || rm $(DESTDIR)$(BINDIR)/osnoise
-- 
2.31.1

