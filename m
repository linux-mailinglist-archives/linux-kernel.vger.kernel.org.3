Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5749B490
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385262AbiAYNDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:03:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26820 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1574881AbiAYNAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:00:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PAxFeO029930;
        Tue, 25 Jan 2022 13:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=e0XjZkEPCUbU0htsspk+6m5kFWNejauFerJ2Qf3nMzY=;
 b=yZN/6lam4eRLbN8M4IAY4Zm4+f6Kn/em/Jg23WmgRmwZqld0dj08VHpEfYLfEFqSDQcd
 bUYcaGPSmss0M197AYFsTwh/YUN3aTkR7scAkkRfdN25YqUh1cKBIJNYbg3PHn4VtCqr
 A62cO8MNvL6eTqJPkwtiEmF0hiLykf8DSJ+hXTPnPr1XOMDtFrewc3w/XFAJdtPJwBLo
 TZpE66Z9MYWCFR/8Pn4BZCUnm9l3BF0u2gyViJKRG/ykGSg87hiffP6bq8h5E2rQVkmp
 GaKRgY7FFiiMa28umRrgJlLgNk52DIwGaMH07f9vPCPwy6K9JzlzuBlSUhG4dYUZbime hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7au126-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 13:00:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PCuww9121825;
        Tue, 25 Jan 2022 13:00:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3dr71xsbbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 13:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcy401wCYAEtCS3obqRqjNsIET7Nhb+YxvTEEmDff9VdsWp7HAsaz/MziPsTjuQl/h5gyWY8mjWWwPyKXwRoJ8Cm1pcWovYYw5bYCNX9Op71lvfPnMfwlCpMD5llc/vP1W1swmiHwBo5KUyFT7/+ix2/yK+5aQR+FNNbGa2quXpFaq0M9dHTSzPTyq4zjJQuf/Z46fQuJHGh0IfEauiZBQYiTfDiw+s9k360d+zD/Byd6nbDqRF+XKHIIRZ34IdZUySHWT5WPVUpHZ+9CI+MleQ++yE9buCCzOjQomI9jj0idK9Xcacu1AFqwNPA3LbpSUhSjOQ6PO7bl/pJWulXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0XjZkEPCUbU0htsspk+6m5kFWNejauFerJ2Qf3nMzY=;
 b=UyCt4KYNbBDzReSCXCcah5QxKfjWnWGmgWGmrjJha2ki++ttVTSxOIHjfLF0pu7XqpTYtl8N3uIDRAzg5u8In9DhDP9QGZ8gdLyRishb/kAHiFzR4A4soH/fGqgdDAfR2Zo8A/96Pe4ib0Xg54jwBqNSUXot1rY1itdteZYAH70UjzGJrY9EcSf+DabbAw+UZ/dlO4yr3FFajn+f/Nc0IbPa/ml4pp+dgkKO91ZAk9RvDV2xopQJKY73qzedbJmbjacVxQBsPENMXEuIXt+qEZko2Ya4cu5M2xeC8nBmXfVJUfFzH7PZFZy1NYiDC2UzjNNZi8d6sqS76gkoRH4n9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0XjZkEPCUbU0htsspk+6m5kFWNejauFerJ2Qf3nMzY=;
 b=qy78/suFURevzh3577r24sv8EcD63/RnRVaTZR/NHjpmHJDoEpcqHuZeTkXQebb+agszTa4kdgDM6MO8E30UcPpdQ4+ZaifIQX1xaSJbLPhZ+JQc/juhNBYZhye38m7j4IuUsu9l4729rCRfhGab5ktHylxR/YhnCJO2uXvOuo8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2856.namprd10.prod.outlook.com
 (2603:10b6:a03:89::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Tue, 25 Jan
 2022 13:00:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 13:00:05 +0000
Date:   Tue, 25 Jan 2022 15:59:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from os_dep dir
Message-ID: <20220125125942.GS1978@kadam>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-6-phil@philpotter.co.uk>
 <67ddc4d7-e19f-7c9d-a4b7-4eb555830ea1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ddc4d7-e19f-7c9d-a4b7-4eb555830ea1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 698553b5-0f89-4aaf-c0d8-08d9e0029b3e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2856:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB285627C25BBC8AB95930F8788E5F9@BYAPR10MB2856.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KiJvENQi8NSqC3wBLv/AhyclMRRnzCe/3aT5fzxenLd3Nj3F20PlYd0kiPfEP5ZZka9wHB84QEpEZiM3mSbF/4SNrcYAV1x8UaMHxLxhhtmtBbc0RV/3tDZBshq1x6wi2LDlOPFc6wgcEs3Z3qnVt618Ow3Bonskct+HRStpOnH4/qj9e1Mw8PHlplV0+EyftF2A8JnNNMxbuxBiJO2LBxfOPH+o+tKa4eeVSr0eR6+alaK37fJWSqJM8Mvwoi3K/yvBRsqLk8YvPCUt7k8/BY9vo3dlXS02V542/0cc4aNKDb9eqYLfp4uLgk6oHwh6sCKkMjtxWLuXVafYljKNWy35pPtwcrXYcaBHQQ7rHaZCepHBrkRH5o2T6eQIGOslzHNPXh0DXrgEo8/qxb6vV+YppkRQOqZ3qzRfyfUi5h+/aUpgSfc50h6kbTb8DD+ZFARDECWY8j9K38HIDnQBpznBfml5/Pny+DAyBexTeft+Ppt7HpIjwR/IIHb2vhRAzE9Jqtrsw2qMIKXMKnFk/UfGxlBVfS/0JBIJIv42j15BNcEVuWqG2H/vAHLlB+koOq0zbP5rndU7UaSo1v5V9NAlkuQZweULs1XoVFjtBPY9N9tfTE5JlKzJlDdEziW9+fbH8xDBWEPa3EpA/uYD3LTBveJklmeUmicnYi2Jelj8FTdf7zKbKVUKE9Hm+PMXEffx7rkYpUyivsqjeKs40A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6666004)(52116002)(6916009)(6506007)(4326008)(186003)(26005)(9686003)(33656002)(83380400001)(66556008)(6486002)(5660300002)(6512007)(1076003)(8936002)(316002)(53546011)(8676002)(508600001)(66946007)(33716001)(86362001)(66476007)(44832011)(38100700002)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aFLOaiuKKxl7IGOdyOQHGO54J12La8weuAnZA2K3l8Py6RSdn26DSPgnjVwp?=
 =?us-ascii?Q?wWEF6AwUJQzCwNo+BK/ukuNv/kmw7hNn+miOPT5ZvT+3iv/KsqRhsFqfjS18?=
 =?us-ascii?Q?ZLhVWCeBf2I00wJwV02JiNHDyhONDCudY7GrfxNBVcdsecJ28EtbQaNmFzHc?=
 =?us-ascii?Q?l4ztrw5pI9QWH+vFkU26EgaJHAJ0vshmzen1aPwnQv6vt4i25MHDoWum4dMO?=
 =?us-ascii?Q?SQfuCVUMd57jIm8Zaxicu+YxCtBELGopta8ptXVk5snDIFhloKiqdET80Rf9?=
 =?us-ascii?Q?2b9OM276KLPvnYtSnMANOCw9nKJMrEm2WqzTHwULsFELRwJ2A1ndXYxSIWH6?=
 =?us-ascii?Q?BnbeBtW1XrMWJXK9geOhCrzUVhaiDgsXhnHyvl0rN9d29tfaMQ9yXI/zXUT5?=
 =?us-ascii?Q?x6txDCGfL8IukDUaw2FOPHOmCPb1nud7kmpkgnv1m7PDGefH2ly1PieDEz5s?=
 =?us-ascii?Q?5dv2WqXZw9/wTVDd8KG3Hi/gehGsrO4crY0nt1vrxKbWs70fEXuCiYH5qyaW?=
 =?us-ascii?Q?+LzV9qiStgspnDlY2acni44CIUeCKR+hwS1nX+0PCxcDxYkrsKgZs5pRhlRu?=
 =?us-ascii?Q?79gmg0yc+68MYlXoh6lK1HhlrKfWarK3jFaLlOYcmQ0OQHb+LjPSa6234baF?=
 =?us-ascii?Q?zlE6+coSYywXgOI2ZaKiTgejR9u6PzT2FXYJ5a1MQDgevYuvgjooSmhOSGIU?=
 =?us-ascii?Q?ien9TdJDdt/z3k0+PgJLki+MOBDoiAMVwBDMsQGHatVl7Iwjzdcdu65/8QGf?=
 =?us-ascii?Q?8HW4+Lz2l61LanY3X1YqaLdMmgVFySr2EqDuylMUBwcfzX68lKx9jABV1btg?=
 =?us-ascii?Q?A9z/3SguJT8DL/KdGlCh6LwiA8Bq356+nDFajslO9KNvSZfmpZbaOCpjylXl?=
 =?us-ascii?Q?ekPgcex8f93e2wS+IK7fDsJqLHiA2gu65kvyTPPZZ2RrGqzFsqFJuaiyCUPj?=
 =?us-ascii?Q?OUWC4XTaLYwFM5bXLSou3WK3uaOcdTpmKNj+QOgdbf+Xvp1TgfbgaFiYVD8y?=
 =?us-ascii?Q?nE8png10Wa+t6qMkIy1nBh4J2HTZKjAxcwjR/6dS09jSGd8XyB9yPf5Ang2J?=
 =?us-ascii?Q?9a/GJmZNXN6bAvGo+gs9HvhJL9ZyGMm5LNIOoSU+DcUxYwQ0uAAtDh3/LW1R?=
 =?us-ascii?Q?KVImFOxWaB+WExkm3RiQxcYfpn83mDB+pooPV1TSR1hZIrUPaLlpml9txkBU?=
 =?us-ascii?Q?OH0UfPnqsOv2wIDroK7d+MtiNaExA8kwZx6/AB9YviJOx44GaeW7Lizc+/Tz?=
 =?us-ascii?Q?o9jfB6Y6JwTOZ9llATPxcGeBw5z/6/5AJ0ku31mAKTZoXgw6hbzBxeQjskV2?=
 =?us-ascii?Q?Qosa8frVfkWczDETJhbNzNBZuM6l74wcS7+r/zYvezSjyaM34TJCZYMW1KFx?=
 =?us-ascii?Q?vuP0QH7hM/tv9DD84rXqhN8DAUWGbN+3fepK8q3GpYEypBIGc2UHDu429y2r?=
 =?us-ascii?Q?CXj4NXrGA2gEfzKXtjNqpsLn8DCj3JPBJFMvQblbB3XG+p1Lum55HC5wG4Ng?=
 =?us-ascii?Q?JrTia1DFkbnhCx0eOhvS10Tdk/2mnU6ri3um0H39QBT8EIde44LezUsnT8FF?=
 =?us-ascii?Q?C+rEXVVgQTPShiB4ZIT9hWDHAXUfg4FvEgcBDTVmfnybtzK4sKrYudWhJB/W?=
 =?us-ascii?Q?vnL4XcXrohpddnfvR3yTUGqLNamSL3tD6Q57ygJPQep5650AjeBI/NTniQlV?=
 =?us-ascii?Q?l8La3gAqx6vGCG+wO26VBpkCsl4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698553b5-0f89-4aaf-c0d8-08d9e0029b3e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 13:00:05.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg0Ro6oJ0ijipba/moSvzFc4gwedOmixLSI88SNOVELWLhzjfaZkF5AyNw1sLxHBNpKkXvqiJtGe2E5oXTW41mtayD/qGaA+8A66XECEUzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2856
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=867
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250084
X-Proofpoint-GUID: Cv6ICX4zfmBBStXVRd9VFffuza-1q6oS
X-Proofpoint-ORIG-GUID: Cv6ICX4zfmBBStXVRd9VFffuza-1q6oS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:48:32PM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> On 1/25/22 01:44, Phillip Potter wrote:
> > Remove all DBG_88E calls from the os_dep directory, other than those in
> > os_dep/ioctl_linux.c, as this contains almost 200 on its own so will be
> > done in a separate patch for ease of review. These calls do not conform
> > to kernel coding standards and are superfluous. Also restructure where
> > appropriate to remove no longer needed code left behind by removal of
> > these calls. This will allow the eventual removal of the DBG_88E macro
> > itself.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> 
> [code snip]
> 
> > -	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
> > -	 * suspend influence */
> > -	if (usb_autopm_get_interface(pusb_intf) < 0)
> > -			DBG_88E("can't get autopm:\n");
> > -
> 
> Didn't you make a function change here? I didn't test and also didn't find
> any mentions of tests in cover letter.

It is obviously a bug.  Please avoid ask rhetorical questions or someone
will answer them.

regards,
dan carpenter

