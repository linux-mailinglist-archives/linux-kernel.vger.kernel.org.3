Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C954649B4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575671AbiAYNKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:10:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18912 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1575450AbiAYNIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:08:02 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PAx8rp026528;
        Tue, 25 Jan 2022 13:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=KP7W6iQ9JHCpq3WmUmy1/TWFF1+L0A7GVQ3XQJo/JyU=;
 b=F5zMJwZ1Nk90uzXX1iIh0jNoJFBUCV+WzE+ufUetmc7ndp9ccQxddxSUizVF1OpmVVEv
 +xn7/So9jq357jxDbhxkvo5NAgsazXH69j31SE9o1wCFpiqmgmWn7TYt510Ld8LWsMCd
 f3sl9O33X5OK2+IMk1ffr0LfV2Bi4DIhvpH4Q2CxXjoL+LCyAcssr+QjU94ZJeXRL/y1
 70Ql8dDFK1sN6PPgiTcu60248vgs+a+DNSmZFIFFSLlTJp7x+WfaZ5e9tGJqCoEP8RV+
 61CvdYNfv5K6vzdi1yxVDN7rkmw29Wk0dFR8Po+QIJVNNe9S8qpbmR4iZQ6MRgtyt+gT TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjbgdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 13:07:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PD0QUu110300;
        Tue, 25 Jan 2022 13:07:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3020.oracle.com with ESMTP id 3drbcnudah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 13:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW/ZNkTalS6OvzksXkFEpEBsgiJvFGSkV/Df/QGl872PPKjxFGYOFuZgg8/pwqDLKcmdt3+A+RnifzqIOgBsI9c45Ge6PvqwKwS/Grn/ppYpMgoEWu2oaSsPYUJKZOBc0pzG+X8/iqM/9vHn54+HbnW3VN9waw0nq0+uiiPlFlR+w7POjhMKoTJu3MfM9ddRD9+/PPfLAwqwJstVCR4IAWLwGSKmkBFDLNVs1PF3lBTE8OI4kmHvhrWqBjtKdxoKaH4NZcrBnbSwGXs6KrCt1QZVI0RrvEKnFzDauyzBJxoo5funOESHR1Vv/Bp0F8KrWJ230F51/UJdA/EbynZ1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP7W6iQ9JHCpq3WmUmy1/TWFF1+L0A7GVQ3XQJo/JyU=;
 b=Uj5K1xytEQbomSlsm2I4jq3kqFaLxgkQkFBrBzohThfO5MXySUW0Ny7d2OBazAkZDAyoaXFQgdv1fC3WkME6hpF3VD6tWNAyk4mZhBUMv6eXNBFcB2mPieoNHvOfQ9EHZ//HOc5JgP6xe3twSeCGIn3zfH6vrFo39AF8I8+pe60JzT25XG0g4PNSeuWyGI2GbGpOCGvFSsuHB9OwnoXUsjqoYhupZLiJ0SvTo3WFcEJKXH6YXCsX1SFjLdTROYmHjqiwByjRNPn5jtD0GiMS6P1yVHzhcHwRs1evx41MtghZqcsmHBDbnVStSGnqRvYNOB/W+CaDbEf4GCqiolZ8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP7W6iQ9JHCpq3WmUmy1/TWFF1+L0A7GVQ3XQJo/JyU=;
 b=ramnnjKOMvzCzT7sNKtVDeoAEOdHLKDcSJf2oFaRSwzFDR+EFjyDVmyg/4aB7J685rdkKEK+eOTxEXSk/La7Z80zo2EY7ZXlEiP1DMm3YIs4tX+uqvFCKKBXk0WTG7cl8XrYJJ6/KmgfugaFvTz5vHQzQQZltaDbTHGjAtg4jkc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5482.namprd10.prod.outlook.com
 (2603:10b6:510:e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 13:07:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 13:07:40 +0000
Date:   Tue, 25 Jan 2022 16:07:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from os_dep dir
Message-ID: <20220125130720.GT1978@kadam>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-6-phil@philpotter.co.uk>
 <67ddc4d7-e19f-7c9d-a4b7-4eb555830ea1@gmail.com>
 <20220125125942.GS1978@kadam>
 <fa0a2717-aca7-a323-2e57-93a9f7b8c371@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0a2717-aca7-a323-2e57-93a9f7b8c371@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6fddcf9-2066-4fc0-13ca-08d9e003aa31
X-MS-TrafficTypeDiagnostic: PH0PR10MB5482:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB548229030906201A389ACFE88E5F9@PH0PR10MB5482.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YRmN7U2+wgI9U4ZQacAbCw49iMK3p2IORRx76R9m6DlWjPGoNPji1B0E0cYE6ejvGm6hn+ACIQi2t85WoYhzHd4ley9di7B9TFTZ8A0d7HRxTclgtX5Dcx05AmKD+b1xsh7eU/N8RifMQRe+jV/9E6l7LXf3Af1+6sYq97ow7BOXjgX5cD3uQF+ecj371mLp4d1dCJ54iN2JtGYrmVXa6MnAOtQN7QWAbel5EcV3N62jovNQw6QOCGO8FtrxFV5tgZvbYTDSYgJGHlkfkgNXBVAnsE3H11fTt7LGJriiofyVujrDAGe6r43umS9NTcfHfBxGEjUZoB+fWwVDsK/h82TDOw/qG22hrEDRsuPT3LEZG7Z9am2lDXp4rY0TGNm2dAWhd48lNtDWAgYgrRYZQEjVMtaYDE6B77CbSyB4xXK80pcRpzreMj+8a5Fmd2vwlXUYL8TDvRrO4+2us2hAhG1QgjvgzO8sY25Eu5fpaIVi/94pD47dQblTqxhPKyMN6d9ySWmK3+IamuB3m3hi/whF91w5r5zuoYxqB0vS63u5N9Kt6w7B2xtN+PbheqfQzmkj4A5POg1RNMtxtscTvhNdP2fnQA+THPy02HT3OmKsc9FYMplKPVz1erEHRmf5QXqiNrbF2Sieuv2ihD9lyIbtatkraYaArUvXmap3fS08ZezVt3JDp/O1DFp1bHxxrCN2UtB/nemkgwrR26J+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(52116002)(6916009)(6506007)(53546011)(508600001)(2906002)(26005)(6486002)(186003)(86362001)(1076003)(8936002)(6512007)(9686003)(44832011)(8676002)(6666004)(33716001)(38100700002)(33656002)(316002)(38350700002)(83380400001)(66946007)(66476007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0GXBkcBjY6sl/Kk2I+/QAuUH4J+kaQ+X2ahFa2axwcXXiQqiK3HHLdazDzy?=
 =?us-ascii?Q?86fUeS8w/1FfwW0CgMKREx+sEfwCiOqMXKIvJ44k+d4XZvwNolZr6hDuC3yf?=
 =?us-ascii?Q?q70sB/glDZy7gfOmido/zfebWLYjK/qeaziRXyphKO/sns9wS4lz0ifypxnD?=
 =?us-ascii?Q?7hxWFsDDy9szPD7UaOn/xODjxFi5+mVIyPMEBt3mu+OHNJ9KYieLdX8ABJAH?=
 =?us-ascii?Q?onjBZsJH2EXraxRW/excQUp5CmqTGVSkrMHNiJi0Fuywog3U/+4g9oQ6HAay?=
 =?us-ascii?Q?eWyT8zZws8Sy7HdQgVLyz3CKfDhEQ96Bs6ZJL0b7euf3s4ljV+r3Jl18+6S2?=
 =?us-ascii?Q?QYD7QOBgK7Nn24O+xPg+wLB2eH4yATksGhQNTR9XP2dVcWKwWFL9ZbA9mEFI?=
 =?us-ascii?Q?8JagGk3ptmtHjipM8lxBAc2JY9/gLS+19W1Ku823dFTrxTi7wUYRXJF/R7Lo?=
 =?us-ascii?Q?Sp+VcdnsBxAtSoW4nV7q/McpVFvClrGBtvGO7qhkmVXQvYGLTMq6UioUQtaH?=
 =?us-ascii?Q?kILZr1MR/HMDDT6v0tAvyEbLw/6WPmmjgC+dnGL6wEZI6gs8C5LKvmEmVhU4?=
 =?us-ascii?Q?IhNDErpdehuKGq0mlPZAaBXnejr2HCklMIs90ClT2Cr40W34LulKAgVa0y7c?=
 =?us-ascii?Q?92lUg+G4O0Gc/CieJOTOiwxXR9b9qS2999icgwt0ehWpNqx6oWFh4rolAwLY?=
 =?us-ascii?Q?6c37frObRCtTc7RWma0mSfOUPMsOSpZD7wNha1SrcEYkXUbwMRzgDGCpnH3T?=
 =?us-ascii?Q?ELvxSMrt5oTRCyo1rjrYvQl55nP3H2piBUCFdvsPzEtlSYJAdmXicVoA2NsG?=
 =?us-ascii?Q?pJ8wKweoSh30v0/f37xiutgcqw8/1rAmvyKCu+XA/SdUtxkpsKnfJhcDeqt3?=
 =?us-ascii?Q?16DP47L86QzPOU8M/prQUMdmSxf3qMwZR5HARP2AfUdg9X/JskUWWaukeiYq?=
 =?us-ascii?Q?i3Psgna+GI95B4LmDRUs+iUb0HTUET5mP+lwanM4N+irXOxQFQG9Io0pnRv8?=
 =?us-ascii?Q?3oy4VtJwV2o9YgkjDD6PpgxG6zykfL+3pxZAEyOxOypEbGnzYF4QZ5kCgZtI?=
 =?us-ascii?Q?DczijIWEWu2ewMkYZrdQytUmIky5NV1UBe/IrPOXav01OYXxc925Ys5I4wRI?=
 =?us-ascii?Q?21TlETFdSxZYlmMZZ4NwSCL4AnSIy+wxRUokwDNF8ikVHCd7taESmlhCF7/N?=
 =?us-ascii?Q?9EDeaa0Lym8VgNsGz66gQ8Yc8zkqPh8ebORGflTiKSz1c0VwrP0/rNmdvc4c?=
 =?us-ascii?Q?naDSz9RfyFJ/ckw3gt295qhWFIcOEb1WkxyG0xZkOAXgdw1H4RE3AvjyvhBO?=
 =?us-ascii?Q?AbZOiFHowN+BHtLy1DpAzwqoLlYWAXKjexyl1qDlYy4JR8Da3zgJkavu5blP?=
 =?us-ascii?Q?LYfYxNIVm/+DKxBnnQFonuBRPIkd92Jc49o4vq4nL83Pfe1gR/W6yvwZj6Rn?=
 =?us-ascii?Q?lvhiCo+760mhSpBAqL8bk7Cdci8a2idUzAs7VvjpRb4DGCDfBnPl1kn04s/T?=
 =?us-ascii?Q?Bjwb2v/8IubSzwb0CM2uIfQQ+92Rk7jVwHBQnB1XI6cFP6GyImoSxLxzb0Xd?=
 =?us-ascii?Q?Utl04+QIdizFqhls5FklPmWOLGPqfideNVKcBvPjQIvaDZGMHV+FetgNi86h?=
 =?us-ascii?Q?OKKUac95bDEiNmW3pHUu1CkflM97G9HARWulgl9MA4dt3m+cWgjxnd15jAiS?=
 =?us-ascii?Q?ixv4AfsnqhvNLkZn5sIngp7OXDk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fddcf9-2066-4fc0-13ca-08d9e003aa31
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 13:07:39.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cKt2OSL8HsAEU0eyTrYyUimmCJ1TSgg/Vji49eRQF9PRryeG1kzCEgcEifFTAT8GWQ/lGVrmenB1E5uy7Si4hLNLi6Tyf1mWDhAIOEOxXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5482
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=945
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250085
X-Proofpoint-GUID: nTItlMDXJsIjHE5aR8l0SE-9i0Wfu-0T
X-Proofpoint-ORIG-GUID: nTItlMDXJsIjHE5aR8l0SE-9i0Wfu-0T
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:04:48PM +0300, Pavel Skripkin wrote:
> Hi Dan,
> 
> On 1/25/22 15:59, Dan Carpenter wrote:
> > On Tue, Jan 25, 2022 at 03:48:32PM +0300, Pavel Skripkin wrote:
> > > Hi Phillip,
> > > 
> > > On 1/25/22 01:44, Phillip Potter wrote:
> > > > Remove all DBG_88E calls from the os_dep directory, other than those in
> > > > os_dep/ioctl_linux.c, as this contains almost 200 on its own so will be
> > > > done in a separate patch for ease of review. These calls do not conform
> > > > to kernel coding standards and are superfluous. Also restructure where
> > > > appropriate to remove no longer needed code left behind by removal of
> > > > these calls. This will allow the eventual removal of the DBG_88E macro
> > > > itself.
> > > > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > > ---
> > > 
> > > [code snip]
> > > 
> > > > -	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
> > > > -	 * suspend influence */
> > > > -	if (usb_autopm_get_interface(pusb_intf) < 0)
> > > > -			DBG_88E("can't get autopm:\n");
> > > > -
> > > 
> > > Didn't you make a function change here? I didn't test and also didn't find
> > > any mentions of tests in cover letter.
> > 
> > It is obviously a bug.  Please avoid ask rhetorical questions or someone
> > will answer them.
> > 
> 
> It isn't so obvious for me. Might be Phillip knows something about
> 8723AS-VAU BT (whatever it is) issue.
> 
> I prefer not to say "it's an error", when I am not 100% sure :)

Oh, in that case, well done.  Good job on the review.  :)

regards,
dan carpenter

