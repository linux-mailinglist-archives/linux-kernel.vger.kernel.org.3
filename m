Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788DC531C67
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiEWStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbiEWStC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:49:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEB7FD373
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:33:57 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NH3MNK013513;
        Mon, 23 May 2022 17:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xA+n5KuvnS1mmwKufHJ2VRnPKjS5ifUNWGp8AErsg04=;
 b=dfQhiHm7XbJMQjzeikIgXM0Jj3ArCA2IFbg5cuxjGgK7z5Xc4FikWOwQbs0sxdxg7lI1
 /K8K/qlWMGUOgpj6TdZ64ADd78iHzPUZgoFQxjB1mCvc/a2SS2Wv2USzsvCvK2ji0OGf
 wDjDUYeD7mgo4LPrgKxmKhB39DnsYfSh2LEY7Y5p+ipjSLB43dFOkTP5WKZZ9XKXVCXF
 hzioc7iXGmOEIvCqOvRQvyVqqxaCv/JI/EENd2+/NcsVxqlEZ9zyNvQ+136oRoeZ5Z9I
 XCWjXhM+nAe4+ZV1/TVIVCQ14IYhhuS/Sw+RdaESxqOvVL4Wfgqs473VLQZPLCGOrQDw yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8eb3rxaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:01 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24NHh26X004994;
        Mon, 23 May 2022 17:56:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8eb3rxa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24NHg8B6015068;
        Mon, 23 May 2022 17:55:59 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3g6qbjb6rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:55:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24NHtu8S49873212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 17:55:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 726205204F;
        Mon, 23 May 2022 17:55:56 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.16.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 723A45204E;
        Mon, 23 May 2022 17:55:53 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, mbenes@suse.cz, aik@ozlabs.ru,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        rostedt@goodmis.org, naveen.n.rao@linux.vnet.ibm.com,
        sv@linux.ibm.com
Subject: [RFC PATCH 0/4] objtool: Enable and implement --mcount option on powerpc
Date:   Mon, 23 May 2022 23:25:44 +0530
Message-Id: <20220523175548.922671-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dbzbUcjglD0wgs08Lkd6cMUdgT_QV4eW
X-Proofpoint-ORIG-GUID: JMYLGJ1AjAqcPy-3KSDSAe5fWDkJrL2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 bulkscore=0 impostorscore=0
 clxscore=1011 mlxscore=1 spamscore=1 malwarescore=0 lowpriorityscore=0
 mlxlogscore=226 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are rebased on top of objtool/core
branch of the tip tree, and work only on ppc64le
for now. 

Note: With this patch set, there are still some 
warnings seen with ppc64le kernel build.

Sathvika Vasireddy (4):
  objtool: Add --mnop as an option to --mcount
  objtool: Enable objtool to run only on files with ftrace enabled
  objtool/powerpc: Enable objtool to be built on ppc
  objtool/powerpc: Add --mcount specific implementation

 Makefile                                      |  4 +-
 arch/powerpc/Kconfig                          |  2 +
 arch/x86/Kconfig                              |  1 +
 scripts/Makefile.build                        |  5 +-
 tools/objtool/arch/powerpc/Build              |  2 +
 tools/objtool/arch/powerpc/decode.c           | 87 +++++++++++++++++++
 .../arch/powerpc/include/arch/cfi_regs.h      | 11 +++
 tools/objtool/arch/powerpc/include/arch/elf.h |  8 ++
 .../arch/powerpc/include/arch/endianness.h    |  9 ++
 .../arch/powerpc/include/arch/special.h       | 21 +++++
 tools/objtool/arch/powerpc/special.c          | 19 ++++
 tools/objtool/builtin-check.c                 | 14 +++
 tools/objtool/check.c                         | 31 ++++---
 tools/objtool/elf.c                           | 13 +++
 tools/objtool/include/objtool/builtin.h       |  1 +
 tools/objtool/include/objtool/elf.h           |  1 +
 16 files changed, 212 insertions(+), 17 deletions(-)
 create mode 100644 tools/objtool/arch/powerpc/Build
 create mode 100644 tools/objtool/arch/powerpc/decode.c
 create mode 100644 tools/objtool/arch/powerpc/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/elf.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/special.h
 create mode 100644 tools/objtool/arch/powerpc/special.c

-- 
2.25.1

