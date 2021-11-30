Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17B7463801
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbhK3O53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:57:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25958 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbhK3Oys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:54:48 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUE0i3P009072;
        Tue, 30 Nov 2021 14:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Kxwu2gwV/usqIoHLZ+HBJnH+O9qupI9igPvX0xu1Hys=;
 b=d4opous1wrjMbdH2gMvNLHPmYj0H5z5WiFpRqe/80UZ8TUQEsARIZIeTUqVeZ1PB279C
 jzHPWVrd3xXuMSWJQG89RQano6gYlSNZwOwAHOpm86+b6N6eZ2jMhIU+YkYdnhvtHzN7
 /VbPvI0div/iCzm3S/UrmRa1x1D/rv904R3JgcuwcrEj1TIii82LbZx5oo/69gcWyohI
 iDNd+UeZA+/OQ8NWd9/ZlaDTknL2XHw5BGyTILENqYrYOIUeBeVC3V8gyBrORp4d/HvZ
 0VL+nhKRwJrCoGEKgTskkQIIaeJ6EJdhtup/OUQPYAQ+bv4l4KVZZfvAVcBYwclwQO9L 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9sjep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 14:51:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUEQIuN062543;
        Tue, 30 Nov 2021 14:51:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 3cke4ppswh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 14:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYIyC5ddngOXpNOge74kEQSJo//q8L65rlJ5pBo+PzuIOss3Vvw3F7CPV0QY1VV6gsr5Ju68YZcYvkvT1IDZC/zPzDpc15/Y8bYbT4COkHZxHfuVhcwz7KDR2SK/NIFa3BU5c6wrPogy1olmkoy4PoSQOz3d3LLFnUJamMK36te/B7JmZ/QpQO44GZbhQzNy0tqlHAUGMhP0qrpUFfM4N187Ge5+kHPz7s16/U1i/glACpBYczSHLjJsm81YN2PNz6GZPCdHYxNstg21gwfON4V60ZW5Btu4fafvEyP6rX3WMk2sWdrQWfcmjODU+dw3Nq+G/Mf09+YpdDTqp/XOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxwu2gwV/usqIoHLZ+HBJnH+O9qupI9igPvX0xu1Hys=;
 b=k0IQ6HMlN0Pdwxx61J/l8yWA51b8VLbwTZyuq1l5gG7lYRlvMoLTApXZXFiXDjJJE9SH1j4B5b0f8HT5hcbCVFhvP7sC8ABR1lsTEuUGXA13slPQCc2dq6oNDEDa5Dk7Q4D13vL7FyLQjJZfggl+Dj1HELNceId0wXlLyLi6Dxv7PQl3aptGOU4o3Iy0zNx5VNkNr1mJvIfXLl5Bc7iDTe3/kPOxqYrJIixIRFRJoulV1tM6N/aLw4TZhpYEK2XUNcKpM+lQCUv0FrfFk3XtV+jVK/g+8DHm6G+blKuWr4UGSk714o70q0u2uinjChhC3U6Cb5lIaeXFxj0/qkbHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxwu2gwV/usqIoHLZ+HBJnH+O9qupI9igPvX0xu1Hys=;
 b=Wi1jPXPm01gur0S/ZuhSMfxl31sNk+j9VxNGJOBwA4hFKoRUIbZ6oZPcJFcOdCAvL6r7s3+9S9TLEhgCRdKmF5y+OxNki/uiw7n5ueA4tnDeqnoETvIICxMl+l+C/D2q4j/AKG6/RFIHCU9ZX8YgFu6R/u5u1zxt+62ri1z4La8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1549.namprd10.prod.outlook.com
 (2603:10b6:300:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 30 Nov
 2021 14:51:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 14:51:21 +0000
Date:   Tue, 30 Nov 2021 17:50:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: pmc_atom: free pmc->regmap in pmc_setup_dev
Message-ID: <20211130145056.GZ18178@kadam>
References: <20211130143526.1820249-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130143526.1820249-1-mudongliangabcd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 14:51:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d6da403-e647-4e47-5dbc-08d9b410df73
X-MS-TrafficTypeDiagnostic: MWHPR10MB1549:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1549D0D91040F1A2DF6B28268E679@MWHPR10MB1549.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I75dK51ku715lZZD1rIBTKC58UAzoLuWLupRFN76la5e+95l0QKmb7FXVdHM/EQUIwF1WFaz/aMlyYIpYHhZN2n82LudF3RTjscp58G91YnubU41cfgagvPul7+o7OF/S+rAf5S70C3T40eXmisaDKmX/xw39PMykRocMO14G0ZuM8cLM+Nkxud0scCoekkTUd9j5/viE+amq0NBN4mRqG7SfO/VGEmamJWYojXxAh7g3pEUQc+KU6ouLoQUjC8mguehZgpKHDbWW6K8Lnmskf3ztBeN3BEJQLRwmNE6Sgc8O9TiAddNUxCvBRxZ3Z8EEXb1x0EU1igaXMxpXSH914GsOVDbLPTTJUZGlEYYLXibDdXXuDC4lHYfKdqXsKIuhSwutWbikwD1l7L8DnPc4zxKuwOSWWTvJoNSMNIvXS82nQoDFGRJ5mQlUB9WiJEaVaNEDc+tdbflzctW2eyiNGNQTlKrl4fk8pApLvg0UgjdCE2F34ksLz2t29Nj1qcRuwLAPmKHTq0VcZv8t4R7t2emgWkk221RSI+tNiU1FC1a9Rce/AEzbbGRgo8D8QIh6RSJhqOp65P9cbphrElVMIsFDdzsVEm9l5jWFxpOHIpL9/zOGh/tvzjuTVil8nDdY2hvuqqUhD1XkqYLD5uuiJu5Yv5jsGuxNBr5Z7R/+pVvn5H33zFxOUkKfH8BQ5qwhGXVM9mBcDZkFiu1ndO9qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(956004)(33716001)(8936002)(44832011)(508600001)(6666004)(52116002)(9686003)(55016003)(38100700002)(38350700002)(186003)(8676002)(86362001)(33656002)(66946007)(66556008)(66476007)(5660300002)(6916009)(4744005)(9576002)(83380400001)(4326008)(26005)(2906002)(316002)(6496006)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YPv2lqeKxw1TTLJSlEbRPMmu059l15FjH0vkFVLHbRKBKdGc10RKMxakU2sR?=
 =?us-ascii?Q?fvvmRfYOnb49Y85+Cv/Ben403u9Lbz6oX+32rr0urxcHHRb4w5D7aQ4cjO6M?=
 =?us-ascii?Q?jOTaUwVTlq5laqX1OLTb+U4/ux8/Cn5neB0cQhWuUH9lsim5llIH5FcJ6EMs?=
 =?us-ascii?Q?uavJaYwwsUHnt5Dr8Ojk5uwa9QUDn2UG/8ORhiKYVhRJbZCh6dsNUFHpzY72?=
 =?us-ascii?Q?YZdJjHPAxJgjksYDGf1WFPHbLyNPquvT211AXaidLLasin//dmG6Xhl1OcB+?=
 =?us-ascii?Q?9WUH26zaO6Frph2SCHBgqVJNAePx+gCP9OJFk23NzuereVfasHE6CIZHReS4?=
 =?us-ascii?Q?gB4D9G/y+UyfCCdi3NaiRePDnO20gO3T3Z4nXihM2KwKc2EHoAjOjyLZJHw7?=
 =?us-ascii?Q?urwua7DIsFokgoUFG+7XKFRAdu0Hn25ve3sp3jKEOgL2ffRDScDZaBfrEDN4?=
 =?us-ascii?Q?NavKsQr5vobR1Q0LKZCVvZwY6V3l/9NZnpjOPxcvrTbCAU5YHJ6eXHB4DYsk?=
 =?us-ascii?Q?/+0l5YnUtN5OU72XhOKQwiA8ijr2El832HcWExQD2fFAUgeU4eqGr1XRZnO9?=
 =?us-ascii?Q?lOO8fKKi9CiKZlrmR7gO+/mX82mWywS072AD7ABZyIatBu3KpKUCKQ4rnU9p?=
 =?us-ascii?Q?NFBkMsaIpZtyZMCk8kMyVUqYtU4Ue0at6i7ueRjdgRRYV2x99NWNlfTH3tV1?=
 =?us-ascii?Q?yzlK6PncOXaI8ALG/X9DpbCvYkBqPoy40aGgsOQZxNQwSKy165kyewCyrfTq?=
 =?us-ascii?Q?pEKrNXur1xGiwQ4keD36/5FQW+/6/RKxdsSIus1ZmJZH+Vv+TJyhsZGm74VS?=
 =?us-ascii?Q?iNB3nXeQVwusqVVJZvzHFu6PhnbzYw/NUNE67iJVJ5NPGxtRn4uNK5+2DVLK?=
 =?us-ascii?Q?RKb5hCiJ1UqvuSR0kG3RaPJNb+51pGKjL6BzIDdV04ponzcGITWYbSbYlKw1?=
 =?us-ascii?Q?0FNk/lAD1EPfibjLZ4RFboeTdkOeuJc10THaveBYK5d4lTPsUZXGcgHhMLXj?=
 =?us-ascii?Q?SWcXs8nnY64vAc4z6ZKOUhGy2qBSAv8DmOjKZY6QRCmfuzPgP2hgOy9aMwBj?=
 =?us-ascii?Q?osC/GN0mEEXQWNlssMbm20J4SOWdSbxEZYHcsgHgKtNqe6JmEmsjogTM6Rc6?=
 =?us-ascii?Q?ttTyZL0qkkizluIFwdLKMGmgIqrjKeuI8WywtRxH2/JJfNSxwF/R8fsFWsyA?=
 =?us-ascii?Q?iYf4Ftdtz7DeIoiGRDwZthq/D3NjIggM2uF/KfxxCCRo1ycMvbHBVkRSo73N?=
 =?us-ascii?Q?WGqiZZ6XGdjLKuc8tIRS7N3Z0Vi7cDmOWh4IhGbdLh1FjIY/fSVrXK98OxpZ?=
 =?us-ascii?Q?GKYjQHjXVUjaHFlTJ3sjzNtP5hZjFHlle4Uh5vGevojkEqrYJ7O93kH72rEO?=
 =?us-ascii?Q?npjIKLSxaNGnQC8okYlI6kRIR95QvrJGw4JSHOmNNXyjWsTszfejGrSnIfBN?=
 =?us-ascii?Q?1X03s9xDvk78uYuITbr2OGiGM7+Rqxr6zOPF66n8Im10eAKFUQuANcn7FNGo?=
 =?us-ascii?Q?EAYO7+4TJaBiMQ8K2SEB37yiuBuwlo021lCuqVLdycT3IodzYwa4SBKzmZ+Z?=
 =?us-ascii?Q?DZCsXdgfLM+GsceI6cd/b8DEdaMsBVYXrESXkO2G6NDcf0Sk730V14lpbsET?=
 =?us-ascii?Q?XRzsTBnef7XCyb76ja0Jpmi/Uxf4Lju+A66l59fKFBXvjfSSSGUI7t1XEHXu?=
 =?us-ascii?Q?eS+90aIHJtXNsKZbdYm5KwHbFz8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6da403-e647-4e47-5dbc-08d9b410df73
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:51:21.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyGMxH1GnoIO2O/NRoNLoGtaks2CBMGuFitOxS2x9S09I+lBYxKXS5ftOZhv5I9J7wk8T0bvG0l8lxoJnMnGbSUTLyzxC++5xc9beHh/lWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1549
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300080
X-Proofpoint-GUID: v4BtXlfIWt0gQfaMXMyr35KLY2adUq-3
X-Proofpoint-ORIG-GUID: v4BtXlfIWt0gQfaMXMyr35KLY2adUq-3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:35:25PM +0800, Dongliang Mu wrote:
> Smatch reports:
> 
> drivers/platform/x86/pmc_atom.c:496
> pmc_setup_dev() warn: 'pmc->regmap' not released on lines: 496.
> 
> Fix this by deallocating pm->regmap.
> 
> CC: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/platform/x86/pmc_atom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index a9d2a4b98e57..95ba108ed716 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -492,6 +492,7 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		dev_warn(&pdev->dev, "platform clocks register failed: %d\n",
>  			 ret);
>  
> +	iounmap(pmc->regmap);

This releases it on the success path so it will break the driver.

regards,
dan carpenter

>  	pmc->init = true;
>  	return ret;
>  }
> -- 
> 2.25.1
