Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71043524EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354632AbiELNr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354613AbiELNrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:47:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1B6338A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:47:50 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CBkjiJ030322;
        Thu, 12 May 2022 13:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=pp1; bh=CUA0frPoF0/nc1dDkE91XYGHp+xOIvfTj5F2uyhjx0k=;
 b=aH+iBPSItyF+hVDoUxk3sJw/X45YFjbSiHb7Qe69wlRB4vVTcTJSOpsCrtsi4TbeCRyB
 6JMX+g+rzSxsY9l3/lDveCRNvsi7L+xp2bGtoev4WQIjjrzR2aIOYFpiPc9oFDc5KQZB
 1voDsJW377/U/fTWMB27OFnLfZunZVXwm9Pio8uaXo4FxrFZ6L2F+tKBWlzvgyBxUguL
 YHtR/wCmeJEUoQ+xbc+AAWcgp3Mqx84mlhGxnYDXm0x95ZbQi91SzALjTUzR3QpL20Y2
 EJ/qie1uSil6+G+YVaggv/thnHX4/1nnN8NpUxabCbEF35tVo5C6GnGlUV7BTn+Pz+XP 3g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g11nqb1xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 13:47:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CDd9bf004529;
        Thu, 12 May 2022 13:47:41 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fwgd8wj0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 13:47:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CDlcgm50069894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 13:47:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8F475204F;
        Thu, 12 May 2022 13:47:38 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.93.71])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BCD3E5204E;
        Thu, 12 May 2022 13:47:37 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: [powerpc] kernel BUG at mm/mmap.c:3233! with ltp/mmapstress03
Message-Id: <9FFA19ED-06DE-498B-924B-9233C1FCDEC5@linux.ibm.com>
Date:   Thu, 12 May 2022 19:17:36 +0530
Cc:     open list <linux-kernel@vger.kernel.org>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@Oracle.com>
To:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oK95Tf17x4VIoJ4AsUlICwkBhakNF2Zd
X-Proofpoint-GUID: oK95Tf17x4VIoJ4AsUlICwkBhakNF2Zd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_10,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=738 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP test mmapstress03 on a Power10 LPAR running
5.18.0-rc6-next-20220512 following kernel bug was seen

[  944.492475] mmap: mmapstress03 (1919217): VmData 18446744073706799104 =
exceed data ulimit 18446744073709551615. Update limits or use boot =
option ignore_rlimit_data.
[  944.492511] ------------[ cut here ]------------
[  944.492512] kernel BUG at mm/mmap.c:3233!
[  944.492514] Oops: Exception in kernel mode, sig: 5 [#1]
[  944.492529] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA =
pSeries
[  944.492533] Modules linked in: dm_mod(E) nft_fib_inet(E) =
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) =
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) =
nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) =
nf_defrag_ipv4(E) rfkill(E) ip_set(E) bonding(E) nf_tables(E) tls(E) =
libcrc32c(E) nfnetlink(E) sunrpc(E) pseries_rng(E) vmx_crypto(E) ext4(E) =
mbcache(E) jbd2(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) sg(E) =
ibmvscsi(E) scsi_transport_srp(E) ibmveth(E) fuse(E)
[  944.492571] CPU: 5 PID: 1919217 Comm: mmapstress03 Tainted: G   M     =
   E     5.18.0-rc6-next-20220512 #1
[  944.492576] NIP:  c00000000047e450 LR: c00000000047e434 CTR: =
c000000000478e60
[  944.492579] REGS: c000000086dcb880 TRAP: 0700   Tainted: G   M        =
E      (5.18.0-rc6-next-20220512)
[  944.492583] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: =
22002484  XER: 00000000
[  944.492590] CFAR: c000000000837a2c IRQMASK: 0=20
[  944.492590] GPR00: c00000000047e434 c000000086dcbb20 c000000002a7f100 =
0000000000000000=20
[  944.492590] GPR04: 0000000000000000 ffffffffffffffff 000000000000000f =
0000000000000000=20
[  944.492590] GPR08: ffffffffffffffff 0000000000000001 000000000000000e =
0000000000000008=20
[  944.492590] GPR12: 0000000000000008 c000000effff7f00 0000000000000000 =
0000000000000000=20
[  944.492590] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[  944.492590] GPR20: 0000000000000000 00007fffb8a04ee0 0000000000000001 =
0000000000000001=20
[  944.492590] GPR24: 0000000000000000 00007fffb8c32bd0 0000000000000000 =
c000000021003c60=20
[  944.492590] GPR28: 000000000000000c c000000021003c00 0000000000000001 =
0000000000000000=20
[  944.492629] NIP [c00000000047e450] exit_mmap+0x190/0x380
[  944.492635] LR [c00000000047e434] exit_mmap+0x174/0x380
[  944.492638] Call Trace:
[  944.492639] [c000000086dcbb20] [c00000000047e434] =
exit_mmap+0x174/0x380 (unreliable)
[  944.492644] [c000000086dcbc40] [c000000000152990] mmput+0xb0/0x240
[  944.492650] [c000000086dcbc80] [c000000000160390] do_exit+0x370/0xc30
[  944.492653] [c000000086dcbd50] [c000000000160dfc] =
do_group_exit+0x4c/0xe0
[  944.492658] [c000000086dcbd90] [c000000000160eb4] =
sys_exit_group+0x24/0x30
[  944.492661] [c000000086dcbdb0] [c0000000000336bc] =
system_call_exception+0x17c/0x350
[  944.492666] [c000000086dcbe10] [c00000000000c53c] =
system_call_common+0xec/0x270
[  944.492671] --- interrupt: c00 at 0x7fffb88f318c
[  944.492675] NIP:  00007fffb88f318c LR: 00007fffb884cf24 CTR: =
0000000000000000
[  944.492678] REGS: c000000086dcbe80 TRAP: 0c00   Tainted: G   M        =
E      (5.18.0-rc6-next-20220512)
[  944.492681] MSR:  800000000280f033 =
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 22000202  XER: 00000000
[  944.492690] IRQMASK: 0=20
[  944.492690] GPR00: 00000000000000ea 00007fffc61d2de0 00007fffb8a07300 =
0000000000000001=20
[  944.492690] GPR04: 0000000000000000 000000002e5b02a0 0000000000000000 =
00007fffb8c32bd0=20
[  944.492690] GPR08: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[  944.492690] GPR12: 0000000000000000 00007fffb8c3a340 0000000000000000 =
0000000000000000=20
[  944.492690] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[  944.492690] GPR20: 0000000000000000 00007fffb8a04ee0 0000000000000001 =
0000000000000001=20
[  944.492690] GPR24: 00007fffb8a008a0 0000000000000000 0000000000000001 =
0000000000000001=20
[  944.492690] GPR28: 0000000000000000 0000000000000000 00007fffb8c33350 =
0000000000000001=20
[  944.492725] NIP [00007fffb88f318c] 0x7fffb88f318c
[  944.492728] LR [00007fffb884cf24] 0x7fffb884cf24
[  944.492730] --- interrupt: c00
[  944.492732] Instruction dump:
[  944.492734] 48a29539 60000000 3880ffff 38610020 483c0bc9 60000000 =
7c7f1b79 4082ffb4=20
[  944.492741] 815d0058 39200001 7f8af000 7fc04f9e <0b1e0000> 60000000 =
7fa3eb78 483b916d=20
[  944.492748] ---[ end trace 0000000000000000 ]---
[  944.493479]=20
[  945.493481] Kernel panic - not syncing: Fatal exception

The BUG_ON was introduced by following commit with next-20220511
commit 369a899d3aff (mm: remove the vma linked list)

- Sachin


