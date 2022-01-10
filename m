Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531C2489600
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiAJKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:09:55 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49692 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243636AbiAJKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:09:29 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A8Lnuu018461;
        Mon, 10 Jan 2022 10:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IbtjkBf4btkDrR9XbGl04FnWp0cA6oRVbosOT8H8V+A=;
 b=vFNPq3Zf4I2erluqVYCY8onMcgPrvSimC2TS57DuhzbjLPYFW6mLgqn3bBzhYucQo6IX
 AuJNHSyrqQ1MUBxeNrnLpYeBg4sU9AxHC1g1dcBac3eZcc0f4p0vB9wFV8sGBFYgaqee
 ujOvDf2S/caxJhWkmKu/h2fllPC5JJIfmqt7/MHxJ8/eP+Eooh+4HbnusPDqKa+WRwPx
 jNFMlPCcaqzaBA8/65ENkeZupsuHo/0X3+0JDsdEgMLO4uBGoO4ep6Ici9CU0VQ4e0BL
 XJuNgHBp46gmALzeHW85f7kUNso9n+5sjDoxaZCNHo2cCAhTQWyFSmlAYAl0l2J3i3Nh sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df2gatpty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 10:09:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AA24fu194244;
        Mon, 10 Jan 2022 10:09:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 3deyqv3kdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 10:09:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFkSmWPLV5LUgtSOi6Rc69VFjM1ri83Ft8WME8jh2EPeposcAENEv+6tloncgzfVD6PTXGkXxZ8CvducQbkzM9Dq4VMKeMG9bShW/WjCN9Bb3Lwxm9x/rMZI3pLxcpCrOghr2pYCcooYFZmj+DedBGejCk07QPtxA/0Q/zs+heev2jIhiPQRoV3DSRQ3mC74shPZxaG6ZrIookw8mjVXo6wgxRr3QhyxgJlpG4DFokj4S0AuHluHnrBl7KEW9vnexlnO7qtlT4iVyIrqA6j0/3GKR72v+Z7LWWgA2fO0KEa8UbrLK1tQJ3DMUQnjwk3i0oNu0btCXr0J3lJfz6DsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbtjkBf4btkDrR9XbGl04FnWp0cA6oRVbosOT8H8V+A=;
 b=NvQONT1vFKzS6aDjzKdJ8qNEbME3MTdsmAN9kd6MhIBiVl1kj0hgQ2r1Q/oV0TUyE7XSDg/D12MINu0lNSugOw/HTNhTZgcHaC1eINDMksXbh7eBnGU+prh0jTtHDKKNBtG28I9wXjj+LhPnw9SaK+9d/6xg+CVZJxqOO0hHOiZBZBo/fT1Sv4rlyeWgWbJQxl83uSzNM9BECUhSeGkS0CXPqHXQnT0f29xAzjwDs6yvsCZodLaLEtjbdU/xBUeJMDMyH2d1C1gJUxU3+HtmgKvXQtfJfmLQ2wi/bmsbGswqDLyTqKuA2HUsfypIesoEroaE/Xn4OhRemIbcAzIoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbtjkBf4btkDrR9XbGl04FnWp0cA6oRVbosOT8H8V+A=;
 b=IRmV5Rk7+IDa1DalHQuFauC6uPPJswd2e5tEq/MskVFQW9LCPRVSdT0W9Ian/zCdvhYabdDNJ0PcQKPXqJQandECxEIAKnO3fhgSLxYuPq6WBqMFntLmrC3dx/ESF9JhtigakQhiOg0zlvXKkr+Ia/SQzM9ns46t17jzVLbO8d0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1615.namprd10.prod.outlook.com
 (2603:10b6:301:7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 10:09:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 10:09:06 +0000
Date:   Mon, 10 Jan 2022 13:08:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] staging: r8188eu: convert DBG_88E calls in
 core/rtw_iol.c
