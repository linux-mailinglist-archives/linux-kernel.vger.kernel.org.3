Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715B64DA0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350469AbiCORHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350463AbiCORHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:07:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0215839E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:06:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFRoGu000738;
        Tue, 15 Mar 2022 17:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=z4vkYyhYzYITGCs0i/3d7ASalLJ9+AdE2iEYi1sOY9c=;
 b=Bxfre7iSpDIFEu1eb0hQpR4qhB37O8Byj8j3KWc1/rMmvV64xJLLMhk2OcGL59tVtDa3
 nUX3jiLbsVso5vwO3GeVS9ZhXhFkPMZMidwwQNP5gYW6pjJOx1GnhJoOqoqk1ZVsczjG
 JNKgOBRCMaRUCAshjkxqCKKxnRvTpZOoTQI0LUNG7q5NY5xr0snEt/IAc7N5rr0vNsnm
 GKHZj18+LbOWa34KuZHNtKaIpo9dqX0aIFo5bH3cBmPQyXkpcwGbrXAeH3/dphQkB+my
 WDWka2L/j3ac5Zd5Vv9s4UbKpwDgOAlGoBHqWXYolHaiXYEXalpplPtsFnEFBwUQtzdM +A== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu3wb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:06:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FGk8fl003408;
        Tue, 15 Mar 2022 17:06:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 3et64tqa71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQMd74KGLUpQ3WjygSx32cov7PxUZgewUdP2/Ge3eNhonW6UprwNeilBgcqkjEaUqv0YUw+50TWTfCsL4Sz6Nkmm/6tHiOc08gYago3kwtTaqxnm421Vo0Fc42UCoTc3T8JkfVh++bc2c/wlsue2NRbwxR099aLwYNh6F8RdUUPm/Ac8kS2g0MEFHmfewkMBk4OoU0s/t1TEpQN5VQTN5uC3HP4hK/xIcAYCkJw3OvaI0mNvQaLWPjv8GsrHTQkulr9fp9MM2NB8fCfuGStfZbp4AYs/EsmFYtGwpzTiO4nFSJEeWMTELt6siRUGxt/fUDrsAZbe0oIO+2U1Phuolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4vkYyhYzYITGCs0i/3d7ASalLJ9+AdE2iEYi1sOY9c=;
 b=X0cTl66povnBmbrDDn+OqbiSawff/A1oM2DgFJ+3uKraoUjdEKPTi4ddxDDkFPG4HTK3PIMVbApq+yupQhaJ42BO3VjJ4YGHR6HpRJpG4jUHO6mOGcRI6rW8ydDnl3SwAIOLrUCudAdhtVPJugwPF3oC+TDXROtoKyDzXqmIWrJ5r/65mMXAuMvUqlJfXl3CYwUtpQoVQaKCkctBnzOGn/LqjKcPh54FQFcSu/tfR0cEC/+niCuObgDfARbPB5I5Z3cynrSogwjbJ2tHrWTfKqVw3+doLZK9n26mqd4lnS6yxgV8Q/pCZwcThoFCONMT6oBrBCg1WRjmYDzW3PEUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4vkYyhYzYITGCs0i/3d7ASalLJ9+AdE2iEYi1sOY9c=;
 b=xSN3cAoXVhiV1dn1wthXAE/E5kF1o9d6FkNzRFFpV2JVRv80aaiLnRh85zC01qd6IP1U4eYmGBKhh4SrmVK5YeBebAh+GbCYhOKhuT8DUIw+fbq1rhs5cfcL2y6wBjqIQc3D6EnChP1cKCB1cig+8+EkNp1/Ub1j7uJgGkf46vg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4061.namprd10.prod.outlook.com
 (2603:10b6:208:182::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Tue, 15 Mar
 2022 17:05:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 17:05:58 +0000
Date:   Tue, 15 Mar 2022 20:05:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: mmal-vchiq: add a check for the return of
 vmalloc()
Message-ID: <20220315170538.GR3293@kadam>
References: <tencent_7A338FE792721C51E887BB2A8DFC0B815C0A@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7A338FE792721C51E887BB2A8DFC0B815C0A@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe8ea65-1e7f-47c2-35f6-08da06a612d3
X-MS-TrafficTypeDiagnostic: MN2PR10MB4061:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB406101882FCCC5859E10E0828E109@MN2PR10MB4061.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcKwFP8ahkDxvYCs42R2Z96sX+01kFyTgy8JFYKaYI188n9qs0Yh9B4BdyvVyPdeKKQ3adnxIfycMGerbZz6NomGKBYkBx0TIjHaneqV1qcZ39fp5GW0tBd0+QzGBZmNAcY60FiEG72Q+6km9qm2AtMSZEF3iwfXDAZOnMXPv4qJcRraE1DT79tRLc2jDk0ZlaQ5S+ljtP4h11/t0ypHOKK9rNCK6sSXozqPLI6oet3PvpzzIUtIMPoixMc5xvAdPGviya846gTibIBp3BngzHt6v9v+WNcTWw/xYFqw71cU9r7s6Krgo2rT5VbxLB98JFSZG8e3bOe4ccg3oOh9MY0C5Xc0ftlFdQoJRJ8KShmVJzETaa/t5slaZhrX9u2wp71qa4LAMTi4dF6OgZ7CKsCE0ZvBIus58KlJ+HyajWM8AVPtvFsONeF7fmKUmZU7x6lH290RfYmjkuaGj8fKv2SySVhrACjbadxR7nwf+dWenUrhFca2cjjGQ6xdIJOlRUpuMI4SnzO8Qv11whYC3BxpGBHgnPW9ttRGtEsNG2DIi2IbO9B0WpsRZcLskh1/51PbRCQZTyBMYPbNP/i8l39XC9iXyklxHcQru3JHRg9Py02Dc+ybwqsdJXQnO4I6cBTfaadhrMC4PIbdYJWuPZurAmW3y7n1eg1U6hr6xJ9o/i/b8jADmLU2W5HMw8DW58u2mf5SwhURM5yDSZ+zAYQ+c2gPXPR0383o+YWdGJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(316002)(66556008)(66946007)(66476007)(4326008)(8676002)(5660300002)(6916009)(33656002)(8936002)(83380400001)(6666004)(33716001)(186003)(26005)(9686003)(508600001)(38350700002)(6512007)(6486002)(52116002)(2906002)(86362001)(1076003)(6506007)(38100700002)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zeFdzz9Tdpbw/AEOFoWcA7sV13q3cu8qtNRgjR9T3TVAzo2VitdMfTzRUnyI?=
 =?us-ascii?Q?lVtiPE9WzuUe9dV3fwYL1hce/NeKqsOR3uFHBBIHHO2d61DT6tJqApMDNG+M?=
 =?us-ascii?Q?x89GKYs0Kn4VA/3tFW0nEK5jFw01FRTaHFg6AQ1T6MPuEnXMSzHvcUcq6kR4?=
 =?us-ascii?Q?NgP2iOXA5FFdxpj7ZscD0jo0witCVx+R3bgPIE67H7w/gmFa1Q48jSMz2jFT?=
 =?us-ascii?Q?xBAoCiJ8EO92NoRp56+aEPe0+dMP5c8RoFyo6YorQvm2VnOkHKY9whOFuOcf?=
 =?us-ascii?Q?zz65XD05UbDwnp2ijaksJn6IV7TqQrhvVGqNREyH6x6YZOYCt9hPs8fDxJoe?=
 =?us-ascii?Q?mh5XXHt2zPd+NTxvbuLOqXwGf3FJuxqczckgExkd5Yl6f8D6CGYT3gMv999K?=
 =?us-ascii?Q?6Syt46yWl02kbFFx6ODRUsZgAVMkpcaGTXmlIth7RwaK/KG0C9EL6fqW8yrG?=
 =?us-ascii?Q?kKOpe5onJY1FaNov62pn50zv39+msEuX1YKZMzfIdDXGYxthbiwTfSofqWM0?=
 =?us-ascii?Q?qgouHcq09kftp2vrBlsuzmMxCp8ivLd2IB4Iziwzsvbwf5R34g7hMNgMI0CU?=
 =?us-ascii?Q?KRhe+K+yGEQrXPL6RuJ/A4QF3vUNoTR4PVaWqxYZ4b+5Dp0t935G9i3wW9Yd?=
 =?us-ascii?Q?WREpt1YAAySDYRGmKSMDWs19ZPD0vjw4opt4h2mbQAC+TsZ9fK+nB8aGIxi4?=
 =?us-ascii?Q?pujI0TWJz+72quN0yQJW3/CjfOHNTgSjSsxpggamJ5NV14tOSXiOkcJHDF6/?=
 =?us-ascii?Q?/hkS7hDq4VQQvH1J9SJKzZ1JPPAIgdMZub+fZ/W0NJMPwOd4xi5c6vpF2Gt9?=
 =?us-ascii?Q?KYRN1oL3+928T1wNcLbXKQYzKP4KlIQmbkekVjMYwanlZUi0ApolvP9SF65J?=
 =?us-ascii?Q?9fW6gsgERrTyFqsIt1Ub5VG73UqgzJ7z+r3p5Q7G5ZLTmhNbMuXYaFz/LGIS?=
 =?us-ascii?Q?ZXTfBFvtldGI7qhpIluqsXDIlrL/tHQHW+N0qrcySTPEQIGT+cClnUtppwnY?=
 =?us-ascii?Q?cwWJuJ+uroyqOUp25EPCoSF0sgKswb9vCiOzXDVIXbc+aUM5qU79Il6fEytC?=
 =?us-ascii?Q?79xsWYqg9C+4QLqB3o/JdrEGx8oIl7bIV/uZyUVa0D+0UHSL+egYMCzm2uXw?=
 =?us-ascii?Q?HdLaVENDLuRdMwmjpZuzA9mCmyyvcCAYTCXkDjGRhQ4+QYIGbV0igDvfNXQf?=
 =?us-ascii?Q?0EvctS/D2KuaGoX8oHlkrcW3okCXV2VWqiG+1HDCldHW17GwcnHB7D29yNBO?=
 =?us-ascii?Q?VVYy3MCJZc4/nVxD6Zdm3ts+nmAnPfRzCHDNxj9RzOutwbY49KWmUH6ANcvu?=
 =?us-ascii?Q?wmCtrlLseLY+FC8UfSfJUOCyAcnZroM4H1BIc0FEgUHGCVT3nRVJCLZyhbKi?=
 =?us-ascii?Q?nwuBdzM+K7lyprGdJHgNd+giWiNK7oomhJ+7Ei2UCOjAc0+FM3mHyvJEfQaQ?=
 =?us-ascii?Q?PETdEMdej3DI6MIF26sX9jfyczEsgO/yRSo1oOKl2jduLthDYyJ7bA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe8ea65-1e7f-47c2-35f6-08da06a612d3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 17:05:58.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR9gk0YMvFL7fg/lkREo7mVKLo+fIfwfl4Z/SWAfMTiqUWDko9+O8fDHcaJGILt/ly+vbvsBZbt18u7i7cxxQoCH7+N+Ewv2iMyCZt8LDT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4061
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150104
X-Proofpoint-GUID: ksSZ_0Z-TOs8KA2yLVYCk8uIcLO_K4gs
X-Proofpoint-ORIG-GUID: ksSZ_0Z-TOs8KA2yLVYCk8uIcLO_K4gs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:39:13AM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> vmalloc() is a memory allocation API which can return NULL when some
> internal memory errors happen. So it is better to check the return
> value of it to catch the error in time.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> ChangeLog:
> v1->v2 jump to the proper location and remove redundant instruction.
> v2->v3 fix the mistake bring by version 2.
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 76d3f03..24cc0fe 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -1909,6 +1909,10 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
>  	mutex_init(&instance->vchiq_mutex);
>  
>  	instance->bulk_scratch = vmalloc(PAGE_SIZE);
> +	if (!instance->bulk_scratch) {

Just delete ->bulk_scratch.  It is not used anywhere.

regards,
dan carpenter

