Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7968D52406E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbiEKWzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348903AbiEKWzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:55:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC67357B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:55:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMWwUA019308;
        Wed, 11 May 2022 22:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=xom9UCj7D222VS2qeTS/kLJV6GCZhWP7GqneluC8XEM=;
 b=IPBOOkiacRKiOHPnBZRoPP+KpvA+znJsskbI6g/7+EAB1W5BKv9dVAHnhAiC0bmlZDED
 4iHGIJktwk0d8CbJvKrsKJUO40MGvlDpLS7DhyB/GKF4lUxQ+EPaOvgvYlbYp4FG9orY
 pVJJkOp+UWOyKUfFr0q8dBZhJ/ecCA0dUuJCXdOY+CObxf9YIBcIa2Mz/X6AQnoeTLqk
 zYSPxrvS2YR9Sz6Nj41DrdTl+az2LEtwDdete41GvQpBZ0aAXjGvo7To7cuc4CaSMjtf
 jnFS/evE3DpUphwvPeqUKUMP2y7IRWEE83BMzJWcvYDSu9cXXOGqV0xo8jzcjP372Qav Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9tt26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 22:55:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BMjg3G002193;
        Wed, 11 May 2022 22:55:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf74wcw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 22:55:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUqerJPGWB/dYeaX0jIX/OkBklm4Sj3BAkVcQz3etgYnsrism7OIDpTPxLNsWTn0cEK7JNow/kEtKToBvuiEfppAwvwnw72VAxaHSACD8G5+T2pO0OBRRA//SEtUQ6Qyf9hytx5bacjaZyNPV+PpFvn5HY1/oDcHbRKJaPiCjDPCDlTpOjWJ7hZkFbFBTSYfFqzCq92nlZZlvH4WjdDXEuU//Bf5hSbufWCx00njsiGlOBqJZnRT62pji8VLPW3nepdisjoPcWbMdajGxhz0ZTImEIa1S4nLLZ0D/0QOzEePVZ1UvnskSUDB0cYWWPTTVIJNFY4BZMI/PbIXTPQrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xom9UCj7D222VS2qeTS/kLJV6GCZhWP7GqneluC8XEM=;
 b=Qu5nCBd2NL9v4uvHHz1CjodgBW54qGIxsoYmgEmtprqCa9qBOR3lywspQLBcApUgufvXPenaBOxszx8ZgEAgz35DfihESxAu2gEFJaDK/yI1sSIyk5XcFe5UAMetIRKa/bQ9tqGXNk5ay+A4eIPjcZtEWsqnTxn4yZelRTEt4rJkdHE65sfdF1AUb2Ms0zashCbkRz6u0X0s0tjxLdO8VWmU0l040ewC2rtYxCVVQqwOGk0zNSACOSbWN4NPeGy9SGrnkZh4t7xtSx3HYgEc/QmlhNbJiW4tBRN5cVLX171J6a3QkFZp4Ygi6JSxR9B4ubnYwyZ56UDyggNvC+UyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xom9UCj7D222VS2qeTS/kLJV6GCZhWP7GqneluC8XEM=;
 b=lNOKle/Hphz6VaUk7o2m4ghpkGJOjBJk4p7jZoP9YBUS7oLBc0w0s9Ggvo5ZE3ZcNAjuNeIm2ddPgNJ2LPyvyuIJkypGrqQ4Wync1WsABADGwN1KK2HslS0CRmZB0xHfnydr3x039XQk+Kl+wjx2DK23oKdiO+VzpQ45dhTuGDE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 22:55:19 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::94d7:fd30:ad97:bc38]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::94d7:fd30:ad97:bc38%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 22:55:19 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH] assoc_array: Fix BUG_ON during garbage collect
