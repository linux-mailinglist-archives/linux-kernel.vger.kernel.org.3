Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22C4D2E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiCILq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCILq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:46:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F21712AB;
        Wed,  9 Mar 2022 03:45:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2298eVJJ010441;
        Wed, 9 Mar 2022 11:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rFQEBOjE3AqssKW2ZoM0kI6MdFkqx5POiQsuFZ57cBw=;
 b=ysWaDQhJMi+7dpWYLVS4g+8QwQVdF5uy52dfWyPg7r6h4DfintI+7BGitTqnP/cQQG1p
 +riMEiLyVDHyaG3kxkpg+SzWRp0ZgP36FWCv/qfWItJmCf/NKlpxu8sg0G6xmrcuRmgy
 yDEob+Va33dZwwIEb50XuhMiJDIfsySbpcbO32JXWpZXQrgzLiTG9Rafm4prb2MiI0ph
 ZqOzVHoZ65ge5/0JEfhJGrcUZJQSgtpdnPnuXQBp7kZGx5Z1JasgEv5Vtzc9rKcraafz
 pKdorv2mt5xTBO3hfB2xwDhriumQKDFR4j5OmbxNxG+/iyTwKR3hM81rCYOKrQk/9CIh Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrasfff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 11:45:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229Bak4Q008810;
        Wed, 9 Mar 2022 11:45:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3envvme6ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 11:45:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1SpKSCCdsmu7/gZZIDX4i0gr/FvCa0U2PGVT5QZ0zduHjJd7BPY9DnMQWu+zwOsiwDYY1rFp5YOO4rYOM2LWdNQAxN+phBPQPtfSg8DoZA88uZoKcmRjINFWUmsP4Xm0Yxa4wOtnQsq/BlPDFg7tiuL+TJY8sXWOVg9AVpLobJia4iFJiEIy0QF9rR7u8MMgJfB3LnEkfRlPOPSGNL0nGp9bqLcb/03G4zliL1OlM/KZupUma5DoErAVKsCE+wMnA090+Ysavjx+ug/elWJvt41eoexYkyJj0YKBucio8ItOxvQl1nIGFrYg5D4JB9zeW9iBgtlkRO9z4OTnaKVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFQEBOjE3AqssKW2ZoM0kI6MdFkqx5POiQsuFZ57cBw=;
 b=hiMvz83rwNC3v7FBpAqYT6eMt7GfTZWF1VXi9CXvuU4tQ+9NwNki7kGfBmkQ3B1bXOndMLSAs5PtCkYmx06wt+qpDEJFdyzv7CUzskjYRMsDi27v7NPOthw1VhjxnE67eQJqeRGvcBzIh6ukrkBj4c6T1XqexG+/LTLdwG36NDFy3MeNgozy3pC08SSde9VXao9iRIeGOYGIYnVgcrFY2MTcHkKvV3OR9bhwt86QL/uGUuTCNTGLhEYhWkTpJoSi0AljBdwjexNvv6Tvx6oSIZiimGss3jZYQUv/jBoZmHmtdgqbrfSBRiljD9AO5CmpVFbG2dICgeuoZXOHgOr9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFQEBOjE3AqssKW2ZoM0kI6MdFkqx5POiQsuFZ57cBw=;
 b=jL4/MWFaE7GqlazpS0SPWizEAcpfsWtxQRbzNtfrKdF7CxUy8MY+rpD0mgQOwilzg0ddV50pasoAUT75HPtoZw65UAkfIaAseq2lKiOQVJy8FCDiSE2JcKRMqmlrHCDgUGRQFejqo1+r/imzugvuewW1LaNT+9RPeVAXX2dYe2g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4676.namprd10.prod.outlook.com
 (2603:10b6:303:9e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 11:45:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 11:45:11 +0000
Date:   Wed, 9 Mar 2022 14:44:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, hverkuil-cisco@xs4all.nl,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 10/15] media: amphion: implement malone decoder rpc
 interface
