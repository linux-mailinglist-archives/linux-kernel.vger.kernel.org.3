Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8D4AFFEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiBIWOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:14:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiBIWNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:13:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71DEE00D119
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:13:57 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KAjre027666;
        Wed, 9 Feb 2022 22:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=/J8Ajts4j13E7SKFT2mDKhxxdywVW41SqbZhZA6D+vQ=;
 b=d+ZG7vKx003QdCEzIeDjAtjCuMYS6Owe6pz52VN0C208NBIB2xStg1um650quZT7B8Lo
 lCLF4w/+P2wtDOOwxldpFRWA1YH4nEi9pXl4GAlDxwOIOolN8zGvgCIEfWJ2prdZYcuY
 zcnDcuYwlJcCWi+JzTa0eiWwRG6D3Oz7Uw3k+TkjdxyUE9lFdHSekTjkTGWixg/JuUNF
 3IXt/KYuNXdyitNPOps/68Uw24VT75D6xjfGipKU50qD/ybf9ZAb8KHWdazy9Je4pUrv
 Zs45+kDlmt0ArKgDYd5OmxSSlZ74LTc0VrY3lZp/E8hmiwP0BK26PPuV3bwjnbQeGX+9 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdswxmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 22:13:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219LtrSp066865;
        Wed, 9 Feb 2022 22:13:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 3e1ec3gve2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 22:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN3l2qOvHVIf58XhYXgQFHLSQ1DqDZddZbCcyvcWAvsL7sdUVn3Piaxfyh46RDRgSpgpRgrbNNsctn3QNT3fyKEXP/o1SSgEBK3I07i6wcKNgQlg48AQe9bTlxQTdZ8nJb2J6bXSsQaG+7ZT9owTvOvpacmuY9Pn2+/qx+9kNeA3Bu21SHI+WNriZktHOlIRcJ40TS4ItqqHt6VwfdmwJ7dTf7Ry8hlVXn0MELuIwtxz2Wi/ev8XZAmu95Khn5iNkJoBYTE4dGctzGaGUa/c0Bsl5y+vi/7SrDcgX9yPBiasR90U/XFimyALhpTKLZyPRY3N9onOW43ITv2A5wBdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J8Ajts4j13E7SKFT2mDKhxxdywVW41SqbZhZA6D+vQ=;
 b=kieSxyYieLiVMAn1UPJ7H5VGky3W/5cI3OBmcA3InH8SPRXArUU1l5aTMvw9PPCxy+cdRG9DGpMpEC/L3b5oy8xcWJkHEDzfhd5oVWkY7cM+cAZ+ebLcAXq0tDCM2cT7a7cVeiEamghS+7DZSPtnohSu3KjB4v/IWRVUfGfPeVswwpX/SWgpPVP725mwKv8lOYX/C80h0DanxFO8sCbWAPV6d81dQ0Or6JPHDvCel8MuaRcWuwgZJ9iwfNqces9xLcuxCm8pT4mQb2Fi2nxl7243BiRASlKLPLAaNYYXwPuAtnu7Mnggx66dW3Q2uDMCxgDzR9Z6keW7ysSY2d8LpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J8Ajts4j13E7SKFT2mDKhxxdywVW41SqbZhZA6D+vQ=;
 b=R648ONJF0OukFhfBX0S1FrO2dVHgeYTni+kOfvaz2dpI1mEtpj989YOstHc2KeLBS4iJ4Z7rSV1GPfvsnWZCODhTqPh9WD5VoHYnvUMY6KTkgEJkRmx8LcDu0U+OQZfELcIU2IsWk4jcQUErWinmKUoFKn3bkEhB1SQ6VsRTbBw=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR1001MB2190.namprd10.prod.outlook.com (2603:10b6:301:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 22:13:22 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 22:13:22 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 0/1] sched: Use printk_deferred() in __schedule()
