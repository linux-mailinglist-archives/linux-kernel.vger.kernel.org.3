Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0172F53C956
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbiFCLbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiFCLa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:30:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA2C3C704;
        Fri,  3 Jun 2022 04:30:56 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253Aad6n001526;
        Fri, 3 Jun 2022 11:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TWuFSrfB9saZDu6O/TQlhO0/dPpvKZd/1iLk1zBqEnI=;
 b=YkqVrjgpYcBOKYccwR7OpZOS+4udRrF6E331cGnhTqnncfSvXr4w1y/BbTD27bLI7SJd
 xIFC3RRnKE+W873NC757lN3JmoKrpkvMh2zHGg5Cuj+8CG6qP4dP9tA1BJxNXg6bGG8u
 jfYG3C13pnwdVEwCLgwQcgXK6P5TiKdU0JbjArUn0ysWI5KxVzgbLwbzDAeOA+QuBbPR
 kePg14NBmqfDsqXGlB2Dx9Jo0c3jnWu0bxZHATz7CxnKbPriH9M5RCaFDKoDBdmnJtqm
 8YI0YONhYCp6tz9wXT+48tFgSCeOLNS/bl/L62iftLhXYZvp/6ZCRpNcDLW6R1cwjBaE SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfeksaxr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 11:30:53 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253BTiYw012992;
        Fri, 3 Jun 2022 11:30:53 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfeksaxnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 11:30:53 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253BLvIm025527;
        Fri, 3 Jun 2022 11:30:45 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3gbcakpbtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 11:30:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253BUfGJ22151464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 11:30:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C479211C04A;
        Fri,  3 Jun 2022 11:30:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71E9D11C04C;
        Fri,  3 Jun 2022 11:30:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 11:30:41 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, cjense@google.com, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: perf test 83 fails on s390
Date:   Fri,  3 Jun 2022 13:30:34 +0200
Message-Id: <20220603113034.2009728-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h4XAIoEzw6rsLBvakpGQWNw7WLHcJxnS
X-Proofpoint-ORIG-GUID: 3nmRY4fwGezJubKaypzCfGpX7ePAW4PX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_03,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test -F 83 ("perf stat CSV output linter") fails on s390.
Reason is the wrong number of fields for certain CPU core/die/socket
related output.

On x84_64 the output of command
 # ./perf stat -x, -A -a --no-merge true
 CPU0,1.50,msec,cpu-clock,1502781,100.00,1.052,CPUs utilized
 CPU1,1.48,msec,cpu-clock,1476113,100.00,1.034,CPUs utilized
 ...
results in 8 fields with 7 comma separators.

On s390 the output of command
 #  ./perf stat -x, -A -a --no-merge -- true
 0.95,msec,cpu-clock,949800,100.00,1.060,CPUs utilized
 ...
results in 7 fields with 6 comma separators. Therefore this tests
fails on s390. Similar issues exist for per-die and per-socket output
which is not supported on s390.

I have rewritten the python program to count commas in each output line
into a bash function to achieve the same result. I hope this makes
it a bit easier.

Output before:
 # ./perf test -F 83
 83: perf stat CSV output linter  :
 Checking CSV output: no args [Success]
 Checking CSV output: system wide [Success]
 Checking CSV output: system wide Checking CSV output: \
	 system wide no aggregation 6.92,msec,cpu-clock,\
	 6918131,100.00,6.972,CPUs utilized
 ...
 RuntimeError: wrong number of fields. expected 7 in \
	 6.92,msec,cpu-clock,6918131,100.00,6.972,CPUs utilized

 FAILED!
 #

Output after:
 # ./perf test -F 83
 83: perf stat CSV output linter             :
 Checking CSV output: no args [Success]
 Checking CSV output: system wide [Success]
 Checking CSV output: system wide Checking CSV output:\
	 system wide no aggregation [Success]
 Checking CSV output: interval [Success]
 Checking CSV output: event [Success]
 Checking CSV output: per core [Success]
 Checking CSV output: per thread [Success]
 Checking CSV output: per die [Success]
 Checking CSV output: per node [Success]
 Checking CSV output: per socket [Success]
 Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 .../tests/shell/lib/perf_csv_output_lint.py   | 48 -------------
 tools/perf/tests/shell/stat+csv_output.sh     | 69 ++++++++++++-------
 2 files changed, 45 insertions(+), 72 deletions(-)
 delete mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py

diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
deleted file mode 100644
index 714f283cfb1b..000000000000
--- a/tools/perf/tests/shell/lib/perf_csv_output_lint.py
+++ /dev/null
@@ -1,48 +0,0 @@
-#!/usr/bin/python
-# SPDX-License-Identifier: GPL-2.0
-
-import argparse
-import sys
-
-# Basic sanity check of perf CSV output as specified in the man page.
-# Currently just checks the number of fields per line in output.
-
-ap = argparse.ArgumentParser()
-ap.add_argument('--no-args', action='store_true')
-ap.add_argument('--interval', action='store_true')
-ap.add_argument('--system-wide-no-aggr', action='store_true')
-ap.add_argument('--system-wide', action='store_true')
-ap.add_argument('--event', action='store_true')
-ap.add_argument('--per-core', action='store_true')
-ap.add_argument('--per-thread', action='store_true')
-ap.add_argument('--per-die', action='store_true')
-ap.add_argument('--per-node', action='store_true')
-ap.add_argument('--per-socket', action='store_true')
-ap.add_argument('--separator', default=',', nargs='?')
-args = ap.parse_args()
-
-Lines = sys.stdin.readlines()
-
-def check_csv_output(exp):
-  for line in Lines:
-    if 'failed' not in line:
-      count = line.count(args.separator)
-      if count != exp:
-        sys.stdout.write(''.join(Lines))
-        raise RuntimeError(f'wrong number of fields. expected {exp} in {line}')
-
-try:
-  if args.no_args or args.system_wide or args.event:
-    expected_items = 6
-  elif args.interval or args.per_thread or args.system_wide_no_aggr:
-    expected_items = 7
-  elif args.per_core or args.per_socket or args.per_node or args.per_die:
-    expected_items = 8
-  else:
-    ap.print_help()
-    raise RuntimeError('No checking option specified')
-  check_csv_output(expected_items)
-
-except:
-  sys.stdout.write('Test failed for input: ' + ''.join(Lines))
-  raise
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 983220ef3cb4..38c26f3ef4c1 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -6,20 +6,41 @@
 
 set -e
 
-pythonchecker=$(dirname $0)/lib/perf_csv_output_lint.py
-if [ "x$PYTHON" == "x" ]
-then
-	if which python3 > /dev/null
-	then
-		PYTHON=python3
-	elif which python > /dev/null
-	then
-		PYTHON=python
-	else
-		echo Skipping test, python not detected please set environment variable PYTHON.
-		exit 2
-	fi
-fi
+function commachecker()
+{
+	local -i cnt=0 exp=0
+
+	case "$1"
+	in "--no-args")		exp=6
+	;; "--system-wide")	exp=6
+	;; "--event")		exp=6
+	;; "--interval")	exp=7
+	;; "--per-thread")	exp=7
+	;; "--system-wide-no-aggr")	exp=7
+				[ $(uname -m) = "s390x" ] && exp=6
+	;; "--per-core")	exp=8
+	;; "--per-socket")	exp=8
+	;; "--per-node")	exp=8
+	;; "--per-die")		exp=8
+	esac
+
+	while read line
+	do
+		# Check for lines beginning with Failed
+		x=${line:0:6}
+		[ "$x" = "Failed" ] && continue
+
+		# Count the number of commas
+		x=$(echo $line | tr -d -c ',')
+		cnt="${#x}"
+		# echo $line $cnt
+		[ "$cnt" -ne "$exp" ] && {
+			echo "wrong number of fields. expected $exp in $line" 1>&2
+			exit 1;
+		}
+	done
+	return 0
+}
 
 # Return true if perf_event_paranoid is > $1 and not running as root.
 function ParanoidAndNotRoot()
@@ -30,7 +51,7 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking CSV output: no args "
-	perf stat -x, true 2>&1 | $PYTHON $pythonchecker --no-args
+	perf stat -x, true 2>&1 | commachecker --no-args
 	echo "[Success]"
 }
 
@@ -42,7 +63,7 @@ check_system_wide()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, -a true 2>&1 | $PYTHON $pythonchecker --system-wide
+	perf stat -x, -a true 2>&1 | commachecker --system-wide
 	echo "[Success]"
 }
 
@@ -55,14 +76,14 @@ check_system_wide_no_aggr()
 		return
 	fi
 	echo -n "Checking CSV output: system wide no aggregation "
-	perf stat -x, -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
+	perf stat -x, -A -a --no-merge true 2>&1 | commachecker --system-wide-no-aggr
 	echo "[Success]"
 }
 
 check_interval()
 {
 	echo -n "Checking CSV output: interval "
-	perf stat -x, -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
+	perf stat -x, -I 1000 true 2>&1 | commachecker --interval
 	echo "[Success]"
 }
 
@@ -70,7 +91,7 @@ check_interval()
 check_event()
 {
 	echo -n "Checking CSV output: event "
-	perf stat -x, -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
+	perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
 	echo "[Success]"
 }
 
@@ -82,7 +103,7 @@ check_per_core()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
+	perf stat -x, --per-core -a true 2>&1 | commachecker --per-core
 	echo "[Success]"
 }
 
@@ -94,7 +115,7 @@ check_per_thread()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
+	perf stat -x, --per-thread -a true 2>&1 | commachecker --per-thread
 	echo "[Success]"
 }
 
@@ -106,7 +127,7 @@ check_per_die()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
+	perf stat -x, --per-die -a true 2>&1 | commachecker --per-die
 	echo "[Success]"
 }
 
@@ -118,7 +139,7 @@ check_per_node()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
+	perf stat -x, --per-node -a true 2>&1 | commachecker --per-node
 	echo "[Success]"
 }
 
@@ -130,7 +151,7 @@ check_per_socket()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
+	perf stat -x, --per-socket -a true 2>&1 | commachecker --per-socket
 	echo "[Success]"
 }
 
-- 
2.36.1

