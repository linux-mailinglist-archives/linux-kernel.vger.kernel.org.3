Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76CD4BCB7C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 02:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiBTBdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 20:33:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiBTBdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 20:33:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417638BF3;
        Sat, 19 Feb 2022 17:32:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21JJIVMv023158;
        Sun, 20 Feb 2022 01:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=0SXVgGffFWaf12dlEqhDHiAK54iEarAc3GoIwHvHYrc=;
 b=bVWYrc8W4O8G0+sLxbl2U34tnXpepH1sYyi9UwTbKxdsnC7PxFScaHXDNbMbq+sM8+Ob
 pv+kmkvM/170WqZUOWYUxAgkptKDI5qYGucNQrhfDn6wnxmZ2hcS3cTrGf1vByvRFism
 UU3EIKK0qJ2SE0VNabd9Lm620xmiMOQZdb5HOzBXhURbNa/YmUK4qXdKinSpjRxe4sSv
 MCbMGml9PJDoKbsecHDYkk8/5OlYAp6p6JqpX5b8oTztLoRJaku79+lQs4Jp3Hw6aFVW
 kZo0cU1afegTAAl07Fj/FIX6ZakuTe/aPaqY0FXyll3cBi70kaj9OTfzxfhCnnHLqqXh yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eaqb398fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Feb 2022 01:31:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21K1GQQA165504;
        Sun, 20 Feb 2022 01:31:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 3eb47x7fw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Feb 2022 01:31:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmMpqYgkjbqPnxwCLsy5z6/HhpIvS+owSuFX1F2uVB8vX9OzOdr70N/cn4rcKzG2DNBUKRIjJNrB2175RctW3yRihIwGHOLJt7Cq/tdXr1YDXdwRcsM5WpeBV3NPR4MPyPqJjyWuvxlfXf8aHu0b9E3x7Sv7BI1jB+YttHgcFeViCDTPgCMq8dprkzKALN33GbXb81DIJ2ULLpe6dimECYw9otWEmXEmn/y2YPW/DdlGghf5C3Au3P0u9zwzT6SW8g6BBNW9pZDfminhrk9v7LA2n+rjrppRD2Zrf1uaKn8YwewiShB+i5OjRYCAKdw6mQ2LO7m+cBD45oWtRJ5irQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SXVgGffFWaf12dlEqhDHiAK54iEarAc3GoIwHvHYrc=;
 b=mCSd21P6wJxb9ANi03Pk1fnj97AUBIdcaJz4DYOgv1puos7B37B+pG7wcBnqy6uouzyL+QEJIluIIRLH+62p0qSIeL7Xosu3SBSHCgzk+Qffih7Y/s8xX6oF+wu3JYF3hXlUIUdZKMD74Wa5LxnFq0mCIwNwSsHvjXWHm9e4SELZUJ2yo5JoGOgYqmY0xX9pycIKmDzZ2f6siQ6aL00XYe2ugwVhyby3+IvPNN/I4EV9z0NBt89nqmszk10n719y49GXXmg/9GXxIB82QO87mMYXSgfhJwGYyJZoK83NX2Ij5py8wyJlO0DPpJAciFBB5XzI+53mJ7gKFU23T0x9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SXVgGffFWaf12dlEqhDHiAK54iEarAc3GoIwHvHYrc=;
 b=wE8dHcTlf0S07d/MAYgsTBhlZM5ijwcAzyaztn6gpG2q77iK+cDczDKTMhm1VvGf0IqvxzYIZOkXKfa2VvtpS5Y/yqjbvY0C48/iR1bgEBOgW6JxPgZxwrLYTMj1ElPnzQccDdU1ge51ouVjAAMRoOf04vndOD2TLZrx/NexOkw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB2965.namprd10.prod.outlook.com (2603:10b6:a03:90::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Sun, 20 Feb
 2022 01:31:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 01:31:22 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, hch@lst.de, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com
Subject: Re: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ee3yfhnj.fsf@ca-mkp.ca.oracle.com>
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
        <yq1zgmmh675.fsf@ca-mkp.ca.oracle.com>
        <b9aea895-4b24-4529-0d87-5148e6990c95@opensource.wdc.com>
Date:   Sat, 19 Feb 2022 20:31:20 -0500
In-Reply-To: <b9aea895-4b24-4529-0d87-5148e6990c95@opensource.wdc.com> (Damien
        Le Moal's message of "Sun, 20 Feb 2022 09:38:01 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bcdfb47-c37d-41f9-526d-08d9f410b3cd
X-MS-TrafficTypeDiagnostic: BYAPR10MB2965:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2965DB28EF638D57CFEB865F8E399@BYAPR10MB2965.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buwFdlwIxMvLwx89+B7C7D3TEs0sK2Q8XLvR5PGBThYVhbnnKCSssb38VkV0IaI0qfdrnLcCplFsAQjdnjqThdkylKVTLMh7U1eFFniKu9hqg88+/K9bGD4j/FVxr3tTRw8KP/SCQxJ1vIiadV3i1Gw1Ywbwy+ic0pwt2WcAdbSfPg5v2TYsDxtClf1rbLh0K0fRS5aV10IRl1MoUUI+6bWHjS/1xziVsyFB5k2t7WjE04fkk/2XBrc+Mlnt38Ghq9L00TIG7uf/ik/XxbpHYhSZIA7zSWhmG74aS3OY04MpwAByRl4B8b0XOH/RpHy88WQtPum3rVV7w/KhoUfpS8ubUYJg7Y9NjG+SAW1ZX/ZD7a5qB4QigepJsI63UV2cJ64j8KePQHyPJ4F8b452D/WQhGEBpF7WGL7IIT/h0XRWCiBB/eV1alN8VFf7TsKBUzBN4CtnJbIulahNcsAtUeF2aOJeIkcMNPZXLT0kA4+MyWuI6Oka5YDYdy4REsKaCBUG7iw+DPfHFOE4EjKaoWrtQKTczpxZQRlYdU3WVLp8yeV3tAwX6emMIbtVK+ZDKTnDQU0jrOkuWjaHpXAZosz+SzYYXjzyVz/BsL0QEY2MvNuLt+lyRncdOtppUChNwcUK9y2/q9NO3nefmTZZyoIzyfytcReHg4MbRKIMmGo9pRXoUNGGPqqLDfGZEqg9I4O+XttG84EAlApixGpcAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(86362001)(66476007)(36916002)(6916009)(66556008)(66946007)(508600001)(316002)(54906003)(558084003)(6486002)(186003)(6512007)(6506007)(26005)(5660300002)(7416002)(8936002)(2906002)(38350700002)(38100700002)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7GUZ218GLc0AN6tTUrWsclT6O3anQM/TYXAosJITIkydPENN7S0U30hwvm9?=
 =?us-ascii?Q?Z/vnVe8yoimcvfHQyRxkTRVLpNqXESBuE2gsA5MjBC5WPjX1ZpzMvSX+1EZW?=
 =?us-ascii?Q?Z5yrT+M95IXUjx1Avo8oHUZ64f7rl4Khc4H7MTf+Yyh272730gzO1OURdV48?=
 =?us-ascii?Q?CQJTEQqSwUcFfchnIBJIKn3H1SPu+T7pDREPFNhdXO4AaJMxtNcK6AeCoTIX?=
 =?us-ascii?Q?DfBbDKY91sJ2MmXRp3vy2I4ZltZul54WTf+Xs36ySTUyzd/X92oGQupZOtQK?=
 =?us-ascii?Q?1DnAAPX/LEnCQDqRJlhD1cWiH1UR40RZQXMh8tGh5PPqBq+kTpKRPlNZJSjP?=
 =?us-ascii?Q?wqwxvSyhtLms7SVjHk2y9+i627NbtTKORohTykzgstyNk99+vi3dpLAU/2XU?=
 =?us-ascii?Q?PSCKKnh9Zexw9AgQX8+Jaiq4NrCj38w5zulwFW2uS538s1yshxmFvaYu+U5x?=
 =?us-ascii?Q?kuZ8tt+pfUXXs9Z9c9exELmORIX/OOPCla4+/bp6CwSbDQoTdUOm/sMgGBgP?=
 =?us-ascii?Q?vyJvPqO8MYQwvWvJXLWwRvcclQLkTqPbY6CwlvbU5VIFWF0+2EoU5N5FUhhG?=
 =?us-ascii?Q?N2T1exbsXxaGDGGKGDb0uKF3TgbE7GdKM2tjTEYrVswlfkY2zvPnyj7Ehd4e?=
 =?us-ascii?Q?Tz99YSd56KK7vTVfGVDO+GfaRqV0OVppUKFBotHyFiKDE98bc52DJPTa1GJI?=
 =?us-ascii?Q?YjFxBaOJEO1lH7DmmXkBhEwS59XzPz/Nq0ndYikRytphgHcgEVA8hMPGCpup?=
 =?us-ascii?Q?t+45HQ3Igjfh8Ofs2qu2uhlMhyMt7e/nwIADxioXgE6UKr4HpIUYoR2VYuYX?=
 =?us-ascii?Q?Vuk1LwkkzcyesTG413mzxEOjo0S95MFqfLbuxh1xpR06ApsgEMSyI+OLBUFh?=
 =?us-ascii?Q?yyoYOtdWbvW5vbKnKYxMZLiWnlJvX18RlWxh0VSbWYRSs3DJg+wBFXxTZPQj?=
 =?us-ascii?Q?OdL5ZeyVYIBds8GuoamtJXhzTrl61LIXMN72h3i15VBoczNP7rnEiis2IhuD?=
 =?us-ascii?Q?Xjy49aW4zTsWnxpxTKKDAfHUcH+hTW464labecaGRUWVVD3mGjpnFLVz3esK?=
 =?us-ascii?Q?WiaE3QMVGCheQT1sVwL4bA0sA3Y9qBRrXEP5PRdmM8DuU71zkWEhg4R0TO16?=
 =?us-ascii?Q?qD8HgWTJ4y/NpHLENnhHIukbdnmFxaN9ZJA6Oi16DcTPZErqseKXBVG6TMOH?=
 =?us-ascii?Q?60JpmHg/nQHTfEQfmKyeeivpLAPciR6JCHsiDOIyALqG7l4ZLRANON1+It/Z?=
 =?us-ascii?Q?7yvdbJGX+pzn2tHiT6xrTuJdtrBd2zMwlGGGy8pcEQK/AdwlZK4Av+AD+xKo?=
 =?us-ascii?Q?uu5p89AIN8FRJ3lRq9T/4RiWAyp6Atna+ItcQFrg46VJ6mkEW3asAVnBVXQ3?=
 =?us-ascii?Q?QbH/9TjNQvCsBUQkiFflzYHqkZRpaZvpsSR23R3kXVBBh0+6/bB7VQwSELXq?=
 =?us-ascii?Q?EjGn7oSQ5U2AHOAvAiqqdsOppFZVByyZdeNAYI7D0nVTusrCfBA7xbUcblAd?=
 =?us-ascii?Q?H8kFt9mexu4r/EmeUrKsoLwne7iS73Rcy+6maNEJXKP9PGyIPQNlR/RKMNJT?=
 =?us-ascii?Q?28h7X+RJ5yqBglzmmVQs6PqSDndrW51P16GYq08FYgsnCn+gR2aN3zWtyugu?=
 =?us-ascii?Q?Ekyaz6zEbPwGqVGLjRijBs3LxTbeUlYLd2SPP/hd3KNrf7uJUAEk5oQFyQDw?=
 =?us-ascii?Q?8b1FnA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcdfb47-c37d-41f9-526d-08d9f410b3cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 01:31:22.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXbYlqLGVfQgbh5z6Pd6BvFR+WnDtVnZaEQAid8Tcf+j5iomIa50XUFzqVVVPbIg16UjD9xCpwtATFaZpJuC7YienyswbkV3phcRFV/WE18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2965
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10263 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202200007
X-Proofpoint-ORIG-GUID: K9UynKx64K3V7LWjrMjbthnRKO_0jQ2r
X-Proofpoint-GUID: K9UynKx64K3V7LWjrMjbthnRKO_0jQ2r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien,

>> Applied to 5.18/scsi-staging, thanks!
>
> Did you push this ? I do not see John series in the branch...

It's there now.

-- 
Martin K. Petersen	Oracle Linux Engineering
