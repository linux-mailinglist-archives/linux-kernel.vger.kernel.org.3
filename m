Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F345A481173
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhL2J4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:56:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235190AbhL2J4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:56:31 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BT76LHo030283;
        Wed, 29 Dec 2021 09:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=96W0fNS6ajaqvEhT1RajwJWIZ5b5cHjZb+f0E1ry6tM=;
 b=QCn41uXm7WX01Gc/rUpVm37QWHCu3lms3W1q0gyv3VuSBsiWeyFiBCFSlHG7bsfkt41M
 RsTJyhLrtuuqCR/23eSFmtGaCKl5TUiCBc+0DaUKSRI9GQDWoxhSvASvsgZTcU7altsX
 fA4YZRA3Q2aNMkkp/c6i300LytOQ6dLjk7VydfggEeW+E5s1YFlqA2caX+3KjVysKLrw
 8iJ4qeuW1M+ML9JQgiSHTAMvxAsXCBSNi7ue9o4O8yCHjZmP7O0PwbGyPTpIQgicWXOY
 aEWKHqsgNc84o/ys7b9o6LBNRPCJp1HNA6B6ClKqIOxNMu1KBLVnnsRvHR9I48j9PUsO QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7xdusqgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 09:56:27 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BT9kBVm025408;
        Wed, 29 Dec 2021 09:56:27 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7xdusqg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 09:56:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BT9r4cn018095;
        Wed, 29 Dec 2021 09:56:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3d5tx9nmq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 09:56:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BT9uL7r30605760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Dec 2021 09:56:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A15E4C04E;
        Wed, 29 Dec 2021 09:56:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0660F4C044;
        Wed, 29 Dec 2021 09:56:21 +0000 (GMT)
Received: from osiris (unknown [9.145.91.143])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Dec 2021 09:56:20 +0000 (GMT)
Date:   Wed, 29 Dec 2021 10:56:19 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 update for 5.16-rc8
Message-ID: <Ycwww97WDmQW9Oqa@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v3wb39H3yy3A8RF6qRiBfarx9tCcmzMT
X-Proofpoint-ORIG-GUID: 7FE-bCuHigUENdkAzS8wXngHggS1_hnn
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-29_03,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112290051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single commit which fixes a typo which sneaked in with
the previous s390 pull request.

Thanks,
Heiko

The following changes since commit 85bf17b28f97ca2749968d8786dc423db320d9c2:

  recordmcount.pl: look for jgnop instruction as well as bcrl on s390 (2021-12-12 18:52:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-6

for you to fetch changes up to 4eb1782eaa9fa1c224ad1fa0d13a9f09c3ab2d80:

  recordmcount.pl: fix typo in s390 mcount regex (2021-12-24 10:20:12 +0100)

----------------------------------------------------------------
s390 update for 5.16-rc8

- fix s390 mcount regex typo in recordmcount.pl

----------------------------------------------------------------
Heiko Carstens (1):
      recordmcount.pl: fix typo in s390 mcount regex

 scripts/recordmcount.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 52a000b057a5..3ccb2c70add4 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "s390" && $bits == 64) {
     if ($cc =~ /-DCC_USING_HOTPATCH/) {
-	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
+	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(brcl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
 	$mcount_adjust = 0;
     }
     $alignment = 8;
