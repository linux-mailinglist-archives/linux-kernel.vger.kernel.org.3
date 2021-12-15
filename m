Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3224B475C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbhLOPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244050AbhLOPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:44:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8DC061574;
        Wed, 15 Dec 2021 07:44:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so19541581pjb.5;
        Wed, 15 Dec 2021 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZQpjHX9dmpcsXje2Uj46IZRB9dElu7f9CmUWai1aoyo=;
        b=GPNcCQDNTcfpQ8Igy41dk6BT7Vnak7Z1zgVF79fb569KzmPV9iUwAamE+QYIRxStoY
         lbvw1V3CNspZk1BfRWE9gPiXEZmEC7viVhsgoK8L3Qx2TfkjWpvADx+8csupU4++5N61
         vBuIdUw47L62gXVMCMxDXIToJH7eH/Bt88O+RkQ04LS0uuzg4sy1VHbTRphGpqFWLciG
         L6mhurvOc5rIx5jmfBar/IDnT+09ek1N5y0+xX26v/rq0YAhxbHA/YWU4XoDdZavM48D
         KdlrPNcDyjDeEakWIZ9KNP5xq7gGqMX/3f2E6ERBTTYJC/NcX0mqHiP9PMsCwynm4po+
         g8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZQpjHX9dmpcsXje2Uj46IZRB9dElu7f9CmUWai1aoyo=;
        b=oz15O/ZUZ9UzLwcojVU8caBYQmqvld8p0J5jShrkrYoeDyjMX+WMYwImIqd6yzw71/
         q7SjZSi3AB6f5Gfwiodm9Bhp1Ar6sTAfSHzbwqTNOJmdc2tkw4OO+lFPmqO0My9blFgw
         y+6e2b70f2JKv8XYOTmndjUk5i+RlOkt5Bl40mFV3+kCNVcrg+QtLNCdsOMx57gdh1In
         V2EkOyG4bKCEAQ5RedxjDWzoefCalNrqz7p2a5X0kc5N9W4R8DMVwlzBg07jpzCGmSn1
         EGSGm5ashc16L81E5OTjTUa8uQBVl7+sn7gNP8lYw5n+Jw5trEcv1LKoPhc5XfOuXjMr
         34zA==
X-Gm-Message-State: AOAM531/pVxtNwQhFDISw+YHJcbU+LaQsp1tFPZPiW6a2ehdwo7kEnXA
        wWX3hO16C425U+H7y0wFMDo=
X-Google-Smtp-Source: ABdhPJyTWTg5hRbQgtXnx9xCo10AsgF4ScMRxvo/dpQBveOWmhz0dDkLjkvUNwqZeb87aQr6ljEQ9Q==
X-Received: by 2002:a17:902:e747:b0:148:a18e:75be with SMTP id p7-20020a170902e74700b00148a18e75bemr5575502plf.73.1639583050796;
        Wed, 15 Dec 2021 07:44:10 -0800 (PST)
Received: from localhost.localdomain ([171.221.151.97])
        by smtp.gmail.com with ESMTPSA id o9sm2907440pgu.12.2021.12.15.07.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Dec 2021 07:44:10 -0800 (PST)
From:   yongw.pur@gmail.com
X-Google-Original-From: wang.yong12@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Subject: [PATCH] Documentation: accounting: add thrashing page cache and direct compact
Date:   Wed, 15 Dec 2021 07:43:41 -0800
Message-Id: <1639583021-92977-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

Add thrashing page cache and direct compact related descriptions
and update the usage of getdelays userspace utility.

The following patches modifications have been updated:
https://lore.kernel.org/all/20190312102002.31737-4-jinpuwang@gmail.com/
https://lore.kernel.org/all/1638619795-71451-1-git-send-email-
wang.yong12@zte.com.cn/

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: wangyong <wang.yong12@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 Documentation/accounting/delay-accounting.rst | 55 +++++++++++++--------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 1b8b46d..197fe31 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -13,6 +13,8 @@ a) waiting for a CPU (while being runnable)
 b) completion of synchronous block I/O initiated by the task
 c) swapping in pages
 d) memory reclaim
+e) thrashing page cache
+f) direct compact
 
 and makes these statistics available to userspace through
 the taskstats interface.
@@ -41,11 +43,12 @@ generic data structure to userspace corresponding to per-pid and per-tgid
 statistics. The delay accounting functionality populates specific fields of
 this structure. See
 
-     include/linux/taskstats.h
+     include/uapi/linux/taskstats.h
 
 for a description of the fields pertaining to delay accounting.
 It will generally be in the form of counters returning the cumulative
-delay seen for cpu, sync block I/O, swapin, memory reclaim etc.
+delay seen for cpu, sync block I/O, swapin, memory reclaim, thrash page
+cache, direct compact etc.
 
 Taking the difference of two successive readings of a given
 counter (say cpu_delay_total) for a task will give the delay
@@ -88,41 +91,37 @@ seen.
 
 General format of the getdelays command::
 
-	getdelays [-t tgid] [-p pid] [-c cmd...]
-
+	getdelays [-dilv] [-t tgid] [-p pid]
 
 Get delays, since system boot, for pid 10::
 
-	# ./getdelays -p 10
+	# ./getdelays -d -p 10
 	(output similar to next case)
 
 Get sum of delays, since system boot, for all pids with tgid 5::
 
-	# ./getdelays -t 5
-
-
-	CPU	count	real total	virtual total	delay total
-		7876	92005750	100000000	24001500
-	IO	count	delay total
-		0	0
-	SWAP	count	delay total
-		0	0
-	RECLAIM	count	delay total
-		0	0
+	# ./getdelays -d -t 5
+	print delayacct stats ON
+	TGID	5
 
-Get delays seen in executing a given simple command::
 
-  # ./getdelays -c ls /
+	CPU             count     real total  virtual total    delay total  delay average
+	                    8        7000000        6872122        3382277          0.423ms
+	IO              count    delay total  delay average
+		            0              0              0ms
+	SWAP            count    delay total  delay average
+	                    0              0              0ms
+	RECLAIM         count    delay total  delay average
+		            0              0              0ms
+	THRASHING       count    delay total  delay average
+	                    0              0              0ms
+	COMPACT         count    delay total  delay average
+	                    0              0              0ms
 
-  bin   data1  data3  data5  dev  home  media  opt   root  srv        sys  usr
-  boot  data2  data4  data6  etc  lib   mnt    proc  sbin  subdomain  tmp  var
+Get IO accounting for pid 1, it works only with -p::
 
+	# ./getdelays -i -p 1
+	printing IO accounting
+	linuxrc: read=65536, write=0, cancelled_write=0
 
-  CPU	count	real total	virtual total	delay total
-	6	4000250		4000000		0
-  IO	count	delay total
-	0	0
-  SWAP	count	delay total
-	0	0
-  RECLAIM	count	delay total
-	0	0
+The above command can be used with -v to get more debug information.
-- 
2.7.4