Message-ID: <20220110100843.GC1951@kadam>
References: <20220109215427.887-1-phil@philpotter.co.uk>
 <20220109215427.887-4-phil@philpotter.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109215427.887-4-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e6303c-19f0-4c23-4fbb-08d9d4213c1d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1615:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1615CA36BC44137495B54D008E509@MWHPR10MB1615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roSWhaXisbfZAwZuIEVkRywe5/BWXDgfpv43H6RH+br0qNDMUahR1MkeMswD9Lm7eD2btq+v/GZ9+U7c5ccF/CCtgbSBCC3JI5RB929kDTX7TxBU9BKN31/yO0/V+OyY0HdHcZBwtZLuZoivjF7KuV7K6NlTc62sHTEb3ITBRB5SwLBozPPQ+PVixSDRvz9Td0rZLS8/T9cEQNLs20OIhqflZc5T7EZhKrc2P15a6ZebhYvuSNWPnI6/flOGyOblNtgsvLEdm+EzANsUIgzYm+7kxwITZIL+sKUcnA6J1YeSBSOUvgEHvtmSOPRloJUOSqnLikz1Lu6BEyUUfn4BJfx+LBOSP9ADK2dwygExfilHAnVz3RCPjE8/I1tuohi4U51tx+9lUZ6FL8cQ15x/evRYcws7u3yMW8K9mv0Mxw/ugV9R7u3E/HsqbY3o4Heo5bagf+QrSEEId11nAVGVjEwfdJLIbTYLTRPgOHxuW2rln7uH3dWh8dWlM6+Z+J4LxcsOy5LBLPP9dJ35gS1MfTw12yClCPUlherRoBiyJiNDvnyPiQ0M+VI5sQCsMjpp6qmoakrcszGrQ3SIBhdYw6LI5smlsS73tAjV12Hyn6k4vrpx1UzTWJxLKLiUCGDnf5zaHl36BtqBWILRPhdIYUmGSuXOxqAttrlwSp5c0ae+d1sb3z+sEsCe3p9IyLTh+EITcg/Utwax8GmOtrnAQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(86362001)(8676002)(33656002)(44832011)(52116002)(508600001)(6486002)(66476007)(66556008)(6506007)(83380400001)(33716001)(8936002)(6512007)(1076003)(4326008)(316002)(66946007)(5660300002)(38350700002)(6666004)(26005)(186003)(9686003)(6916009)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SdFFIpyW1mJWedRJizE4jWTogyE+Z+NJE2zwVvZB3NFrK6aA5z2iSDgdjLhU?=
 =?us-ascii?Q?L6CcgyPQhyDnwnMFVZKtw05MMw6KCww2ki6aikbsZYfpnGtjieTVc9TRFzwj?=
 =?us-ascii?Q?2fsuFynKVsznYYr7idyASGbkB8/h6ysRLX9/4sUpHqI6blNH5avuYPnfHf3r?=
 =?us-ascii?Q?IWhDP4oU0f64gxuMbAlex3UwD/IGH8wSKWpNA4B+mKbnhvcMrQLSCZV2qYwR?=
 =?us-ascii?Q?/0IMaLjDLEYJYy62p+akp6rkN29pYDWdPSbDMOz5VS3roShkZ77mqRaSb8aB?=
 =?us-ascii?Q?XWeunrUrhe9vm02JN8v4+TsMFHr75R+lJ3ljQXoRTpfQaSmgoxUImxmKhLDh?=
 =?us-ascii?Q?V2YjRzRJABG232HkZFVv7KUcVP9v17/9+TEEXqsSZqRWQdcpViV6dbzXfsQZ?=
 =?us-ascii?Q?uJbnWBEBUMu1mQlDG1a3xiKRTpphReWwdPyh0yv/j4D5SJl2+g3NUmJ1Xtd0?=
 =?us-ascii?Q?PfkzGNlKAExLWEXhvycdHDLrgMkhODJ5ud/mQlhJSOJOLAw56sdL+Rg2ei4l?=
 =?us-ascii?Q?RkNC9JfIfLkXZ6yAxPCHI3P1VvTzF+RRzR7xV9bNl5z9i+wUwPlwWNZOQ4ZH?=
 =?us-ascii?Q?3eIhJGuuq0vN6XD8WSgeWK3/FsHvn/oF8yWlwwSiAzSBAfmiw9Gfu5XI5Qcp?=
 =?us-ascii?Q?q9HNzRdWU6ep1Ivo3Rx0jyB0pDxVtFDJA60U1daBfstPSEmnwaOUnyMNabm2?=
 =?us-ascii?Q?e2KbGws7VAoOVcH3JDPtU0moXH4xd8pV9v157/2m1tVrjW731G7djeyx3NTX?=
 =?us-ascii?Q?YXXU7tODG9z9zfO78Nx0q5excfeVNiBtBKOVbTd9IwP+fEArvWk4jUKIdD7z?=
 =?us-ascii?Q?orSO9VApLF863tf/vWSZ+HidRU+icAQuSlL4mXRhVw9aEegQ4yq9gruF8+kd?=
 =?us-ascii?Q?ICywyVnXYA3UkTqtuNjxlxQuhuqEbNcgIZefR60V5nCkJOPwrEz4iW6E/ZL0?=
 =?us-ascii?Q?rJvIiLK+wr1l+smfLdvUU8TjRBoEJVhxO3adQuyxif9Ulz5syw9SBosMYl/7?=
 =?us-ascii?Q?KP002LgNP99uxLVP0ssIu9Nox1HCAkbi7BnxA5Hh59YyTtN/3eJsPys5uLba?=
 =?us-ascii?Q?iF46aa0mLHwuwi7ITh+gzCCYKGTM21LIHhXQDzlXqNtv9sT9eRzVKGe9Dv4r?=
 =?us-ascii?Q?HXomJNRM3q1qMzXOie3lvJ8OCNg06MBDQPoe8h4ogifdm3Vk3TjFdhPttwAd?=
 =?us-ascii?Q?/R7ef+yrRSjtAEbHvN0QiAAuH9aN2wEMtZMbhpfgppvamoCn3+B7t17dqug2?=
 =?us-ascii?Q?HEeAW9Sok0UYrN5DkipZ/geLymWsNWHy8BFOYJoCfz4Sl8VnWL9g+DBeZ3SU?=
 =?us-ascii?Q?tWYfn7PhB89wekvzXfr5tER1SPYX16M1OrcLed1ur3IkU5vfFPbmd+io/qIF?=
 =?us-ascii?Q?KAG0C/4th3LYbVVh1f5jDT9lHqQOkRmTarnDMYg0Dd6x01otcG90i7A33//d?=
 =?us-ascii?Q?8J55F5EL0UgCSVo7lnMPamqu5ykTzhPEpR8ClI1AkT8ynCM+hjf6wEQetZeh?=
 =?us-ascii?Q?hLt3xmlhpBrcuqg5oC7wuzQAaJvnnS603UGWUUMR8UJ+08GlkLzf6AP7D4cS?=
 =?us-ascii?Q?eP7AlTzZ7fPCpXdqrHlPgpMagi4EaZlP1D4GGKMtEDhA1Jatu5dqCaPP0lJG?=
 =?us-ascii?Q?4gDR5+S48TACVt7QK/xooAjvkqXPSt8yOPdlS3NLjBLirH4hoPq+0lzMr9+x?=
 =?us-ascii?Q?m0IC6LDELQGSBqZrHLpg2E7QRl0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e6303c-19f0-4c23-4fbb-08d9d4213c1d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 10:09:06.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWkgnDLNuqpaTg+xX94KaDlWZ2FrON4czBSHZIsjae5VEv/tdHVxKx/wFj3aV+OzczAfTj3wTMq3w3wLoUkCZVtygbDPTW4XWKjkjauBjik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1615
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100071
X-Proofpoint-ORIG-GUID: dGAG1AFESUWshRIIGmeVhVKxF0bIqQkR
X-Proofpoint-GUID: dGAG1AFESUWshRIIGmeVhVKxF0bIqQkR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 09:54:23PM +0000, Phillip Potter wrote:
> Convert the DBG_88E macro calls in core/rtw_iol.c to use pr_debug
> or netdev_dbg appropriately, as their information may be useful to
> observers, and this gets the driver closer to the point of being
> able to remove DBG_88E itself.
> 
> Some calls are at points in the call chain where use of dev_dbg or
> netdev_dbg isn't possible due to lack of device pointer, so plain
> pr_debug is appropriate here.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/core/rtw_iol.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
> index 7e78b47c1284..923da2a9f6ae 100644
> --- a/drivers/staging/r8188eu/core/rtw_iol.c
> +++ b/drivers/staging/r8188eu/core/rtw_iol.c
> @@ -12,13 +12,15 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
>  
>  	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
>  	if (!xmit_frame) {
> -		DBG_88E("%s rtw_alloc_xmitframe return null\n", __func__);
> +		netdev_dbg(adapter->pnetdev,
> +			   "rtw_alloc_xmitframe return null\n");

You're going to have to send this anyway because of the compile issue.

I feel like you are not being aggressive enough in the debug messages
that you delete.  For example, this one should definitely be deleted.
Don't print an error message for alloc failures.

It would be easier to Ack a mass delete of these messages.

regards,
dan carpenter