Date:   Wed,  9 Feb 2022 14:13:18 -0800
Message-Id: <20220209221319.179648-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beccd506-6261-4d2b-b4ac-08d9ec196281
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2190:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21908EC3BF6456F378289FE1DB2E9@MWHPR1001MB2190.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRXIzrnyp09a3SlbLr1xEVeSv1PuWlZOziisZnIzXA2Imv/aWnMUDwvMNAD6u9Su658d7ysQG4IpeBinyxzqqSY0iQz+dCLEU9mHDl505U1KI6ZvQQvJn/tWuAZ8oeO9mQILuOjM2xSj8LeALoz8OIvDLlLT4DGc31ZAuaLJpGSHQGt0XIT3MYbKb+rQWuQyFiNfSsdcQrgSgk9rLqL7e4PN8TpPKfszGg1qOToDtPAv0L3loBUXziJmPguWzg+X5ci7D1RObVjde7g9TyQcWF5G5CH4YDrn1TBsaadUqYmhuMlk1RF0E8w4ZKaU0W2R7Tmm5iOXX0VygJEw7+V1zRijLA6KjauDJnCDeRca2c+GZex0HndVId3LR78N40birtqQiNF4ZklhxdwZ3unsoFUCEYUTtNZQAoSA0MpvFP9198n7zYu3ihejVsMaNglhr/b9f7jREMhsFOA5h7QXVX7Ho+dF69GFFFEZiajBebMg2D+ntyN/aHAmqYAm86VhnuoOpKLis/VM5BdvFr+qMDJT9muQYvtvolR65sIrLUA32Z7g6g2WITdMzUGPp0VNeqG0FKzlNQmcgtcoLCAdKAvMiqpgNn2PobO53s4KFkuNHUhGqkO51tZNWKL1Cb6VbVR4M0P7cFF0+v9QQcqMz2WF3lgUXnj3EiWlEWHQ0TeIcj/Kg7yFms5BLck8921JLktf9Gss0gnoK9XYOEqxplbNNR89PmEaXVFRX/hQtxIDQphu5SIkRu7sxLxdfsRr/dkNuZHUvrxs+YMJLU8r/zmJEcHx8F6sv5gt+qTxSxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(107886003)(66946007)(6666004)(316002)(508600001)(52116002)(66556008)(6512007)(6506007)(103116003)(1076003)(2906002)(186003)(26005)(6486002)(966005)(7416002)(4326008)(36756003)(83380400001)(8676002)(110136005)(54906003)(38350700002)(5660300002)(66476007)(8936002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qv6dIeA72fbof44POUIQT80o3yWJFibwzyew4XdHfBymNHikaSfU0HGPdLpN?=
 =?us-ascii?Q?1K0zEbkoA1EFfBz6cRRHSu7FiKkxuShreN9dpK8xCwgXNGfO9o8yv9wQi1u8?=
 =?us-ascii?Q?PZwQo0aBucsAsV/x5/LwQOo0E9ZAgk3QGSqq/JoSdfoPqyN/wd0qmDc2Loeb?=
 =?us-ascii?Q?Dwc1WLXpqdvi39KFS3AYEIyb4JKQUzNBEUvMm4rgniITMSMzJhH0y5QAXaH6?=
 =?us-ascii?Q?E3DEYhkxYf8FLlWL1yKCj6ei0aofUs2PScTSVP+BUfsIbOfu/LirjZUzxeNo?=
 =?us-ascii?Q?vZ9jzejGM6iGJE+oTRkw/yb0W0fh9EMQ1YfhZH++qKNPFtXVAOgJtvX8LIg2?=
 =?us-ascii?Q?Puw4kKhs34tLw8S93f+6e/qZbtp5zVXq2B4QXyuM8fLD0k3o4luvj0oZQvvW?=
 =?us-ascii?Q?uYoslZT/ublTnCtUbyCJzUuno49dcMoFZq817sm/MKr9MPY4fJsR17uG9QDf?=
 =?us-ascii?Q?lCSfckau9HzBJ4IsTwlOIEe9NV6q+lozEXBP+Dqds1/6SnygSvq8RWlfzZJL?=
 =?us-ascii?Q?lNCD0zg1Rk7RNu7c5saXj9DQpi2nksU5vZOiScmy1nBNOgWSg1n+tM/+mMYF?=
 =?us-ascii?Q?fKsCZ0Rx7/qp16HXukJT02yN2MzZR7tw2Yu58l/w01nupn72fkhnPaQT7fAR?=
 =?us-ascii?Q?k8WQ7JctgMa9sktuKTfj5E1kaA+lO9LSygC1xo+9/zTSTXESFn23DVl9S0tw?=
 =?us-ascii?Q?nmeIj4syK30oCWJl63Z4HvR7/tdh93zQiUZIQ4OtWvmqkko9tfpxyNbN0z1P?=
 =?us-ascii?Q?AtBkf0MLvhcQJyGA19ts2b3NpliQfZAc1tqKJ3OBTt1J7CBQIobmf0tpyjWb?=
 =?us-ascii?Q?C1w9/DQ5Qp88egzBsIyq80OnAY1rXDGJ/BbYHptzSgYOKldf2JU8dvXMbkep?=
 =?us-ascii?Q?Z57kuhotW3KtlFapLloZKt+JmCHCNtDhJxhjpaji/bnn5ZrjhzsHDGZ/JVtJ?=
 =?us-ascii?Q?OegvsAmWXfpv5jNJfpz0hkT4a6jfJMRoW+ZiTaFK1vR5x+lg2c7bPs1Mcd4X?=
 =?us-ascii?Q?qHOeAfC85m5G2i2+KFZ5j9wOpgDhq7GEv2GGRIAHR/TYGN2TG7EHB+EZzcwP?=
 =?us-ascii?Q?q4Wh7uOoul/ofOzpdlHiwMvArfRCqFAn84TTSWLmX6hZOUCpb7Td7F3aZ0Rp?=
 =?us-ascii?Q?CSqBktbb0JffjAbNpf8Hv8LQgIDdIn+9Rbz84ZAX1WJvOXq1i0kLBOiKeZTv?=
 =?us-ascii?Q?KCACwyLZ6dlJkr9DQkTOWzjncsw5M/JaQBYx8fceGDCITRHP8sRKtb00i6Q4?=
 =?us-ascii?Q?dZWNciI8gfQ3gUB8LrCtNU1TRWG49PxLP4uEpXG0simhzj2Bj2C2NasXR+ie?=
 =?us-ascii?Q?Z4asfreOyXC9ln1vVfNjmgHFZwOjaAsk+GKhIPqfcVK5AMYHYy83mIviY6Xo?=
 =?us-ascii?Q?kaw+0zWnpUUY3V7wd07mxkctTgH+0J5oICeKw9GJ3FzJMw+HR7pCtynJF1xz?=
 =?us-ascii?Q?iMOoFParw8MlLEYXKlehq9kWTVsgMMEFarQBe6U0q35weySOOxmdPiukcJ4e?=
 =?us-ascii?Q?3oErq/p9P506GKR8jjz3ZO554tFG2ZymwlA67eeehKFa6g9mrPywUptuQ0V6?=
 =?us-ascii?Q?vSAPBBSxQTgut7k3aNuY88OVLbzoX7f60LJHyrRH/udhw3ntEi7bQlOX8rwi?=
 =?us-ascii?Q?IhYkMdlmUI+L84Pw57qme2qRlUFNNptSVcG09NHt039ahxL0DgMH+FQUt1dN?=
 =?us-ascii?Q?5IQ1kQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beccd506-6261-4d2b-b4ac-08d9ec196281
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 22:13:22.2671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFc590ZnPURCSWBNiln9od76BpfchsbhQnEVYxTNozTDo7a89moS7vSnN538bnj0DthaglhGba/hnFfG+3JjILafWXVz5ZOcg0Uu3h9YVCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2190
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090115
X-Proofpoint-GUID: iCETQ4-4mQWnsSbHrr3Ug1qqknj3r_AP
X-Proofpoint-ORIG-GUID: iCETQ4-4mQWnsSbHrr3Ug1qqknj3r_AP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a customer whose systems are encountering a deadlock due to a
warning in the perf_cgroup_switch function, which is called during
__schedule:

  #5 [ffffa82fd8fd3700] native_queued_spin_lock_slowpath at ffffffff8ef0ef2b
  #6 [ffffa82fd8fd3708] queued_spin_lock_slowpath at ffffffff8ef0eafb
  #7 [ffffa82fd8fd3718] _raw_spin_lock at ffffffff8f805a93
  #8 [ffffa82fd8fd3728] try_to_wake_up at ffffffff8eee1f8e
  #9 [ffffa82fd8fd3790] wake_up_process at ffffffff8eee2425
 #10 [ffffa82fd8fd37a0] wake_up_worker at ffffffff8eec67b8
 #11 [ffffa82fd8fd37b0] insert_work at ffffffff8eec7997
 #12 [ffffa82fd8fd37f0] __queue_work at ffffffff8eec7af2
 #13 [ffffa82fd8fd3838] queue_work_on at ffffffff8eec82f8
 #14 [ffffa82fd8fd3850] drm_fb_helper_dirty at ffffffffc1d3cea5 [drm_kms_helper]
 #15 [ffffa82fd8fd3890] drm_fb_helper_sys_imageblit at ffffffffc1d3d010 [drm_kms_helper]
 #16 [ffffa82fd8fd38b0] soft_cursor at ffffffff8f316906
 #17 [ffffa82fd8fd3900] bit_cursor at ffffffff8f3166da
 #18 [ffffa82fd8fd39d0] fbcon_cursor at ffffffff8f311e3f
 #19 [ffffa82fd8fd3a18] hide_cursor at ffffffff8f3c6213
 #20 [ffffa82fd8fd3a30] vt_console_print at ffffffff8f3c7e42
 #21 [ffffa82fd8fd3a98] console_unlock at ffffffff8ef1d4ac
 #22 [ffffa82fd8fd3ae0] vprintk_emit at ffffffff8ef1ecf5
 #23 [ffffa82fd8fd3b40] vprintk_default at ffffffff8ef1ee29
 #24 [ffffa82fd8fd3b50] vprintk_func at ffffffff8ef1f8a4
 #25 [ffffa82fd8fd3b70] printk at ffffffff8ef1bf58
 #26 [ffffa82fd8fd3bd0] report_bug at ffffffff8f7dbbc5
 #27 [ffffa82fd8fd3c10] fixup_bug at ffffffff8ee3592c
 #28 [ffffa82fd8fd3c30] do_error_trap at ffffffff8ee35989
 #29 [ffffa82fd8fd3c78] do_invalid_op at ffffffff8ee35ac2
 #30 [ffffa82fd8fd3ca0] invalid_op at ffffffff8fa013b7
     [exception RIP: perf_cgroup_switch+330]
     RIP: ffffffff8f01c26a  RSP: ffffa82fd8fd3d58  RFLAGS: 00010086
     RAX: 0000000000000002  RBX: ffff99013f7b2708  RCX: 000000000000038f
     RDX: 00000000000105a0  RSI: 0000000000000000  RDI: 000000000000038f
     RBP: ffffa82fd8fd3d98   R8: 000000000000016e   R9: 0000000000000039
     R10: 0000000000000000  R11: 0000000000000000  R12: ffff99013f7a8010
     R13: 0000000000000000  R14: 0000000000000000  R15: ffff99013f7b2700
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #31 [ffffa82fd8fd3d50] perf_cgroup_switch at ffffffff8f01c223
 #32 [ffffa82fd8fd3da0] __perf_event_task_sched_in at ffffffff8f01c538
 #33 [ffffa82fd8fd3e18] finish_task_switch at ffffffff8eedd460
 #34 [ffffa82fd8fd3e50] __schedule at ffffffff8f800794
 #35 [ffffa82fd8fd3ea0] schedule_idle at ffffffff8f800ebc
 #36 [ffffa82fd8fd3eb8] do_idle at ffffffff8eee794d
 #37 [ffffa82fd8fd3f10] cpu_startup_entry at ffffffff8eee7bfd
 #38 [ffffa82fd8fd3f28] start_secondary at ffffffff8ee6f6e9
 #39 [ffffa82fd8fd3f50] secondary_startup_64 at ffffffff8ee000e6

While certainly, the perf bug which results in this warning should be
fixed, and I am working on tracking it down, it's also clear that this
sort of warning should not deadlock the kernel. My proposed change is to
enter a "printk_deferred" section at the beginning of __schedule as the
rq lock is taken, and then end it as the lock is dropped. This style of
fix has already been proposed before [1], but was NAK'd.

I think enough has changed that we should reconsider this change.

First, one reason for the NAK was that a better printk implementation
was forthcoming, which would only write to atomic-safe console
drivers ("sane" drivers as they were called in that discussion),
delegating the rest to a kthread. This implementation is still not
upstream, but in the meantime we've had several kernel releases with
this sort of issue present.

Second, another reason for the NAK was that WARN statements require
immediate printing, since the system may not be stable enough to print
the warning later. Though this is true, warnings are not meant to be
fatal, and we should hope that the system can limp along long enough to
exit a single context switch. Even if that's not possible, the printk
infrastructure contains several ways to allow the buffered messages to
reach the console even if the system crashes later:

1) the log buffer can be written to several places via kmsg_dump()
2) panic tries very hard to empty the log buffer to console drivers
3) crash dumps contain the full log buffer data, and debug tools can
readily reconstruct these records

Third, since the posting of the previous series, commit
57116ce17b04 ("workqueue: fix state-dump console deadlock") was
introduced with no objection, to address the same deadlock in a
workqueue function.

Of course, I'm not bound to this particular solution -- I'd be glad to
discuss alternatives and other ideas. Thanks for reading and
considering!

[1]: https://lore.kernel.org/lkml/20200927161130.33172-1-zhouchengming@bytedance.com/


Stephen Brennan (1):
  sched: Use printk_deferred during __schedule()

 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.30.2

