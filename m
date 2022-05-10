Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1D45212F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiEJLCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiEJLCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:02:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2EA201E8D;
        Tue, 10 May 2022 03:57:55 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A9E9YJ027802;
        Tue, 10 May 2022 10:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : to : cc : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=LFGPf8mFA0aevhB01jzcjQEGy7N5k1JKzArekpB+7wo=;
 b=scCNGxELalf+pJEneZXWDybfUaVGo+FT2/30yt1ZEY/cvIIB6+8GxgAFPcrYJcv7vJwu
 gSAZZLkFxc6fUnTmLbi561zmGZ63uCobRbamif8zpYL23eDV5MChFM00J9wTcE9/FNqr
 FdidhIM3UkOkMc8AW9TFF9I7fT4xWqVAT5Q1wELNwseACJCm/pGAkA7erAsr1bF9rqoP
 hsLVjO2SoxplMkAqy3wpaXJfnoylbwAKNqfbbyH5RaN7jmd9Nhz3ap8yAL0tZfw35gY2
 6eq/4vgO7TTpe6fKPTubLteLU6i8pK69NEGlPlECdtgITSnu/HKbs5m+40VyulGN3U3A 4w== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyn811y4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 10:57:22 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24AAvGXX026819;
        Tue, 10 May 2022 10:57:21 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 3fwgd9vf9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 10:57:21 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24AAvLQG7799336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 10:57:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F33F8AE062;
        Tue, 10 May 2022 10:57:20 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D95CAE063;
        Tue, 10 May 2022 10:57:17 +0000 (GMT)
Received: from [9.43.16.192] (unknown [9.43.16.192])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 May 2022 10:57:17 +0000 (GMT)
Message-ID: <b6e58d90-a0e4-00bb-7d61-487f163c8b8b@linux.vnet.ibm.com>
Date:   Tue, 10 May 2022 16:27:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, kch@nvidia.com, axboe@kernel.dk,
        hch@lst.de, abdhaleem@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
Subject: [linux-next] [FC/EXT4] [PPC] WARNING: CPU: 33 PID: 47869 at
 block/blk-lib.c:50 __blkdev_issue_discard+0x250/0x280
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oAfMhK2fwKJwPzZz_B5j6OLOgxkbOJgS
X-Proofpoint-ORIG-GUID: oAfMhK2fwKJwPzZz_B5j6OLOgxkbOJgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_01,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

linux-next kernel 5.18.0-rc5-next-20220506 WARN_ON is triggered while 
running stress test on FC disk created with the EXT4 filesystem.

Console Logs :

  md127: detected capacity change from 0 to 62879744
  EXT4-fs (dm-11): mounted filesystem with ordered data mode. Quota 
mode: none.
  md127: detected capacity change from 62879744 to 0
  md: md127 stopped.
  EXT4-fs (dm-11): mounted filesystem with ordered data mode. Quota 
mode: none.
  md127: detected capacity change from 0 to 62879744
  WARNING: CPU: 33 PID: 47869 at block/blk-lib.c:50 
__blkdev_issue_discard+0x250/0x280
  Modules linked in: raid0 rpadlpar_io rpaphp nfnetlink tcp_diag 
udp_diag inet_diag unix_diag af_packet_diag netlink_diag bonding rfkill 
sunrpc pseries_rng xts vmx_crypto gf128mul sch_fq_codel binfmt_misc 
ip_tables ext4 mbcache jbd2 dm_round_robin sd_mod t10_pi crc64_rocksoft 
crc64 sg ibmvfc scsi_transport_fc ibmveth dm_multipath dm_mirror 
dm_region_hash dm_log dm_mod fuse
  CPU: 33 PID: 47869 Comm: mkfs.ext4 Kdump: loaded Not tainted 
5.18.0-rc5-next-20220506-autotest #1
  NIP:  c00000000064beb0 LR: c00000000064bf40 CTR: 0000000000000000
  REGS: c0000000a7a2f870 TRAP: 0700   Not tainted 
(5.18.0-rc5-next-20220506-autotest)
  MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28002282  XER: 00000000
  CFAR: c00000000064bd24 IRQMASK: 0
  GPR00: c00000000064bf40 c0000000a7a2fb10 c0000000028cbd00 
c0000000ed960000
  GPR04: 0000000000000000 0000000000008000 0000000000000cc0 
c0000000a7a2fc28
  GPR08: 0000000000000000 c0000000c70a0000 00000000ffffffff 
0000000000000000
  GPR12: 0000000000002000 c0000018ff95ee80 0000000000000000 
0000000000000000
  GPR16: 0000000000000000 0000000000000000 000000000077ef00 
000000014e1e56a0
  GPR20: 0000000000008000 00007fff988b0588 00007ffff213dfe8 
0000000000000000
  GPR24: 0000000000000003 0000000000000000 0000000001000000 
c0000000ed960000
  GPR28: 0000000001000000 0000000000000000 c0000000ed960000 
c0000000ed960000
  NIP [c00000000064beb0] __blkdev_issue_discard+0x250/0x280
  LR [c00000000064bf40] blkdev_issue_discard+0x60/0xe0
  Call Trace:
  [c0000000a7a2fb10] [c0000000a7a2fb60] 0xc0000000a7a2fb60 (unreliable)
  [c0000000a7a2fbe0] [c00000000064bf40] blkdev_issue_discard+0x60/0xe0
  [c0000000a7a2fc70] [c00000000065e840] blkdev_common_ioctl+0x1b0/0xbf0
  [c0000000a7a2fd00] [c00000000065f6a8] blkdev_ioctl+0x428/0x6e0
  [c0000000a7a2fd60] [c0000000004857c8] sys_ioctl+0xf8/0x150
  [c0000000a7a2fdb0] [c00000000002f468] system_call_exception+0x178/0x380
  [c0000000a7a2fe10] [c00000000000c64c] system_call_common+0xec/0x250
  --- interrupt: c00 at 0x7fff98524480
  NIP:  00007fff98524480 LR: 00007fff98867828 CTR: 0000000000000000
  REGS: c0000000a7a2fe80 TRAP: 0c00   Not tainted 
(5.18.0-rc5-next-20220506-autotest)
  MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 
24002288  XER: 00000000
  IRQMASK: 0
  GPR00: 0000000000000036 00007ffff213dec0 00007fff98617100 
0000000000000003
  GPR04: 0000000020001277 00007ffff213df48 0000000001000000 
0000000000001000
  GPR08: 0000000000000003 0000000000000000 0000000000000000 
0000000000000000
  GPR12: 0000000000000000 00007fff9895ce40 0000000000000000 
0000000000000000
  GPR16: 0000000000000000 0000000000000000 000000000077ef00 
000000014e1e56a0
  GPR20: 0000000000008000 00007fff988b0588 00007ffff213dfe8 
0000000000000000
  GPR24: 000000011b2a0890 000000011b2a08a0 000000011b2a0880 
000000011b2a00d8
  GPR28: 0000000000000000 00007fff988b0590 000000011b2a00e0 
00007ffff213e0a0
  NIP [00007fff98524480] 0x7fff98524480
  LR [00007fff98867828] 0x7fff98867828
  --- interrupt: c00
  Instruction dump:
  60000000 2fa30000 419e0018 3c62fe6e 38810068 38630da0 4bb95b21 60000000
  3b20ffa1 4bffff60 60000000 60000000 <0fe00000> 7c0802a6 fb010090 fb4100a0
  ---[ end trace 0000000000000000 ]---


-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center
