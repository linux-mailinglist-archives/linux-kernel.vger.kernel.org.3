Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584554E2286
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbiCUIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbiCUIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:50:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E537A1B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:49:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22L8VPwS031204;
        Mon, 21 Mar 2022 08:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=r1UeOi5YfYHNMLmoqo4R5sHOeTOJXUnTgQYarWWH7zY=;
 b=opip2c+gfghiuKpy7Bj4HMpCX0aRHiu+D8Al9bJemohbI/SEjMYfzxsbqaKt2O+6epID
 RvLTDRv6NqbNFOvAT9+EbXXKA+BTAOvaBeGlPfLIB5jYO7A0EALoHWihOjdVsm2M2OIL
 qZnLTRSaHV1WzOJYZ2hQaF4fHrYX0M7afBGviUdLlbAGThbRV6Wt5HLK9NCkhGCz2Is9
 ZuO2scp3bJhhIwDZT7E+27GODeGMWYBfNSWAcnnML/VgyNqYvo91zGMm7hGtjlDUFH4e
 2uyetOYeAA6WeVY/JkkujjcZY//5zmWnsCaXjEzJSMXm1g5F0Hy86hOQY8cPbiLukHYC HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0jm2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 08:49:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22L8kGp4112407;
        Mon, 21 Mar 2022 08:49:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 3ew700bxd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 08:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYbEe9coMRTahbhAiKUCqU02VsuJF4wrALEmluaE2nBKRF2wg9MeFMF/4GZnDe+MMLHPAbcWyKJqW03HX+mk8v+QCDrTe11EokUCnaVhxyz9e0y8aBKuGlclvBmO4oVGwWJ6d6q+XDyR3TyCgtOP+QH4U207NlmhbEnT/BY67rqFOYtj0ttd+DZcQYMRWunMXMTTjjgxZSfaPposFJYx0YyiKw2uaM904goFm3Lh3rWEgKTMzrX7L8uKp72Hhnr7FPhIj8CLMpBk5DO9KYPoaqpiQwRJ5H98JUX7K1LpGKuj5X46bCoEE0qzdxFrgHH5AXaCZ7Wqiavn2SZaKrHjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1UeOi5YfYHNMLmoqo4R5sHOeTOJXUnTgQYarWWH7zY=;
 b=eravQci4q6xo4U3Thw0x2sY/53C398br6qdRT8lZYIMdcNyAq0++BZLrI+Cu2I+a/+afGurix/HOcRZDOlAGQB7ixmD53Vdj9PpvNitPttHg5MsHHApww/r+whwZOxzNa9YHLPBOKhDDCYELCzyo+7GlRRJcSneqSE0xFKK6dFFETtb5tZHg0D55/+OH6eBbPbMHVDjWpmYvdh4k0NZsM8OqtvHcDW+g/ch8WkWysDOZWZyYi2xhTyHzSKz6vNAP4bg5o3o/X4DuPTcSf5eSeWtL+8pIPGTVhJ4ky4UEmA4/Bn3YdF5J81t8dYzql+R1FCACq201rU1mKt+Y/VYYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1UeOi5YfYHNMLmoqo4R5sHOeTOJXUnTgQYarWWH7zY=;
 b=hxDabBW+KG3rp8X9gekbqBcJu3uQ3x8o/Nv8SqumAZo47lvQKzFENS0DAzNdEnm3hpq5g83WYMmMBMzKGmYAgn0sDg2/XjVO56yJ/GdSk3aLNZxCahpg9iPqeYhlm6pDtNowJlzWmPDyAWPb9rFnOYZUjvUfVzzIryvpctLDW3E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5010.namprd10.prod.outlook.com
 (2603:10b6:208:30d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 08:49:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 08:49:10 +0000
Date:   Mon, 21 Mar 2022 11:48:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] staging: greybus: codecs: fix type confusion with
 dedicated list iterator variable
