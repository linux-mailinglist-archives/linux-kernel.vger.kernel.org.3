Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC0D4615C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377238AbhK2NIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:08:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240026AbhK2NGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:06:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBRlb6021547;
        Mon, 29 Nov 2021 13:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ku/CEBfJmQxdYxGV2L21ygEQjKY0TaYo9KnWsYQuGc4=;
 b=AJfUUDlhnaNS/3cVihVY8S/HOUVL9Cjdlk9QcEIqYeWo/kyk4rSwR6mtjTbnA+rsYoyT
 RQ2hjmeOL+8KyPU4TiNHU1pi1/CpxTXHcSnuLUWSmF0E3LyJ4HCkgJMCvURQhEy3ojeK
 sEkvv/ZogA97D51wFFZrUGTVJs+8PrZysZZ9uQ+MV72Xv7RHIhaM6V4PfG/AzrxMzazu
 K3tpN5X2TRDAPdYDAR/tfCAq4iiT/9c2F9u+o1J/dMYc1KE96j3CpVP/hTFj2u8m6C63
 BoSY0zCKXvY0foNDYGEfjGxZ95NykpIZdudNMD2dO9k34fl0LhBo8mjScxWl6FHhe45j pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmx0pt6dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:15 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATC0xaS024408;
        Mon, 29 Nov 2021 13:03:14 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmx0pt6cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:14 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATD2QuD010817;
        Mon, 29 Nov 2021 13:03:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ckca94w7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:03:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATD3ATn28901632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 13:03:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6896011C064;
        Mon, 29 Nov 2021 13:03:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1650511C050;
        Mon, 29 Nov 2021 13:03:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 13:03:10 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
Date:   Mon, 29 Nov 2021 14:03:06 +0100
Message-Id: <20211129130309.3256168-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L7H2P8xoon_xMwuf2x9xraZusjePbhHz
X-Proofpoint-GUID: gmlAaXk8iSjvWuXHyaZ2BqiYgyUmdioB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=751
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
As requested by Greg KH: avoid negative logic and use uppercase defines.

v1:
Create die and cluster cpu topology sysfs attributes only if an
architecture makes uses of it, instead of creating them always for all
architectures with bogus default values.
Also change the book and drawer cpu topology macros so they match all
all other topology macros.

v1: https://lore.kernel.org/lkml/20211128212221.1069726-1-hca@linux.ibm.com/

Heiko Carstens (3):
  topology/sysfs: export die attributes only if an architectures has support
  topology/sysfs: export cluster attributes only if an architectures has support
  topology/sysfs: rework book and drawer topology ifdefery

 Documentation/admin-guide/cputopology.rst | 33 +++++++++++------------
 drivers/base/topology.c                   | 28 ++++++++++++++-----
 include/linux/topology.h                  | 25 +++++++++++++++++
 3 files changed, 62 insertions(+), 24 deletions(-)

-- 
2.32.0
