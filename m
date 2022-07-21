Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737AF57D56E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiGUVCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiGUVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:02:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161B4904F2;
        Thu, 21 Jul 2022 14:02:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so3950902wrc.8;
        Thu, 21 Jul 2022 14:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzOZ/buUjSLGOsPD1/ja3wfCZsVe9ZvJX2WkV0R1uMA=;
        b=FW/664FOnx9kvxzM6wGlPoF4ICJysh65o5yUWQl+EDU0FhKo/GOGJOYppor7DqIRAC
         PB7cuZkprILBa7jFTac1CdLpLHXrbl/gb997eSZURLXCMBpRbhTXiQ90LkJ3QAiAzfeD
         /NPJo2VXESdT/uGAUaY3uVQE1FVkOoo6VMAVZgVmVCxaPDVHPnih315rO2K1Eh8rF4Fv
         4SMC/Pye4AQJmrrhFcoW36mI6mUL+z/UbsD8efFBNb6WvWFHdMB0pPPnkBLYEwiWt+0Z
         u7Xo64/cyIXlQDHKybFJ3SKn98eLMScDHkgTDAPo74OsjLwge9dmBgNndmStzRVhwplo
         XIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzOZ/buUjSLGOsPD1/ja3wfCZsVe9ZvJX2WkV0R1uMA=;
        b=sNfvyO490vmqD10pKwXGz5KMFFpl4aJW95UFU5smx4CEVYZgsaaT+nlEwmRba2YaJ8
         JSCfc0Vp4graOJImp9Rkzxw0fzD8Sj+uk2rvWm06iGSGvYBWEZyhDMpwMWFspgRi20nG
         g5BO1mp+kgIiJqHa9+cjaeLzaBGyPRYuy199d4S7vBrC8HoScjFAAUU0feGmj+2ZqRfz
         eOAj021CAvZwPdZ3RGHBNSExwK1cnvYqKkMwKnb56CFP8MwvUU3yw/QgJhJCg/IzOeUS
         S6bghedqL25dNgdTCyssDn3KoXsT6r/kz24JuXvinMvr2sholsP1MgHvA6kEF2SB7rQ/
         0sug==
X-Gm-Message-State: AJIora8ZfGsMj5ynGQTDAPwv+wAk3e4US7NQ6F0ig/x/VY9/oHivVM9x
        C1dP5/AYuI1JZYr9g1dhCyM=
X-Google-Smtp-Source: AGRyM1uXo/iZjsT8WmiiksOoyLvdRoLXooFYZcBcZDEwM9Q2X8P4JSnySPvwmXVpAEOSQObRxIp49Q==
X-Received: by 2002:a5d:6252:0:b0:21e:4457:1bca with SMTP id m18-20020a5d6252000000b0021e44571bcamr184739wrv.287.1658437345312;
        Thu, 21 Jul 2022 14:02:25 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm2884383wrs.29.2022.07.21.14.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:02:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/7] Documentation/mm: Avoid invalid use of addresses from kmap_local_page()
Date:   Thu, 21 Jul 2022 23:02:03 +0200
Message-Id: <20220721210206.13774-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721210206.13774-1-fmdefrancesco@gmail.com>
References: <20220721210206.13774-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of kmap_local_page() must be absolutely sure to not hand kernel
virtual address obtained calling kmap_local_page() on highmem pages to
other contexts because those pointers are thread local, therefore, they
are no longer valid across different contexts.

Extend the documentation of kmap_local_page() to warn users about the
above-mentioned potential invalid use of pointers returned by
kmap_local_page().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index f266354c82ab..50d2b1fac24a 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -77,6 +77,13 @@ list shows them in order of preference of use.
   page_address() for getting the address of memory pages which, depending
   on the GFP_* flags, cannot come from ZONE_HIGHMEM.
 
+  While it is significantly faster than kmap(), for the higmem case it
+  comes with restrictions about the pointers validity. Contrary to kmap()
+  mappings, the local mappings are only valid in the context of the caller
+  and cannot be handed to other contexts. This implies that users must
+  be absolutely sure to keep the use of the return address local to the
+  thread which mapped it.
+
   Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
   extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
   because the map implementation is stack based. See kmap_local_page() kdocs
-- 
2.37.1

