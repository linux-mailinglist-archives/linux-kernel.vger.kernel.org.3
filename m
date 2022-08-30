Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8705A5885
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 02:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiH3AqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 20:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH3AqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 20:46:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FA7EFC1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 17:46:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r69so9238869pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vu7WwGg8hHjHQMxVBeejwIO9X7hwzWU+rYfumkNTH28=;
        b=b6S3/gCKo9NnWhn25HJlEhO8WEl7M4A1s/ssomIGAzJE1FH4gXEurRRpcCR9M6R3Se
         gcZNRDdvw/CyXRDSoZE8QCSDE3T2kQkYNrDeQnXJw4CgKfMwaTsJqzQ2oVOVNrZsD61p
         dNilZgZ0MKd5EZdlmfh9+HiVlYYhnlFyJPFSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vu7WwGg8hHjHQMxVBeejwIO9X7hwzWU+rYfumkNTH28=;
        b=FNUdzouJ9N5MyPh6tjnLOFTY03LpIIxIrUVYjgX6SHagC7Dt0DUT5kw+I5+2zgSWEm
         Vir8HvLut+RlJLKbXudG7m2GaQ/JKDNQYifmbsYWR4oG/0tp2znPypAUFBgbpkJE5CYX
         4I+3aMLIkIrkO0dD0NKDc/9CXS993DcIhL/qEseKD0XyYNuTv7rUgT8Hmrnu0trh4cZc
         QQ+SwDhMMbDFlyGJy1lwbSYx9A2Wr4bKHspy77Z/o93CuHgaw0r6VxCiv0+iYBoEWkzT
         NdcQtrmejvBudMNz2TK8tpKt7iAMu+Ox+JDJvo+cvpEC8Xn44S3kxZnIkc2+b6EYVR59
         4nrg==
X-Gm-Message-State: ACgBeo0ny0V0DUeLaOOLb63kZBZciLwsBzKlLJjVzSnys1MqT3qy4cWp
        PQ/yLjXdkJJ3mS9VRO0x8KB3zQ==
X-Google-Smtp-Source: AA6agR5uP241h5cUO36rE+CaGBwKIwp8ECEml29/w5Jc3feGDEcnJZOOebGr3TnXFvoWckC8FIXkmA==
X-Received: by 2002:a63:5b61:0:b0:41d:3227:37b8 with SMTP id l33-20020a635b61000000b0041d322737b8mr15863985pgm.265.1661820375015;
        Mon, 29 Aug 2022 17:46:15 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:49ac:6e1:90a2:a0e0])
        by smtp.gmail.com with UTF8SMTPSA id o18-20020a170903009200b00172ff99d0afsm2331495pld.140.2022.08.29.17.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 17:46:14 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Jae Hoon Kim <kimjae@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH] LoadPin: Fix Kconfig doc about format of file with verity digests
Date:   Mon, 29 Aug 2022 17:46:10 -0700
Message-Id: <20220829174557.1.I5d202d1344212a3800d9828f936df6511eb2d0d1@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The doc for CONFIG_SECURITY_LOADPIN_VERITY says that the file with verity
digests must contain a comma separated list of digests. That was the case
at some stage of the development, but was changed during the review
process to one digest per line. Update the Kconfig doc accordingly.

Reported-by: Jae Hoon Kim <kimjae@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 security/loadpin/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 70e7985b2561..994c1d9376e6 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -33,4 +33,4 @@ config SECURITY_LOADPIN_VERITY
 	  on the LoadPin securityfs entry 'dm-verity'. The ioctl
 	  expects a file descriptor of a file with verity digests as
 	  parameter. The file must be located on the pinned root and
-	  contain a comma separated list of digests.
+	  contain one digest per line.
-- 
2.37.2.672.g94769d06f0-goog

