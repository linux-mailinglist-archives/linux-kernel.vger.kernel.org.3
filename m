Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677DE4DD87D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiCRKzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiCRKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:55:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789B173377
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:53:56 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22I7G6FI011425;
        Fri, 18 Mar 2022 10:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1DOyL1esRamQ09XaHORjhYt3CSEvg1N2aBpD4KZxnuY=;
 b=CGMm5YOdXkiuG10qs2HclE7ytzFjVCc2+lZYB4BQKNmp9x3XW+kTM6Nf/0uYs+RK/Zf3
 YXUdnSKOQDZlUUtAIX27PYF1kseDmh9gMi8Jw1tZmbLcNild8/YgLIbYoNm1iPFg0QFk
 +gYVb//yvbAbdPzRC3/ob0KBWGljSCPEvv62UggC3OckWxr+utsuEDPS0QYdzaJYzLa/
 ol4H32qURkws6v4tHj4j6mH3Z9NAqfuccfF+ybB6uxq/Ts2517Be5XSkDB3Q2kUsbBIk
 fE5whGa1nbnl38r8ubrbPpjo9fIy1c63a4PbTtce2atqQMnaeOzkR43iN91wb85NepHA cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev2s51p4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 10:53:27 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22IArQWd018221;
        Fri, 18 Mar 2022 10:53:26 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev2s51p4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 10:53:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22IArOXa024786;
        Fri, 18 Mar 2022 10:53:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3erk58ubwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 10:53:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22IArLNW35586324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 10:53:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B687342042;
        Fri, 18 Mar 2022 10:53:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7322F42045;
        Fri, 18 Mar 2022 10:53:18 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.86.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Mar 2022 10:53:18 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        rostedt@goodmis.org, naveen.n.rao@linux.vnet.ibm.com,
        sv@linux.ibm.com
Subject: [RFC PATCH 0/3] objtool: Add mcount sub-command
Date:   Fri, 18 Mar 2022 16:21:37 +0530
Message-Id: <20220318105140.43914-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AqETGOV8H98pyxLq8bKAOf0dX5GmwU0C
X-Proofpoint-GUID: e5slvh2lRhBHs3PT7uH9zEe7iJieddNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_08,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=776 suspectscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to implement 'objtool mcount' command.

Right now, objtool is built if CONFIG_STACK_VALIDATION is enabled.
And, '__mcount_loc' section is generated by objtool when --mcount 
option is passed to check sub-command. 

For architectures to be able to generate '__mcount_loc' section
without having to do stack validation, introduce 'mcount' as
a sub-command to objtool. This way, objtool is built for mcount 
if CONFIG_FTRACE_MCOUNT_USE_OBJTOOL is enabled. Additionally, 
architectures can select HAVE_NOP_MCOUNT to be able to nop out
mcount call sites.  

TODO: Enable "objtool mcount" for clang LTO builds.

Sathvika Vasireddy (3):
  objtool: Move common code to utils.c
  objtool: Enable and implement 'mcount' subcommand
  objtool/mcount: Add powerpc specific functions

 Makefile                                      |   6 +
 arch/powerpc/Kconfig                          |   1 +
 arch/x86/Kconfig                              |   3 +-
 scripts/Makefile.build                        |  12 +
 tools/objtool/Build                           |   3 +
 tools/objtool/Makefile                        |   8 +-
 tools/objtool/arch/powerpc/Build              |   1 +
 tools/objtool/arch/powerpc/decode.c           |  51 +++++
 .../arch/powerpc/include/arch/cfi_regs.h      |  37 +++
 tools/objtool/arch/powerpc/include/arch/elf.h |   8 +
 tools/objtool/builtin-mcount.c                |  74 ++++++
 tools/objtool/check.c                         | 178 +--------------
 tools/objtool/include/objtool/builtin.h       |   4 +-
 tools/objtool/include/objtool/check.h         |   2 -
 tools/objtool/include/objtool/objtool.h       |   1 +
 tools/objtool/include/objtool/utils.h         |  28 +++
 tools/objtool/mcount.c                        | 138 ++++++++++++
 tools/objtool/objtool.c                       |   1 +
 tools/objtool/orc_gen.c                       |   1 +
 tools/objtool/utils.c                         | 210 ++++++++++++++++++
 tools/objtool/weak.c                          |   5 +
 21 files changed, 590 insertions(+), 182 deletions(-)
 create mode 100644 tools/objtool/arch/powerpc/Build
 create mode 100644 tools/objtool/arch/powerpc/decode.c
 create mode 100644 tools/objtool/arch/powerpc/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/elf.h
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/include/objtool/utils.h
 create mode 100644 tools/objtool/mcount.c
 create mode 100644 tools/objtool/utils.c

-- 
2.31.1

