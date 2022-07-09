Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E028256CA96
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGIQUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGIQUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:20:52 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C43459B3;
        Sat,  9 Jul 2022 09:20:50 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 269GK4xM025972;
        Sat, 9 Jul 2022 09:20:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=ajck2Kpp4QR6GINz1hOFPMCbQgumHBrVbPDM+ihyOsg=;
 b=dEigSPIMZt1HNTW4m4KO87w5hoMkc+xuwWQI3RoG1LSTAf3129sgIfydz+s86TCKGtj6
 JTKeY5cGXJPl1fqmk9HD//7R/kFIsF5k+ztnzijndA6hKc3iqFzDz8bk7PDIQ0pi3h41
 EYCaY6m4p8QAHdTWp6aV1U7QGOZIziLWJptEDMIzTb/rynLrTiE4cmQL29xbifvTLtKP
 56xc5RWM3HrFoQvkBUUmSAmRpdIEScQKaeIydl1YU+9kO86noYPTCVrDxX9CBAxilAfG
 E/a56cpvXDY9LlDYOBHDHXhDE2HeUWvUTyVv3/jR7lquOYWl+em7AczhbwTNhIl9EU2v VQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3h796kr3gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Jul 2022 09:20:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anox57IYvEqExQ9BaC62J09e6bvjGJgOQJfvwIldshHZ7nUze5o022F8SO+K5MkZZkeIDRZ94NAkPpFZvXeXDf2zGySF4qIxhejslnFViebCpd19x1P1XYA1WpjSQPGI5GJhKQY8brDBv3jMkMrSOQ7hqd/+0NlO6Dq8H8z93+Aogoydp4AI4Vo5VwNdpgwHCF7xA1Aoskqu1ycJvbdraDSdp5OR77zL5yrrgVIwB6Ty10wXh7RG8+zHF0Pb2ImgVUrqoqlTOfh2ur6VJhorpE0flvkhQLEL2RmRvkQ/E7AXxCASSM4vYeGUvjZxQ18j7+u/PzK1jHxtrjHQKil/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajck2Kpp4QR6GINz1hOFPMCbQgumHBrVbPDM+ihyOsg=;
 b=UYRU+f+i8W1ukIHe93Rucy6NAr9B3lcXJnBkE/UaZTPsi2CqTeSSBiPuiq4kdHgGcP3p76TUx5vTIGW55mj5y0NBR8MmsORIHmTgKyHzOdtYramLX5fcL8v9ec0inQudAiuO9WVWrzoSCWX3RYrPwX0lZceQutdBPqwJzdW/1ZVwyHClqNFkkfmRi69WXFyzx0LyyOvZTKte3UAK5yg68dw0MmtlhOHwC4sMhNem59Fhrt0xIhweyJ8FA3lvj53MMm9LXHHO8CV2YOWx5UNySHWDoUnlk/ZOA6crvaLnX9wt3+2bBeMABHTQrr/y88bpt4FizuEtDXS128QXnrFPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by SN6PR11MB2735.namprd11.prod.outlook.com (2603:10b6:805:60::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 16:20:00 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::45e5:975f:214a:f0d6]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::45e5:975f:214a:f0d6%6]) with mapi id 15.20.5417.016; Sat, 9 Jul 2022
 16:20:00 +0000
