Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC50D48645B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbiAFM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:26:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27050 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238801AbiAFM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:26:35 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206B4b9I012780;
        Thu, 6 Jan 2022 12:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+107pqH63syh/ytib9HgFo4oCZdlgiHBgcCKL8du9O0=;
 b=Zk/fVeKqU/qZsusDJVJ4EI6t0B5Wp4ukZDjPsHqz1/2i7L7JT+OKUB3ZhywjeMRvqwcl
 8Su3cXCQ569gzHgPAgjawXIwRC4/b8Qcm5LIXUk0IDIHoQavtwTyp7Jnum57RBXsvpQj
 klVge0d5sHlhr0Va2Gu/4WcLQf8KouA/TaEOzJ8SaX9eV3A8SjF2iS63hafvhUbjU6GH
 VNmifA3Y3H5lvK6L1gUBMcDTf91nYXweBItxUf0FqjukOkljsK9IKaojYH0As0cN3OWT
 TAsu0gMTUeCG1bWVHJjoDufn8qkPINmtpg92Xsmuxsl9/6RWinuIA7ZGHyEjyVa2m19+ nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpjsfd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 12:26:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206CBq9C056811;
        Thu, 6 Jan 2022 12:26:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 3ddmqcpvu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 12:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjdux2zQaMmCfLc9+7f9mD4B6wR+gZfvcwnW7Y9ktCuuITBQau9p2nVX3BVOjgusYHZrQIrxADHTb2fae5WipQcQlO2jyNkqYRk06WF8MnDycvS2LZMwquRn2gJGobh3yuNs5tFFBZsZEWhuhzrgrgo5qO6rZ3rIdP1/Vu3/hsQM+lUd9o1Q3XzoOa6YE+VJsRsuQQVmn6tRiDdiDokZ1zPWfJgXprJVzuS8LANJgbc8QZ3nMWc628wN78tE4k+2gbAKCN4RTCtRFLjMVdgu/UPGfBPDIPMu4mNIL25gh1YAbZc0G/D3WDfhs5sU7nrhRT3nQcC17D4OEkqCho8Mrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+107pqH63syh/ytib9HgFo4oCZdlgiHBgcCKL8du9O0=;
 b=e4sdv2WW5kV+JTVZVDITVr/YX7BaAMiVO2L4MB/Dr007yWIMZKpPV5O4o0feFwkWD7UA7ErW0KxT4q3EIqwZIgbxqprmHpFZrS1t+aX9thT9m5RWrRJBXIp2X0zZb2O59a5KAK2dHTj1zFA+qHjS6kyebf0826xdmZVAxY0URCAM1m9lGt0MCTUvSXhzJbv3CGcxhVIH1a1+dFmJvncc65c9jHno8XCTSzYVmKZZIMK/DTmVE/Ypp4H9NO4vDzqsUubxFXoaxhBteEN23dLbuebRTxHkNLT5UtSf9N65iWremMkZZJDLgkUhSbMdvsw7V0EHcwD//RJKhVYAqsQ8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+107pqH63syh/ytib9HgFo4oCZdlgiHBgcCKL8du9O0=;
 b=diEwOufj0WlFu1U+e9dv3lkdKI5LIRzXI0c12eRFt1c0MUdUsnyuJK7zgWSOTUT+6Z8F3DyQe9OBm4VHukNYyPnsohO/K/dhSPJxNqW1nE+KrpAlzPO36QOr52Q5uNZeV36EYLurE7D2OgRxRnz+t7ADaNwBBYcNVrwJ8Bke6Q8=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1400.namprd10.prod.outlook.com
 (2603:10b6:903:22::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Thu, 6 Jan
 2022 12:26:26 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 12:26:26 +0000
Date:   Thu, 6 Jan 2022 15:26:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/32] staging: r8188eu: make
 odm_RefreshRateAdaptiveMask() static
Message-ID: <20220106122607.GL7674@kadam>
References: <20211229205108.26373-1-straube.linux@gmail.com>
 <20211229205108.26373-21-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229205108.26373-21-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::26)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eb0be97-2a5e-4b5f-edf5-08d9d10fc235
