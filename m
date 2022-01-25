Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1425D49AFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457651AbiAYJQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:16:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31052 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1455458AbiAYJE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:04:59 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P5fxpb005958;
        Tue, 25 Jan 2022 09:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=k0eofbVCpSUb/dX2914NLlHG+dTvLLmZY60wqUih27M=;
 b=AjEdnJ5pahZ7lzQS3w0OGRssfeoh+WWqn6H/iUlvpSC/cnvBhIOrpBvocYcjayTvnRzT
 UDXH/IlA4ur4OcDxoD0XgjsP7mk9dtjiOuOh3PSzrbq7tifRRIW1n2FFC1Z3iQYY0am8
 ZUfQAHTtVmyzo5hnKeWboGVOvdVIeUnTeHt5gakMXVrkEStweFP3PbK7FBXqBfAMXJLG
 spHDHwMpZ1utPlXdT3gO4KVB/ddwrel12x8HDozHlO8l2cs+lnOvzDUOrJZ8LgGwo+dE
 uwRy1bNK1d5h5MXlQPlI8gh881NAF6BGDYSDAfzAxRBE3WB6OCCKiU3/UnzqJWaLIQG9 Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaaagru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 09:02:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P90RXE132553;
        Tue, 25 Jan 2022 09:02:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 3drbcnax8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 09:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cua2BNmaqmd7hdz7QTMTIPK4Z1affCrJb7TR2yP/zQjalT8ohfi/wzaCcrRtu3nzaQOpEtm/M/uYwVAmzBIUEoeUIqyaMNodDVIRHWAe80JC5mabU5mJCt/8ucQNANooeOdVdbyUIzBtQLufo8ChM44J01xGIqYBRaCiijUnrziSKKizBg9bxNJAiCLflsU97CBOyLUHLGUz8OiGY+SxDDHtMReMQE4oQ5CRH9JhACQznHz2WtP0wHwPTQhTrwRiM7mCzEFVnTnob6TuL9zj+6rR1MPqaObQtmqMFoVa0z2Nho+HVXBj+1pErgVXg6DY20wYWRAEto0FfhBBwAouGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0eofbVCpSUb/dX2914NLlHG+dTvLLmZY60wqUih27M=;
 b=Qj6PaXBef/XCHubaB56Em7Q4yruT4OBuu3EjySrclXvqIyWBjulPI16+gOBK9f3eueDhCyJbnXndDdyNiTFBsjPOI0WuXnaXZHQNkPcvq56bO2xmBBX81/ThoNFLU+biAfMVMKuhCykdOUzx2V6Vu3rFo0jyjaBM/id4EchCsnQCMxXWJIzJlJ3ho8+dGQbb/84xVJUKIIeH/JCirRbSA5cuX69+Y/ra0+aYMEXFeYGBvWCqHD8es7y5p9DcgT6skTS7QUAUL6u/+NTcg1b0DaT2YChoktrQTZEBuWZjpaBnBsTiAOi1F6NEzGBlK9lVjVSMM+J8WIVhhy2OY5Eoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0eofbVCpSUb/dX2914NLlHG+dTvLLmZY60wqUih27M=;
 b=YWJw64WucSIriBBriY1Gnx+zipf+xf4ZSWBDuRXVw0EE/lZvpfRAa2XoxdevfdQ6clonVuNT7x0Rvoee6P1TjkDxWj4xQrCBH9HAjrlWfaGKKUhEzMq6z7aPgnurQXX22UNMszv/YAFiKLfC0qj502b5NmwvviUkosqfbwXbVGY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3732.namprd10.prod.outlook.com
 (2603:10b6:408:be::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 09:02:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 09:02:54 +0000
Date:   Tue, 25 Jan 2022 12:02:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: Re: [PATCH 02/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from core dir
Message-ID: <20220125090233.GR1978@kadam>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124224415.831-3-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e480dce-b3d6-4e9e-507e-08d9dfe17911
X-MS-TrafficTypeDiagnostic: BN8PR10MB3732:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB373228B28B268F029B8086368E5F9@BN8PR10MB3732.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Eu1S1AOyoBQv76BGx8yXOQ5pIlE/x7YpKZpIGEMlPvoxuGYfrOGPEb0Jl10h+aAs0PvomAmGwk/rE8TKaYPrACYQQWolv3/NUs+75ljzsfZrBekMp0ufB0TKXZZgQNOpi8n2W9aNIgo2hqv4djxggALcKE6RPWftHA6KllG4xXDCUzEdbDjI5RFUnZ2GcxT7oyGKvXa7fEU5uTHynVC+SrCnzrcUNaAuXQbAk1ESuSUckdGKVL8ofbJiTEgvk1AbpjHVmbqMQ8jHnCfp8skR6YhW8kRFmJ6iPS0TNC2RA2ZrTbHwb5wktJpP8r7vVYfDNF1bDeFRJ/yOpY/BXA6fXiy63hM50A0dPdNHpuludR2XZLNLWRGAI/NeDBpXSgcIpvSkJQZZdKhvOrZCAy7fZWOh9t3tQE4XxL3gRRmM2E+me4ufRaXXzT4oBp3txNGojk2bMkZrILms4hmiKYx0/gCUdpP9N2qGVzTTfrCJvZS1zKiBev5ms9UeWIQ+ecSr+8vN9cXPxcySz+A7Tmjuk/qtPY5GAQfr3pkXlz9vZkTANSlwX1Kwh3+8Vl8w/MHQ43ow+1F5qY00EkhoGUiMtIS2Za5s/mJYaElv9tDAUe1YQJ8xRjA+djoPFkxZVg5xsKMh13bEeyPlFz1IYkEPwCBXAw5ZUSFd4pLcLcAAJHei66ClPvWOfdcWM4wtY/cGNuKiUvMWM4sYtKTpQAKfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6916009)(8936002)(66946007)(33716001)(9686003)(6512007)(66556008)(44832011)(8676002)(5660300002)(66476007)(316002)(83380400001)(38350700002)(38100700002)(33656002)(4326008)(6666004)(1076003)(186003)(2906002)(52116002)(86362001)(26005)(6506007)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cyzpxPEclOeAXUf/S8y16MubIJ01kPpOlXhAqgRUcWjR9Jo7elKw5COxXHzx?=
 =?us-ascii?Q?g8WxSi+of6FWK50JfVXe7Yh1eEYHYlMbgcuNsEEUF5Vm1fEqNyYSZleeZPfm?=
 =?us-ascii?Q?Scft3WWl7+JNjsqadUEq5678VzkwW9OaIzgNz+vrd0lHbdsy/zpdePyvtmJS?=
 =?us-ascii?Q?ldE+2Q2m6ujIBiNZKbA+wLvI2uQRoPg/Vjg4WokMJcogdDPlQoyEFWCekWOa?=
 =?us-ascii?Q?Ov/rpGUYd+WajBDRACWIOxB7hVAgRd3E01mQ/yDEek0edLQkoncUSNUkKgNA?=
 =?us-ascii?Q?qpw72jfC4JVTQLjjsMcaBw3xv7zdffg3iXd+BStbsyATYbWRFrauXwXEH8DM?=
 =?us-ascii?Q?xGYMIL+QzR+7K5D3Y1IA/oQbA+DG7wuesdCUEKbRTWKqourwF1oN/WIWrC2W?=
 =?us-ascii?Q?tWZogm5Ryq0giJKadVZd686uSp5IPBjwO5nPucT7XHiHrSZIO+WEdFKZudjg?=
 =?us-ascii?Q?siFheDpqyWpsA7/zCswbfwaqdmFpTcBB56+x2G3bgKWNfMmMaWmMGzcq/Sfi?=
 =?us-ascii?Q?zKqRsxzcRPjPedGU5lJyxmAWkliEzJqPWCsMgQOyfOMBaD4js9sdwkUX8/oj?=
 =?us-ascii?Q?g2kUvkXhMTX6Bo+YakFigeTmcWYsVH1GtkZ+2lU6PXRMOcW9UNjL6GaovFbW?=
 =?us-ascii?Q?rFVxbVgfFWAcIFPljnow6Di2L7zycgoj7JV8KGzHnFoBPrBKyq8R6qAXcH4Y?=
 =?us-ascii?Q?5kJ5Xq8i3xPASacuwExL592OIwpuulCh4g4Lumlz3UnqGJTB8btbbeCNcrSk?=
 =?us-ascii?Q?oi2hodoKveBR+fh2dIUWcJgA2ZOAfgke9Sit5UTyQ2a3hQ0Q6iK7UnpfWFlQ?=
 =?us-ascii?Q?fn/OFKRygIfDrkAyhVwLQ/E1RVkp/KiUZQELxn0mAYgD3whTtdRWkzgKOzSk?=
 =?us-ascii?Q?QdgIQ87pPU4FHl4GkgjXa1wnDOi+lI3zUUUi8TDqgp5BBYdTJ6FJ+EQN6mkm?=
 =?us-ascii?Q?7x6RQprj836HPQgbGGwbvWL+0bS2niZ2oGV5D2qKCwBICJ9uHSuJk/BBZMwz?=
 =?us-ascii?Q?BsT5spppzGKebxNPMnZcxeKlNyzayTRf/jHa/4ittKMZIfSAWokFfjH2il23?=
 =?us-ascii?Q?/OUC11hOM0MDytbNUPF3Wg2Cua6egYqi/Lmq6uT4H/IoyRE/eVcoJzcGS1u3?=
 =?us-ascii?Q?hc6TMGQ4OprvbG3aWPvR0NOCJLUUWDnxExkta/cLeOdA87SKSMLdD4Fob1bZ?=
 =?us-ascii?Q?3I/bOsdK/Zq9PDD+4KKS1Ioe+okCgS24wS6mFzz9K/JF5sKHFmqF+fMQLMJc?=
 =?us-ascii?Q?P/tXuQrHTSNZV7tCjyePkBiihyk4WHXtW8BWcETGNdLFzPOZlhNazgt4Bvqw?=
 =?us-ascii?Q?B3nphseTHKI8vitkMUkn9u9bLfF8CbAnHx7lm8HeWHD+13obxko4oC2wAJlN?=
 =?us-ascii?Q?HmxD7bdd72F/hm6P8lPeLWOMyzTQ3Cy+UCOnW5fgxkcAIukWQn97cJ/PA4bJ?=
 =?us-ascii?Q?1uoI9xZCtPDLPe3/tr/z4ywR1YXtTKXsaLlg8m4XcaPSDfQcgcAU7fQF1ldZ?=
 =?us-ascii?Q?/5hAS8MQslNVtecq5zqy0QLDfUAcCERH4EhZyPE+MoBdupwti82nnD1RFsG6?=
 =?us-ascii?Q?Ji+Hh4Y3r9aib+ZSR6Da4a2UdnVBj1LQvVaY2v8JuUpjDaZWTgmaxiNCrejN?=
 =?us-ascii?Q?YK1+cR+9oPvciTqCVm5vlDTiE+H9sre9FSEJmNrvTBnZrdCETZIgesi0jf0H?=
 =?us-ascii?Q?RsudQCU/2G+0bTK21m7PSGBN1c0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e480dce-b3d6-4e9e-507e-08d9dfe17911
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:02:54.3167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ncn5G/6IOGBzMbEHJXgn4XlhDDLSjuVhzpq8xPbjNaMEqFJVXJFXmO/MqZr3vAQJ8qQQi9EUamtMnLP6YDc7e8N6fbysR1UASg3/ygyGFiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3732
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250060
X-Proofpoint-GUID: HIQ0QvWVGbkwqPzdmnI5PiZtpL9mIcEH
X-Proofpoint-ORIG-GUID: HIQ0QvWVGbkwqPzdmnI5PiZtpL9mIcEH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:44:07PM +0000, Phillip Potter wrote:
>  void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
>  {
>  	if (*sctx) {
> -		if (rtw_sctx_chk_waring_status(status))
> -			DBG_88E("%s status:%d\n", __func__, status);
> +		rtw_sctx_chk_waring_status(status);

In a follow on patch, can you just remove the rtw_sctx_chk_waring_status()
function?

Looking through these warnings, a mass delete is the right thing.  The
debugging messages are garbage.  Use ftrace.  Some of the errors are
debug level so they will never be seen.  If you enable printing error
messages, it print a debug information but at error level so that's
useless.  Forget about it.  Just delete it.

You're going to need to redo these again because kbuild found some
build warnings...

Normally we would say if you're deleting a printk() and that makes the
curly braces unnecessary, then you have to delete the curly braces in
the same patch.  But in this case, you're changing a ton of code and
deleting the curly braces makes it hard to review.  I would prefer it
if you just deleted the printks and fixed up the curly braces in a
follow up patch.  And please don't fix long line warnings either.  Do
that in another even later patch if you want.

You do need to fix any build warnings about unused variables etc, but
don't worry about checkpatch until the end.

Basically as much as possible I'd prefer to only see deleted lines in
this patch.  No insertions.

 12 files changed, 66 insertions(+), 472 deletions(-)

There was one function where you removed the padatper argument because
it wasn't necessary.  That's great but do it in a follow on patch.
Keep a notepad app next to your vim and write down notes as you go:

0) Re-run checkpatch and delete unnecessary curly braces
1) Delete rtw_sctx_chk_waring_status()
2) padatper not needed for frob_whatever()
3) Fix long lines

regards,
dan carpenter
