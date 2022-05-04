Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15A051B091
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378590AbiEDVbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347126AbiEDVba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:31:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AD75131E;
        Wed,  4 May 2022 14:27:52 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244JMSOl005392;
        Wed, 4 May 2022 21:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uG2cuZvxA/+CYu9Mwm0/55GfutEUGI00AFnLdQHDLcc=;
 b=Za+bFClkcZI6+yLno4HDgZMEnNPExsuK2xIkJVJMWr6BZ3UN/P/9rU3dmqOWGiayfx+P
 maTx9BVPz6n7K31lUE8vU9bZ6xXRHIPdDkx6f4NNcoz8vP5QAJhXd/tbvJVR06pDDTj8
 /k8ARufXGbYpaYDsuKtJDDG/rl3R1+2iijiXuHMpSzMNePc/rd/5bb+UwohhwqXtLqCk
 rsljVm7B3o9l/4tkHLUAVinnzwohulQmzO1+saYrJp3YdUKxQaECcWKfdZ7ghWd8Tvvd
 XxDvL4cqfASxfmAKHsr67LMvMsuQlWcRHU/Qs4iAe+YyhfrlB2kmdou6w/b1q//7Q9y2 ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fuyka24td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 21:27:42 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 244L6JOi009223;
        Wed, 4 May 2022 21:27:41 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fuyka24t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 21:27:41 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 244KqPXe023256;
        Wed, 4 May 2022 21:27:41 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3frvra5bep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 21:27:41 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 244LReit15663456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 21:27:40 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55C90BE053;
        Wed,  4 May 2022 21:27:40 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35851BE054;
        Wed,  4 May 2022 21:27:39 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.160.71.212])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with SMTP;
        Wed,  4 May 2022 21:27:38 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
        id B858A1DF790; Wed,  4 May 2022 16:27:36 -0500 (CDT)
From:   Reza Arbab <arbab@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/prune-kernel: Use kernel-install if available
Date:   Wed,  4 May 2022 16:27:14 -0500
Message-Id: <20220504212714.152837-1-arbab@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UVRWZzirs79AQa0aZQdoRcca5gsIKBU4
X-Proofpoint-ORIG-GUID: TbXZe023WkTytbhFasi6BMGrRz4UO_-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_05,2022-05-04_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 impostorscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=844 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the new-kernel-pkg utility isn't present, try using kernel-install.
This is what the %preun scriptlet in scripts/package/mkspec does too.

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
Hope I've sent this to the right people. get_maintainer.pl came up
blank, but kbuild seems like the nearest match in MAINTAINERS.

 scripts/prune-kernel | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/prune-kernel b/scripts/prune-kernel
index e8aa940bc0a9..dadfd0e47f89 100755
--- a/scripts/prune-kernel
+++ b/scripts/prune-kernel
@@ -16,6 +16,10 @@ do
                 rm -f "/boot/initramfs-$f.img" "/boot/System.map-$f"
                 rm -f "/boot/vmlinuz-$f"   "/boot/config-$f"
                 rm -rf "/lib/modules/$f"
-                new-kernel-pkg --remove $f
+                if [ -x "$(command -v new-kernel-pkg)" ]; then
+                        new-kernel-pkg --remove $f
+                elif [ -x "$(command -v kernel-install)" ]; then
+                        kernel-install remove $f
+                fi
         fi
 done
--=20
2.27.0

