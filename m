Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852C34DAC52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354466AbiCPIS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiCPISz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:18:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9888563515;
        Wed, 16 Mar 2022 01:17:41 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G87w5i005797;
        Wed, 16 Mar 2022 08:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=pp1; bh=3jOmHKD2ZZcxiCZiF0fzeQBKDauGBqWVWvYwJqZZSJQ=;
 b=dAFODFOzBd9idu66liLd2X49WDH6OELg//xPs6eEWLzXy5ceS9fLP/eZD9d4SJXs70hA
 LxdpJyWLjqn44V+yso5r5drtgEessLCf6eq7PB1zkiyEQU0xsBFMddJpceGkFu+o8/os
 GUojKCIZYOU2iX4Ua4DVw/hFWGO9yZHrVF7tmtML96syQZ6NfhY+WtlzJsFaGf5BVZja
 93X+fjQ4hGC17eaIcsqw/bzEZ5Aw4vcew0/69boRDft5ok1zGUhykJ5/T+MFtN6HZK+o
 u0xIcrMtHb1yZpvCntg6SU6ft8uDsaQkynRri6CjKWAaRcnqCk0BkObcevSQ212uqph4 2A== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eubv18csr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 08:17:37 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22G8DJlS026349;
        Wed, 16 Mar 2022 08:17:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3erjshq894-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 08:17:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22G8HXYx45154750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 08:17:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C9EC11C058;
        Wed, 16 Mar 2022 08:17:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 007D411C04A;
        Wed, 16 Mar 2022 08:17:32 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.79.177.2])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Mar 2022 08:17:31 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: [powerpc]Kernel crash while running LTP (execveat03) [next-20220315]
Message-Id: <19C0AAEE-43C1-4A17-83DC-5EC24BB1E0BE@linux.ibm.com>
Date:   Wed, 16 Mar 2022 13:47:30 +0530
Cc:     linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        riteshh@linux.ibm.com
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zvenb4O0FL7EydkavzDxjv8dnlMQH7oC
X-Proofpoint-GUID: Zvenb4O0FL7EydkavzDxjv8dnlMQH7oC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_02,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP tests(execveat03) against 5.17.0-rc8-next-20220315
On a POWER10 LPAR following crash is seen:

