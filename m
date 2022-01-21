Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC9495D01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379123AbiAUJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:42:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20086 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231417AbiAUJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:42:04 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L6sH8N017777;
        Fri, 21 Jan 2022 09:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=yOLxxI+B6R9/qGCaTcrCuPNdvDZsxicOcUD/AkAiZ9w=;
 b=pLOkOhF4DUWABxHw0o3YX5GM2TAjwlfqGLaVamsXqovHQmuWaAL4LTK3tfPy76WzjBje
 V0eql0SJ5Sgk0oyo3frPiDjTj+NrsMnBs9nHhkThRwiD/AL5oKjNjIDEUaux/G5xuQ95
 vn+QCR/Gc4vAwtVylUZRKPkfI275E7IpKWicLaMeU0rCs/v7uHT/g9zcOtJJQc0o9nUI
 Rfy1pWaKofW46FCiWw2efOo/7Wwc3uOEb1NZtIJettC5Mp+lD8D1GNEbJFfg7kBgzz7v
 5m6VYNDaxqwZnMRJKlITfmbd6Ub/7Za49AJphEBp864x4KwMvMKTr7MTNHmYA1+6zHEa Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhyc0und-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 09:41:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20L9ejBX124977;
        Fri, 21 Jan 2022 09:41:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3030.oracle.com with ESMTP id 3dqj0vne90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 09:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7bnrT7w5i+XyHWtVqATWY2Y3plsUNVYRD65ltCjyhaLfGsp+RPlboPi5XgYYXYJFtIDnslKcCUeUx/SVq3xrSRXA9m141LvsnXEZnKb+pyo6Q1vlI8qvNG698dxWtGew0WkF4aC3uyGZHUR3Z6vaJopeFpyytPKDIb/d4ZCmZf8g3ORKBoQ/NOZ4hMktl4nbN6C6Yxau1Ed1KLqLgWUfk0fRurgMqJxzoPnDZPkOCR83/MPmXvJ0U1ZepxMJbSRWvecfdkXmwwz0rE0v3JgKLCUXU0DG5w7LiolTpwJYxG39v/7/NjIlw7iPPAW2OkNqDUrXsQeWmKezbhjZorfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOLxxI+B6R9/qGCaTcrCuPNdvDZsxicOcUD/AkAiZ9w=;
 b=VxGh5gREmpxDPg35cB+KY+JkOIA6Fx+6qANjvk+Cr1FKJilCqhTvCKaENU2g8mQpZ5/mNkv9cnIKCP9Qw/LAFao8mPn4vUoj6E/AUdPy5KyUl9CkuAFJ3n7s+0nZ4skm7Y6jDUlkTGMj1zfOjK3IakT83ma6TlOs8wreeEejzglugJhSG412muRDuJu1fr6YcQvxGOUUeVMT50FIUZL6NDUTBbKaiWAVf4WpoWmLjHnlPO1L/Jwb2//92/I0S9uFtThPnZ3T6iXfBgzksZbrUEUPFm/ju0kjRxJQv2wRvbkM3ofdEBshSa8HeFX+15YeSWcDFgjbfCtCRB/rEC5JdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOLxxI+B6R9/qGCaTcrCuPNdvDZsxicOcUD/AkAiZ9w=;
 b=tDZPTNml1EDRPdFowGR3TQ0FAPeiKH2LEIeqSLrSVfLUq1gAyDvyJb49UpNYPeZFkwx4/gu6orgFu3XGDF8eEacdgbnDI5KpUxY/sds3/7ObSwjWzU4nOlD2FNlzpCDc9TWgHkhxYuodmQ9KT5DiCryQB9ETW1E+qgM1X9WsV+I=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CH2PR10MB3784.namprd10.prod.outlook.com
 (2603:10b6:610:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 09:41:51 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4888.014; Fri, 21 Jan 2022
 09:41:50 +0000
Date:   Fri, 21 Jan 2022 12:41:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: media: omap4iss: Use BIT macro instead
 of left shifting
Message-ID: <20220121094129.GN1951@kadam>
References: <20220121093722.320082-1-mosescb.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121093722.320082-1-mosescb.dev@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5981b4e5-242c-4a6d-0217-08d9dcc23fd7
X-MS-TrafficTypeDiagnostic: CH2PR10MB3784:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB37842DEE1F86BFC45A3CAF588E5B9@CH2PR10MB3784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htcfLEWagaR1SxJSEsk8ZBs/nZvuOJkNI+ovmTT2AttKaoU1FuYXhZQyUU45Ie9ZPedBxvH15VDu3cfDC8EMN5tsdhC/hFWPvXji4WkNfow7vkSlWWDTN5k7Fh/mBvVeXxrxemBO0VzO9yqkoOwIearORBrLUfLmc+ScOKmD5gvqRvASFB/OYwVcMDd7aaIFjUXgOqGtvrhRSLVyPJtIsErQ6FQ+GN3MLzNp4hT3bNIkLOsYl/9ZFfe6Rqff0MzqOUsaoFldt1Ldq7pgo3KKnrtu0b+gnQKC++mdvj2guTzTrUPz7amFGLc8wS1lX2OWgXS6jgry49kFDz8Sy7GER3fcsw9LvTNDwbBinnDsDXjdrNmAP+0AhZ7Qjw3Wfzz+vk02+vymT6S6p2r+S3j5aEd17vsExDiixkkp0xzdrEDPhAxlUdMA+HLGU3mipLTbgss4jDqgkJtjsQ8/NFS1MBAockEC3hdzrfNJM8f1H4Er5FpRlwasxBVUhkqoqXquSJEgBRaF5J1TkY3AqXX6wFTWgnSx9kuJl1/yMCONYuTi/mh2tj+lgL8K01pNE8X70XmGIVx4e49g5tialeMyqjuR9yRQwnFCAp9misPQx8tQ/uNJFAmX3YmDryXx7P7RvT3c0Si/eYnfM25C2vamjpTKWZIfVXFehOYXTW96OS+0lEltQo+wq1IV5kAEwDgW6iJXNdNLaa+EKhD3QyBvZPzVoEA0c2ivy0E2H5UBs+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(186003)(52116002)(6506007)(1076003)(6916009)(83380400001)(508600001)(33716001)(2906002)(8676002)(26005)(4744005)(33656002)(86362001)(6486002)(44832011)(316002)(66476007)(66556008)(66946007)(4326008)(5660300002)(38100700002)(38350700002)(6512007)(9686003)(8936002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6THzXAZ7VtpfV3WJygsbTZ+vqV1xoAi8En8uO1ICzbC8AhbWna9ZPKje9dO?=
 =?us-ascii?Q?9ly7kMRcJ5U+7KuUb7HEe3UZd07QgpmnKZ2RddLtYFQLxAUG3S2hefS0jK6X?=
 =?us-ascii?Q?f5M5E4N5kOBQuq4j0PxuhWv0xxvZnPNz57AvUnyVF+20OXCSSdG1Uywx2hUW?=
 =?us-ascii?Q?qlzKdZq0S1RMiQOKBfmYwYryQ2DFTyn9O1OqeRi/2AlEb8L44SnkIQwco4qe?=
 =?us-ascii?Q?nrflAN6vNlBb4cBOvl7higA0phlAdD0H9T5K1go3NrPiPmNpenQTBFNvsRT/?=
 =?us-ascii?Q?3LP1jlrJpjndhe1zNNcxUaqESy7yJObjpaEU7VLVuoMYxmSVm3qKXOTl3D1I?=
 =?us-ascii?Q?MyDCM8iouDIOR2j/lWr6OEg3EhMKgIldYTSPszu+uuqIKkercTsOctzEuby0?=
 =?us-ascii?Q?RUNlJmJhDcL4q/DqZdxR51NXU9/A7+hzEOFz+90UHq03wppDGvGy4RQo0vXy?=
 =?us-ascii?Q?pLr7V5gZGsUAoc6Xe83AmC0qHO7cqB2fCY19OCD+EKwHMy63GhgqV+KetoeJ?=
 =?us-ascii?Q?SPF4Nbd9WLY9QgRshK6p+m5LmKA/QQ7LKuH2pp3tni9Kl5HA6DLFyUU0DbLO?=
 =?us-ascii?Q?hUX5iK2P8fFr/qsxLeracOpe6m23jausRQ2mAkCBAqM+MlmmnGFqRiP5y44s?=
 =?us-ascii?Q?lNx2Pf0LNaZYbTrD/oBtqsIxcxgXOn92306lDs5h3no1Inek4nAt6HTdIGYA?=
 =?us-ascii?Q?xEoLd2J04a110r+jPjwnMO3aXlzKi1km6LvXP/CeoifwuSwz4Cb1k+3Vhbe4?=
 =?us-ascii?Q?Sh095lfMsFOYJa8LwU++pFGPRIcwHmIHngM+urdue+58ElrGCHpwkcdkxIgZ?=
 =?us-ascii?Q?0dG1u9hwg49sbh4UISGVODjh78qEhmGQ9eKysc+VFpDB0AmzngJpqDG6x1NH?=
 =?us-ascii?Q?qkvwz02u4uWuTC8tC/45siAQF4t/qr8IrPqROs70Qr2+vi09nhrDkW+ouAni?=
 =?us-ascii?Q?H9wzHSkE6hpXQqkXZvFLk4e8WLY4luPfM2RW5ZYx0KoYmEjVX6tIt2NhZiHM?=
 =?us-ascii?Q?kWsRW+m7leyIyTwQrT7vaMLIK6J+NYRp06QI0Em0uZ6DC3cjG0ihDj+j7Nsi?=
 =?us-ascii?Q?bvHt+RoHe+4n784K7mV2bcMkAvKMaAHXJ1p4n/PW3QoWDCDY0hUyGBPpz13w?=
 =?us-ascii?Q?4JJ58ngVaxyWOZoRg3GmjtuN829alvHz1MDh1WltmNa0zD5Oda7e8TDltauk?=
 =?us-ascii?Q?b8F7ytyx9MqdbqDSHEe0nc6Xno4zGUFnxVVAR9bwkVlHXn9E8cPnuG/GWgS3?=
 =?us-ascii?Q?nOwxaiGq/md4CRHvIXAJQB8xYMU2RUBUmSAhZKtW3fMOrKF1wgiacfT/oNr2?=
 =?us-ascii?Q?K3V1bV+CZfE/d3O8Ugn5Qqd0AuDKRqZ+Fzc5g9M45vslIkHYstWZLoHoGNoA?=
 =?us-ascii?Q?0TQGt08uZSIDSSByqXkpMfYq5sDObnNNIt9gU0Q6lu+2ldSMHH/oJ50SdUyU?=
 =?us-ascii?Q?9GKTtsO0mQXb+xX39oH+6gFu1fQRSi1byJnzfhuN4+QsIZgID4poAzBC5VEB?=
 =?us-ascii?Q?XBZ91aGcr/niZogEDNfQ3eSjJq0uMUyedeuI0rrq3WodRGRcs5I7MOPKL3DX?=
 =?us-ascii?Q?r1vEhXMeNAQeo3XQ+C2SZ6VTyn/wyP4SPK5JRFe2siIaCyifYSvhV8MG2IxV?=
 =?us-ascii?Q?/ieavP+8zIigaaxDSb28uLiIVI5qWveIH+iSKb0+dFdfEuZ+thHff+MLoUXs?=
 =?us-ascii?Q?AONTpsZ9xP+DaGQqoIKTIz7ycEY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5981b4e5-242c-4a6d-0217-08d9dcc23fd7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 09:41:50.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sG4eWCKqW/6vN9lN8TuzbyyIucQAk9yK3+FYcmPvdloY0qr7GSw5ns1UY0lv40KsVeqCbYNVyDLhnsRm3JwTFpHf2jHGo0UfmCsIJYvZYG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210064
X-Proofpoint-ORIG-GUID: z2ae2C-zfnt3kBACXdsfZr8xbczvy96e
X-Proofpoint-GUID: z2ae2C-zfnt3kBACXdsfZr8xbczvy96e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:37:22AM +0100, Moses Christopher Bollavarapu wrote:
> There is a BIT(nr) macro available in Linux Kernel,
> which does the same thing.
> 
> Example:  1 << 7  is same as BIT(7)
> 
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> ---
>  drivers/staging/media/omap4iss/iss_video.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/media/omap4iss/iss_video.h b/drivers/staging/media/omap4iss/iss_video.h
> index 526281bf0051..ea1cc311384a 100644
> --- a/drivers/staging/media/omap4iss/iss_video.h
> +++ b/drivers/staging/media/omap4iss/iss_video.h
> @@ -55,17 +55,17 @@ enum iss_pipeline_state {
>  	/* The stream has been started on the input video node. */
>  	ISS_PIPELINE_STREAM_INPUT = 1,

This should be BIT(0).

>  	/* The stream has been started on the output video node. */
> -	ISS_PIPELINE_STREAM_OUTPUT = (1 << 1),
> +	ISS_PIPELINE_STREAM_OUTPUT = BIT(1),

regards,
dan carpenter