Date:   Wed, 11 May 2022 15:55:17 -0700
Message-Id: <20220511225517.407935-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:5:120::45) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d541c0e-640a-4e69-646f-08da33a15274
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4605:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4605B724D80683503415A8D7DBC89@SJ0PR10MB4605.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCJ9VuXqJjtvCZz5jedQpADJUguqDCypdYkNB1qjJ+n4xLj97t+XxR8+m2gufMcABTR/M1LiaZ2ri/o+jL60xVQeBwwMaM4538A4BYAYH845yLJexkWHY0CxeUfHcMvVBfK2R7o9CtAZ73k/m/Oy2JYSYezuKS5Sy2OVbbLNNkGaJi8aQAiOsm7mUPANqcRYkE8toIjLo4FCbX5wZP8J3INqPWz0oTU/wZvN/s+LeOfAbhc5RAyPfVJbzMcgJG/GOaUnVh6GTIdy8jGMc0J2GLYXxr5hgiiyNwjqSyEAMOMAaV8vwkfTlqttgsj6KKScT/g5ZKdu2zMrMjxLNIJEbDNhdKgoYtE2u5pWDey5F14BJCEixWlEugLRBwPb+9anic0P84huzpGfpLKVl4Wg6RKIRmGSSufnY7t1YWowJKeZghNm0puU0sO+SdpKiHjoLXVhJH6GfRvcQV8hksrOvMnjV8y24RAGPNcJdRJSAbLlskdchNrRNISlLfibJ1moZh9I9Y1GrwTUFdw/yv6WoQxr7eFgNrlWfIlXlNalBy1gIOJrHqcmSXnyGh1W1Hfb5nsib7owOZTTzATNuXBP/H7GenWppqtdvB3wf0EFgWFpFGBC74RLZmBw9pPDhBRP2kAbdbh5obuuOrAJ1cbO1A77JpQP8nlRxxWiPW4TZ8KBTdjtJBfZ3iWPHAEKTxo1wRqQwdcQwpIV/qHKYrt+RkRhd05NSgGOda8ivqdVYFusHH9t+GYq1l856ODrj8PDQTeaXQgMKisDvJsDUO17nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6506007)(26005)(6512007)(83380400001)(54906003)(186003)(52116002)(2906002)(6916009)(103116003)(8936002)(316002)(38100700002)(38350700002)(508600001)(66946007)(966005)(66476007)(66556008)(6486002)(4326008)(8676002)(86362001)(36756003)(1076003)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f54KLDJGRKpVqJyM8lc0L/oS8CwJbFZNkhAmT6EWEWur9ES6zIfvDhGYeCnb?=
 =?us-ascii?Q?ua0QOZCUapyMDWFWoBgx3VnNS3NAbSEofZ/+55vInRrFGKQO95vAudpq74Hn?=
 =?us-ascii?Q?1yGukqIHHkHB33kA2dSnaZVwoD+47tjPLD9Vf8vbRvqnkl8RNK6oyVaYKseQ?=
 =?us-ascii?Q?8p3HkhY/LnSBHfnrUEKWBwyjo2FTTRs4Fw/AIX8WA257Uk8qGiVtOjOmMd9j?=
 =?us-ascii?Q?djgWJnOUdYuD5Khujpjf0ckZExSl7ZSY0RMgBrdLvy0ixvo55fTO9RmznbZH?=
 =?us-ascii?Q?dv3vy8uz9OXNDp/l3bf1IHMpBgWTTvVvN4lE8AStsHVGWRuibsi4mtGz0z7Y?=
 =?us-ascii?Q?cK/s6VpimRMKsnWBzYWOVNITb2l2qZGSOhEx61OLDWDK3ZJt2I3ovtv0Wwka?=
 =?us-ascii?Q?E8zNISz3FHdtfyxbEgq9LmVeGsSOGKGn6DYuKheGhSzmmmKylZonnV5h/bS4?=
 =?us-ascii?Q?ZLblKQoI12WQshfau1iGBm6TW/W6fygsIjEOTuR/gAyNu/tfATkwqkNrjRZH?=
 =?us-ascii?Q?j9UdPwS6/pk7pgjRJ7Ce0jZzWI0+BFqS+k8Ygb7F5K9l+D3UhHdqjs1ms3l0?=
 =?us-ascii?Q?apDRxSopfW/Rl/HPSQ8kvfObcRBK6NSKKszPvpyRD/QY/fBcy35WmCE03kLC?=
 =?us-ascii?Q?7pPiLmdJxAWoQUjHP2D1ciGU4nxI65QJOdhbGFE0B8PMZslgrnavtLD2wr1o?=
 =?us-ascii?Q?bwD4AE0iUtSd3p45+x79ZNCXemQK5EJ55x8UiWwweBq9BHLb4ysStPxKKPU9?=
 =?us-ascii?Q?viTRbKP+aEE/EmxgTxyTgaau2i1DXkGtFjes1oiLNnnbWrrPH9PHG+qzAegF?=
 =?us-ascii?Q?G1cJkb65zRQrZzMkkAeoROVAB8JSz7b0IJxSgCNcKJ0RsUT/AawBYgmPfo8K?=
 =?us-ascii?Q?aKD1ZmVZRPkhq9N4YMkYwhtSMdGCb1WI9yRjFUaH2eZeHQV+bhY6C15Rspi3?=
 =?us-ascii?Q?LqIwZFPzgg7itDwiGTcMquhTVpuSWHfwR4fT/VxAIO/Hdv6YSvVNHn1GQQdD?=
 =?us-ascii?Q?GKaZm9QHgvKY8wOOXTaSXSnP535VxbeH6unZ5ExEd7VrfuXdbx141UJOjbkh?=
 =?us-ascii?Q?2M2Ts3fXtLXiaaTl1N+6GpVFkP8YiDN9oiGaWmlVsRKBlXrMHKnU8l8e7KJi?=
 =?us-ascii?Q?OnfH86TGeFp1kZHz5AU4Q69qJak99Sfn4x/MpEIZTdyBsmZYf/ZTmZFw6KCm?=
 =?us-ascii?Q?BidhV+o8zT5rrHAwVTUAje2D963s+ibrGLFHqqRyF8xJLMIZ0zvC6mYtp3Bq?=
 =?us-ascii?Q?HPtIJD2MQqkP+H2kUyz2tl7B8RqykKmgFD9SCA3755hQvseXaaLNv/KOJ8W7?=
 =?us-ascii?Q?N8JPuP5VLInL68iGUiqgXKZUFonPMHT2+6joOVr1kiHKGDoF1TpTm9vY9dUX?=
 =?us-ascii?Q?3VXT/p/bv5HCO7yN/jjsHMzgLbv6vjIABvuvtvIpJUaTaJHxrXU8kvPf7wyd?=
 =?us-ascii?Q?mBkoEtt1M8KFDpay0RZ16zapGMSr9y1InKWaKJlXnayALyhbF76wCktlZ+rq?=
 =?us-ascii?Q?Z081KLR602Ng6zWAgpxT80ybgK2pIbislqOChtlEPMDiIThk18feQy7tImAr?=
 =?us-ascii?Q?tuzlVxRN9mHEkISupfNLQ6oi9ZkSxT83MMirquj16rpPVAV4lcO4Pl4fFlrT?=
 =?us-ascii?Q?p2zdW77gNXKCPCbiqKdy2sr5S9lRzTV8cCXycygQiGAzX31CET5q5MTasfCD?=
 =?us-ascii?Q?PqmgUxEkDJMoKfD/vXlsYJBaqi+SfcvQE3F6JdxFkWnqpHK3LQE5DhJuvrgj?=
 =?us-ascii?Q?GJsSg0u/6DxTJPoXmrQAkY3ikqtKqa4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d541c0e-640a-4e69-646f-08da33a15274
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 22:55:19.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7o0UOT4o71VMMz8XGaUvQ3PJ4Kd3BffhYB+pcqnvaQ8/7WIAOGdcVFoxUOOTv2JdfPWBmtslwTVKzhxxeaUxgeCm7oFNeuY9pddqADImO94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110101
X-Proofpoint-GUID: 4D7jwguUH6_kkaWRIOc3wD33ge-L7dxr
X-Proofpoint-ORIG-GUID: 4D7jwguUH6_kkaWRIOc3wD33ge-L7dxr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A rare BUG_ON triggered in assoc_array_gc:

    [3430308.818153] kernel BUG at lib/assoc_array.c:1609!