Date:   Sat, 9 Jul 2022 12:19:56 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     John Keeping <john@metanate.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] sched/core: Always flush pending blk_plug
Message-ID: <20220709161956.GA20046@windriver.com>
References: <20220708162702.1758865-1-john@metanate.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708162702.1758865-1-john@metanate.com>
X-ClientProxiedBy: YQBPR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::14) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4e8dc89-5a80-4df8-a3b7-08da61c6df4d
X-MS-TrafficTypeDiagnostic: SN6PR11MB2735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1ZjAOOJcK739TN6HcRjF1q0AVR8vrfqX+Qw3RAkDdGZShEzYnX/6G5XUTG2ODzjIT7pxVlHlomUfy8oBMTNyxLqG+FysLCXl4QstBw+oj8T2OZaN1lWOr2R8I5nStmk6oM2jTwuEIS2QJKorEbe0qzQsVQQ2xOitfqdGXG0J4W0ncekwEac00855mL6J9SYaj6g+8GWsSUaAcZlpd3H1QflafOr8dmvfC92E0VRuX1LIvPweuRyPALNAtwJzIbWay1Q1qkP5avZmmBWj3BieDAIkhm8AK4Rqy5Sj2BZuwJMExwBZVzP7/9KJrguQlkRXtP9Url6qNFfGgZU+ieombujmh0CzaF7JfN5uCrs6PHoWoqCpdLkK/HDkRoJnFF5v//PVBZ/DemhtJpDWieEdA58rXTA7JlgJcR8EFj30HE8xvm2XmMO1gEjhpk8nUba6jNd5PM1D1mtd15rOZeUiwYGZspd2nznjk7paO7ZSCe+/w7dHjp9EuH5zBwg0pYCGJ8cBVkb+r36xiGgzbVV483eQG0n1omKwgKsMBH38wLHR3TVHDL9I96zoqAxNx3sftilyV1ZFHDaNG5XH0SVZIag//dQ15GIZanleSlvsazl+aKy08lsgs7z8kYGGO0TIQ596AmZ1X9i0cIFSEiep7eKn2CY9Ji8zMPtz6nCmQbMa2lTGqvJTCLChZd9j8HM0mtQUHr7QqmPVkjohe+b+a8cDBTGqykXqVcyhA2j+fbtMPjygLs03QQ0m5QQsMZogLeFL7bPajzHUPj7WMccnf8lDutMgecIZinwaaUSNL5BsDBsT3r9ytZFWFif8d52y92xmaNeI7+bZHCCZIh7Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39840400004)(136003)(376002)(26005)(6486002)(6506007)(36756003)(1076003)(4326008)(41300700001)(6666004)(86362001)(52116002)(54906003)(38100700002)(478600001)(33656002)(6916009)(6512007)(316002)(5660300002)(44832011)(38350700002)(2906002)(2616005)(83380400001)(7416002)(8936002)(186003)(66946007)(8676002)(66556008)(66476007)(30864003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eI6tLaxlYU20BMtN1FfQNkbeWp8FmV/Z6WWGXmePCV00klUfUVDYqKZ/Lldz?=
 =?us-ascii?Q?4g/IhAZeIkAOCMhVJWBS6j5Q1Qk30CG3WWhat2IH/QCPi7yQWDqTRFs0XVc7?=
 =?us-ascii?Q?+dkw4kpCBb61vprnORqLEtG3Ymxok8l7m4aICtlP7MKWYl1PiUnvuRediuRX?=
 =?us-ascii?Q?GPZRD/OdQDcwzgpuzHqwdA8Db+dU+gi0dFdsg6+hpqT87DVJQW5nLnhl468C?=
 =?us-ascii?Q?5uId+OzaDdvdOIlEGC/VolICAOU61O6MKMBtt2AZzcrMGPufzRJ2u2wdGnaQ?=
 =?us-ascii?Q?kaF1rHR/ffx866lSmYS4orL4/B0W5m+MNRZ/SBDAYksVvGseKo9zOOvUd1Ih?=
 =?us-ascii?Q?zwSuqEew7bPWav7rUblCb+fTDQpi/PBIiam43Qp0NkX3Oy+1PK8PH9FFzqch?=
 =?us-ascii?Q?7RnKTItCm8P2tCOONEnmt5G3qUiqt/98JdqJvf8JVIJKjlv2A1eRWPzrSPDb?=
 =?us-ascii?Q?2pn8JrxP703vK3/523DbkXmoNvlLMD5gyTDuf5aK5T7Z+lZXWicsKxaOlBDf?=
 =?us-ascii?Q?wUOSLh+s5stPp4+hy1y5ceGTje2d3LjDgqoJhP4aS7PbZrE4T+qajv0+it+4?=
 =?us-ascii?Q?0FjyZRppkoQ/J4J5DnBYgMsGASIkpVDnUjJ7xPKfw8jGQ3slsFFbK/krTPvY?=
 =?us-ascii?Q?3WcXOWNM18nhvAvnrB0lpetTQapZBSEAtBm/2vlF8ER+8OF35zTacarw5Sn5?=
 =?us-ascii?Q?qTB7BlsOWdTdSgyO1R7DJvjBWUeSwfNYp5TQuNiV7AHeB2oSm76jcIB7pCHX?=
 =?us-ascii?Q?qvnG0uCWRgcLy8u17kFot84UDk7ZT5f5VgYgUF+ScOJNv89GzfsxQv1BLOFG?=
 =?us-ascii?Q?9UWL2exer4p6U0CyB3P1nk/q8cmV44mMVH11I0eYy5tquBSbbg0FSOZnaJKh?=
 =?us-ascii?Q?S3Ll0iwW5+s+dHXzx+TAHM8SWj9eyUyFZtZrGd/c+iXab4yNODJa8CaulZVg?=
 =?us-ascii?Q?ZvaaKUEmSZB+o5tIo/KVOOtMo+UrZFjIq8OBZKzGGC7HA1+h8AYKUEBy0Bpa?=
 =?us-ascii?Q?HeixxOOTwxXXBElACLO4e+bDBr8h4Sjda0txAw65s/0bhJ4SLUqn/KlfG3KN?=
 =?us-ascii?Q?Dlx7fMcoG/cUJuP/mLEuaBmRE7PNwctWXyFeys4lZYyQWuwJaPzmQC9/vN/1?=
 =?us-ascii?Q?jZUdm/5II42ewzd5mENVaWUKl4Y5O1bJfYgz8CPaT1um5PwyR2zj9FwMXDxm?=
 =?us-ascii?Q?yuaEeseHnCwUT9dfETGiFBoRHi3Y6+kAqcrG12MmlaqTXDFat9nyigYD7Cbm?=
 =?us-ascii?Q?6pMnt4xEcUgF0wOiUvsZvZw6/NlIfQUFQHQ6xO/PkF2Lyf5+EIGarn6uCX3N?=
 =?us-ascii?Q?EXkgdHhpLrDLmNy6sGj4/S1ucQBRfo8+89g+a8tOgBvWYEvtjFPHnnpYj9AI?=
 =?us-ascii?Q?Gr2R55on3yjke8d3c9lQR+rqzhxqGofdGvWa1OoEMJbd6ZgNObNUlm8K0pL5?=
 =?us-ascii?Q?6gTOka4LxtbT3VfkiSGQ+O2AeipfsH1fOqUZXUwWTLVjnmw7UsPg/e/qD4Iy?=
 =?us-ascii?Q?wV7u5UTZc9g/EEpMfPA3K2Vyzppb5VGKrbckUy79gfOIqO+IIYSQIPvlZVhy?=
 =?us-ascii?Q?1EMkCCTSuQx4jcwyXAPXh34f/a1UeAkP+3Yx2oEyLxhCJVRVNSc8kW9e7xKB?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e8dc89-5a80-4df8-a3b7-08da61c6df4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 16:20:00.6204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pib4QwNDQDH2/34CTVinNhG9wQWuXs6/3dfWsZkjeC7LmVvUGoGZsQ5TWW6EiLLALK2+/mxPS8qUPM9LUeqgpWOpqxHobQuhx5kHkCKZRPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2735
