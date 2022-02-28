Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A554C62FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiB1Gd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiB1Gdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:33:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347EE1B796
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:33:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RNbveW030117;
        Mon, 28 Feb 2022 06:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NZ4AgWYUNrOSlb9LUs4m1CPQTgqDeuu+hYevmPwb2M0=;
 b=J8QGbh+8yK/scoSrd7FavHxMyPDyppjZOBcX6hLonDenm5GSXuJrKv4KoVv0cyZU0fEi
 IRlrrgj67mI3cBn+Wgjpkyk4zWgmfvWauosf0nx+QGxiteGAjnnEQRB4g9LmX3rmOR7k
 pmXH9xcB/nXBR8zwepkb/CpnimhfZ5N9pH/RhDoMDlOManTFYXvRUP2+RIePnc5ZJZlp
 GRxSwkn8N903ymcv42qPylUqXtFpiHN1dgiY7vTHKmkF09IOSplpEytW9Bv9WvO316ZZ
 dI/apfVuIEK7S/sQiUDah7ddL2lsu6ap4YcVQHM9lgelGZ3894cY1+gq3c1t6bEL5fnO ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efamcb89m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 06:33:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S6VJ6A081675;
        Mon, 28 Feb 2022 06:33:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 3efdnjdf5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 06:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Micu29m07EQqU2quDkIQjcDACAdJk3aHSTXL1loXoE2ZLrczpRTakY6i11KrSmvjimfpegzZDQycFfQQQGkXz96syv0UpJo/Gb2POTNq0RUpltD7Yx6XDbQqgoYWXILLNPQqhY8FKaSIFX3CUbxEGOhdRXg1QqydpZdfZ8Ie8/2iS9g+0Og7Ku3yKZyWBus8eWkWkqxBQs6vfaMRWsrAooR576o/UQzrquEGfLxiFUWrPn4w9mhH3SyJD0/PWAONusG8Mq+8IlGAL+bfn8+afBdv/bG/o6UkIqWibLXnzYfpHCFk/Ki1noTvb8fN2EAaPv3Lr/9T+twKHf5NgGbgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ4AgWYUNrOSlb9LUs4m1CPQTgqDeuu+hYevmPwb2M0=;
 b=At9lTs+OC2lcfGQ3NeXfQqXmpTaz6PlLklkMrbi1eG/aBgnmEsA/C+thHXSzTqfXzXUb1XwvuZUOl0kI6O/AFCxCrFLS4hE/usB5ryWONBWuIUI/lX7MHjCMNwlCo7n29LFfGxHrlga68e9zHii9zihRaltaVBOl1tXC+PWIutTe9rOU+VSMcdbGnqr+cAg7WuhlnLn9jAedc4TG9uZ6fuf+J+LECzT3BCirRyWqEgUOhobx0M0x6pgtODLrxoDIPR58pANh/XHfiDKKbuoPDzR8eAD7H1RjDQnZvNZQi+a4lfQfayO45WEyptLqAle+RBV3YM2tYLkwoyhCCzpEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ4AgWYUNrOSlb9LUs4m1CPQTgqDeuu+hYevmPwb2M0=;
 b=cYnrvDMbGyN2fBsCqP7wYKzCk9AVwNKfnnHKHot6ddF13NKcom+zZlgxKdpZ4C2gQeMEWh33XrhPSaljHzfBxOblYiD/EPooE4Vp252uMTrWDy0RtoZu80DXSihqUFKxxGSxNdEQcRr7/Ny5RC0MOtzPbnqaBjIbskRruFB0MNw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5883.namprd10.prod.outlook.com
 (2603:10b6:303:18f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 06:32:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 06:32:56 +0000
Date:   Mon, 28 Feb 2022 09:32:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: remove rf69_get_flag function resolving
 enum conflict
Message-ID: <20220228063238.GA2794@kadam>
References: <Yhla4a1Clpguoo2h@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhla4a1Clpguoo2h@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec232ca5-b954-4485-6ac1-08d9fa8427a7
X-MS-TrafficTypeDiagnostic: MW4PR10MB5883:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5883EDF8C1FE620F94D98BB58E019@MW4PR10MB5883.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7y+KS5BZNs4DfglsleUoGOo/h938RIchbej5nLa6Zm88ifm/5Fx2zgvIHP8H5YDTPPbU8AAKfqZjZDth3sPDcNz0aW7rGi3BCKHsqlHo8SJOE6HROjEBoTrksstVGI6eCJMpNhMZqG/jh5HzDIA/hyrl/feMEzBSZ9IoN8lMCpGt6WxSeiCUOTAhOTAAqny3s4sFYARxyEAn4TERrMU/zJSGOGgTcMwTLblHYQvv0whqCrfG47ei8Sgir+XozxKETZHtsJr+Pv6DcBfagfGzHX5Cy3mBtsDTev2N4NaPEJm4GbJJGyEC8EaFzff3+qLjbok8BfAaPUFi2K6cNGP0ReBYq7wS5rJ0qjl76WcV/4g+E5LgLrMZot78WEnwAPbk7A4fbQ1DyPnswInHwUJKEnDTvkl7jiHXawd6Geyg1wFl2d9L0ZvfLgEF/rv2rVsLbHg1xA7DBj9/2eC9xaETb15WHX+XkzaIhfjQ4ZkvS2yeO0Um3QXC0Vvgo9xoT1TxdYaFoBVZI6rJ4K/fVgqlX0u8iQ361zNPtFkIxKyilkMkViS8hKbGMheGQGtR3shJTKOHYGXQdYN1I3od0NcembG4kx80gUxCNFpl73hUue+VBs7X4V0QNjLebMg0c5fmeh1NA66KafHJaiy18nC1/j+ndUVufMMeHFhozfv1jilqwbQ8LL3BWjLhr+VEbS6yU1nJqWgnmOGQfAsCHPL7iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(33716001)(508600001)(6486002)(52116002)(2906002)(38100700002)(38350700002)(5660300002)(44832011)(8936002)(6506007)(4326008)(66946007)(83380400001)(6512007)(9686003)(6666004)(66476007)(66556008)(8676002)(86362001)(6916009)(316002)(1076003)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T6v+8BGUEGoSqT6RaoxQdPGxt4FJDtzG2EU4iF8oxv6TWNOf5mWYlbzRMX0V?=
 =?us-ascii?Q?QdRVZnyKCbh6vaR9GZLcgTOnW0wx+0JeoTUVpFSgaNSjLPln5cN/57HGXMKW?=
 =?us-ascii?Q?L5y8IDiN8DPX5Q06bQaKTYxBMfNJwK/Ox816goYlqw9wC0QHuxytcMCFxCoV?=
 =?us-ascii?Q?qhysqjF36Qc+VPQobNUzAuX/BOhOlXktWPA8+nY1/5rzKRhktYHjiQ5ZC098?=
 =?us-ascii?Q?N7XPAdSCaoqcNDpqvi2OPohXjTddH4pCFxmqwFzx+Ga53MqYHWQ3itNiaaHN?=
 =?us-ascii?Q?11qzZUE/G1Qb39ItVlatwds1++1fcS85FW3kNXYjMLfmE/qgJOG4bGHf2Y7s?=
 =?us-ascii?Q?tpWen9cZT+gESR9ZDtT2P1WunNzELHORdPkP73mc4LoiIcwBzGdqxOp6VtwV?=
 =?us-ascii?Q?hptdddlrJr9doRRL8ApihR4MGjAg1RevQxAkypyhXPlF5hxCCFLrn6+tTN93?=
 =?us-ascii?Q?ohRdEC89Q1c1tknvS7bmFW01KaPhHIYWkVvEBgM3xj1FdsaleI0GWd0zQUnS?=
 =?us-ascii?Q?4D6K+kH3J7AVz/9J8Ct2YslN101pJL/Mpudgf1pWEg7xxtOaWEQvqSGDrKT3?=
 =?us-ascii?Q?hlzINzXBjMzuwX+Q+RnSOBAn6UGCHMVYMhliTzuzCQWV4rKUSIHoMaCqqlcc?=
 =?us-ascii?Q?BxxNjPFnWIdDhHXKGMVUb7uT38LteFrNfjMGXVHouow2ZKAl/Cez/rfb8wXd?=
 =?us-ascii?Q?NukKsGIbVAmA26A3248qPZtGIuiXWA9xY7fKiTh3ci8IFETxwxzmqKMc2wJV?=
 =?us-ascii?Q?b6WsFDTgb7T9bdT26mJ31Cqg4BQcJuCj+rvW/LC06yxF8yFpkDZh/ccKRdj3?=
 =?us-ascii?Q?FW3gYgvcdQcO+JL0+RVpz/X91p6+TfGfRKjvye82rfeia0OTOp8HQm6rFjl+?=
 =?us-ascii?Q?fvHcLhrUlnxxh7uLHLtUb/O/6M5BeKNaHXQhTrM6xuTfPWnkkU9W62u7IoZC?=
 =?us-ascii?Q?qkBeptG5skfqCV4InJlfZdwr4w2caTr+KQrAn+DY8jVu7n0pwdOjZvUpF5wR?=
 =?us-ascii?Q?pVXumL1Tw9xCBnz7YWT1EHqkdSKDi7CwCQP28EHpSMla5J2e+3pFYet9tlxR?=
 =?us-ascii?Q?Gfbu5MlzjxWCe/ILcBbRfPdAKKEO+n+61vKDmU6K3Y9g7QTLdeNPj/ax26Z5?=
 =?us-ascii?Q?EGDGqTGaPddxFBABawZwbLPjTIWl89wKfpy3YgZAHlznfpkVCqQcm7A1SHKG?=
 =?us-ascii?Q?4Gm9AzrVk+OMPT0Eb+TZVr02kdq/Oy3p5FP9KE7SHXCAwv1DBSFl35X6yByt?=
 =?us-ascii?Q?qx9TcrIYxOqQnlOCVJBMU72iJ7foPKxF1y6pjcMSRmwxylXvpL6d9Dp1I+W2?=
 =?us-ascii?Q?pclwgUst5TM6Z9m1EiCEJTzKLGv4X3eNKvJjLrE9vxpEqKYITEg0ghF12QAj?=
 =?us-ascii?Q?46Qdo56MzWa8XPDu32KONtdE5T1rnPPUXmKY8Qhp1rNXA/zePlG0cRqlGIjg?=
 =?us-ascii?Q?zy0ugPPZw3b2NEeIK12rVJc7hedEYxnJ7fYek42ehHF319F42htC6VEWHEns?=
 =?us-ascii?Q?tbb/lt/3UQtuH+90wJZeIQiI7i9n0k8ewT434XcLpv2zScEPRvNx+8c3g4Vs?=
 =?us-ascii?Q?8+OZ/bqkXHapEGZyKrdiEOJZDzwSwaE88AHesDPRG2UYryVKA22wl5v66NiZ?=
 =?us-ascii?Q?0gB2ySMCPTwMGOCr9Pz0WgrGzUpGaAdqDHvzwI47291cg9x3aZriDlZ2xguK?=
 =?us-ascii?Q?AcwJRg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec232ca5-b954-4485-6ac1-08d9fa8427a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 06:32:56.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf7EL1JtbGELPNyhkBc9wAhLHumQY9woXIADURLLzhkO5RP8vUoq9TDBy+BWQsnNB801hkBdoe6zJyguZTVyNqcNtwrcWolh5gHZ0v849R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280038
X-Proofpoint-ORIG-GUID: Stgzowo7Aqf__FLp11yFTY6KD8cP5BiE
X-Proofpoint-GUID: Stgzowo7Aqf__FLp11yFTY6KD8cP5BiE
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

On Sat, Feb 26, 2022 at 11:40:33AM +1300, Paulo Miguel Almeida wrote:
> The reason why rf69_get_flag() existed was to provide a high-level way
> to obtain values out of 1 (of 2) flags registers using bit masking. The
> idea was to map the possible flag values found in the data sheet like
> shown in page 70 of the RFM69HCW datasheet.
> 
> However, due to the fact that enums values in C must be unique, there
> was a naming conflict on 'fifo_not_empty' which is used by the
> tx_start_condition enum. So the author decided to create a 'fifo_empty'
> one which would negate the value that comes from the flag register as
> the solution to that conflict (which is very confusing).
> 
> this patch removes rf69_get_flag function which subsequently solves the
> enum redeclaration problem so kernel developers can follow the data
> sheet more easily.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.c  |  8 +++---
>  drivers/staging/pi433/rf69.c      | 44 -------------------------------
>  drivers/staging/pi433/rf69.h      |  1 -
>  drivers/staging/pi433/rf69_enum.h | 20 --------------
>  4 files changed, 4 insertions(+), 69 deletions(-)

You don't really need to write a long commit message for a commit which
deletes 69 - 4 = 65 lines.  Just say "Remove pointless rf69_get_flag()
function and call rf69_read_reg() directly.  This cleanup removes 65
lines of code and it more obvious to read."

> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 069255f023c8..3f3e863e6cc8 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -434,7 +434,7 @@ static int pi433_receive(void *data)
>  		return retval;
>  
>  	/* now check RSSI, if low wait for getting high (RSSI interrupt) */
> -	while (!rf69_get_flag(dev->spi, rssi_exceeded_threshold)) {
> +	while (!(rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_RSSI)) {
>  		/* allow tx to interrupt us while waiting for high RSSI */
>  		dev->interrupt_rx_allowed = true;
>  		wake_up_interruptible(&dev->tx_wait_queue);
> @@ -442,8 +442,8 @@ static int pi433_receive(void *data)
>  		/* wait for RSSI level to become high */
>  		dev_dbg(dev->dev, "rx: going to wait for high RSSI level\n");
>  		retval = wait_event_interruptible(dev->rx_wait_queue,
> -						  rf69_get_flag(dev->spi,
> -								rssi_exceeded_threshold));
> +						  rf69_read_reg(spi, REG_IRQFLAGS1)
> +						  & MASK_IRQFLAGS1_RSSI);

The & character should go on the first line.

						  rf69_read_reg(spi, REG_IRQFLAGS1) &
						  MASK_IRQFLAGS1_RSSI);

But that can be done in a follow on patch if you want.  Or you can
leave it as-is.

regards,
dan carpenter