Which corresponded to the statement currently at line 1593 upstream:

    BUG_ON(assoc_array_ptr_is_meta(p));

Using the data from the core dump, I was able to generate a userspace
reproducer[1] and determine the cause of the bug.

[1]: https://github.com/brenns10/kernel_stuff/tree/master/assoc_array_gc

After running the iterator on the entire branch, an internal tree node
looked like the following:

    NODE (nr_leaves_on_branch: 3)
      SLOT [0] NODE (2 leaves)
      SLOT [1] NODE (1 leaf)
      SLOT [2..f] NODE (empty)

In the userspace reproducer, the pr_devel output when compressing this
node was:

    -- compress node 0x5607cc089380 --
    free=0, leaves=0
    [0] retain node 2/1 [nx 0]
    [1] fold node 1/1 [nx 0]
    [2] fold node 0/1 [nx 2]
    [3] fold node 0/2 [nx 2]
    [4] fold node 0/3 [nx 2]
    [5] fold node 0/4 [nx 2]
    [6] fold node 0/5 [nx 2]
    [7] fold node 0/6 [nx 2]
    [8] fold node 0/7 [nx 2]
    [9] fold node 0/8 [nx 2]
    [10] fold node 0/9 [nx 2]
    [11] fold node 0/10 [nx 2]
    [12] fold node 0/11 [nx 2]
    [13] fold node 0/12 [nx 2]
    [14] fold node 0/13 [nx 2]
    [15] fold node 0/14 [nx 2]
    after: 3

