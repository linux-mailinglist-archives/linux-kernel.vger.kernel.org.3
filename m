Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D064ED35D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiCaFog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiCaFod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:44:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE445CF5;
        Wed, 30 Mar 2022 22:42:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V42Y3B032352;
        Thu, 31 Mar 2022 05:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=OY8kOrEpZuIZ1vPB1PSkBgjW3nufbrnwEx2LsAlmZTI=;
 b=Rh76JTGeEFaO1ZNVmR706f3nwd0D6UN7czDW9Fd6lly8zpYTSTIKuoMIr7sbTE52xqHy
 OHDeNdLFzRppwcC4A8GHf20SsJTwYG3aww3qcrArvkVFBqETh2L1uCMc9AJv/cju+npi
 QwxWUwTouS8HI5PjHmHw93/tSQ85vt1tQpKzD95tCv2x+yzeijq7FMtq22RSFxysfnqM
 gK8sBBMwY0UJAV4s0UyZidGknHIYoBQfbTWmegL7ir+4A8F1ClT8OA0QgsbXcJpjgQ7E
 XGIMDyKzJVcT9EbHrat+AzMTVI58l0XR5OC1OADuMf9P7byTwmQsmod4APx7w9Bvz4KT Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctugpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 05:42:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22V5fY20152374;
        Thu, 31 Mar 2022 05:42:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by aserp3020.oracle.com with ESMTP id 3f1tmyr613-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 05:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfeKE3/nxMXRrUXm5HiLQb9TnPg3FzPyank1agOdhg/mbHliY2JRlxS/TBNYvCXE/me6NG1nuVA0IO6DuzHc0et8yKsR7u4KTQmR6w4MRbG0GmheuspMcmPUHthfRCB+lJd0r4RFr5V274V2xRRsJbabTl2t7o0tq0+WurfYKS15CYzoKVV2AHey0saqnpepIUDhWwPgB3/8iKPEmy+FWuG20+Xsuu8PSeXOF/4VKlbEEoOZWUqE3duI90epRJiOmOAdyX7UVLgm52qnPc5OX0ur/VgkwEYXP8zWaYmkqm9ts/poZ+61LIygHVV0/hYMbvyAimj1M6VJ1dD8IYFysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY8kOrEpZuIZ1vPB1PSkBgjW3nufbrnwEx2LsAlmZTI=;
 b=fxP++BZgTPJAYGhd9ETe1EhxCfdpIjc+WDFd5qRML6+YaOlufvhW6y08hGFvM8dEc27Z1OgXZi3NGSbKc+Xmq6nkusSc/UKJUfoGlOJ1aQ2TtjsxOci670OFKmKitobw9QeXSeB6+lBXmc9evPqAEONd2TFxwqxc5Dp+tXV5/B2AUM/jn2GH7rAeoLuHFv0zxobTGvT5BR3ntC+hX9dRQEZTv1mFKlGA0v1hTYakpoMJYfXUbwSjhyZswhh15gkWo82TYcnNyTcFS00rEYZLdGf0WKlfnDhirB4/wb5+CANmFBXt/iNDHMOyrr0gtdeqoiXbSJZ0uQjxxDX/8mLXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY8kOrEpZuIZ1vPB1PSkBgjW3nufbrnwEx2LsAlmZTI=;
 b=ptPoCnYnKB5yufJqPmPsmAAgpjvk1V6iPvK4A4pnH2iqtTOHzlVlZJPU9UYtf3xSDVxKmQkUG1DbetIBatlps+cl3DJWqRUCm9GZfmDVo8V5k8IEYFP4dpJZy7s4SldS2KED9CvdZ7gsKhLLF7j1USV1NTULhQwtWz1qodIaS7g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3253.namprd10.prod.outlook.com
 (2603:10b6:a03:154::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Thu, 31 Mar
 2022 05:42:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 05:42:31 +0000
Date:   Thu, 31 Mar 2022 08:41:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     fmdefrancesco@gmail.com, axboe@kernel.dk, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Message-ID: <20220331054156.GI3293@kadam>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com>
 <20220331152622.616534-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331152622.616534-1-haowenchao@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5191c8e2-d959-4964-b15a-08da12d93f97
X-MS-TrafficTypeDiagnostic: BYAPR10MB3253:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB325378C4FA320C8715749C038EE19@BYAPR10MB3253.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBnzKNH1GYBlzNsfM+B8UT2jJ5TqtPzrJLcfoq3fjcL/4vQnUxmM9nzDbc+mRQZu48Yz0kqQi8WlcuuS+n3cuH9+rLFmCCPiShEZYdrtvjKvRpTiTkRxvfAq0NEwofiwakskIbC0idYaAqGxWc2RtRdSRqps2Q6dwmV9xCrB8R6klt1BAshobazXfuQ5x88Z7rargB5Jyj2iIpdo8I3HxA9pe/FbC9bhOwFdNx/zj8IqXOkSWx584P+qFiEHXW1MOxjcUpq1RurOxsVncSNWEHajHV691wYkEgoi2FHpi6hGwVEES4gMPtPD0RpqfDNbgrt9FhG3XEm83gVBteK4QXdqU+EO1FoKVRm8TpFxru+4vlmMUyiIJ+r0UrEC5+q90uI78epPdKZIWl0IzJg5qksSrtyI04BpYK/jJuh8wcSPgoGEZYCmzx2UATyDLZtT0eP3CFug2RVAeS2VXXuEnpeSvyDeFPXn4t0yGY2gVfQlJ3K5/WbBHPj1Wzdc81BBUKZfw8nEajwckXSB/oNHzBD38gWtp2nbaZhKKEzVuduIXYlHgBp2NzjIDedDEzJJKZc7rM7UqcMs/tt8etiE8JFiV7BbBduk6qiE5ayaWHTxVU0VBk2dJEXXNovK7ZYt+nAni04as+joSkiqNayVIHgYOsFWMpaGerH4HaW0Sz7+kO7nj4tAtitZQ22Bo6c+TOSWzM0oHA3I/HhNJWm1kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(8936002)(6916009)(86362001)(7416002)(5660300002)(6512007)(52116002)(2906002)(38100700002)(38350700002)(33656002)(33716001)(9686003)(6506007)(66946007)(316002)(4326008)(6666004)(66476007)(8676002)(1076003)(83380400001)(66556008)(6486002)(508600001)(4744005)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivJWDhGNii+Pp2nxbKMu1RoN9bDJgN+HqtdvStLg48h1LwhwiSOfO81q6I3R?=
 =?us-ascii?Q?RLCHYnES7zDB1e4Kk+QJMcEBWXZlHWRzQfN5Clmtn1P/aV7VwNiZtih661TU?=
 =?us-ascii?Q?DDp6Ln6P0ATqgGK0T0Q/y4Ik6IvKegn51qOTsW9tieRye/vCaJA5HnPAv9dY?=
 =?us-ascii?Q?U8YG44CFs5oDsSuBk0jTMrwVDKHFKn4z8CfaeIHJEPl6oMtf8R8O2aTA9ohv?=
 =?us-ascii?Q?2gTsOfO8FJ7X3oaoKtCS/0kpQqfeMEGXBQmdaVvS6DZzPEb3RYYakTo4Gpo1?=
 =?us-ascii?Q?CUDmMAP/QnBmPHmdzSUO0pezSbBN4Jpdvp/F8uAqRQUZqM6ZolROVr1NLsM8?=
 =?us-ascii?Q?tUOiPIBtlynVqeoc4pzCtpaZDlbgX8KK1nLuN4YmOumwsv8hbcsz4ojdde+n?=
 =?us-ascii?Q?MutEMgNMpw+Xtbppqc/g2tCoFWW/4lGH/QrnSkGoagwbODzUFdABlbGxLrmK?=
 =?us-ascii?Q?fkD+ZZX5Yp8M2XS9C7P8fmoc7wnH+DNrp6Ru1Az9tCnQtaJ4QWwLvkcgtgzQ?=
 =?us-ascii?Q?nQHLuvr2FUJxyDZ3EEgWILhIVP3sBDLDMH35Ngm+aI39EsrrBfI9CIfMFsC2?=
 =?us-ascii?Q?FqbqvcVlVGU62CqA2B5Yqq3ZKBVT6ChrtP534HouqFv+G6Rcasz43Q6Qqh53?=
 =?us-ascii?Q?TdE9t4LE1ePwXaTF7NzRAWieLxOJjdgDE7GPWoAWOpgn9NiL0phukXiU4jKK?=
 =?us-ascii?Q?6/EhQp97P3X4czxWcQWXCQk0j3GCh+7xjXf54VwZRN0a/V4YVcg/uzGCK1Hi?=
 =?us-ascii?Q?DPGjquNmnjnmNlaGxeNPTx4JmPszNs1cYVGV2hz+jmLuA+OZbClwMJBUjVmY?=
 =?us-ascii?Q?Nu1KNVOH1fnRQoYMe7YdVn8pA1dM/KWhHeIR+TP0xXx+/GWLzPMZf8dHAlA0?=
 =?us-ascii?Q?kK2cZPtpRRk7yPfZGQkviFLgQwCCvXoY8WaDjKhbCobA8U13C3Zom04mpOMd?=
 =?us-ascii?Q?dTEwBZDGhvVFdrQFjZxkS3XIkVlDr9Rqee9gTQuYcinkUEtWaa37lE2CZm8i?=
 =?us-ascii?Q?AESEUlH09dzK8t+IY61tAQKAOCnc+m+BlkNJyjyqcmaCbYOu1MYoeXthLr6O?=
 =?us-ascii?Q?fzDx78Yr4/uR++OEKjAAfUJ/xNxye8GEQRppMWK1H2b+ksrrBajWI+85yxmN?=
 =?us-ascii?Q?Rod0UcnaMslbMsimF/RCFm/iYIiLke09A/Ji4rCDGLIOGvnh6Sg5G1dNL43a?=
 =?us-ascii?Q?SABKYklfApnYNuSN564V62+BB+F37uXbTPuKxB6NHNfQVj/a+VQ7mNF5WT2C?=
 =?us-ascii?Q?V932OySKx8x5Yz9q6RWpGvPqCZIfWc5ozQKRXVAHO1C7/2CoxGZca5kQkbU7?=
 =?us-ascii?Q?MiBrFrWb8qr6B4ajNLfzqLhM3YeY5fK6fx9814sFn7RsOYzDubNHoH7c9rRO?=
 =?us-ascii?Q?jEhMg/WdBgcDg4dAkA7MqkMPjXVKW1mf415Zpl+e2bSR3/aA4F+NhEqH+Xpy?=
 =?us-ascii?Q?PE6HiqvBS70v+Rr+yBhn8M0fnAMf2khvrT+j7iuvGlkH6Fa41/8FK0wElLMj?=
 =?us-ascii?Q?cMVlBYR1UAC1UvDdNSavYZpPe4BTMuXPUCFCWR5dDVeoydtqdjZ9z4QDWohm?=
 =?us-ascii?Q?NBByJuzLsJsgh1WOC/yFQigs3KbnM5BfS0lJRYozCUf7LI3cNOZR8UMj+8Wk?=
 =?us-ascii?Q?2n7ic9DDPNcOxRZ1pvNIzrk3/Fb/l7Jg8oqsljUsDcAWl0DXMv18g4PO6Fum?=
 =?us-ascii?Q?FxEA3b9s1Rwz2v4BffDQe8ACKDD/XJm50Y7IOHgf1FuhKx3hUz+I1fvcwZd/?=
 =?us-ascii?Q?2T+NzDOsLfRUwHkRdW9h71hOAFyoMsA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5191c8e2-d959-4964-b15a-08da12d93f97
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 05:42:31.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glNOEUNLHMAW1CE0mkipJKWz35FDdKbxKOrnLPhU+vbtSBAWBgenhRUzcFviLcHQDN/B2UaZjAbGXaXUsA74Oq43/m7fjkHHF3LtP1dWCps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3253
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10302 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310032
X-Proofpoint-ORIG-GUID: mlVrc2CQE3mbsfsXQAQL-9oVyoaNTPtV
X-Proofpoint-GUID: mlVrc2CQE3mbsfsXQAQL-9oVyoaNTPtV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:26:22AM -0400, 'Wenchao Hao' via syzkaller-bugs wrote:
> I do not think it's necessary to call device_del() on this path. If the device
> has been added, put_device() would delete it from sysfs. So the origin error
> handle is ok with me.
> 

No.  The original is buggy and it was detected at runtime by syzbot.
It's not static analysis, it is an actual bug found in testing.

The device_put() unwinds device_initialize().  The device_del() unwinds
device_add().  Take a look at the comments to device_add() or take a
look at how device_register/unregister() work.

The temptation was to call device_unregister() which is a combined
device_del(); device_put(); but when the device_initialize() and
device_add() are called separately, then I think it is more readable to
call del and put separately as well.

regards,
dan carpenter

