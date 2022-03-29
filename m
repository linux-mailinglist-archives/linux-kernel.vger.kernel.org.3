Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C74EA906
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiC2IP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiC2IPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:15:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B468984;
        Tue, 29 Mar 2022 01:14:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T67jYj006038;
        Tue, 29 Mar 2022 08:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=F7vjUc022jGBHMlU2PHXO5c0zH11o6Klvl9CDp+EClk=;
 b=XW5XPMpxVkAWUuRHAxaw9AHBZtaFpt3Kb1UhAVuOH/pcj6flCsUTDcUFBegCPHea1G8C
 Ta0hCe7p0dIrnv621w6jvYpbdvDHBD2AcUysqDLnPY1cZwRb54ZKX6MYnWrPcuu7TGup
 LBDhaJCk+IWHRtNXX+VASy5UgE0Sw26eTJjsRVXppUhnQkWafrLmHfB27Gkg0hd5O47I
 oyovFpo2zQV7l6g5dSO3hN+q6wPTk4/QDFe8xMKKCpSpivgQGK4ERv9VoNILRI9iG8dy
 YBL/ABXIeITJTK/1r+/tONywlIzcR2nXSDFVWPKUyKmg6i27/pQZUCW64/Ju7RX9jb6V kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb5s6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 08:13:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T86j7e045098;
        Tue, 29 Mar 2022 08:13:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3020.oracle.com with ESMTP id 3f1tmyjn5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 08:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikjzAFjqVUM09/leVV/O4AUnYrIeCw0CYPkkqh3vgGC8s8AfVF8m1ihaI4xLGMOjaUtwNsHa8dfAR1OyUV/cr5fNNMp5acyZLIQODNH83k8yNW5N/S5WlyxryogHmo55t7LJLAhvkN5PVkMpup6gOcgOkuiVOsCpE4yMPwO/CzEiS62U19hJA1UAehb5oSQF5d4iO6Q4A2REGA2TvciEO/rgBQK7Sq6I2Vr4AsXosYWs0fhgpI1PN7hmDJgna173kEL+YTDADP39M3aA0Y9NN8M6/Nk6rJVNJfQvT2MAf6eaz48toCZDoIb/nMBt/kum6yX++2LzSMs7GLS1RUt0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7vjUc022jGBHMlU2PHXO5c0zH11o6Klvl9CDp+EClk=;
 b=HP8LZOr/t+/kwPV7an81tSoIXtwawbPllvefYbsit7yB0mhAC7G1567c4gSDpEWEUXFYRYdNJW3In90uCFGeNpEeM5Bj25wSd2b5Wr86wb9+WabMXSAN4aZMojndknYTgx3uFphk9em7juuqNj1KH5yNQH6pQcEmOBPTPL0DkS4aqz+VB7VY02M6oTLmeAfn+WCag0T3/2jSJRP4XOBQxBnG3lWzXjMQy9cwTXi9/jy5Plh1UPGIO2UYh4bkwvE4LDjXcUnkwYQbpr4riUQaCcGUav3sMVzgKqVsd5P38CEp+V1PymDoU8VASQettXyFPMbzXRdVnHqYtzFDmdCQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7vjUc022jGBHMlU2PHXO5c0zH11o6Klvl9CDp+EClk=;
 b=eQnwbWvogbkR8APwSwDq2nud/w55OnQL2PhEamlp0tRj77tHosM6xMsHsoVFROJN3bat2/jX97Oz0tqMv/7e831aEkAWfYpdDcx5lXdcikwqELjLlPL3Vhmb8DbdAo63rJnr0ZqmogtmIpazklyN5Qa3xUP4/rEjbkJAUht7jl4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1343.namprd10.prod.outlook.com
 (2603:10b6:300:23::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 08:13:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 08:13:44 +0000
Date:   Tue, 29 Mar 2022 11:13:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 19/24] media: rkvdec-h264: Add field decoding support
Message-ID: <20220329081321.GV3293@kadam>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-20-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-20-nicolas.dufresne@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c61ff2a-cde6-4058-6872-08da115c0acf
X-MS-TrafficTypeDiagnostic: MWHPR10MB1343:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1343A22F11034020B0394DB18E1E9@MWHPR10MB1343.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86Zj0eWU99m3tKo+5Tlj0kztIHA97bzI/4WP/5YkH8z51vl+XXdqANFEkwpoufWIA81lNUQQGYh2gaxX0t6RwZu5R0+m7/YObd1lSiFMdsEe/c9BXG0PaDSo2J3Uann44UuCeXGyNH6Gae/Jkf/eWYOwg18WjeC1UmDe7f7hfr2uSG0j9Vx7jH7IoT/5wiSqvyVJwn/hTp3R4cEaglgP2Ea3ZM50JfOk2BeOUXTCk0Iy7JoMUcvr+odRHefDGQC+dVJvxVSy905pynnBXXawL4wFxRzZYvtqMVlVKVkxv5iwnDbt7NuU9phWnLsU2HVJyKZ/DXFiwcV/5ZFqUMMLGJu4e2lBDW70NPCcS8MzcKSSN9+lNHJ64Ks2KpO4PxUYJeumyjJuBFsQwJg0M+lh/oVfoRGo9r2cYjHu+gniKfQjZbyOxJ7bo4OaOrjRMFW1Blp7IidOKV//LOfDhLqcX0fnmqDr3KdVL9yKmN0ylgU2U3onDjH+Xq5x+OI3bDuKCFN9mjx1LZhdQEKaI2iVpgziD2qvRXin+rF/3tGajkD0d2nfySMType7D++mNnWtE9PKvQEMuKxG/rcEI92pxKK4YqSWSSRYzkkg/mAmo4e0+ARDly0u55PGFHjU9Kqyg47RCk5Ab3Ydclx2IcwZl1FYlV+72jWHPHmSFaIOElY+Aj4TG9UN2w/V0fBhnC2tA8yqpjebGBw3cfn/WHRG/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(6512007)(6506007)(52116002)(1076003)(66946007)(66476007)(4326008)(6486002)(86362001)(6666004)(9686003)(33656002)(8676002)(66556008)(5660300002)(38100700002)(38350700002)(44832011)(6916009)(8936002)(26005)(33716001)(186003)(316002)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L9bB0qzLSULd4BIc05elqRhLA3yGhjFgIotr9l4EdwfOwm7puwt4dNkTA17t?=
 =?us-ascii?Q?2Xi5x6Y5TzF7K6llWghRVDmaEgbpmFdWHdTy2hsaNL5Ao2Uv2LdBP189YBnL?=
 =?us-ascii?Q?Y2zJklMocSnxkZvycpN/Cn13oUnfwjf4+Sywgc+VHUQCbgwmZvBQkMJhgnES?=
 =?us-ascii?Q?1enpMsdEP8vUNxhYOHXORsN+ors6aCdP8lBOFSdJuB1EHT77KYoZ8ou/68rK?=
 =?us-ascii?Q?zAoiCRlNp6IXd9RoD8RLkymYomjsMcJZMG6EU0ud/QJN3FvCG9MupJXFADj1?=
 =?us-ascii?Q?M5tvU1Ifr13F4TAeoct1mzoGD3zVbETDIHp5lHxB4q6jGlIo57Y07Qu95Eav?=
 =?us-ascii?Q?903EvPsfIXX6qtMUy1Fthu8yrjmcv+Hhlivc8xKIq9WeYE86r6GZgeCrxD3x?=
 =?us-ascii?Q?lNzi5SV2F1TJYR3pxKPScFppNdIggWEbgxccCb8R0MIChpj5wuKmrhb1RYKr?=
 =?us-ascii?Q?dSqgZ97J4PaWnvREP2RqCcJpusBoyabYp742zJ+mENiEJWDHyLKTVDXtwcF8?=
 =?us-ascii?Q?zNUsxrnVAZc6vwyWIvgoTkb5aT1uxRjIyuwNmEAaTT2q19XfURn61wD1uZAI?=
 =?us-ascii?Q?VPfvTFQZZSrifYOhRdrDwMWuL5SsKnQyrJTwPV23xSjMsXT+O6RUfXSjJ22y?=
 =?us-ascii?Q?vYu4AnA1IXI5F0Qxh5mIux7QtmTQiw23lXHI+YoUSMgATwMZ9EUhfczYvP23?=
 =?us-ascii?Q?s7BhONBX8etM2JkrGVo258rQ7v3w1tNJEbiEUH1R8xezzp+6ceThyQnPb3Uk?=
 =?us-ascii?Q?E0ol1fb/BKZeE8ziGIk8B6Toc2YzkGA2Z1WZdHKU4KEXPuLmG6pHiOZ0Gbc8?=
 =?us-ascii?Q?TnO3SFNVQyMkNbmkphsavOTAJAewO4RFwGCTQwrx6TrAFjzqDODxgt+Alu2Y?=
 =?us-ascii?Q?qG7Q6eUECEJ0979Ws6qPRG1n/txLx457QymT2AQkAtJWYYl4+dNO9N+pBQBr?=
 =?us-ascii?Q?4z7J8QnWlgFDBNuzOBPIUUSGFaeUjrg7Xj8iTuBkgrOlt9AYGoP8jIW9wUCi?=
 =?us-ascii?Q?SdRzGiWFT/1bDAaANWnGJR/d9Y0lJoHu6h/MDOAGVdzczoDuV25R8nUbHbfU?=
 =?us-ascii?Q?iPp8AW76E0lqiSw3BGrgh2r6Q27EBtOip4GQVUp+toYkKcTVGhTNOnGeeeN+?=
 =?us-ascii?Q?qGVWdU/DFiN45RVHMXNGqK/YW96FAa45pkBguugVD9xMt8b+xOpKxj0T5tHI?=
 =?us-ascii?Q?c/VBd4QPhS3poDWwGNM0EZP0uffD9GoBTUjHmrOo4jrT1rAN8eS8E+T+K+4S?=
 =?us-ascii?Q?4iqVHlb0klEIRAGYpXz/hdL7mvK9k60i7lAOnlfLjOFgpng/7DPZyWgRpO/C?=
 =?us-ascii?Q?t37fufkFmP39vaMiw59mbM/G9apIQQgmpmb+t38cVdZfY42z6dspVqvxMp5h?=
 =?us-ascii?Q?Xk6Z219Ct16Nd7XaN45Qi5slhEMuRFdSC2mPRSJNOak61AI9aj0RRlB0tCeP?=
 =?us-ascii?Q?IqGTB9snFVmP+2ZeuTdlZhD2Uzz1Ja4PTIjm7P9S0ZQXIQpKQqOiS1DNwl0W?=
 =?us-ascii?Q?L2p0s/e6+Uq437eYP7sKxsUOVuMyxfD+M0AH6cCIGqPK+6cFQqhLMTgcNi1S?=
 =?us-ascii?Q?s70sQEHzs59/PF6vF1ay29a7vjV9aKabYJMDecmFjRBJ5xr2zNfVWsoIz3/w?=
 =?us-ascii?Q?0/Vgwx0d0r21WJNWEW++b4WbNHWLpG3oFcMkfOe5RIabEhyjtt2OxhiGra4u?=
 =?us-ascii?Q?aHAe+dQECY+rjd0TaWnUYP/CG+4U1EbjYSC4z2AtjxYaf1iylq/u4M3JS96R?=
 =?us-ascii?Q?zmPSHVdE0Oyd1ol/jEa5Ic1NfTw43tk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c61ff2a-cde6-4058-6872-08da115c0acf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 08:13:44.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1YedWUvbTkBIcShPob7pxrd+NGfkqKnzVetNrE940K/Sv/nnkTWU28HRNMjbmpfN8IM2Y/RGmxzoDvfsYV0rR7RQMPkuAhPnir8gWH9Bro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1343
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290048
X-Proofpoint-GUID: 98bHWn-LOBivGNocLYwv77zlpgQQo_fX
X-Proofpoint-ORIG-GUID: 98bHWn-LOBivGNocLYwv77zlpgQQo_fX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 03:59:31PM -0400, Nicolas Dufresne wrote:
> @@ -738,23 +735,26 @@ static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
>  		struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
>  		int buf_idx = -1;
>  
> -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> +		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
>  			buf_idx = vb2_find_timestamp(cap_q,
>  						     dpb[i].reference_ts, 0);
> +			if (buf_idx < 0)
> +				pr_debug("No buffer for reference_ts %llu",
> +					 dpb[i].reference_ts);

