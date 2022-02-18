Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B90B4BB82B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiBRLfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:35:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiBRLfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:35:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD3F2A0717
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:34:52 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IAI5Fa014558;
        Fri, 18 Feb 2022 11:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qo99wzwd8oqmv1lLr7MeivZzYjSH5lbgyVZGNRefIc8=;
 b=dzzAN4xHkS7xXKODH7Yy1fXH2EtFonQTMVXqFD3kec4cKMaHveVr8pUfq2s3fvzqFb5L
 eGnh9C93BY5CUH+wUoD481+pZtNOEjQcXiokaGJdjesxu1ifnyb8CStcD8gNM7m+NFDB
 sNSumCEtOiX2RmS2LYAXYNUqRolu/+8s4t0bUTm7wCw46+2a7To3O9Pk7tXEECVbYiLA
 ajju+VUCQysxtP+NlJOM/JMCNgEb8V50G6vMJ+ue2FxLDwXx0gmUYhJXt17x9Wif34i2
 TEm0Rs4p17rUHgcKx+PXlCCtHXfRwlxRs7dwJaR99CRKD0G02bOBnIAAwG/kf9MCcK2b Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncb178f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 11:34:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IBUdIl033188;
        Fri, 18 Feb 2022 11:34:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by aserp3030.oracle.com with ESMTP id 3e9brdnkxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 11:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEWRIhrTaiY8Lo0uw2vUHCAT/uJVXskivvb/2ulDhy+l901RUzM8E2O7/dAmqEFtzv05chZlVELsJRi2LioJeX4DtXVD49PK9MyKcVAuBuemtW1cJDGT5jcfHlGqnqj8KzcwFUQ0o/wwrn31c/gXKt0XW33RjxkleK5zSofSWSo1J3HHa8GSTThxgeyPymIyx6AeGvGCcO9ODMDY6GK9syTIgtgtF1TPZgXb/VvdiaafWbgJ6TEU/zx+YuwCaBOpMD2yeFHiKMerAPqU1jMbPGG4JhMnHYqXiUiCMZ1s7A5AOzvAyJB2Z4nHLkCCbefpiTnR+19wzM1s01wwUe1mnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo99wzwd8oqmv1lLr7MeivZzYjSH5lbgyVZGNRefIc8=;
 b=ZFi03CRqDvG1aH/4nXvfvwWEFfOy7unETeBI7TU2oyn+VS2nJdCLmEKro+3hJzcdHG++u0ZL7uf7rqr342gvo0C+B9w7OG1XNEJrOic+kyXml0w/mOg4DdEmb3gbrKNTCwo008MyprqtspCR/V1zi3mIoYAiWkf3Dwu+q19CmGYafI1XfdQXjY8U7eUJ0dw/ubAEjPRwU4oBLTRPWo9nhNLZv6k1moATRSM0vaVEK9NDLAkpRdkZRzxN2Vh2XSB46s1i8+EmZ6hOoV7QIPTSL9gtEQBd+7YjclwXF3+BGUbVCpDYVl2P4k6B+A/bd4PxeadQQBZ+HFBmBsjkpmkU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo99wzwd8oqmv1lLr7MeivZzYjSH5lbgyVZGNRefIc8=;
 b=aCQP9ZdgyTkPWhgt7E7ynOgRtJcw3q8C9ryIHcQ3UHIDqsOju7gVf3Vx8jDkd4kYHFhqwFV3wgO717eDkXpwv6hV2ixE5Q1EFuErx5gdLKLDpiRhSNATshXzLlIv64LrHwgzFqTel7+lWQxhZHoh4MkUK/vl72sFn7HxDpPM8yI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1842.namprd10.prod.outlook.com
 (2603:10b6:404:fb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 11:34:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 11:34:40 +0000
Date:   Fri, 18 Feb 2022 14:34:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: wfx: fix the error handling in
 wfx_init_common()
Message-ID: <20220218113422.GF2407@kadam>
References: <tencent_8F1C1B14CFE19C4A05FF632068CCCBB92708@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8F1C1B14CFE19C4A05FF632068CCCBB92708@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dddc6c3b-1ee2-4fd4-2fbd-08d9f2d2a607
X-MS-TrafficTypeDiagnostic: BN6PR10MB1842:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB18427C321F819F510B6AAF7A8E379@BN6PR10MB1842.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kx2f+LBCTYQm2N52FwubbPy8TGYWQPyIFVTUep7y28bswdbioROjTorx7oP3qnUo/EM5tCFsTN+E6lvHQflWAMfKWfCdq+sSUxzwFJi9WS3eSrbpGV2EpEfrX3H/C/IZPyaMD11sPQ9jIJ+7wL+YOBDJ961YOjNdZYHbQxXRdOI8Y+I9v2+M07gTebs8/dKVROur99QEuWM7s7Y62OTN7A/kes6Ij06tTjBaLumVaX3fgAUqjoeTjAOcD0qDnpPLPP2kkg+9EpZv9AIa/ihDiy4muyOde7hCHqCGMhWvKYJygi8mL95PD2S68ASDRk1gKL3ODi8cTLjapRRTFGnPUi2NaCWz6qgrX4K8b/Gx7UyhJdyPlxt7u3HmhuLiRhhK1B5/fEOEti2+i+zeLYmhLMbGm/iPuZF0hM2soWHlYCXwL4V5NHaaPG3XyVx5PYKKeFBqkZ8fs5NqeyupDU+jiQLQLP0m99aI5OCUjanCuzXcEDuiJvVTnGCYcdunmqz+2mD+/FkIH72ROljwd1J02Rl4gIofhDg93yW1XHNJE2U1PKX8JW1YJS8KJ+viVgkKqGqXozor/Mm45OCFAZirAVmp6RGi8t+kTIFU8UkHOp5YS5/2k/UrepdWBLuDcVUnRpvIuKuqF6imMEQuuMUSI+SUw+h6BTqGx7LzrYtYv3v52bPpIrkpj4XBsLKaJg26S94p/PyLPxcUfIF6E0TW5hHTjrhoS0JFVxz1k9kAki8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(83380400001)(66476007)(33656002)(26005)(52116002)(2906002)(38350700002)(1076003)(38100700002)(6512007)(6506007)(6666004)(9686003)(8936002)(44832011)(5660300002)(86362001)(6486002)(508600001)(33716001)(8676002)(316002)(6916009)(66946007)(4326008)(66556008)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FjTJneVMq32jjXvW9cLYkrDhPU4cyFev8eJ2XOu8yhX9GOiDSGl9hGWGhR6d?=
 =?us-ascii?Q?6yuVlkeomQM8X2rnoM/PRLhQP21MRUaTop426U0Je2h6xW1FUf2sJ3Q0pDE7?=
 =?us-ascii?Q?Wlra/YiAz4O0wVRBl7OxqZVPVqRDgog8cloPvMIs3ZDWewPLvUE0YK/MSSNe?=
 =?us-ascii?Q?1XX34U4Eu3QTQB3E3TpJS9Uly9q+Bj3rO0gFBgcfpxypTbpiMqbmsFvxk6/3?=
 =?us-ascii?Q?xlR/BU9UhHO1XY/ouzO440IFg68d4HRuU/h9TNStzpobvsCO1c5QBVGetld1?=
 =?us-ascii?Q?5R4686S8PaTqpUgEzwzFPAwn9c7+07kOO23Uwtaq3EDzBVi06xyU3Ln52SNm?=
 =?us-ascii?Q?qd1buhhv8vcRHs6LKWmmXSQeMPFM7lvsP7x2UplgM/pBqjyk/iIyc1DjVDA2?=
 =?us-ascii?Q?vPmaeV/IH2zuipKZs/YyG9crKpuiitNQYCKF0FbJ6K4Ri2aN1sgRu71vCzdN?=
 =?us-ascii?Q?pX6sOFRrTtEAsaVzdpx46k4c2fAFbs/ulpxT6vNA+oyuLbC3uyv/MMZlDpo/?=
 =?us-ascii?Q?Axt2iaXXOfWmyryOYueqeBf/6ztlyyekE6eUKjKgUk9UDHQuvpPHjLi2NOHC?=
 =?us-ascii?Q?f20oYou/+djxkYj0LkMSi+ZHDE0xDak2Juxid59gO5mHIZrKdaPETMCUkTyV?=
 =?us-ascii?Q?9cJAUUaYEL9Tn+VIa8e2QgrAo2Htn414DRT2eI6nziKyKXa1i5wiLUB48S35?=
 =?us-ascii?Q?vN/VZIsc7sU7IZ+3HkNq5nseMbQSMktuJsz6dl9leJywzNOK+jvd7hVK1q6E?=
 =?us-ascii?Q?CWrk/AuYKkOEAwG6vTGxZNtD4y/ZVYmsKMuFPC+cQKfwmLMRBtjxky/vMl5d?=
 =?us-ascii?Q?B80mzEGFPaVm7LLJfxwbJdu/mB4FLARReDESvw0+pPu3sOAp0Ap5YYQffTur?=
 =?us-ascii?Q?nUT/MaZw5EdZYNHeJpLFG+ruTA8FyIyak/4DyodEjHc9HDGZv/D8De9exPqo?=
 =?us-ascii?Q?0fGiK2aRFZ6Wffeg8r/WdZrMk1lJ97g3ZBboG7zzPEcLnhkvLGe5x0o5+Fw4?=
 =?us-ascii?Q?qyQJeAGzB7NRqnXflQ9diB+ZDBcemPKsLcPcqYmq1lBW0rIb5Dpf7V/S+5C7?=
 =?us-ascii?Q?qfpsgcRRPS2fX32LcXXk7t+qz+fTq4mGBK0waT0z5xw751VL7ZD6kuPlVdLr?=
 =?us-ascii?Q?DF4XMe65MO2XoZcpMc3TeUS6klv1ae9uVrSrO3xBiFJ4Ld10sq+g7Eg7R9zp?=
 =?us-ascii?Q?qnHMhjXUD1LzR0CpHpxUE+4TKbz01cfK1Q1NbJXTZFi1QjSsOnvxl15j3pS9?=
 =?us-ascii?Q?qL8QLRe3EXU+sFmOd+36Ua8WnoVmfaxJJZL1ITEW7aGKsNwrFz/CIIsebfEH?=
 =?us-ascii?Q?VMStQpegOVK275AN5XoI4oV3Wpjw5l2mTyKFUm2yBo9CVFznOoWXncC9MW19?=
 =?us-ascii?Q?jjtK6G5cvWAAfa6ywGjocwzqXmfyvq0pQIYJk2ckM8W7IqdXb82FRKmY0G3I?=
 =?us-ascii?Q?30c/kwGE9OUtsm5AJ3zSLiuk9NzK/JM4mO2ReYufCCNoZqIX9ouYt5oEgE/m?=
 =?us-ascii?Q?gBaFrm2QP0eJccNcyb6IK/ZosaVbSjsIRf3ga1Tjd1WCTq00kpfk1aB/iSG4?=
 =?us-ascii?Q?W4bbbb3qt2sc7PWG/LZiSm8NxCRLPZpak+TKCKJ/SNMVEkK9BKMdywLd7fdF?=
 =?us-ascii?Q?T3nhj991LGksGlitWnjWADW9js1w4nU+nEGamlPRLEmbd/6VMlCCGbFxdXlb?=
 =?us-ascii?Q?CqO0zQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddc6c3b-1ee2-4fd4-2fbd-08d9f2d2a607
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 11:34:40.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5X5JeuEkxv+69we/OqBglsYyf/YzvnQCYUgUyNyayhHFXGjp+79simT8JdUD63BEAmyMNnlm4lLcaRASAEGrQingcXDiaAA33MtQmhdiZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1842
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180074
X-Proofpoint-ORIG-GUID: B9b9HQAvvpeqh558A9phlOk1coicqH20
X-Proofpoint-GUID: B9b9HQAvvpeqh558A9phlOk1coicqH20
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:47:21PM +0800, xkernel.wang@foxmail.com wrote:
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index 4b9fdf9..f83df9f 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -309,7 +309,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>  	wdev->pdata.gpio_wakeup = devm_gpiod_get_optional(dev, "wakeup",
>  							  GPIOD_OUT_LOW);
>  	if (IS_ERR(wdev->pdata.gpio_wakeup))
> -		return NULL;
> +		goto err;
> +
>  	if (wdev->pdata.gpio_wakeup)
>  		gpiod_set_consumer_name(wdev->pdata.gpio_wakeup, "wfx wakeup");
>  
> @@ -325,9 +326,13 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>  	wdev->force_ps_timeout = -1;
>  
>  	if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
> -		return NULL;
> +		goto err;

No, this goto introduces a double free.  devm_add_action_or_reset()
will call wfx_free_common() on failure and then we call it again after
the goto.

regards,
dan carpenter

>  
>  	return wdev;
> +
> +err:
> +	ieee80211_free_hw(hw);
> +	return NULL;
>  }

Also the patchset was not sent as a thread.

regards,
dan carpenter

