Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA561484E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiAEHP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:15:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236412AbiAEHP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:15:27 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2055lRAx025650;
        Wed, 5 Jan 2022 07:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dVJpHv+YjbftGIJ9ukse8fTknYro987ItK6Z8bBfpok=;
 b=dBIJFzeY7d99vaicfSOp7KTlo/3T6ITILcklh+ojCIm20Wake1YI0wTYTVoKQgProZNi
 06Ze5/kIOPrQ2xSBQxvNmu3pmvVyc0yFuQcpfIPWAiwQyraaewstGpVuSOcQV4A/EKqI
 l8NdWlMaAaAppiJj7ZA6fr3MuKe9uiegcsS+i748EQ/iWQ7JdmRiJzo1ij+5Q8bdgGMQ
 csdBfo0fu0JP4I2Rs3fizOqZJ6v2DdC2J7SsGPO0Iyv7b36Tyt8iHmflKRbo8LiCsuUj
 XdAZKXmwBKo9WoeJbpy0IDeWbkkAN5g4cgCDNQPXMdpwRTxnFti10a3dNIM/T4A/Hxwq sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcmawk1xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 07:15:16 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2056xGrS009622;
        Wed, 5 Jan 2022 07:15:16 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcmawk1ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 07:15:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2057CYE6014034;
        Wed, 5 Jan 2022 07:15:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3daek9e1s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 07:15:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2057FBuJ31588702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 07:15:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D70EA4053;
        Wed,  5 Jan 2022 07:15:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C3D5A4055;
        Wed,  5 Jan 2022 07:15:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.124.62])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 07:15:06 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org
Cc:     linux-kernel@vger.kernel.org, songliubraving@fb.com,
        maddy@linux.vnet.ibm.com, kjain@linux.ibm.com, mingo@redhat.com,
        eranian@google.com
Subject: [PATCH V3] perf/core: Avoid calling perf_mux_hrtimer_restart multiple times when scheduling event groups
Date:   Wed,  5 Jan 2022 12:45:02 +0530
Message-Id: <20220105071502.42988-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iJKwv11VdxGhqy9oJ-sDyDVN21US1238
X-Proofpoint-ORIG-GUID: kdyXdkOF_rBRZIB5n3T4x2BnWugu4_j2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_02,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf uses multiplexing if there are more events to be scheduled than the
available counters. With multiplexing, event groups will be rotated at
specified interval of time which is set using "hrtimer". During event
scheduling, if any of the event group fails to schedule, multiplexing
gets enabled by setting "rotate_necessary" for that event context and
starting the hrtimer by calling "perf_mux_hrtimer_restart".

Patch adds an optimisation to avoid calling "perf_mux_hrtimer_restart"
multiple times if already rotate_necessary is set for that context.
Even though "perf_mux_hrtimer_restart" will just return if hrtimer is
already active, this could avoid the overhead of calling this function
multiple times if there are many event groups. Patch adds the check to
avoid calling perf_mux_hrtimer_restart() for each event group on
every schedule.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Acked-by: Song Liu <song@kernel.org>
---
Changelog:
From v2 -> v3:
- Added Acked-by from Song Liu
From v1 -> v2:
- Rebased on top of latest kernel source.

 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 30d94f68c5bd..cc293b4360f6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3753,8 +3753,10 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 		} else {
-			ctx->rotate_necessary = 1;
-			perf_mux_hrtimer_restart(cpuctx);
+			if (!ctx->rotate_necessary) {
+				ctx->rotate_necessary = 1;
+				perf_mux_hrtimer_restart(cpuctx);
+			}
 			group_update_userpage(event);
 		}
 	}
-- 
2.33.0

