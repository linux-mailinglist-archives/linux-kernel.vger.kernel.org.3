Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C1E4BF16D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiBVF2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:28:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiBVF1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:27:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7353C2614
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:27:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21M2CsPF012145;
        Tue, 22 Feb 2022 05:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=EEDShSA49WOROdAwWrMj0psuu/GOsoVXc//GtADfpBY=;
 b=zRy7swMyeR4MJrYpPEXhwhFKLI3hKnGXU10qf728ZKiB5CqNipPfE0mxxNc9fHykhZ7N
 XpWai9hJusWmO3XWpdiqlQOk/4yAlsH+71WeIpxN3V8e6SkQnwdtWqHiOmkfAW1pWllQ
 xXxy8Te2lY8hXYP0l90QY2M6NjKR2vKO4SzXNpsbCXcCCeDgAbmVWl4N2e1Tkkmk7298
 JDudwHFwhUJXWn0sMJnFL32dKMb9uAImSyyd2HSx0WfELJodlZdMDHdb5OsuLa3Gztq2
 sd4iOo+C+bbKmEZkwLPCnTFNm+KGbOWo+5V6qIPei7H5PI7mbN43XACpdc9CKvlDKHMs ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ear5t5ymm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 05:27:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21M5Go9X109398;
        Tue, 22 Feb 2022 05:27:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 3eapkfcqk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 05:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOB+vs/YvqvRSocXswoIhwe3aw2vKraxQEBLj7+KokEwnLQ5QugH4tJ7ulTLP7FF3m+Cv6HLpu/HutBukQphWIc1PS/9d9NmakS9OuIdXQFsnGPCPUUWjZK8TvsXxRCRPan9qPFIWnC5DfBjPYkoMrf0oiDQBJj/EAIaNBGALshwU9dEU2gkWQs1Ie9SXy0YAuvQW0Jd0vcrqhAu25c9vxhpkURD064De6Fj8Dz/iXJHH1tApHXgfBDt7tR49QmPp+e3StMTroDvlqFPaieQvktHAAh538QmFLXrYscjMsIEWr9Va9v4V5Dn2Z0xL4HCqw35Y3dVJtg1HIbSfUw6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEDShSA49WOROdAwWrMj0psuu/GOsoVXc//GtADfpBY=;
 b=Bpaff9FO1Y+63FDBQ9MWqA5LTn2cBaq3IiEPPhDl5oGXAz8dQKpsNiFnIjg3KIhklSQBgxxTG4Cper19x6dum9E+t05dRGAwfb/wsqnEcEy0wokjgXeX6icUH+d2WC8fsXvy6DUI0Zxw9Eh7b96VN9s2UlBgZLp8O3LumEm7/jD+mUHV8LAWLGoskjjnhyhM/cgJUL52/121JCzwkOnmUsiQMwNzHHDMg/+ydcen7DZT2nFYqiVWTtnpVoPj10Gtzi9btFYDmoiJLLiyMBZerdkyXfz3K9IKzfaA2F6ZZn6rMW04loWCzMA0A2yZD5/5KQkrv247/h473HDPmd8oSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEDShSA49WOROdAwWrMj0psuu/GOsoVXc//GtADfpBY=;
 b=XLjdQvZEAHL4xp/fcMOK6LzJ+RbOG3JkIvCMIfHnxW1W8ob9JItL+l4IlUvadMvdm9ahAzriddN8yy9akHlrtCrLmbitzFc1ZrqNHxmu8e7nq9vGoN3bfz84t0joKXBdiTrIPLGXOXs6piS8Zns8MVRAUFchVFerhg32BwFYEHo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3759.namprd10.prod.outlook.com
 (2603:10b6:208:185::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 05:27:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 05:27:12 +0000
Date:   Tue, 22 Feb 2022 08:26:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] staging: vt6656: Fix CamelCase, add comments,
 change macro to function
