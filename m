Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407454E99E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiC1OlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiC1OlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:41:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6423FBFD;
        Mon, 28 Mar 2022 07:39:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SCtwDT013589;
        Mon, 28 Mar 2022 14:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jMBCQ5AxRcDMCiyMhbYjjDMAh+ZEhgjLTZojeXTMVRY=;
 b=nUmIJ4QbFHQQidQ7J+KT1eHUOI5ftn1ZAwkLRr/TXqcC0Q9KEYx9lL3VYKHsTcTWWazi
 HJceI3tVaclbNTec35BmhMMvi7QAVVlaeNtKebwmuWKjlV+h0o0W5AsQVEcTjCUUvTi9
 E/ZGbHRZyf/4lIBN4YBtS+YVqFaUCba3LrF4M559aX9vrWvd2cozp6P4r9fcZJvFOKA0
 yUGZHzZz6SGjXajLmghDUxeC9DKN3ZmfiCH1juY8kEt5MB9uMzeAT04J+jLVlBpOZyUV
 +qVNs8nvKOl/4FT6FqdkE//3gWklEbNwHhBOfKaL06xjETGkieuQGxaqcnUR4jukOHt+ Qw== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0btws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 14:39:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22SEGfmk192638;
        Mon, 28 Mar 2022 14:39:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3f1rv8abx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 14:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqBa+GwQ1kc9DFBBMTdY71blfuC3rM3eNMhfAa5g1RYChlo2lUtt4SJIac7cGUsWw+PWi9reOloDJJ3bUDy52yoZQgRKdVUAmudYxwTinVC9zO86MAZSbEgSE+BJvcVmrKQjWgPFSMhyaP8NWIv0eWZUMoeBYhLB5R0qH2Thj5RzYw/EQR8vR0kbrJqNRLBs42cQdGOr/WVCcOZ4PiacfFdZsHL3KItUGaZFc14C7DdLnnNWmZUx0PHT/j60VDMEh08xhGHhGdwA8ruI1SGqm69a4u6Er4axgNE4qxict1fe08BjyT3lXqWMB6iJSwqbx4ztTDqeSkUEUqk9CyQE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMBCQ5AxRcDMCiyMhbYjjDMAh+ZEhgjLTZojeXTMVRY=;
 b=YsTCAPpXPlmlMRo/7BENq7+Wq1TqgcncXD6XFmky/yv29TpUL/zfWjUeqtbSTWlhE84fnCLomvX+hKns7y57ZHCTTtHzm0rQolW1Z93J2FCV/SObXLSvCgeNgrIogOqciA/J5dDCdEA1AgYrydYATIdZaIsQqd1Az53fkUsde1kL+O1J+i/GynZQtOHFhgWjJd6QES5KsO3WEwh45b1GfSxpZyrHKKH4dOyCqkM80yBtWffDAZCBksdAGgRnrJAXuWfbcqDgGpSdSqK4rmOzvgcsl8IoIHX7bG+3tFPidIpQHUzEazWvEMlK4yrzYh7xZC3PscReLgwpYdDN1drHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMBCQ5AxRcDMCiyMhbYjjDMAh+ZEhgjLTZojeXTMVRY=;
 b=o6zcmc9tOW5B0RS0Pvj3xIzmea9VrS+67ch3P5oHzh3Y5QBoZQ4u7rT6aJtuWY7a2ThvGo61luZdmlHAx0noc/tznyS2nXxWtHzTe4J4E7dw7irSQsf7sQahuofJAmcoCTnHjKzGs/9ovAMwJEEjvvIrkWB+AmQ1TUvuhghRiSI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2487.namprd10.prod.outlook.com
 (2603:10b6:a02:b0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 14:39:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Mon, 28 Mar 2022
 14:39:15 +0000
Date:   Mon, 28 Mar 2022 17:38:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: Re: [PATCH] scsi: sd: Jump to out_free_index if device_add{,_disk}()
 fail
Message-ID: <20220328143853.GU3293@kadam>
References: <20220328084452.11479-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328084452.11479-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0051.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f627684f-505f-41fd-603f-08da10c8bb4e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2487:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB24871A563950FF44CB44040A8E1D9@BYAPR10MB2487.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZarpgv+aXFtA62hlpm2p31BD5qp5Y5pTsWgd6C1gdc8wJzwaenYjb6Fa4gKWQDt8ciRljG32WhySDgHVJhxhVY8ZXja7BOGCtRlUhzuMsgW+pV7cEkV4FPyw+5gxwZxtJnO5V7L+sWt74+x2fshqfekhbqa5CW1AePfVNn3GBuN89TVEqq0eJhwjPgjMbe8bcT/X22rU6XsVneGWOhTnhj9iq0PUdWhBgHm4aAde/srjEmiko+GxWWIgTPc+2t5raZU/v3e8eQqQXk5oKxVlro6E3iNZfrPdvfo3P5EklSDaZu7SuM1ogtoVJPpdJAi+Ec67Aylm6M3BGeDSlWk4cNBTAE0maqQDWdYJCliQ8xnOyTLw8uHRkHUEoQxeWA7YHkBt7uUosU+ZfprNaD6MvrqH1S9ZJyPuIBi+tDDjjnxVB3KX06hujXiWyRjZiaTHN5LbwBKa65bJw9eO1nm9+Hk2GlpG0DsQoWOLHkk6igWlP2BLE8Rw7Enyp8b+LD+0oIArLjANUm91HH3fj1QzmfHFjfoxCdmR9gvYxJHlaPtiBINElV6Eoe15DL/7Wo/06jsyrpvEQuOycU1tDj1YA1fa2nrGV5GAWwnbvZtr6tJPDkAbjQMMeh1+fcqgbaBzlqEBCyfmZ/7Tw5qMer5UMd3x3YEdWNU1skJT4I+JrJEjdyq32+I1EDErY/q40E4pRuUnrPwN/XaZv/E/iUk0nxg/XPTlrv4SSa/fJsJwf64VjiI14ExHxm1TNzYGpfjju4yBvotos3l4t/7x3i5zRSpooNu4Tj8NhpKuEqBKK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(8936002)(5660300002)(6666004)(186003)(83380400001)(6506007)(52116002)(26005)(6512007)(9686003)(33656002)(2906002)(1076003)(66556008)(66476007)(38100700002)(4326008)(966005)(508600001)(8676002)(66946007)(6486002)(6916009)(54906003)(316002)(33716001)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u6QxlEuCOwn6y7za/FOy/XuCr/n7yVprhjtzxZTDhX/oM9dRbOLDw6dm3gbF?=
 =?us-ascii?Q?EvjEwQT0Jqed2hQ3NLopD/Kqgbp65QanBhRRbHTNRRmq+wSzm5um7aQU6uzw?=
 =?us-ascii?Q?ux9s7DAns8+vPtF5AZRIQue33nKXIaHWL6Rvi+1N7hKk930jNsvofRqcGQE3?=
 =?us-ascii?Q?f0wZ6UPqdRvG115oohUR9qRSPlM18mGA+yctnfVYeqAX4dY2mfPzqPCmooCz?=
 =?us-ascii?Q?CyFRwUW/RgK9qIxrcOx+1oFaLf2hG7QQsaucr0GQMnHLk8JO9CfFWjX8sR2v?=
 =?us-ascii?Q?chmAsZ9EETg3SbEtvj1GjAX4YJehkso22pv94mY0sFMZ/I8xjmg39JWLEBDP?=
 =?us-ascii?Q?HNnPqJdccpS/UxZKHRUyRZSbwqdsffJKT+GgMpDR940HfK+aM/uriGT9gHoi?=
 =?us-ascii?Q?wfDUmaBp5egYP3MHFcBhQxR3dH0l3ScT4ELzwlYnbnn83SWbSxhKwwPY48Pp?=
 =?us-ascii?Q?sI13lB9W9yYIXJ0pmMR1fIsDTw+TFhymJeQ1N95WnsTEsCdxQNqW3o9J2bSZ?=
 =?us-ascii?Q?9YP1RPxq3qAnilNRl3nqyqoIga8IdeaRRFUgDmwzwz27vjuXjIpLWwkKWh+B?=
 =?us-ascii?Q?UQIS3QhxlBHxImH7yMW5XYXT30SVzxW+jWKDjKfn/qiNmEKMmlK0x3A+CTHn?=
 =?us-ascii?Q?qUPLlOnPHxavRjx/OzURgQ68IF9wo3feGndpmSR8WKYwX7bRbbfHx9IJuoHs?=
 =?us-ascii?Q?l6273k1ywMUo+Q/IKxyD2pPqbbTQuF94xi1kJe/nHCwURIafDZsYqkvbevoU?=
 =?us-ascii?Q?lYhJ22/Vywao59LjZI8f28vs0F4Xvc89wQA735qeWudpPwLRdvltbok+xg5M?=
 =?us-ascii?Q?pcCfTS/ZjDAYZ+YjOppD89IYdoH1Vwf+p6uqN3JSBXlnDClS6JB6Cb1GDdJj?=
 =?us-ascii?Q?E2KQOVjNJ2UDr6rOUZGR8mOlR/q4wi3RGRxBC2TtkWnzVjl3FHj2Vkbm1+l3?=
 =?us-ascii?Q?g5tceV5s7/bNyRnglZNOkCE/JfJChhQy5cDxZposoDD1rQgWhvc/vPvs7Oeb?=
 =?us-ascii?Q?uUSh9Weq/3oc1dkpE6gkEW03ZKOfBpEfCu33r9RLE18ZbeUO1eme9f3DqtkC?=
 =?us-ascii?Q?ncuBkgp8leSoCSbHrofEbVeyJIyDTNfvSZ9Qaay63fViyiXt2ZOJkJilodW2?=
 =?us-ascii?Q?YPgI0DRHgjZhC/Rdv77MW7DwW155DMhDf/NXMIsBmYa6/Vpce9InEm/geZw+?=
 =?us-ascii?Q?9JvOIQSn/nImwazj+fI6D3do/lQ76mmBcu+E1tYPzpIxEknF+P8z9Q6Z8CSI?=
 =?us-ascii?Q?YrA3fG+zzdRlTXPH/Bsts5MOG1UmQ69BmtPQCb02RIZhVJQT2NoMw9kBnaoF?=
 =?us-ascii?Q?CEatAp5ZwT+TfFvtQ2HqjZKtXCcoG9MbEYkDcpSwZxxGPvZs4VmC8B/PLVdq?=
 =?us-ascii?Q?i2XpBpyMTJaKGJn+aGgmi86pLdL2JuukW/8fcHuc8zTObaW1r+AWfGKPDisz?=
 =?us-ascii?Q?m8oBi8XFsdwVNkh1FdPTpk9VM4GmOxwqIPZtV+mRmYw/4xv0kIGj6MTacYnR?=
 =?us-ascii?Q?K5Eph0f6QhqSYu3Y3Xvdu3lS6O56XrM+nVRXWe6DI09Vc7rBJozEX/sdkmsa?=
 =?us-ascii?Q?JwO+BLYkS9IO8qTSrjTWKgquWdkWplMDAFFErHjmp6xetiRMdO4N+7I3KlX+?=
 =?us-ascii?Q?PtvC1LhN8i3o8wh0OAIElU6LqZXmmqHp2SbuRr/Mm0uizKjYyEupJ1TY2JxC?=
 =?us-ascii?Q?XtoA7LcmGG+qPon0pcyHicNegsVHD9lQT9yxsa+oj0btE/60a1BBF0GRigyX?=
 =?us-ascii?Q?vo6Q+65fG7/qR53B5T1yRHx3RBkSCuc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f627684f-505f-41fd-603f-08da10c8bb4e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 14:39:15.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TyILaKor3hUAcAdEclVxVS+GfyEJSMENA/ugsT8WapvKV1uU/KODNMZ3wJ1biiDS1GCsGqCvaVJCeCK1a/3Eyq2kWN8Gk6zkZ40kPQwBK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2487
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10299 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=817 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280083
X-Proofpoint-ORIG-GUID: 8f3yojNLV82vVM5LuQVc_Amia6nEgLBS
X-Proofpoint-GUID: 8f3yojNLV82vVM5LuQVc_Amia6nEgLBS
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:44:52AM +0200, Fabio M. De Francesco wrote:
> Currently, if device_add() or device_add_disk() fail, the code jumps to
> the "out" label. Doing so we get a memory leak as Syzbot reports.[1]
> 
> Fix this bug by jumping to the "out_free_index" label.
> 
> [1] https://groups.google.com/g/syzkaller-bugs/c/BvuqG6YGb6I
> 
> Reported-and-tested-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
> Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
> Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/scsi/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a390679cf458..61fcf653ef5a 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3434,7 +3434,7 @@ static int sd_probe(struct device *dev)
>  	error = device_add(&sdkp->disk_dev);
>  	if (error) {
>  		put_device(&sdkp->disk_dev);
> -		goto out;
> +		goto out_free_index;

The put_device calls scsi_disk_release() so this change will introduce
use after frees and double frees.

There is a larger process issue here.  We need to figure out why syzbot
did not detect that this patch introduces bugs.

regards,
dan carpenter

