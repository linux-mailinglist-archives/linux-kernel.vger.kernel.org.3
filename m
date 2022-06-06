Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA9053F05D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiFFUnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiFFUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:32 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5325D1208B1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:51 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e656032735so20653554fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zN7yZdXGDF9PPNDxZsgYWxX8yKA4nCi67h3WnKoi/Sc=;
        b=gR+ZqTNEY2oneCOOINaXerlABfVjfegVqPEAFOUx+e41iHPZqWuoSvB3U7W+hG637B
         SLS4OfO+8R6z0aLbzDhoxgNXz7OecFthBjJVdWzppPR3gOH3JL/lWCe7aa1CvwIeuDsz
         MYoQ9YA6J4efrzkkKb5UIYKUbidZoSXMxYgeXeNTaC2F4PiPpEi7hx7w7qiPuVFP1vCS
         c9zoMH4HmZhwPC4kHRveq3sr39ydbDioDIufjmhfcEFeLKmqok/hOSkroaESNG42C6td
         SR2oeM6Ys5NcAmmTaOmNWvG2vT+4hDamnw4a86phgUCcExZlVfBzAUCJqv258spBA4GY
         DB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zN7yZdXGDF9PPNDxZsgYWxX8yKA4nCi67h3WnKoi/Sc=;
        b=h8238dM6yxZQnqM3exNY1kf/LREPnGZQ1agyFBUzOH7Ue6iXqMic7AP/SukyfjxzTW
         6O5ZsAVHkZ3mNfoMfJD0orxJc9ar7fQoRbSHR8ty5IPPOuAiaABQjecwOUVbKbJmlr29
         bE+5J1N7A/s0jTBjrkk1Pw9oCKDzMaTPYnSL/LyzTTTgpdZIX7bNb+CYpKwHqxfM/YNq
         PuLZsA+VWtWDFWIQEsOdSH2DCa79qiayqt9U5AomiLaNSrUSWA88jLufgMz8uNFd+pjx
         8ATsHnhU38LvxGLpbMP0mHEj7xQO3vxVkYbd9ntqLwnEr6ZFnpMGM6wCXLlMBqpdzA0C
         r5PA==
X-Gm-Message-State: AOAM532arabpvV07PFy/nP47Q3m+gd7HwPaGzxRI0M039Q5ij7hYhMav
        +QfKSkWx9C5yL42a21f7rrunhxpB6A==
X-Google-Smtp-Source: ABdhPJw/XjRxHKzCBw4N3AcILogPcpEvbEODBwQq63HwujCnt98GlY2TKNISuQnTW15c0UGWqt8lVw==
X-Received: by 2002:a05:6870:7009:b0:f3:4965:5b1a with SMTP id u9-20020a056870700900b000f349655b1amr14053098oae.234.1654547930552;
        Mon, 06 Jun 2022 13:38:50 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:49 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/8] signal/compat: Remove compat_sigset_t override
Date:   Mon,  6 Jun 2022 16:37:57 -0400
Message-Id: <20220606203802.158958-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220606203802.158958-1-brgerst@gmail.com>
References: <20220606203802.158958-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 no longer uses compat_sigset_t when CONFIG_COMPAT isn't enabled, so
remove the override define.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/linux/compat.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 594357881b0b..44b1736c95b5 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -126,11 +126,9 @@ struct compat_tms {
 
 #define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
 
-#ifndef compat_sigset_t
 typedef struct {
 	compat_sigset_word	sig[_COMPAT_NSIG_WORDS];
 } compat_sigset_t;
-#endif
 
 int set_compat_user_sigmask(const compat_sigset_t __user *umask,
 			    size_t sigsetsize);
-- 
2.35.3

