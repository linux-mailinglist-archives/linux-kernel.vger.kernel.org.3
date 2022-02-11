Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625104B27C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiBKOZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:25:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiBKOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:25:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B99188
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:25:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BBCL3A027666;
        Fri, 11 Feb 2022 14:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ItEgz6lCEU39l5HKYhNOtrd9dFK3bQp9W6hq00eXsx0=;
 b=zZyi9yOsusD5LJRFOiUeqCFA13bvNtOBw4Wn1o1hkJ6nNaUT2PRka49a7nHnU5nHjAEe
 GisAy/wyirvEIsGG5kk2+7WyhrgMDS6ovebKpkOeKqZ64MevOoI27D4Y57AL4fIcCXV3
 mwuSUugyruYOe3Mw6iXY4rBDp7hZUINEsZCWrpvnkBwBu1wyZGhxQy3TB8bIGQiYdlMi
 Q4NCR/Bdkb1/YXxYmbHiA4hZxVLVr3SteCuHGPy6RXWHo79vU6buZ8xmYNSx/hFQCXI4
 U0oRTvFOEholGgEqEou0sBC6qU0kv9+rutQ3nUPnnsxT91b+qT0EyvOr/EzNpgHyduvs dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdt35s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 14:25:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BEGOio137834;
        Fri, 11 Feb 2022 14:25:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 3e1jpxs5t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 14:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBl7N2IYg2w3LxccUz1T93njSWyAyawq5ZSZgo7rl0SXDhNrlsnzZOFnH8IuTqZhEAb/cMtbM44iZNhKuP8BffCqC58RhWdv2Lw+sR92dN2pcMmLt/7Et0yrPXqYywHv4HYvjYxVmh0AqxGX2JdE3nOdDkkiCtw7UzTwTQK4HOFV8UTY1Sh4VXSa/rrJQe8evPcFK7MINEDJbTCoTTVlxsevbK757fWqZzLpOK5Qzpbn+PTDkaMQTJ08pl2mWJ6/zNu39MGBS1Au9TeUK2RFFzcEXu4hJG09f7psO0eVleHDikWcZlfRqIB7cHb5hG5ilb+MCFrNo0/BfpLLxFGe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItEgz6lCEU39l5HKYhNOtrd9dFK3bQp9W6hq00eXsx0=;
 b=HTMEqyvNhcdBLeAt1MpO1MTHgcmYIcCK6QKMUNGkEQyDZLvnaihaXHUSvkOj4BINOIHWvZ076fH1yPmMjOUgokZkxDrNZ8iQ8jN14pzzUM2dGKbWR2UISRGBIDfFjs//QYotI88yMA8o0oVGGC2rzqrSvEBNQggK5UxYHJAgUlAMgQvPOap2cak039rC1+VQeZQs1B3O6PMNLJ5Aaq+27CrEE2/JTaIK2XwMiZdV7c6ZNTWfj6EUsfrQTYatDUyqQYcO6jAOoxh2j/R/Z1Avc5B73n+X4VFIXmgZPF9rd/2MqtoSwdw2HOvKqSk0HgzCbQ5uxMvvMFVqYRLaT7uA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItEgz6lCEU39l5HKYhNOtrd9dFK3bQp9W6hq00eXsx0=;
 b=e/qxjAWQ4cFlignruygw0qR22l22pYnu1lFfzu18X0OIZwHoR/Uh+6h4qlMSlEBhBXo5szbdXjApRZOOsuD4I0JlHfaQDRs5tV3QQcjM94lBnJH1MXsBW+tDnlqbMFjgodTiemI940qaTgb2T3T/yHI94TaVpcVfpBfIDFIFCZY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3249.namprd10.prod.outlook.com
 (2603:10b6:408:c6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 14:25:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 14:25:39 +0000
Date:   Fri, 11 Feb 2022 17:25:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add rf69_dbg_hex function
Message-ID: <20220211142528.GO1951@kadam>
References: <YgYZRArwwF7Z1B4f@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgYZRArwwF7Z1B4f@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0043.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f6bd96a-3525-4056-336f-08d9ed6a6083
X-MS-TrafficTypeDiagnostic: BN8PR10MB3249:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3249AF5B69DE4E7DBC7746698E309@BN8PR10MB3249.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6Yqv523/JwJJ3vWPTSCJ49zYDC5L65qLJ6k2XKQMNOmVefRJOrAiOpgTeSmfjfC40tyJHzJ/6pj5PnL+8HDN0k+zHNzZbCz9h+WfMf4HTBDX4bBcGsqne56nDm3eW7Muqpx6svbO7GccqDpEJlkMfkY0dHKTeqMbDlTamZfPfYp+dqpMMo+suor2+/ixwbr/T/C5ZUdzER4IYiRuT+8JZDIr8/0bytqQlbnRNPREHHpcI6EeIF0ETaaPPHJdN6+oMIoBAGoqODIw0HUlNDjytKyCWItMbYw+lBQrKB4+08Ar2bXYCb9+eqsXRhSRSAhsSjp4XLuae+vF6AeDCJGpaZ0o7JrzzfQypWypQEBS6xJfrhqClFboMSo2oGymnZRfAVn/+6q2ELHAfev654aoTnSaDGDVByQUGw5U9F4s9Fr0LkTV/J1l3BQIrn5ocT0ZNIxrp8YLx/wrcbf8/dg+ly4RrqNJ9HX+JY4eEhs2pFFjoWFIj9p3bDtOyskYqLg8KfGu3cdlgd+43TEO2uuAawSWAtY+NTvQ4J78+K5tEd4j6RcANFYNxhrs8mRhCvA1p9Bem+6A48Ox1SAX+420dgj8B8D17SgAvaSs4bdy18ypEyjMa2vtEIT3u4Ri+aGCa/2N8L4EulaCYbGIyS5UEMGVxsF1tMKlzbnzt8ODXUC/yr7+rzn2WE6rR3KhFuEx+kciOC1YyaUJ0L1Iea9Mo/A8IY8j7Hr2PcyWrp1NDVIjbPPdlMbiZSElwHmt9tNB6Mt6POVrh8YKi2IX1i+w0Z3beefhGWu+oPo1IevveM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(186003)(6486002)(86362001)(6916009)(8676002)(8936002)(38350700002)(316002)(66556008)(9686003)(38100700002)(52116002)(6512007)(4326008)(1076003)(26005)(966005)(2906002)(6506007)(508600001)(44832011)(6666004)(5660300002)(33656002)(83380400001)(66946007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PASfzOc/kOj+0yLFbg8B6b2yjvb+1domI9zz4AoY4xMWPZtOhM+lN51yPA2m?=
 =?us-ascii?Q?Ppj441+LkziVppGTdR4vNG6f140b1yCtQ3rYRvDT6RxgWuObTXUdo4s5zXO3?=
 =?us-ascii?Q?skXZJTbmjJEy2JVSTZUMveSGxz8G+Ut+YOTIdf4h3YmIM7/bEwWbTET9koYh?=
 =?us-ascii?Q?u5fxPHpv0i9h5DfErgTJrhbyOSoHIZtXFdcZN2aeNb0yBedjTCZP2SroLVc6?=
 =?us-ascii?Q?X795BjSwUZizQ2Qtmbf0NSeBUl+yKeVyH2iKEadMYir6EeLpLKfLOGfOAwFb?=
 =?us-ascii?Q?JVDetKn94j5whzLeqN3ZFsmM1C5/k1RimoQkehgHN2Te8y3kMN8pBU6Mq7aq?=
 =?us-ascii?Q?zkAWXJSLDpckr6TlXUQz+mP1tCzRnuhce6KDB0wPOVpHdAqMk+VzsHsdm6WV?=
 =?us-ascii?Q?GHXDY6S0MlngsUMqJ9Fp8Cdi3XnWO7m8mYR5ZjZ5mDNVNRI02RVK5PokUHsM?=
 =?us-ascii?Q?eeGV7TD2QYzfzC16iettzqEc+4pzSsqfn8WsG2LkW8jFGwB2ARoMklb4oVBb?=
 =?us-ascii?Q?8Edb8LmctCjMXoEk3OWcRkPVI+r3jd8EOuL5cVKYVUH6w90htQppLKzBfoVc?=
 =?us-ascii?Q?xG+CnBwbnD9Ul+4JKS+04N44PV7gLWqk54LldLbEpU75C20WEDGX2XT2pGOQ?=
 =?us-ascii?Q?06aonCzGn8eTi+i7EAWnLF8Q2hN10Mxz/1mA5a1OdIiuF9JFsbl804KlJckY?=
 =?us-ascii?Q?i3B+baXSzu/YKfdmm0jehTrAz+8y+1QpCTTMCFAHBi0UYKT4dl1QB2sluQkw?=
 =?us-ascii?Q?jlTtFNXJU9hrfX2eKFJVFVQsJbnxuv8PTe92HEGscz957+oqSzyTRQXzf1aJ?=
 =?us-ascii?Q?C2h960AcKpI1QJNPNLR+tWLYhg2/Va9HgYFTlr1oVMBpT1fsicGhYV+OZQRF?=
 =?us-ascii?Q?YHI11fFoPb+TDm/Mt9WBPlsQ4jakZneV51ewjpU1Gtw7e6jF5VHcP1Zv2waE?=
 =?us-ascii?Q?yV21iVNL1I6KI9LEJEfjUpUHuLnmoQqSGVQLL8Cq8Vx/K1gAVxNEsYBLIaCT?=
 =?us-ascii?Q?NoqS36QL7qFHOeMrIlhwC0R2F/KiuMh8eFkw7GJcjvLNLXF45iBjRp99wxDP?=
 =?us-ascii?Q?E4CWVUNfdmUhz/pyn+t6ZMlh54DVR67gqRmCXMy6+XGkO8LFJE0pf+Q8M0M8?=
 =?us-ascii?Q?L4gqORNCPZLLn9xf2qFKujIS01KolWHompQWAOm8r/zfgdkys3ouOMBFQ3AG?=
 =?us-ascii?Q?VoSvaZkPHiM9lqr4gRNNioHY51B5866Hycdn7JOETS8HF8I5foA/BRlnCcHi?=
 =?us-ascii?Q?kPztmcy7DGxpb8ooSbNVG6j9um+ld6wp0ijN15PBgOh5YKrpx/ow3Qqk9k63?=
 =?us-ascii?Q?eUFBvKtQKQzAYD0YUhcHLgeOmD0hSWALh4HQuPPfU9MhC/FRMeAuBq8OnZ5n?=
 =?us-ascii?Q?wktUpaaT8Z0HJCnirw6jBKMrpU8/F75AnegYjQI90MpOY2DT+Ik5PXHJnmMb?=
 =?us-ascii?Q?FrDVCOBIU7V4ypme5ZPEDWoarjFOFdA7xf4NnD3WEmclYn1TLCokFtLrHkr4?=
 =?us-ascii?Q?BNys6hZWAWzlfiBvMY5THQ1GHPD5ovXgjEobLHz1t59ZWPx0wM9xghmaCzOE?=
 =?us-ascii?Q?9PRp3RuqHm8pMxeWwbkfcC+7jk/dXu9n2xfVBgtsZNiPSsTqa1oapk6hugt6?=
 =?us-ascii?Q?rbPQQJZQeN1gfInkXcz+fCFKVu2PHZ85uzVqf2n4wzOI6DlMRGBbOi5vD1rV?=
 =?us-ascii?Q?SCAWZw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6bd96a-3525-4056-336f-08d9ed6a6083
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 14:25:39.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2z+sQ4Kpe00ORtZfSh572+xoHIa/Q6Vx7lctirFInILq5HEJyUaE7dh3zO/dTAgXMnQDGL9vNdH1at644v2PC4W4PDy67gMBEBGgs7DP+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3249
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110079
X-Proofpoint-GUID: fFCh3UNPvycD004WIEt-WFTD8UmsoH8Z
X-Proofpoint-ORIG-GUID: fFCh3UNPvycD004WIEt-WFTD8UmsoH8Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 09:07:32PM +1300, Paulo Miguel Almeida wrote:
> dev_<level> functions don't support printing hex dumps and the
> alternative available (print_hex_dump_debug) doesn't print the device
> information such as device's driver name and device name. That type of
> information which comes in handy for situations in which you can more
> than 1 device attached at the same type.
> 
> this patch adds a utility function that can obtain the same result as
> print_hex_dump_debug while being able to honour all possible flags that
> one may be interested in when dynamic debug is used.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---

I feel like this patch is over engineering your debug code.  Is this
really worthwhile?  If you really prefer the new format that's fine but
it seems like not necessarily a good use of energy.

> Meta-comments:
> 
> the initial discussion to use print_hex_dump_debug started in this patch
> but the original idea got merged into the brach.
> 
> https://lore.kernel.org/lkml/a630d8381cee0f543e0d77614052e1d04ab162a5.camel@perches.com/#t
> 
> ---
>  drivers/staging/pi433/rf69.c | 39 ++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> index 901f8db3e3ce..82d4ba24c35f 100644
> --- a/drivers/staging/pi433/rf69.c
> +++ b/drivers/staging/pi433/rf69.c
> @@ -822,9 +822,37 @@ int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
>  
>  /*-------------------------------------------------------------------------*/
>  
> +static void rf69_dbg_hex(struct spi_device *spi, u8 *buf, unsigned int size,
> +			 const char *fmt, ...)
> +{
> +	va_list args;
> +	char textbuf[512] = {};

No need to initialize this.

> +	char *text = textbuf;
> +	int text_pos;
> +

Don't put a blank line in the middle of the declaration block.

> +	int rowsize = 16;
> +	int i, linelen, remaining = size;
> +
> +	va_start(args, fmt);
> +	text_pos = vscnprintf(text, sizeof(textbuf), fmt, args);
> +	text += text_pos;

When you're printing to a buffer like this then I find it's easier to
leave the start of the buffer constant.  So get rid of the text pointer
and just use "textbuf + prefix_len" instead of having a "text" pointer.


> +	va_end(args);
> +
> +	for (i = 0; i < size; i += rowsize) {
> +		linelen = min(remaining, rowsize);
> +		remaining -= rowsize;
> +
> +		hex_dump_to_buffer(buf + i, linelen, rowsize, 1,
> +				   text, sizeof(textbuf) - text_pos, false);
> +
> +		dev_dbg(&spi->dev, "%s\n", textbuf);
> +
> +		memset(text, 0, sizeof(textbuf) - text_pos);

No need for this.

> +	}

Instead of printing lineline at a time in a loop, what happens if you
just print size bytes?  (I honestly don't know because I have never used
this function before).

regards,
dan carpenter
 
