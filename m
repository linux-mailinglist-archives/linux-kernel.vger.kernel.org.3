Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1224BCB04
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 23:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiBSWTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 17:19:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBSWTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 17:19:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1CD5675E;
        Sat, 19 Feb 2022 14:19:24 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21JKNBNw007169;
        Sat, 19 Feb 2022 22:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Y7K4X3UnVjMHEjU/CKdwh8bg6FTCi/XWi5j4nBWZhBY=;
 b=lWKcqqjo8TMhyQ2d6DOzYJB/McBCde6KbLTytDoBA0dlUUUhfTsiKf8DIvstQzjFDu5E
 IIs08Z1xBS8jymmcA/Pmm9ytls9Ns9+80+K6heOVW06CosiIac4BIO2hAliXEoISNF2x
 DJ8FvEPs8JT1naos9td6Lj18ADuuY1RbPU3HI45enCTXdoryt+L0ki4tyWOdkTxVC6b7
 BFyCqmcq6AB+2Njhi7V8J2ssu01hdrNAcW86LomY8tRjqsQftthSaLU48NPyygzoaK8b
 RtdfyMYXSEMVsp45u+4EbYlVYSZBNaJwWpcsQ9J6N0PIYASDo6eZ3QU3MsCklQQVJKoR jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eaq5293j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 22:19:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21JMGhG8169969;
        Sat, 19 Feb 2022 22:19:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3030.oracle.com with ESMTP id 3eapkd3dpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 22:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFnVaxZonOBI1+DCV2Py8euu4PZT/JExCLtZTFHNZycFHi6fCdzZZ3MVCU8c3AXy6+G9Cy2cwEKnzfEuq4H6YcBH22sRXRP6OOQZ7tKXbazx6Samh6AvbKxzKPaO59LszCzwKDqBpqEBrhrg5G+96ipMXQ0o27LUDSCcw3Il1pyD4+KM1Th15tjQHMqCrxbWdNFiqrMlCiuDzAmE53KXloRVbof0f0M2kvfHi4TUhnw+U67SOM3GXu3jU+1LB2Wx8gkG/Rqv7HuwBQ42u/VjFd05SmrZOGfXecRMStWsTnGDKMiNAO53Ukuqm2SOrVfAncopAaESsxob35SXBg952A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7K4X3UnVjMHEjU/CKdwh8bg6FTCi/XWi5j4nBWZhBY=;
 b=QfIRQVKeDGDvHD8gfdwN9ffrMhieKuLM+n1V/jWTG+QyzEhd9PuP2meIkAPJ+twybP/robwNdo7lVha554QjWJ7NhINgFiuj2kBXZWexwY5cmb5cWpGvl1w0uzk6EVStzsycBC578zP4S6/6kCUETMx6j4r+os8Vjdm9Cvga2rlXtmipYStS6XPB+whG5AQX94F/zEOA8e9GO9wTHkof+z3GhGzFVbeecZb/xrn/xkffvRGgS/xP96Lhb0O3qKJgncc5so6NsFigtKoA1QRcspcw0S68ROXOqFt+NMLhMQh6CoePheaIVnKjaLXL77dHHRYtc5tm0fgunOJ9ROVjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7K4X3UnVjMHEjU/CKdwh8bg6FTCi/XWi5j4nBWZhBY=;
 b=vSVNGGHIRKgnMuU+AmgsVKbi0owRVTar2z0dEh8g7OjH3gE5oLoznNOQotfotj20Jo+Lm2qgTiy4PjwS8NtdiQm+EVL7CU4KF8/3g7JBd/Pk9TgVfKTMFptF0Ca3yDpQVDWKlXFqE+K9Rvldd1jrb63SLLo/+tQZaJYUlsrooT0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR1001MB2407.namprd10.prod.outlook.com (2603:10b6:910:47::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 19 Feb
 2022 22:19:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.026; Sat, 19 Feb 2022
 22:19:16 +0000
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     bostroesser@gmail.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH V4] scsi: target: tcmu: Make cmd_ring_size changeable
 via configfs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d9qh548.fsf@ca-mkp.ca.oracle.com>
