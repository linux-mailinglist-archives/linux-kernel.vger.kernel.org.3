Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0E4D606E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348177AbiCKLQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiCKLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:16:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897BF15697C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:15:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BAUBQd024112;
        Fri, 11 Mar 2022 11:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SiFGYrcaIGQ6FO7fRVOM8OCwG+oGIp9ArD3gTmq7qLA=;
 b=emz9M8ok5tQe5YNHgvrSBbCh/fkFE8ORo5k7Tx2yLbuXiWpKxzMPf2UXVHOgXtV0D1Fx
 5tJfB5XvbvnAQoFBzhhp6O709ywzQeWv+kwMhaIRMFpU+r7NYtN79tIVrMzH1f8Gji6u
 r6eGO6yQ0UVXxBkN9Ez4QcRvomJRvWtSS+gU7JgA8IRzR9QaTcZuQOkOtRLb4d2MVGye
 ZSfOYCBs0vcvhfy98ZHOeYS7ySQT3ry/itvZyqTQkWTADzPOgio9d3v598kaZmN2BnF+
 1fPonZxu1NCy9vxfZIgavtPYWI8KYNNWiE3/+3T1HUKpbGs4tVkXJ6YHpzn5rgfQpCYt Qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cr7xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 11:14:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BB5vZg115332;
        Fri, 11 Mar 2022 11:11:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by aserp3030.oracle.com with ESMTP id 3ekwwe1w2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 11:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgn9e+WStZwDaCMkNBZpU9h0Za/G2+U7RRf8v8k8o/pwTdA8/tw/lUrC+HUrSeY2PCaqBfIDnJb99fuNXQyq4kaqKpvTMVB7rClSn//+rXGJzjwZs7Q8LATpP0kGp19sEftmu6Unk7250V3Eoe9OwNxQUN4P/4ukGzylqnM8W2grGQiyj4ww+LU5q7UUhKhtMHnq4r9iC12SXNv+KEgx3XrPbEmdhLAp6dncUVXOJAgPR1FwEj4YA02giIpVFZv/ZSCHsZf8JX03p0j2HLKH4hKVUizATBHsviRBGOnHy0n/MmGU/VBF97bO7vm6eAGYSwquXI1kdzguG1e+bx3LdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiFGYrcaIGQ6FO7fRVOM8OCwG+oGIp9ArD3gTmq7qLA=;
 b=V4HLjYfMwQz9RG/xt0yMSNsvp1o1lDoyCdKAJq+9LsufNU19UpBwtDP1M3npvkp4jP8JdFdTUcbYxwFeMb/tFhDY9qn9aCmS18aoSznawhlpMPM//4sAHdJR0AdhNRQuOn96H0Izn4FXQaZjn0xLmTMifizCUUS5Omhgc+qjI3QPIQcjOh2QvZB7gKm+uYEkiEDGYcHbWLCIc38psIhrlxi8fyQ7lMGiZBymNzkQgmfVFxt3yKlAIWzk4S1ZFZTp9va0vO/mLEqtTbnQEEfQZIl54EBFxUGrTdR7pMiZF65tN+5DF8MevypMF8j4WVvxm5CThCFiYtLI9a/xnPJVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiFGYrcaIGQ6FO7fRVOM8OCwG+oGIp9ArD3gTmq7qLA=;
 b=Ct7yNSBYeDF+cGRLOHqQpVdntJ5/3r82E7fLXwqYM6BIyBehDghy7Kn/VW1ZpJA6waic6Xe9F4T8Ide/Z296A+s/XKxXK88p8XEvi9GFkGUrC1+32thdR45VGRn8QOqg7fuuiR3QKEjJWnVJDqaZNb+hOy8KfpYBLTCGKwIteNk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4220.namprd10.prod.outlook.com
 (2603:10b6:5:221::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 11:11:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 11:11:31 +0000
Date:   Fri, 11 Mar 2022 14:11:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: simplify unnecessary NULL check
Message-ID: <20220311111120.GJ3293@kadam>
References: <1646994801-26211-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646994801-26211-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0034.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 153d0013-209e-4a7a-e5a8-08da034fe581
X-MS-TrafficTypeDiagnostic: DM6PR10MB4220:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB422082C8DC12679C0A6D69728E0C9@DM6PR10MB4220.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oP+nitEpigzf1ZbyqFyoJ2QuvzDyohAja71Rk+3NLIdNk27dKU5S/kgi3GPWAl8+9kySJJnW39ubieStv30DqXXsTHE8jlLQE9cV2xPM5/vSJ1oXJsW8f9/39Mci1mQg+uwzawgdT9gV0D4Of4IEK3ws8M9H23t3PAyvzfokMit18ECGYXVbxgtIQbUftiswDB1fiumc+qa5GdwMRrb7p9QVUlb1gM68ZrsFSbk1xZPH1wHsIqm+pK4YwjnbKzpPv77ajBDAvfKdIYoc+eM6VcHP83cPx/HsgGD6vXDUgnl5wjZbKFMTmYSS7j9ajL14i1h2yBH1XGvSfCPp5VA0x3mxo4TNAAFVfbXHt+GsibP2Yfu6d8Ppvd1SAuYvSfv7vhOszeQcuy51q98nbCF0aM90ZCLfisFXYJRBH/T2KN8gmuhjIn+gir+LmGPU9B6Phx5Dmuqf3KfaBz6BXFYEjoA/cw+1R2SAjtsDMIjv7lglNUP5aq+5MjAUKAlfGPyzNo+PzI5WxhsLFPDNbvzwc27bKBX4qaTzdu4AlT5I+eFYlrTUA/jKITinwBHcLBz1xej1Lwlk3z61dRVowIJPvAtoClc+E8WIr89iuMjVvSbx7JPYqLXHmuOc4H3ry8YqZqCfjkmeliq8bwfZmbSKdYKph8wcrLKjrGeJLGxZ9aEgopgu9bqXjgr/FvwPPxEHQv0H8AVTVhiJxEDyobGjWaqS6XZ8ibVj106xwSowADlhsm7WmqA8DDIdlQ8r2efrlspWMHa7syUVX42qxbCzbQXcOK05ZX13GD0wfi/oclQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(33716001)(6512007)(2906002)(38100700002)(6506007)(38350700002)(186003)(26005)(9686003)(6916009)(83380400001)(52116002)(8676002)(44832011)(33656002)(66556008)(66476007)(4326008)(1076003)(6486002)(66946007)(966005)(508600001)(86362001)(6666004)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fuBtvyzltZctrR0Oy9rXXQnORMde3kzAfp11CWPuFDfhBnrhNh6BVsp/avUF?=
 =?us-ascii?Q?Q6PXE/9Eoddb76ZUbAs8aWq+SReXErBjEX/NzjNFAH1NCF8/ycz3u/p1QpX4?=
 =?us-ascii?Q?bH+DTZ9fsrMkiXZiiyw4pXNlDt+wvmVH4gNCAVPJEKnG4W2Kfc65wOgEhFwu?=
 =?us-ascii?Q?Equ2QPMVGUkRlFYYSD+LmTnBevmZLPKiQerej+6+dxBAb2ZANMc///F8kKlF?=
 =?us-ascii?Q?z0xvSLQNzbsK9FEdWJKdHIkl2xuzBxd7R+ZgYy8qBHpuGwyEeSvUSzmNrKYG?=
 =?us-ascii?Q?FYJDqLhS/AWytagHFvnTat0qQ9BvbNHfKnXFY7uH6WZTwmi1lF43Lc8Uv4lq?=
 =?us-ascii?Q?nGDEA85pX5CBcHFkgcysXfyp/4DSQM2iwmp3mu1J91Pls4rIILacBFIDWFuH?=
 =?us-ascii?Q?aZ9jiHyKqUksuz4Uiw6j+7Dz4O3M9Os6RUqkeuYyb5naGNcj7cnVcNbOXLRc?=
 =?us-ascii?Q?QCLl1MzTr8PyKVtYFblX6e9Yk3RwngH564lDVB48XrZCwCUFELlzV+TI3wPi?=
 =?us-ascii?Q?5vksGJMlOkqhgQPLZWDfaQseSUkljZUN5MBvKD/Qc+cYXnL28QN1mkpo2k4K?=
 =?us-ascii?Q?ylFtMIoQSQW1eliVUd6ZpPKPahLy3WPOL1CC3Be6qB9+Tvi72nmBBr0qxHOa?=
 =?us-ascii?Q?kG0elUf0uOZId1HH85SvfqIpE1PPuYbu4M5aoV++LB0Is8up2Wy2gHifnMbL?=
 =?us-ascii?Q?n7M9elfsRTUA+G9ZmpYh3kLKPknoMqI/Z4YUETyDtGwg6becYz2b6b3mzGYT?=
 =?us-ascii?Q?Ms8cyGG+OYEZITko07LDi4iggW6vSxwa7CMyi5cJFJo6EjZUMft+MizW5s6T?=
 =?us-ascii?Q?j/AwKRmAHp4hrr4YhjiKW8ggow9+Ok4qlAOhKYtFwMdDEk0G91L7nXnLD0kJ?=
 =?us-ascii?Q?MRifZ9JFEVmutAwSRc9oWdbJ/offW5g/fJq7aGTdkGeXgYgVpDjIISJqyIzu?=
 =?us-ascii?Q?0Xe/9gxEOi397/MyMc55igt5Y4szOVhUrwmnGulDzGZIeOGiuJiQU55is9Sm?=
 =?us-ascii?Q?Nocal37xHVPO8n2ibuO1LupJcdx6ZbLmbQKd3FPWQDYLyY5fpKOll9XclwwI?=
 =?us-ascii?Q?PEnOR6S3jjy4qfD3tOnYCyo89zhBqXUXIvjdqpH6P/ETl/2439OE2wmaOq2+?=
 =?us-ascii?Q?CpSyqTualvLeoPFkoHLe+Wc9wUKH7Y83HVduicmR7x5+EQtYbWgODeo+1Yg/?=
 =?us-ascii?Q?rxoCggIeq2ruybzwycumxniGWwW2PmUXrDP8eHatz2PxGURlatYv1UCuHAk+?=
 =?us-ascii?Q?ngw/tAifX3AD1HWpwzefSMEazrLCsQtXEb/TMOeXscizpePU10scU9suEdGQ?=
 =?us-ascii?Q?LR1Je+KKdX8GYGeBttyETIHZ2I/6LEZJzENKXyWPPtJtg3vpli2SaanxLQLF?=
 =?us-ascii?Q?MP+BmKfywGr8y70jFgeOaFAyn/dVdhjzsy9l/MIOmB1vDX99/cdPQ8f2GODI?=
 =?us-ascii?Q?0JIUXdYS5SBn9A+mf674Bs5f9nB4sG/RPPNWoy2SlkXKdxYFsJ9RTg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153d0013-209e-4a7a-e5a8-08da034fe581
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 11:11:31.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+kUPYpUMZAQHOrOK4KQa59iQw1c6UGaHDjcCELaEtJHz3grTBdicrz45cGi2YG10qBRBSUHsGUAJ3jT+oLIeSNk2mwp9gCJIXje9VD9He0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4220
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=735 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110054
X-Proofpoint-ORIG-GUID: 6Oa9Ejj55fFlym_nBIN0akA-zRKVEHXl
X-Proofpoint-GUID: 6Oa9Ejj55fFlym_nBIN0akA-zRKVEHXl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:33:21PM +0800, Haowen Bai wrote:
> remove the optimisation of NULL checking it inline, kfree/rtw_free_netdev
> will take care if that would ever be the case.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 91792df..8d1ac48 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -425,10 +425,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>  		rtw_handle_dualmac(padapter, 0);
>  free_adapter:
>  	if (status != _SUCCESS) {
> -		if (pnetdev)
> -			rtw_free_netdev(pnetdev);
> -		else if (padapter)
> -			vfree(padapter);
> +		rtw_free_netdev(pnetdev);
> +		vfree(padapter);

The rtw_free_netdev() frees padapter so this patch would introduce a
double free.

This driver is kind of garbage so I don't really fault you for making
this mistake.  If the error handling and cleanup were written in the
correct way it would avoid accidentally creating bugs like this:

https://lore.kernel.org/all/20210831084735.GL12231@kadam/

The correct thing is to not call rtw_free_netdev() from rtw_usb_if1_init()
but to instead call:

free_netdev:
	free_netdev(pnetdev);
handle_dualmac:
	rtw_handle_dualmac(padapter, 0);
free_padapter:
	vfree(padapter);

Also you need to work against the latest linux-next or staging-next
tree.

regards,
dan carpenter