X-Proofpoint-GUID: CCK8Ks_me8SV0bPLaEsIIiyO2mTehDr5
X-Proofpoint-ORIG-GUID: CCK8Ks_me8SV0bPLaEsIIiyO2mTehDr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-09_14,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207090072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[[PATCH v3] sched/core: Always flush pending blk_plug] On 08/07/2022 (Fri 17:27) John Keeping wrote:

> With CONFIG_PREEMPT_RT, it is possible to hit a deadlock between two
> normal priority tasks (SCHED_OTHER, nice level zero):
> 
> 	INFO: task kworker/u8:0:8 blocked for more than 491 seconds.
> 	      Not tainted 5.15.49-rt46 #1
> 	"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 	task:kworker/u8:0    state:D stack:    0 pid:    8 ppid:     2 flags:0x00000000
> 	Workqueue: writeback wb_workfn (flush-7:0)

This is great.  I was on-and-off looking at an ext4 deadlock triggered
by LTP's "ftest01" - and was just potting my notes together this morning
to clarify for myself what I thought was going on before I forgot.

Which is good, because I then could recognize the very similar patterns
in what you saw to what I'd observed/deduced.  Otherise I'd probably not
have had your backtraces grab my attention at all.

Long story short, I applied this to v5.19-rc3-rt5 and it resolves the
LTP/ext4 deadlock issue.  So...

Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>

