Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAC24BE8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355953AbiBULTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:19:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355984AbiBULSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:18:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA41705D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:00:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L9Qcp5022629;
        Mon, 21 Feb 2022 11:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9Rg2P5Phy93+hfW+nkU7m6e/dK/SUr84NuaCgbMfs+A=;
 b=Qhjx6j5zc1Lll2Cp7OZtSKoNCS9KefVZLs0EJ/MeNJA5CY3TMulME70UhWeKXTLOa96W
 kCyzSbJ1+cnO+SnXphcSxJ1AW5Z5zpLfYo3n0rH9YJSo6xfoPskXMmSLmOztdRpae/6y
 jKUApP85rDkpFBZin73MmHszHi8LTKUJdk0xB5qnZ8rkUz7CrOqjkhwN1ylZ+/DhwL51
 do19g6YNq1hnkU/Nh1jbOqnV+rvQonibWGTpFcnDhrr96sFpetCAUrV9iV90NHw17Y7B
 xQG0G2XQ315sfGYZs0NrcmFWzTUwnNr4LNfxlfXE/S5tZFr6MBqHsmjZ2gzBatj09zuv tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eaqb3bwyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 11:00:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LAtVCd055808;
        Mon, 21 Feb 2022 11:00:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by userp3030.oracle.com with ESMTP id 3eanntb484-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 11:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9Vp1i7haxunxSn1zG7jD7ii7lxUUrOCJElOjxuYYzrVNQX7M7Y+PjAidIYnTyZUMdHXb+Q2/0XG0/cZaxvZcI8L9cZhtuv89U01dGJYW7YmTQxVB3p4sFDM1wt1DxBoRVZkD1xImHAkDluWp2gbSPHfp+Otq44SYC4eSG7HXGHoXQLKkicvKrhpvZFJfcNVQXzhBcEJYIz4ENToPP83uJFhkpW+6meg4uvyWIM3zcYJCydAr5UZT7fSdQhOsjYSCiSPCo+kmaMgsvrQ0lE15cfDfaQtOO4Lwr7iwWRjwmJ/YlOlXbQApPac2jwzN3olVUtvzjE48OepDVH7kmqJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rg2P5Phy93+hfW+nkU7m6e/dK/SUr84NuaCgbMfs+A=;
 b=fVkSr0C2mNkON+lp7lcqQVvdH+0Wxaoc/mB9CeAJaG/dgNJnDCgsIFUAMz0praxznhzxmF+q4DATbxyf7jxJh634eAemKHrZizJnSXjhIKGH1oDXV/9Br329k7/7fQQJ4rHKMT2QhonQJ7NswmyXvUP1nyakRvd5HUd2YbnXT+g6AhsqcvaMhGVDiHvoNGfKgoT2i1QgKe5IsdlX6PqCCUEc2AQnNtZwp/DtilEPg7qzzcLUzWNDJsAoBiKwzG2CE8wGJTt0IIrXQcRyfW64ssRW0LhOcCTIiwl21k5TVCaHK2CBYSuUyBg/lvzdTdRfXRoGP+xQZMGHOV8I0rA6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Rg2P5Phy93+hfW+nkU7m6e/dK/SUr84NuaCgbMfs+A=;
 b=VaIDzFc7TkN0hfqCBRV3vFnZyO7pEQZn/Zy7SzE5SWi5YFRmaOArYLHCRO/Jt6qqFcUj1zkHNVDWxfPO0SVnnw/NYc/sRufaUIaAnYWIVP/Mbit0fAPRUUF2Dcyp8Q+o5w0ryPolDAdcEWFTZjsxvQcHq4sey7EAGml3ubH4Z7Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4450.namprd10.prod.outlook.com
 (2603:10b6:303:93::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 11:00:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 11:00:17 +0000
Date:   Mon, 21 Feb 2022 14:00:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: use BIT macro instead of left shifting
Message-ID: <20220221110000.GD3965@kadam>
References: <20220219183234.31216-1-mosescb.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219183234.31216-1-mosescb.dev@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3817fd9d-d3b4-43ff-78df-08d9f52957ce
X-MS-TrafficTypeDiagnostic: CO1PR10MB4450:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB44502167F170C0B1FE3809C88E3A9@CO1PR10MB4450.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9BqnoW6eo5DqMLBBG3mN14BehROXE+lL14n7g2Q3wlHfsS6cotZ4ZKNhAg2GRZTvhFdObSFDvmxzNQoKkrLyUDClYfNxDZEDNmF4LsraS2uDXzGqNdkIQtZi/3amz0wCI7dY5oi2bffrFKAYL7K5/LvBwbGH/b3UJQjEyxP4bpEb3PsXd1WWELlLJriqvMeQVvKPYpwlEKCKC/s9D9xmaddKYId14EiyFVvsZ/Fvq6Oc8ByIb5BsLFzSgp2yoIF/jhMFEyAW2hi7yxt/osGhpFpvujzle4LXONotPq7LdilrVhT4ICWx3F7dqpYfr1Giom+vcJHC+tH97xk5YQanCsABKGOuPAWf4ZJTHVEWrdbwhjiAjqJlT00FdEV/GLMfDJYLkehTLMfeeOWT00zMWxjwSzajrG+JcgEB79oUl3YZIimCnPMvofAHyY4DCvoOsWSC/quq0bfDlC0tvcT0wBsCMBFahYFIe5sHh+JagyhogoO3sH8Qo6iWM2Qx1KhH2vZ0mgEpkIav+LVC+tDfDO6TzbXxtQFsMuQciJIc3uTfs++s7lh8rvj7ztpZkeyKGEaC1+x68q3nfRSNYY7wCaFgqb5p7OwPWD8lcS0ekolo5IJa+HPetOQ6Y5RRVhyS4N3enderwx+s37GQwJzNruVTGUmx+Vuto/zYl9En7SLHQLvP2/Nh7KkFg6ywTTETi9uNWt5iHKUWlPlL+5ndg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(6506007)(2906002)(66556008)(6512007)(9686003)(4326008)(1076003)(86362001)(26005)(66946007)(186003)(8936002)(52116002)(38350700002)(6486002)(508600001)(38100700002)(44832011)(8676002)(5660300002)(4744005)(6666004)(33656002)(33716001)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FDmnKGPDKOnDDva1OhqPXL3ebSPw7rbEfKKtA48W/ZnMcQWbGZCrKbyj5/y?=
 =?us-ascii?Q?nQ9RzopH+m8wHfcF4QtZE/7x5a/1ryJxWu2rXy/D/sQgJycJshnYHg3/Efd3?=
 =?us-ascii?Q?QGmDgzCT+upYM7FVdS02zLEj3AZgMGZaxdfNLRT/D9UVJpoq+AvaeHV7CqMn?=
 =?us-ascii?Q?/3WlSFcqEbMy+46XRZRHKsEkjA/SoaRLvuCwRbQaMQVudiQp+cgCXZoG6lzP?=
 =?us-ascii?Q?RIq0Ncob7OiY9A4McldWik78uA7t5MzvcWEPIjbnxWri4BrHJHHi7/RdDcqM?=
 =?us-ascii?Q?POMqybg5GhUCF0eOsQ7rEMWHJGQhv2AkHrXLphCnSNK/7AAKS1KWg5izxzaL?=
 =?us-ascii?Q?W0XOi7E9zYrDjBYL6VCNamf7+UqZcFYmVTjdmqJk0eR57ldFqNhlrRdAyC94?=
 =?us-ascii?Q?ZLU53PchBQNW4kN/6f/NytQFuXt0RP7tCc42Amp3XZK6dupgtSmzFtIs9oRQ?=
 =?us-ascii?Q?rM3h8Ag3vxdufnTSnjHKrI2IVwpM5UEy0fJIC3uFPPxbvoitjpHUlweogq41?=
 =?us-ascii?Q?SScK20GlVvscqP+1OvnNOnMN1OhhLCwAz1Wg3ji87oA8dleoRTSAYtY9jIj2?=
 =?us-ascii?Q?6Vlp0e6QPP4/Q2ZokSDmUsDOegF7HTfxmKxyIwE2nvLUimLKWDnxHfKPiJE6?=
 =?us-ascii?Q?Is69sONBYgXkeLjbHb61Ocu2MYDmrWo3HdvBCyq2OVnFm/7EJOi4W/W/cyW5?=
 =?us-ascii?Q?RspmRPD+ks4M9sERUiWAm8xzgLWQOAiYNSsosAduQtlt7WezTn4NjRgvl8Nk?=
 =?us-ascii?Q?xKsskc9zQSkdHGsFsZ56tEnS2KMki5wqH3HzwDxOYrewZ7vL5CR0VVknYobK?=
 =?us-ascii?Q?KkL+6IksWwTxVog9Ctw7Hwsa7ODxvgWeZnLOGIXE7dSK+4pu52KZ/RVJvJbh?=
 =?us-ascii?Q?r7HAwlBoQu+gIBPCmxy0d7Oajl7C5Yvc5h8N1cNicWLdX4il57Kq0Xj6uEIw?=
 =?us-ascii?Q?UrLGTuRmO2UlE8rVq3XxhlQLkwAWjYtfDloSXMap/yKPjt+odkRd5G+0Q6vk?=
 =?us-ascii?Q?755+zpyBvS0wWzq7DuS1nhjRibxQykdRcQwVOx1Jw84Wr4pzI4RQ+a3WraPs?=
 =?us-ascii?Q?Faz2798OzS9G5V+DGzQfrPzNCe+dPAFBA6F9Lyw96qE3TqjCNxUMVtMVdywl?=
 =?us-ascii?Q?32Fko9W7U8S6vkANhrkFuA48pgcW3/LrqjrsHLi/YJ4p9K6mi217z8ttN8pw?=
 =?us-ascii?Q?hD56CJPQGUtj7fiDLUuv8cvjmdNmJs++j4HVLOp8cjEwVOHxxkmU9z6YKFdj?=
 =?us-ascii?Q?XkHov/0qyQC7KDH9AHZNdxpw4eHKljsnWAf3vUT7f3NeZ/ljQJdnezp8AC11?=
 =?us-ascii?Q?/LLfAoXKptzeydiBp2uREwuCmeTpXNFC6BmkYeRY7SNwJcX72/1Me1EicF16?=
 =?us-ascii?Q?HkOxAA5rpIFarcPP9krJn19Lil10AfRkazPfFdgNOOBxU5UzjniwB9HPm4bn?=
 =?us-ascii?Q?ZLiEKhEZzHenwkmCTiQN1zTEfKt5CBN+17JV+yISZw9OzZ8VcZdoxu3h4g3c?=
 =?us-ascii?Q?y/Td7yoSQbHWP/2X2/5w7DPWepTpBPS07kd1e7jVIdUhgoIVxnLwgZkFTgP3?=
 =?us-ascii?Q?JOSt0lpTrGpZl/jj8AdJLe3NXKqv0mo4JKb7c3Rd+5fiMwrLcfNuKuezWo5c?=
 =?us-ascii?Q?5Jkt2VtSpdv2oT/JoN0bIYyT01xaVm0BHbEhARjVLwaqt3q2hGpb3RotAs7N?=
 =?us-ascii?Q?R//pjA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3817fd9d-d3b4-43ff-78df-08d9f52957ce
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 11:00:17.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APNSfEgJiN9tkLeJr5tWcX/umIeWWUiRaocjeFkd/5b/Xo9hxr9P8k3na+nN7n6SgBIMoit/438exDoDMxzhcqcB2ChDhoc19kEsAwoQla0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210065
X-Proofpoint-ORIG-GUID: H4mdm_mFc2aCrEXHALFWPZrZh6dEYBZm
X-Proofpoint-GUID: H4mdm_mFc2aCrEXHALFWPZrZh6dEYBZm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 07:32:34PM +0100, Moses Christopher Bollavarapu wrote:
> There is a BIT(nr) macro available in vdso/bits.h
> which is doing the same left shift operation
> 
> Example: (1 << 7) == BIT(7)
> 
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

