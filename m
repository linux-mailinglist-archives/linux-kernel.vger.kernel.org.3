Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0C4EB938
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiC3EKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242458AbiC3EJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:09:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EAE1770A7;
        Tue, 29 Mar 2022 21:08:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3L5qT013073;
        Wed, 30 Mar 2022 04:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=sWMR3t4Mi1TPIvLvq7e9gjBlOUT+THkXovonMPIAqbY=;
 b=zC4x2+pJJI1CApH1UlghXyDWz+OKY7Ntff7QUU3D9lJVKQtiy2+UcGw3G8ywQF9h83Sd
 FYc0jqLVtuYYQH+yy0sdFZZrkBd8juP2pQfuBESvcN523IoTDorpUoQ+vmAx6ce/3Zzz
 8dKE1Gm7vk9Yb6a8T1OVYasUwodfbka3/F5xitviRHS2UKYKJNIz3gd1h0ajyE6EU4E2
 xR1QOV2RWaybIHYIr+H6bBaHFqBxRZdCS8aJVj269FKaS16zS3XzRsTEjJ3oQwXgxaAt
 zrFzB9roJMsROQQQAl6FpqMKJGgtzw+ZWT7RjCZIxahYtGMNnfK+VUotbBHb1yXpcVgq FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb86n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:06:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U46wOr158311;
        Wed, 30 Mar 2022 04:06:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3f1tmyne1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTOig6pY4jWcl9v5LLLJeHR3isnpuKXSPQVdmw83DrUqi9oRYK2L0DtmVryoUaoc++Oeg/HXbHqc0JEudsWAS6CwT+3WhCAV7OR4tEjc7SERc5KXfqyK5ts7zlhlVLhD5g8qp+qn5WTFA1Kbx+6W6PFj0rN2yk0CTOIQ9/JSTQ1RsKEht7qXi2BY89N0WYySbDreLqVEUkv2xBpCC8p2RM7oq6I+lG+I/YHYA08adoTEQNTq1y72U+gawjblHFwbe0qLfVTTRYu70JKDH0192JTCRBdHKgfxV+XawW0ROYMwLlentTR2TSBE7lPwpOiO+Lej0wWDB9kGlFL6hFy+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWMR3t4Mi1TPIvLvq7e9gjBlOUT+THkXovonMPIAqbY=;
 b=g4SIDb5cSjdm8RVzHneBIPJdn3CnUArEj/JkknOwQ0nYGPSTgeWaem1YaxLIdF8NHTbrf46uxu9L8DblfW1l/RFoSy9tIVNQ+LqnYKF4UA1tUVzcfNYlRPBS2/2vhGf5I8YHWI1S7VNtL/J30RovOU7KP8quV3rGjj9t7tanDvYAOHvfVMgMy9qdHsmNecZOV6IQSWmYf/CipsRnf/CHIWcshXl2jI6AcIGlA22bkJ1rhsFzX3bsDaaB2uuOCvtxCtF1XpVDrIbq8Bh0/Qf8zoGoVAFLCvmr5ShSdliqQpFo+3uu9Kkey0EvJbDLAW7J23dP/vmiV2mrMERuoE8SlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWMR3t4Mi1TPIvLvq7e9gjBlOUT+THkXovonMPIAqbY=;
 b=KpKpdv3KMwp0z+eKNiBO39mdzMgYIWSsrnIEDrdxDde7+4GWARYWOphOs3uVXIIkSwOxcGUCE+bHb41tTkWdASG/lcrc1qbWRVSZhMbdZXutxHAoq3MY2LMSU3XNcYWtqCDB4iSzyIfMj/YzXXXKD6scjbJKVpnvoq2doH+8nhg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB1802.namprd10.prod.outlook.com (2603:10b6:3:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 30 Mar
 2022 04:06:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 04:06:56 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: Fix spelling mistake "mis-match" ->
 "mismatch"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgl8rsmg.fsf@ca-mkp.ca.oracle.com>
References: <20220319231122.21476-1-colin.i.king@gmail.com>
Date:   Wed, 30 Mar 2022 00:06:53 -0400
In-Reply-To: <20220319231122.21476-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Sat, 19 Mar 2022 23:11:22 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:806:125::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa3e6797-cc0a-42a7-8ec0-08da1202bab7
X-MS-TrafficTypeDiagnostic: DM5PR10MB1802:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB18021B8A1DEDA873E3F75CD68E1F9@DM5PR10MB1802.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HrPKFvxwYg2TTPXcQt2ugWfn9MYOrkrmd74EPlBzvb8eLvb1AQNXjxZmKyKTx5tnKHTxhKa3k3zNekwunpMLUt+sFWXqoMWyh39ui+pB/iDBtZF39dxjQGXOhTHwHerucKFp4qGUHfU14N0Xw/js8YlaShmaSK/WaVyCYXGfxoHgmArPQdOUHX2V0sXlC2KdlqWfOZi1XeFlj0+XonuBqoeBB/qBG27l+NjFma/2ZGZPYWay2rdS8hzNBDah+xTBzLNKTrRiONyMQeRqZzeH3hq8zCeIUvnhjy8I4vv71geq3a4vUlawOn1ptJPnFNt9SGCpMzp7HrYhDdoH+q2IL3Yet41IxKtLheO7mC2HsGa/jbX3DhnMd/uzQ+snR7agT0UqlJBykzW9lmrmUiwxbCULDiwAF3IOfWJlXg72ZdLM0X1RdsjOmjqD/hqc3LLKUN9L07WPHzmH8FJiWUZoJgg7ojYBmde10qnKLYxUVrxEl1/Jwxs4SiYkOJK95MRG+Wt5SFGiGkQ9NwZuTyEXH5HnBtda1lUTdceUd812jmKbwxhUj0nGvRynClESwHQg7jlpYaNOe3uBn+QMvPt3HdTCa9fM9B0il4DjDcSvIPwxa8Gm9ornGDHNUTgupaghuDQHR5MQEAAGp5NiOhcyIWVJ7qZqE8TPGiKEp5eLJzB8TNZ5+oVXxX6JwhdbGIhi2EVG6L69Oscnbpfza/SXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(86362001)(38350700002)(66556008)(66476007)(36916002)(6506007)(316002)(6666004)(6916009)(6512007)(66946007)(5660300002)(52116002)(558084003)(2906002)(8676002)(6486002)(26005)(508600001)(186003)(83380400001)(54906003)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tIbu2g65KVEWHSD85ZUYwcbeKJY9yESMsoiCBYv3KraugTSqc1xZkqFbyXC1?=
 =?us-ascii?Q?x/eVpIdKlTro/arHTjSfF8iIGGYTeWZDnFalB7GakGTOBdcAvCcMDe8XT1NZ?=
 =?us-ascii?Q?kRvTJylFScFs0ZOew7R/OtJ+IGruKHnt0j3vcZA+oYAD64v33O4fjllNHycf?=
 =?us-ascii?Q?ahRLHomr+j9D0T9e89L/mZCENP9RGh53xdOeUUVIzHPd7FuL9XgZcZIRwsOx?=
 =?us-ascii?Q?otl1TdEmnUL+hPQp+b99sVIkVMEE1xsCPUb5feVzmegs/c5GmefbC+TeX1yh?=
 =?us-ascii?Q?qBRkzeEsMzRhZcRkEod9H6NVWBbDNoMiR1dKi0WnSfOiK0gVglB3EsPinJ0i?=
 =?us-ascii?Q?EMstljH8jH8fSB3zi249zUXAnEnN/MxHZJQBcLdtD7Er1JbV3siIuFg7NTav?=
 =?us-ascii?Q?eEc704GsU4b2/x9W3BFJ4K0ko88BDnKVpO4qE9j05PvpJ2tiFhPBLz+j2mNz?=
 =?us-ascii?Q?96xqoTw87UgtrRFKE6J05hb/f69+tHcItvaTYTLEzmdeEsGxFqKtz452tIeF?=
 =?us-ascii?Q?3gzevV6ZDKDh89WSPJNNJlT95jHfPavlhJ5m+GTSAbcjBznjqn2m0Fvx/j26?=
 =?us-ascii?Q?YiCVr0N0qPm1Xf4EuZvpPfBptHPNTkI6xlYzT4fbv6huj2nb0eFrYkfkIwYl?=
 =?us-ascii?Q?nr9paYOlI8kXBa0VWOoSb6EYHwn5fAev/VyIexHZrQRoA7AFivXbvY9rDLoR?=
 =?us-ascii?Q?Je1KfDaAsQ8ropkXU518tOHYNhgssvH0kwKPbnMvRLgzIDQg/0erQdOEyzVy?=
 =?us-ascii?Q?afnyyRwC81LFnkEtA7k/DyXZOCP5QR2WrRWtRw8hoU53IrM4isxL/c5onSYf?=
 =?us-ascii?Q?SoVI/mrua855XoTFTgQ8dXW+XorAdESQl0M6QX4LY9UfnA2cSAUdVjmMJ4/t?=
 =?us-ascii?Q?A/tYPZLM+HL4h25z+AV+DihDK0mygAPMfPsoKJDeVAB9rWb332YS6Jc+ziF9?=
 =?us-ascii?Q?79ray7vhSCcRms2vIKuGa2dhYGlRTPnu5vtRWP117nKDGlqw0biXOtuJdaP0?=
 =?us-ascii?Q?AyVRsfHdD6h2a+lZ6BRjtnRY7pPTy1ypklx13SG+5LXd9FHnG6+mNsYur0k3?=
 =?us-ascii?Q?B/gPtNhKgi4oTDwGao8c9uQNElIgJsfWu3QTM7l2SZjdS3EJSJXS+bZLEt/h?=
 =?us-ascii?Q?h1mu7GdsfQeuFpa+S7njyEcJf7HAG9Grv96Dj7kXJYQKonm61HErZf4+Hy4f?=
 =?us-ascii?Q?8xNF7krVvMPJBCjjCYCCxVMvrjV5Sq6VmDc/+FzxA/9JgX6KCK4iL8ducnYI?=
 =?us-ascii?Q?fnWmL0zcOh8a36ltbN3b/fGumszYjUyLR2CLFCRHPdtlf3pIac12PJwph+t0?=
 =?us-ascii?Q?o2KLOCrMVkGJbxynIBU3Dy8BUKktXw1h3x0KptmKxJRaDKUKWcnQBUtfTtWj?=
 =?us-ascii?Q?xCRl9pTnTA6mq2cS/KHdd++G1yl7ayl8u7qd7PwCRlo2uwoCHJc1nPHJt8Pc?=
 =?us-ascii?Q?RjQ533DVTkKxslMGOcjURV3FsJK75g6+R5FAVHXeXTwNdXuaIXFF0VkNauH1?=
 =?us-ascii?Q?KkYF/puk6IOYHXZOoXU3OlhD1HgZFJpvLUgkEf9ZXHmuLcB2rc8Iqk/1/9a9?=
 =?us-ascii?Q?fpOncM53aRzHDAGGTVy0Y4FYF58pdyA172+0K4sCJeQHNYeXJRiDxgb5J9s9?=
 =?us-ascii?Q?puq1UZafQMGDJqJjpF0uTAMyuAdwVNJxFerbTUylKf1sEea89c7oFZmb8hDs?=
 =?us-ascii?Q?Vr44XGiOaKRVYX+UKeYV8oKsecP7tRxjSJDPH/42jx1wkgvJ9sRfJtMqVUFi?=
 =?us-ascii?Q?AiwOU7kvQtvfHZuxa4NP4YqIWZTIlIM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3e6797-cc0a-42a7-8ec0-08da1202bab7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 04:06:55.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi2UM/tvgK+0SKkjTYo2ofyqHAVCqSXNeCjzxvKzBu3iCvRr5YoVe/Clo3RnPs0OLuIYjBU0+kdXuOrRp8uEFUte4u5AUps8eHRZ8ySasI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1802
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=819 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300019
X-Proofpoint-GUID: W6aK2x4dhJKRHVsvCILKoqthS0sjrcse
X-Proofpoint-ORIG-GUID: W6aK2x4dhJKRHVsvCILKoqthS0sjrcse
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are a few spelling mistakes in some error messages. Fix them.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
