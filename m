Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D9F47E182
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347737AbhLWKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:35:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35604 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229988AbhLWKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:35:10 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNA7JBk009109;
        Thu, 23 Dec 2021 10:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=g+TepBkpaMD+UOEyujzuhEbB1HXp3e27mu3t6Ctdn2g=;
 b=UVgJRxcgKKP5J9p7es5KCm9XEgvJhqvuubWYN9B4TOy83yZUT5u2QDZJI38Al+1u0jbv
 gOfR7yke1G9oMdlI1LAt4Dnh9KgOcUDDlTLfQAi25TlC8Kka9aBCL/AuHUTQq3PYs3yM
 Vrh602Oarm1U+wBe3KQwUh8qGu/CUhLme7j5pQiC7ri5h7X4XJPqBVZqfmYy+/wXI3F2
 GhIYPrkRsU7HoYLoIUnCLPGLK8nZus0tt9fhPPleBZLH2hcKoyQL0dLQoJwW1UV6uppm
 d3LNLNNdx5opJuDVdpgqQn4XLg78A1Nity2kERaZrC5/SMw87GHjFHuqCCvgUKW9R66N RA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d4hqpws7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:34:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BNAWSmb027045;
        Thu, 23 Dec 2021 10:34:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3d16wk5v47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:34:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BNAYlAG40829284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 10:34:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD7EC5204E;
        Thu, 23 Dec 2021 10:34:46 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.95.224])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7EEDE52051;
        Thu, 23 Dec 2021 10:34:45 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     <linux-kernel@vger.kernel.org>, bristot@kernel.org, luto@kernel.org
Subject: [PATCH v2 0/2] Fix check for trace_percpu_buffer validity
Date:   Thu, 23 Dec 2021 16:04:37 +0530
Message-Id: <cover.1640255304.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bJw8_sNPleS0hIBY9MLS_03y7yNX0NS1
X-Proofpoint-GUID: bJw8_sNPleS0hIBY9MLS_03y7yNX0NS1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_03,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=506 clxscore=1015 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes how we check for validity of trace_percpu_buffer, 
fixing a kernel oops seen on ppc64le with the new osnoise tracer. The 
second patch is new in v2 and carries the change to tag the pointer as a 
percpu pointer.

v1: 
http://lkml.kernel.org/r/20211221162529.1480652-1-naveen.n.rao@linux.vnet.ibm.com

- Naveen


Naveen N. Rao (2):
  trace: Fix check for trace_percpu_buffer validity in get_trace_buf()
  trace: Tag trace_percpu_buffer as a percpu pointer

 kernel/trace/trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: f7f0bb5eaecb1aff9cc8ab13425d43690b71ec44
-- 
2.34.1

