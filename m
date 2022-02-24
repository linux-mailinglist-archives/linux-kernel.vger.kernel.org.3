Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528BD4C2473
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiBXH2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiBXH2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:28:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1D160FDC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:27:44 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21O65ufK019924;
        Thu, 24 Feb 2022 07:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=UgNcQuGd6gDpW+vMwosUWuu5tOpscqKDyJbMpmhX7zw=;
 b=vDMuSvb+eQ8jMmLEssIKEsfxR2DwhP1AspPqkZAE/E1nfrV7yY5kJEaLgVVYghW97mV9
 CGvxtzWilRUhvMOeSD81jOKzKmSecve00SlnFev+oFoKyffZnSeJALupHl2nyVPD87CX
 pu+NJgE90peClI9d9jkSaIvj5PlLvo41eXfLixsfwtiAqe+bi5W3yAMNAJ0xbwX0FnbS
 881NkmesnMqVn0FXNZV9Q6b8EoNELunk9flV1oHU+D0nWC7e7BtO8EhdEnW30dK9n8IR
 X4nX8RvzJRYYVUDfvQkoHXmQI0g8sQd5sNZYEWS4E0XCI/anNIxbD4grkcWpLQ5Ml3Vq FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7aphty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 07:27:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21O7QWO0086210;
        Thu, 24 Feb 2022 07:27:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3020.oracle.com with ESMTP id 3eb483965p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 07:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpKdjmCa7+jbSS+cYzrttmTBecaMvZeTNq18LIZefmDRGKz4d65z0Z6AvORvmaAAQJy1nA4DEviVcpbKhPjNil0gZjqj2qVKlcs3krtiEq3Ui2oYMhUNHAdzbY0ZTlZt4Uht7SzEE9N/r0hxhQ2K/zDXWAfy5n7SJ/VVJ3aoa420BOhnB+LWZpxu8mD9nf7ZRQmt9sn7i6IA92CXEmGnyHfWqvax6tkSFPHCrZOXtjg3qVF2gZQQ9v5WEFIWHWN44i9ZApqiqSdkjO5aQXJg5w4X+kcK9cCi5dRFeCxBG09kIkcpzVCwLJRSQtPsMXa90wsTaA0NbLitxx/5ILIkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgNcQuGd6gDpW+vMwosUWuu5tOpscqKDyJbMpmhX7zw=;
 b=bLxUGcEVFj8OL7iYCDemifhnATjZoTLmglJw/eYhT/Y6rqzM2Z1QW178yP7w9bsjU+QpOWz1aDTh705dgceuLeHh/j9yCXuirIZuqnDIRN3MsH4vFjsoUiWmenj4P8o4LEWERjNkX5Kfrp7aRMfO/dgGbDFgmF3EWGiupGc7KlURiqCOWAQ1YatmOom9c1/XWlMpaaW8N/1qtuLmvekx5IF+yTtpEFaor+8jbvdLWwy/ODJSbXZtrFtCV+87aLzNxHef0ALoe4KgIiQat3T7skREGc2TwHve4g26+E8K8HccZGKakeIu+Xy6JN1vnZzFe4bgk4kJUikd+vaklJWukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgNcQuGd6gDpW+vMwosUWuu5tOpscqKDyJbMpmhX7zw=;
 b=TWuKxKhDvWYIOWqhn7wjspdkPtmTfGwiZIR4t/FKXKNgsS0drEN+1QZpBeCkS+L8ssAPXOHsInQD5F7Q5c7hQfL6557V8K1TFase7kEaR/JgIIH3Gy4EbzwoULPxPmx2JiPYRs07BevGd8aaELQanG1lj+sKpdsfMiygVCM2sDI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4356.namprd10.prod.outlook.com
 (2603:10b6:a03:210::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 07:27:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 07:27:28 +0000
Date:   Thu, 24 Feb 2022 10:27:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Johan Hovold <johan@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: rtl8192u: rework init and exit function
Message-ID: <20220224072717.GJ3943@kadam>
References: <YhPI5iDRUpzYWDyY@kroah.com>
 <20220224064033.1530924-3-ztong0001@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224064033.1530924-3-ztong0001@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b3c465-04dc-45e4-6c7b-08d9f7671cb4
X-MS-TrafficTypeDiagnostic: BY5PR10MB4356:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB435671E96CDA9B8A6FBD7A758E3D9@BY5PR10MB4356.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kx27gdiT0t7Ja0Jx19MVcHxHjzE9XXUDERW0zjdzxbhAiJE0zz/agG+uJdJqB4MFbU5Z6ZZQi7VjC+0ivrkYWhHFPTQU4Kyh5g93E3o9cOTE46Dl7sZJKEoOfHx4xquIzkVXOsfUdTL5ZnNEvWAPS1mfHZ72umw2fr2GEPbiUUp3jxLav4iXpfqrQbSFghRtUaGGpwZiDsvmRdEz1xZqiew1A2WJjxmWOA3Rkzt+z2iguRavf542eB3JhPDTQYnpCqBc9dIPSJCmPUa0BtuVlA01VkXq62OGFhK4xSoxAOoPhpiBFBoYgalQzFzalM3OoDd/EEisKxl5cspLTbWOma0hV/ClecSvVwFUctVeI2M6rKub+BPTmYHMXlQi/my9ydomXHdX0eYtDnYvUJf5KtqMHKhhiO21j1Nb/bcMtqpzy5TCIiyhl+mM5CwEi6NLd+Ovz/yruWuhoiMSEt6nSE0f3YQaiQjV5WRC4i/WcuCVNi5duQEDmPFnCd95z6e5M5aG/2W3oVBWEF2vpDQBLCvckVp3kNzwYhph0ezbib52LDuhjkX/2BvXK5pqmD9rGYvwh7KHmg/c9rTJhUbrPQHQ8Xk3We3rSxmCm/HHuLRWKW0hcAOjD5NaaqTjoNipuA+sw+dqsJJDzbJrslPa53wQYhAn6QmRLtUbgk3iCdz5tzV8b1MJrkDsVICEap/eghbeWK/Cu03Aoc1/ofcItg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(38350700002)(4744005)(186003)(66946007)(66476007)(2906002)(33656002)(9686003)(6512007)(33716001)(6666004)(38100700002)(7416002)(1076003)(26005)(66556008)(6506007)(86362001)(52116002)(508600001)(4326008)(8936002)(44832011)(6916009)(54906003)(8676002)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?byu7h3F5LDf4BcmcMS0V4HrmixnNsswgyfdB1qycBrNqZJC04DPEeb/cJ1gg?=
 =?us-ascii?Q?hoPC0Mguzt1KoaMd8dhkGl81//Eoei+zV1WJHbe28mvm+t1w5dYgtKWg19sA?=
 =?us-ascii?Q?qYwnFRCdfhuYf02M8a7zC45+u84yTcA0usoboSf8fEQvYsQ1ozlbbRauvtGL?=
 =?us-ascii?Q?FlOp/+4c210FwdvQMJYkA6zHcOO7jiBXxE61LUrJ4Fr1Hpzq0t2Sl4qLCPpg?=
 =?us-ascii?Q?vp6aWVNNwjasEKnbghFkOkTkvp5fi4gpFiNYrc5hDXfglVKfRaLfz5V88e4M?=
 =?us-ascii?Q?MKZGFO9Ze8RFwfa0EQskgMp42w9nSTvPp4xye6+r+g8uzo1gq9Sa8RxMxGwM?=
 =?us-ascii?Q?L17Qs/CUEe3Ewf6Xz4zphu7c7W1Hhs40qbP08ghtf7KyK/Si4i7+WhDbtvmF?=
 =?us-ascii?Q?DXc28A4/0Xisosw5OJ4397e6U/y1Pe0ME6rEXS+RlUPDkdv06jGyOlRlV4T8?=
 =?us-ascii?Q?UXwMKayzcr6/eEu4H7UOkN3DbBBtfq3GSGpqmQSRIaOkN7Q+c33eGOVip+zF?=
 =?us-ascii?Q?N9i33liv1ctWkxDZ0UAe1Nff4E5QH0wGeQLf59MaelC39Eszc2+VAQHh3OF1?=
 =?us-ascii?Q?o7xdn9qTsmIbStSEM8cVFiZwFsmxtYOYo0bGJyUeQ3A070dbSFMKkUAZYzls?=
 =?us-ascii?Q?PQUtNpSyxfLCs/jv4pEcKkI3SguedlWpSeXam+j2U8d7xjEftdAzwurolXVi?=
 =?us-ascii?Q?lSrbfLSAoaJ5/rRAf4QHFkDG5AdUOc4QqjS2F2VDfxXKJ+5vqpNGv7Qczfop?=
 =?us-ascii?Q?PmTvT1ZAPlZP3qIS1SB9MiE2DDZ6t7lQRRS6TKcDQzNTyatt9nhrqay3ektz?=
 =?us-ascii?Q?Y/F5bYn3Q25UHZEZ9KPLkMPFxW4KDJWOy6q4vsdT0x71ijnGZw7qw0jidpsS?=
 =?us-ascii?Q?r+7KXvMs7Wjx93rQGyuauCyYZcuwvzlJFwARWjoCN7Ri2I2v/1mvyTzc+GAs?=
 =?us-ascii?Q?d2hEbhIgm0j5Zx7g7t4w3NR+hce3DJdkdkf2hjCRTgA6CNQTlVAFel4VdH/y?=
 =?us-ascii?Q?HsUQklOmPs8gq30Sh+Ezq64/VYa80lSrYx9cm+bFqNWnE8tnoVOUceCkyELb?=
 =?us-ascii?Q?6cUnCR9zmQNzbANBm7zeFwyTb5fLJhLKJ+XbMsd8CMJKX6zRyv/+Dzz+bsyV?=
 =?us-ascii?Q?TKhRvyy+01Pie411gkc5gMRIwOFcjdi4oJAhEPETE7cILH3XKRrSWGJOgzMI?=
 =?us-ascii?Q?c8aleC+y0fctyzPIVBnhrbsIS4B9KVOsGKAiS+lK4/+ZJvdxDdhGcFM/Lz+U?=
 =?us-ascii?Q?FtbcOXc/5CqhzE1PnqxZje5xTAiZ5C28oNBmLewpwIaj02oS6LjTpznirCUV?=
 =?us-ascii?Q?qKjoRibWWN4+XXnQuVmNnfd9sl2wBR5YfuEk+WhxNKr+vspSkHx9mGqHkTxp?=
 =?us-ascii?Q?35RttlLtX3SyamYFMBaPwZX77TmLEQPOBpIjNrDL3m/VAJ+LDVLLHW5Wrw52?=
 =?us-ascii?Q?+cBdjM41Cnw4AA6ExzHeIMhGIBgBr5pPN7wwF+TqOm0ij2+d3fJvkKVayN2G?=
 =?us-ascii?Q?os+0BAnlYn6pWDFMAM8WuPKWuT7RUz/VMGRmXgc6/JymFpDd/YTV2M51G3rD?=
 =?us-ascii?Q?WJMuM7tMw4UjypmxIyo3iWSGtBP6D+kmtG/dlp3KkqkNGudA9KiT7pMRoQMC?=
 =?us-ascii?Q?pJZxwNeDq04OVHEnnN9OOR5yo3jMIpRJEMW/BQSHwWtyT/tL6FY/gQZ4MXue?=
 =?us-ascii?Q?IR4K/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b3c465-04dc-45e4-6c7b-08d9f7671cb4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 07:27:28.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVWygGREqOmejYoPa1cWOspmT+NSgERE+WYwuZ5cxipSKLbHE39KcMh2dh/NRrd/0FCj+xg5Uxq7xdKHXZmTsNRoppcSDZ27K6UMqXCzh2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240043
X-Proofpoint-GUID: Nn-VDZjFpE5vN0G3l2PQL_GbLkicQm4l
X-Proofpoint-ORIG-GUID: Nn-VDZjFpE5vN0G3l2PQL_GbLkicQm4l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:40:31PM -0800, Tong Zhang wrote:
> The init and exit functions are not releasing resource properly. An error
> can be observed when we load/unload/load r8192u_usb module due to this
> issue. This patch rework init and exit functions to do proper resource
> release on init error and module unload.
> The __exit attribute is stripped from some functions since they are now
> being used by module init functions.
> 
> [  493.068012] proc_dir_entry 'net/ieee80211' already registered
> [  493.271973]  proc_mkdir+0x18/0x20
> [  493.272136]  ieee80211_debug_init+0x28/0xde8 [r8192u_usb]
> [  493.272404]  rtl8192_usb_module_init+0x10/0x161 [r8192u_usb]
> 
> [   13.910616] proc_dir_entry 'net/rtl819xU' already registered
> [   13.918931]  proc_mkdir+0x18/0x20
> [   13.919098]  rtl8192_usb_module_init+0x142/0x16d [r8192u_usb]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Good!  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

