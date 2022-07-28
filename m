Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE3584386
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiG1PtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiG1PtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:49:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DF6BD48;
        Thu, 28 Jul 2022 08:49:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j22so3886772ejs.2;
        Thu, 28 Jul 2022 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNL0v8M3ogq6CFgHYJ5gw3skUxo1cyHwx09sKFCivm4=;
        b=NDPcSSW6IS51pmJKZAmPDSDqw//XotceDPFpPrTWnME1v0ubVsH3OjqWS+O6atJfQT
         Yk+6kcjfART2IwEZU2POnRTLCeGAmJf6gzO4vfA3muIrmWFo9exWusBCcN1BWuWT6cgx
         zud2dYbh8HOHNPnPZ1mCNubOvWf6WIg/KA1qXahAu1tUoDIUIDq4Dkqv5ur5FIZ4B3a8
         FTILN9VHDJ9eP7WfaMoyf3VhOEbkalf2Trwscbhtpw1Wr0lZpEsQ4gJZ3t9jpXTSWJ7M
         nqPFzm2diXj14vHjJdMI/htVPNZAvIg1RfKhrTsJjSoC1Ev3n7IlTHPy4FeG7efSNSEh
         oweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNL0v8M3ogq6CFgHYJ5gw3skUxo1cyHwx09sKFCivm4=;
        b=FRoKQY9Ulo7xoNrkiMkN2L0zQMdOQaoAgkmipqd37UQWUVyoXCtxoeZOOOD5DjLtHW
         ITYoPK6m6u/qtKxJRHqE1pbVcy/ZGcMT4MLRVPvTq2g47vypT4VHJ4YWZ4Wkk1BNVIBw
         4rf8w0Q/W4kfAUpOmlwNfiTsEz5LC2UbnBMUVB87LuM/j7WwoDQIHi+IiTxjlbqKNBez
         hUhmOX5V817Cdp28+Usesd8W/noiBTrvo7wD4jV3f/FUEs2T5F96iloBAPnRWQ+rdO67
         AuXBHFR3w8uKanY4AnXxzk4RVBv7/CJbviT0M204ei3B5Dnf+2CZF1NP9T3xe6y07rrw
         bskw==
X-Gm-Message-State: AJIora/YTUQ/VYD+Ss9Jivu4bnVFAsDDfUSJxy76W05Us3x84SnrnwCI
        MY6/TvbHDcpjEkY6iuNjsss=
X-Google-Smtp-Source: AGRyM1s1lHJVGwf/gl1f3XMa52mfrgiOxmy82DQqsN1S916uAzl1V/CXtmqgra/ZOudzPNYSy0S3YA==
X-Received: by 2002:a17:906:8a6a:b0:72b:552e:67f0 with SMTP id hy10-20020a1709068a6a00b0072b552e67f0mr21090041ejc.733.1659023339142;
        Thu, 28 Jul 2022 08:48:59 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm902487edy.20.2022.07.28.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:48:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 4/7] Documentation/mm: Avoid invalid use of addresses from kmap_local_page()
Date:   Thu, 28 Jul 2022 17:48:41 +0200
Message-Id: <20220728154844.10874-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728154844.10874-1-fmdefrancesco@gmail.com>
References: <20220728154844.10874-1-fmdefrancesco@gmail.com>
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
index 34d7097d3ce8..71dc09563ff8 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -77,6 +77,13 @@ list shows them in order of preference of use.
   for pages which are known to not come from ZONE_HIGHMEM. However, it is
   always safe to use kmap_local_page() / kunmap_local().
 
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

