Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502FF4D9F24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349760AbiCOPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349755AbiCOPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:51:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE3443F6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:50:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFVjLQ026507;
        Tue, 15 Mar 2022 15:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=GiRgIHKtcLTYD+DbFyHQ6tEyki5Q8SlPLP6c4NA4stM=;
 b=VdK/E+auq/qZtyL7CJOOR6g0jJpM1m25Wk5ZFqhSddzAC/EIYY1Y8WzPcjWXc5MTExuX
 dD7bWckcACpxL+1O/qmieuKhdF4qKtugSZxqmupg3wJ/oSa0KXMvlr6GblvacH4VuJ0+
 7kG/NOQGoXgq/CJz0WKOf0HT5sFM649UGu6BifuiIKD1F9ujZFzzYuUiwRkCS0Pbi+5V
 FbPzrQrm3VTr5DlNxhwQyIFC7eW9zi6brt3Qy0ZwSqkvO8OKW3F/XPGPsNW8LPkaxBTl
 Q8bhxEVYUZpSUoZP4TVACZ9wIrf/kAHH1sg5C5L3TfLvRHAVZTWw5JF39Bk/oby+TBGx Zw== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rkk44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 15:50:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FFWLod133665;
        Tue, 15 Mar 2022 15:50:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3et64tq359-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 15:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z32Do+b+MF5Gze4aeTD8qc0LdIGwb3+wxp2LQn6ul0Z7u5ZUZxNzCFeCr6p/RLL/2IlyyR9+57pinL2wcW0NCHKMiIK/SGcl/QU/0UeImaGPux4nKuVOaQ9kK2QdfDRAiwaGm8ZP3Mzmi1qbKMVrFGped49lU6OymtyppEoXdERSyyQd5TmZzeoEfJQvsm/HXDIGaUDttrwTgwOln5BaLgDj03bfhf6Wz2UmLQRfI5j1rm+4xqCZtFptXTB5rpkud1DElOmln/CPK6iDUpJ7KXIDuyfiC3gF/Zysxyt9NSvw2ULVNkJLUNdyH4AhQuduSbpkKOKX1Z2ojmyI9sMbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiRgIHKtcLTYD+DbFyHQ6tEyki5Q8SlPLP6c4NA4stM=;
 b=AClb2zvWw6CoqQcgRwgGK7XHo7xJyJVF7QzyViArR/Z9vtEaJ2mbxSIjAAb7yJtJzia/zaAg5aSb0Etgw43urgxjGaq+oT988Eq2LBncENhzaIlBJPQwByNE2ipdrwRBKRC1Mv9LETxbjT6k2axtN1+Kjl01f0zVCYnQio3NyV674zn7kCxXZxWYWNIp9BTi4gVzZG5OFEwc1JYHzMgg3N3txhvOb72a8yaUCydooSkUuM/JgEy0Mp93/bqAJVlEU06I9iOAcWVx1nfX3c95HdMilCMkm/9tHlU229GK3nzCOO/i9hKl3mjGjB3lg3DN+tzBq8IhyCaAn8MqLPdrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiRgIHKtcLTYD+DbFyHQ6tEyki5Q8SlPLP6c4NA4stM=;
 b=bjLFZiaB5vrAjmZrdIdRLETLn8LWV9BjjDkXXJXtEUP8X9AxRXQsA1uM7he9zE3qih9hUXdt3jzQmz2UMzxe+S+YboKylNBwrhVV2MRqfp1cvV/WEgzGoarWrCCy5gQM/lwLDvQY9+asMO17c8wSu+X6jiLyesgL62Yf2ebBvWk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5676.namprd10.prod.outlook.com
 (2603:10b6:510:130::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 15:50:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 15:50:00 +0000
Date:   Tue, 15 Mar 2022 18:49:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>, xkernel.wang@foxmail.com
Cc:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mmal-vchiq: add a check for the return of
 vmalloc()
Message-ID: <20220315154948.GP3293@kadam>
References: <tencent_410AFB702E25A27F689010E6A1DC308E7807@qq.com>
 <YjCg6oQcNiGKEH3x@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjCg6oQcNiGKEH3x@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7449b598-b1ba-41ad-c360-08da069b7655
X-MS-TrafficTypeDiagnostic: PH7PR10MB5676:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5676C3CB24FD30AA7E6B6C658E109@PH7PR10MB5676.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9e548EGs8kv813XkYrVJRJYDjz1YYjR0VcuKRpX0eq4dj2H/L52C0M56ZyK0cnyDC1LF1CtODJhTe2+tdU3aGsMP35lErLUlxL0jzzs46ZGrqNgFUjYA3GviKgul67I5eWxssk+ndHXhrGvOwycuKlVI6386G1glLbXbb4B9IZMCo+KNv5Dd9gfLWMi0Bh9VXKYqJUjQdAp65WxZHEBNLXugs34+6FXudxadURWDXmW9v+OdaupT7v6kkjYQ74v52wNaT0JUILfNN41u6id6UW0IUQt6GpsvWxnykDhb/0cTbdYwRmW8j9MZ2qx5dndFgH2cOdshqRse9iRWUIc0gbFyS4htwFQziyOsn0tsm1qPKog/SdgpSDOjJdD7JqDu97LQpbQxmgnUE3kvHvQ/Vaz4beMzE6DBAEkwakqLAzIXGXt62m2TVxEXi7xvn+14ldqg7QMUJK2/hKgdLnZR+e7gx0IgHPFrO6/TYvMkK2Bsl3aa34SIQlBYYsBL/wB+iZd3MiYCQhjxNYepOpUqKA81jL8pU+FOWqpUpMMh6rdqUbIItj2dLFGcT4+9rs6TDroxjuY7ghXgh19Imp9crK8vKtp2/oNY3eMcAfALyOkHwahdyNL+0gXEFWUPvPLJ/O1psYalKcv1AF7HOdW+3jhGbbUL7IVSzAqD4JyJyZXnTOH0qgpMYODJ+UgphuoZ76LnVSiW9nmmAMPjMUoYmhyJwvIAt1Z7w5mxaeZcjJMvft7mqrunBbIGL1SgHB3zx+Dk1muid60/7R7ETvzvVYfiZ1kZVjdB3afxzvUVm5JCpzxz3oCo7ZjRy0R782r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(33656002)(1076003)(186003)(26005)(508600001)(6486002)(966005)(5660300002)(86362001)(8936002)(66476007)(4326008)(66946007)(8676002)(66556008)(316002)(9686003)(6506007)(6512007)(52116002)(2906002)(38350700002)(38100700002)(4744005)(33716001)(44832011)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rDatmA3BU749U4E8E2iONuFQJfhU/oUv86AjK/78hzdW6hgOkO2lTL+sdheO?=
 =?us-ascii?Q?s3LPLwPDLZEO50sU5rHZKoxVjTj6hrKjq85a7Y0PvY5jdr+gW+UMTGTNBl31?=
 =?us-ascii?Q?PkjSObVf9Brp8ZzsAEHhuuspPq4KHr4RKLl8PM+rYphPpSjzMpXWaLP4gW/3?=
 =?us-ascii?Q?jQIhiNt9Jh2njpeLvnBeuqPyg/32K8aIUqtdNbERPzUqe+A9pjiGm7RtFu7y?=
 =?us-ascii?Q?YL98g0Cgvt+lGO7DKpVWDn5T/YJ9EP/CORvU5hU0RuAX3Fof/p1AvncmlUac?=
 =?us-ascii?Q?pIXtB9xwy5hjbOAFeVKnBHP3AinL6tK0vcsfz9h8AkpkhWMiqCgboYcHTqcO?=
 =?us-ascii?Q?9nbsCoSGxeCM/nxKdUm+BCs53o05mTo/El7rWEvyr9uTmXPY0ZUKJSsC+Cqc?=
 =?us-ascii?Q?foJRl9xd6xzNWpDaJHsvjgHtYSVAY3qFEpImjZOlRvY0oYuwQa/0fXKrlHFD?=
 =?us-ascii?Q?i1vyul8XIbBqz69jQeaaiiuBPAwLrgAjQGA5qE456H11L/bl0jOekYKBNS0V?=
 =?us-ascii?Q?FCnGg55GypXJUbewpjF9/9xQwcXfzaJLVGml2n/uYJS9ISrJcIm0Swi5AAra?=
 =?us-ascii?Q?czPPfJjI//KxAwhI+doKO60mM0pNGs1KBoeeJr8dUQdoDvVsmDb5lzY33sct?=
 =?us-ascii?Q?9x25XFIhKv2fF0Ud8XTqkDjgV0DCVIVTTSFUhvnhZ5ruXP7joABwLnXW6mEv?=
 =?us-ascii?Q?u/m5+5EMub4hPiR3TjCEPm6AfEYGUsnsMj1dZzzr00lKMGlQV3CyuzaqF0Qy?=
 =?us-ascii?Q?iWB6wGPI1WpuBtAsHZbourhpR2p4jyLhOiznN4G6WR3+vwiJnzSn+tVYQh/C?=
 =?us-ascii?Q?QA/0fqjRye3ajnNXCsKC0gGmmHuN8uB1NhHrBie1uWLQdWyPMM+YV1v91Jje?=
 =?us-ascii?Q?yDoCIR6vtslT+Z1v2F2U5D4EoYOfesW25e4KtYAFZb7f9vap9MMnPlGYEvzs?=
 =?us-ascii?Q?Ca7uqkGilBBNDqavXyKYxfA/V052fmKgDr56IFiqkeeZ9ZL5UN1Vb+Dq3U0Z?=
 =?us-ascii?Q?gboWfl0/LLR5nrAVHybE3jrhRwiIImpKqccpyUmsnbyro2F8BNC2ix84CuCJ?=
 =?us-ascii?Q?zgOPrBAE2wvVwdU3QkpbsmEjLMhzaDyAHf/ghMZyc23f2iHvnniGnKeH1eVA?=
 =?us-ascii?Q?yi+7jQgA3SEwB1fmLTygl/1Y0ro6o24vZptI+UQC3fRUX7i52K48Cj+htHM7?=
 =?us-ascii?Q?xcywVRuAacYJ+gxSwgPa2PamYkMCPD+tbY8XPSE2oOvcBXoqC16h1TKu1aG2?=
 =?us-ascii?Q?+GRswf2arhDMBqu6V1qTQY9RS7JbwCeR/BZnHd+h0HOBoCchjJlVQ0uF4fIh?=
 =?us-ascii?Q?lxq7Pfc250CwBhR4DL7Cl4R7kL/HEMtfsBuAjGIKH/ZAVHg9hlB6LPEPpnpv?=
 =?us-ascii?Q?w9d1sJHq19lU+FOfKSswOTcl7y8hOngzYbvUFHlxJdBUtTwPeY8JMyhzIl/m?=
 =?us-ascii?Q?8gN5Z5kZN8N4PNnu+IndVpLxD7TSFoI0z8eIGrDyc6FRCg8hF7mWCA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7449b598-b1ba-41ad-c360-08da069b7655
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:50:00.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOHZgWrg8pcF6Swii15HbPw3LuaCfFYT0Ap2VnuCikFdJx3NGTKPmnAQcl762ynsHUucvvjYkrk07+RZUawsdRscFAJIJbkjUEY0piRAIT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150101
X-Proofpoint-ORIG-GUID: SQW2Ws-QrwNThD0OLFJea6jgl5MU6NEA
X-Proofpoint-GUID: SQW2Ws-QrwNThD0OLFJea6jgl5MU6NEA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:21:30PM +0100, Greg KH wrote:
> On Fri, Mar 04, 2022 at 04:17:41PM +0800, xkernel.wang@foxmail.com wrote:
> > From: Xiaoke Wang <xkernel.wang@foxmail.com>
> > 
> > vmalloc() is a memory allocation API which can return NULL when some
> > internal memory errors happen. So it is better to check the return
> > value of it to catch the error in time.
> > 
> > Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Unfortunately these patches are not making it to the
linux-staging@lists.linux.dev list.  They are on LKML but no one reads
LKML.

Here is the link to the staging archive.  Greg's email is there.  But
the first email is missing.
https://lore.kernel.org/linux-staging/YjCg6oQcNiGKEH3x@kroah.com/T/#u

regards,
dan carpenter