Message-ID: <20220309114454.GB2592@kili>
References: <cover.1645670589.git.ming.qian@nxp.com>
 <d0ab41721f15544646fac01c1902331476bddfbe.1645670589.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ab41721f15544646fac01c1902331476bddfbe.1645670589.git.ming.qian@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3401727c-df58-414a-511e-08da01c24439
X-MS-TrafficTypeDiagnostic: CO1PR10MB4676:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB467610E6FFE2B75E9F382CA88E0A9@CO1PR10MB4676.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pr3CfZHMN8uykD8NOqrrmv1VQAQPxfqVL1slRfVGTCNNI3K53DpbwB68oKL+EiiNF6c1DeqQgMEKwEHeiK2D1iIeurU7DX4Hd1LaWAZWiAhnC1lP2tlROYoAcibwr38YcQCzeO4OA2wElEO8Z1locJDJurGaRMIoSZKN6G1umd615YcSsbBGt2SnCU8HPVcgLJFthcSJRJpvE7IJMyUZyda1N+64iVkP/WHvUrXhafMu8LBqZ/0iOF4ZJMp8X6UO+KeYlSMe5aPCzzWAybFZym5cseM10RgodkvNfa6YyQNnz7J2dC2eYZC2km/H6WFpCtZsk11lHjERL3v2SZ/Jqxdn/YVT+lCIBUGOiEObSpmAMT2CLmWd0OnBBwOoPwLRZXP4qhT/2j74+I5YCZZQ+S6bLau4K6cdN3L9sR5bGPEC1HXZ+TzPnQWaxZdtuWuVTNEpYVsNV1SZ0QChKyKCcnwPVYVtvPsZ6KLDPwzg+dzx0hBF1iUIFaRbLozfXyckmDVUxzLseW80g6XG7mRBz87nnU3D98NQpDotp7eiUIyetiQbG+xEfzL9P7hpHJ8ETV1AcqyjhrnsySoFJ1mCrLzbt2QOQMIUj28UeHMj+fct76xsZZhv03r3BezavI5ZSNuNvOJ72zRJiilOdasqL73KvECW6QgsrFxq5kvRGvxlOgYCg+DqagmsM6ucy0TfJTKeOuWxh3F7IwKOn3NPrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(26005)(186003)(2906002)(7416002)(8936002)(44832011)(33656002)(5660300002)(1076003)(6512007)(8676002)(66556008)(4326008)(66476007)(6506007)(52116002)(9686003)(33716001)(508600001)(6486002)(38100700002)(38350700002)(6916009)(86362001)(316002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TWEX8IVc4LGltFFAZwxys/KfsGXQZjDQoRWXNFGaSpc3AeUzaXYCY09Z0gi?=
 =?us-ascii?Q?lJmrg3wnhVrPxs/tEEVvLOiAjWv+rog8/xWlgzv0k0os5Bfhqbuhiti6P2bK?=
 =?us-ascii?Q?WbDMsTwU06Wmmdq0ZH4QbC7t4DcuuodLLu++t005XXNt8Sf8BwBKxPHZcCsf?=
 =?us-ascii?Q?DDBPZu+ISuq+PKHSDwtp15r9vowv7TP++SPYYMn06nJ3WiAheuaKnXLBnXlP?=
 =?us-ascii?Q?MQ4NND9rWLUUulRjJZ00R25BI58l0o1r4Dm2R2Bpfkzw7CAHpaGBIfykmjUq?=
 =?us-ascii?Q?JVKPAsLmG+EvSb4VVzNIunuBCK8tINyMxLkYXbq9f3W91M08RQmy6YLt0LEq?=
 =?us-ascii?Q?a8ynweuzOSRA9FT2SOd95spePO8xw3S4337a5oic1jnNOM2LsmmoGDfY/KP6?=
 =?us-ascii?Q?FYipLwtF6ZvH3hxHIKdXW+BdHLNEaVlFqva1jzed74fxtwoRHP3HFfKuuHlB?=
 =?us-ascii?Q?TKRaawG400qgiaxD/GhPxoXxgBa12r6z+uGRNocuBR4to+QbSpenTzOmXjIV?=
 =?us-ascii?Q?sP8P/eq1NvQFrWl3ph7osCL1ZPhqqTzjYnZh5SCu/DEMrXK6UKjTzx9vgMoE?=
 =?us-ascii?Q?rNUfkqjZNI6UPj/iyVJmmnCfG0MVXV01bjnlxYWf+6ftu4uvdELrMI2u405B?=
 =?us-ascii?Q?GQnxO+8q3jGwa+ub6PSuSsDqEIa9AmF1Nsp/YELyN/289KW3KCWIz5iqP40n?=
 =?us-ascii?Q?v6a+qWShNKkGFdIuxu8ilQIO+nXte5VCbFeQx/DtgTnslmfOXcXUiJQ2vSYz?=
 =?us-ascii?Q?stpxUkVbfztI/kyyGYLoZTHldzfGuo/79sGNMDDnDxUZNccDTOFgl+VHahuW?=
 =?us-ascii?Q?NDdWoSjA/ZxjkX4/aRBdXpEx7rX3sllyGSq43I4bJEUToqYJD735Vw4tbn3N?=
 =?us-ascii?Q?QGToqImTyoR6yWMW0MI/QQNuc6je9qP3iKkQpEXSwx0bj+zJpmY+xHKSDsXt?=
 =?us-ascii?Q?Tut2nW5RbD/3dpH2VRNP0TbmNrod3tkl6orYYmwR1mFjJAkQCHzIyTzZqyBX?=
 =?us-ascii?Q?daZpY/RbadD+aQWxGo3rHX9QuGEQFTjgJRkrbUec+RwST6fHtla46TRclAGF?=
 =?us-ascii?Q?ROPBf1VCoMrAl6ZChu2NiCeaZg22Cxq6ir+XKI8HHQ6tPuoAAseajyvXFNiC?=
 =?us-ascii?Q?zmpiAkJ5UeOuxYkKG3WRjB/GZQSEPelCiubjqPgoKXrD/3gex67iq2mVcjm4?=
 =?us-ascii?Q?awc52FhGJ+kpnJC7bMg6EzxwJhYrcI3FGhhfP3tcGt1Ox+JyIi4PHeqT2m0o?=
 =?us-ascii?Q?rVcmZMJBNZRW2nNUCKZ4rI4WNjVpghNBzRJ7FB1mPpJKf2Up6G1l6yx9bFUS?=
 =?us-ascii?Q?e/1qHEHQlx5Mk0e2FmXWrrXWLQNSOY10tKnebkC4ighLaI0LZ9aPLjPl4Y4f?=
 =?us-ascii?Q?dCL7HSUph65bvM35qAjRDQmeqh8+uW3iuJPeK2d8BpQ8P/GBy6ep8YDAo35k?=
 =?us-ascii?Q?poRDGUWys6KEzJ1Ln9UorzVojVYqvDOTFl+FP7vJCluVlbJhwovUNA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3401727c-df58-414a-511e-08da01c24439
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 11:45:11.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsF70OApo0Nekar3hWSuM0I+0WHDhpl6ygGi2Ql+54Yc7voUTxHPRIp6r/RsefGInkKFo26EgzjXoMZjLkwdVZLiF79Kb4VN9eA75ZE3810=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090063
X-Proofpoint-GUID: s4r1lwnRBSdHXSCMtsGTsU4AATxXXCkk
X-Proofpoint-ORIG-GUID: s4r1lwnRBSdHXSCMtsGTsU4AATxXXCkk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:10:08AM +0800, Ming Qian wrote:
> +static int vpu_malone_add_padding_scode(struct vpu_buffer *stream_buffer,
> +					struct vpu_malone_str_buffer __iomem *str_buf,
> +					u32 pixelformat, u32 scode_type)
> +{
> +	u32 wptr;
> +	u32 size;
> +	u32 total_size = 0;
> +	const struct malone_padding_scode *ps;
> +	const u32 padding_size = 4096;
> +	int ret;
> +
> +	ps = get_padding_scode(scode_type, pixelformat);
> +	if (!ps)
> +		return -EINVAL;
> +
> +	wptr = readl(&str_buf->wptr);
> +	size = ALIGN(wptr, 4) - wptr;

The ALIGN() macro can wrap to zero if wptr is > UINT_MAX - 4.  This
would make size into a very high unsigned value.

> +	if (size)
> +		vpu_helper_memset_stream_buffer(stream_buffer, &wptr, 0, size);
> +	total_size += size;
> +
> +	size = sizeof(ps->data);
> +	ret = vpu_helper_copy_to_stream_buffer(stream_buffer, &wptr, size, (void *)ps->data);
> +	if (ret < size)

The problem here is that size is a u32 so ret is type promoted to a u32
and (u32)-EINVAL > size so the condition is impossible.

> +		return -EINVAL;
> +	total_size += size;
> +
> +	size = padding_size - sizeof(ps->data);
> +	vpu_helper_memset_stream_buffer(stream_buffer, &wptr, 0, size);
> +	total_size += size;
> +
> +	vpu_malone_update_wptr(str_buf, wptr);
> +	return total_size;

What was the point of making total_size a u32 if the function itself is
and int?

> +}

[ snip ]

> +static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str_buf,
> +				       struct vpu_inst *inst, struct vb2_buffer *vb,
> +				       u32 disp_imm)
> +{
> +	struct malone_scode_t scode;
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	u32 wptr = readl(&str_buf->wptr);
> +	int size = 0;
> +	int ret = 0;
> +
> +	/*add scode: SCODE_SEQUENCE, SCODE_PICTURE, SCODE_SLICE*/
> +	scode.inst = inst;
> +	scode.vb = vb;
> +	scode.wptr = wptr;
> +	scode.need_data = 1;
> +	if (vbuf->sequence == 0 || vpu_vb_is_codecconfig(vbuf))
> +		ret = vpu_malone_insert_scode(&scode, SCODE_SEQUENCE);
> +
> +	if (ret < 0)
> +		return -ENOMEM;
> +	size += ret;
> +	wptr = scode.wptr;
> +	if (!scode.need_data) {
> +		vpu_malone_update_wptr(str_buf, wptr);
> +		return size;
> +	}
> +
> +	ret = vpu_malone_insert_scode(&scode, SCODE_PICTURE);
> +	if (ret < 0)
> +		return -ENOMEM;
> +	size += ret;
> +	wptr = scode.wptr;
> +
> +	ret = vpu_helper_copy_to_stream_buffer(&inst->stream_buffer,
> +					       &wptr,
> +					       vb2_get_plane_payload(vb, 0),
> +					       vb2_plane_vaddr(vb, 0));
> +	if (ret < vb2_get_plane_payload(vb, 0))

Here again, negative values of "ret" are type promoted to high unsigned
values so the condition is impossible.

> +		return -ENOMEM;
> +	size += ret;
> +
> +	vpu_malone_update_wptr(str_buf, wptr);
> +
> +	if (disp_imm && !vpu_vb_is_codecconfig(vbuf)) {
> +		ret = vpu_malone_add_scode(inst->core->iface,
> +					   inst->id,
> +					   &inst->stream_buffer,
> +					   inst->out_format.pixfmt,
> +					   SCODE_PADDING_BUFFLUSH);
> +		if (ret < 0)
> +			return ret;
> +		size += ret;
> +	}
> +
> +	return size;
> +}
> +
> +static int vpu_malone_input_stream_data(struct vpu_malone_str_buffer __iomem *str_buf,
> +					struct vpu_inst *inst, struct vb2_buffer *vb)
> +{
> +	u32 wptr = readl(&str_buf->wptr);
> +	int ret = 0;
> +
> +	ret = vpu_helper_copy_to_stream_buffer(&inst->stream_buffer,
> +					       &wptr,
> +					       vb2_get_plane_payload(vb, 0),
> +					       vb2_plane_vaddr(vb, 0));
> +	if (ret < vb2_get_plane_payload(vb, 0))

Same thing.  This condition is impossible.

> +		return -ENOMEM;
> +
> +	vpu_malone_update_wptr(str_buf, wptr);
> +
> +	return ret;
> +}

regards,
dan carpenter

