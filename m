Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F952576C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358979AbiELVxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358991AbiELVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:52:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3653C53B67;
        Thu, 12 May 2022 14:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9TOTceQFsfD7i7QFP/7Sd/VAoqXqAyo8IKXlg3JO+wDxKGK0qxYECflf8GrHpKoq5UTx2r3B3eaj8TCzWRch6Fpj4vuV5og4ajFwVJMl1FyaLj6gwwgpvT3jY/PBMQCLCVOdpDyezWMpnbcWjeeT+V+5fGvMS0JSEi+pKcr285FqA6hzs5635aMEmwZnmrxCtbr5abZbdY4Ruqz6W9NcLg8SQLd7ox/82Lspprpng/AeKe0+x9aLOwYG/tA49zPzM7tFPKvw8RxdtOMOOjznOGxskoxo0727W+ACfBSYzjDY5eoY+ZjbQyczGNum5D/agIzJjqG9THsYhNSojuhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P5jEP/XYNmlTVjAl5OmNO07tYv0CeI+/2SOGKM6xSI=;
 b=UT5CH7MRIDXt9MoxbsJlu8cPwSqFmNbkYxRyTeLtIZrGFRNnlxO43VkNmb4sAvesMbj4Kglaucd2217Fz1IqjgGM8D9plcTcsSaVsyC4ZljQ/NJxLXim9ZzNCmtr9u8/+tKk+mbFtslt6A3zMk9v1xyVgiYV80EJ3sVlJvEzYjjwHfU0CKUaZ2sTp9H7WqdrJzQ5FX2S+3fo6GuaNYOUC64Bb2FYCHQGaPJsZHQl2wTkpebeQ3m3lWi1ySCiqETJvkpiNI/iOQQhQECGTRh+cDXsQytBFtsIExDJyjPix2KfZc77P+llCewvnxlk5IhEYtR8leL2GU7T76u4R1fgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P5jEP/XYNmlTVjAl5OmNO07tYv0CeI+/2SOGKM6xSI=;
 b=N+cDzDKpLhQMo2dxZG8P20r+vzUz65F+V4ErEBVZkeREvZffuEJMddBBnEeTpndBvUT3PY2g8VEsFcdOrwzsfQJH7vJac0chCQJrRqKUc9q/TxtlehlidNiwQz6bn6dyUoJhJAmJrNGAeiVm9SiFf7+uvQv90Lunm1ItxYDBCZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by DM5PR12MB1914.namprd12.prod.outlook.com (2603:10b6:3:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:52:01 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::f010:1c99:9c9f:7cc6]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::f010:1c99:9c9f:7cc6%9]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 21:52:01 +0000
Date:   Thu, 12 May 2022 16:51:58 -0500
From:   John Allen <john.allen@amd.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     seanjc@google.com, Thomas.Lendacky@amd.com, Ashish.Kalra@amd.com,
        linux-kernel@vger.kernel.org, theflow@google.com,
        rientjes@google.com, pgonda@google.com
Subject: Re: [PATCH] crypto: ccp - Use kzalloc for sev ioctl interfaces to
 prevent kernel memory leak
