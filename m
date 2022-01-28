Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE0E49FA95
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiA1NUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:24 -0500
Received: from server.lespinasse.org ([63.205.204.226]:41711 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348738AbiA1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:11 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=hJIKChkB8VHiAv0wjag4cY+zBFGl6h7s8aJLFAJ4t0k=;
 b=Oyga/3lCe/RtyePrIqDmFLWhX0WM4mw25anmtIa6D8dSMSzDkLudB3p1WZ9iuB7b0C2pS
 eHBPvV4iuqF+1dfBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=hJIKChkB8VHiAv0wjag4cY+zBFGl6h7s8aJLFAJ4t0k=;
 b=UsMUlczIw2jWjOR5SBzHQnYm9vx8Q0Npk09M/ESPvhfFkeTqtcANk3M9DqGLJRlfmqctP
 aXhM1bdRoDv/uV17HzEB/CfGYygE0r5zLawZTdSKm8lOScN6cotkIoMmXwS6NZx8/ndbtDR
 CtLcYcf7Q+yhYzFs766riGUBWIYS8IPqkElBrJV3oOZ2nN9rNQFZGZ4ZnwP9MDSH0X409G6
 UQWDalHyrq+/0D6y2FwuoFRRrSxZyLfr6es3W8xkSvUK0ouTQhRgOm3+PBCokIL5ueLe99n
 eyedRbdNwHfm/c9v4K6IlG4cs1EzJGVjlBsaQy/R+2NNuEoCEKmHM7S4fsJw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 41B2D160ADF;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 252BB20FB3; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 32/35] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date:   Fri, 28 Jan 2022 05:10:03 -0800
Message-Id: <20220128131006.67712-33-michel@lespinasse.org>
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
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6978140edfa4..e764329b11a7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -222,6 +222,7 @@ config ARM64
 	select THREAD_INFO_IN_TASK
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
 	select TRACE_IRQFLAGS_SUPPORT
+	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
2.20.1

