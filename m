Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756144C616B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiB1CuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiB1Ct7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:49:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E880420F44;
        Sun, 27 Feb 2022 18:49:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RMXx5h029559;
        Mon, 28 Feb 2022 02:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KsU5xckTz3tuX/3wSmb46SFc3DQb0o5GPCIkkZRuhP8=;
 b=OqisRc+dHr3vij+e9IY18Kwziail3ulZz57Nns2yTJXs00n0UxVw2+XDN/r16kdrgb5s
 KnhcqPBCptkjK7Jj5zJ/ahgSuxxmqNUdJ+RhRjhLEm4MYpxQyWphALYbd43WDCY72cB/
 LJ7gS/83gSGDp5GswTfn42LODtwN7/ZhUnWAleGit2snrlr3G0t5mb83EjAHYwnMvgcp
 1ow97HsYzTf9xgcGprWy6zDkWYNKM2kaBTnk6OTUQWGhXd49Yjprn1McaUcVUX+EI+iI
 emDcfuj94XIpUhJgN9rs7vJnU29ONmC40XH9Jrw3OJPqeOhmNfvmLIu9CAwd9/R1xw47 fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efbttawjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:49:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S2jEFc110035;
        Mon, 28 Feb 2022 02:49:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 3efdnja348-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmm5GkaWT7vPDaXRibkBB8KWDn6MjU9RREnIB48Xb9x6zrJMm7i4dGXOI7z7XnvCPUVLt7cI+gQ5Nvn/bP+s5h4wri5P+8B5Bt4NO4fsVK6GooIRIDEgaKVRcktQOqz7KMfMEK2k5g2oNBOFImhHPjcdb+Pk2g6ZKaiS8212VZtM/JfCIEC32aFKZftqqMu6aXkLS2gHgR1DouXtVi6RpXhMjpAhHETRg2qAIW7swy9aMl0at42eS4g9J5GVOdX307vMgdUlx22q9gXjbuDFAfyEXUOcVNaaEtJzac7HJ3dWpRIa3N7Y4hVjbJs8n8JcvtjbRYyClLfazVUWQhPV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsU5xckTz3tuX/3wSmb46SFc3DQb0o5GPCIkkZRuhP8=;
 b=di0hsHq5UCHhQtdFvsVnIcxHXFBhfwoxSJnHLo0K2oH99NhGrQTDDSImUVi4lDLt7YNKy9jLFalBT8j4+xwXQrYl7/QvzjXleuplJjhKY0ni72Ow9Bt9H3ECpB3VTpRexA0zvGe5clo9NSPSUVCKpHDgV8wCWg7HTmEmam6Ju+QQK6SWGfGfKoHYaquV2ys1jVJdBS2IRcC0gKWjumYZ3a0a+xY+8PbqKyX9yiSlFYZgWbBrq37To/YqH6O+p24Re2r40cGVEzQspWe6TnA1+D8PjzAQdbEifvvSXD2xGk1+d8fkwynWR5KkoLqgHf2jHzhT6utjva/rdLJFCzeEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsU5xckTz3tuX/3wSmb46SFc3DQb0o5GPCIkkZRuhP8=;
 b=cF3T9RieJRvx9Bgxc1KP3xyZBDzuqffLLxzDOs8+RFbIYdsKGx4o6kiIuXkV31OPz21zzEHgS/5kZZ0PTmDzHZcTbhDIykncud1cuyYTIGY5tDDW19ekEYvttbQYB4EWlmnsgqC4A9ubN1vrpAmU512m7JXKidjDjjnwi4GGm8M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4695.namprd10.prod.outlook.com (2603:10b6:510:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:48:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%6]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:48:59 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 0/2] scsi: libsas: Some minor improvements
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yoz7lke.fsf@ca-mkp.ca.oracle.com>
References: <1645786656-221630-1-git-send-email-john.garry@huawei.com>
Date:   Sun, 27 Feb 2022 21:48:57 -0500
In-Reply-To: <1645786656-221630-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Fri, 25 Feb 2022 18:57:34 +0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 517c8463-a109-4bf3-6ab0-08d9fa64df0b
X-MS-TrafficTypeDiagnostic: PH0PR10MB4695:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB46954F82B8112F9C9B8AB4AC8E019@PH0PR10MB4695.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alvoxdqgwV/y0MF8DouWqC2oFWPd9C9bD3NGNj9DG2wfGN+aMdmXyg2y+Tbb4QBwbUWa1+Ur0jw3pjWjWYLXuAanj6+5whk/jp07R8jQXnaL1VmmUwsS7wDyPliv+BhnmMOC/X5ddKMsrYu2JHusalcG0K6ccuBHfffhucCiVtGSX5qj65ujZBxB+6U8e9buZrb5YRn27gCMNXyEunMxLOlRIzpu0P9wuV0ETK+ZR6xz8GiacWzvZuVV9TcLjTIdXB9cyN14e2nwNXl48R+F0B7lkEZjwcQeT2muA8oiQKCrROQgQqGm2aG2LzmBiqhFZD/BHydVaCAnyeHBp9lqF5iPJp1sOs92B64l7hdNIkTwkcM7nACSsgrf16dVeADGbdYJ1TC0TTwNT4c3JpmIHlLsw+6x+XJ6vtfGFIfzscH1DU1UAoSXkzfbYEc3YjZjm9J6jpT+88W5rv5/gGpmr2XbQfx6mLiJhN5OOvRmM+yrN3f+fCI1hu1Bl35p3/btgEr7k+4//AGXHOZOUoWSjMTrP+CV8jRvgVKFk3zjwgr/7VhcxtlAQKiThfQ1naLOqLTXsYzkJdVWviQlr6uJU28adrNQKVbdRf57+67Zde1oQ1tiYA3MId/v8Tbnf6PiXC0qTkLaa35nGcaS1tgVO5IxihNv5g3EUrTimHMNHpZ4Xb+QAJyBjoY5BqAkmdX1hO7VcE6Ehy6N/sNR/WR+og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(6486002)(6916009)(558084003)(54906003)(36916002)(6512007)(6506007)(52116002)(508600001)(26005)(186003)(8936002)(8676002)(4326008)(66556008)(66946007)(5660300002)(66476007)(38100700002)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ib8ZU3gwhpW8FoFNgAZ2KpBSDlVurnOV8V78TxAQX/Dz/gfHvGbnwQdqyacK?=
 =?us-ascii?Q?txHM1HEGN+D0EcGfbCE6O3TACL5mvUH4dZRewzTxJas8SHeed4YR5Bcd9Qwk?=
 =?us-ascii?Q?FECxkebyPsyc7vwNUcKQdF+RdcRxcgQvyP2wAdxIeTu0ZuybrUt8sgotcK03?=
 =?us-ascii?Q?rzbblnu4qAPhxfZVnIgI65q5II9D3TzXAFh9tmEpZGIofc2JSzOsGPGPSITO?=
 =?us-ascii?Q?uEPuDWRxlindOy3AjspbguLgK1kQDgMGm4yCXQOIwn4FzweKJbfKnfflb0+M?=
 =?us-ascii?Q?o4kZq6SOqdjKsSs65XLeNsvEV0HrGxr23gQUda+bCPxvYEmzvnEXI+nOZbdv?=
 =?us-ascii?Q?W4mOf9cW+54i91aMC+smQhaRgAVO7BLUKk4a/9If5WVV/t5uTw2rI3ccwPJk?=
 =?us-ascii?Q?qjHuTtbF8twnzz4sY18VTDzh0dXeyrTIWE+d100hWQwcw7nGFuXoUTKWuzkx?=
 =?us-ascii?Q?PKY2LxKi31d6RGrzZialmhcONcpIMXOZHXCjbV8HIGla05K0nfQOusYMPtS9?=
 =?us-ascii?Q?mIB/wD0UhYsTH18QWbKYyBrHEK7bwD003T4EePLYGMrd5YJc25SkYvfiY9bC?=
 =?us-ascii?Q?XxWBUj4Kkp9Pw+QSrrsFkw+wlBie4iSQ+ghrOs6XzIq5BQ/Ksx5s7Quu0qTn?=
 =?us-ascii?Q?am2Hmkiycc+XFpEIqOpwwcsLZBViE0PePXAq3rxcugZpd+jSGvL+t59HRdce?=
 =?us-ascii?Q?gwUp1v3lM2MdBKRTe7ovsHXTbieRZlFzKL6JGrk8aB2eJ1dCQEBD9a7WaHJc?=
 =?us-ascii?Q?15eX5jt+ASSbd9KK+wy4MSJrJO+mGxUKzZpc+SpBEBp2yAEtK2f7adezKczR?=
 =?us-ascii?Q?PwEaAUzotc58saymt8UP9jkd7O95L9xRrORq9njWQ+qlHsAraNFWFTz0tX6c?=
 =?us-ascii?Q?ZqmlKGe1mN3+8Q1r1pB9E1cEROlR1xVJpzCcegy5WhxE09C81rRczlPU2Okl?=
 =?us-ascii?Q?vPds7hCP/33CD99pzliFStek7A0gVvVNXUJbIuCjy4eSrTUfxfNCG8ueWWNE?=
 =?us-ascii?Q?BK0bpJqmzQWgnDoa8qFrYl/ctOIP47xHN5Cb3MXYnn8EVw41b2w4IfqsD72P?=
 =?us-ascii?Q?H//ztOT/Uiqv68QeiFwGbBW66EMw1bcpym/7v5yBGbG+LaBIa+T2/Az+J+ej?=
 =?us-ascii?Q?O/hp+TrIvd4TPNaYrfYCGXtg6S5wNAdlhDqXS6YeKYU5332atN2hcknWChrH?=
 =?us-ascii?Q?cuIpZEAnB/GcoTCZ6AAcMiVTdehFGWoYadZe1/9fvvYgrSkF9gQvj2UehDLA?=
 =?us-ascii?Q?jwaAaEo5l9PX/VM4sXZ5oblg4bn9CXpGhdsnTCma/vvE4YoxWbheLCYdH7d0?=
 =?us-ascii?Q?iZEhdknV9dx7+8iqOJZSs7gHNxPLI2yAm6unw+TLdhE8nj9LmOi0sFHksBHN?=
 =?us-ascii?Q?JyFSTjxVRkpFcObaK25XMTHg3Rv4WAvwuvKD0PeKEdipCQSYNOkabF7r1Vhn?=
 =?us-ascii?Q?m9uX0ymKlM3dP30dXCpqXLeHjgJa4CdHwBuqq3Oqekm1l71xU+BDEqZc2L1X?=
 =?us-ascii?Q?lmp3zhIvrGih4JEE475XMwn7kkDdlVj9in+yBgetP6kKTGrLa6C5DxBxzn7r?=
 =?us-ascii?Q?TEAQuIDBZ3HjdAY+YO7pBlK6u+S+EvgLxyhGopIrl9JS79MJ98SO3a/KtkEf?=
 =?us-ascii?Q?B5Uec8Dh/Z31l94kQ4Op4uUIjl2kk+7Yi3yrI0UOT0oFrsYgJjL2F31gdy4J?=
 =?us-ascii?Q?WYdTOg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517c8463-a109-4bf3-6ab0-08d9fa64df0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:48:59.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: didFcugny40hPrRVbTMDofcG/C9y1eabz4HCRFDElbcqvbE+0shj/Nmb459owbUyLEmiG6CDk3d/r0olfLQYPsyKIvxEoUgjayBdlvoza6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=818 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280015
X-Proofpoint-GUID: QuQz-PCbINjcr-hiwH1iWVGUSZS37zeI
X-Proofpoint-ORIG-GUID: QuQz-PCbINjcr-hiwH1iWVGUSZS37zeI
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This is just a couple of small improvements which we had sitting on
> our dev branch. Please consider for 5.18.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