Message-ID: <Yn2BflKqBSybybC/@dell9853host>
References: <20220512203455.253357-1-john.allen@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512203455.253357-1-john.allen@amd.com>
X-ClientProxiedBy: BL1PR13CA0261.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::26) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbd569da-d6c4-491d-f9dc-08da3461a4ff
X-MS-TrafficTypeDiagnostic: DM5PR12MB1914:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1914518AD6AE9ABE9F1D7F629ACB9@DM5PR12MB1914.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84G/Cp42E+kH4AaoHtS1Gsvwxde/NVpf3c7vZadZun7dNkkmpo//sgywUaunYU44e/JviVkilcZthQ7Dreuaoya4BI3n3KNSa0NVPtNiCuJY/7HoCo69FL8uAlMVmS7CUljW+iXJicHWpoIM2q4QKUEC3ZIgD6Qazcj4FOK0nNvCbivOkKL+soGu+pR4Kx35JeRk4sSDpd8R/rsnh5g6R9xGfTN4EPlnmQ5ebcycylW+opUwNHYmOi/ydLUqUMQFT5BcTr+lmCZVGxgSYeHZ0ANBC3TdHNiv2peOEIcZx8+I4jJvFyoY1MVDb+GUDXfxKXLTz8X4ghAmMsJKOUv86owXFx0qOpqtx677yzipS8/CuLjpVo7dIjr4xnZVlpXh2xTGVN13lcGx60SafK9F3s7axwGF5cYD7bfYzsAScSTZHoHCT5qiRgvEM7ZRD1T73ahGn8SM9Z4eZR9/J76+bnQVlHjkrvkPVcKw/GRSkBs/hbYcOiTB42syEyRvmVuLeixe85m28IqA4QjZTrXSuUO/o2XI5iieaAVEdDgNA/xxhX2nV2sDuVBLsvWUMJ0+fIBMKffH+2yzjHltf0tz/unCNVudiyW492IVci2V37oZhuf8TjCTU/yeqcRVKV8aj28ji1Z2RG23ZMAcjVJ9UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66946007)(2906002)(66476007)(6666004)(66556008)(86362001)(6486002)(508600001)(9686003)(316002)(44832011)(33716001)(4326008)(8676002)(6512007)(6506007)(83380400001)(38100700002)(5660300002)(8936002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkqcjhSgnoWsDd/K0rA2pnaLVzu4xeWw2RHbFfgiEI6f3TqUdJQ9XqduB9bg?=
 =?us-ascii?Q?RWmI86iP+LtpjyXddSNTS3iY4JqrBN3Qe4mSNxKORuYIKfzvGiAsvhljrCgA?=
 =?us-ascii?Q?hoK20mZDiuBV/ew2mH5OokEkHahq22KpMxCFm3RJYk4iEekvkPEyZE1Eqz+F?=
 =?us-ascii?Q?/TK4CAR4lO6mH9r3jfiDWMzfg4xlMvywufSbRZux5L5qZmCaBnbwvR5bL7zP?=
 =?us-ascii?Q?ljAFEnSnWgn0x3UHnODx5nKuZxZK+A+Ds75i9Jl+xVj5fzXQakjuu3jfnBAR?=
 =?us-ascii?Q?LMEG+OM3n0Jc115yotKf4jolXlWWlsf9u/po04VImAQgVb8YwIz40SNHFCp4?=
 =?us-ascii?Q?kZ/5O6DZ/aUJExmEeR5UzL2D5RdkI05xkAx0FSSt/zX+ACvouC0OMHLH65Hk?=
 =?us-ascii?Q?JBqoguTo03Pq2ffD1jAshg/7QeS1RMzdhLk8OtychdfIQqWrGlxzB3aFMDMT?=
 =?us-ascii?Q?Kf/obNDaO5/VM4TW16qHs/N6BCeLk5cv5w66k9wKXN8OShlmKrqb2eMRjZ7a?=
 =?us-ascii?Q?mU+EpPZwdF5o7XV7coCtxlNUGABRwqv7db+7ki2iQRp6uz/5hElaB3lqB0lJ?=
 =?us-ascii?Q?3+AMuu4o7qmU4ffnpsQCmS+XYwNYEZl1ZISHHKW39IKaOI6tXTtZ3K6uV6Jh?=
 =?us-ascii?Q?cFQZ4mZzqz/nmbwF6JQqXwHPwkTeuKtbSB4PRvRqzidPjewQLtTQo4vg9NKs?=
 =?us-ascii?Q?a2DZe63enxsoL4DE3gsBf4u9gWJBx598muGGS5NOnIFaOnpKtfKBqmxcXw11?=
 =?us-ascii?Q?mKt29IV5OM/Dm/I8a2yvQkAr0652oE+UkfJD4+Vw3UWRcw+rNQGErHSNIpoT?=
 =?us-ascii?Q?sjz9O4768OWZ3wrPP+1fslkV+uX21h9Hc64sUSfwwfpeu7dDU8ckrGOVR9Lp?=
 =?us-ascii?Q?yflxq2HG1ZgEHJrJ7k/wQL81Smc5EYCyIsVLdgstoa08kzaUghqUxPvTOIuT?=
 =?us-ascii?Q?mljKs+fN9z/4TcfSg8w6wdQdlkayFZ4WnFAHV8NyJSUanLSNlsTUjYqbzqPA?=
 =?us-ascii?Q?/rD1ixGp2zvq7KCMHG0T8LiQaPaoL6g0IiK0Wa+0JxLlRLDa2DsCpsp3FYLA?=
 =?us-ascii?Q?GSQK2qRPXFBgSWlyWgqgWcJu86gftF1cyMQh4z1vuUcDUEQ+T7w3vGY1CoEC?=
 =?us-ascii?Q?knDHfFklHzKVvIqGc5N/3iBfgXX7INUZCxkK5hNQozjRoMbSmdQc8FncBUxM?=
 =?us-ascii?Q?F4kz/AGlRVRvY7xfwMm8EwI6iKvtzuHI+UVZpGo94JPUF0V3p1iGlEJ1VkSo?=
 =?us-ascii?Q?84b/V+wVkI8lBwqme83ML0epiC/DtLveqse6kAl96KZwNzIzOmCi1Ug+BOVl?=
 =?us-ascii?Q?xuqjC7DzBN7LZM7alZOyGjeno/arIXepjmypeCwEFB6hKwhRMc1dSiRbjFAo?=
 =?us-ascii?Q?pxlE3nX5gPn2FEsl+nYjjPfAgcy5+7D31meL6EPoINvYulu5UpHX/+C8L48w?=
 =?us-ascii?Q?SdGbrro7Z/nbfWQOp++S3sK7xEu0a5MQCkmxlScamScog3B2QP1DEQ1lI+Yd?=
 =?us-ascii?Q?cXpdSlFcmhJF4W84KHEPO5u8dQysLuXpZiY8fbmut+cGk9LKwp5W1LqaZU54?=
 =?us-ascii?Q?QcG7xhU6XpCs2xBsyFW8smZFTmEQprIWJzm123DqcIQVMnuo4ef2aJJh8ARL?=
 =?us-ascii?Q?r5GwPXiNUzoE72qGbyGxoEBKp8WPFYtxx36BhuZiwJm0GSDKTsXiXqEUyqrV?=
 =?us-ascii?Q?XLeYXTLq8JimQNjE3svAXRymH0JIqSOtWdk4d4TDoWj6GTu7KxOOgg0UI+kl?=
 =?us-ascii?Q?QiQZV2KoUw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd569da-d6c4-491d-f9dc-08da3461a4ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:52:01.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CFtbxWdaKHWhz2q06w2sIQEoUjXYPUDpDrYbrhu5gI9v8cfm044ff1F2wMTZY5TFK4zTOdOrkKOrX2M/0hNdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:34:55PM +0000, John Allen wrote:
