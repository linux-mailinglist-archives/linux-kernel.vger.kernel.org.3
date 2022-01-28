Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B828449FA7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348777AbiA1NTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244833AbiA1NTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:08 -0500
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jan 2022 05:19:07 PST
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7193C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:07 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375406; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=60KVsRSybg58S5Bq7/6VWRR0Ob54Rjhy19T2JOiOHJE=;
 b=M7pzfh5ZrllwylgwXDFgMgUOxk+x0CQXf6B5IVcHP6kNbiwFEwwKpkHsAzgcdMs6ciQ+K
 40+M0hVJhJPDMYlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375406; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=60KVsRSybg58S5Bq7/6VWRR0Ob54Rjhy19T2JOiOHJE=;
 b=hH+5ulWntN/qZ08GjZofRdKqO2OeOaAGUxe42j5ciL7Bjfd4AWn2kXvECpD0Tk1kLuQim
 pXNlIDBs0nLbih3vTu1Xmftjg+LmMrBFYRCGmnBJXw+5vZdhI3IEbAvdi8t/VIWjDGOIWvb
 VK/0trH9WTTtLQsjBsY0lG/KIFr00ZEXA0HIUrpP7HHkEFIFaJjWppZIzD16uxbHJw/3rti
 LymDIcnLEYmmKHELb7Bb3LM2Q3tDBAZ1TqK6ebvJCW9rjIgkV5aWyrvSy/xo6LiJO1+KsYu
 PgxAcY2i2izS6gADabfEHywhVuqppThEPWfhOrm+GR6Sg4NMiy43Uk41aLmA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id CEF33160942;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id C2D5D1FF74; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 01/35] mm: export dump_mm
Date:   Fri, 28 Jan 2022 05:09:32 -0800
Message-Id: <20220128131006.67712-2-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary in order to allow VM_BUG_ON_MM to be used in modules
(I encountered the issue when adding VM_BUG_ON_MM in mmap locking functions).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/debug.c b/mm/debug.c
index bc9ac87f0e08..40d3f358b75c 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -220,6 +220,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->def_flags, &mm->def_flags
 	);
 }
+EXPORT_SYMBOL(dump_mm);
 
 static bool page_init_poisoning __read_mostly = true;
 
-- 
2.20.1

