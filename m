Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F51462DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhK3H5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:57:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14948 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhK3H5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:57:45 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU6UltG020993;
        Tue, 30 Nov 2021 07:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=LcqI3eoiEOnLfW5dWWTwBJnZBYqwUKmO4MSxQsnDjsY=;
 b=SywGRvufaaXg0y2MnToOiQI4RY4/l71c9+/c7sMOZkik9mUGBpYGlQnJRlnXTY5fSE2i
 tAgY6EQibDOETHAlt+weLZgKmRnChz8/CvgWYBZwFNcg4ycIUj3YpUKw9o4B40zP+ojW
 fUWip0Q6jM+vXFWQZmOnsViUxhJXkDRbB8QE00qtoehA6SVSbsGsdKvDrZkfRm/MHagP
 MPgNa49ePbvQwv38eBUjnNAE2hhbeTyKAzqVQmNuhyMntoU3s8Qnz0n3dIWVF0ijs/QR
 avu1Ic4BM/5gVu7W/58/7wcP1HzTV9UEXregTErKsuUKVwcpq+bZbtyLfgqz9Q/hrCZ/ Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwqamh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 07:54:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU7jcoS065547;
        Tue, 30 Nov 2021 07:54:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3030.oracle.com with ESMTP id 3ckaqe7pk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 07:54:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEADiNvEenckF7OWn/kplqs+QYN+W6I4UmvkYFA0S7lM9JveeyuUNiSVira7AL6Jdmt75jpME7iY3FaAxoT8sV7A0Fp+ZVw9D43SXYmJnSy+9uRwiu3wfcnIwr4slwgmZL0+6/B1AdZjJfo0oq+PwG19n20d2s0OQz8ky6TWxWQ+9nFgA5tePqQw8ER4LF7nQped3A9hWLQwu1j6xEUPsafEehVpJsB4GPmO5LTeLqpnLlEc6iqjVdrn7kVKxKLL+fmmVlkA5CAHrCKkD1Yp/qPoxU1eqH2rta+WD5VAq06YuimU6V6lDh7gNyGcRRNVlU7cPXtYbGpGIAhwBPjv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcqI3eoiEOnLfW5dWWTwBJnZBYqwUKmO4MSxQsnDjsY=;
 b=f+Abevf4WjDy7PgsGCffsZYceBnYy8WqEkIzsfifzaULsDwtCvwToP+d4D12O8b3fjTEBYXds1b1cAxhm3pskJg/R1LvSIvaOFzEiLSyz0i70QKu2be8/s9byGeqNAqeqRuDL8YgsRa/AKSVgbcQ5ivUZOBIGTMsOyZpzDXypWdWTyDQMG8+MnCFXo4AzJROLqiZP0SaqvIsq6JaJEmpalAGi/SFvaKQ9yH1PVdyDWRPDF+moZ8RlaFSUZbV29SpRDX9S4lrwwJ/QEd8D5vwJekD+H1u0x636k/IJVRAHJb41QgYT4WEX5mOaKCqSAQ/CO1nH1SS8SjvRrxHMUMMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcqI3eoiEOnLfW5dWWTwBJnZBYqwUKmO4MSxQsnDjsY=;
 b=EzkLKoBvGFlZDncMVjB8Jm/2SMvhGMXVNVBsJJO6YoE6x8dFFDHeWLag+1pvvDvJr3xgYd2VtjmcpCtXndfzktgSgsqyjhd9XI6fIGPIH6GgiMSZXiQIXTsB/awb80Zc5n9t7899i3Wd3LOE35D51H6FWRUeeh/Ywbe6JSIzucs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2367.namprd10.prod.outlook.com
 (2603:10b6:301:30::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 07:53:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 07:53:59 +0000
Date:   Tue, 30 Nov 2021 10:53:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, 282827961@qq.com,
        lianzhi chang <changlianzhi@uniontech.com>
Subject: Re: [PATCH v18] tty: Fix the keyboard led light display problem
Message-ID: <202111291912.gGbp6mtv-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129040445.24134-1-changlianzhi@uniontech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 07:53:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dcd735f-1209-49c8-559a-08d9b3d69163
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2367:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23679AD2DC5F7E0A836667B68E679@MWHPR1001MB2367.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fbyg80t8r3hVXLDJ5cULDFqyEazaDwkOR0f+IRMSqK6Enp31gqPv9rhtmAeScIu3EmcUs15Mt+XSyk/Ou6QkV0l5Cm9AKOB8STLBq2AAgtD5uEjmCADYg0opukD+DBVXAT+Hqh3AFdTAhL8r00gPRhbOcPWlT4Agk9fhueLbT4eC331Qum0WvUWF49fGTBeAXrRFwPxRB/FbOl0NvQgQFHRpp+35OJ5plaAfr7qttmB4KRU3P8flso1qPYozdFo296ixRp3zCImfyAceVZ8jSPAKaOC9k2hKiAnvY/GEilwJV6+qlH7QMtU1DZ8vBSWGr+guyjcsCtdXgM70bZZGyb2GUYd/VSsqiGtG2gOHHArfVWO8ucAq99Wj5TlWI6t0nPHZv8nwlNEZpaS8cDSYfv1PnvhG52rSnioIJFBbi1UY5uVgJ0p7yzWP0Oqo4wUn+W1ZnEWdRZEFzbF2Hllcq0IRk3miXw2+Fw/Ce8jW1TOZXJZ+Lelp200xPyIjdzIDmBT9PAnctQK3BA3aA6kBv6Ltu30z0IImjp3lbBw6418W60BUR2d9U17KgW5C92FemVObctoUgIDI2+dR0Ts6KGGwnCgFIRGo/P9lH1MFBbCKThEJtW5pdZcxYrMinzP40/X6p9NKRrvI6H4a7fH/wFkgx4lR4ylHRBqIDUCObOivVexTSXnm2lIFDV9iD37qq3Mj/Ir0zN7FmgRMIarwFQscVp6iVtJSjGEsik0ZLTR92Ft6iRK1rZkG/05X1lLbaDVsj3o+JRdVXo1/fBFgF0e6Xa+aZMXVlCQXGjio3Z4kRJFsyDRbYV681bSD7ou8mhc1vdDFVAsgDYPKFdn9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(9686003)(2906002)(8676002)(38350700002)(52116002)(36756003)(508600001)(38100700002)(956004)(83380400001)(316002)(66946007)(66476007)(66556008)(86362001)(26005)(966005)(1076003)(5660300002)(4326008)(6486002)(44832011)(186003)(7416002)(4001150100001)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ujOdCkDaRmG9bg9rvpFs1ttk0tj1BzRrfC7EDULwJCkKZBSKsH+Q72N0Wrh3?=
 =?us-ascii?Q?W5Hsq621cILa6AVWYqXW2leICUPbXsX0lF907HG9FeLQ0SDdKfBRLFzs0BFV?=
 =?us-ascii?Q?1PFxpvk7c/6/g3GY3aKTJUVUug/SSmdrB9NK8i/Zq9o2Bs26+K++/3af0k24?=
 =?us-ascii?Q?SmIzukebEM1X9BVJzhMfIESICWWJp6E/s4aj08xHsx8EwC+rkI/cYKBRz6Eh?=
 =?us-ascii?Q?9to8SB1SEZOQIALw9HFKNKbLy3hjfh/cu565zCjYVvdKMdON7C0aNV2Aa5Ep?=
 =?us-ascii?Q?kAFm8TnaxSrZYKsrcpgCU9tjkyKPZgQmorIpYmjGdZWESgRrsEOvgVasIe13?=
 =?us-ascii?Q?Z/05vxuqVCZT8NlzpMfo3vroa+zjTP5AFFDzzWUEAe/ZYf0Y4cJJcRAThMl2?=
 =?us-ascii?Q?+CL56nldd4WIKiXydRnXTKvD17xa1KBd79WZFrff3pgV630usXaF2gmp6yW3?=
 =?us-ascii?Q?ePw/6RMeDbH455whn+MFAUSB2E0YMD6ohUy0VRuyiqbh6LzDymS856NGeQGj?=
 =?us-ascii?Q?maaJMhHlFhlYH5jtvt8RFgwQTLzNCLe6tsQLxDS5mDE7NIlPtbfjgbQy4lp6?=
 =?us-ascii?Q?96j9jVVC9LbBL6gpGhYqB7JBdNZieZYQUjOYcPTwpBk2EOcwXiariRfCwl0Q?=
 =?us-ascii?Q?37vuLbVOiTxVO53etHH4j3ownsw6q+Qc1MFJj71pbENUll8aZNRfQq/Emuh5?=
 =?us-ascii?Q?YTAS3zPde6hJczHIF/pldAAIRNkWoe+LuO86PMTFSNTyT1QzSeq+BPUg3Nu5?=
 =?us-ascii?Q?dy038+jtfoxkH3Y+B672MON76s+IYHFyUBfNve0DyivjNAn044b+vOmHE5fL?=
 =?us-ascii?Q?MMJt3yhQulek6rJRmGmDkAYl4nMiCoI3wpE7AsCXJjSFOIwZmJRwXvlmvIP2?=
 =?us-ascii?Q?bcmf/JLZOemSD3e+KxLbiFltovLLT2WsgbPYZMoimbit+RyVNav+qaNPiIG9?=
 =?us-ascii?Q?1dZB4ml56eK4T8gDVZWyks/IZjlvDvG1oXItukQD/faCtRwpFHYhOlwy3w2A?=
 =?us-ascii?Q?yTUO8UM2QZdmWvtH6qZKK2g90kXNXcMtMtBBut4H5+dEmQyhwUuHzS/yIHOO?=
 =?us-ascii?Q?qTYQXT68HPhdV/4S5AqaFLETxAX2LuiiytgJCoa8C0WH/9LIUDg7OKmo+tFm?=
 =?us-ascii?Q?+oX6yCdqyctSTYjExtSD1gFOgxerCCBeGNiIvn4z7adT0iEcCZltwAehdd7Q?=
 =?us-ascii?Q?1kWJlkpxCKkVINnSLmQwlcJ/sgWKlHz/btJEMr/VyDd0e0uHY2rkA+qGPlzP?=
 =?us-ascii?Q?EzWGwG4/CiN2KJtQuuNJGWy+WdHa+QKa1p4F0FZLhka4eiEFKVSA/G9ZV/fM?=
 =?us-ascii?Q?iSqkXUSCmP7/QlVzLrhP+jNyfbx/PBLpKcPo+A5LdomG7rXXFYkwxXcWJ85h?=
 =?us-ascii?Q?nyDrSmUk2ix7dYBdRW5WWy5m7aYPTrO4cI8WTTh8LMW44KkGz6mt72HNqD+x?=
 =?us-ascii?Q?uOaHsr+ygHxuEoBOCpF2XjQiKIx35F457Ro5K8e/s0aAY+nqnEBDwc8iGZvP?=
 =?us-ascii?Q?o4sCfOnETENDuGN86bWRF3Ih3TnpUMhmQgCo/fsPK/lLlnIwa/RIToz2XTfB?=
 =?us-ascii?Q?Z0S2XutI1GqdcSob8k+20mCNh8DspS6n4yWEKVvnKVOxensK6v9CTBB/8YHt?=
 =?us-ascii?Q?9Nw6YF1VxIv2fB7X43S3Jg0XKTCCoegoJWcpxvv6Ovc0w6a3TpSVwJ2YvGnv?=
 =?us-ascii?Q?T+mQqdDcMpBmtyADzwXq+9e/NZE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcd735f-1209-49c8-559a-08d9b3d69163
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:53:59.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Of8SKAAcilOjpoiwDEtYmGPvz+5cXSRwqq1yEb+1Khn0D+H7B2othVhK0BW8a+bdBHrfaKRATrsgXvo7MYTj7bXOkN32LBvvw/27UsDkM+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2367
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300044
X-Proofpoint-ORIG-GUID: xyJFxUjW1vTOMcr-5r-Tp2LzYJW0wFZ1
X-Proofpoint-GUID: xyJFxUjW1vTOMcr-5r-Tp2LzYJW0wFZ1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lianzhi,

url:    https://github.com/0day-ci/linux/commits/lianzhi-chang/tty-Fix-the-keyboard-led-light-display-problem/20211129-120853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: i386-randconfig-m021-20211128 (https://download.01.org/0day-ci/archive/20211129/202111291912.gGbp6mtv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/tty/vt/keyboard.c:425 vt_set_leds_compute_shiftstate() warn: was && intended here instead of ||?

vim +425 drivers/tty/vt/keyboard.c

63f24a7fafd448 drivers/tty/vt/keyboard.c Jiri Slaby     2021-01-05  414  void vt_set_leds_compute_shiftstate(void)
079c9534a96da9 drivers/tty/vt/keyboard.c Alan Cox       2012-02-28  415  {
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  416  	struct kbd_struct *kb;
079c9534a96da9 drivers/tty/vt/keyboard.c Alan Cox       2012-02-28  417  	unsigned long flags;
63f24a7fafd448 drivers/tty/vt/keyboard.c Jiri Slaby     2021-01-05  418  
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  419  	/*
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  420  	 * When switching VT, according to the value of kb->kbdmode,
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  421  	 * judge whether it is necessary to force the keyboard light
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  422  	 * state to be issued.
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  423  	 */
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  424  	kb = kbd_table + fg_console;
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29 @425  	if (kb->kbdmode != VC_RAW ||
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  426  		 kb->kbdmode != VC_MEDIUMRAW ||
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  427  		 kb->kbdmode != VC_OFF) {

&& was intended instead of ||.

560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  428  		vt_switch = true;
63f24a7fafd448 drivers/tty/vt/keyboard.c Jiri Slaby     2021-01-05  429  		set_leds();
560757cc1f5e54 drivers/tty/vt/keyboard.c lianzhi chang  2021-11-29  430  	}
63f24a7fafd448 drivers/tty/vt/keyboard.c Jiri Slaby     2021-01-05  431  
079c9534a96da9 drivers/tty/vt/keyboard.c Alan Cox       2012-02-28  432  	spin_lock_irqsave(&kbd_event_lock, flags);
079c9534a96da9 drivers/tty/vt/keyboard.c Alan Cox       2012-02-28  433  	do_compute_shiftstate();
079c9534a96da9 drivers/tty/vt/keyboard.c Alan Cox       2012-02-28  434  	spin_unlock_irqrestore(&kbd_event_lock, flags);
079c9534a96da9 drivers/tty/vt/keyboard.c Alan Cox       2012-02-28  435  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

