Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC7655A05E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiFXRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiFXRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:18 -0400
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8254463628
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:17 -0700 (PDT)
Received: by mail-vk1-xa49.google.com with SMTP id m38-20020ac5cfe6000000b0036c7c6b8508so918356vkf.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a/I3oVqLRkRj5HBns0MWW3Ig4smTJMVIYbM6WBPe2Ok=;
        b=Oi4b3uHib9QeDIaeFbYIYjHKGKKHh9PJftREg1F7x7dC3MdxzlFlkF4nFN2oUkEmJv
         ksO18/0H6IRArOgx9eqn0gBPvHv2o9/dMee0FdF4JnH+jRgLOM2Nmsz6Dpy3izb1wBXI
         nx/vriW2gKgSHU0JVyGwH1vUXSXmgF4EHLnj5axRDix5D/a9yC/E9keoj2kNivTofhb4
         42LtC0DSUfNjTGTr1svMT6wtFWhev3hUy0WltrufYZ9eblHJrOi+VTLQFp5FE3ILODHz
         B23csyok2qwTFatLcA+FGCv8SsDhrPMlNnuTVoNybqfkwHtiNOSZnpNZ1wSXRcUNFGXT
         kHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a/I3oVqLRkRj5HBns0MWW3Ig4smTJMVIYbM6WBPe2Ok=;
        b=XfjdLiOk5/7hb6s+xiQvIPx+tbdocIstaggXuzltJ3BBmOy35clKa4kmq+LnJpEIMS
         TeQAw4ceAQOMEwzGFX3ZcznMd+Cw/syUNh9MWcYBYKLrd867YINnW6giPvwj8bQGsJV0
         a0E+hAj/JMiuGYq9hJD4NHXR1ivXUZ5R53UyGkGaXQxas3uwB39zlBg1IqwevyLS94I/
         qIAfKy+RBVJGTBibM9dPI+4Qg2JHOj0p+jTagSZIcMztK177Nsy80yQN9YtG/RK7xdXN
         ZRqK2/Ghk2JVwSu5EvYXv1tlCrDU45uAeTmUzaodjRk7MXqPaoVnyCp+OrZVPv04/tV0
         5X9Q==
X-Gm-Message-State: AJIora8Hw7tv2+5NXoyRELCEbDIvN4Rw7Y5+bsp7AnqCfRc0y8Hlo2rv
        QvZQcD2ezDNPZJHAzwSPK5bP1H3OyLDVVCYl
X-Google-Smtp-Source: AGRyM1ulcuwzT9arHdsQPyjRKEdIRoxwLhneCD7SBt/oCPOlZSq/mYJ1bqnOaa+5zikkIexlm8WeaXwx6yxitdUI
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:2657:0:b0:36c:d88e:88cc with SMTP
 id m84-20020a1f2657000000b0036cd88e88ccmr256693vkm.36.1656092236628; Fri, 24
 Jun 2022 10:37:16 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:35 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-6-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 05/26] hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

This adds the Kconfig to enable or disable high-granularity mapping. It
is enabled by default for architectures that use
ARCH_WANT_GENERAL_HUGETLB.

There is also an arch-specific config ARCH_HAS_SPECIAL_HUGETLB_HGM which
controls whether or not the architecture has been updated to support
HGM if it doesn't use general HugeTLB.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 5976eb33535f..d76c7d812656 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -268,6 +268,13 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	  to enable optimizing vmemmap pages of HugeTLB by default. It can then
 	  be disabled on the command line via hugetlb_free_vmemmap=off.
 
+config ARCH_HAS_SPECIAL_HUGETLB_HGM
+	bool
+
+config HUGETLB_HIGH_GRANULARITY_MAPPING
+	def_bool ARCH_WANT_GENERAL_HUGETLB || ARCH_HAS_SPECIAL_HUGETLB_HGM
+	depends on HUGETLB_PAGE
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

