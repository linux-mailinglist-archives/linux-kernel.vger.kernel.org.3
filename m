Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A7E596B60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiHQIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiHQIam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:30:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1717D1EF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:30:40 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H8FC1M000844;
        Wed, 17 Aug 2022 08:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=7ysuBdFEmYms22UqszBVWWsW/BOt+YuzTKdNrP5Aofs=;
 b=M3zTrCT2ZE49Jwhe5iE5teinKUyjGi14M/1lvQZpw3Tv79/Qr/3cBXbcO6byMSB5UKNH
 DY+VSuOtqnAaQLOoUP7aP9qAzkBD75blJU1UeCg1gr8VziXVPjFTyIB/iguD+4aPGNmq
 3A9fSM5y5R/1bmISVTCkqpTP9vcI5kHMLGcdIX5IRRRI8lFwFfjMIcdBOGNz2LdrnB0g
 JgUthaevNjmIspSeDI/x3I6U/NFOZHYHZeCPOxo7HZxgF6R2VL/CpIsHhrUcSV0YzolP
 /wx268ZqNUwKHPvmZjiioPFPp5XTs7HkPp+QGIx/FR+qDM8g2ZY24IQwrwio0FAMXN1s vQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0vn98cwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 08:30:34 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27H8M3OI008092;
        Wed, 17 Aug 2022 08:30:33 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3hx3kan2kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 08:30:33 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27H8UW3G15270540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 08:30:32 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7369EC6055;
        Wed, 17 Aug 2022 08:30:32 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B408EC605B;
        Wed, 17 Aug 2022 08:30:29 +0000 (GMT)
Received: from [9.43.68.94] (unknown [9.43.68.94])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 17 Aug 2022 08:30:29 +0000 (GMT)
Message-ID: <f65d7074-48f4-a25e-0dfc-424910f0b48d@linux.vnet.ibm.com>
Date:   Wed, 17 Aug 2022 14:00:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     aik@ozlabs.ru, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc:     abdhalee@linux.vnet.ibm.com, mputtash@linux.vnet.com,
        sachinp@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [linux][5.19.0][SRIOV/HNV] WARNING: CPU: 3 PID: 3873 at
 arch/powerpc/kernel/iommu.c:830 iommu_tce_table_put+0x20/0x170
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PCOIdjLKVMeyaHg4pmyeI97vhaQ0VRvp
X-Proofpoint-GUID: PCOIdjLKVMeyaHg4pmyeI97vhaQ0VRvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_05,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=671
 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[linux][5.19.0][SRIOV/HNV] WARNING: CPU: 3 PID: 3873 at 
arch/powerpc/kernel/iommu.c:830 iommu_tce_table_put+0x20/0x170

Continuous WARN_ONs are seen when SRIOV device remove operation is 
performed after adding the SRIOV device

