Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0A4D812F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiCNLju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbiCNLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:38:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA5D42A02;
        Mon, 14 Mar 2022 04:37:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EAvRxm020117;
        Mon, 14 Mar 2022 11:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dN7VBbzNU+wTIWePI+RhxpAwik7Z7V5GJkWLcBGgNvk=;
 b=c2S5VZZaLcHcWcbKuRqhAx6ev6IuyS6xRSeW6fqDLfIVK9CZHJ2yqoI9nKDF1iQ/CgLE
 Bdr+0iMaslhwnReVAGN0hYVHDA4f5kg6FeTjsd/uvBCYAiwScRZakVRTd+P7P601qRzD
 myNWHCXGhZ1MpyMb4yt2ppLWxowPDAi3t9X6OJG+pFdvymfrfrKYBUa5L7hv8sDiuRgw
 TRSpeGJ0DdD/LkzHk8rbqPl8c2tpHHhoXIhIJCfu0ejzEzTIu6BxxAZKcLE2r8Zk6BXw
 9wbclzbePGrATRNgY9Cs59n8XCLKpKgBcDKZBSlN2tnQQbIc0dF/LRHMb4CxoyiDN/9o kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et4dk026f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 11:37:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EBb5IQ150647;
        Mon, 14 Mar 2022 11:37:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 3et507r03p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 11:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgqvF9vdR1qdew6CCQ1DGhjkCOoKY7UcplZNbWWVPdj1RdVkG/s5XEzGkxf1UyVZyvb/eit7snrPkfbHiYBp2Whtx43yldMxYFZbXtPRJR+161rJNX8sV5QH8rBnfXIBkgjRrM3Cr4FfTrRS+pxVknH6fBeTALDRgYlyI7xjCuDWWKbvFwZtUi2MyNopWehW80kJovFBM/Dt1++g57JEqiCAMkDgvESgTwwQjwkR4zT5IfIIbSL9/fHAvFMKOuYkUNbCOGksJJH6RolfUp78LSutr1/ECFn0tz6xpQEOITRmshRGCHfkdekKoRg3A1u7o2/uSSgGhmyulAZYiaHWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN7VBbzNU+wTIWePI+RhxpAwik7Z7V5GJkWLcBGgNvk=;
 b=ntdvl47oZfe877lnGdU4QEf5sLmxvl/tffR/HHWJGTaUTxl7ys9PcKLRH8l13A1WJ+OlRfkDOO2Hc6c79CW3OMXapn9ZvS1cNimvjFv7KiNFubeYhBmNzf5RyLWEC2doQ9+UL+CizTjI999jLHLH5x9stKF5NY9Z468SwZrpwoHTd/CFJ6hOc2yXflGwHPwmQT47p6MJNGhv7RWIij+kmoaPDsqBULbgevaP8F2J1UAcPivWSo8t+AxZUNKOOY0GbHUUw5wH6X2tBT2llsPNyi7CGM70SmOu5URwPi/+i7yf9OQpDZYUI78BtVhY3pE18A0KcviNtMu1A+D2Wte0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN7VBbzNU+wTIWePI+RhxpAwik7Z7V5GJkWLcBGgNvk=;
 b=Rm0srnLLoZVsBG5NtdWU/WflDVZ4+Ljr9qYfvDdyIL2oVXEs/bXJXA+DDQPaHv9VgV/3DBp9teGOYIj4Kv2uW7mNLZBPGzCTNMbkr/8mVp7AnRL75o0WI4DY/DQ3YHMbbd4T1OvJFmjljepEEKBROs+0Socr+354aLD8VVAEHeI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4252.namprd10.prod.outlook.com
 (2603:10b6:5:215::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 11:34:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Mon, 14 Mar 2022
 11:34:24 +0000
Date:   Mon, 14 Mar 2022 14:34:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        James Smart <james.smart@broadcom.com>,
        kernel-janitors@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 4/6] scsi: lpfc: use kzalloc
Message-ID: <20220314113407.GM3293@kadam>
References: <20220312102705.71413-1-Julia.Lawall@inria.fr>
 <20220312102705.71413-5-Julia.Lawall@inria.fr>
 <846e22e76ba9e4c620df159b073bbf4e058a35f0.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846e22e76ba9e4c620df159b073bbf4e058a35f0.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3281e28a-5242-4851-4655-08da05ae9722