At slot 0, an internal node with 2 leaves could not be folded into the
node, because there was only one available slot (slot 0). Thus, the
internal node was retained. At slot 1, the node had one leaf, and was
able to be folded in successfully. The remaining nodes had no leaves,
and so were removed. By the end of the compression stage, there were 14
free slots, and only 3 leaf nodes. The tree was ascended and then its
parent node was compressed. When this node was seen, it could not be
folded, due to the internal node it contained.

The invariant for compression in this function is: whenever
nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT, the node should contain all
leaf nodes. The compression step currently cannot guarantee this, given
the corner case shown above.

To fix this issue, retry compression whenever we have retained a node,
and yet nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT. This second
compression will then allow the node in slot 1 to be folded in,
satisfying the invariant. Below is the output of the reproducer once the
fix is applied:

    -- compress node 0x560e9c562380 --
    free=0, leaves=0
    [0] retain node 2/1 [nx 0]
    [1] fold node 1/1 [nx 0]
    [2] fold node 0/1 [nx 2]
    [3] fold node 0/2 [nx 2]
    [4] fold node 0/3 [nx 2]
    [5] fold node 0/4 [nx 2]
    [6] fold node 0/5 [nx 2]
    [7] fold node 0/6 [nx 2]
    [8] fold node 0/7 [nx 2]
    [9] fold node 0/8 [nx 2]
    [10] fold node 0/9 [nx 2]
    [11] fold node 0/10 [nx 2]
    [12] fold node 0/11 [nx 2]
    [13] fold node 0/12 [nx 2]
    [14] fold node 0/13 [nx 2]
    [15] fold node 0/14 [nx 2]
    internal nodes remain despite enough space, retrying
    -- compress node 0x560e9c562380 --
    free=14, leaves=1
    [0] fold node 2/15 [nx 0]
    after: 3

Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Hi Andrew,

As far as I can tell, lib/assoc_array.c has no maintainer, so I'm
sending this bugfix to you. Hopefully David can take a look at this and
verify sure it's all sane. I tested it on my userspace reproducer, and
also by booting it and exercising the keyring_gc functions a bit.

Thanks,
Stephen

 lib/assoc_array.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 079c72e26493..7ed20233a770 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -1462,6 +1462,7 @@ int assoc_array_gc(struct assoc_array *array,
 	struct assoc_array_ptr *new_root, *new_parent, **new_ptr_pp;
 	unsigned long nr_leaves_on_tree;
 	int keylen, slot, nr_free, next_slot, i;
+	bool retained;
 
 	pr_devel("-->%s()\n", __func__);
 
@@ -1536,6 +1537,7 @@ int assoc_array_gc(struct assoc_array *array,
 		goto descend;
 	}
 
+retry_compress:
 	pr_devel("-- compress node %p --\n", new_n);
 
 	/* Count up the number of empty slots in this node and work out the
@@ -1554,6 +1556,7 @@ int assoc_array_gc(struct assoc_array *array,
 
 	/* See what we can fold in */
 	next_slot = 0;
+	retained = 0;
 	for (slot = 0; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
 		struct assoc_array_shortcut *s;
 		struct assoc_array_node *child;
@@ -1602,9 +1605,14 @@ int assoc_array_gc(struct assoc_array *array,
 			pr_devel("[%d] retain node %lu/%d [nx %d]\n",
 				 slot, child->nr_leaves_on_branch, nr_free + 1,
 				 next_slot);
+			retained = true;
 		}
 	}
 
+	if (retained && new_n->nr_leaves_on_branch < ASSOC_ARRAY_FAN_OUT) {
+		pr_devel("internal nodes remain despite neough space, retrying\n");
+		goto retry_compress;
+	}
 	pr_devel("after: %lu\n", new_n->nr_leaves_on_branch);
 
 	nr_leaves_on_tree = new_n->nr_leaves_on_branch;
-- 
2.30.2

