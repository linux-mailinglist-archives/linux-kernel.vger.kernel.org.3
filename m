Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B28467249
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 07:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354956AbhLCHAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbhLCHAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:00:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B0C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 22:56:50 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s37so2133085pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yVC0J0GgDi6D+o/IFLNWueSiWRaR9U2xArJ8d+sGzs=;
        b=XsTfRgpV2w6gZxfsOnXIturDcSddGzfLc3FtabtsVNEhMUTSOPBcYZszfyzGpqEmi3
         pxbFgLxVSM55oMl+wfh3rfIyS37aImJLMJBnQh56RpeB/WDyj35UTGAenN2lwvUJ+Cuq
         SYXRkLnPE1IOOs0ZHw+vMDwq1dMvZR3LSskEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yVC0J0GgDi6D+o/IFLNWueSiWRaR9U2xArJ8d+sGzs=;
        b=o/Idoha4rzA9HoufgKme3hVbf04U8h5oqAcqAZkV4hBnauPzvJoTMFDUq00kAvG0Fz
         AjIZQwJOmS7t4ql72EBGQxS27Ij4ms3xSyCSrU8Qki1VJ5IWrww/8eYNvcrcfXZBGiaL
         iHdK6XV0VxnXTJzWNDilGoU5lnY5IhsrYjgpi+h0HUaTpkR6J+uL40ozdhlKWuKRJeyg
         K2YWSi+5mlkwwNd9r8jjuiK1AgC7Mzit0Rrl3WSaQ1hEOLxluVEMVRyNJJqYO6HYfzlI
         eD2fIJ1uIqsdtQVGLHGVqakPe7+WQ4wn5czth5C/XTWQMpkDuBHIZ53jFYo+qwfuXp2I
         ZN5g==
X-Gm-Message-State: AOAM532ay80Gjg9x+5JLqGlF35u5Gm1xM2NUEOsmSFoQLpTDzsZUsq4H
        Hgf/wUpOoemASN4R+zbyPMQENg==
X-Google-Smtp-Source: ABdhPJw+KrMRfgQD9NsuTqOlLn8EEYKQKMn/hzfj6JZJ7na/JzXZTVLK1G+No+NlLtGZUzSWQRrRdw==
X-Received: by 2002:a65:6814:: with SMTP id l20mr3271579pgt.8.1638514609624;
        Thu, 02 Dec 2021 22:56:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h186sm1926226pfg.64.2021.12.02.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 22:56:49 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] hugetlb/cgroup: Fix copy/paste array assignment
Date:   Thu,  2 Dec 2021 22:56:47 -0800
Message-Id: <20211203065647.2819707-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; h=from:subject; bh=QunbLtKtOPD6ZtE5jieVWtELn4i3W17Ccb86rvTxWNo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqb+u9KE+Tr58mubyFzC5LFRo1fXx/0dTGztzt1xL SLo4bniJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYam/rgAKCRCJcvTf3G3AJpAqD/ 9ngdlzSV8Q6799AM0CbQ+KPbuUUiyJtSVW3VSRT3c8ZdZh+mV8qomHz0/TdosvhqRBxRwomUfzeyTX GDVoHMTEOu8uR0JXDrKY1ZXyNVQt4/Fzg0zWilVZMjpTOaPr2kW+XKjaZUtYLFhLZcaqnU7F2Lpq79 Ee4lbOqULwXGa3mb8/kmdW/8Cq51UrQcyh9begBraCLEEmxGbMVe40qR4LUBSKDta+hTsl2As2hckO VmVw3/D0mzRFoV4iMVmnlEeTHSb6tko6LVFTp4KuM6V0vghX/yZCvnsCf07PxRf3F0ybDc5uE3Ejuo 5WPSUprGDCCYgXJ7Fi9E2hZcZATCtzuTxoym/rHZ0PpYdP7kly08L7NJX26dMBZQcUTJFCHmWqRDs8 hOQDnwY1OPQbeIFU7Wz08kkkxFpALHQXitfHHMWcVzz2m8j8YWDO2GkipDDrcuXkwS6Fjki/4zO4kK dX+yk6haFdhdDQtjAagyjHAL5UnIEGRu6HG2X25VPuWMg87fUnRhkzDM/Wihr+4D6bS1ijqIHNDiTM uvJpQLetff9gPNmBEicy/r6qsQ9W1jMUNVNVe5AkIxQ8X9Nf4P9sX9mdBbOBPY/Q7HnDV8ixAU4vDY TjDk5T65+C6B1q98QYL/8Bp7cjsGIpVkaR59cdANHPCT2pGJ5ohZDYLkOQ4Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix mismatched array assignment, reported by an -Warray-bounds build:

mm/hugetlb_cgroup.c: In function '__hugetlb_cgroup_file_legacy_init':
mm/hugetlb_cgroup.c:850:35: error: array subscript 8 is above array bounds of 'struct cftype[8]' [-Werror=array-bounds ]
  850 |         cft = &h->cgroup_files_dfl[8];
      |                ~~~~~~~~~~~~~~~~~~~^~~
In file included from mm/hugetlb_cgroup.c:23:
./include/linux/hugetlb.h:625:23: note: while referencing 'cgroup_files_dfl'
  625 |         struct cftype cgroup_files_dfl[8];
      |                       ^~~~~~~~~~~~~~~~

Fixes: e45f4726bcad ("hugetlb: add hugetlb.*.numa_stat file")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/hugetlb_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 9eebe8df3c39..f9942841df18 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -847,7 +847,7 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
 	cft->read_u64 = hugetlb_cgroup_read_u64;
 
 	/* Add the numa stat file */
-	cft = &h->cgroup_files_dfl[8];
+	cft = &h->cgroup_files_legacy[8];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
 	cft->private = MEMFILE_PRIVATE(idx, 1);
 	cft->seq_show = hugetlb_cgroup_read_numa_stat;
-- 
2.30.2