[  945.659049] dummy_del_mod: loading out-of-tree module taints kernel.
[  945.659951] dummy_del_mod: module verification failed: signature =
and/or required key missing - tainting kernel
[  955.520206] process 'execveat01' launched '/dev/fd/-1' with NULL =
argv: empty string added
[  955.529560] loop0: detected capacity change from 0 to 524288
[  955.830492] EXT4-fs (loop0): mounting ext2 file system using the ext4 =
subsystem
[  955.831047] EXT4-fs (loop0): mounted filesystem without journal. =
Quota mode: none.
[  955.831056] ext2 filesystem being mounted at =
/var/tmp/avocado_2hol2hy1/ltp-SHEyyra8b0/3CPNpu/mntpoint supports =
timestamps until 2038 (0x7fffffff)
[  955.907793] Kernel attempted to read user page (1) - exploit attempt? =
(uid: 0)
[  955.907806] BUG: Kernel NULL pointer dereference on read at =
0x00000001
[  955.907809] Faulting instruction address: 0xc008000000be04ec
[  955.907811] Oops: Kernel access of bad area, sig: 11 [#1]
[  955.907814] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA =
pSeries
[  955.907818] Modules linked in: overlay vfat fat btrfs blake2b_generic =
xor raid6_pq zstd_compress xfs loop sctp ip6_udp_tunnel udp_tunnel =
dm_mod nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill =
nf_tables bonding libcrc32c nfnetlink sunrpc pseries_rng xts vmx_crypto =
sch_fq_codel ext4 mbcache jbd2 sd_mod t10_pi crc64_rocksoft crc64 sg =
ibmvscsi ibmveth scsi_transport_srp fuse [last unloaded: dummy_del_mod]
[  955.907849] CPU: 30 PID: 1947255 Comm: execveat03 Tainted: G          =
 OE     5.17.0-rc8-next-20220315 #1
[  955.907853] NIP:  c008000000be04ec LR: c008000000ba4b00 CTR: =
c0000000004fd040
[  955.907856] REGS: c0000002474831a0 TRAP: 0300   Tainted: G           =
OE      (5.17.0-rc8-next-20220315)
[  955.907860] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  =
CR: 28028282  XER: 20040000
[  955.907869] CFAR: c008000000ba4afc DAR: 0000000000000001 DSISR: =
40000000 IRQMASK: 0=20
[  955.907869] GPR00: c008000000ba4b00 c000000247483440 c008000000c28000 =
0000000000000001=20
[  955.907869] GPR04: c000000206668af8 c008000000be0068 0000000000000000 =
0000000000000000=20
[  955.907869] GPR08: 0000000000000002 0000000000000004 0000000000000000 =
c008000000be7f68=20
[  955.907869] GPR12: c0000000004fd040 c000000effbe7280 0000000000000000 =
0000000000000001=20
[  955.907869] GPR16: 0000000000000000 c0000000029b4048 0000000000000000 =
0000000000000000=20
[  955.907869] GPR20: 0000000000000000 c0000000029b4048 0000000000000004 =
c000000206668af8=20
[  955.907869] GPR24: c000000247483528 0000000000000001 c008000000c01208 =
0000000000000000=20
[  955.907869] GPR28: 0000000000000001 c000000206668af8 c0000001f0d92e80 =
0000000000000001=20
[  955.907904] NIP [c008000000be04ec] __ext4_fc_track_link+0x44/0xf0 =
[ext4]
[  955.907927] LR [c008000000ba4b00] ext4_rename+0x878/0xdc0 [ext4]
[  955.907946] Call Trace:
[  955.907947] [c000000247483440] [0000000000000004] 0x4 (unreliable)
[  955.907950] [c0000002474834a0] [c008000000ba4b00] =
ext4_rename+0x878/0xdc0 [ext4]
[  955.907969] [c000000247483670] [c0000000004a498c] =
vfs_rename+0x9cc/0xe00
[  955.907975] [c000000247483760] [c008000000341820] =
ovl_do_rename.constprop.28+0x78/0x140 [overlay]
[  955.907982] [c000000247483830] [c008000000341b50] =
ovl_make_workdir+0x268/0x7e0 [overlay]
[  955.907988] [c000000247483960] [c008000000343aa8] =
ovl_fill_super+0x1060/0x2160 [overlay]
[  955.907994] [c000000247483ae0] [c000000000492f68] =
mount_nodev+0x78/0x100
[  955.907998] [c000000247483b20] [c008000000340054] ovl_mount+0x2c/0x50 =
[overlay]
[  955.908004] [c000000247483b40] [c0000000004f676c] =
legacy_get_tree+0x4c/0xb0
[  955.908008] [c000000247483b70] [c00000000049063c] =
vfs_get_tree+0x4c/0x150
[  955.908012] [c000000247483bf0] [c0000000004d3768] =
path_mount+0x8e8/0xd50
[  955.908017] [c000000247483cb0] [c0000000004d3c50] do_mount+0x80/0xd0
[  955.908021] [c000000247483d10] [c0000000004d3e3c] =
sys_mount+0x19c/0x370
[  955.908025] [c000000247483db0] [c00000000003375c] =
system_call_exception+0x18c/0x390
[  955.908029] [c000000247483e10] [c00000000000c64c] =
system_call_common+0xec/0x270
[  955.908034] --- interrupt: c00 at 0x7fffa9b38dfc
[  955.908036] NIP:  00007fffa9b38dfc LR: 000000001001ba78 CTR: =
0000000000000000
[  955.908039] REGS: c000000247483e80 TRAP: 0c00   Tainted: G           =
OE      (5.17.0-rc8-next-20220315)
[  955.908042] MSR:  800000000280f033 =
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24002202  XER: 00000000
[  955.908050] IRQMASK: 0=20
[  955.908050] GPR00: 0000000000000015 00007ffff95c64c0 00007fffa9c07300 =
0000000010029a08=20
[  955.908050] GPR04: 0000000010027de0 0000000010029a08 0000000000000000 =
00000000100299c0=20
[  955.908050] GPR08: 0000000000004000 0000000000000000 0000000000000000 =
0000000000000000=20
[  955.908050] GPR12: 0000000000000000 00007fffa9e1a340 0000000000000000 =
0000000000000000=20
[  955.908050] GPR16: 0000000000000000 0000000000000000 ffffffffffffffff =
0000000010027a38=20
[  955.908050] GPR20: 00000000100284d0 0000000010028238 00000000100280f8 =
00007ffff95c65b0=20
[  955.908050] GPR24: 0000000000000003 0000000010051098 0000000010050c60 =
00000000100555c8=20
[  955.908050] GPR28: 000000000000040c 0000000010027b08 0000000000000000 =
0000000000000001=20
[  955.908083] NIP [00007fffa9b38dfc] 0x7fffa9b38dfc
[  955.908086] LR [000000001001ba78] 0x1001ba78
[  955.908090] --- interrupt: c00
[  955.908092] Instruction dump:
[  955.908095] fba1ffe8 fbc1fff0 7cbe2b78 fbe1fff8 3ca20000 e8a5a0c8 =
7c7f1b78 39200004=20
[  955.908103] 38e00000 7c9d2378 f8010010 f821ffa1 <e8630000> 38c10028 =
e94d1100 f9410038=20
[  955.908112] ---[ end trace 0000000000000000 ]---
[  955.908943]=20
[  956.908946] Kernel panic - not syncing: Fatal exception

Bisect points to following commit:
commit 9d5623d7ef8765f21f629e4ac636c19ec245e254
    ext4: return early for non-eligible fast_commit track events

Reverting this commit allows the test to run successfully.

Thanks
-Sachin

