Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9EB4BCAD1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiBSV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:57:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbiBSV5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:57:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67499659D;
        Sat, 19 Feb 2022 13:56:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21JBF85Q022899;
        Sat, 19 Feb 2022 21:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LVUK/8FqhmEAul4PL6LNodGZl6czDngFZsJzuL+X93Q=;
 b=uA3ntgtYpGrt/pvMjRKgZxhsEb+zAvfNfCpRGtbL982JwDl7FZmeExOgSxo5v2EkuoT0
 jXc2F5/Q195uyux23CO8sBFeb3Wkf48eFF5adKeVEbqNPuS5Clj2LjE85jEwIz7TITTk
 yWGu0oZ8QVrQ5uH9XBPb/89madRM1NmPvEkM5NA89N6fODaV4KwXW/YPVkhoNvZ4vyVv
 mVLYrVqJF5/T7OFyBtzdqz7JFzvY5z+fBfv5R6bxV5QQvO1xkC29yt+/Yeq8LZUsvVtU
 pMGN6V51YJAegVm9D5L6qxpVDNmxaGF1kUTG2B0QaphLtHYgaYB0/5bI1Hk2AqPRYW3f VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ear5t104f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 21:54:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21JLogvq028898;
        Sat, 19 Feb 2022 21:54:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3030.oracle.com with ESMTP id 3eapkd33s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 21:54:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu3PuWDoxgt6XKlzgXGYZeeN2ekeINGCt5410jR4htbFZjLTWgTVsCz6BDiUzXTE8e/8PTQiFWtf9lUSYxjBpk6GeiI57Pu6hGuBdh1LXHFnOvQT3sxLnETUSAotOs6HQ4+hig+BlpwrHg/BewZbqPSGhDUyy6WJfluOr/OZ7Jf3psJGtREvID0fW1E2Yiw5J/QmCq84BCJo/H1k4irOD5i35ySALWquJ25IQ55FDmG9PnKhsrWr50rAEnTxAmiaKDo+3wUYnyrrtZxMkZM2HVlGXB/qiPN6BB57bQaG6hP70rsfuRrlH9Gjzs5xaesfCHUGbhjJPwgC2F81v1xW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVUK/8FqhmEAul4PL6LNodGZl6czDngFZsJzuL+X93Q=;
 b=S54UANipniuh3P+mWFFKjPKROqP4pmztL2N0AdSw5ShGOg3yrC+9KWmiDz79lP/tmB2AVgNmlVown23/+7z9RlfYZcNGVxFds47j7ONsBphqMGoGGQS6i0BVenwUIX+g5BzCHUhUM+a44Xymv9CiyQS+Riby4WyVcD+qHbWyO5LRxnuevI9PSLt5oOPL0M6EgiO8hD9qeuCdvlC68hWA4xjDE03vWd9aJebKtsxNOC8S5hWKH+qz/zAqg3W4KLhbeya4yoYksGgAwB9AioKkD0kjJLlLlDPwee4PLx2Yq1y3TfxphcqprKgzx9yDkQMVbHFoomNugwEG6KkVU57xgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVUK/8FqhmEAul4PL6LNodGZl6czDngFZsJzuL+X93Q=;
 b=m51IZYLAHQSkIC8NKInJFrYvL+lduOMkr+MsoU1EUKE3kly9iu0BSdZNLXrRuPACH3IcNSXxjMXdG4for//9ohLQSCNc/9cdJqkZHNJNk7QOOyzxhGetCFwNhELOLIG/UJleyciniaFS68bl4J7fbY3Vt/r5XPu08RsSzgAasoo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3371.namprd10.prod.outlook.com (2603:10b6:5:1ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Sat, 19 Feb
 2022 21:54:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.026; Sat, 19 Feb 2022
 21:54:00 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com, chenxiang66@hisilicon.com, hch@lst.de,
        Ajish.Koshy@microchip.com, yanaijie@huawei.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        liuqi115@huawei.com, Viswas.G@microchip.com
Subject: Re: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15ypail31.fsf@ca-mkp.ca.oracle.com>
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
        <5ecf520e-588c-d756-1cb8-2224535b550e@opensource.wdc.com>
