Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FEF48507A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiAEJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:58:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10994 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233977AbiAEJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:57:55 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2056uo4i008994;
        Wed, 5 Jan 2022 09:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=z0x3ThgQ/k7QUdm0tnadWHfW0Nvp2I7x5jntVlP8xYY=;
 b=U0dY25PNgjoDqVp1WdZcV0zkT9O9BZ5CnKrliLRXUxuhXAlQx1AKk2ASbOpb6wXQFV9s
 fLBBcTfp55tMlelKK7XKCEOndoJ5kI5X++YtqzKB57epoE1AR8Lules5tbGfQrzyVTvk
 BuFPSPjGzy4hyllQHeUde+3uWWhNCQznarVep0Zi5CIObYAEi3NZ1Tk3jnKfR2s8fs3h
 fvoa3DZzaekPSOEh4y4gISDqG2SEEyVfmuAGGLGXC/MRLUkHRYo26b240SjWBKul4t9D
 QDv8ePDYMG5Ixsel6e3bj83MvpoMI3+JOsGTm6109TPDLbX9EPO/EPseNONShRjM/73V Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc9d93kwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 09:57:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2059tduJ145692;
        Wed, 5 Jan 2022 09:57:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 3daes4y6jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 09:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGWiodAO7EF90StBy0+2S1Y1Wsrxq9f1ypwLZipsMukFtOGhE4zhWv4lY7NJC5B+u6/TwOLU2tY3khFupYFktWTRF0IeFjZ9UPBg2a75xy6xlfC0MbMNu2DYCc46ScGJcio1t0nIyRFdKOOUGnrtwSA5zs1tP16KPnWvj4mLUUK+G6U9o+RMTSKwmWP4K7ndrzRdquNtpWQ+VbNp7qYC7BN5naFW73Qwj7PiENU2961udea3TfgZpoY8D1rCSRVrvaqAcL0Bp5j4b3BrM89RHZuBRGBSq55DePu10kAmMNr4i1fk6+hT2IAG2HffWx7KzUWM4qCTc5H2MLCl/lTGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0x3ThgQ/k7QUdm0tnadWHfW0Nvp2I7x5jntVlP8xYY=;
 b=W3X17ut0yl8y3AawAEIWeCrYCVZ3KmcAwW/KnAAcCzrv/at0P+qeU/1Ptyp8vEB4U3qJTjPXMVHSgHGsQWydO9hUhi18VYHm1U5ZpfC8abHiz1VGjWgPiEPr5G+n88yAuiweB8oTkOpTuQrwkCUPdR+THcrChVatnAPX2fQcpyqzxP3GaztZgMFs+VY0t3wTtQ8vGgB6DC3vS2xI9kprUipSYlRKzLF8pgqogt8H8/JvOm2/xWnE64jttQa59ch3O9yEkanhFXVWvpHzTG/+6kv7tFXrlR1glWVrxLeX6sjh6iAZqqAhmCav5NttkBKWcw1w02dVur3V2fv8/zflKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0x3ThgQ/k7QUdm0tnadWHfW0Nvp2I7x5jntVlP8xYY=;
 b=oEkWddXvttBo0JfqiaUdxvlwls8yvxg13bjxIOYIHYn9lHAbvT9b4gHKniJtC8lBj5tDhNB7gKK5D+eUA8xM5Wvi8guw34S1e5i0n+gvVa0iGAlRU9wZfbTGvyAp11u223S24SMVc71ikMYqOU8Ra63CTkIhYoTKzRnrq/wKJ+s=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1728.namprd10.prod.outlook.com
 (2603:10b6:301:9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 09:57:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 09:57:44 +0000
Date:   Wed, 5 Jan 2022 12:57:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ismayil Mirzali <ismayilmirzeli@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        simon.fodin@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: Fix styling issues
Message-ID: <20220105095725.GB7674@kadam>
References: <20211218203647.24486-1-ismayilmirzeli@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218203647.24486-1-ismayilmirzeli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e3a02b-31d1-43f3-807b-08d9d031d1b1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1728:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1728D0EC509824F3850E6A9E8E4B9@MWHPR10MB1728.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnofBK0bcUnpmkvwnSkRVJSXCL7+xZty/cLoRz1OSMe1FiF8ydt0eI+kyGHB73NN1llR2JJiONEkcqLpmCxrCJ/XQ6uxNDclYPmHVh2g/xlYXHvBanaOg+m3sokKuQ1fblyCMYNQ4KiPF0lf7KVMMqJ22bGjUev0gAIU1n5103+BSVB1HINMOTcfKZX59XOfAtsItBG5fiaNgGPA6Xh9MgRyAgkeQwKCtD9Ii62HAt+Dem5lgufETxyRwkrMpldDFLcE9npNPkunVRUKj5kY+hmFR5dzKYRDvn2idY7+50cMmNqTQmyZ4VqTdHjnFp9mPJv/7IWlHuRPjExnjLf4eCpiyeSi06E2isExo5TupWzkRuHFDaDH4Rb6HzIEtpXziMVoYypsijxuWREjkD5ZtryYr8IvAePyFBJuIPDkUUZy8mNUIRSNKtKfPqenNPFtofwZKm1hWYxeYUQLZ2tLbEB6gT+YIfhF7QkG+tZawfvc4NE7kcFprRCcHb2v1lH3WWb5cU4Z4ESV+LfH5wYxEezFHpCPeg+0fgRGabqqmZ5qPy65WSFkhziOku3UfrQwheuwJenHw2d2SORxEI8R49CwFL0z/d4X5Cd8ufruo0RtJHTMW6CqQRMxzrgp3/Xh0X5BmCMPRrBEz/i0MNGUBpbZ6fwya4ku96e/RF3XbgQMMW1QTEsKMJcbUMmdGoqSHPnfsFvOTM2A0IntWrED8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66476007)(66556008)(83380400001)(2906002)(1076003)(8676002)(26005)(6512007)(5660300002)(66946007)(8936002)(38100700002)(33716001)(6666004)(33656002)(38350700002)(4326008)(44832011)(186003)(9686003)(52116002)(86362001)(6916009)(6486002)(6506007)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knPEvNM9LOph1cb4lL+ErqUvjAVWgPBGt2K4kANwRGF6GCAxOcxJY5uftDdL?=
 =?us-ascii?Q?38/qYB+K78rDywfN0qkK40MeMMRzgtgYKDt1UIEYBmwcX+QaN1rxz5c7ECCu?=
 =?us-ascii?Q?5bEmqaS74JvIFvoMC1gLXIkbYBlpCjz3EYoBds6sm8fV1MulN8gpTBTjzs6f?=
 =?us-ascii?Q?QmBTmS3k7Mh52Nwtaqkv4rHH0D0Mz3dzL2MgP/YWEClyYdqpwQxBeRo+8HPc?=
 =?us-ascii?Q?jpG0X8gXcMDocezUCQkzVdORaYSh5bpH/NUdkomNEDnvLuHc73l1UxUZx1DB?=
 =?us-ascii?Q?ZcWCzlFcxoOb1NcQ4Iloay7UAKaNQgInBa4FxSRFzsazW4mKG785YOkZml+w?=
 =?us-ascii?Q?A0uetTMetgIBtKlrImC7B4VsQzmCDb7b26dIVlUsPa6bKSOoPIJpK+RE0+pv?=
 =?us-ascii?Q?zVi9fXVUftUpdtii+WhbqkNl+cIT9TeVNFH6sFQFaJoufIbMSdyHiPwNm9Ce?=
 =?us-ascii?Q?cbA6HcrZDVqNctWA9nRg+6qSmqn0Q051v+HWLC2cSuzfU3VC2NA7uVDxrl33?=
 =?us-ascii?Q?U285afByY6vVIgb0lo0dIpWtPKD/IYalPKoYOsJxA3fQWXkyr9E7dYVi/XG+?=
 =?us-ascii?Q?EEFixO9CmKufXPJ3cUH/ans0zq3m56pJeJZG1G/NNYEhPKOQyMxoCu2Gg6XK?=
 =?us-ascii?Q?l0dzJ4rXjF7XHJm0F9U6/uVN/mtMDJ2lVzoxeq+jtzSSS1Wd9ADHnuyKPZY7?=
 =?us-ascii?Q?r2TEOvbwHLFn4rK55CfFpFlSYGee+NPQCjaXODd3xxO1xEw0vmhkvysEwomZ?=
 =?us-ascii?Q?QpW5HHWcjNR1y0L9zMtlI4RvZIZo0rH74TNqrrS4CspzcnYxKY81+f1HxDUV?=
 =?us-ascii?Q?ekUAok4zk5UNqh8DGU1PIfpxJnyhpmmDxtweJUgTCFxiecV/ji+69NEOsdTP?=
 =?us-ascii?Q?u96VDN1XUVqBmVdOzBuFgLvD/U6Vx1YOwrXx3IxM9y50WjXQ1YlJttMd+YB0?=
 =?us-ascii?Q?DdlEDADnlNUmKtHcNHtb7Wmguai4fFWyXT7/R7y/+6ifzHY/sUQ15DUFgpd8?=
 =?us-ascii?Q?zjeXK0jB2Rjco+Z9pM0nSO9b67b71nkqbdtIXTnbvMUTC5IrmRJLEL2kA79G?=
 =?us-ascii?Q?8RUkBP+D4atlCO47jkXO8CWw4RhdYY8GRjuBiWG9dH6vJ+P9RqOfdFRsYY7r?=
 =?us-ascii?Q?NKqJXuzemS9sjZk/fAJa0xkzS0H7mYg/75WTdZjJCp3slGmFYwDJhiJ8Dk6x?=
 =?us-ascii?Q?9vdL7Hz6BxLDI33rPqsZS4wG9dxWTF5B11oDtidjiJGn2yM8ODte50dvxGca?=
 =?us-ascii?Q?vCdPs2nj9B+L33uWNu6MflwPwpYcdPGbWglSUO8dXqb4IztWh5KkjnYYbdwh?=
 =?us-ascii?Q?ULfbqh0PCWYESuqaAGmPX03zlp0Pe13N1xVNR6vc0sfdoXRgDOasAXFnLsvM?=
 =?us-ascii?Q?0cNCJouMibRirDXiWXgtet3FTbPXIx5z45Usnkv3UTs8NRFP47IYZoubGCwc?=
 =?us-ascii?Q?MLdbOfu8F/GV7/Fa0JH5ThDO767EHuEEsGqM1FnkYZuElcfKJ7Ajjmy+p0N3?=
 =?us-ascii?Q?jMD/e2mQ1MMwS5bJ/uY++xayggTZGkqStX6EHoYiRPpIIyf3dssK0Drio0kN?=
 =?us-ascii?Q?XTXlrsDtSa2u2Qg2u+XVVzAejmdbXIpek/sM+LjLOO/xBe4wJvPI6EWX1BEn?=
 =?us-ascii?Q?gHq1KkK452PrKsOlo6O+hlMV/em9pU1O+s3M8iMUoJgZajqZQUIAiIRlKn/C?=
 =?us-ascii?Q?DgdXT+u+esQnVkUTTbgXmtUWgJ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e3a02b-31d1-43f3-807b-08d9d031d1b1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 09:57:44.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oBuOBnnWAyNnVoU7VYURlzY64W43nzZ7w3MrYDSsdFL40C6XQflmPD7UX/Eif6aECDLx9onu10tk5J7Zk63mWssLy3vZ0k3uD0Lxhza7nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1728
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050066
X-Proofpoint-ORIG-GUID: j6mHc8TYfGHDxoWAmqFP2fqfmaeDNIIF
X-Proofpoint-GUID: j6mHc8TYfGHDxoWAmqFP2fqfmaeDNIIF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 10:36:47PM +0200, Ismayil Mirzali wrote:
> Removed extra whitespaces and brackets for oneline if statements