References: <1644978109-14885-1-git-send-email-kanie@linux.alibaba.com>
Date:   Sat, 19 Feb 2022 17:19:13 -0500
In-Reply-To: <1644978109-14885-1-git-send-email-kanie@linux.alibaba.com>
        (Guixin Liu's message of "Wed, 16 Feb 2022 10:21:49 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb3d40f-9edd-4766-a460-08d9f3f5dd9e
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2407:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB24070428E96D26E79E1766B88E389@CY4PR1001MB2407.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8xvpvIDRBGyJsb1h/9QlLCmRsXOMHwyJb9ySQOHK0SXXqhmiJl7/JIbvrd8w3+yibdcu2cas39mdYca8haJdy9Za0EacTx+C8e0THexTP5y15aetusOFXy6Ox/yuvnbRLFLVVFtdUNv1f2wRw7Ihpe6P+zF0Nm/XM/L2NacOxw1VxfnTstM61dX4kL1xBvYen6ZXqApquqD9ke6csD/iRKv5GDc6r6NUf2QtUB+tDf8aAEEV+2w7P+5M/ggFwLLpY4spGRn4fvppl+cbiYytEi2oZvPHnUdZpw4YF9RBe5V73y6AgiLtz4/T1LNNv0Wbzp5nrhEf+DR/UavMQz53Zoqy+MZjgVHi5NXfH0jBL6LVLCqBEkkkczuEcLDYfvbakAfKzLWeaX6GxiAlHM7xgnUXYJuk6rlxsKxJ4jc+I7kRZWYNZm7o10BXfK3BEUw5Y2MUqp8FQC1UNJmq3lVDxFmp1SQN+GoWP06508QlGAF4DjouTNUTZXo5hSsJbJHDMpLeIquJ6Mh4aK8etji+rQF1B1uh3HX6v4n6GB/jJqonSCUv4UMAmmkVn/z5tGw/UQ4YgILRfx1Lh2sF9nscvEQk6/epOAKj5izXHJlOnhSCrZrpbbVkQiYMYTJX9L5KwKax7yUxGnFv7+SBvHKuRj1p2a7zRnyAerjwd/Cxom0k/iZkJZYeosmXAxXPS/lhkKbUex6hPo2vq4x1pEMDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6916009)(6666004)(316002)(66556008)(8676002)(26005)(186003)(4326008)(66946007)(86362001)(38350700002)(6512007)(6506007)(36916002)(52116002)(5660300002)(6486002)(38100700002)(66476007)(508600001)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JIuJy7u2euA+P0w93PIZtGBt843cW6t7dlp32VSwvRdyXd4xLBazBKd6L9WU?=
 =?us-ascii?Q?6RDMo6Kds0cm35tgbAC+bfDDCoIy07GGLNQnln/NK9Y8hCSBOuCO8IKrxe6e?=
 =?us-ascii?Q?gmrVrje2zbbJV3jOeodChVJZcGji8+ALI26WUAWJxU/aRMvGwzfa0ZNf5HZZ?=
 =?us-ascii?Q?Ss/HTAlYSucCmCnVk0Oqg1nduG/dktqyqOCOVe7w4YHq+CnLlW0Hu5D9/5Kv?=
 =?us-ascii?Q?8JJCQdvgonVYjLDYxtc4kDllASaQsknIS38cVgM4gUxsGVn5Ltktm1Tg2pd2?=
 =?us-ascii?Q?H6flVdulR3mZokKPcveO+VXcqKhkt227R4xGa+dPOhRdGo4vVV1Ate0Eq3WT?=
 =?us-ascii?Q?P8eWIAYAURIXugUjoinpLdNC/QUrOBpksVR1rmEmfcWq7oyRfVTAhwhZY1cX?=
 =?us-ascii?Q?JsDlvEKuJ7F5j6rrHnCWVhBubuxhmxcS2lJUd9RK7ZPMmRYNBq/2gnaQwHpp?=
 =?us-ascii?Q?FV98YKLb0AzEArT3CLlefT1wBL9OxWBMFEBSG9lGF48bCCanwh2G1WNMcJ//?=
 =?us-ascii?Q?37xVCwEU23J0yTbddwWsfJKzSDIyY7tcbPW/J5+0zqGO51kLfMBOTCH5ReVp?=
 =?us-ascii?Q?tH2J8zfNNk54Ad63aw7jtTJRbZ1PE2rnRF1DXp7WLDG9QCB8xTasFvcVgU+c?=
 =?us-ascii?Q?U7Z4KQzUiAYY9gAEfKnsKVlbPBI/2sOUlLWRmwOMLzX6X++gTFP7h74l7LOJ?=
 =?us-ascii?Q?YmgOpUKBWVsL7efRlYknrNFMMiflFFghRLv9B8SaFUFIoFEPWrGGa+zAug+T?=
 =?us-ascii?Q?xuWPpomR+enq7wT85Tr5lStaTtcsJnPwerObqY1aQNEN2HQtS93fjZ7vl64a?=
 =?us-ascii?Q?2PcoKpliiKpMk3jpgmT+eVnT8nJa19N7N/wAqJOwRw6kowlxvZW6bDjauDjW?=
 =?us-ascii?Q?/0GC/8JgA7EpD3Hsjp7DhsTwAieo3X+v73ZOKhHu8ZSZBXpiPhEwb5CNy7is?=
 =?us-ascii?Q?eq3MChy12AAHkl/XJ3HHFecz0vfBe23JPLninqxToELUzeN5u7qfT1223QEB?=
 =?us-ascii?Q?758UrgQKPFKwOQH0OajnhYVPTdB80KwnKPdB5AFjgGK089mWZ4pIQVx61Rmp?=
 =?us-ascii?Q?kD72NWtdfIFhiSvtYtAtf6A67+/WuTJrqmH0BS6fJ7LSph2vb1ezmSO6KnzS?=
 =?us-ascii?Q?XlR+Mv2IwOld7U2Ro/9xylEFJ5Er08t56LmLTywKH/OQOO3/GkNTBwmYmIml?=
 =?us-ascii?Q?09XMx6+GWUkuIiRy1VfM1vpjAbxV9ggC2Z/pVoNAPJRwyPt87iihtLnzmEx6?=
 =?us-ascii?Q?gFwW1oj0zw1Vb0EPNeERu2BDj6+V6+OcmdTvYzp+vgRoGbHQsWjnx13UHDwM?=
 =?us-ascii?Q?UsNjphORRA8AFezgv8Dliit3KkekJvBfNxfKwWjUCns7dtBlpaW9UlIG/lw1?=
 =?us-ascii?Q?agct+Fi+ZWgz3bidccGTf0E9sCKNiVvazNUssJ50+RWDOgaJY0LpG6NUkoyJ?=
 =?us-ascii?Q?WnRiXjUUTmgX4T7xdKnM03oatb8KpIWIBrbQIEBi8q2JXTeUikk4dtnR86Tn?=
 =?us-ascii?Q?79qOHj4g+SKHqpV+jXZw9JxQ9KdkzXSmjGv9kXoo9WnRAzlTF/s7FQrFlem3?=
 =?us-ascii?Q?jzFWLHQ2hy4qOCtQrAhVa2wp9c9G9W9VskvLLtBP24KsS2gsekdlbbm7aznQ?=
 =?us-ascii?Q?/4azS3N8jJjSOBb9QLY2t7EtmnAhRDrmhjc1cG+XP6+wwHF4vq7lG5PTVuLB?=
 =?us-ascii?Q?4DHZrA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb3d40f-9edd-4766-a460-08d9f3f5dd9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 22:19:16.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgqycpH5NppTaaV46b4e0Cnriile/B0/bhSYrD+uwOEHBaQChGhE6EGFQWD6280MtOXGUu7ajwRbljqT0Q0cVVbQGGFn9JbEz7NOhVZyh4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2407
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10263 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=849 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202190144
X-Proofpoint-GUID: YNGNznIPWy80rUf6i_Ov-GY5jjxPyuss
X-Proofpoint-ORIG-GUID: YNGNznIPWy80rUf6i_Ov-GY5jjxPyuss
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guixin,

> Make cmd_ring_size changeable similar to the way it is done for
> max_data_area_mb, the reason is that our tcmu client will create
> thousands of tcmu instances, and this will consume lots of mem with
> default 8Mb cmd ring size for every backstore.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