Date:   Sat, 19 Feb 2022 16:53:57 -0500
In-Reply-To: <5ecf520e-588c-d756-1cb8-2224535b550e@opensource.wdc.com> (Damien
        Le Moal's message of "Fri, 18 Feb 2022 13:18:49 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32f849cd-e563-4b6e-b905-08d9f3f255d6
X-MS-TrafficTypeDiagnostic: DM6PR10MB3371:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB33716A7C76207FC8DC8AC6148E389@DM6PR10MB3371.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RfhzabgkLZqvfhIrj2kgrwLvwsP3B+vMzXADQE9vbeMyfXn1g4qlBzHtY3XWZ0/bXPgucmdOCfNvtvM7sYWmAplBQpazSpAjlUsUXku9ZVriEdStSotydVtJe+cbPofmwAAQG4QBNdaRShYxCvLFEKfQIzYMlfECLxYP5KL0xWxD1z4G6mgobMCY5hRVY3G1z4X3UMrwN6c/5+tLaYjvcBRiL02+6UBgYfZq6aqkv90TpFqGVVjuoxAIc3ZdhupYZMajLXlI+j21F+CRPvmzd29hYbLHdsZSJ9atvzzzxOt5wK3TLnrJVYGdKDX+eMxwqliNMCI1Mlie5j0vI/+++vX9bqNGDKtsJ4012bKp0FcNxudKFIKAR+xaWAJkzK+ae8Qn16CVIjSRamCoSOthEFFXDr6Bx5JzAmqQm4DAxHxyN1yoLB1n0pSJzJjZ5JfK4VPBN7KQDuj8uTCMB3pfLAvgkPxbrGiVqAybWROz7+qxaUn8THTfFAD30myvzi/8J+7vYWYU9sI6Tw5M2ZsD/QW8PajS1QR8bQdSuwJqZe7700bR2SKEX7MAxzz1HHJy3cYtiLXmgsvgVwCzCtfAe4WcZejBxW5bWRfAttYsFWKRqEy9SB/L/2oQ4HPQZfE6wYiIB5PBWHG8zTxodwRW8ARBBIdVvPKDroaZCcobwI4DnGWlOAltUKselxzkCDRkcg5TnVj0anZ5phsZJve4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(83380400001)(316002)(2906002)(86362001)(508600001)(4744005)(186003)(26005)(6506007)(7416002)(38100700002)(38350700002)(5660300002)(66556008)(66476007)(8676002)(66946007)(4326008)(8936002)(6486002)(36916002)(6512007)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lKf2aXEvg/mjHaZydk75SR9HiM+0Om8a4sVQCMCWxr5kesePWPCsVVt101E?=
 =?us-ascii?Q?KqIs5KB5PA3DAdTUZ4gLQ8rUe81LgxnAAN5K9qfICsSD8JEvdGLsgl39s8lV?=
 =?us-ascii?Q?jxcCHcfbl0/1rQx9WkoggZw+Hf23iA07ZhkIc0ZVYJhllbiII1u7frcRMLYd?=
 =?us-ascii?Q?0ElZIGrM0JT48M152YJhLIVBstE3HP2I0Ou3/bloQgLA+N8pU4m2qCevPw/W?=
 =?us-ascii?Q?4T/VlKT6AVEeOMIy7l6HTI35YbTZOb/CAztih+CRhvduK55X9kWAVKbXHG+y?=
 =?us-ascii?Q?lQTfsvdLYRaTPGIQLlRygJkiQCudYb0B1bITbWJoFX1qioh0V7j21b/nhsrH?=
 =?us-ascii?Q?ftHa8TyG6UhFN0/3jXiA0QtVZsUZ241C3K6eNUqbhwKz2LFsseogFHu/44HJ?=
 =?us-ascii?Q?0HMoPF27bST+zMLO1ZKNh8PT0wydMCcI4KS0zIAIqhhIJupse+ygh3kL2YG2?=
 =?us-ascii?Q?nqV+KPkDIGLfD9w7ftjh9gIYokTZgdf5hckeOdDyKTvXcd+lQUc0ZAjnkCZT?=
 =?us-ascii?Q?fj/in9hIE3U432NXmRvLoQ/ncJ1c6+S+B1IbGBDe550fNra5EJ+cLspu/tnN?=
 =?us-ascii?Q?z2I6kAL59XrM18BDQPzXsBi/owVrTj5MQGNPQ7NSg3Xe9iLcbLT7C5TOp6GT?=
 =?us-ascii?Q?31zfXBgPjj+d08ZyGdQmr7cxWDp3Z5F0CSHVH2eOdTKWTpYqPr8gVXv9BSFb?=
 =?us-ascii?Q?txtF5Kub3XsHbz+5+GK67HWQasodTgNj9icEJAsEX0OX8bHOLnloLrccQXbN?=
 =?us-ascii?Q?ZgtySX9DI+sYsf6+k03MZy5IqBcxm/rbTy5g27gIDZ9CD5FyA2LQQOJHElKW?=
 =?us-ascii?Q?PNQYcrAc6c0p2BvyViVClyArRclOqYG3MW6/b28aWIZeUDUbrgdimblE/ccS?=
 =?us-ascii?Q?Wwi4OuCGQhA90i3ho0DMh70qnho0IxDgO0zlaaRuU9kobwNx/tIHog9GWDrp?=
 =?us-ascii?Q?lAR6K72qjCxqd0S6BZcGfLVDsTJDFuS2leVrzQ3MoXIgRiSVSOQCafk6Kbga?=
 =?us-ascii?Q?DTVQtrWrTx3RnFIJbQRpO1u//CR5FNnrvh40Yrie7QF02bH9/bAFpM/d2C+x?=
 =?us-ascii?Q?/OftZNRbpDe9TzvL2uLW/nuuqDOm3tQkx7GEYSu104pI0oDmgnk7+mrHV7h7?=
 =?us-ascii?Q?tn6dPtcm7NOOpDzS9pAOqEOIbqFcCWM6GQYwAa6u7mIDMgDIga6xIeuZBIEM?=
 =?us-ascii?Q?mUZm2tcrtbOxMeU2ZlLVF3Mvwq8UFRGZiIkMAUwjjLU+QT5jfKyg4Lh6sChG?=
 =?us-ascii?Q?+dwFq5l0mSjptczMxMvfaJ5u7EiRNF8jQnvdA5szmAaTGvW/JPkeIGnYAmi5?=
 =?us-ascii?Q?EWqs38fwUVgx1hkii/o9dzixXEMqLBpxix98dwK/poYIwSSmzEP5j9Kyq9Hp?=
 =?us-ascii?Q?rWZcpWHGAzoVvLOeg5BG+OlmHESc7/fgsi5bXLhaCxpPzkYQjxbn/4161WPG?=
 =?us-ascii?Q?x64dOGSM5HPEu8d3bS9jrGGsKiKFO2ntJy3YnA6Wdki8o9KK9V01MbprQJXm?=
 =?us-ascii?Q?wTunNSzjw0f/wOCjP7wry35bOqv8BKpbBfD1EM9z7Lccaf7Y30a6vxDLn/cc?=
 =?us-ascii?Q?gWv5fGOzWPX6WlXkRZCp8e7mVQSZHeDZzErU153cAHjhRU0sZ/nDCckdbL5E?=
 =?us-ascii?Q?IHfgsJcx3FLyoCXEkHYf0XDAaW35oAHg5iAgwvbLmfUbpP/4Zy90iUKrBXIB?=
 =?us-ascii?Q?JiQWMQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f849cd-e563-4b6e-b905-08d9f3f255d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 21:54:00.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCZ420T6H5FLZsunzUfEWmY/+IUqQaDrXkojAhal5OnHG1LrogZ90jpiDYGhgyEDd1SZb/diX2mB3mybzOvK8+froeF3zV4ClCg0pPjn8rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3371
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10263 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202190140
X-Proofpoint-GUID: YBL5NAHZruCVlR-3xVvLfOJoNa1nRg9T
X-Proofpoint-ORIG-GUID: YBL5NAHZruCVlR-3xVvLfOJoNa1nRg9T
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

> This series and my pm8001 series have a conflict. When applying the
> pm8001 patches on top of these libsas changes, patch 28 has a fairly
> easy to resolve conflict. Let me know if you want me to send a v6
> rebased on top of this.

"fairly easy to resolve", huh? Sure, if you manually rework the entire
patch.

Please send me an updated version of #28. The rest of the series is
fine...

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