--- Call Traces ---
[  645.034242] ------------[ cut here ]------------
[  645.034247] WARNING: CPU: 3 PID: 3873 at 
arch/powerpc/kernel/iommu.c:830 iommu_tce_table_put+0x20/0x170
[  645.034258] Modules linked in: rpcrdma sunrpc rdma_ucm ib_srpt 
ib_isert iscsi_target_mod target_core_mod ib_iser ib_umad rdma_cm 
ib_ipoib iw_cm libiscsi ib_cm scsi_transport_iscsi mlx5_ib ib_uverbs 
ib_core mlx5_core mlxfw psample ptp pps_core rpadlpar_io rpaphp tcp_diag 
udp_diag inet_diag unix_diag af_packet_diag netlink_diag bonding rfkill 
xts vmx_crypto pseries_rng sch_fq_codel binfmt_misc ip_tables ext4 
mbcache jbd2 dm_service_time sd_mod t10_pi crc64_rocksoft crc64 sg 
ibmvfc scsi_transport_fc ibmveth dm_multipath dm_mirror dm_region_hash 
dm_log dm_mod fuse
[  645.034301] CPU: 3 PID: 3873 Comm: drmgr Not tainted 
5.19.0-autotest-geb555cb5b794 #1
[  645.034305] NIP:  c000000000062380 LR: c0000000000fd9e8 CTR: 
c000000000060720
[  645.034307] REGS: c000000053d87790 TRAP: 0700   Not tainted 
(5.19.0-autotest-geb555cb5b794)
[  645.034311] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
24002244  XER: 20040000
[  645.034320] CFAR: c0000000000fd9e4 IRQMASK: 0
[  645.034320] GPR00: c0000000000fd9e8 c000000053d87a30 c000000002a10700 
0000000000000000
[  645.034320] GPR04: c00c000000036ac0 c00000000dab0830 c00000000dab0830 
0000000000000001
[  645.034320] GPR08: 027ffff000000201 0000000000000001 0000000000000001 
fffffffffffffffd
[  645.034320] GPR12: 0000000000002000 c00000077fff8e80 0000000000000000 
0000000000000000
[  645.034320] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  645.034320] GPR20: 0000000000000000 0000000136dc20f8 0000000136dbee08 
0000000000000006
[  645.034320] GPR24: 0000000000000000 00000001749423fd c000000002970418 
c000000053d87b50
[  645.034320] GPR28: 0000000000000002 0000000000000000 c000000009781500 
c000000054f1a2c0
[  645.034363] NIP [c000000000062380] iommu_tce_table_put+0x20/0x170
[  645.034366] LR [c0000000000fd9e8] iommu_reconfig_notifier+0x98/0x220
[  645.034370] Call Trace:
[  645.034372] [c000000053d87a30] [c0000000659eec00] 0xc0000000659eec00 
(unreliable)
[  645.034376] [c000000053d87aa0] [c0000000000fd9d4] 
iommu_reconfig_notifier+0x84/0x220
[  645.034381] [c000000053d87ae0] [c00000000018e174] 
blocking_notifier_call_chain+0xa4/0x110
[  645.034385] [c000000053d87b30] [c000000000a76f6c] 
of_detach_node+0xbc/0x100
[  645.034389] [c000000053d87b90] [c0000000000f9fc8] ofdt_write+0x898/0x1050
[  645.034393] [c000000053d87c60] [c0000000005656dc] 
proc_reg_write+0x10c/0x1b0
[  645.034398] [c000000053d87c90] [c000000000493cc4] vfs_write+0x104/0x460
[  645.034402] [c000000053d87d50] [c0000000004941fc] ksys_write+0x7c/0x140
[  645.034406] [c000000053d87da0] [c000000000033b88] 
system_call_exception+0x198/0x430
[  645.034410] [c000000053d87e10] [c00000000000c63c] 
system_call_common+0xec/0x250
[  645.034414] --- interrupt: c00 at 0x20002a31bd74
[  645.034417] NIP:  000020002a31bd74 LR: 0000000136da3804 CTR: 
0000000000000000
[  645.034419] REGS: c000000053d87e80 TRAP: 0c00   Not tainted 
(5.19.0-autotest-geb555cb5b794)
[  645.034423] MSR:  800000000200d033 <SF,VEC,EE,PR,ME,IR,DR,RI,LE>  CR: 
24002402  XER: 00000000
[  645.034430] IRQMASK: 0
[  645.034430] GPR00: 0000000000000004 00007ffff4a44ec0 000020002a417100 
0000000000000006
[  645.034430] GPR04: 00007ffff4a44f68 0000000000000020 0000000000000000 
00000001749423fd
[  645.034430] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  645.034430] GPR12: 0000000000000000 0000200029f5b520 0000000000000000 
0000000000000000
[  645.034430] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  645.034430] GPR20: 0000000000000000 0000000136dc20f8 0000000136dbee08 
0000000136dbcfd0
[  645.034430] GPR24: 0000000136dc1dc8 0000000136dc20c8 0000000136dbcfd0 
0000000136dbd038
[  645.034430] GPR28: 0000000000000020 0000000000000006 00000001749423d8 
00007ffff4a44f68
[  645.034463] NIP [000020002a31bd74] 0x20002a31bd74
[  645.034465] LR [0000000136da3804] 0x136da3804
[  645.034467] --- interrupt: c00
[  645.034469] Instruction dump:
[  645.034471] 4e800020 60000000 60000000 60000000 3c4c029b 3842e3a0 
7c0802a6 60000000
[  645.034477] 7c690074 fbc1fff0 f821ff91 7929d182 <0b090000> fbe10068 
7c7f1b78 38630330
[  645.034483] ---[ end trace 0000000000000000 ]---

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center