Message-ID: <20220321084844.GG3293@kadam>
References: <20220319202058.2518847-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319202058.2518847-1-jakobkoschel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ef5d87d-9082-4ed0-9bc7-08da0b17aa9d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5010:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB50106C38F84593D167A2791B8E169@BLAPR10MB5010.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rzdtwmt8NYVWrCJIkM6I3i8VngxIFfGvRbBSYgwjfdR33ye/1uJykXt7aVaSAhqC7FlJ9ZODCfF4Kmmv7IZVLl07YB39JoDHeB7lPMh+CaIDb/fuU+ZzyznsWqOToAtR07EzxETXnhk+d4LcYHM2I8ZI0hLvk4YoZwvEL+XRPgUnsLtkcjs/zquiSgcpXx0CxtQl81Ju+l4S2kNkF7tRhv/kHsCvqSJe79PTVPOzeR9bHPi2BWfDfJoRWIo/E21yo3nIpo4YkrBH9hJk/EbxnABjOp0cMjGi2dqpLYACaUNMHmIT3KA9EwBIzUQsqe1lOPIUkWYp7zNGst+SX0g7ISQn/AYXNXkbCcoHmQ5cQJ1zK6YsfnDAgGVFL1d4qi+3DYVhPsN/HZGsna+9vhHMweRfQB7HUZsYO76eg5IYAnUqQSi3SbMqQi9mq6vttS9PFZN/VxhG1o5U6msXC3o6ybR/nN8tcSRLhmzaiVd5w8z+QlG+7rMvZljZggmk7EVkh2IGX6tnVTkAbrbtDqHFHGTBrHcMm30VqimwHrhCRUf9X7WlhJVgw6fLhTeTtmhx7lDTeDj2Gm5QwyJreumbvgPhV7ii31rI7rhw2y2lkKpgmlECrPNHXGA1o9r/hI4dbG0Xg484fN12u9evFmdC48qG+S7CeNLM6nDy9S7qIIqTpSpCiwGuxKM09Abj+bnwf6q+roIfi/8tn7z5jlOMqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(26005)(186003)(38350700002)(52116002)(6512007)(38100700002)(9686003)(83380400001)(7416002)(5660300002)(4744005)(44832011)(8936002)(33716001)(86362001)(33656002)(2906002)(508600001)(6486002)(6666004)(6506007)(8676002)(66476007)(66556008)(66946007)(4326008)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k26kz6UBZOm9NdN/ZSJ+DKKJA0eH3pzD+tPbmSvaeU15ulR7woNVIAdXH3hJ?=
 =?us-ascii?Q?iBDVoIHsA95WK8mLZ4OvaLYfwhG3ODGwlaRRmMP56jp/JtXt0R5sqcsMBkov?=
 =?us-ascii?Q?49GdUtaJkotGzAvoHEt0eregZz+RtvlINBXwJQWDWV5vaUDs/x6Os0ZwVd3h?=
 =?us-ascii?Q?ssIWGCp3q/cbjCd7VrJjabv1iTvXNBPKtL2COSa8SO5AnyMr8BUQaHeBCVFP?=
 =?us-ascii?Q?UHOqUJLtg9XnUIahxcgJfdz4/qAZ9VTWCuigcvlOsSF/LdJjyYhGtT0zs2+r?=
 =?us-ascii?Q?Y6Ft15bWtR5J9lOYTtDZoChvnp19eL2epz1C97Kug9hY8Qezb4zn6JSSDJr6?=
 =?us-ascii?Q?/ozXcDWrdPsTpK2v58De65pGqx4JiVnfsJlntNaTE0h4fEITY6G6mO26IEiA?=
 =?us-ascii?Q?4yFJLn54ObMej+LRqxHmVgyJKkt1Oc3mWpnScMLTnFqTTfvjw2KeaPjRANcd?=
 =?us-ascii?Q?4Y0rfxYTh7/3A9BudesENHznsjKZrQKQq7vDz7Kk/AGKaWXjOZ6e390Bbrv8?=
 =?us-ascii?Q?ft0ioGtv96s4Q6WW+TULQAJ5dxZ+x8k0x2pY900Q+zVwGhV4SAq0uP4x7abH?=
 =?us-ascii?Q?dxEdTfh9dTiIDhIHVkmC72fVwTQ3W8PaBULf2Goj8Br1mNUQbE0Eh2BFyV1/?=
 =?us-ascii?Q?FH3ospPsnNKWkjfalqrNL0eesMce9O9F1J6jmUAaGdt2y23AANR61VZktH4L?=
 =?us-ascii?Q?xTQobUxJLzXOck4yOWQk6PSuBPLmttyC/tL1+A90vpS3TpOvdN3SAzayV+OX?=
 =?us-ascii?Q?WuRQIXiZEyrpeke/i8f/d7V/jA1/eILiHXN6yeDfCs+VOONfCObXSDArGp53?=
 =?us-ascii?Q?/BzLN4DL1k0m0wCazLSx4R57DOJjAhwYxna/yEmpZQxv7xnsoqQKQIbDH3Bm?=
 =?us-ascii?Q?AbbmeOQJv5oY/nGtn6PmKHq4OVpNJlySv7qzYo5lMlKEPcqOecN6PCXEgn5Y?=
 =?us-ascii?Q?3afhjK02uQ2rKWA/Qm3JEJM0kIqNafWMZ7lAIKizAu0EZMzsTk9JPuEoF21h?=
 =?us-ascii?Q?BEpQcXPwmCekel1ThMqsi4+wWv8xNWwIZM/kmuqc5QaZuWjAdlZCPyN1jQof?=
 =?us-ascii?Q?vJjbEI2tRMVKYP7jVeUvfOCIj4RRWyyRJ3Jpu//CMJgcye+0tRrs8YsLqVy1?=
 =?us-ascii?Q?lLbOm+3CRAq0EwxeHcenGrMqB1NATVI3cfCRUgLR/QYiT7d119pyrk3zgoww?=
 =?us-ascii?Q?aWDEzDxKlEhe8mvL0ntT3lgh5XFerDWxT6QHT7lySHiuZE3Rj6cGOxVcaXuO?=
 =?us-ascii?Q?j+dUjY8CajKEzfuE7sfCloXgeErR9Zt4SQ6+3OVXveq5+IkkHIgGpfk2gkdx?=
 =?us-ascii?Q?tq/KR31xnkiDBcCPcVYWo5dHtweqWFbe3BZP4/56qBPPiifaNeRwYig1OXL9?=
 =?us-ascii?Q?fFQmRQNluL8PjiSByhdmOJ24JXI/L3LqSWdyf/zCNk3i00qoz6hoMDiXDoxd?=
 =?us-ascii?Q?sriAiX3DIKDnsMPoX9Pxo7Rc9z5UrhLjFrucXsupmrndLIVKBbfz9A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef5d87d-9082-4ed0-9bc7-08da0b17aa9d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 08:49:10.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1j/J4GJifD0ZC2496Z+f3q9n5y8bn+0SVledadUWa9ufZB3PA0XfdU9Z/ut+IDLSBfYV6Gi5ZbMa/fsSC25qClHE5l4dkQsMUBdAiNLrk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5010
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=699 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210057
X-Proofpoint-GUID: Bssv3n7jwNMzQCCB_J96N4aBhcQuu29F
X-Proofpoint-ORIG-GUID: Bssv3n7jwNMzQCCB_J96N4aBhcQuu29F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject says that it fixes a bug but it does not.

On Sat, Mar 19, 2022 at 09:20:58PM +0100, Jakob Koschel wrote:
> If the list does not exit early then data == NULL and 'module' does not
> point to a valid list element.
> Using 'module' in such a case is not valid and was therefore removed.

This paragraph is confusing jumble words.  Just say: "This code is fine".

> 
> In preparation to limit the scope of the list iterator to the list
> traversal loop, use a dedicated pointer pointing to the found element [1].

This paragraph is the information we need.  Just add something like
"This patch has no effect on runtime".

regards,
dan carpenter
