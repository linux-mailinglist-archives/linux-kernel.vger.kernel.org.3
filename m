Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7B4C9C68
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiCBEXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiCBEXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:23:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E945FAE;
        Tue,  1 Mar 2022 20:22:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222acwJ001848;
        Wed, 2 Mar 2022 04:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lRfqt23968NaeLy54gpWa7Qcgr6/LoKev19x13OfQWY=;
 b=XXoGxHbzWuZW246W2ctJgiKztUL9Fa8L0SBnseSLfCrq6oye5RYHMDKp1n9WdXDV9e08
 iJpO/lpbWyom42Ay9VayTgfoiLW/WVVDjQhn5qAggdrZk31vUWa+IU89Os5GrEgzOWTy
 a8FkpjzVAKKTwepJoCKMUszMz7p8TQcgCSdDpggwv+yquwQN2efxRwabmcrMIE8QTCXQ
 u0YgiM4kbW5JXIQ8fcaPcwK5rWtvFMppwBr22AK1B43ynXxfGABUCrCOw7MnxgozhvEM
 MypXM74/2vQ7+/dc2AnaG2fIL0k8wjlMdkSLTEwTc1hKa/L5GT6nYpVOqhAOgiKXeDlU Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k44r5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 04:22:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2224G1DH080552;
        Wed, 2 Mar 2022 04:22:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 3ef9ayun48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 04:22:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlqj8kg2WYESFpV96uE19xjVgVcScAMJy+JwMhnvOo38zlWXLMGAYgabYgdqoel9TtzihFbYdi8K+6sCWepbIDCwCrUXkmX/oGo5MjqS1IdTyvd8ZcPnoxRzP64/S6u+sNhYojWFyJK9xPlaq3JbpTeyKZY3LHakh3aowIfQ+p84e+C/oMRO6FKsj0Dp+F2eDpcOS8yIaTa3WTn3H5LJO6v3S9JsDsGEX9uMikVCoM/9WjvvWjjwaeun7F8tLQTZthdMqR3ixI4ZNTjWoYrgJ0uS1t3aZG3cLo90+4QDWD7eACxSufwTE0g/AhX9Ua+8uThjiTbdeVirDfyPp73yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRfqt23968NaeLy54gpWa7Qcgr6/LoKev19x13OfQWY=;
 b=eYTG1v+FhlZvRChgCkOfEzg4HkPZbWuVz2FxYbA27P2lOqjKOlhHgqbBg2ZrzC9xtF1e7atRjjrPliasmoGLoVLWW5ygJBSqq9heQzjLs6tAfeNLHeOIMiWWFbdbv74eyz0BqnYF/vUzorBREwEAn+cnWzyf0Ljv9Z6WWRygUp8C+NMCCWtpXrmDyjpiYCQdFIs8OYF6H9NtwCy8nBaTa7PCj1f8BZ9+AWpuRCMDZYUQhBvXkV0ihF82CCsZw36zKZf7ztH0yVANlIM5YgiJNY+dUIxeseJ/pgwglcJ9ZFmynMesJyZh/zIvNBX+P8mUaqK3PYynPbLkWPzx++PDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRfqt23968NaeLy54gpWa7Qcgr6/LoKev19x13OfQWY=;
 b=a5B+oE+hkB9KFNMAydRegCroQywqKXU8WkhjgyjWvhdExi4M3KdLz5M6RcZxRb167luZS38ByncYaPzX5DIxBBYzhe73JrJcbrbFi/JA/CsApl6NMmGETNs+g3wF7uE7cu8xrH/j7NrVGvbWl0Il98pOk1XRb6hfTktBX6mulq8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 04:22:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%8]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 04:22:24 +0000
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: wd719x: Return proper error code when
 dma_set_mask() fails
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14k4h0yrv.fsf@ca-mkp.ca.oracle.com>
References: <1646060055-11361-1-git-send-email-zheyuma97@gmail.com>
Date:   Tue, 01 Mar 2022 23:22:21 -0500
In-Reply-To: <1646060055-11361-1-git-send-email-zheyuma97@gmail.com> (Zheyu
        Ma's message of "Mon, 28 Feb 2022 14:54:15 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c068ea91-8221-48e0-df0a-08d9fc04405a
X-MS-TrafficTypeDiagnostic: CH2PR10MB4295:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB42952F38EBA49752007319C38E039@CH2PR10MB4295.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJ9aAMzVIfR6NFshib/lxpNH0nz6zGVRRHmsD/USmW3SG+zI+QX7jJ4AS4xCMflJwJnYbnsIqrSY0zbBi+b5cCp5X7Y6u5Toghm3Om+wSpKqHyvRrHv60TNAvuw8k8JxILnfbIEPxGPDWXMRKwIKcQ4I3TjccPDR3KjNN6680M1cSwv+qOOpXPY9Gqpzr4meyIUwRzf/lLbEmbfru7+kyIuIrH6qcmF7ESyTQnJI3doWEzjkI/K+mlTsC8BaOJbibhjKZmXcZDu8Vpm4wXQkgcyYqRip9iUfw38IJMGVSGPFpRaATg+W7mcuIF++cSthYhqbhaj0Td1qjuav9vlVl/PoHx5YZjhcw6Y2AUsPB+cB63KxyVJ8D482jZDPg48EB0YmV9si/jfYYbl3Ltlrvf7RS1a0X+N1Np8Yf0vI5jBBPNsj2oMI49g3UvroVyANBAt37jDmIwSy2ACTOmYVEKVVzm3UdRgbYV+seXefTz1M4bPS/oTNpF2q20xTnumKxQBzni3+DE3ojQfXX8voQB/lHZVFHg1k4rHCJCOd3MKVlo0KTNNLGT+axip3tGFFqLVl2LmG2ZPd0eiHXX2uy0RmzOYvWyFB42Hq6Yw6FUw4gqgPUeT66e5nmmnRxM4EpQzgEjAV27UlqWLbAXj15KWPBanWXxf2QekC8o6i1qL/wxPEUg8sNY8WHHqD1FXcjaedUL+Ljivw81wPG8/HdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(558084003)(6486002)(8936002)(38350700002)(86362001)(38100700002)(5660300002)(4326008)(316002)(6916009)(8676002)(83380400001)(26005)(186003)(2906002)(66556008)(66946007)(66476007)(6666004)(6512007)(52116002)(36916002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vQPlDNnqeMWKJjcZykJW5sEaJpy6f99N7JQhJrXu1qToytndITG1MTQ24d9x?=
 =?us-ascii?Q?wwmT7O0ZsqoyR3FfuGDXcAcS6yJU/MteEWDB/GTBSKJnugNyFMKFS7EQnZbC?=
 =?us-ascii?Q?QzhVltH9gHnCWVtwV2XalqyA2/F9qSuFUt6FCRY0ihdpeWWkPTVnWmNFXpOI?=
 =?us-ascii?Q?rrM0zVuPtucQGRrVpibc/0AYz4EfZjXubEJedFJikJoOT6QktByf9VirAyp0?=
 =?us-ascii?Q?2TbFw6IIB1rBlVd+XLD5hkEM4DDEo7aEEA+GHF6Ftq4ZtIe901WUnAu+vK5e?=
 =?us-ascii?Q?wraaDSSSnVRXIinpEbIfSFLvfum5kTdSI2fF5C3O9nnChcvp/fN/6bBncRol?=
 =?us-ascii?Q?Ok9teGzbXGKYaafTiUWEcIt+S9UTEkDjBdDRqNv22I5efO84XsweL+ldHy2p?=
 =?us-ascii?Q?6RoE1v5uqO6p/gBYAb6hEot/+YmETl44lQ9ZMxcTk7zntYd95H3rRRIJJ2M1?=
 =?us-ascii?Q?fHf7StW7hh1vVU/GcLgqD1HAsoJtJMUKB884oUyJ+pYw6TfoljFP+In4NPcS?=
 =?us-ascii?Q?qtxCriNrPpLhDgluSSQmUnREyUF3EK6p+j7OUsQRgOjfrgihrv7oyPmf+2Qa?=
 =?us-ascii?Q?GJ1O2nDKQVUkuLvaKgjFmWUa5dXmb6y+mBJxqscnKv2SI6zUP/b/FTRNflOQ?=
 =?us-ascii?Q?RNPed5q2zwI3ptznc2C9kjaw1JZwip+dloV1ue8hHwhMXmOO5riWiCnPbrKQ?=
 =?us-ascii?Q?O8JdKimkq9GIKnFbwxwhNVoKqbli4+pDJjOG5KfztWlhcY48EUssfE317TZr?=
 =?us-ascii?Q?TpDUFL320AY23IgMqrgXSEu03IAwzmgghRROT2ieP6hiNKMdMURO3ceJD4eu?=
 =?us-ascii?Q?/o+1aUBnHG36RObDWwmdplkxNUw6a1EzViqt5EIhT+N5vnmkoJ71vVWWsZxg?=
 =?us-ascii?Q?zvj/cki3XX5/DPTkND/AoHE7h5+nEBDNLZ1nXo1yJLdFDGOI9npnq/xv6Fne?=
 =?us-ascii?Q?fF2qjtw3XMGHUqQYfQvuGDCJq69uDjUBixPBRiPjmBnJWEJ8oj40KTRy4etX?=
 =?us-ascii?Q?uP7Rt4J3yXQyNjI84lQQImcArMG3++kCYbDgeVyvtJ1JI1t0/sHw0OfShL8+?=
 =?us-ascii?Q?px4PZ5/+RZ/JogLBbsAmARGdrF0XXeE034EBC75XIviH8nFui0EnLkGQz/wP?=
 =?us-ascii?Q?rQI2N8sF4mCF9INLp3KjdL6D4gkj5KLH+OPIUGHklIcFJ64ku2fx6HBW+zid?=
 =?us-ascii?Q?BnWp1g7uDneqvOtmS+LNUQFftwUmUsF/q2ivZ1lcBAe4HOZ7u9ekaN8vTV0F?=
 =?us-ascii?Q?nVeVV86Vgq2pdAMto10UGuUWQXvAFBojy+4gkzqM2tqdbXSH5l6xqfbjQWwG?=
 =?us-ascii?Q?mC3znPczmbI6umHOYfMfYKvc98jzLP8Te6NT3FOXWkN095Gp6WqIInDkrnG7?=
 =?us-ascii?Q?r7yhVxwkUgOl8hq2XlfPM9AmotBk94rkQA0HKxBHMz7zEVYFiGSQLDgNKVXs?=
 =?us-ascii?Q?nofwnBRQG90fUCghBl7eTyGTS6Sr66sSes+wYeY2NF1i/fImdJOXnvjIUVBW?=
 =?us-ascii?Q?4xLqsS9ibf3iyvYCEp2/lN8hBIC5Pz1sLwAS5+eIdotQ/3858miNY9iN8sbt?=
 =?us-ascii?Q?K+mFRXNCI+oZil0Dp/q3vxZBhWh7jJJJyfXJtVaQEGH42z5gOADZI93ycJtP?=
 =?us-ascii?Q?UqQ2kHfmPrQDk7+Wkf1qQmifHDGeFgsDMejYBRcdOmHwMre3xfnsKl/9ltQt?=
 =?us-ascii?Q?6eCdUg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c068ea91-8221-48e0-df0a-08d9fc04405a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 04:22:24.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2WFlB8bIwyQb4lu/mQbZpKS0AZlP4ZTcD7sBt1kjkn7CZNkQXMBTGuG4HgydmwBrbOTy0l1uUrfLnvCvlvk5lYg5eykBXj81DA+DE8l0k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=809
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020018
X-Proofpoint-ORIG-GUID: OzMsC3ZUe4HFzeWM_u1Xol_Y0ksnnSsX
X-Proofpoint-GUID: OzMsC3ZUe4HFzeWM_u1Xol_Y0ksnnSsX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Zheyu,

> During the process of driver probing, the probe function should return
> < 0 for failure, otherwise, the kernel will treat value >= 0 as
> success.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
