Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056404E4CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbiCWGx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiCWGxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:53:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4D71ED7;
        Tue, 22 Mar 2022 23:51:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22N2OeOe017302;
        Wed, 23 Mar 2022 06:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+fudnmKkJ7Uy7IfF9nWwvy6585PwbIkoAq9ENd5DZhg=;
 b=aeiEqLBSudcrHZQcMRYzWhLHmWY2F9ifRQLiD82Cnbx84osjutMs0rCXRNjBfNLTHgBV
 yTdngNz0GzKKhQ3aw2VwO+Sy/L2XEiTHnVOfnERQsBsJULxEX6XWLSvs8iSHcpfwgS41
 vSHy77wzKjR5n+n5/ibWurcC4/uzdAkKLUHXUQKxG7IqsPo+oXYGQeREFtO4klkJmtQS
 04oKG72UcjpnS4hcGTOj3nOJtmB1CmGPA+FhEd/nAnBmiMnz5nuiwKbhmTYQANpWyVFU
 6bb0xBqNJzf5yAPrLak4jFY4Dksxwx6505FEGn6QDqGsHEvIXXfm8O8oDBuY6NHnKJqS 6A== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcrdxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 06:51:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22N6kmsD144641;
        Wed, 23 Mar 2022 06:51:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3ew578w979-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 06:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNb7i4spxrU0ooVpvyRk4TfPxA31gPcY0an0i6xuFQNBchfq31QwFE0x3gDd/hY/EAFmians5rdx0B13HeaR7nIzC84+Q1Iq25zvGGrKLUO1kZ4b3Fd280Anb4iFZ0v393xBfvJp5ibfEwi4AR0At1itlOVCKBSSu8VaC3r5HGNtXsBn+tqxvwDyl160BPFxJAqNXnYmSOyBxLV6GMqAR2Wn7BQ0HK0vHSlVyk7Vpcoe9PZwDU9+1n9Hasgbkogs35PSST/OSUGFraVNTCudcdXqsrKf47EBaV4i2BVMY5Jq9nsQnWTh25Wf+lzHTxyxCFU63qZ6cfLdDja17PLwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fudnmKkJ7Uy7IfF9nWwvy6585PwbIkoAq9ENd5DZhg=;
 b=VeoWS1iLuFPdNpvQqRIPvFd+keJ95Py0Ns6r6o6OXB3FXb/0R8hfOvNmzlUbGrlmqnjLha3KS7//LlCMx0pX8SCAWyzrYCyTe1I8pcki58bBla32aJUVP9b1ih5c1RmM+ijFMlEY7csKzn5HGHh2uQgUdLEecJ9kb2JUB0TOi+z29l8rfwyoiN8UMYExHNJouMD0Qfc5jOhTFre5NaPDE9CDEJ6Q/PLlhG7v28pIkCV5T0KG+3RxRiQ84bMb1QZbbnToEMYA+wbVtQhdzP3LtqoEuWr2B7pLHDDE7M1hzmMlPpFSSoXJxCJVlShcJFlbMk43IKWkgp1u2AQPDJIwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fudnmKkJ7Uy7IfF9nWwvy6585PwbIkoAq9ENd5DZhg=;
 b=ryb5/IkX4QALOaSnRzMu46wxqqemJPh1vUw2gZobsmC0hVoz10JzayHChgM+1TE+05+Qg+haEdX718eiv55sZTVSFcrIJZPC7rw0BVSQIfBkMvjG7oJVB9yTMw+sQHzX4IIzVJuAvAVqFj5uWezjEy5OqfH/6ORcGF6DMTjDvJs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 06:51:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 06:51:31 +0000
