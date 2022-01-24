Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7349790C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiAXGuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:50:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34738 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbiAXGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:50:02 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20O2TNBK026846;
        Mon, 24 Jan 2022 06:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bg7iHWAUAmnApD8+c8cP1Qzz5jvEkP9bfopd1nnY+4c=;
 b=sFb3dbWkAW+9oaIbyEkUYExtMEPxWGRn8GRIiOPwzoVtVFVBvqARyO4Qb7WkjXp2VQ76
 sROXN7Wrjrad7XjWuHEJuyNvEzBkBVq1od38rnx8GhmLjEpFjwL8Oy2UBPz/RCwLomEO
 JsGka9skCczMCogJXuR/+2tepzgCe4Xpmv3v24QS0ZgFYdkTOe9JmXLFz2/1EeUP+cmZ
 Xd0WetYMqYg2fTb7AJJqORW+0tHWrDalE1Rpr9AeIcT76v/iTFcq+n1z00A5DZ7axZtl
 O8VuPhMbK32ap5IK1ObOGexzerjlojCZa4SqqWBvKU75VaJY1CluSTgMayFAKKyCfY6d tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr9tb35bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 06:49:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20O6kMAg082055;
        Mon, 24 Jan 2022 06:49:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 3drbcju57t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 06:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAMFVJSNhoKIcWaY0ielpWEJVJ0eqk7/Ujh/UBvo/hrbEIMxqSJ0BiykCRIta0f/pAVuiQkLSfA1B01oDFNi5lUR0xGS0DP2WEG5tGwrM1Ma25iwFBQuoVpffn3JCQ14SrOH0k742VytSgTdHM3mNwjVB3nMzLRMPt73KNbF7Z60MAw/TfOMb8mAK7gM7xMjaBxWW/ckoUlAdArAZx1BGqRjwTnbxhkmLnR3sUPJWwbAkfWgmVVwHGitQHd/19QNBWzxpZY7tpj4hNp932YIx6PnrL193Ejvm5x7plVzRfjxIK4gJEYi7OU/GNcVGtctUt25nitAnM7toaYkrMEidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg7iHWAUAmnApD8+c8cP1Qzz5jvEkP9bfopd1nnY+4c=;
 b=OHMsKzqIg8/coCF6fSWneEe5XQoqQSz+ABDsMozRmW+tADB6aULKVuDieP0RLn/9s+FPdxklJ7boaCccqbn/xqhO63rRmg0AWLMGoFuUuN906DpJ1XqFrqsureMbu4+vK2UMl6zGBm537GPGjEfW7gCrOO1IIEc3pXokosi265bRIc57nLUpHylVDP091tEpVJFnOb1CiD3E1mMoO4JfQ928bvBLoKChPIfSK21JEYiqBhLdKOFjRfabPT0N3SOrbdimM3ovIZpRFxrzxqJMzwPiGs5y3aCMYRQxPs4ZCsTLC9jBU+OCxDZ8t+o8qSaBN66RaqAEZOX/XEql0s9puA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg7iHWAUAmnApD8+c8cP1Qzz5jvEkP9bfopd1nnY+4c=;
 b=jXhQlzPovCEJm2rTWOKM2a0UjLAwtiIr8S8R8qiKIuW2mk+nW9T2TRkGq5Hvaisa3nJ87nPISg2A82t1l9F3Z6LOhFNdIkvrNtSPcswF+yCxkO969LvCS4gPJNRW4lR5ppdn/9wdpBPuUUvXGn1Vx75vL3hB2chD4jbuLBRbc84=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1556.namprd10.prod.outlook.com
 (2603:10b6:404:3d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 06:49:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 06:49:40 +0000
Date:   Mon, 24 Jan 2022 09:49:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: handle rtw_init_netdev_name()
 failure appropriately
Message-ID: <20220124064918.GR1951@kadam>
References: <20220123181734.10402-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123181734.10402-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67eefe56-97c2-43c9-161f-08d9df05b16e
X-MS-TrafficTypeDiagnostic: BN6PR10MB1556:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB15568CFEF0F7B75C163BE46F8E5E9@BN6PR10MB1556.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhaeoZy3O2HchMGhLtj9HJD7cALvtAPnSkoBDEuXylOgacJZ8pMxkZR8I/CCASjPFzcHtgYV4atGcP82HYd0doe8zjMkIsRKe1sYbTWkvdorlodke8tjXXxhvMrS5w9IoofrG1sh250FwVbfAO5YDCXk8fJI/UDiWsomYyzbUC/Xhrv0FF7YAEzGFwAigKoVGiUxI7geDfPAucW19CCv3fAXoUO7CmHmqE3G/oCG5N2aHfDzwmTJXj0zbycnstjMVEQInlfAAAmUcortLt8Fs7u5wQMy/PGhaXHF8tWBBgMLSOi2FGUFpM5MP4GoZ1lhBViitU6OMIU+bNoA7XawX8dX8zgyN9XbMHix7U1fcUGECG70GEvSqt8vdufiGR9X5cPnkmr6xzobTAy+twqi3jecLoBXDgyds8jGSB9Yg32E8fXhkvLKZCBTJMoejM5ftdSf+gCZfYFuifEZHDSBweh9utLjSSkNK0WL0vK34O92DyP9tfYPW2v6511uz0OnyDrw+5lrKFVlcwf2iBSrnaHGAzoH9RLjb1F24RY44zVSwWFAMORr14qZKiB1AaX/slHgNfMy4Nbvx4HSLQGUHMcgWqHgQjPtYLTGIXMZzdNWq7pNmXMStBTeB6YWu/mV6RT5O6sBUH0uwrLzePWZN+HOiqfv3PFHYyVSxn85JrkHkY/C4S5bpEtL2t6xLkQtFjrcZGzzGYfE80OIILyz+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(6916009)(83380400001)(8676002)(44832011)(1076003)(508600001)(52116002)(316002)(38350700002)(86362001)(186003)(6506007)(54906003)(33656002)(66946007)(9686003)(2906002)(4326008)(6512007)(66556008)(26005)(6666004)(66476007)(38100700002)(33716001)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?41ICoxmT0e4Tx5QhF1Q6K4vVuvpQ1zofBc0QbvtU+myVEQKJNjceymhgiMLM?=
 =?us-ascii?Q?s40Sc44lr8zwNdw7MCUvL6sMCFixsRnWrFxzttiMPmmx67fSqXNjeKTceWGD?=
 =?us-ascii?Q?QqHGtCNJLvT1AUq9ogIK0G6fBPAOno/Hv36nd+F8FVvJynfXgbtd9JzG88tT?=
 =?us-ascii?Q?EddfdfSBlTs57wE9x4+qhCvl6x5kM55Inp+uV0IX6fQT4PNhQAH+cPgLibuY?=
 =?us-ascii?Q?O4tIHuftnQ7fJ08+i8DhO/jglgWVV71wVc9iC6zkPuzp2uo4QIEF/YrZ3h+S?=
 =?us-ascii?Q?GVwjQ1GT9BlTWm71z7AdsqtQNHsztgYBPTuoeruP4NDNaWXIqmC3XLpsIXYc?=
 =?us-ascii?Q?fuR8OziLHYAlkYLHuaoKslFtXkz/oEfasinzrv3t3WhUmaBJh3gnAzpbRy3o?=
 =?us-ascii?Q?IcubmmcrgKIMgSyDxsaZ226VFe/xWWfyw4OQtA1w9rpVzRmwMIi6bAdZ+E+J?=
 =?us-ascii?Q?OkFI81D8aWpqRM+mKXvASVnBe8Ys0mw8Qjav189shxacLc1xIwEYGRGEkFwb?=
 =?us-ascii?Q?E0J/Vfzng6Cxi4200Lyw4/OfN/aJpzYrYRUXIUBj/k6YsxgFb7MhgARjwpBU?=
 =?us-ascii?Q?3au4MxtmqLQ9IRk1ThdS2vWi8Ol3dNOXQ7d3uRD956x7EOlAJy3pdw+zc+un?=
 =?us-ascii?Q?HfMJqYBJJu66Vppsu7VmNww9oBXhMpQSu1VJ5iHVtMxnOPGfxh2gA+B6+yCV?=
 =?us-ascii?Q?VDS51TcJGqjuZDeDZAiRNKEEDsGTQ8xGv2Qn9UPRb5a4IeVJY6k93zXQz0M1?=
 =?us-ascii?Q?wWg5BBXwBMWi7r8q5OCnbYUI0X7sHpQ1+8exgDcZxxzs7mzaxH5Yh+lXkRo8?=
 =?us-ascii?Q?wg2LYTxE7EZUrTi0MBO02UpYZnEpsT12F0sDytfzUu+mYLUwPyvP9auygGM+?=
 =?us-ascii?Q?3kuNEU0+gbIwdk5L5yQygg7QREsI8Lonp4TlVfreXDRaPP5Z0UGhLaT1DR/y?=
 =?us-ascii?Q?Bxkzf02Kb9COCCBSMad0BSg3ut4r0geDXThG1PJTcX0FZOkuChJmXcDU8fxq?=
 =?us-ascii?Q?X5Wjz8jlGuzghfDXaFGveGwdpQHw9TOzldBL2Yq2U1mNBtrG9prXQ+/pK4vY?=
 =?us-ascii?Q?ifO8dFF/4e4km6SznoH0BlKqXTY3U78DFZrBiJDb5Z+D+k768yBluQtkq8CV?=
 =?us-ascii?Q?/RFCmfc1RT+7DOFpPvssDEpfOYJ1K6hIWVSrpMHRFbz6miuDwBqkxEkEw0uU?=
 =?us-ascii?Q?OXP8lWcsQxZ3tOZonZcOUlyScC/qZTtLJ8dHAxzpPvSvIhi0tz3fsXFAkLDb?=
 =?us-ascii?Q?1yLCZF2y/xFaKCZzEzqECHmX0xLMxcx11tbd0SJGqOvkfx5UQLMNmDLeN7rA?=
 =?us-ascii?Q?+dvxqPkPRHad+VUPj1o8gU62/63EFwHrIiJ4WW318AUA27qEOXwsD+3Qgz90?=
 =?us-ascii?Q?kdhtEl+h2vMcDnfenbiWSJEDtvR/D84TlN0P+LLgpCL7kPrdkeo8HKWJ5rH1?=
 =?us-ascii?Q?HOHjFb/Fhmvly1dGQPEW5wlbtrT/6/7mpJvhjTo1A8IxWHTZmH9zEiBrQ0y9?=
 =?us-ascii?Q?WKD78PMlFONISsH2EIJZvLH91eT9i2R3Us+gaeDbGp6KoUeX3d0CdbpX9gEk?=
 =?us-ascii?Q?0Wl+mA1VPQ/GyVHp3TVZ8PyoT0xEhu2UcmsFe37hg1FEvQcFhp8bvkcGdV8y?=
 =?us-ascii?Q?71xvQWIL/tqjFjzt1GKp6xa+nmP0CIQxYPVP9AolgnnpMLU8vUyqDmV9xvxr?=
 =?us-ascii?Q?EMgFdA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eefe56-97c2-43c9-161f-08d9df05b16e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 06:49:40.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akWTvDXC/Ra67at0ulIAAptYtMCUirlsm1lJVvn96qLecvJDrCehPTZdvqnpbaiwe/ad0QpBePhw3aH4t1j7yETMoNfXw12KOjrWxFfCSPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10236 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240044
X-Proofpoint-GUID: MOtAv-DhGyeRnqzTKEWhohH_ttzFb0Ta
X-Proofpoint-ORIG-GUID: MOtAv-DhGyeRnqzTKEWhohH_ttzFb0Ta
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 11:47:35PM +0530, Vihas Mak wrote:
> rtw_init_netdev_name() calls dev_alloc_name() which allocates the name
> for the device as per the given name format.
> The name format is specified by the module parameter "ifname".
> It returns a negative err code if the format is invalid. Handle this
> error appropriately.
> Cancel the timers ininitliazed by rtw_init_drv_sw() before calling
> rtw_free_drv_sw() and then proceed to free the adapter.
> 
> Also, if register_netdev() fails then goto free_drv_sw instead of
> goto handle_dualmac.
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>
> ---
> v1->v2:
>     free the adapter and netdev instead of warning the user about 
>     allocation failure.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Of course, all this code is staging code and terrible.  This function
is needlessly difficult to read/review.

TODO: re-write probe error handling

Step 1: Keep the success path and error path separate.

-	status = _SUCCESS;
+	return padapter;

Step 2: Eliminate do-nothing-gotos.  s/goto exit/return NULL/

Step 3: Delete the vfree(pnpi->priv); from rtw_free_netdev() and call
        vfree(pnpi->priv); from probe and rtw_usb_if1_deinit() instead.
        Avoid a layering violation.

Step 4: Every allocation function needs a matching free function.  Move
        the rtw_cancel_all_timer() into the rtw_free_drv_sw() function.
        Open coding it is a layering violation.

Step 5: Get rid of the rtw_handle_dualmac() function.  It has a bad
        name and a global variable.  What is the point of this function?

But that stuff is for later patches.

regards,
dan carpenter