s/oneline/one line/.

Do this in two separate patches.

> 
> Signed-off-by: Ismayil Mirzali <ismayilmirzeli@gmail.com>
> ---
>  .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> index 7fe3df863fe1..7807b2a6cdc5 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> @@ -32,7 +32,7 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
>  	pHalData->SdioTxOQTFreeSpace -= agg_num;
>  
>  	/* if (n > 1) */
> -	/* 	++priv->pshare->nr_out_of_txoqt_space; */
> +	/*	++priv->pshare->nr_out_of_txoqt_space; */

Just delete dead code.

>  
>  	return true;
>  }
> @@ -147,13 +147,12 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
>  		return _SUCCESS;
>  
>  	ret = rtw_register_tx_alive(padapter);
> -	if (ret != _SUCCESS) {
> +	if (ret != _SUCCESS)
>  		return _SUCCESS;
> -	}
>  
>  	do {
>  		queue_empty = rtl8723_dequeue_writeport(padapter);
> -/* 	dump secondary adapter xmitbuf */
> +		/*	dump secondary adapter xmitbuf */
>  	} while (!queue_empty);
>  
>  	rtw_unregister_tx_alive(padapter);
> @@ -311,7 +310,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>  					pxmitframe->pg_num = (txlen + 127) / 128;
>  					pxmitbuf->pg_num += (txlen + 127) / 128;
>  				    /* if (k != 1) */
> -					/* 	((struct xmit_frame*)pxmitbuf->priv_data)->pg_num += pxmitframe->pg_num; */
> +					/*	((struct xmit_frame*)pxmitbuf->priv_data)->pg_num += pxmitframe->pg_num; */

