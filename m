Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBE4A6C38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiBBHSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:18:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10224 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233634AbiBBHSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:18:38 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2126HAi6026641;
        Wed, 2 Feb 2022 07:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Rj9NgkquXuEUB377Ss+wB5+cpYb6GVe7U51GNmoz1Hk=;
 b=EWjOxjdowWGUG7FdsJ6HxOUcQQK0PiUDmQsUDagqgVW0ZwMYAU4X8m82MiE2K87cQkn7
 YHTFDOKj43s9AZUSsb9QPMoaRuaPoU1xks/UkK/7ARfBMO2U+NIfsvlmqOkgocxRRp2R
 l1nN33zDRWRvDzFPKh0/mIMbUE8jXHI5loKWlGpdaUrhamh6hYvC0wl6QBzvxQQHgUF4
 EUMNRlir2SLfSm3wXgSz58LGYzs+nM+xjx1W+n/w3MZs/InWWzfzxPGrTeahKl8CL9je
 RvVKnh9P0vHtQ/ycPCXdzCk2hGq7EmoekwAIytPr/2Jqag0K4ElfxdeHTIh3xSOltSmf 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vda4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 07:18:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2127FlrX035743;
        Wed, 2 Feb 2022 07:18:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3dvumgt1ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 07:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdG7KkIT9tsOcdwtZoPq/zQ7bhz+8jDd/bMLLgIP2n56druyx4DNhlsWY95EHJpth2Ua61DKJxAxU5MzORI3vKX1QuPWG3nrkmaFCi3N306L8ef0icbT1sqY42xkT4ZFYkbtyeSzru4FeyGTPDL3qQgk3vYObG1FOi75s0+qMVrhJTL25NQeGZenetHac9uSNg1RNqG+h48EANyoDZ9nJG72tugnXEjZ8MBLXHTEseg/VzI0ehesXntZ/wAq7gnqXMi3bYSkev2exXkrF8tIEJ7XVdNRJq0IelArGdXU/cd0+0y77dReTIdB6zi5exI3dCjeIa9mNkFwskzfHEis7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj9NgkquXuEUB377Ss+wB5+cpYb6GVe7U51GNmoz1Hk=;
 b=XM1/b8/3A++WxHIgdrWFKxrGU4vXxP297g1ZhX9X2XlVeNzQgjdOcjvJr5TN66vfB3FoCEAkgfTgzAC4qe1G0rPfGsFZB1fK8u5GHntjMcBS6VhmiY1t0qSR6UiaT68I6MrrmD3YbhH1fmuD9BXuVDJjNiQe2RgF4D/hl5Dcgs18HFhbFe2v16WkRu/8Fk2l/g0rCtpFUb4janUh9ZazH55ugS2FOWsUvblT+WtVuZge4FcQyMWB+SEI4VdrhfPGdrWrlXnx94Vbu9kW137WuarDySWN1IdZJe24Y/lyl96n+nGdbWajoA+ybi+Ww+d9+fre9nvRMNY2pla0BNLMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj9NgkquXuEUB377Ss+wB5+cpYb6GVe7U51GNmoz1Hk=;
 b=E1KYVuR6ah3gLdNiW0mfpQjjZc+U7YEo8RsbWyzwB4QJnBdw70o+S+Z/uZwCPMlCyFcgA9lO4JhJfCWuqMFPgnuvkFok5V5d7Lfstd8jxaJW+IhxVEbssf4Zk/XuanRFLnxKAuUjrodN0q8U9OhxZveecspis8ngSkoQwH+Bgx8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 DM6PR10MB3274.namprd10.prod.outlook.com (20.179.160.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Wed, 2 Feb 2022 07:18:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 07:18:22 +0000
Date:   Wed, 2 Feb 2022 10:18:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] staging: r8188eu: Silence out-of-bounds warning
 in HT_caps_handler()
