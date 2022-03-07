Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D04D0B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbiCGWds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiCGWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4CE93585D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646692367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rdVu7gaqINPujMlHtzx8XjmC1lzYrE3ToDYQaDek84E=;
        b=DAvG1zyeyxK1E9KTQJAzv4hFVj04w8oINp/BeonPCqrjC07fJg0FkyZyL93LyAZuYuE1GV
        A5esKRewjaZD8x5dzcQtqczEA82ax52k7+0bVJfMA7WGmhzwH3lEUnhL+ocp8dcc1+UGpE
        HO3LKjcW2Pm/rHLZWVI+sC9E1pZMtPA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-JdxxEpjrPy-jfF8UyXVQVw-1; Mon, 07 Mar 2022 17:32:46 -0500
X-MC-Unique: JdxxEpjrPy-jfF8UyXVQVw-1
Received: by mail-ed1-f69.google.com with SMTP id l14-20020a056402344e00b0041593c729adso9465935edc.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 14:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rdVu7gaqINPujMlHtzx8XjmC1lzYrE3ToDYQaDek84E=;
        b=Rej75JGtTbpdIl1mVwxTSWaaCWOrGJufCmEV1LzdgLjP2TZNJBE+CbaKkh45Am/3Eb
         eGA3JLmgfYDw/ivFQTJQ98/N2r9UlGJgKBWKvupqgJ8EfkjDh63BCwxkDIdoT/UM+k0Z
         SOlTzlYQN6hG61bhyEBCJJHs1DPDh1Aqmsnw7TkVIt3nG+NQVHIrxSIRUOeNCXw7Mu64
         YbzHRq3z8hxsJD1RzxDUXU5FuHRMmjWbBe3UzclyyNCTIF5Wl9956P7fE+Jihc0RaK5f
         5dW9Dv8SLOKETAV+Hb3PS1QrfLOryA7GHaUMwNqG+Ds2K+vZ4GJXEx7oXvA03dhKz4Rl
         B3NA==
X-Gm-Message-State: AOAM531oIDcpRXLH+zrWhBt2JyQZXXHhiGZ1OQi7UcFP333VfJMAsEXM
        cRKDJmT9QzsSXwnB1HB+9y2N3Coom/RdshdiOW5rTs910qJe5VE2LA18MjoIfbVOjKx5b9c0KO/
        eI1hFAQlfohx30UFLekxBGqxGm7f8UstwYYPeQTBVNR66enUMrMeUN+ZRNtIhdnilHyKZZw==
X-Received: by 2002:a17:907:c0c:b0:6d1:8c46:6415 with SMTP id ga12-20020a1709070c0c00b006d18c466415mr10935125ejc.326.1646692364967;
        Mon, 07 Mar 2022 14:32:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxl2qIf+M2py+3MvT2/IBR4c5STLaZRG5tcCXwEd7UYY/YN4KbNF+9+PE1/LHmKYhMmtgn9nw==
X-Received: by 2002:a17:907:c0c:b0:6d1:8c46:6415 with SMTP id ga12-20020a1709070c0c00b006d18c466415mr10935105ejc.326.1646692364745;
        Mon, 07 Mar 2022 14:32:44 -0800 (PST)
Received: from redhat.com ([2.55.138.228])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm5514127edb.47.2022.03.07.14.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:32:44 -0800 (PST)
Date:   Mon, 7 Mar 2022 17:32:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] Makefile: fix config cc version check
Message-ID: <20220307223231.608498-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.config is of the form:
CONFIG_CC_VERSION_TEXT="gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9)"

while CC_VERSION_TEXT is of the form: gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-7)

thus when comparing these, CONFIG_CC_VERSION_TEXT should not
be put in "", otherwise we get () outside "" which shell then
tries to evaluate.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index daeb5c88b50b..d5c03c827825 100644
--- a/Makefile
+++ b/Makefile
@@ -1714,9 +1714,9 @@ PHONY += prepare
 # now expand this into a simple variable to reduce the cost of shell evaluations
 prepare: CC_VERSION_TEXT := $(CC_VERSION_TEXT)
 prepare:
-	@if [ "$(CC_VERSION_TEXT)" != "$(CONFIG_CC_VERSION_TEXT)" ]; then \
+	@if [ "$(CC_VERSION_TEXT)" != $(CONFIG_CC_VERSION_TEXT) ]; then \
 		echo >&2 "warning: the compiler differs from the one used to build the kernel"; \
-		echo >&2 "  The kernel was built by: $(CONFIG_CC_VERSION_TEXT)"; \
+		echo >&2 "  The kernel was built by: "$(CONFIG_CC_VERSION_TEXT)";" \
 		echo >&2 "  You are using:           $(CC_VERSION_TEXT)"; \
 	fi
 
-- 
MST

