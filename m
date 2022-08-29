Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79605A562F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiH2V2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiH2V1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:27:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5E49F750
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e16-20020a17090301d000b00172fbf52e7dso6844085plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=WpdYqLbUAWRRR7NpWeIwifObGgR3/WEcKlSas1duxWs=;
        b=A8iXlM7kWh/+WLxmr7Wxu633pJ33WbnreWCJkhO2mN51OTMuCRIiZbXSJTMwU7nnLp
         8HrWKhSa16qOE9IHNHTIDFaumIghV/X3vZxzBwxJyopuUJchdMXN0oUY2EJvc97qw23/
         002SGSF6e/GfvGXcSJZJ9OH52bwQ+17bBv1qwUEkh+/hxiA3XGJZS3QMw2bsNQo6K8n5
         ASVJIXUmfSCyDSBXlWu7+9C2NTyQxO6WdEpOrWiiN0G0XOZ0xYY++9szDB3PW4z/iVNr
         kXUF0efo+Jl4A1NDPbFsv2i2F8cuEbcHbyZjyx1JQrC6JX3bDooGkyCEfiAtjL3LX2kX
         L4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=WpdYqLbUAWRRR7NpWeIwifObGgR3/WEcKlSas1duxWs=;
        b=KtpWuzJ8jnDu+y2GbboetjTSaMA9QWs+Xr+EMf7i+nowQIjNQ+GoQ8inWXk+4Wy9uw
         +j8aj9mtiy7oTtKpIy8mHaYyA6acQCiWWx9LsT3EjdF6nEhzZl1TWF2EWDLaD82w+C/7
         P2ePyuavhm1rnLtZ0l6B0MX+ykbL6wsLT4ZFpriy5eGvlYmea2wIVQDMFY+Jc3w+mMAQ
         mWy17nNNUwzJj66G/DMXCZFDj7ULecfjMAnIf3L5zpHZdlksnpg2EVoA03cjAFIevnrF
         //3quUC1StQZL7QBSNszY9PSPmBuwEeRld+1dZqeb/MTXIo+jyWOps5opUUguzNuyBIH
         m8Gg==
X-Gm-Message-State: ACgBeo1N1Do4CayCTXdY+o3ScTNpeZA5NhrdDDEEbr2rtvBg+GMaJe8i
        iKW+WAbF7ClV3ZGYG0iTdVNLva+D0Ew=
X-Google-Smtp-Source: AA6agR7BIF7zDBFRMtaQFIX+dYsK3ioA4U218I6Y8n5CHeAbnavsVuqAEK5kMo+KsvAOcZae2RDMSpS8XIE=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:903:2d1:b0:171:3773:b95 with SMTP id
 s17-20020a17090302d100b0017137730b95mr17499271plk.173.1661808383315; Mon, 29
 Aug 2022 14:26:23 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:30 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-28-surenb@google.com>
Subject: [RFC PATCH 27/28] powerpc/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
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

From: Laurent Dufour <ldufour@linux.ibm.com>

Set ARCH_SUPPORTS_PER_VMA_LOCK so that the per-VMA lock support can be
compiled on powernv and pseries.
It may be use on the other platforms but I can't test that seriously.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/Kconfig | 1 +
 arch/powerpc/platforms/pseries/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index ae248a161b43..70a46acc70d6 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -16,6 +16,7 @@ config PPC_POWERNV
 	select PPC_DOORBELL
 	select MMU_NOTIFIER
 	select FORCE_SMP
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	default y
 
 config OPAL_PRD
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index fb6499977f99..7d13a2de3475 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -21,6 +21,7 @@ config PPC_PSERIES
 	select HOTPLUG_CPU
 	select FORCE_SMP
 	select SWIOTLB
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	default y
 
 config PARAVIRT_SPINLOCKS
-- 
2.37.2.672.g94769d06f0-goog

