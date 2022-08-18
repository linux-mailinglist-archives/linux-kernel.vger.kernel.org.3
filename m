Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27B3598108
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243495AbiHRJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbiHRJoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:44:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD89AFAD5;
        Thu, 18 Aug 2022 02:44:15 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I9iBDg006855;
        Thu, 18 Aug 2022 09:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : cc : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JiF/cybh1Bde9Wop9QTcigKTsMN5Hvkz8vlESEossD8=;
 b=gPeO2JbN5aELFVU0zwsUodWHPGYqiHlrm8d5vnQoUy/0JgJPrkB/df8Lcs+jsz6vh7M5
 Z29njVqcbPSElZd8WGeri94bMUJfCU1qSYnc7mPaJhqcQ1CdBKh6DouhaAO1uiEjKRts
 ZlvnIBRMC8qlDUdmYJbj6p7NIX8gfRuUurlhWWPYaGTrqzSu5GNuu8144dprFuvvLJaf
 7aXodaz674SIvAX261/sGcGvZnj/35+so1J+esgjEOMn2VRnl9lcyP/pBwEs0ydocE4G
 BteIgUfksBSqfpDgaP0zNtTx8d7DEHTho2YEN8DxZlCt6VYZyd9cz9BeyaU8pa58O+0Z AQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1k22800x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 09:44:11 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27I9LYNL031432;
        Thu, 18 Aug 2022 09:44:10 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3hx3kadg91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 09:44:10 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27I9i9be47055254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 09:44:09 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64DAB6A051;
        Thu, 18 Aug 2022 09:44:09 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3DFA6A047;
        Thu, 18 Aug 2022 09:44:00 +0000 (GMT)
Received: from [9.43.127.90] (unknown [9.43.127.90])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 09:43:58 +0000 (GMT)
Message-ID: <0d1621b1-6654-34f1-9630-7cf5881a8eaf@linux.vnet.ibm.com>
Date:   Thu, 18 Aug 2022 15:13:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [linux] [5.19.0] task hung for indefinite time with call traces
 when rebooted with Kexec
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4c93ce0b-8e04-1f03-e4ce-7c763719169c@linux.vnet.ibm.com>
 <6b5267ee-9372-3862-614a-298f7bd9ae60@I-love.SAKURA.ne.jp>
Cc:     abdhalee@linux.vnet.ibm.com, mputtash@linux.vnet.com,
        sachinp@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
In-Reply-To: <6b5267ee-9372-3862-614a-298f7bd9ae60@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Sfz9BJZy_UGEzcY5BkfPVp80frY8apST
X-Proofpoint-GUID: Sfz9BJZy_UGEzcY5BkfPVp80frY8apST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,


Please find the location in source code from where i am seeing the call 
traces generating

File : kernel/hung_task.c

         /*
          * Ok, the task did not get scheduled for more than 2 minutes,
          * complain:
          */
         if (sysctl_hung_task_warnings) {
                 if (sysctl_hung_task_warnings > 0)
                         sysctl_hung_task_warnings--;
                 pr_err("INFO: task %s:%d blocked for more than %ld 
seconds.\n",
                        t->comm, t->pid, (jiffies - t->last_switch_time) 
/ HZ);
                 pr_err("      %s %s %.*s\n",
                         print_tainted(), init_utsname()->release,
                         (int)strcspn(init_utsname()->version, " "),
                         init_utsname()->version);
                 pr_err("\"echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs\""
                         " disables this message.\n");
                 sched_show_task(t);
                 hung_task_show_lock = true;

                 if (sysctl_hung_task_all_cpu_backtrace)
                         hung_task_show_all_bt = true;
         }

         touch_nmi_watchdog();
}


On 8/6/22 15:30, Tetsuo Handa wrote:
> On 2022/08/05 15:54, Tasmiya Nalatwad wrote:
>> Greetings,
>>
>> [linux] [5.19.0] task hung for indefinite time with call traces when rebooted with Kexec, A restart is required to recover the machine.
> 
> kexec is waiting for workqueues ("kworker/3:1" and "kworker/3:0") to complete.
> If this problem happens only when rebooting with kexec, something in kexec path
> might be preventing these workqueues from completing.
> 
> Anyway, please repost with locations in source code like syzbot report does.
> 
> [ 1104.673153] task:kworker/3:1     state:D stack:    0 pid:  221 ppid:     2 flags:0x00000800
> [ 1104.673160] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
> [ 1104.673170] Call Trace:
> [ 1104.673173] [c0000000060eb860] [0000000000000004] 0x4 (unreliable)
> [ 1104.673178] [c0000000060eba50] [c00000000001e378] __switch_to+0x288/0x4a0
> [ 1104.673185] [c0000000060ebab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
> [ 1104.673190] [c0000000060ebb80] [c000000000d244e8] schedule+0x68/0x130
> [ 1104.673196] [c0000000060ebbb0] [c0000000008d4574] scsi_remove_target+0x314/0x390
> 
> [ 1104.673233] task:kworker/3:0     state:D stack:    0 pid:227332 ppid:     2 flags:0x00000880
> [ 1104.673237] Workqueue: fc_wq_0 fc_rport_final_delete [scsi_transport_fc]
> [ 1104.673243] Call Trace:
> [ 1104.673244] [c0000000726bb860] [c0000000001b9cb4] enqueue_entity+0x184/0x4f0 (unreliable)
> [ 1104.673250] [c0000000726bba50] [c00000000001e378] __switch_to+0x288/0x4a0
> [ 1104.673254] [c0000000726bbab0] [c000000000d23e84] __schedule+0x2c4/0x8c0
> [ 1104.673258] [c0000000726bbb80] [c000000000d244e8] schedule+0x68/0x130
> [ 1104.673262] [c0000000726bbbb0] [c0000000008d4574] scsi_remove_target+0x314/0x390
> [
> [ 1104.673295] task:kexec           state:D stack:    0 pid:228289 ppid:     1 flags:0x00040080
> [ 1104.673299] Call Trace:
> [ 1104.673301] [c000000069147510] [c00000000001e378] __switch_to+0x288/0x4a0
> [ 1104.673305] [c000000069147570] [c000000000d23e84] __schedule+0x2c4/0x8c0
> [ 1104.673309] [c000000069147640] [c000000000d244e8] schedule+0x68/0x130
> [ 1104.673313] [c000000069147670] [c000000000d2e028] schedule_timeout+0x348/0x3f0
> [ 1104.673317] [c000000069147750] [c000000000d2554c] wait_for_completion+0xcc/0x2b0
> [ 1104.673321] [c0000000691477d0] [c00000000017cbe8] flush_workqueue+0x158/0x520
> [ 1104.673325] [c000000069147870] [c00000000017d068] drain_workqueue+0xb8/0x240
> [ 1104.673329] [c000000069147930] [c0000000001825e0] destroy_workqueue+0x60/0x420
> [ 1104.673333] [c0000000691479c0] [c0080000009291e4] fc_remove_host+0x21c/0x280 [scsi_transport_fc]
> 
> 

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center
