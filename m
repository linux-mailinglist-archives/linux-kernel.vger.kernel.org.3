Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC04146BEF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhLGPRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:17:23 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35205 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhLGPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:17:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UzneqvB_1638890029;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UzneqvB_1638890029)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 23:13:50 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] ftrace sorting optimization 
Date:   Tue,  7 Dec 2021 23:13:45 +0800
Message-Id: <20211207151348.54921-1-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210911135043.16014-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steven

In fact, the code enclosed by ifdef CONFIG_FUNCTION_TRACER 
does not take effect. I saw similar usage under script and 
judged directly after the compilation is passed, without 
checking whether the sorting takes effect. Sorry for my 
negligence.

Now, after the modification, the patch works normally and 
passes the test case of livepatch's selftest which reported 
by robot.  

Yinan Liu (2):
  scripts: ftrace - move the sort-processing in ftrace_init
  script/sorttable: code style improvements

 kernel/trace/ftrace.c   |  11 +++-
 scripts/Makefile        |   6 +-
 scripts/link-vmlinux.sh |   6 +-
 scripts/sorttable.c     |   2 +
 scripts/sorttable.h     | 124 ++++++++++++++++++++++++++++++++++++++--
 5 files changed, 139 insertions(+), 10 deletions(-)

-- 
2.27.0

