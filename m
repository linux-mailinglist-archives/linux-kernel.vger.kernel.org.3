Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8A4E3B29
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiCVIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCVIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:51:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46AC76291
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:50:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22M7ErXD019319;
        Tue, 22 Mar 2022 08:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9m+lRzjIqXhXDIBb0cpuzpTClk4qkTb/BYuJaNnFKgQ=;
 b=w6ZlrDZmUBHutX+VkeMlvMTpAvWu/TFlTxTd7PSeBCr8aa9SIEf2M6xAPtdv/zL+X3Xm
 3D7o5LgqRjK27XbJn+5lGAo2ncZNqX54nYZhHmkS2v6xRCDXrI/9PBoMz92I9yJYxuKr
 I0Mh9FIdLahxlVTE42uywGPZOvs08iut7ET0WC6itPDQsOmgetrgBBJThzDNcNBLjwPt
 TjZz8kP2R2zlTp/OU6UPYZezFMbG5G0nnh18DB9c6LevX/OVowpD4UHZHxqhTmZCLdtb
 Km/XzMp6gXXrZ1F2a8B2BSeb1/RVQHYmCxT/TT13hfuBhKD3AsFjkIkqsvyscAv4MCJW pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0nqv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 08:49:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22M8kvlW094789;
        Tue, 22 Mar 2022 08:49:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3exawhaxft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 08:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q48sHr2aJDz8Ih28gbqkaQVxUeXB3BkjDdfjNtpa3KHfZbdFq5FT8jW+tQugzd+iQbcApRpwJsc7rlbiGbSXbGUZKu7oI4CyLUk3P/kvZKQF2EfCfG2AXjrV71cY7f3Fhe3FVU/OBgWktsBydt58LUnnEYhKa0lMgZCZzHnmJHg5rKmQDbugA4KeuDyl36Ydc51yOzf+NL6gOJJv6Lp10bgGI4GRZ1EFcyxTt1lVaSswI0NmgflS3lh1T7g7wzt99C3U2Y4KZKOTvsIwpcQHsCzv1ybIPQMbtMNUcvmzq/pC31hyfzyI0ykC+0aiGfwU0YDL/NqDBx5ywVmFglW8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m+lRzjIqXhXDIBb0cpuzpTClk4qkTb/BYuJaNnFKgQ=;
 b=Bm/eyLWV6AvT3jRb6fIlW25hqp1jh2jWmEHOa4lCVvxBZgDjsD4OBB0m1aonhMlpqltt+1V+bGMwslRplUE5qjJtof5/kBPB2s84izEz/0YHoE9YoFgGXHhbboZdOS3WCVUF8jz+80gMgcTszz5AUWrZ0/ibmdH4jos+eundgqCtz7p0Yvvm1oM6LG7Fm105kEZaoQbbEgMrEYlw3E+fp1vsThxwe2l8oI1z2/FoxUT76ldJsuAYNypKvK75NpjCqEGNFhc7xUF6snI6OSbE2+mJlTNuTIadk/F3s9lmmJQAv3QbPaePzIIzNdZWFKyKkE0UTrbum4usLJApKE5vCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m+lRzjIqXhXDIBb0cpuzpTClk4qkTb/BYuJaNnFKgQ=;
 b=T5/M82vKufvZ2wY3EbJHCf0QqqYtxTO9EOYifIn0Wts6MpMPs6aYtvE5bS4MV3griY0T6t7n21MdrJmX3xzfnegXGk5OOhiE9r0MswDCThmFtNoJ0/wy6jf142D9PM5AaQo7Bauffz66lBYg8SyfjO693heP1dDARRYCqugiSAw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2318.namprd10.prod.outlook.com
 (2603:10b6:301:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.21; Tue, 22 Mar
 2022 08:49:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 08:49:46 +0000
Date:   Tue, 22 Mar 2022 11:49:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: Properly test debugfs_create_dir()
 return values
Message-ID: <20220322084928.GM3293@kadam>
References: <20220322083858.16887-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322083858.16887-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf03a34-cfd4-4e31-62b0-08da0be0ea6b
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2318:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2318EC7AED8430E0F5DF8A268E179@MWHPR1001MB2318.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39f2aAtLRWt1hdChqjnEyJFUEeFdWmGBtNheuf8vvSYW8/Tp+O8uSPb4rWiFuooX/jvNKbJ7L0WJ8PrRkbl9C3mqNNNkpXJfD2ieOcxZCTcvw7vtYjgTczWgZ8KBDW4YakSylmHCUdWr9vTPjXvBLWtwzH5hL6jFvgedgrD/i6igPEEEmaabs94ss/VQOCOEXGsU4gvYDBXWQdl4filRUR94X3hFKFJsqdvGo8Bs5YrAH0O5DCnKKlBm9tm7QoTd4Gtoki9GGWu0GKnZpCSU+QnuRrMLYweBEckLvlU6DMTzPZxFHGs7xoO4lUoICNqcBvvwpnNBYq7O60A7+R/K9U1bl0R7Vzoez1oMruS/4kEXYRFFP5fiS+5ViHTv1gH8Xqxw1Y4jNzbAAK7tdRib+4WWc7/xyRDOIy3zT/YnqnQP9oXrz0gVSAXcF4FpzPDk6SDrN9/dEGBb9YfJ/BErNIsgpdWd61/kMvjGiGyx3fMAZCfuez4VBq53nz2ol17sUv+rVZcv4aoyfl8DWua9aZMBR0m/OZa1j3I5QYvDJGfWc1TYtvi053LdANun5hAE7qbbInsxDQlI/tzc+3VpxfbEFgKer54ytG+MC1mj307ioeIHYsHxzr1ccZD3sBXqUBL1SnzOrdDqpz1g0jc5+dC5Y5zo2ldQPg0xT+BEICYZoMtSRzEI8PneXdodkbN5FFGrXWMGM2w7EOLZFbk5wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(33656002)(66946007)(66476007)(8676002)(4326008)(86362001)(54906003)(316002)(6916009)(83380400001)(52116002)(33716001)(6666004)(508600001)(9686003)(6486002)(38100700002)(38350700002)(186003)(6506007)(6512007)(44832011)(2906002)(5660300002)(8936002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZTdgmSvj2gQ4RIZfa8ZtShF2VLjMFhlQAxvSwulpRA//wzSec+c5dqnYKwSt?=
 =?us-ascii?Q?mf43YYHPceQdGEnqCgwBJIrYqzLbzyrzdLiArQWcZb7KZWxfZM9qZM2kk7FM?=
 =?us-ascii?Q?wVpFzqDKLUF8B2fOgDpYCOPYEwaesB/3hVmmBTMuM7nYKldrF2KO+Twrcurj?=
 =?us-ascii?Q?+kCoOCHOJV+NmYnUYikueFPSwWy8LtIzcG+bc2J5s1/PV6hX53R5uOzkmmyc?=
 =?us-ascii?Q?x421cUVU8qTNvMV2ncq4EHN3d/bxxdscia1WwSDctA+BQx7JZvMLTNcUsejD?=
 =?us-ascii?Q?bdJoHHTwEKvUjNZhPAp+XDdP/5qL1N6jDrAkzUg+ZKlUu6XsQTQFmPUptWY+?=
 =?us-ascii?Q?e80rZr36Lzi9i4SQEziSj1yvHcZsnDA9QfNp+9DMxjEyIf7RQf1Kung0b6lf?=
 =?us-ascii?Q?SEqPo6PrkmuWaiobUwp7yBRrJCL2f21A9f3vRdwlULqfVoTiIJlAKPqnZjMM?=
 =?us-ascii?Q?l3PE/fSNrlVYjPwcaH8PIMwXbdIHTpEiM+ViEK4hdMU0q2pjxWpJa8gftPI5?=
 =?us-ascii?Q?LLWSL0hD+/UzEdXU4v2bAh5FzBIF5nk/4lXGFDNf+/KM8b/xzA5N1S1oWsMd?=
 =?us-ascii?Q?AXf2hJM8TPE2iFehHmOpqjHVeJ4eSWa9WPQxDRigco+2I5SR3xTi3dg/RDKA?=
 =?us-ascii?Q?e8XMTGtq0Yq9hcAVTaz8WBfeglwP3i0t3M/WMzg0TElg8RPYUCnv1JrtwJsu?=
 =?us-ascii?Q?sJuOFyHo4YJCvpurki9mpl0EaZ7fy7DLl2dvLjpTDy5w4ShKACdPNGV6JH/7?=
 =?us-ascii?Q?iz7i4qgGme3A+gK5H6hM/86KkUbbj8X5YQqwqT9O5/lrngWzHRhm/2i3y1Pd?=
 =?us-ascii?Q?zFWvnaxneFfxHTV1753hzkIfMumgojSrD3G8eOXg5z1dEqtqkbZX1mVKE1NL?=
 =?us-ascii?Q?9rsWt5wUBq0gULjiXVdUQWDqhcru/I+xkiSavZ495GArLcaPMyHPonDKGhXg?=
 =?us-ascii?Q?0NFWOe6mqVuuwFXsIwVzYpHn2thC8UxPR+nWuXjumRM73OvNw1Y5TyWSAtN/?=
 =?us-ascii?Q?GI0iO/XKIImPxXiCXmqhig+uUk7ZAEsAbf4SC+sYWEyKi6IpMSabl5q+VdVX?=
 =?us-ascii?Q?AFcXi1NmVFbNLzjKrwFixcv6uWDqFpQT9Wi3sfRLkGMpGRA9xWcAbhYuyIa2?=
 =?us-ascii?Q?qEnufBxv98Cp89xo2CWKW7IHcyP8NHwof9s6uyZRQMxVrSgoEa0bBoXxljFB?=
 =?us-ascii?Q?quYGEemXq7eCvLc0JXIa7PdTIT/tM2zKHKw0F00uHcxGxdg3y/CCdZUSRBg/?=
 =?us-ascii?Q?SkAFX0TIffqz6wveQTIXES117m84fP9CV4fws2pklKtNUTieHNVCcpQSUHtk?=
 =?us-ascii?Q?bDOZ59qkpS4R844zG+tcgRnz982WVX4OTV3ExNXq4MYIBk0QDgCu1PPMri3r?=
 =?us-ascii?Q?7qrJAZUgrwkIKE8CJL6XQp/OyZe6rQPSFSa+wqQwwinu9/PBA6IdKX8UAhRw?=
 =?us-ascii?Q?qXM0YDykeNNNfU8s0KR8DjJzjIQuAykWMXQAQrzhwB7A/eQmVQaJsA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf03a34-cfd4-4e31-62b0-08da0be0ea6b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:49:46.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWvahAbAJ7nrZhvTa0mvcL6ANzXnNLMOiHjybJ79pC53zmzEQTbkId1wrivYOwEPDwU6AbuF9+LeKhM5lIEchleFsTbGVlP+UY+PYsJiP1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2318
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10293 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220053
X-Proofpoint-GUID: tU003N5cf2Ce3TXAIFe2isH0RRlINZf8
X-Proofpoint-ORIG-GUID: tU003N5cf2Ce3TXAIFe2isH0RRlINZf8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:38:58AM +0100, Fabio M. De Francesco wrote:
> debugfs_create_dir() returns a pointers to a dentry objects. On failures
> it returns errors. Currently the values returned to visornic_probe()
> seem to be tested for being equal to NULL in case of failures.
> 
> Properly test with "if (IS_ERR())" and then assign the correct error 
> value to the "err" variable.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/unisys/visornic/visornic_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
> index 643432458105..58d03f3d3173 100644
> --- a/drivers/staging/unisys/visornic/visornic_main.c
> +++ b/drivers/staging/unisys/visornic/visornic_main.c
> @@ -1922,11 +1922,11 @@ static int visornic_probe(struct visor_device *dev)
>  	/* create debug/sysfs directories */
>  	devdata->eth_debugfs_dir = debugfs_create_dir(netdev->name,
>  						      visornic_debugfs_dir);
> -	if (!devdata->eth_debugfs_dir) {
> +	if (IS_ERR(devdata->eth_debugfs_dir)) {

Normally I would say to just delete the error handling.  But in this
case you can delete the whole devdata->eth_debugfs_dir and the related
code.  It's not used at all.

regards,
dan carpenter