Delete.

>  					pxmitbuf->ptail += _RND(txlen, 8); /*  round to 8 bytes alignment */
>  					pxmitbuf->len = _RND(pxmitbuf->len, 8) + txlen;
>  				}
> @@ -385,9 +384,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
>  	spin_lock_bh(&pxmitpriv->lock);
>  	ret = rtw_txframes_pending(padapter);
>  	spin_unlock_bh(&pxmitpriv->lock);
> -	if (ret == 0) {
> +	if (ret == 0)
>  		return _SUCCESS;
> -	}
>  
>  	/*  dequeue frame and write to hardware */
>  
> @@ -405,9 +403,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
>  	spin_lock_bh(&pxmitpriv->lock);
>  	ret = rtw_txframes_pending(padapter);
>  	spin_unlock_bh(&pxmitpriv->lock);
> -	if (ret == 1) {
> +	if (ret == 1)
>  		goto next;
> -	}
>  
>  	return _SUCCESS;
>  }
> @@ -428,10 +425,9 @@ int rtl8723bs_xmit_thread(void *context)
>  
>  	do {
>  		ret = rtl8723bs_xmit_handler(padapter);
> -		if (signal_pending(current)) {
> +		if (signal_pending(current))
>  			flush_signals(current);
> -		}
> -	} while (_SUCCESS == ret);
> +	} while (ret == _SUCCESS);

This change was not described in the commit message.

regards,
dan carpenter

