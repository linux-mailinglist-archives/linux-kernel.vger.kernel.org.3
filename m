Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7A4B548D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353713AbiBNPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:22:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiBNPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:22:41 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF84755A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:22:33 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EEkjcG021937
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=pp1;
 bh=3aphYakjmcpQXotkxCMLCxg2sdHVdbaI3eZVZ2wiTh8=;
 b=hNm7uqzDVDhsqM80ho8kng4JtRq8LSy3Fle77qyThGbOPyFGSNhag29mkj3kWqRaDbU3
 cMpV+RwG+adWSxGdUDINyfbf5x5Qh96jJ4qDG30EUoBfUejK2x3/bmBxmkgBWKlekbHe
 RM0Hd393b8suHhXXxRLEhFT3wcvDkTNy+yBn4gZH+QWFAZgco+ERCpuF2m/32OWmoy7p
 7UCC0dDKK8nYvE1+X5N8aHQxfvg0ZNz1CryfE1nBVLhYqTzhdjgBRkMrzYY3KgVIY5yE
 E0nUuorv/30bEEA66E7mYt6BcmpdMAPp0/E/ZJs1iPwJ/e6hIHmwlpbJxgMYQdPYyK8p yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e779vnnwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:22:32 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EEI0Og007164
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:22:32 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e779vnnvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 15:22:32 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EFCtil020527;
        Mon, 14 Feb 2022 15:22:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3e645jdwqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 15:22:30 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EFMSFH15335686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 15:22:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2A3A11C058;
        Mon, 14 Feb 2022 15:22:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF03411C05E;
        Mon, 14 Feb 2022 15:22:27 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Feb 2022 15:22:27 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: circular locking splat in fs/proc/vmcore.c
Date:   Mon, 14 Feb 2022 16:22:27 +0100
Message-ID: <yt9dee4579sc.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pe6i70sQuEGVSsEcfpJ8dRm0KSLy7G3-
X-Proofpoint-ORIG-GUID: JI2sbUa4mkE65TQrQ9M8FAvlIF_6HTbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_06,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=983 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

i've seen the following lockdep splat in CI on one of our systems:

[   25.964518] kdump[727]: saving vmcore-dmesg.txt complete
[   26.049877]
[   26.049879] ======================================================
[   26.049881] WARNING: possible circular locking dependency detected
[   26.049883] 5.17.0-20220211.rc3.git2.2636bbc7cadf.300.fc35.s390x+debug #1 Tainted: G        W
[   26.049885] ------------------------------------------------------
[   26.049886] makedumpfile/730 is trying to acquire lock:
[   26.049887] 0000000001a25720 (vmcore_cb_rwsem){.+.+}-{3:3}, at: mmap_vmcore+0x148/0x458
[   26.049896]
[   26.049896] but task is already holding lock:
[   26.049897] 0000000013539d28 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x8e/0x170
[   26.049904]
[   26.049904] which lock already depends on the new lock.
[   26.049904]
[   26.049906]
[   26.049906] the existing dependency chain (in reverse order) is:
[   26.049907]
[   26.049907] -> #1 (&mm->mmap_lock){++++}-{3:3}:
[   26.049910]        __lock_acquire+0x604/0xbd8
[   26.049914]        lock_acquire.part.0+0xe2/0x250
[   26.049916]        lock_acquire+0xb0/0x200
[   26.049918]        __might_fault+0x70/0xa0
[   26.049921]        copy_to_user_real+0x8e/0xf8
[   26.049925]        copy_oldmem_page+0xc0/0x158
[   26.049930]        read_from_oldmem.part.0+0x14c/0x1b8
[   26.049932]        __read_vmcore+0x116/0x1f8
[   26.049933]        proc_reg_read+0x9a/0xf0
[   26.049938]        vfs_read+0x94/0x1a8
[   25.973256] kdump[729]: saving vmcore
[   26.049941]        __s390x_sys_pread64+0x90/0xc8
[   26.049958]        __do_syscall+0x1da/0x208
[   26.049963]        system_call+0x82/0xb0
[   26.049967]
[   26.049967] -> #0 (vmcore_cb_rwsem){.+.+}-{3:3}:
[   26.049971]        check_prev_add+0xe0/0xed8
[   26.049972]        validate_chain+0x736/0xb20
[   26.049974]        __lock_acquire+0x604/0xbd8
[   26.049976]        lock_acquire.part.0+0xe2/0x250
[   26.049978]        lock_acquire+0xb0/0x200
[   26.049980]        down_read+0x5e/0x180
[   26.049982]        mmap_vmcore+0x148/0x458
[   26.049983]        proc_reg_mmap+0x8e/0xe0
[   26.049985]        mmap_region+0x412/0x668
[   26.049988]        do_mmap+0x3ec/0x4d0
[   26.049989]        vm_mmap_pgoff+0xd4/0x170
[   26.049992]        ksys_mmap_pgoff+0x1d8/0x228
[   26.049994]        __s390x_sys_old_mmap+0xa4/0xb8
[   26.049995]        __do_syscall+0x1da/0x208
[   26.049997]        system_call+0x82/0xb0
[   26.049999]
[   26.049999] other info that might help us debug this:
[   26.049999]
[   26.050001]  Possible unsafe locking scenario:
[   26.050001]
[   26.050002]        CPU0                    CPU1
[   26.050003]        ----                    ----
[   26.050004]   lock(&mm->mmap_lock);
[   26.050006]                                lock(vmcore_cb_rwsem);
[   26.050008]                                lock(&mm->mmap_lock);
[   26.050010]   lock(vmcore_cb_rwsem);
[   26.050012]
[   26.050012]  *** DEADLOCK ***
[   26.050012]
[   26.050013] 1 lock held by makedumpfile/730:
[   26.050015]  #0: 0000000013539d28 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x8e/0x170

I think this was introduced with cc5f2704c934 ("proc/vmcore: convert
oldmem_pfn_is_ram callback to more generic vmcore callbacks")

One fix might be to move the vmcore_cb_rwsem into the loop around the
pfn_is_ram(). But this would likely slow down things. So the diff would
look like: (UNTESTED)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 702754dd1daf..4acd91507d21 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -133,6 +133,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 	unsigned long pfn, offset;
 	size_t nr_bytes;
 	ssize_t read = 0, tmp;
+	int is_ram;
 
 	if (!count)
 		return 0;
@@ -140,7 +141,6 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 	offset = (unsigned long)(*ppos % PAGE_SIZE);
 	pfn = (unsigned long)(*ppos / PAGE_SIZE);
 
-	down_read(&vmcore_cb_rwsem);
 	do {
 		if (count > (PAGE_SIZE - offset))
 			nr_bytes = PAGE_SIZE - offset;
@@ -148,7 +148,10 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 			nr_bytes = count;
 
 		/* If pfn is not ram, return zeros for sparse dump files */
-		if (!pfn_is_ram(pfn)) {
+		down_read(&vmcore_cb_rwsem);
+		is_ram = pfn_is_ram(pfn);
+		up_read(&vmcore_cb_rwsem);
+		if (!is_ram) {
 			tmp = 0;
 			if (!userbuf)
 				memset(buf, 0, nr_bytes);
@@ -164,10 +167,8 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
 						       offset, userbuf);
 		}
-		if (tmp < 0) {
-			up_read(&vmcore_cb_rwsem);
+		if (tmp < 0)
 			return tmp;
-		}
 
 		*ppos += nr_bytes;
 		count -= nr_bytes;
@@ -177,7 +178,6 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 		offset = 0;
 	} while (count);
 
-	up_read(&vmcore_cb_rwsem);
 	return read;
 }
 
I think we could also switch the list to an rcu protected list, but i
don't know the code really. Any opinions how to fix this?

Thanks
Sven
