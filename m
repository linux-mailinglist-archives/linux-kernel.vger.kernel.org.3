Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AC95A5566
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiH2UN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiH2UNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:13:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D150E99B61
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:09 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d6-20020a170902cec600b00174be1616c4so2749131plg.22
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=/VThv+tjo6zeyyM6s3mIRpPL525v6/rUnx75IOl8UcY=;
        b=HERL353EXOu8sHVQwfGHM75q3HiHjX73sJn0HMbUNrkYmj2F93JDA8WiNtmM1kG7fM
         XH1zc/fgd4uY0/kCMU8a6F9Dcg7gFXyA5B+un0mwF12lfEGtzkTvY+iziuNykVlAUymN
         28fx2UFAzzwK+3Gxj7aV4sjOuz54wMrf4HoG+5bxCqfh6PX+8NI771U6yaxKlC58YBgy
         0uqxZv48yPHXRn6M66g8s119yjOyR/7/TpH6FgpfuPxeGLUrJIz+z0nJcGvFnzQqGQ2c
         /EtW7tQJDXM4TnFlXXxWldBDXrH5RzQu6AO6DoXByezfWP8X/F6zWfkUQnpW/MrWZX1H
         L5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=/VThv+tjo6zeyyM6s3mIRpPL525v6/rUnx75IOl8UcY=;
        b=DrKoU+QxBNGiXX6OoMXoRQL2BoiGRG2xeEPPD61E4LKR6tyb043ul40PPepiH4+C+6
         APUUiMtnP5v11uw0SH3+tqLDGGKDSOtKSramlZRbIVvddaAU3A2APQfQo5MXkx1GMgg7
         nWHVk7+zQ/1S1jP+MmpKnzL8jO/KQvDraXUsRHCdNDZ/W4rBVgOY8GAEycocvkQGw7UV
         XmuBu8eyAEARPOjO0oB0dZYUCQ3JInkSHXy3crSQRy9y/6TMCCNd6xsgEj+Q1s+h1K+R
         nB0/2PvTPZfR+OJ7ZSQJnW7SDNLGArJ2xxSGHZHLBfOyaPZEjqDeqh5jnkeP5F2QbF+u
         QKQg==
X-Gm-Message-State: ACgBeo2X+K9ddnC8PHQVWn+xqW+iKGWna40UuEBQf4UBBjVcdu5NDda9
        zVKtmgYpol2rfHXS1jcVkI7g/Z0rcyWqrw==
X-Google-Smtp-Source: AA6agR44iriQeDXdgAvX4vNd3NFHaCNbdwc8OiLFAakZZBLGzj4mhYZxBtLwFzx6rmpF8+WHDrqydlcQOtARnQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:ea85:b0:174:3c3a:8ff3 with SMTP
 id x5-20020a170902ea8500b001743c3a8ff3mr16542934plb.152.1661803989292; Mon,
 29 Aug 2022 13:13:09 -0700 (PDT)
Date:   Mon, 29 Aug 2022 20:12:52 +0000
In-Reply-To: <20220829201254.1814484-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829201254.1814484-6-cmllamas@google.com>
Subject: [PATCH 5/7] binder: remove unused binder_alloc->buffer_free
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
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

The ->buffer_free member was introduced in the first revision of the
driver under staging but it appears like it was never actually used
according to git's history. Remove it from binder_alloc.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index fe80cc405707..ab3b027bcd29 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -109,7 +109,6 @@ struct binder_alloc {
 	size_t free_async_space;
 	struct binder_lru_page *pages;
 	size_t buffer_size;
-	uint32_t buffer_free;
 	int pid;
 	size_t pages_high;
 	bool oneway_spam_detected;
-- 
2.37.2.672.g94769d06f0-goog

