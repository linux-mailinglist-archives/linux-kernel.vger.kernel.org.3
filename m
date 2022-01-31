Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDC44A3E45
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiAaHiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:38:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27214 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235089AbiAaHiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:38:19 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20V6wni3030877;
        Mon, 31 Jan 2022 07:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=iIOKto7u02K2wzlgJ+rVNdlvLH7F7SJHQSFJiRX9jew=;
 b=gqGn2qE+wyxOKOv30lUG9SQ7gKOn7tvF9CP5ZkNqUUhb3DlBr0ffKPLG9uVG95a97cb8
 XhwGCsxRkeAA/JV0hjvn3wY/5TpGjDpFjocVZvH8gAXwC7OH4m/jR1jUHgT6FTIfTsk1
 EXWy6m8E5IDdARxly7wAHf8ZjGB9/PgHt5k+WNYfhV1lO1nI5H6isad+nSxVg33moBHi
 N2UiMg+Bo5OWC7skL2wZ8wrDRhIzO+sjz2MdkuCQE0Ah2LQAdzH6X43xumFLAWvV4aOE
 N0HXHetWcqP3omL2IoWYYGlaDhKagRGfYng7MB6osAey9LIZiC7rJgyHQyjrAg9Nlq1k /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvv6237eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 07:36:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20V7VHUF154149;
        Mon, 31 Jan 2022 07:36:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3dvtpwaba4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 07:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBWLPaO3Xwr5LyIR1GLu1yKcO0Y5ZHoSxq7vVvgglSd9IEEEYMesWuOftShS/f52wx30rUg9JhjrIbHoGehKzJY2XNZxMdWvRq/5GV0vBhf5VAR1RT+8l2/RSTp6PNA0ge6awjIYt0MFw22ZKTNWyYN82QSkVer6JsKbhkr7B8jNLqsaYUuKpHhGKf97yxL8NkdItzLWnHoanDQqgWuhj/QUQFtGipTENWE44vn8M9hqwg+CJ7wEvExzaUOG3TC0YLfW/uViBbOhtjfTrQ0OWDda1wG0ysLUv03znlUMIxUAfo+raKGtfOiacwCtRAB3pCGPGaIUod8B9z7DW56upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIOKto7u02K2wzlgJ+rVNdlvLH7F7SJHQSFJiRX9jew=;
 b=gH1o0JZYilUlWs6Th1VatCAgbus5Nhmd53Y8IX9PgS8llnYaQDY0DMRwU9BcleLmM+7MYtJETq7gkKL5VZ+CEslTWvECG7IAT+0QGxZrjzui5q33G7Aibc2zDegTQsujwQEmnNUfT8eUonfmtcXmK55JSJngPzdU5qFNfyDOkUI3jsJp0CqEJ7n2VviAK3kSEk+wokeKQz69YJ1ZTVBt/HIQgbmhGy9KNdYS5hws7udl04v/Xv4cqtk6yuvRLqX79QxAl8Iktpkv5Fg4slItiCahbOjgG2urp4eRua0xFvM3zDN0j6nlphLp26ae5nFdrZjVP94CWlpaUWUXLAfkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIOKto7u02K2wzlgJ+rVNdlvLH7F7SJHQSFJiRX9jew=;
 b=R3TkTeJSaMDM0MlHXT4nPRfHrJJRYsSIt4AmR1GZ2+MlFOj2/NpTjwRTUQe+eJVvM7ogm7bOim6Q6LZzI1eDspkxrG5PDW7A/i6BmoZt/KIL0p4zRdQXUVmITSXLlSwbmujsoaujZEHGJ1StWUEOeBDmirL48AP/dCOqRZWI4Os=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2798.namprd10.prod.outlook.com
 (2603:10b6:805:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 07:36:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 07:36:51 +0000
Date:   Mon, 31 Jan 2022 10:36:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        kitakar@gmail.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, tomi.valkeinen@ideasonboard.com,
        joe@perches.com
Subject: Re: [PATCH v2] staging: media: atomisp: Use BIT macro instead of
 left shifting
Message-ID: <20220131073624.GH1951@kadam>
References: <YfVstOJ38OTtd43n@smile.fi.intel.com>
 <20220130180655.22970-1-mosescb.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130180655.22970-1-mosescb.dev@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0991c71-e374-4702-224c-08d9e48c71f3
X-MS-TrafficTypeDiagnostic: SN6PR10MB2798:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB279873789B21F18472955F4B8E259@SN6PR10MB2798.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylGA2D0n3nISlIwWp7GwaTogoBy8VKlet3oTwLQ4cPnwXCFwXtdqNJCH5e3bX8gNMdfWbucq1zO/+IP88r5LRsQlXB+A+t5OvT21yt0YPRAC/8jRUFQpdc8INlmI2W+LkVw0YCuBLQAHP0ZFL8ZRtXM/LCxLCpvnd/VL/l6cI7c2S7MKmfcEfWHAz17Z6REBSnidXWdzSWQTmJi+TgrHFBUNVnmjDnE83G6oi9kGXKJ/KbxBmYtpQeoEZV0flWpEHmphjP4XaYQNFNvKAI+8PRDMIjnD5msVzpT58vfGA9IMDBucWTYlFzGo7N9eV2j8n4tPifVj4GOwaQLWqxEfWUAlHWen+jxeCI4emSFPuSnyDFJO1j1vljB0gyCScF1dHRX8dtt4OGd6RoDr2XDhBNyJ5QUYlsYZoy97EQi4EzrDuvKspnNbyhLIRAzkSG4Ns5Ukd7V8iDOLwvZaWP3n7OMtHrYzHtQXjrDZHpr+Ly2dzIQKIb2z9nXXgQB49IMO+ALnHJNtVAOmgKM1KKYuShv0smaOq2smtmP7C7KguDvNpxfIBn4DgkL5IpLVvmdgnY985XOUCOUtFro2/xQI5ha9/uL5CMcbRbWYHcJiO+lQU+9ydwJnRqHhlJ4i/h0DSy08bdcFVPt9cOdX4nHS95HT60wQ+0tF85Yhw0Mkx1qt4AUbNuKrMUJg86JLOYRG7hO9S2fz6U5uTTisXV+CKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(66556008)(66476007)(38350700002)(44832011)(5660300002)(316002)(86362001)(6916009)(52116002)(8676002)(2906002)(8936002)(4326008)(66946007)(508600001)(1076003)(26005)(6486002)(7416002)(33656002)(6506007)(33716001)(6666004)(6512007)(186003)(9686003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZTs/VJnaIOxiDfql4ilh/R+5vm+i4+vSkJdRQDjISAAGAAwU+UMPJgQNwbJ?=
 =?us-ascii?Q?nL499LNujmUsdzbiEwNmf76SbYRoHDUaAcm2mnW68ruUp+5Yx1C50iEyAXVh?=
 =?us-ascii?Q?W6r+RM6r2SIEvNWiHLrJjSdqYfshElyIN1FCroxJhnrjMtGdrMoTk71832qm?=
 =?us-ascii?Q?KKXdRSM1uZn52G+Pm6gCO4MqmaOwLb1fZRAkRTQ4YXOAEe1NQhiMCBKtm3BL?=
 =?us-ascii?Q?CPwKvUoO1QpfBEk4vLlAK9STVibFzvm1qVn2cRfYlJXR6U0ubsQiMyC4xrUo?=
 =?us-ascii?Q?Dm+APrwRIpWyIMjjhtHcrl5tAHs86iXtJlYJ+BBqb9gRurS8rKS5lHkR3Tfv?=
 =?us-ascii?Q?Hjgg6JpfnFtgT4YSkn8pynNY8khFf4fqsOb0X+Wp1szLxUXMIHFqj4Bhvew1?=
 =?us-ascii?Q?bbw6hfGhGASvhZtjYWUXZL5giSOOwEmHfoHVRrmPLmEJRfjywKSJoyOXq2rn?=
 =?us-ascii?Q?YstiDKVd8HaaUOhwz+CB4y02b3SPi8c2GdNT8VL9rMbGBSGsNpZOC3a103NH?=
 =?us-ascii?Q?W+w/QPn1Ey7hFtIHuNLWIC3tf712iidZ/yP3r28bR7cgTPOdJpijm/smhnOV?=
 =?us-ascii?Q?vohzgzsLdSKrMg/XZ8TcUA45W6PkXGFzEQ6EyhEqgiRgR2GzjHRMivItSp2P?=
 =?us-ascii?Q?MNctD7GfuZxbiCe3xUfXCIZVT6Cn+h29Eb8lJn7w56Q1tg2SjUZAh1c5uMsG?=
 =?us-ascii?Q?gtvBiza/QyheEUM66VyA4uxCzv1k0KSBAdLSShe7bjU3Z41pZ1V+z0MdGSDG?=
 =?us-ascii?Q?fuprMQTkAuZWxpFX0TkrO2jA/XjIOGPED+05kN4ziUlGdwe8cV1G3Wijrogw?=
 =?us-ascii?Q?yTs7BahVvq2EmywcxZAv7/ITVxswh62WDOO6v/KR6YBqXWpxZo62tF+Bq20s?=
 =?us-ascii?Q?3ueS0HSf7vLU2jDIiVfaJ1pIp1qUY7TtSuq5bgAHIMGm3yby/ZVmymBWP0WA?=
 =?us-ascii?Q?7ABvS4fPKZQ4gITwDCOuyshoJcoCLwfl1OVsG2VsEmf5pEiDGXb4iH6PN+vi?=
 =?us-ascii?Q?M6BnMIpqT1khcMSJMsbPzFvTsGj9rEAvyLmFonB6mgAPtxQJTAoAAYmF7+tk?=
 =?us-ascii?Q?HUKwgjGQJ9cdhVe5gMIXWDMNiOip3a6V6+LqdIcc/iepuDnh1yIvFSjcUjqZ?=
 =?us-ascii?Q?5C+rpWB9pcJVhp9pFrF9IxvGrrdfIGsb8tkwVmeWUxkDDC+iuBptllv4COUX?=
 =?us-ascii?Q?BDj7Wmt5+YmaYBEz1GVg7/fJ82qmxQEnAcMR9bljeeP9KxlxR1t6fRwi2oQu?=
 =?us-ascii?Q?8tdJ+T6TSe2W799BO+0pnOt0cDsizYos516YkRoyemwUjmmpN3Cy7LMabnx4?=
 =?us-ascii?Q?dkDXCLLCD6sxqm2pC5clqriHPJqYTQaWrK9MJXP565+hIVBRAIGmUMTTLnVJ?=
 =?us-ascii?Q?+6sYKOEOwzR0wA0vUcmyZII411jYwCvOtk3sLC0eUc2gne94dmNSmld9aOTN?=
 =?us-ascii?Q?n2uUsR5LL8+GCgAZ7ryn3YxuIOAbR375EO9iNkev5LyKlxZr5OsZLQFCPv1Y?=
 =?us-ascii?Q?qkVNrENzNu57Z6Vmcp1aK2oIQYQ1+A5WJ5ClF/LvSmmfVY5B4bKlntvVyp8P?=
 =?us-ascii?Q?eDEHZPPpyxkUqYukg9QvVPlrsFFkm5+JyitGqSuU+G8Dqp/w2CEtkN7OhajO?=
 =?us-ascii?Q?WZ9rhNT301KbzQd2BO/R1S5809V9zwrv1j+XKcRQGrnwo3RNDKWD/zO/PIc2?=
 =?us-ascii?Q?pa+csVfixVLiPcuRnIMfkADVhMc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0991c71-e374-4702-224c-08d9e48c71f3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 07:36:51.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmChJlcc5ESS4ynj9u0IKTBWklgZSlaZD8VG+VkP0UYf93jywp6kiE8GOYshtUD5KcrNv6JQTrgA04DcTAiTLLJMk0RzepIionhbV92bu1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10243 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310050
X-Proofpoint-GUID: Np62ja3rIZiS0prFltf0QpnpdIjMIva3
X-Proofpoint-ORIG-GUID: Np62ja3rIZiS0prFltf0QpnpdIjMIva3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 07:06:55PM +0100, Moses Christopher Bollavarapu wrote:
> There is a BIT(nr) macro available in Linux Kernel,
> which does the same thing.
> Example: BIT(7) = (1UL << 7)
> 
> Also use GENMASK for masking
> Example: GENMASK(3, 0) = 0b00001111 (same as (1 << 4) - 1)
> 
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>

This patch does a couple unrelated things.  Break out the GENMASK()
change into its own patch.

> @@ -65,7 +66,7 @@ enum ia_css_fw_type {
>  	ia_css_sp_firmware,		/** Firmware for the SP */
>  	ia_css_isp_firmware,		/** Firmware for the ISP */
>  	ia_css_bootloader_firmware,	/** Firmware for the BootLoader */
> -	ia_css_acc_firmware		/** Firmware for accelrations */
> +	ia_css_acc_firmware,		/** Firmware for accelrations */
>  };

This change needs to be in its own patch.

> diff --git a/drivers/staging/media/atomisp/pci/ia_css_env.h b/drivers/staging/media/atomisp/pci/ia_css_env.h
> index 3b89bbd837a0..b9ebc14441a1 100644
> --- a/drivers/staging/media/atomisp/pci/ia_css_env.h
> +++ b/drivers/staging/media/atomisp/pci/ia_css_env.h
> @@ -18,6 +18,7 @@
>  
>  #include <type_support.h>
>  #include <linux/stdarg.h> /* va_list */
> +#include <linux/bits.h> /* BIT(nr) */

This comment is not required.

>  enum ia_css_rx_irq_info {
> -	IA_CSS_RX_IRQ_INFO_BUFFER_OVERRUN   = 1U << 0, /** buffer overrun */
> -	IA_CSS_RX_IRQ_INFO_ENTER_SLEEP_MODE = 1U << 1, /** entering sleep mode */
> -	IA_CSS_RX_IRQ_INFO_EXIT_SLEEP_MODE  = 1U << 2, /** exited sleep mode */
> -	IA_CSS_RX_IRQ_INFO_ECC_CORRECTED    = 1U << 3, /** ECC corrected */
> -	IA_CSS_RX_IRQ_INFO_ERR_SOT          = 1U << 4,
> +	IA_CSS_RX_IRQ_INFO_BUFFER_OVERRUN   = BIT(0), /** buffer overrun */
> +	IA_CSS_RX_IRQ_INFO_ENTER_SLEEP_MODE = BIT(1), /** entering sleep mode */
> +	IA_CSS_RX_IRQ_INFO_EXIT_SLEEP_MODE  = BIT(2), /** exited sleep mode */
> +	IA_CSS_RX_IRQ_INFO_ECC_CORRECTED    = BIT(3), /** ECC corrected */
> +	IA_CSS_RX_IRQ_INFO_ERR_SOT          = BIT(4),
>  	/** Start of transmission */
> -	IA_CSS_RX_IRQ_INFO_ERR_SOT_SYNC     = 1U << 5, /** SOT sync (??) */
> -	IA_CSS_RX_IRQ_INFO_ERR_CONTROL      = 1U << 6, /** Control (??) */
> -	IA_CSS_RX_IRQ_INFO_ERR_ECC_DOUBLE   = 1U << 7, /** Double ECC */
> -	IA_CSS_RX_IRQ_INFO_ERR_CRC          = 1U << 8, /** CRC error */
> -	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ID   = 1U << 9, /** Unknown ID */
> -	IA_CSS_RX_IRQ_INFO_ERR_FRAME_SYNC   = 1U << 10,/** Frame sync error */
> -	IA_CSS_RX_IRQ_INFO_ERR_FRAME_DATA   = 1U << 11,/** Frame data error */
> -	IA_CSS_RX_IRQ_INFO_ERR_DATA_TIMEOUT = 1U << 12,/** Timeout occurred */
> -	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ESC  = 1U << 13,/** Unknown escape seq. */
> -	IA_CSS_RX_IRQ_INFO_ERR_LINE_SYNC    = 1U << 14,/** Line Sync error */
> -	IA_CSS_RX_IRQ_INFO_INIT_TIMEOUT     = 1U << 15,
> +	IA_CSS_RX_IRQ_INFO_ERR_SOT_SYNC     = BIT(5), /** SOT sync (??) */
> +	IA_CSS_RX_IRQ_INFO_ERR_CONTROL      = BIT(6), /** Control (??) */
> +	IA_CSS_RX_IRQ_INFO_ERR_ECC_DOUBLE   = BIT(7), /** Double ECC */
> +	IA_CSS_RX_IRQ_INFO_ERR_CRC          = BIT(8), /** CRC error */
> +	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ID   = BIT(9), /** Unknown ID */
> +	IA_CSS_RX_IRQ_INFO_ERR_FRAME_SYNC   = BIT(10),/** Frame sync error */
> +	IA_CSS_RX_IRQ_INFO_ERR_FRAME_DATA   = BIT(11),/** Frame data error */
> +	IA_CSS_RX_IRQ_INFO_ERR_DATA_TIMEOUT = BIT(12),/** Timeout occurred */
> +	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ESC  = BIT(13),/** Unknown escape seq. */
> +	IA_CSS_RX_IRQ_INFO_ERR_LINE_SYNC    = BIT(14),/** Line Sync error */

The comment is kind of messed up.  There should be a space after the
comma and just /* Line Sync error */

> +	IA_CSS_RX_IRQ_INFO_INIT_TIMEOUT     = BIT(15),
>  };

regards,
dan carpenter