pr_debug() is too quiet.  Make it pr_err().  Set buf_idx to zero instead
leaving it as an error code.

> +		}
>  
>  		run->ref_buf_idx[i] = buf_idx;
>  	}
>  }
>  
>  static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> +			    struct v4l2_h264_reflist_builder *builder,
>  			    struct rkvdec_h264_run *run)
>  {
>  	const struct v4l2_ctrl_h264_decode_params *dec_params = run->decode_params;
>  	const struct v4l2_h264_dpb_entry *dpb = dec_params->dpb;
>  	struct rkvdec_h264_ctx *h264_ctx = ctx->priv;
> -	const struct v4l2_ctrl_h264_sps *sps = run->sps;
>  	struct rkvdec_h264_priv_tbl *priv_tbl = h264_ctx->priv_tbl.cpu;
> -	u32 max_frame_num = 1 << (sps->log2_max_frame_num_minus4 + 4);
>  
>  	u32 *hw_rps = priv_tbl->rps;
>  	u32 i, j;
> @@ -772,37 +772,36 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
>  		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
>  			continue;
>  
> -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
> -		    dpb[i].frame_num <= dec_params->frame_num) {
> -			p[i] = dpb[i].frame_num;
> -			continue;
> -		}
> -
> -		p[i] = dpb[i].frame_num - max_frame_num;
> +		p[i] = builder->refs[i].frame_num;
>  	}
>  
>  	for (j = 0; j < RKVDEC_NUM_REFLIST; j++) {
> -		for (i = 0; i < h264_ctx->reflists.num_valid; i++) {
> -			u8 dpb_valid = run->ref_buf_idx[i] >= 0;
> -			u8 idx = 0;
> +		for (i = 0; i < builder->num_valid; i++) {
> +			struct v4l2_h264_reference *ref;
> +			u8 dpb_valid;
> +			u8 bottom;

These would be better as type bool.

regards,
dan carpenter

>  
>  			switch (j) {
>  			case 0:
> -				idx = h264_ctx->reflists.p[i].index;
> +				ref = &h264_ctx->reflists.p[i];
>  				break;
>  			case 1:
> -				idx = h264_ctx->reflists.b0[i].index;
> +				ref = &h264_ctx->reflists.b0[i];
>  				break;
>  			case 2:
> -				idx = h264_ctx->reflists.b1[i].index;
> +				ref = &h264_ctx->reflists.b1[i];
>  				break;
>  			}
>  
> -			if (idx >= ARRAY_SIZE(dec_params->dpb))
> +			if (WARN_ON(ref->index >= ARRAY_SIZE(dec_params->dpb)))
>  				continue;
>  
> +			dpb_valid = run->ref_buf_idx[ref->index] >= 0;
> +			bottom = ref->fields == V4L2_H264_BOTTOM_FIELD_REF;
> +
>  			set_ps_field(hw_rps, DPB_INFO(i, j),
> -				     idx | dpb_valid << 4);
> +				     ref->index | dpb_valid << 4);
> +			set_ps_field(hw_rps, BOTTOM_FLAG(i, j), bottom);
>  		}
>  	}
>  }