X-MS-TrafficTypeDiagnostic: DM6PR10MB4252:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB42528BD5967239E418D67A828E0F9@DM6PR10MB4252.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oV6pQvx1Ihf5EUkjLUnDdMto6AptrnV0vyoRyfOkmTrgxzI8toBj3KbDjpViJcoceo55T1X2NasGCxN09dWVwmQ6ce7WqDrLhwI4U4Qr1QrQxfq/d8P/xS8jL0zJGfJC+Km3aA1uVYyE0MMI7+lnXG+VPlnE68COToB6naJGPwtRT6i7YRkwqUIPGkZVuphak8Vxmx+kzPKuFzqxZz4zOtagrJv0XMjkDH4ri5aEbE+vXj5CTHzHJwPRiiiKwahc4OKQmf/w8TRES5hr+DB6kfn44095sANwsbCKfGKDAsWubzVwieVeFlh3wQF9iD9onwhXEaSkn9fstHZ7yeKJuDoALK5zu9Iqju0VCWFpXkYJIz4cQUR8CU6jXEsFxj986ukLvGjf5Dy+QujFHASEXmxCC2eVVOi1rzHfRkIIwsTA2pZNOQ0x2dVjHOnn4ju8V09hJMoMSkf/qoQf4j5ds8qdmHBT3sLIxurBP/5HpG4af27deOIcD5txt7nSQV2VuAecKLnele755bFA65AvZBoVN5sfXH7ctlnrEldVYSnbDcMeG5i6A8S0/YxK7fiB2Ns2+SZuXMDxS1bojRSCCFsKsyhfWTvY9KjrKVRetbLjuKk8qdu+x9iyK3sMWCzFgIUtP0SitrNJcpt2uG0+e2RcSJC3f9GR+S+K5AwiMkeN9XmmDY7R+aBacwjV6ESFU3OoqX8qPAIzPQQC2QTC1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(8936002)(38350700002)(38100700002)(1076003)(66476007)(66946007)(66556008)(107886003)(52116002)(508600001)(4744005)(6506007)(5660300002)(26005)(33656002)(186003)(9686003)(6512007)(44832011)(6916009)(6486002)(54906003)(33716001)(2906002)(316002)(8676002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDwno1G6P1bYLM3lo9mq+xo42OvrRMNgwJUDpqk6ioEQsEns2V7STfX0vy5s?=
 =?us-ascii?Q?Xcei1T2G3SrP7+ABwHnR2X5j5L99zIy5Lt7Ht31QBV2D0ahdUxiGjs0Z34aF?=
 =?us-ascii?Q?txV6vT5P0M0nzqX5neIJFIYBrTp2LfOyPfUhmju19KCWRgJTXqtG6ZkiLcGz?=
 =?us-ascii?Q?UJxMKXmMBDZszk/xMx6VoAt9DTwTI/ftVnh+8PUctbXf2GVZo5pFdhIOS4Am?=
 =?us-ascii?Q?l/CxgdrxpZ20Qx2s+rtND23sFZSO0P9YhZlGqROQ5a5nnyIZjxkP4tpGZg1i?=
 =?us-ascii?Q?8DFvZxys4ATa84lv5VBmC8VItTBu7VCakQ7YZ0+NVSQmu/tDqk7V3dQkPr6U?=
 =?us-ascii?Q?e2lHXrMJBnzu5nkelMpKO49R1Nfl5yTdoKTlPlBOH147P+PR6HvipVLNOW9S?=
 =?us-ascii?Q?KHguG3gaPW+ojqXDKr6m+rt7pCzeNF1G20ug+/pzQnaqBT8WI5JwORL4OEOd?=
 =?us-ascii?Q?Nrk9Shzkxcabzb7U9WP8ETpVgU/3K9F9ZQ8g2Q7HU1/8Dp/e80D/tA8mSH4b?=
 =?us-ascii?Q?y5ENZ4x/J9E2sASfGS5CgETLtJP6djeQsUuTcqNZibatzgbzqB/nTGhhsJNJ?=
 =?us-ascii?Q?LhVbLm69mC6h93xSJv5CVkx9IgpFKRS53jsP8zJ1+OC6Q2V30O0EAhbY32Xc?=
 =?us-ascii?Q?m5MS0u+Ot7kIWmzv4k3mPn7opL7exL/taVufWkDdHNYJmpH7mb9Bs74Q+Tbx?=
 =?us-ascii?Q?W3wytqa0eQ+gmBtBp26bk0ED14R/21a3VOQZQ7bM1IDOJCb68tx/WFyKFnRi?=
 =?us-ascii?Q?1Za3rjMjhRI7lw5w9B1MTAUv7UY1HEioqt76o2ummcWV/hsiYk8AuzGV5KOe?=
 =?us-ascii?Q?QWJ0gL3sj3ThdedYSk2251dvm4e4OHcT3ZdYCRZJXbWkLdrgNYy5cti1aZ2g?=
 =?us-ascii?Q?JZidhsLHknsGI/6UOKYE5kMtQpUNRfrZWIUxjFs9Qx+84lxjutTg9dj2pOmB?=
 =?us-ascii?Q?wkaSkT+fpU/tDpp8dGEbs5evmk+lf7O9uuqY3yY9IEVrVSMbgIZmJRZKApZN?=
 =?us-ascii?Q?28qbyzb20Q0GyYYfO2+2iH4qLTlVIitvISzV4Z37WywY6dR3GO7tMjRh3fjU?=
 =?us-ascii?Q?D9zyyjtnY6NU5Q4E3/gOQ9a2DT2fBhjiAAN6uga+bYsJAbLgqlEaaWYg+B+8?=
 =?us-ascii?Q?fCG2t9jgdd5jV7y87XYcialrhTIi9NWgeG+RMN3pgx12RQLVHsWgPt4SCFQy?=
 =?us-ascii?Q?tS0m/1Jf4Mo8LdjQng+cx+WW9pc6gw+QYEBKtcYEiEywK2fd/V7L+guEDAcq?=
 =?us-ascii?Q?JtjlBS0Sva7NIXdiulwu7iMJJxTL3cE1/Zd6i96fw0aq/WRc2hyM7wtgMOlm?=
 =?us-ascii?Q?37MwFkyrunuBM4psaEJIZh0RO6899rkz8KSAkiszLfP+SPJOfUgpgepvRcjl?=
 =?us-ascii?Q?6BuzBiy/4SKM5sUBKu2V3Pqzb0QMEwdtDo7YdIzKFNj7bAy+8LciwWdydAc5?=
 =?us-ascii?Q?GZh0di/dYZ32d/W86Yyj7xGETGoMxyTbCfAqglZgIMU2DDEHuf06DA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3281e28a-5242-4851-4655-08da05ae9722
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 11:34:24.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbv1/jkpS0vhkBrJlTRtVlFKiB/QatSpFTdrMnQz0wTfmo4ZdQKRT3P/ECBvIOJMEW30svkGjYdDSpOadDE6s/+giV1q6RTCNRgxCiw/j6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=860
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140074
X-Proofpoint-GUID: q49q1LWumz7dsiLAgwC_wpHJBMOxrQ9A
X-Proofpoint-ORIG-GUID: q49q1LWumz7dsiLAgwC_wpHJBMOxrQ9A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 01:45:01PM -0800, Joe Perches wrote:
> On Sat, 2022-03-12 at 11:27 +0100, Julia Lawall wrote:
> > Use kzalloc instead of kmalloc + memset.
> []
> > diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
> []
> > @@ -6272,10 +6272,8 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
> >  				 phba->hba_debugfs_root,
> >  				 phba, &lpfc_debugfs_op_slow_ring_trc);
> >  		if (!phba->slow_ring_trc) {
> > -			phba->slow_ring_trc = kmalloc(
> > -				(sizeof(struct lpfc_debugfs_trc) *
> > -				lpfc_debugfs_max_slow_ring_trc),
> > -				GFP_KERNEL);
> > +			phba->slow_ring_trc = kzalloc((sizeof(struct lpfc_debugfs_trc) * lpfc_debugfs_max_slow_ring_trc),
> > +						      GFP_KERNEL);
> 
> kcalloc
> 

Did someone have a Coccinelle script that converted kzalloc() to
kcalloc()?

regards,
dan carpenter
