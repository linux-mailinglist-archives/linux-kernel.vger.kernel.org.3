Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813F74901E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiAQGXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:23:48 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35915 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234410AbiAQGXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:23:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V2-m4ej_1642400624;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0V2-m4ej_1642400624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jan 2022 14:23:45 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org, nathan@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] fix initialization problems 
Date:   Mon, 17 Jan 2022 14:23:43 +0800
Message-Id: <20220117062344.15633-1-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220115225920.0e5939aa@gandalf.local.home>
References: <20220115225920.0e5939aa@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,steven and Nathan

Thanks to Nathan, I realize that there are some problems with initialization.
Initialization of pthreads and mstructs may fail or be skipped, in which case 
it is possible to use uninitialized values in "out" logic. I'm not sure if 
such an error would happen, but it's certainly safe to initialize it.
 
I use mcount_sort_pthread as a global variable, which is consistent with 
orc_sort_pthread. And initialize the mstruct in function do_sort.

Yinan Liu (1):
  script/sorttable: fix some initialization problems

 scripts/sorttable.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.19.1.6.gb485710b