X-MS-TrafficTypeDiagnostic: CY4PR10MB1400:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1400D11A678823076F130C788E4C9@CY4PR10MB1400.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnivMKJAjhbYpM18d6zyA6O0t33a5ViLFhryZMV0AAfSTK6VSA8mVp3M8CRoY0g40sdrHkA6pDegRkpC0eHffJwIiuanjI23EmmWwp8RKGoOzs+XyIgcLXa4ItAawp6CQdksjE0U2WzNHJkOT2sPoZPJguRa/Dxv69sORoPGyBrmB2vpeEz4cQ8e1F799IpTy2PYxspzA0v33jiD0zvUmfyKkF9oAo+HIkt/XQcnHG+vklrqsVPQyEjZ45b+HDIAwJSu/wTYyhyyeKW6F1cHZWXaDcGXRF6+3pECzKQZaCiNFJXhR/OAc/QYDnyFdLUDkgEx/GOUvqtEQST9hs4q5FUvb/NcmlgNK4lfWAmV2qWm/ZoWzsXgrk1O/leRSVHztkPtjeJpwnddnYHBcHlT6B32aM57XZyzC7OzEruALnnX+MLEuukEZbOC0sSnAxuObRTbbh6Y0Wi0/VmpSsztfD4c67chJ8MPozbruxt8pC0osqofleolhvfeg4FXtJIlrjEScy8H3Xi9sXNJ0KPJufsIIwDggbLvWAisXX15dHw8UhmPP3WR9N3+JHs3yQbl+YwYtMAkfaZjg6ND7HBb7T9+JuwCoGl35gS+M1iSvCBBKuYwVYY8en7WUWAbZMSl3ekpNffclDdhqNw+MTF7hXbWXzxoO4LRn07zd23nqCephuRUOQdA/EbAPUbEDh98AvEeleO8/7xsmw/WswfyTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66556008)(66476007)(4326008)(66946007)(38100700002)(33716001)(33656002)(8676002)(38350700002)(86362001)(6916009)(44832011)(52116002)(508600001)(5660300002)(6666004)(83380400001)(26005)(6512007)(1076003)(186003)(2906002)(6506007)(6486002)(316002)(8936002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4X1VAIjxAhOw1wsd1eLU2ACJ60K5dPbWWV6Fo9bE7MXO/TtpAat4HpPhIBf?=
 =?us-ascii?Q?/a3gukPZaXnNHJkCrgfxZBx27h6v654FIAMlzT4l19T3Bokc/NynIIfknjR+?=
 =?us-ascii?Q?L3gXDndFC4464klmSy9e9Kx+ej9nrhCbBBQfFh43Np97IGtPods7a2llbvTg?=
 =?us-ascii?Q?OQ1paf2m8nhv4EdtZ8l5RaIU8BjaqsjdCMtOdluYBTH2K623lA5COVYtKkgt?=
 =?us-ascii?Q?UnbVmtU6Zkbi5ipNdSyNNA1uQGjvnlBfQpzWrKOU7gIt+VKMfHqW57+NeYJN?=
 =?us-ascii?Q?eJ09sO52vbfSjQ9Fh64iTlxEd8gNr5FTvTmIm5YbHSSd2mr7qmgoBqXTcgO7?=
 =?us-ascii?Q?9XhsJxf1+jGqEmElZ/ew5+PA93StMbHPrEpcb6bT9hs77DWTfB6xTHO3SZmQ?=
 =?us-ascii?Q?kgESX/D2ObFiLWYYd6huas+vxILmMNZwEP2TWHCfFQg099z9f2oSXzAzyfFV?=
 =?us-ascii?Q?FT1AIRF4JmlW8MnRsoQqHx8elWvMRjUyOZmCKc0qL8BjTQPelwYYib4FJBBn?=
 =?us-ascii?Q?EecnPnm05eNuq0dI7e+QxdUHqYBMKJHUdlZxfByFMnG7FotYx+HkGN9YzFI0?=
 =?us-ascii?Q?cRbDkrqBy4vHYvl5yQI0ULkHLGgfpl+VIBzB6myY1/c8cDQWY4lyVKNhodpR?=
 =?us-ascii?Q?3g8T84p2q1kU9XiHYTcH5QCpAgfk4M9hzka8EPFTOYkQjI2zJEoP9/wuI3t/?=
 =?us-ascii?Q?W35qcQVphCghxIQuZ72oEIOHS0W/RNxC0SH0/V1pxTF31yDc3nvsREyEQJLN?=
 =?us-ascii?Q?kpbPK/VcVDDrBy+dlcALFUosdbcjYgx8CUdFpPqfYIQzzuk/SUOp64+8iolw?=
 =?us-ascii?Q?klG2s6SwuZ6LNH87HpeMW7QKfmXTV90Di6CJFtg5mGNDOtKmXj5jI9DFBdLl?=
 =?us-ascii?Q?KR9QhcJGdsilGsiRoJKcqXH3E44eok8f9Mx+NSYBfU/q1XOKpVxNHH9yaHJy?=
 =?us-ascii?Q?TNJMFfsGnzIoOw4ZmE/VUp1+DEmkClO4T2BS9vzvAobnbkFb6UdUk1QyXhvt?=
 =?us-ascii?Q?zSVsdAt01VVJDK7+S1p+ZWcG9eLy6X07XaO4VcWTRoueBDsQzE0qlGP0GSQF?=
 =?us-ascii?Q?w1hQ/3BpSiFt0j/Wcj7O3EoeFxPfrmJH/Q//FJfJXcZ8zQ/J0MtOus6MNd+L?=
 =?us-ascii?Q?+ynttctqxCTBK1shw0i5LWUsaZVagVl6hs05ev4BQqH1rMdMH15H2P9BzxcN?=
 =?us-ascii?Q?XETn0zKg1CwbEwREBvtRQkTrbAIDT+DTMjXXfV7+9VpQGFxy2HYvh3Bkbi4C?=
 =?us-ascii?Q?eiZFqGDjdNdz7p1pT/CIpVHvsS/mKGWKBWlQoyMye5EQWCICvaKTsZxNadqv?=
 =?us-ascii?Q?/zfSJo14eeZ01RQf7VpukxqHvIq2miqTf9Is0Ko1Sc9UAbhzm6zOBAk3Z46u?=
 =?us-ascii?Q?C/NjK7DM+aMElL+CGq+klfB4rYpFRcuAUDo3umOXoFbHN8YvEihQ9zHRY99n?=
 =?us-ascii?Q?Ay3QnnzWOtUOHb5T/lVv/Hrx9zOWZCgqDCDY/uASvfozJUKVovqhJ8kbJgx3?=
 =?us-ascii?Q?FeuljHrIUuNg4fOm87tS+limf5uAbJgGcuDm8L1S1BMabAPcS5GBsVGcZmEz?=
 =?us-ascii?Q?4AKqNtuFtOtRxJFaN75zD+ZHdeqI1PxREzUfkoJL6xgsJhAoLerbxi0W98HU?=
 =?us-ascii?Q?scfuDKUBqO3PTObImAXuBbBd+sdPi4dMjg6HWRDGV6/xsmLtG77UhpKC/GTb?=
 =?us-ascii?Q?vJ1CELc/Nsl9wPy1eCRbKbHdFfQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb0be97-2a5e-4b5f-edf5-08d9d10fc235
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 12:26:26.7664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMLMXlzcbw38ALlmXsT4zdafacKhiLVL92xNkd09PyVq6u1wr60Stn1lsG9aLaQrzmJa0QIMEa/ukel32ZS5RbjEILOLQuCEQYL0OPs3G3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1400
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060087
X-Proofpoint-ORIG-GUID: 4PThxTrrBsWZhdZXSahn0uvrCS0zCJG4
X-Proofpoint-GUID: 4PThxTrrBsWZhdZXSahn0uvrCS0zCJG4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 09:50:56PM +0100, Michael Straube wrote:
> +static void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
> +{
> +	u8 i;
> +	struct adapter *pAdapter = pDM_Odm->Adapter;
> +
> +	if (pAdapter->bDriverStopped)
> +		return;
> +
> +	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
> +		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
> +

Michael, people don't thank you enough for all the clean up work on this
driver.  This is not a "please resend" level issue, and also Greg
already applied the patch so resending is impossible.

But, you added a blank line here after the declaration to make checkpatch
happy.  When you're moving functions around could you just leave them
exactly as-is?  I have a script to help me review moving code and it
helps me if the functions stay exactly the same.

Anyway, thanks again for your cleanup work on this driver.

> +		if (IS_STA_VALID(pstat)) {
> +			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level))
> +				rtw_hal_update_ra_mask(pAdapter, i, pstat->rssi_level);
> +		}
> +	}
> +}

regards,
dan carpenter