> For some sev ioctl interfaces, input may be passed that is less than or
> equal to SEV_FW_BLOB_MAX_SIZE, but larger than the data that PSP
> firmware returns. In this case, kmalloc will allocate memory that is the
> size of the input rather than the size of the data. Since PSP firmware
> doesn't fully overwrite the buffer, the sev ioctl interfaces with the
> issue may return uninitialized slab memory.
> 
> Currently, all of the ioctl interfaces in the ccp driver are safe, but
> to prevent future problems, change all ioctl interfaces that allocate
> memory with kmalloc to use kzalloc.

I should have CC'd stable@vger.kernel.org and added a Fixes tag for
this. I'll send a v2 with these, but I'll give it a couple days for
comments before I do.

Thanks,
John

> 
> Reported-by: Andy Nguyen <theflow@google.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> Suggested-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 6ab93dfd478a..e2298843ea8a 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -604,7 +604,7 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
>  	if (input.length > SEV_FW_BLOB_MAX_SIZE)
>  		return -EFAULT;
>  
> -	blob = kmalloc(input.length, GFP_KERNEL);
> +	blob = kzalloc(input.length, GFP_KERNEL);
>  	if (!blob)
>  		return -ENOMEM;
>  
> @@ -828,7 +828,7 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
>  	input_address = (void __user *)input.address;
>  
>  	if (input.address && input.length) {
> -		id_blob = kmalloc(input.length, GFP_KERNEL);
> +		id_blob = kzalloc(input.length, GFP_KERNEL);
>  		if (!id_blob)
>  			return -ENOMEM;
>  
> @@ -947,14 +947,14 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
>  	if (input.cert_chain_len > SEV_FW_BLOB_MAX_SIZE)
>  		return -EFAULT;
>  
> -	pdh_blob = kmalloc(input.pdh_cert_len, GFP_KERNEL);
> +	pdh_blob = kzalloc(input.pdh_cert_len, GFP_KERNEL);
>  	if (!pdh_blob)
>  		return -ENOMEM;
>  
>  	data.pdh_cert_address = __psp_pa(pdh_blob);
>  	data.pdh_cert_len = input.pdh_cert_len;
>  
> -	cert_blob = kmalloc(input.cert_chain_len, GFP_KERNEL);
> +	cert_blob = kzalloc(input.cert_chain_len, GFP_KERNEL);
>  	if (!cert_blob) {
>  		ret = -ENOMEM;
>  		goto e_free_pdh;
> -- 
> 2.34.1
> 