Date:   Wed, 23 Mar 2022 09:51:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] ksmbd: Remove a redundant zeroing of memory
Message-ID: <20220323065111.GO3293@kadam>
References: <f8f1f383c4533a91a6025b1db5827ed6aaab002f.1647980983.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f1f383c4533a91a6025b1db5827ed6aaab002f.1647980983.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f86ed4-2caa-47cf-85ce-08da0c998ff5
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2975AEE21A2F92E02662D6A58E189@SN6PR10MB2975.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgXY7UJVwM0a3w/5VPAwy/fqWxU7vWg8gW4WgOtTE/AegOq8enTsGZXFZEK1EAx6E9ltesu7ouOb0jfIhs7x+VXAnoDnzYTfNkIB7u3COwZcwAueqHPnZQqBL7WpF5ojB5exh7vSwWIpXsQgfNqBZBQfFzMRyozDR9kdldnAukZjOTy4CdviGEgUxsKjCIGeKNYBkkR8HI/4X9QfzQITW8soL9pV+pmrWVT66L9TqrSrbeyrnKXiPFOaynapuc2rIn3dqfxx747He04DhJOCrjI0BQVUh2tj600TncVb5zZfmrNMwvwnfUUARNDKNsRB8vNtMVac3kEkZ02hjNd52Jx+2gynYgugC2PCD1xt+JKSXQUp73VGTCNEHoCjE06PHHO2nKLAsFdPcyWbw2wGwuGcSWQuGwZIUfRjZbt85JqovKUCPS7e+NZ3ZYb24Gjs2NGd4chsu70xXZUKfxDc0ZUfY06tukTt0skE3E3mswvCRGzQ2lRaBxrViSTb9TXfI2GYqBAZDciwylb+6BVJzp4JwfD4kGmpj696n38qr6JDwhhOKlULGKxv9eC9H/+oXF4SDmX2knRL7nMHYcdvy9k1ENS8oEjdhaovdnWEAXvMcWrBVWs+dt4YEIZhbZKI+pEM9MB8+cU7yublWA8Jgi5F7b3ZcT56sdg84RFIKH/36hELtof5FlJ4QNExziHDAf69QSurRJtWztxoO0VfEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(8936002)(66946007)(6666004)(6916009)(54906003)(33716001)(9686003)(6512007)(86362001)(66556008)(66476007)(186003)(38100700002)(8676002)(38350700002)(33656002)(316002)(508600001)(52116002)(2906002)(5660300002)(6506007)(83380400001)(6486002)(1076003)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVaWIINFOahwbDxY51O+8KdioNfV/aUXTVuK4YlzCK0/oRwAIFsun1r9AkCM?=
 =?us-ascii?Q?wF6YaiwOV/wVhv+sa5oL7W+GRatg1V5Soeje6CkUeB5TXwasYOmp0q2q53X5?=
 =?us-ascii?Q?HehHbAvxRE29XSwLGu0Fb7yTHGNC5yiRPooJkekFuTqVXFsAaMUTZOdDLFGF?=
 =?us-ascii?Q?F2qil7xSG1uwwEDFmjRaf2HgE8dtItRxocZXWD7MTAsJ5iD7BWzKIWpU7KjQ?=
 =?us-ascii?Q?BrTGUKa5JnQMWQmhCkZgDIvHOlJwU3AYA9e2KRS7X6kDVggfxyRIr/pELRci?=
 =?us-ascii?Q?jCcNaxf4Ey7HfOTxcgL+KSfLFjKWfnZV9qB+cZE28zRoVwsMeQe4HRCs7FXP?=
 =?us-ascii?Q?OVmvC57GFQh6zvD+9WZIY/Iurjy+HV965d78LKd68ufX/s54HhnexH1pW3Se?=
 =?us-ascii?Q?AIj9lKPdpidC6v5fwWO8gzqSiapMlfRPltbIlndzUfyH/mUCbeEnutgIyzYi?=
 =?us-ascii?Q?GgV5CaGeDxTU/oSIbWjJfdyabGmSJwWnm+ffE05VzeB4CHC93J+mw2Yjb3uY?=
 =?us-ascii?Q?kEF/na66JqzWRLLSuNf0ppqrH5SrjEr1neHA92caXFua0PkfcOBbTEPibDK3?=
 =?us-ascii?Q?rZXhNJSYCaf4LFudIMbY0f+V+BcoWcxs8Uo2a/Ay9KiL7iXrs8kBKNKOs+V9?=
 =?us-ascii?Q?9KFIkl8tRswJzsqYe+atmpSmw/77SA/YWAii623/gqldizU+ZYDojqI+I7Rg?=
 =?us-ascii?Q?389+/xnrNjZzMUgM9Zu7HdCHcuPB8I40y8toWJ87W8/cxNGzp8hlnm8XfwII?=
 =?us-ascii?Q?xoMedWzm7mFlt3pjjiCKp9lL4FKlNKhnZFKHK+f1Ct70kg8phyJD+1A4b88w?=
 =?us-ascii?Q?OzT/IGHT9VH1jpj95BLujYlx4ZWSpCvuxXSnSoAJ8UPvBbg7PH58BIsoaemQ?=
 =?us-ascii?Q?oV2p7LHudUvwTZAky/RCVJBikc9yODBOKD5+Chh5GdlRdCn8JzuXDYfypCFR?=
 =?us-ascii?Q?ibsTFI/YzxEqVEYbEZF4cRsxO6cQxcNvzg9J/hSpjS710POUzBwAYIZ4m4L5?=
 =?us-ascii?Q?HRpEQ1+GTyBknsrklOAklZU4FkdHFF3lutlWHK8nlAnCNn62Qt3CwAVEutzm?=
 =?us-ascii?Q?uK3KlIG7tKHsPI3Vl5KLMM4xUfNzWaDecAO0QIShk1mr4gNNVlXHND2UZ73k?=
 =?us-ascii?Q?W5lpaKKzKLBf3l5oescYcWrSFFhR6OLsTqxwGWYHnS9+Hdu3ZXKmUlfzqGLy?=
 =?us-ascii?Q?qtBRcB4gzuiwgeRMsNZ7c0pZ/SDdnVOQF4Iy4h47Xoa/8rlf6ZrhUBVzB83z?=
 =?us-ascii?Q?eZRipX/E/J1E8o6H3Sg/shylRTvaQ/JL6sx0w89yApn0eme43Vn6gd73ADmB?=
 =?us-ascii?Q?yW/Ahe98/NRNw2OFjniVwR1+Y1U6FqG438h7XPPgrLusNC0JzfJi5LIGN4Lk?=
 =?us-ascii?Q?+l6bv0xuVA1SFT2XTvdPAOKvyQ+0EQ60KnIpoXsiIQLTHQ7YjYri6nuPrGXd?=
 =?us-ascii?Q?pN7lsjLUUWdIi+rerS4WwdRnLx+ueBuck3blnaJhlPtcTeRNDDZUmg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f86ed4-2caa-47cf-85ce-08da0c998ff5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 06:51:31.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQWqdDHCSJHZRTqjGkifNaD9BqGiVgk/kVO4348XQz/UUZYigS10FAaahf2FMwFiMmje8AKzXeMnDJZeqTnfZeh8xlzAtVvqIbaRo0VItZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2975
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230038
X-Proofpoint-GUID: D02bvtlzgTBq0FFQQwDEt1bAZM5VZSwD
X-Proofpoint-ORIG-GUID: D02bvtlzgTBq0FFQQwDEt1bAZM5VZSwD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:29:51PM +0100, Christophe JAILLET wrote:
> fill_transform_hdr() already call memset(0) on its 1st argument, so there
> is no need to clear it explicitly before calling this function.
> 
> Use kmalloc() instead of kzalloc() to save a few cycles.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Alternatively, fill_transform_hdr() has only one caller. So its memset()
> could be removed instead and this kzalloc() left as is.
> ---
>  fs/ksmbd/smb2pdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index bcb98109bac9..0e4f819e5859 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -8434,7 +8434,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
>  	if (ARRAY_SIZE(iov) < rq_nvec)
>  		return -ENOMEM;
>  
> -	work->tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
> +	work->tr_buf = kmalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
                                                                 ^^^
fill_transform_hdr() does not clear the last 4 bytes.

regards,
dan carpenter

