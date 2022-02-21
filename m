Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB34BE429
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358542AbiBUNGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:06:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358536AbiBUNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:06:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE8EF34
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:06:23 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LCr59l002355;
        Mon, 21 Feb 2022 13:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=kILDo2zF8qjFH54gRd2yie0Oy+RloJn30X9ouKV71P0=;
 b=f6IJYfllGJduChVTtI6oPnTt1PbJqhfWNrRtyrObGIx24tEUj0I5nSvk5gKC438dall0
 k3bXVbYl+EWznWTMTBan1szdZpq9/YdNywTxVctBjSsL/9/lcA+mlPaLoQ1KI7fYJpyN
 sKRAdzVvnsDQhhxGtE+FG4wDMVOSVMt/1PsZpMYjM8kTJgKUuGhIuqmpnjdyGlB7sejt
 EuE5wfFly0FYJP1lQ9YQAEVA0rHS40nv0wpSsXWAsJIMvAvoMMnmE1Ckkxc6araOnI5I
 ColxQ1ycXdIudmilZaUB4OD5YQxm+grtubpCBakY0JtFJiLxjFA+NKmSwPXQk4LHVQ5e WQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ear5t42rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:06:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LD0n4Z136657;
        Mon, 21 Feb 2022 13:06:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 3eapkep7cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDCL++LYrGZ1GCmucxeejY0bTBOV/j/JC9c39CJmp6KGY8CMI16DuFL5seQOOTjnhsufoYzUY/P/uOKA6faSKjnFNB8SvCQKGoqU8PUuHsT2XZyv081Hw5riY2Ru1GTZw+2/188T4Qr1j4JiG4CbvoruQ6h4Cdt1h0gJsxVvJygHb1D5VZlnGjQ3dGZ1vdZx6vTR9w7Bwn04tiLyuobMmE4JQf7L0AwE/TyRAti1nLOkG5iiLnq1AZGD8orxFUiY7i3opVWRLM7skyuo6CMGGgRGk6TVmRANbcWQJZuVSELGyCFRLNPITa7xksCn7LnDGIAbb4cSHgTmNLmOY9ogJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kILDo2zF8qjFH54gRd2yie0Oy+RloJn30X9ouKV71P0=;
 b=CUcgvpTPYCDd/J48ENNtQHS6pOP5LML5HPanTqxZwmwuHVGfOUkionHbgTN6U2y3hwPzdreUEEyhdjp4/ZGCYWRF/cXQBfPZr591qG+mZUN2GafyMfIuhKlY1B5LtaY0PON3eliDPHzFSJerxiUEjIHmXi08iIfiD8kLYH+DAGtRIkgJmpy2bVMZgqNZvnRp90VOHISjLL5ZbcB2g7Gf+afp/naTgAO673zbxIVCMa6eEW/BwCz2WHsP7tfB6Im8OR2JSdFgLLNOQY9NTkAKNMY6HvVJJZBVmfGk81MbxKAySHN7Vl63hKUWb7KpVIHD2bfA9I4IWr16GfnroSxywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kILDo2zF8qjFH54gRd2yie0Oy+RloJn30X9ouKV71P0=;
 b=J4Fgj599+nW0YSZD6tHcOrTEOQJpLinu4k8IQ7Fcm/FsKXQb6OrLOInk15wccqT3Ny3vnvnR7Nq9/5Qmc2c48dc2ymHXnxAug/hoiH40wYpmr6C6GjbezF7Q76YhU/4BYVsemwZ1Wn9yvOkRjDJmXzzHHT3wPtd/hPrHJH1Fsyc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5367.namprd10.prod.outlook.com
 (2603:10b6:408:125::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 13:06:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 13:06:11 +0000
Date:   Mon, 21 Feb 2022 16:05:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Cl=E1udio?= Maia <clrrm@isep.ipp.pt>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: cleanup proc fs entries upon exit
Message-ID: <20220221130548.GK3965@kadam>
References: <20220220231554.2510567-1-ztong0001@gmail.com>
 <20220221130006.GJ3965@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221130006.GJ3965@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ada2be97-f593-46f4-923d-08d9f53aee57
X-MS-TrafficTypeDiagnostic: BN0PR10MB5367:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB536797FCDE7B92720D3B554D8E3A9@BN0PR10MB5367.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16sOwywh2VFCyajAEvgDPNTUeCgVGVZZOKfuyHfIMV8oSC2J0DojDLGM5m2qCZTtS5Wh3pvjd8ql0NWlOHXvgwgJAZcjl40R0VnI/pk7/XP1D7TiqXVj/Q5kD4RG/UUNkhdvGM0SmTs46FJQOULgqGr9A66Jyq1EV56J5CzWYubTvcXIakCcSCcbHsrIeOUZpomPhQBJECJ2oK5wM9MxP4FYLUSqdIaKV/ejpPQwrZDek9QXS04VBMoDLJLlmZOagHOW23F9PEgQPN5ex3Uhe6ruz2ok5xVNge5jtnvm04SifrgQ3Oe3a+ZU+ezc27Q6u2Kf1oSddvrbHsMj3ktyvVaKeStBpJxBoBjqT3pppVm6fSfCXbsdrUVKrM7EvuKmM3dDXv7xuXbaBGzu9x/z+soPu0Ixuu0drjU99iP3DDjvsTNom4CmpGA5PDnLUl9K7TuYVjRO1FQQxMW9eEnO+FrHH7++pMlFgrBEKN/ql198P+hJcHg8JGi+nBRu2kQvHP6iqy/n7sUb3JM3/Y4DGvgj2JwmxHkMvvkklOhJpDL65ljTnGYKvRhvdkzUi+i78wHXHj9thZJxiPXeTZr30hgBvkugONqtMusjACyqatd6UD2Nr3TeCdRYSFsBxLphZU2Ft+cK9uG9M5KOsRdPR1KRXzOdGLhZk2yvLtdobSJuBoNnMCoaPB7WDEJXJ9PRVC/NtWoHN00G/Pm5f1C8EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(52116002)(38100700002)(26005)(508600001)(6486002)(186003)(38350700002)(7416002)(33656002)(5660300002)(6506007)(86362001)(6666004)(1076003)(66946007)(66556008)(66476007)(8676002)(4326008)(33716001)(2906002)(54906003)(6916009)(83380400001)(9686003)(6512007)(316002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?teJgnLC4vdlyUK9dekborg4EAMcpa8tpYOiY2FYiG+mLEnRJFYZliaZF1ipK?=
 =?us-ascii?Q?K3KHVAJjvsdMhWqc6EHT0xwNjbRiQSCM+vldFbwJ9mqXK27JZLfpht2iVJ2I?=
 =?us-ascii?Q?k3/6WlmFZMuFqaR7EainUSuhSk07d3IxmlwUq+PsiphNt5A8mSs3a4NEem1a?=
 =?us-ascii?Q?/ewp67p0OkW7K0000BBuwgduUzpAniULixgMoElGC4vWP96+BMMhZ0twTyxO?=
 =?us-ascii?Q?i4jazrbp9tC2pZwlNFd6pdNYxJpega3VoFQxog3u7uk9LTTc0BOWFHwpqK65?=
 =?us-ascii?Q?t2VY6IZbRhZayb4GjU+4tqiHgqVJCR9DwHsaT3q2wmTtNKxBQ7UuznnLPruA?=
 =?us-ascii?Q?1ChlXA/MGdcZPMVf6IgglFLt3HKiS3h6ZfvF14nDkWMJHkIxnMaTUJYEKo9E?=
 =?us-ascii?Q?Y6Xe0D4z2oMvDx+aZnSsHrF0S4yTuMvDirRPNqXqCPWXDW+t3eX2f+nPdQO/?=
 =?us-ascii?Q?Oh4extP8MNjrrJdxBFwYfRQpwCNgxq58iMMJNuEhxwvTvFwDyD5V64Tlhy7Z?=
 =?us-ascii?Q?5yloymYlM7JKgALPqreYZVyT+c1MxoTWbHNI8YT6rk6/fLogDAsrmSu3C5xB?=
 =?us-ascii?Q?MGyoubNriGLuZ3De3qdImqWaQbNpJ52+HFBxHo774DCsihHL1uAcno5PyZMD?=
 =?us-ascii?Q?VqIJvddpM1/AdQPIbpROTDAMW+tAHe01Spv0891hRyy/JENM3AWwH1/CL33J?=
 =?us-ascii?Q?Sq1N/Zaj1qHTZ82kJ8d3R7uoIAFKKT9c8OW1jg7Ez7EUKQlOs4599XV2CDS4?=
 =?us-ascii?Q?4+sczDDK5vOrgoZiIVoMxE+yIZW9lBxA2EoBQIotgpGBR/e1qSWt1aKYEm+g?=
 =?us-ascii?Q?qZhnk95eJw01oUcP0jFQONwzKxml/ppCEtabOLmVHioHrCq2luYvjAGgIAAC?=
 =?us-ascii?Q?Q5dUTHfAFZ9yInyc432J07WA929uSbWTlSoBozhZSEdwmNBBRyb0CESOrz1A?=
 =?us-ascii?Q?6uMeEKtmOeYIPNDsX1s704v4oBOxToF4KfuRbgOz5g7JQqSvuRImQvC67DCs?=
 =?us-ascii?Q?8/sJ80wx5YPMkvBD44TXT6oeBLdEQVAbh3HYvXTSyDMVlGXuVLcP+U07hovN?=
 =?us-ascii?Q?Xlpuma+b6VN7RerYb7Lp6UHE0wDFR+Va0AA7bRiUzpMQqpZGlBeE8TNFMIv4?=
 =?us-ascii?Q?q6kCwxYcfIy/aYWYnOcYZqGtlLjIRZMfH4noK4DywqluJRJEF251cmRbKc/P?=
 =?us-ascii?Q?Tpg9lQ76UBWuwITJnhW0VSmeNbNfehpYrhtar3mXuic+xdGuE8NI0bhJrtWZ?=
 =?us-ascii?Q?PsL6LCHpEqWwtvyVCOQD3QFm4uQ2XyIiMHX3nbBU81BGQB8v+7JUQdTLhNC5?=
 =?us-ascii?Q?LOn3jqvgBHdK71Ii2yE7y8os26JMIaEcqP7rJQmzwF5V6ElXlXXVawLF2uO9?=
 =?us-ascii?Q?TBGxF2abrYphEOdA7tCwO7clD2miAedeuKuU5F8rGUnw4/k2kgcpP181PDKm?=
 =?us-ascii?Q?YNeh/LA9ld8OBozMm3fLENcRn/+RLvNSGqThuuNMlJTxFqYxMv5zHTDJuN0+?=
 =?us-ascii?Q?qiBiUn+CucvMsIw1rQlIfhkfMpzWP6V1xHhrpp+0E2b2G53/EjspV5S/T67y?=
 =?us-ascii?Q?+lRO5V0J3FohTo3W2QmYwzsEs80NmAb/W9EN35Tg5FZmUE3XuxCzpFiUjn8p?=
 =?us-ascii?Q?thhYfnYjeQMUd43m37iKyAPLzvRabKcO8iQq+Jg7fft1PZtdIi5jgjUj/md8?=
 =?us-ascii?Q?eBQ2kg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada2be97-f593-46f4-923d-08d9f53aee57
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 13:06:10.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG2mBKLdbSCa5zh+5GYWdtkXfMoQRRhaiZWzAgEmhDAmQNfGLEh/XpwAO1m2QntPUX4Ab+aqHLaumIxJp5caxbNX8xOMlbWYlf9/HWxDnF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5367
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=950 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210078
X-Proofpoint-GUID: Q_7vto0Mhk4wW5wZrLgz_hE9lhk3u48v
X-Proofpoint-ORIG-GUID: Q_7vto0Mhk4wW5wZrLgz_hE9lhk3u48v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:00:06PM +0300, Dan Carpenter wrote:
> On Sun, Feb 20, 2022 at 03:15:53PM -0800, Tong Zhang wrote:
> > proc fs entries need to be removed when module is removed, otherwise
> > when we try to insert the module again, kernel will complain
> > 
> > [  493.068012] proc_dir_entry 'net/ieee80211' already registered
> > [  493.271973]  proc_mkdir+0x18/0x20
> > [  493.272136]  ieee80211_debug_init+0x28/0xde8 [r8192u_usb]
> > [  493.272404]  rtl8192_usb_module_init+0x10/0x161 [r8192u_usb]
> > 
> > [   13.910616] proc_dir_entry 'net/rtl819xU' already registered
> > [   13.918931]  proc_mkdir+0x18/0x20
> > [   13.919098]  rtl8192_usb_module_init+0x142/0x16d [r8192u_usb]
> > 
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> 
> This is a partial fix but there is a lot wrong with both the init() and
> exit() function.  It's not hard to just fix everything and it saves
> time.
> 
> Here is how to write Free the Last thing style error handling for init()
> and when you finish writing the error handling code then the exit()
> function is just a matter of cut and paste.
> 
> The rules are: 1) Free the last successful allocation.  2) Every
> function must have a matching release function. 3) Every function must
> clean up after itself.  No partial allocations.  4) Name your labels
> with descriptive names to say what the goto does.

I meant to add:

5)  Free things in reverse order from how they were allocated.

regards,
dan carpenter

