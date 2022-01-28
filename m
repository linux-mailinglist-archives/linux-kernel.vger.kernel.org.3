Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12749FA88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348964AbiA1NTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348654AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3613CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=BFnS2HVemFqBghBQYQoit3Mzm0TjMbmSrEenm665k8w=;
 b=2dpLWkBE9v0lknlSIzYPOUv9ofd7VbjV/VSh/N5tA3XRDjPy8JwdzJcC1peuzvFj7CHoh
 7yhOi/faRp4ngfHBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=BFnS2HVemFqBghBQYQoit3Mzm0TjMbmSrEenm665k8w=;
 b=LXpqXihdo7IvGRJFBVCLL2z4CQzI6N+qpPgYIEda11ogFMEAadWWEJW4swjM25P9IqB20
 h1Yo5Cl3w5IBtDesp8ESchFm1g+O9UEcQmSf+6PMvPuXxYmgpzkIwhwYea6CY33/lbWRHd6
 3O0VrccO8zNPJBE9Sp1RqqbzTPRHXWCdSSh6bXYc/ZGFIRudFc9tRPqmkhL16of3LSIh8mb
 S9WPbCxJlnKfiiwiuA8d2lvr/FJUS/T6tmzY4SPCjVo0vOkuHL7zRyozEHq5jIFj7o4BdUY
 k6qm3DpgdiNfOmVAnYMtSTkMrzRc8asV9g3wYWhxGNfIzEOlBTtEBwtu2n1Q==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id EF82D160965;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id D3FD620459; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 07/35] x86/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date:   Fri, 28 Jan 2022 05:09:38 -0800
Message-Id: <20220128131006.67712-8-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT so that the speculative fault
handling code can be compiled on this architecture.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc76949a..378bc33bac54 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,6 +34,7 @@ config X86_64
 	select SWIOTLB
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
+	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
-- 
2.20.1

