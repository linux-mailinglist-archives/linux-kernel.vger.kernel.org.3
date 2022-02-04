Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF04A959F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357245AbiBDIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:52:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38636 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357237AbiBDIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:52:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2148Bw01012568;
        Fri, 4 Feb 2022 08:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=VnT5zOEDiWVHlRm06TzxtyQ7r9iCiUugD/bGLQl8ia8=;
 b=bX2rbmDABjvOZnBO0JsQhDIvU2CPRro9fwDQQ1Ugux2pnMzoC8U25rlZgMWWTwbhFl/X
 HhvGyz7sdHnCULxjDKENC7oVWmn0gXPxiwFiM80mTkGsraUtgnTGIhpnW84wJGuLzvhN
 GthoufJC29T4WajNZOTuMIjWRlLrWzuAWvLZ/DGaBaHglp2sX0wCsZBpfrjlX4JYx/Nx
 rGTyQ5mfiBEYwFMZ8+k55Og1okvaBwGtii6B1Zkip71hP8FvkIgB7D6j5KKAlSTpc1Yd
 O0a+/6cERAruGP0iDA5IUVHF7CpJd6e/1l3hort8SL2CuVI2IkCkokhXzrm6YLqTV+F3 Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hevt0ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 08:52:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2148pL26078947;
        Fri, 4 Feb 2022 08:52:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3dvwdby85c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 08:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctymLmaKW2Ndr+q99cmVg3L4yrXitrjTrHxhCZchJruS0uwWRY40foR9R3mAC7IGLJsnE31h5dSUwPuwW0QFeoG/Jt1dqBo8xGfXcWSKgkcB15PTek4glvxqHNcAkqrfQ3w2vLPz8jXKsGL6gcCYiiPAKkL60nN2+uzKdj/brgySqH9frcRZVfoZ2+CfcQ4hkTowhyKQdUvSpH+JBBSei+NChD9hbFxU9WDPksZAQaikBS1CMu9GbpDv3NgVkD8bkKlPLSDxfHGKxIARmehh+p7jhDfPrNq5LBydqqgPfQH31PbzB+8KVnRP1TzxM2CxcEN56KoqXSm995DzHKB4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnT5zOEDiWVHlRm06TzxtyQ7r9iCiUugD/bGLQl8ia8=;
 b=fZGn5uCEHDI1J3yvePOBadkxlgEvOm10iHrD/O7ciQuNMMYD+be1hS8Krhx5ZB/BSijlYF/zkIg1lbas9MvAt4qHIX+ZyqqPFGgavVQYBV2j6XCPFjXMNiFpwsdpg0XJqUt1GGoP0eO6uoehp4M6OZNDA0JOPT3jIM9gx0Qjf03DOXZH52ngLat/0Lgrspa3VyCd7KWxj3k41AwKKRWtEltPymTdeMpn0Yf/AaVDtcKC6VN7J+yiFUHIdvg84fdAMuuZcX9J61jsfHzGuTYeazu2R5lHVY1roBNK+N0+icfz87WPu8AZQ2/e5ynPgQtBsMCHRCKJ6QxebW2HWRf15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnT5zOEDiWVHlRm06TzxtyQ7r9iCiUugD/bGLQl8ia8=;
 b=GL9fiA/MIr/XErpmaFDd5NMe0f2k+AZCVxWdz2uWs1lJipv1AdVnAZbCqFFGT/ClGBL2LCbKkg0qd0iRkwYlHHFoXEJJanzK6OnHUxrU2HEvjrDwZf5bFy5eXhyKgNFnVi7hnbLkuNC2Yijxdt096dt05GFPLG0fzeM9atwdNkc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5093.namprd10.prod.outlook.com
 (2603:10b6:408:12d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 08:52:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 08:52:15 +0000
Date:   Fri, 4 Feb 2022 11:51:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Bolle <pebolle@tiscali.nl>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, insop.song@gainspeed.com,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: gs_fpgaboot: revert removed board specific code
Message-ID: <20220204085145.GX1951@kadam>
References: <20220204054028.3123858-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204054028.3123858-1-ztong0001@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86cca72e-6b55-40e5-e63a-08d9e7bba389
X-MS-TrafficTypeDiagnostic: BN0PR10MB5093:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5093FF33F414C11044993E838E299@BN0PR10MB5093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RF/NKWVtqvHJs07JnNUNiQjNXkO6BUfwZEw4xqnISthWdxw/QrKAM/Z1QVg5ZhuOQI3cFOpnSBeRV97Lgu/s7k7LEBTZ6gbwFsdOtDoi1+8sx27gnqm1tNaDVWaQFForO5Xf6eo9T1HAsNNe5+CMZaAN2wPp3w5PpbQRZAJ9m6EqWvGuhnNmZ9LCimzBQ73Z8vwFsRxmuJQegLT7yJina+6iTI1AnHfb9NoKgU5+eZ9wyi9mMjhjzULGv7WRexriS4coywTU5rBhnqY6BVsiFK+FW31TaNvqTSFm7pXzvuG5owME/tG8hc5e38Ia8+bRkgXQMgmznViJAw4iAMMBmu1gFMjcg3SzlK23hvi5IVpv31t7ddKC2ElMzeYvxGGAcjQQSABKf3aTExRg55A5W9fabArReIXR5stbxkZg6y3CgXa52IHOq8Wa/o5JS+SPdxW7hFKGTKaxqMwxweZPHeNRxiUANMhDfk2BxWXCw1cnHVXD3qluqQddO1J2etkl7Qe3sSz9bss5lRjpQ9ehJ3Smi5tCL3kEcNEGYi79ipagvRilyaUniuIvwU38jyHpj/rQ7EZYDGeK+DnUclNv/vP9BTIZ7UsbT9qTSDrn5Ame8YrRnDEAIQkhRysAO4qp6Cjz3NGWX8gV4SeL0hZH+w5cfv1dY5H9kTC1E308BabgzzmTPeL6+hTqU1Hd5oUyr6sp4RpOD/8bo4BioAp/fbHS9KC75S7UV5tyFDFgisI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(2906002)(44832011)(26005)(1076003)(38100700002)(186003)(66556008)(8936002)(8676002)(4326008)(86362001)(6486002)(6916009)(6512007)(5660300002)(9686003)(38350700002)(6506007)(52116002)(54906003)(33716001)(33656002)(508600001)(66476007)(316002)(6666004)(66946007)(5716014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Nxy3EmiUaLeQr0s+T3+P6IpBm6BvNyLKctJ0RPeaHlUZxas6yn+N9Q7Pswn?=
 =?us-ascii?Q?kxUAg1/wwLdCRDEv4Kpd66+07aTn5+9Ey0Vz6ijcYMiVvjjUiQp+hHcNI2Eg?=
 =?us-ascii?Q?mAVyTj0GbCU1X1G83HAvwUnVaouFMFnP+QFmL9zkOWzD5MLRu9WiOnjDg3Iv?=
 =?us-ascii?Q?T8owLdZfC/v5LkZxvk8FQ11OzRC5JaLH+aAAGbqZ3vFRBL80ECTAV/VEv2H6?=
 =?us-ascii?Q?PfZZOI5MKmelTvZVKBCX1VrtwwzNmvUazxLR5IKsEhG7Uhg0p1rvxPL9Nqzh?=
 =?us-ascii?Q?LYswZwbL3nlrqZuAx3IKQALgdclwz581fLGATFVo3AhddIAjs7p+w3qhJFFc?=
 =?us-ascii?Q?y7K147wsjwt2063HhSTdKWGwRehZRFxq5SiI5hQsBe2gXnNvMntagmbx/t+H?=
 =?us-ascii?Q?bJTJLO8269n1jWvfjdnkIdMLctbMRRaXRJ3xY/r0/GSBjx1sJLM5+EoITiFQ?=
 =?us-ascii?Q?5aLyFfjuwQEWc1rdZFHV1BH8niGzmh37VnwbBfpzW+MS5bNN+J+VlZJ7vP9q?=
 =?us-ascii?Q?NvnfmYnb52Wo8bF8joycPnn82oZqi3u4iAfT9E3BU1zicaZiIs8yjQjzyCW2?=
 =?us-ascii?Q?E4BBkaamM2fXeYG4cmcg2RPyWnmnGUiNITn1o8xb/V8gjLQB/c0LpA1RxVd3?=
 =?us-ascii?Q?mf343So10Ng/tRVoIGxQHOCDVvEQlv5T+vlyj7X3voSY/bSVUp3YrQe227NM?=
 =?us-ascii?Q?J4WfqY7FuSqBf5isPsVDJdlYuO0zp6AnNssGhfF0W56jjFLKWA+pmjrfUO4T?=
 =?us-ascii?Q?GF9K6PIOGmBcCD6P5hkSsra5jY2aBvZ9nMM1FhoROporva/pHe9j7dLLlxa1?=
 =?us-ascii?Q?wUJsKMSdMZK1OqidvYKu2j9cvGejGFdXEw7yKfcNvqbBI45S20g85Pd4I7uZ?=
 =?us-ascii?Q?dlGnQNPNPMfHEQsmou+Msm7Dqcq6cDZmYmK0AJX2cRFzrBsBlmnU8HvwbUni?=
 =?us-ascii?Q?dUyI8xypjSKtPk8CKyyD2IZ3chNsOe6jtyVrECkOPy4TET55Qh7spThycn22?=
 =?us-ascii?Q?cmzOCfaSXmMyDLHNiBwfmKI8whuQeZYQBhP9KWYdbLmmMODfSLxuk00+1S+O?=
 =?us-ascii?Q?UNozswpyo72Nl1REEE3/zsGl7XDahmi1C0v1NkMLOOQkmwUcEm15z21WF1y2?=
 =?us-ascii?Q?8E9twQk2RbE/AYdzVOQCFpVATPWailkBrd+ynOdonvDZabViwp0zMWyIpZb6?=
 =?us-ascii?Q?qbZtQSH5oftiXw+wSaAxaIiLEqK+gSn6mUpFaBNI6yxneN0smkigbduJPPUy?=
 =?us-ascii?Q?Rx8CDQIx6tuJoxNDGDC0JSUCr1xdxIxqwr7OhwR/4A2+fk2ANXETQBkt8wbE?=
 =?us-ascii?Q?YobOiqmVAIVjue4uS6zezGxvc/aDeX9Sq1/jyFgzwYyK6N54S/YLg8Iy5qNP?=
 =?us-ascii?Q?JgQsY2IFqnL3ex0PGSfZsEWBXIabWkQ4MHSSCUgCiL9DEatpuWKIOcJvsUOQ?=
 =?us-ascii?Q?sK6ewvYKOwDErdB+K+DgAsqhToNjsFMTGv2lDrxvqlIzdV4RpxaCmsQC93Yy?=
 =?us-ascii?Q?YaARnNhtv0VwLK8s62mHiE23AP8bi5iADNiBT7LFg6/hejDQ135qfMUeL2qG?=
 =?us-ascii?Q?rihJXm+bksHedNhRPqopZMzex6vWRsjPg54obMiQHJ5QvDdWEXCYzPhFOfjZ?=
 =?us-ascii?Q?u14+svMpbjo1OyL/foK5XGtn4iqo7CESzZxtuWgS4VAn2MC4Oogb0juFx0bA?=
 =?us-ascii?Q?WWRMcg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cca72e-6b55-40e5-e63a-08d9e7bba389
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 08:52:15.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmHPoVh4aOxPngbQKBjpKpT3Ij+bVc4Sd4emF3v1qTok3bVuoPt0C7dqxajULgjP3CP2z3yZJ/FV/FSmXbXhNqn5QjgHZ11sNdgSi0mWjZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5093
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=863 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040046
X-Proofpoint-GUID: ftw7u02P0vTIqV0OedgkdbYe563cZGIv
X-Proofpoint-ORIG-GUID: ftw7u02P0vTIqV0OedgkdbYe563cZGIv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:40:27PM -0800, Tong Zhang wrote:
> gs_fpgaboot is currently useless since the board specific code is
> removed in 06a3fab941da. Loading the driver will always fail since
> xl_init_io() always returns -1. This driver is broken since 2014 and I
> doubt anyone is actually using it, we could either remove it or revert
> to the previous working version.
> 
> $ modprobe gs_fpga
> GPIO INIT FAIL!!
> 
> This patch reverts previously removed code and adds a Kconfig to make
> this board selectable for PPC_85xx processors.
> 
> Fixes: 06a3fab941da ("staging: gs_fpgaboot: remove checks for CONFIG_B4860G100")
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

The Fixes tag is not really accurate.  The code has never worked.  It
should be:

Fixes: e7185c6958ee ("staging: fpgaboot: Xilinx FPGA firmware download driver")

I assume you don't really have this hardware and you're just modprobing
drivers to as part of testing?  If you have this hardware then we can
preserve it.  Otherwise we should just delete the whole driver.  It's
been 8 years and no one has noticed that it doesn't probe.

regards,
dan carpenter