Message-ID: <20220222052654.GL3965@kadam>
References: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e097fee-1a04-4ed1-7aae-08d9f5c3fa21
X-MS-TrafficTypeDiagnostic: MN2PR10MB3759:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3759B0DA19DFF0CCA053E48C8E3B9@MN2PR10MB3759.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Pgv9l+kNVWSm7BMjLluHUHDd4r2NuicpBI/n9vXlwLALGTFDyGXLMw4/9BTZ8g4K1XECHYo+VgSLqlOy0cENiAaUN/jqJfAAzu9e56h6ymSkclxzZwK/pqJsTPFui8/YotTMGPyuOh14pI+ZTjphIeeRX4OPXLCvZq0a+Uay+4fjDv3H75JuINutvm35vPgEvlSg1iEWqag21aXJEcNqrofMAS7TMRyd8cyZRX7K111hYj8rgPPRXizVQgC67/JoIXZBD7e6mzYDCHuN/UFZ4H638XVoBsB2z32MdGDulcFHmria/d1aaRewJPOR44xICIZJbOqEF97Hk35zZuYtr44FOOntEz9gi6UKzBDXQI4rwP21LHc2Be/CdfJc28Pa0HniOLLXND2seebVKgwoDJy6RM3NUvpPKwM4yVSZj9vTzaRkp0aSTl1Kx9Qfng48nF/ikidsZUo0xXsQIiqmYFHjN7ttNF0cxuWyjbtOL9YatZSfKRLdHlMoXJuaIMIgmbzdPBehflYC1sE5Gl/JADbMfzCLIYtyWAhTzDywPZacSwn+7/O/OoJoezHroCId550TtdEv/48EXOz78EjTKyoUBHnwMU9JDWiyHFRZSg2QLH7ght1EZ3AW5snctfdCar5zVRDeGBOHA1aRY9gCV9Z2cwUPrMcrbFz6FVrGhSN2VAN4lN62dk4vslqGfaRZK4NybWChL7Hyck0p3878Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(9686003)(6512007)(6506007)(52116002)(508600001)(5660300002)(38350700002)(38100700002)(8936002)(44832011)(4744005)(2906002)(54906003)(33716001)(4326008)(8676002)(6486002)(186003)(26005)(86362001)(316002)(33656002)(6916009)(66946007)(1076003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r75uyK4TMoaK9akjPU1eFfQH6eDba2x8Rqah6aeAmoqHIFx58fMSbHi+5SUN?=
 =?us-ascii?Q?Q9oR/dddfXxyRZsxRdwL/F2pBidOJtxwnB2/C+qSQ67CgKZcjgh8mVTN1UIP?=
 =?us-ascii?Q?IAv1qbZgpnAHkXc7lM6JnYfU0lgcax6yrTtxtvv0ur7ishzAVQ45Vwt4ukg2?=
 =?us-ascii?Q?ZoQfLK2K08tBeWf9+RGWsJVwZCe5bfG3l8z996ozZJPoaNrcDegVKqnZ2BF/?=
 =?us-ascii?Q?Uql9pBPGrbu+2RrfT5g2zoh956qLwZhxxckSPY/gUZCy2iIRiYeAGmH4vN2h?=
 =?us-ascii?Q?PVunzYndD9f+sge3h+QV0SFu0Sj02Zy4BhchjUse5FBwgWuKLn9HfvW/uKoE?=
 =?us-ascii?Q?WUlRp624Hq6ZRr+Gv0f+jEcPKloZyyOUGcdeajLIfoRTbTCravxWTiJ2g1g2?=
 =?us-ascii?Q?EoTOTYLQCf6Qqx5zzRv+vtfku2G6Jk7kGU7kqe9aTiNLTec24q1flou0WmrN?=
 =?us-ascii?Q?/Mdu/SjOSZ1fyLNZ5VJ1XpA46d6/MO68InPDX2Gf2MzAeZFur+kYEY31XOR6?=
 =?us-ascii?Q?rNPDwORCgxuU8OgTHn6gf/XoS3LARV2qD9Uskj8P9z/Pnib+1sYAs2GeNQEk?=
 =?us-ascii?Q?wjotY6TLA3KwP668oMJ2md/OwiHYLbDwhNSHilc0GeC83rmnWv9frAAYAj3y?=
 =?us-ascii?Q?BQEU8vk5vCRsx5x8glzr4MwfbEwClsG4e6t5ObQIiKKkkLnWDPTVsPXy56MI?=
 =?us-ascii?Q?O6xMzbF/pu0A9qTwzetNkhDLLjNa5NZypvmQBaN0Akjq3pr+wERrVurNOuUl?=
 =?us-ascii?Q?0N/vp1PTSXz5ByrwZ8kZgPPFogt+WMNzAtN6xoQAKWeaIZ6DnXXQzM0S/PKp?=
 =?us-ascii?Q?qZMtPLBTZexuCboM/lMLsNIXvzbE51uzpeULyt7yVkdPnp6ulnx/GnwlHti/?=
 =?us-ascii?Q?ku1wV4y91qOHc2GY7xzConDIKlJDooCwa7SG59pQgB59+3WgR/pQLtqcPKdW?=
 =?us-ascii?Q?lr6Aa3Rj0O3/iZtbzIMKHndip86tWnU3/KKAVrCkB8MmjTQZQds3+tjnIF1T?=
 =?us-ascii?Q?5AAITy3sJIAScYLAAqgUYep9xfhaJ4eiQpyMI7JMRUp3Pt58jtC6fSt2W2/c?=
 =?us-ascii?Q?LYfh2i3PL509wiinhf6998Ibci2p0b/m3Z8/81NkzCa6vOZZ6xJFSV2Uf+hl?=
 =?us-ascii?Q?g9rKcYr7Q2aewX5TnRBADAK8m9NoI9J+Fh4pp6OOlPpn+Scmu5p34IvZb+cy?=
 =?us-ascii?Q?qnkB0do8UafnwlInT6j8lO9Jal6Of1KzICKwT9QREdOEffXDn47WlY/Uoljh?=
 =?us-ascii?Q?G52DVfrnIkw/qtZGSfud+1Z+nHhBzZDiVvCh13KVVBzVXkB21Re0tEbRh+aN?=
 =?us-ascii?Q?cetNjImjVc6VuCz6+PfmTwqC5HDxjAFUgFOWieCmM5TE8krYs+wS2HZeNGF2?=
 =?us-ascii?Q?bbIGORPMcikfzr3W/tb9LY/nPH+AmTbp+QtkCzEgc1LwIcmoZeSjPxw8UDvt?=
 =?us-ascii?Q?VocsqBEPx13On6iVApJLuKYfA/oocyGfhRWQnEpy5jMW4fLkU+3EZCABetP/?=
 =?us-ascii?Q?FlcNOjWX6wm9rKsxVYg3DCxZz01uOhvGiGzEYmaWC8MY/GQleWPWvN9xPr3t?=
 =?us-ascii?Q?FDA4dAexIa796czPyd1aU2HOlh5lj+yR8W8IURDG1DhJ+xSM3SYeQ5PRp4Zz?=
 =?us-ascii?Q?0w+pWkPqZfBWiU7PmXR3Xy8GRl8YgmjuuqQXUjQg2rLRAuGyDYhMY6ThIhuZ?=
 =?us-ascii?Q?4haqdw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e097fee-1a04-4ed1-7aae-08d9f5c3fa21
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 05:27:11.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6rUJBEHGG7HhS6/EaIGo29rFkpZvb/Vg1TI6uYH9TZTlRHfjgAL+rDVsvQSfPgNscUfpuLkD8fM9RBIKRowSCK3udGyKjNKkJbxEL9VEPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10265 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220032
X-Proofpoint-GUID: R026_dtuqNEqNkrOfA4QiL9lKVG3SJli
X-Proofpoint-ORIG-GUID: R026_dtuqNEqNkrOfA4QiL9lKVG3SJli
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:24:52PM +0100, Philipp Hortmann wrote:
> Various checkpatch.pl fixes as liste below
> Tested with device VNT6656G6A40
> Transferred this patches over VNT6656G6A40
> 
> v2: Patch #1
>     Changed EN_CFG_PKT_BURST_MO to EN_CFG_PKT_BURST_MD
>     Patch #2
>     Devided into three patches
>     Patch #3
>     Devided into two patches

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

The one thing per patch rule is slightly complicated and different
maintainers have slightly different lines that they draw.  You could
have merged patches 3 and 4 together and it would have been fine.  But
what you sent is also fine.

regards,
dan carpenter

