Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3BF4D9F61
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349874AbiCOPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348769AbiCOPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:55:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E36551
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:53:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFe5Ix029153;
        Tue, 15 Mar 2022 15:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Oo0Tu9svc+ZaGbrG/otamT6HSMlTaaa5MsLZi8wtQoI=;
 b=EEPkWEdlm7YHTl5j0Yx9o8g2BdX7oVR12sjJE/o/Q9OkRFIAW8wxJfB0dxpM/ktFZuEN
 RuSUpwHWhthM6MvCvcfcVq8BhHVjY1Ftm8KIhEAFIsj85zuquYU01QkZB/Wj7FLjMaK3
 4j9y7ZcYGjHFLDHCu3olXJIbMdv2PC17fld8evAa1vXNouqai8xPJInw8a9s9R3/UhoQ
 TyVNxmftJCP+9cII0vDeW+Mp1u9T+C65RQnA3PbcWETJf88VuOVYYihsGeosZ5NKsXsn
 2GFODpRNeAUQP3zvdJzJkkgd+yUpEuiKBFAbpIZRoJQSQz4894QaME5dCc77SWWnpbox JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwkf6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 15:53:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FFWFUu077077;
        Tue, 15 Mar 2022 15:53:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3020.oracle.com with ESMTP id 3et64k2gg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 15:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjtufqiDz+X52N2L+V6NBqrt0fQK+TDESHzq3CELcS76ALM3729IkjbUfx2Ljx9pLytGWVhRB1L3cLHxF5SstgXZuB0siIJqsX2FPCWYRXQbmeb6kP2IP5nV0T82J4VQDVTJzzL73LI8plouPKzv8Z3GcZhXpVgRLNfANFxRdwuQBJKKbtr8furvz7nFmVlPMQ2363udaX8kHxC6xVR9JkLXqCXwEwL9xs/7x5qKdK815wlU+60zrWyNYguQxdBwKuV1Ta2IYHT52DM/tFXYKgVG6cDPfhld+GDur2fjA39rVBo3e5A0NadOdI0V+4qXSWueLTa44pKfOZHXgjmp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oo0Tu9svc+ZaGbrG/otamT6HSMlTaaa5MsLZi8wtQoI=;
 b=KV7fPN7rZGstX/PJoST3IwqCY5muKylqbWgrhyCnUCWKEy+dWP31Jbvz6OlVkfyRsoNJYyi969O4KgXslLM1UFnEjx83dx95CVjWneRDsYAajU49+BWXKMWcrplhPdhGDdZUYglLv9XdfFSX6MY1eDcZ3nPqeQnLwawEftrG859FmjVbxYH6+wfSRtXqTbsKzGHWj7THLMCIEUkvEO28vaFJxRxSW5my11Kqj1S/uiZo4W2LsjoIdS8d6llTR4I33deyTWvKmj4/F9vLlyxkvvnA8J8epBM6uErcXE+XZFxKRjdOy36PWHr6AylHIfU5S0JXPXJQ6jIzMGaZ7mgohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo0Tu9svc+ZaGbrG/otamT6HSMlTaaa5MsLZi8wtQoI=;
 b=n3FEED09wbYQ/FSxWw6/NB34f3m213nr0U3TjWfRyBsZxgC48hnpvuKejUj69mbPObXYpfDRYLlVhgYJMrQC44PjnCU2BiweGrmMzS7xJzaQnFDBJPnsvgDwI5WnlWwsqSE3m4b4lrRYjNRKygfKQGYqG20GE3HjyN0WPnknuDs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5676.namprd10.prod.outlook.com
 (2603:10b6:510:130::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 15:53:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 15:53:38 +0000
Date:   Tue, 15 Mar 2022 18:53:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     xkernel.wang@foxmail.com, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: mmal-vchiq: add a check for the return of
 vmalloc()
Message-ID: <20220315155314.GQ3293@kadam>
References: <tencent_7F2A8AAFF05125C6FF159033E69B5C108E07@qq.com>
 <YjCwagaijyA2oO8r@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjCwagaijyA2oO8r@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb44bdb3-a70b-47d9-554e-08da069bf894
X-MS-TrafficTypeDiagnostic: PH7PR10MB5676:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB56765D286EAE46A9B865F6CF8E109@PH7PR10MB5676.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tq0SPJaUsBXc9uX4klCFShYohr4Iu3UkYdYsoe+i151ObybX+7vJz4DfDPrOSDKFsPqHHa/0ZKLqqM7MozZo0IKP48rKOEPM+40ACZ6PUYKmr6XQlMWCS3xSmT6spCbK1+TkvR8XZN/Ipu1ygwGrIwASUmiSwP/2WQCj2dn2rcV2Uem9F8rx/XRg8xCK6JDbgRbIxvH6hZ0U14HkRKNzStiq0j8f1P0ejK8E9/r77Q+LeQ0CPNLlR854IxMFvWje/aYL41Y7DfmfBYVO9xnhmXYlNf+ExufEhj3VfD0AzmrEcxpNQ4Zi51fsK/e2uPHlwg8/AF6YruMgwQhSAoTozWdrpOWGGeEbXzp5/vfKCz6zPX92hNLtb3nJ6cOHqrGj+wbVcuqFi0otb9rN+aFLh1ACKCsrt1GHu2d2reDLw0zNCyWzQIaWu9TGbu4gADqpqmGeXlWk17kfSsPTysDj8ikfQfRpJBEln1zujI4egzW3dBronEAj5w+TfUr/6f12GxPVvFFClhZjNqlkggtwiQdNHRWTGE4BPMhzCz/72vOcNDYz7Tk6vhKFWwYo5GbiCgmhwg2wYgc1j3VoHvt6ZqD8E+jImS/7Nx+P40y/HGuf8OpWtxYDRc1GX6zEKPo7VMfmokRh6ObIHu3r48S+U0GnJUJHVjVfKv9RnIP/SopeVgYbGr/td0YfN2FxYbj6HDFLAO4XRG3Xna32B/Y9h43635oReZi161ApegdT9is=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(33656002)(1076003)(186003)(26005)(508600001)(6486002)(5660300002)(86362001)(8936002)(66476007)(4326008)(66946007)(8676002)(6916009)(66556008)(316002)(9686003)(6506007)(6512007)(52116002)(2906002)(38350700002)(38100700002)(33716001)(44832011)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kt9+YuVtDlvHybPkD96OrDMqITHk120nduVTncDhFfwG2D6PH0tRZZb/S8IJ?=
 =?us-ascii?Q?OVgenouFNEB3cmavrIlqzADcx4IWrI8i0LtlGoKmATAHhgFoEdJCj91PH9Xr?=
 =?us-ascii?Q?TPnHttlqHSxKZJG1U6MMiJ3ZfJ4jnA6chkzlnJ5AM7SxiI7Zl0+CslnPhb7L?=
 =?us-ascii?Q?OZfIqjF7VJIE5GJC/Uy7+jO9pyC/jrAfjjUZO1FLhoykQH2Is0x/TR6XxOKh?=
 =?us-ascii?Q?sKdi8BII1EempDPElzkkBkgccSkQJg8Pw7Ltn4t8wf+MqnqOH1vjsAMcs7xJ?=
 =?us-ascii?Q?Q8IcDXP1EWIXeisWTAiUgwXFMPFhuWiDc7u1dvqqDTOcw/nvhW2UHj0LWsA5?=
 =?us-ascii?Q?DC5klAc+Y7c/UyYyT+tx26z5pgBDoqQwp/kpz3kxhYEJMy4YrLoqmv4oLlTd?=
 =?us-ascii?Q?k8e/E1xfZFNdu+H5kSyl3S6oIXRCso62CTlCOiW6LK1TTOvKHcUbjtkQ3GU0?=
 =?us-ascii?Q?2z+Sbq+D9tDTaWYFL3KrpK7PEfY8F3MiCWdoLx6+tzaXTt6DUZs9iYu4GvmB?=
 =?us-ascii?Q?E7A6grSaZkQNIvlztuCmZTkHhE+vEXkkssmHPQ5pHl8q6KcyaVkuNnTnjP/k?=
 =?us-ascii?Q?E845m/kZSchN0lqHAYMTb04bvM3eMMRt9hWXXgiq26ivBAwYDR1YxZ/OkM2z?=
 =?us-ascii?Q?TETqbOdUTlchr85YEcvK8gw9bX01Xesiq6yNBJAs4NkyC8EWhTORBcOpzhrW?=
 =?us-ascii?Q?8VoxRhRTRe7o2dStrevBjbS4F8O4XUW0AkUtdMYZ+iHSYJz1D1xpUK6kJvFg?=
 =?us-ascii?Q?X9FqrJ4XptEOXzJvPZoS7c7/32rmXGPcWy4UCtd1dpCFF2YG/fDN5PYCGkmU?=
 =?us-ascii?Q?cGqnGrQR9X03ZC+yJrN0GFJaAVQumCdIJaI7lsYkZL+W0wc74riHifusmgyf?=
 =?us-ascii?Q?0xh1GVhbUw7SZ9eRYhqLr6t9DUzbyliVmfCn5cVSOw1G+kvdgtgKWusZ1ykz?=
 =?us-ascii?Q?Rf/oHLt3DG3u2mG2JGBZRx3H1+bxQ3h5cnScuWqTFNazV97vU0t/1Xf3srts?=
 =?us-ascii?Q?15Wa82uusdcVsuydj/6uIJRkbIjdXLTnFQ1OS/KkgS+yHOXXlwyBQkthCGhZ?=
 =?us-ascii?Q?8rRpmeMIyd2737OtaW4QGyTqQDwBcKL5e0VaQRCnq/p5pbGTJrFsbjowd0dy?=
 =?us-ascii?Q?WWIpIcVWC4xavesXv8WoI3WLZ9nUUebTRm0Ph8rsJKwQeAVoj5ucfc8GdHTE?=
 =?us-ascii?Q?DiBfeHn4SZR9AuKFPzR5+ntUSh3hmImJ5PHkXfIeRx74EQ/F+sYHFWIJApcJ?=
 =?us-ascii?Q?j6i5F8WI7qx+OR9fm43PqN5d34XwYvx5uIiJTgx2x8bJgI8u4jyAdSjohEOw?=
 =?us-ascii?Q?l25E7ZoyFCaR+zaO5Whil7DYpCBX0Em4YQNuLbzGeFrJiCDpiBa5QpsuxUAp?=
 =?us-ascii?Q?vYkJZTTqqOQaTF2vEl9/6dSrKQ4LFSisoxoLyoGLo47CkfuvI7bmeR8yLxzj?=
 =?us-ascii?Q?5iWRLVicGaBFIm6RcGARZBmqI6SNlmVnSuWyuROKMzBNUUNXteloxw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb44bdb3-a70b-47d9-554e-08da069bf894
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:53:38.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3Fzls7eSJyVCUl5DAw3a/9b5Cs0EHNny/QmoEJrVn/claEnrCupL6W4RCDOdbPq2I1p3dQu+GE+/jETco6lITF1/ow2akFJ7IWx3j2nuwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150101
X-Proofpoint-GUID: _VRywCmCWLGFr7NgYkym4ZIxOECg588V
X-Proofpoint-ORIG-GUID: _VRywCmCWLGFr7NgYkym4ZIxOECg588V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:27:38PM +0100, Greg KH wrote:
> On Tue, Mar 15, 2022 at 10:42:07PM +0800, xkernel.wang@foxmail.com wrote:
> > From: Xiaoke Wang <xkernel.wang@foxmail.com>
> > 
> > vmalloc() is a memory allocation API which can return NULL when some
> > internal memory errors happen. So it is better to check the return
> > value of it to catch the error in time.
> > 
> > Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> > ---
> > ChangeLog:
> > v1->v2  jump to the proper location and remove redundant instruction.
> >  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > index 76d3f03..ff4b484 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > @@ -1909,6 +1909,10 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
> >  	mutex_init(&instance->vchiq_mutex);
> >  
> >  	instance->bulk_scratch = vmalloc(PAGE_SIZE);
> > +	if (!instance->bulk_scratch) {

Is ->bulk_scratch even used anywhere?

regards,
dan carpenter