As I'd already put together my ext4 debug info, I'll include it below
in case it helps future people searching for LTP and ftest01.

Thanks,
Paul.

	-----------------


There is a reproducible deadlock in ext4 on preempt-rt triggered by LTP
"ftest01" 

Reproducer details are at the bottom.  What seems to happen is as follows:

The kworker doing writeback wb_workfn (pid 213 below) stalls on the 
one and only down_write in ext4_map_blocks() and never moves again.

      /*
       * New blocks allocate and/or writing to unwritten extent
       * will possibly result in updating i_data, so we take
       * the write lock of i_data_sem, and call get_block()
       * with create == 1 flag.
       */
      down_write(&EXT4_I(inode)->i_data_sem);

So who is blocking the kworker?  There are two of the ftest01 processes
(pid 818 and pid 821) doing ext4 truncate which look like this:

  ext4_truncate+0x46a/0x660
   --> ext4_ext_truncate+0xd6/0xf0
       --> ext4_ext_remove_space+0x59f/0x1830
           --> jbd2_journal_get_write_access+0x51/0x80
               --> do_get_write_access+0x2ad/0x550
                   --> complete_all+0x60/0x60
                       --> bit_wait_io+0x11/0x60

They too are stalled in D state waiting there forever - presumably
waiting on the kwowrker to make the progress they are waiting for.

Here is where I think lockdep shows us the problem:

  5 locks held by ftest01/818:
   [...]
   #4: ffff957c2a679958 (&ei->i_data_sem){++++}-{3:3}, at: ext4_truncate+0x443/0x660

  5 locks held by ftest01/821:
   [...]
   #4: ffff957c2a67bb78 (&ei->i_data_sem){++++}-{3:3}, at: ext4_truncate+0x443/0x660

Yes - that is the one the kworker was trying the down_write() on.

Also note that the bit_wait is a big telltale sign here - there is only
one in the jbd2's do_get_write_access() function:

      /*
       * There is one case we have to be very careful about.  If the
       * committing transaction is currently writing this buffer out to disk
       * and has NOT made a copy-out, then we cannot modify the buffer
       * contents at all right now.  The essence of copy-out is that it is
       * the extra copy, not the primary copy, which gets journaled.  If the
       * primary copy is already going to disk then we cannot do copy-out
       * here.
       */
      if (buffer_shadow(bh)) {
              JBUFFER_TRACE(jh, "on shadow: sleep");
              spin_unlock(&jh->b_state_lock);
              wait_on_bit_io(&bh->b_state, BH_Shadow, TASK_UNINTERRUPTIBLE);
              goto repeat;
      }

Presumaby this is a corner case that preempt-rt makes easier to trigger?

The full trace with interspersed lockdep info follows.

Various detailed reproducer information follows that.

	-----------------------