Message-ID: <20220202071801.GW1951@kadam>
References: <20220202070906.GA274379@embeddedor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202070906.GA274379@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3277d789-e0a7-4ac3-0b9e-08d9e61c31aa
X-MS-TrafficTypeDiagnostic: DM6PR10MB3274:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3274F239AA43050D8E648C088E279@DM6PR10MB3274.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:191;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AexbCYvikDi3GH+agw76v4W45hJOGRTHzUH8XqyDGv7TrpmmW4n5sysmIo3EIXP7HES/YsR1dPHyDwTawJ7AouVY2KGdGtvUSU5IjMt0scO1t9j/8s1Y0ArDHAhsSvrU3gVFyPWVr6iMDGaj45jIMOQ9RVEcU2bFX6/bcb3+sjRv923lwiE5VSKQWWwl1usVCX5xulLVxkrQe8KZ7Ga1r96fb+zJADMIWUhO3wzEAJg5coSqlthDT9X3bJmZJs0kWv8pWhckh1jxUDSm2XMShJ5+aJg9yJeZwUxyZUAZilXieSlhAdvO01+2kl24scBISJxBngxopKBkZ3/376wdDqSAHz6nrjXWV1KFzBLKysY2Tew5Xx22KnfG4ZWmLRYSRR8pomhzto29bQWkeKUZhfFyVKHhmPM/m6Mf+R+cNlubTYmlolLewyz9eo0nJceS7Khk+Cvf0NzXGDszzapkCGkLMtAnJUgKes8D9GqkYSphRE7Wy/0EKN46ce63H3B7mSBm36S53tn3lFpvCcnJF4e9UFxw0gqQO4lFUWzQV198ck9+P0NRxiA1qICmvIkf3hrKMc6iLky3OLaeu6X8EIYyd0Aash5mL5Hwq70kVl4Cf5/x7X55PjRMFf7CqoO7kJ7y65d6WP3mABUaHvcutWqfO62KLbNcpGfKXCN0gxq1rxUipgVSQDqVtTHOcg+fD34H3J2eZo5iUSe98eymjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(33716001)(33656002)(558084003)(186003)(1076003)(26005)(6486002)(66556008)(38350700002)(54906003)(86362001)(4326008)(44832011)(38100700002)(52116002)(6506007)(66946007)(8936002)(6666004)(66476007)(8676002)(9686003)(6512007)(6916009)(316002)(508600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OcJ1Y+RNHqIlUQSKMth87sjUDZ1fCvKiPTlrHQYnqdlHHBl3zq29aMF1NwI8?=
 =?us-ascii?Q?o/9eyzmGaMhTzTIcAAaQhqQ53dQpIEeEFyqfccI9PN2bnj0ioPNGlQQBiTn9?=
 =?us-ascii?Q?Iow8s/LCltR/Zi6qIFHd/hICluRFKqug8nzGwL4nfjpgSgh9hQ7zPmSURvqH?=
 =?us-ascii?Q?06xegx+7nB64UFagiz15sGk9KyN1AZkSYk6MW/yDnk+EfMfcAUWUPEgZ5kiJ?=
 =?us-ascii?Q?PVI4SVCfEcNjyOGie5PyfcMmQlngR321DJLMDJHOLUs0+NiF+8X7OEYe1JAu?=
 =?us-ascii?Q?0JNzqVTtBJE5xczyeNuRPkfmPIaahUt49YlHtjC+y6KxAyYMaKk5RVhY0hAI?=
 =?us-ascii?Q?DcEjKsGJ6P9HwRIN7bxHm1U4DjPCg20NVGo+9LqEbqtLmFLoeDwVG5WogVEN?=
 =?us-ascii?Q?CVpUhixirkE4y2AfpXu8Z+DrxnXbo+iE0WVrHo3VsoyRedPpVAu1pqvkHAXG?=
 =?us-ascii?Q?oTn0LHhiK7IrkQgdsDLcNYk8Vvc3GrDHwGHwwxTRw44KuCH2yqupYWdjhDxJ?=
 =?us-ascii?Q?lT38ZqeMgdrGnAMvfYRCGiLqXbbl2lwub+1Tn995owLT8dCp8M3G3pXF6Rps?=
 =?us-ascii?Q?3IcEoKcUROU3ynPxFfRE6ZRKPhZhvWeGAZiJRlMT3dk+L2w4X9m3u4heBG9Q?=
 =?us-ascii?Q?SMochpkaopRRE0Ke1QrkNEdeqqmmFhg4tGOw4B2mGcPtp0yGBMKlwZxE9q15?=
 =?us-ascii?Q?UJhWAL6Vlt6xka+w91F/x6MK49qC3yjKELOo3CsUqtoquS/WOXJ5MepGrgyN?=
 =?us-ascii?Q?JmFR3+9hI7ob6SeaG5gM42tI0AvlUSM1c6pX/Wp44HwpZiT/fVydnDmCBBuH?=
 =?us-ascii?Q?mXbHTy8Js0iXOdQ+X4LfqD+TdgAwphDAAtwyY3BpCuKzOwjF7co8EqGPNiGU?=
 =?us-ascii?Q?UlZeMN2p++3MTOE/305Qu8viHz5mogspAyYhDx++XgLwx9Hpe5ifWxv0Qzx5?=
 =?us-ascii?Q?1aSuKkHEM24aQ+y29rwzds5oppSnSUwa/Zp3I5Y8y7rYf5+8Q0sTkc5jJMFP?=
 =?us-ascii?Q?5nCcO9ZZQ4PQ1ZIDuAD59sJHXXeeq/7QRUL2KKQy8I+28Mk4egv38tUq++C2?=
 =?us-ascii?Q?8K3VjHe30ccwoDN7gmk1dnc2nu1h7K/GIjRGy0s5ArM1BLzvCvnbfNL+neoW?=
 =?us-ascii?Q?CcojZiwICo9AuOMpoZfC3DaWxsCCqC8RkrB36zJdUs2CQ3x2Lh9LLkrEed5J?=
 =?us-ascii?Q?sPXEjjDrrg+Y26FJewpkNZqEGM2O/rLxznrGQGeOJdmM7dxNiJfS8t7m/K8n?=
 =?us-ascii?Q?+eFeoDJwu4t9skBXrj643IpxqGdt0/ge6Hp+/Ubk9OxI9P3AhTeYcdejslmV?=
 =?us-ascii?Q?SMoRFxjZnxy8mNn03W2ut6LS8yscptzPz7Ggd6PcIUaLkVcfhy3uK4MLk2tm?=
 =?us-ascii?Q?mVcFiTMaIbmGZP5MxUqLkcspfzRrpJoR3+6Xtp3W8+ZxahI9nJPou6FU/rPb?=
 =?us-ascii?Q?C4PSiIEal5JBkrYSOtVFKjqsDOruP07EdaipOSpsDmImUGemYEj4JvCkIlEN?=
 =?us-ascii?Q?eLLWpgjlzfK7RUmpd3VwtqoQyo4dosXQRzrmapNrCush6aSa4bPgIWG8DWw6?=
 =?us-ascii?Q?7CDRJE1rpPcN7EFvWBRoflUIvjr1cnbUE+WjNvfLPLquqft5zWPF9uFEEWJY?=
 =?us-ascii?Q?seTacobw+iu3yBgKRBMV6AWcEvqmUS8G0N/yfBshhc5ow3e5E8sja6pnPsn8?=
 =?us-ascii?Q?pdwYFHhvCs5roxIXhyXUHhG0ky0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3277d789-e0a7-4ac3-0b9e-08d9e61c31aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 07:18:22.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZKrP9yXq3AnbXIIQ25aL4oJyIRVLevIgtJgY5LBZyJxeAkTYJkzGVk/8Elg60XYbVXtHzktTd1Ubg+vgeZR97+tkx2AKDdbpfh5mxpaMMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3274
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020036
X-Proofpoint-ORIG-GUID: F_CtdM1SMVXxsZ1GTf8Vos7OLfot5DyG
X-Proofpoint-GUID: F_CtdM1SMVXxsZ1GTf8Vos7OLfot5DyG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 01:09:06AM -0600, Gustavo A. R. Silva wrote:
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

regards,
dan carpenter

