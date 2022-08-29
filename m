Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437205A5628
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiH2V1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiH2V0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:49 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D474DCB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 36-20020a17090a0fa700b001fd64c962afso3800076pjz.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=2fd/wGll+ATU6BJRTn7wtpRUT69Ps19K4L9NuJFwTCo=;
        b=CptXAEbTEIrjcI1hpAhqMGzwstwkcEJJxmfb7we2Tkw33BFQo0d25Vl71IxE1hgwCE
         +/zdjUxBz/kfwlykJ2mpRLD2ASHh0Jx/8NPF+GvmOj+OIPDuJ9h8tJ0qgl8jIPnA0gyY
         HL/K18g+JnPGw8ocd38eG5KHL97qZgAE2vHMSq8EmM7kYFzwJqKpJAdVhwHK8rQ0CEUk
         zlwtiJI41bKlNxlGW7NWWuuvJOTrejKhLXTonY1HBOreH+6SF0a8TMKsBr5d7H138Lnw
         MYC4Krs42a4eoKPM77oYkjvTzwtNbqixe2Jty6RY0Tg1xXxoDrCaGfCoHKiNRbMG4ac9
         6NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=2fd/wGll+ATU6BJRTn7wtpRUT69Ps19K4L9NuJFwTCo=;
        b=HSqoH+9LDmkeOjE5+0qscOIrkwQQdDtmrOd/0Ibs+OSb6voR6T3yUT9R4md7TDZgpc
         Brn8EP8jIYdKS3b7xZrak0H7vh2vPFNFTtUXyebg4t6uOVesUTeITl9Zf3bJsstqg3/2
         UnzcDX//LsbKdkGD/79llnmFHn94PVMnL7KOxwbZHtckSuFFPBvzZCY67CJWjxLG3N9l
         MO0TpDFNLLWKX5mPQSzLVe1ige5h5oCzn7ei7D/4X69JwQDN/7zRkh1eONABiIJxDbDa
         d/5KsS+xQx+wWXfWCuV/U0/q/VYjKiAj0t18EiFuNk4TPVawzh7wdCR+rDUfjgyRY7oh
         VNqQ==
X-Gm-Message-State: ACgBeo3aootgj6cTHOBsoHv74Q6EiVC9mJmAKtj8ztKyrpYmPOMJQ2+P
        peTNQDQYR/+CbgpAFljQPK7vlrckh+I=
X-Google-Smtp-Source: AA6agR5QjqhJOQoDiATaLtKSN9vwads3L2SWpCSYlmwHfKycrJZLy9F13OZO0MNqEBq8/z8yofCbHCaZE68=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:902:d54b:b0:174:af35:4ba0 with SMTP id
 z11-20020a170902d54b00b00174af354ba0mr7860599plf.74.1661808376452; Mon, 29
 Aug 2022 14:26:16 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:26 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-24-surenb@google.com>
Subject: [RFC PATCH 23/28] x86/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
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

Set ARCH_SUPPORTS_PER_VMA_LOCK so that the per-VMA lock support can be
compiled on this architecture.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..ee19de020b27 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,6 +27,7 @@ config X86_64
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
-- 
2.37.2.672.g94769d06f0-goog