sysrq-w backtracce information interspersed with sysrq-d lockdep info
on 5.19-rc2-rt3 kernel:

 task:kworker/u129:34 state:D stack:    0 pid:  213 ppid:     2 flags:0x00004000
 Workqueue: writeback wb_workfn (flush-7:0)
 Call Trace:
  <TASK>
  __schedule+0x329/0xae0
  ? __this_cpu_preempt_check+0x13/0x20
  ? __rt_mutex_slowlock.isra.21.constprop.25+0xc0e/0xc40
  schedule+0x48/0xc0
  __rt_mutex_slowlock.isra.21.constprop.25+0x1b8/0xc40
  rwbase_write_lock+0x98/0x6e0
  down_write+0x46/0x50
  ? ext4_map_blocks+0x156/0x5c0
  ext4_map_blocks+0x156/0x5c0
  ext4_writepages+0xa1a/0x1290
  ? __this_cpu_preempt_check+0x13/0x20
  ? lockdep_hardirqs_on+0xcd/0x150
  do_writepages+0xd2/0x1a0
  __writeback_single_inode+0x64/0x850
  writeback_sb_inodes+0x22d/0x5b0
  __writeback_inodes_wb+0x67/0xe0
  wb_writeback+0x269/0x5f0
  ? get_nr_inodes+0x49/0x70
  wb_workfn+0x43d/0x780
  ? __this_cpu_preempt_check+0x13/0x20
  process_one_work+0x286/0x710
  worker_thread+0x3c/0x3d0
  ? process_one_work+0x710/0x710
  kthread+0x13b/0x150
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

  6 locks held by kworker/u129:34/213:
   #0: ffff957c25e9ef28 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x201/0x710
   #1: ffffb7e9c3797e68 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x201/0x710
   #2: ffff957b9c9b70d0 (&type->s_umount_key#34){++++}-{3:3}, at: trylock_super+0x1b/0x50
   #3: ffff957b8a9b2d18 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0xd2/0x1a0
   #4: ffff957b9c9b5be8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x13e/0x5f0
   #5: ffff957c2a679958 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x156/0x5c0


 task:jbd2/loop0-8    state:D stack:    0 pid:  679 ppid:     2 flags:0x00004000
 Call Trace:
  <TASK>
  __schedule+0x329/0xae0
  schedule+0x48/0xc0
  jbd2_journal_wait_updates+0x7c/0xf0
  ? schedstat_stop+0x10/0x10
  jbd2_journal_commit_transaction+0x284/0x20e0
  ? __this_cpu_preempt_check+0x13/0x20
  ? find_held_lock+0x35/0xa0
  ? _raw_spin_unlock_irqrestore+0x86/0x8f
  ? _raw_spin_unlock_irqrestore+0x86/0x8f
  ? try_to_del_timer_sync+0x53/0x80
  ? trace_hardirqs_on+0x3b/0x120
  ? try_to_del_timer_sync+0x53/0x80
  kjournald2+0xd5/0x2b0
  ? schedstat_stop+0x10/0x10
  ? commit_timeout+0x20/0x20
  kthread+0x13b/0x150
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>


 task:ftest01         state:D stack:    0 pid:  817 ppid:   816 flags:0x00004002
 Call Trace:
  <TASK>
  __schedule+0x329/0xae0
  ? __x64_sys_tee+0xd0/0xd0
  ? __x64_sys_tee+0xd0/0xd0
  schedule+0x48/0xc0
  wb_wait_for_completion+0x62/0x90
  ? schedstat_stop+0x10/0x10
  sync_inodes_sb+0xdd/0x460
  ? __this_cpu_preempt_check+0x13/0x20
  ? __x64_sys_tee+0xd0/0xd0
  sync_inodes_one_sb+0x15/0x20
  iterate_supers+0x94/0x100
  ksys_sync+0x42/0xa0
  __do_sys_sync+0xe/0x20
  do_syscall_64+0x3f/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7f3f9dae2cdb
 RSP: 002b:00007ffe06430318 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
 RAX: ffffffffffffffda RBX: 0000000000000800 RCX: 00007f3f9dae2cdb
 RDX: 0000000000000040 RSI: 0000561f57de52f0 RDI: 0000561f57de5340
 RBP: 00000000000ff000 R08: 0000000000000000 R09: 00007f3f9dbce0a0
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 0000000000000207 R14: 0000000000000049 R15: 0000000000000003
  </TASK>

  1 lock held by ftest01/817:
   #0: ffff957b9c9b70d0 (&type->s_umount_key#34){++++}-{3:3}, at: iterate_supers+0x7d/0x100


 task:ftest01         state:D stack:    0 pid:  818 ppid:   816 flags:0x00004002
 Call Trace:
  <TASK>
  __schedule+0x329/0xae0
  ? bit_wait+0x60/0x60
  schedule+0x48/0xc0
  io_schedule+0x16/0x40
  bit_wait_io+0x11/0x60
  __wait_on_bit_lock+0x5e/0xb0
  out_of_line_wait_on_bit_lock+0x93/0xb0
  ? complete_all+0x60/0x60
  __lock_buffer+0x3f/0x50
  do_get_write_access+0x2ad/0x550
  jbd2_journal_get_write_access+0x51/0x80
  __ext4_journal_get_write_access+0xf9/0x1a0
  ext4_ext_get_access.isra.32+0x34/0x50
  ext4_ext_remove_space+0x59f/0x1830
  ? ext4_ext_truncate+0xa2/0xf0
  ? ext4_ext_truncate+0x5e/0xf0
  ext4_ext_truncate+0xd6/0xf0
  ext4_truncate+0x46a/0x660
  ext4_setattr+0x6db/0xa40
  notify_change+0x3e5/0x540
  do_truncate+0x7b/0xc0
  ? do_truncate+0x7b/0xc0
  do_sys_ftruncate+0x164/0x2f0
  __x64_sys_ftruncate+0x1b/0x20
  do_syscall_64+0x3f/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7f3f9dae3f7b
 RSP: 002b:00007ffe06430318 EFLAGS: 00000202 ORIG_RAX: 000000000000004d
 RAX: ffffffffffffffda RBX: 00000000000001a5 RCX: 00007f3f9dae3f7b
 RDX: 00000000000001a5 RSI: 00000000000d2800 RDI: 0000000000000003
 RBP: 00000000000001a5 R08: 00007f3f9dbce090 R09: 00007f3f9dbce0a0
 R10: 0000000000000008 R11: 0000000000000202 R12: 0000000000000000
 R13: 0000000000000207 R14: 0000000000000043 R15: 0000000000000003
  </TASK>

  5 locks held by ftest01/818:
   #0: ffff957b9c9b74e8 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_ftruncate+0x1b/0x20
   #1: ffff957c2a679b00 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: do_truncate+0x6a/0xc0
   #2: ffff957c2a679cc0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0x39a/0xa40
   #3: ffff957b9c9b5be8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x13e/0x5f0
   #4: ffff957c2a679958 (&ei->i_data_sem){++++}-{3:3}, at: ext4_truncate+0x443/0x660


 task:ftest01         state:D stack:    0 pid:  819 ppid:   816 flags:0x00004002
 Call Trace:
  <TASK>
  __schedule+0x329/0xae0
  ? __x64_sys_tee+0xd0/0xd0
  ? __x64_sys_tee+0xd0/0xd0
  schedule+0x48/0xc0
  wb_wait_for_completion+0x62/0x90
  ? schedstat_stop+0x10/0x10
  sync_inodes_sb+0xdd/0x460
  ? __this_cpu_preempt_check+0x13/0x20
  ? __x64_sys_tee+0xd0/0xd0
  sync_inodes_one_sb+0x15/0x20
  iterate_supers+0x94/0x100
  ksys_sync+0x42/0xa0
  __do_sys_sync+0xe/0x20
  do_syscall_64+0x3f/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7f3f9dae2cdb
 RSP: 002b:00007ffe06430318 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
 RAX: ffffffffffffffda RBX: 0000000000000800 RCX: 00007f3f9dae2cdb
 RDX: 0000000000000040 RSI: 0000561f57de52f0 RDI: 0000561f57de5340
 RBP: 00000000000c2800 R08: 00000000fffff800 R09: 0000000000004000
 R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
 R13: 0000000000000207 R14: 0000000000000075 R15: 0000000000000003
  </TASK>

  1 lock held by ftest01/819:
   #0: ffff957b9c9b70d0 (&type->s_umount_key#34){++++}-{3:3}, at: iterate_supers+0x7d/0x100


 task:ftest01         state:D stack:    0 pid:  820 ppid:   816 flags:0x00004002
 Call Trace:
  <TASK>
  __schedule+0x329/0xae0
  ? __x64_sys_tee+0xd0/0xd0
  ? __x64_sys_tee+0xd0/0xd0
  schedule+0x48/0xc0
  wb_wait_for_completion+0x62/0x90
  ? schedstat_stop+0x10/0x10
  sync_inodes_sb+0xdd/0x460
  ? __this_cpu_preempt_check+0x13/0x20
  ? __x64_sys_tee+0xd0/0xd0
  sync_inodes_one_sb+0x15/0x20
  iterate_supers+0x94/0x100
  ksys_sync+0x42/0xa0
  __do_sys_sync+0xe/0x20
  do_syscall_64+0x3f/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7f3f9dae2cdb
 RSP: 002b:00007ffe06430318 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
 RAX: ffffffffffffffda RBX: 0000000000000800 RCX: 00007f3f9dae2cdb
 RDX: 0000000000000040 RSI: 0000561f57de52f0 RDI: 0000561f57de5340
 RBP: 000000000006a800 R08: 00000000fffff800 R09: 0000000000004000
 R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
 R13: 0000000000000207 R14: 0000000000000069 R15: 0000000000000003
  </TASK>

  1 lock held by ftest01/820:
   #0: ffff957b9c9b70d0 (&type->s_umount_key#34){++++}-{3:3}, at: iterate_supers+0x7d/0x100


 task:ftest01         state:D stack:    0 pid:  821 ppid:   816 flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0x329/0xae0
  ? bit_wait+0x60/0x60
  schedule+0x48/0xc0
  io_schedule+0x16/0x40
  bit_wait_io+0x11/0x60
  __wait_on_bit_lock+0x5e/0xb0
  out_of_line_wait_on_bit_lock+0x93/0xb0
  ? complete_all+0x60/0x60
  __lock_buffer+0x3f/0x50
  do_get_write_access+0x2ad/0x550
  jbd2_journal_get_write_access+0x51/0x80
  __ext4_journal_get_write_access+0xf9/0x1a0
  ext4_ext_get_access.isra.32+0x34/0x50
  ext4_ext_remove_space+0x59f/0x1830
  ? ext4_ext_truncate+0xa2/0xf0
  ? ext4_ext_truncate+0x5e/0xf0
  ext4_ext_truncate+0xd6/0xf0
  ext4_truncate+0x46a/0x660
  ext4_setattr+0x6db/0xa40
  notify_change+0x3e5/0x540
  do_truncate+0x7b/0xc0
  ? do_truncate+0x7b/0xc0
  do_sys_ftruncate+0x164/0x2f0
  __x64_sys_ftruncate+0x1b/0x20
  do_syscall_64+0x3f/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7f3f9dae3f7b
 RSP: 002b:00007ffe06430318 EFLAGS: 00000202 ORIG_RAX: 000000000000004d
 RAX: ffffffffffffffda RBX: 000000000000016a RCX: 00007f3f9dae3f7b
 RDX: 000000000000016a RSI: 00000000000b5000 RDI: 0000000000000003
 RBP: 000000000000016a R08: 00007f3f9dbce080 R09: 00007f3f9dbce0a0
 R10: 0000000000000002 R11: 0000000000000202 R12: 0000000000000000
 R13: 0000000000000207 R14: 0000000000000040 R15: 0000000000000003
  </TASK>

  5 locks held by ftest01/821:
   #0: ffff957b9c9b74e8 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_ftruncate+0x1b/0x20
   #1: ffff957c2a67bd20 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: do_truncate+0x6a/0xc0
   #2: ffff957c2a67bee0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0x39a/0xa40
   #3: ffff957b9c9b5be8 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x13e/0x5f0
   #4: ffff957c2a67bb78 (&ei->i_data_sem){++++}-{3:3}, at: ext4_truncate+0x443/0x660

		--------------------------------------

Reproducer:

Get latest preempt-rt kernel:
	git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
	checkout v5.19-rc3-rt5 (or linux-5.19.y-rt branch)
	make defconfig
	manually enable CONFIG_EXPERT and then CONFIG_PREEMPT_RT
	make oldconfig and take defaults for other options hidden behind EXPERT
	can optionally enable LOCKDEP options so sysrq-d works.

Get LTP ; build + install
	https://github.com/linux-test-project/ltp.git

Boot and then run reproducer:
   dd if=/dev/zero of=/root/tmp_mount_file bs=1M count=512
   mkfs.ext4 -F /root/tmp_mount_file
   mount /root/tmp_mount_file /mnt/
   /opt/ltp/runltp -f fs -s ftest01 -d /mnt/
   umount /mnt

   loop device isn't strictly necessary but contains fs fallout when
   inevitable reboot is required to get rid of D state processes.

   Test completes on v5.10-rt, v5.12-rt - should take about 2-3m total.
   Test hangs forever on v5.15-rt and latest v5.19-rc-rt.  Test threads
   in D state - any other i/o directed at /mnt also hangs in D state.
