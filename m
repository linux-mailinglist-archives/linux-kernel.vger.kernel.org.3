Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16AF464778
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347070AbhLAG6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:58:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9170 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237081AbhLAG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:58:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B155hft018947;
        Wed, 1 Dec 2021 06:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=Nxk2h2J+xVftFBr2c/knI7736xKT/LMeq0AVeoVnnvg=;
 b=H337vL9GVAm1yMdoiXjUdxLAucSAcHi6MR/7PCjGqD+3SBA5QcqEzqgdGB+0S8LHyt7L
 AUBgIQYWK97UEGkQOBejRl6l4pXPh+OzTU0iqhgYTeaEbfQ3o4D128C3z9mfOgnPcx4D
 iayoV0hjo10iVtmST7kU8TAVN/w9eZjmNNsBGGsXXzxJtV/SpEPIew6bMn/Ugri2Vz56
 uuSDo9qFVTDbQ1HT4J9VWW45iH20k0h47esvOs3H6nOqaQfsRWJyLnczrjHFiui/S8Q+
 GxLAjsRpkbqgdOnxU8zVvcfWh9ziKEierIWTt+nI38sIBRBaYWFc/beOy2rkQtmDPgit wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt87gcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 06:55:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B16pjOO010727;
        Wed, 1 Dec 2021 06:55:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 3cnhve5hyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 06:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIEqSB2eMBJonp5ft3V3WGLbDlYrouGS3hwTESz7yJInOFgs7H3cIBPz1zNnvCZx9gSfFlmmOiPXdX4YSbohJmBWx2Mnj3P1l6BBFG1qo/e6VYgrAj6v/sUZjzRXuQg7lEksLt15vWIAiQRAchqkAWUADqDZcrSZjPa/M8Gvz+fddCFrflOlxENlUIrHHQOYPbIrk39AE3jXUwpAtf1r4SgTFX16rYg5U1xDot16d3NQrgRtWohEpAQa9LzQXh2mAWc4DqR7fosW4o8lF31BNDWr/C5s1RySwV2aFD59EL3+5+Db5boVhWXIPP2Gv0oJBvlzcwmKfHec4oUf3s8xIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkrX42AnMTW1gYAzUiUXIj/ihShCbsMYWNa96hK92y0=;
 b=a3tzr5nqx9Ll4Z5T+e1K9Zj8GUZVjlp6DsG5gQKGyLZjLJm543SfIphft7fYuapGcwggeEiv0bngpA6+qlpero93U6fCjDUnzDw5Mie3ZZ/cY0Z3VRdm0P0D9ykxmolQBcInJd79TfO/jHksS9R2wbzVYzgL9S1B/I2/AW6X+ASI9KzOs8cTGJTdgfLvdtmNu0JYXOdIpfSE/mMfpbJ7YIZRPmFfT5lz7RALWz0J4Toh2cl27i03XegyTLxBJphk1k9gGdxn8NKdpjvakTi8ZZtysqKiTI9q/cDvcTUSc0WE80VTYssIjj486KE2hsMezN0sO5zXD61lKMw94+EF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkrX42AnMTW1gYAzUiUXIj/ihShCbsMYWNa96hK92y0=;
 b=fQL9u4HZwSkczVUCMnRARLy/H0aRQF5WUHB7t4Ul7VQYHXi/LTS6XI6utzccSnI4oiM3lnXQJwXLHtuXbxGLENIfhfVw2sBN0Uuw+4E7JXv7Mism+9ZKePfjNYON9nXaj6DRiik0FkfXTkt8qqldbNcX/EIoqC58JXtOkLW9YHs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2254.namprd10.prod.outlook.com
 (2603:10b6:301:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 06:55:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 06:55:22 +0000
Date:   Wed, 1 Dec 2021 09:55:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH -next] staging: rtl8192e: rtllib_module: fix missing
 free_netdev() on error in alloc_rtllib()
Message-ID: <20211201065502.GC9522@kadam>
References: <20211130034007.779351-1-yangyingliang@huawei.com>
 <851b57b9-79ac-e7a1-a61a-6f36a5d9d77a@gmail.com>
 <8f1c4e5a-663f-e5f4-a98e-b72ee3a4f365@huawei.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f1c4e5a-663f-e5f4-a98e-b72ee3a4f365@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 06:55:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d656136d-985a-4033-3ef0-08d9b4978bb7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2254:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2254876A69DD758FBA8399E18E689@MWHPR1001MB2254.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aR8QndOhxAQPhHtQjVov+jJuidDPkqakJw4i2kmgQvZ6WUEbwDdxGUBj5bF9jKTVXHV/9v/ZOvdkvPKqhoLOqXx2/g/wH6BPOYjxJ+aGZ8l/PGBnZYSZmRH2VFYlBSuaybq6ABHbb/wZMsEvaVc0PFhHrvtckoNAC5j+4c7Z/hUIqzl0ubizqT1JQLGxe0ZyNNdwpX7lX2QagnlUBQKZ0znyNl2roSvyePWNro5aAvWf6jhjtnsY9c7v/uXP1n01cMyJjdnTXiO1pmSUWmPAccUclMK3Nczzc5zLAFP7hQvaWlGAy7ETaiCFNTiDymq0IOfxnFUeyoGPJ0z3PeLdBIyFWGCH5WcriZVY757jbWvGdLsUYXkM4zPV6kH1yxzZQLpg8RUB2B/Bww0JKxbQbrZbmjkQw/PgZgNlV5c6AluYSxaxwNB0jM1QdZSJsqoumkVwrC/tlZ/0xrewXVqupwvOtPsV6tGbtjmFGSlt7qMYEzRG+7LyDaU776CB3zYtU9604h0bjYZ49VstwX7OL+us8kQXl0OYvrWUv9yV8bgKqPaVA7COiG9ZwtcIUjlrf2K6HNpuxEC9YluSOB8XSlBUzU29WyWzTbRUnysDtGTz9zoXQGsLb9NacK6ZgMxMVDNjcvfWkfXpU/gPyGCnwUMQmOm3QsD/rZbJq385MvMP+Xv04W3bSn1wQMdK2oYcna8ElvovuOCYLJ3LYe+o/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(38350700002)(86362001)(33716001)(38100700002)(6916009)(956004)(66556008)(6666004)(33656002)(186003)(508600001)(66946007)(316002)(1076003)(6496006)(66476007)(9686003)(53546011)(83380400001)(52116002)(9576002)(26005)(5660300002)(4326008)(2906002)(8676002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RlAlhxf+5RbF5SxcU4a1mM3qn/vgAbfPJfA35LcTTI5lD3DoseiguKM41J?=
 =?iso-8859-1?Q?ghyIfOfVt1U7mX4UhGtqFDsEJYjy/n9ANK39rO6OnBUz7mrgsOW8+QTTLd?=
 =?iso-8859-1?Q?902X1MtaEvvtvNrlU30ip0HMMa4ZCb7B7ajVsob3YwKEZ2iDxzrXBtCbUE?=
 =?iso-8859-1?Q?YC+DyhzRzhtO7i5D+nAASmxw9LhUMT4DTyZICpIAJKfYo9Y21tzapwSDYU?=
 =?iso-8859-1?Q?4+a5fQlDo/zywAZKzfcyXv/OBnRk+Jm6Wr0lyrD1vFfgVPqnzd4ey+qnET?=
 =?iso-8859-1?Q?CNV+bsHWIfCJ9YCiuA0tRFvL5xGlSTAuLFO49K0Vt3fvRVLnr8Y/4HO8mA?=
 =?iso-8859-1?Q?emlKgZiLBWNIqcxmp+UiA+fy/2z/yQtQuRTt8FIuah5lRQIzRk6mpnnWuE?=
 =?iso-8859-1?Q?Uzf1TWsYw1kIdwvqTU7N3NFbyEJ/KBcdO/PT4J8pWZpu/atDMRsZQgmZcB?=
 =?iso-8859-1?Q?t71+7zyoZ8HMMHqaOcXdLGMdmGbfRlmDPaj0FUuZQ/jeeMHlTiCaIOW3jm?=
 =?iso-8859-1?Q?8/sCo2Y2oKVVXjNE2j4Rt55IOp2BIfo6TZxoyRbRJ29PYSqZn/HuONMZFt?=
 =?iso-8859-1?Q?QYzIrSUBtcJPkmNmmanFCao2+c/4VAPdQAvtz0XmSf7E1A259iMSLJ5AeB?=
 =?iso-8859-1?Q?j4TLsapJlC/FvXmTzMNwHDpcEgpgN9+ZZs1cGsUYIzvnE/IN1pyXaOTNK4?=
 =?iso-8859-1?Q?oZJ264z0EdzzjaK26Q2txvS1prZK87h9LxnPbCYJxzr/KKR2FlCTJDM5OD?=
 =?iso-8859-1?Q?iXJAeM1PVcfRO0FMOemu+cTY8PptQeOVlf9ewS6oHcdzePOsbszkJTFOb+?=
 =?iso-8859-1?Q?HusDCQYI5CtaZzy7yX6A+V8bzC1W+cz06mg6nEEop1n+tqNCdkXTlUBFKC?=
 =?iso-8859-1?Q?LZE4xd2xzI80QWsyXolXSbG35aL/ktbXxQsjRiX+jvQWUsohoBlk4Qs2Kh?=
 =?iso-8859-1?Q?1eUbOCdzqi0CkxqDNVUYwzr9QquY1DXrMkU5cpom/355roggOUdlMLi05S?=
 =?iso-8859-1?Q?j6nakfwlrvjDoHfFeeF3BISp4HOXr/GzycXFzXqVC5qH/xe23C8o0nVYRt?=
 =?iso-8859-1?Q?jChaVsIhQ5bVeKB+yMQSBjnm418uQw9BXI81W60Oc3tzDYCHWMG88pJKHo?=
 =?iso-8859-1?Q?MIgVdtrOQJhgwWoHWlqpFs+PWQ+vILGJfmxDQTkP2gOMNK1yXmE0wWZ+2y?=
 =?iso-8859-1?Q?qO98DJG0Wzf2waxRiZWgFobPhUG0wVpVHjcQSvwHkpxkQ98WDposhGVDS/?=
 =?iso-8859-1?Q?FNPaXlvLkSLgdZGQWQyG4E/XsNroF6UY7S3PVi+QatwQRWcPIeJcdqtHVV?=
 =?iso-8859-1?Q?uLw7bLfY1Vtu95SQwvhEPcMvieO00bDLl/XGUpwRMG9BAOdoR/Bt4Jr8kv?=
 =?iso-8859-1?Q?752Jv73Ea3YWRk6bjYB6GeQbzt9j2yCoYRTZHNvB2z8J68So6TSgIhAfWw?=
 =?iso-8859-1?Q?yjLvwInxL1h00l3jZYmYRewFJanXZSrgtqCLL4XCT1I2ljUXU0322MAgyq?=
 =?iso-8859-1?Q?Ii0MEWlcQCuHmR3vymxMy3lZYEZTkNe9zKrUzGDPoBShLh3+zarr6vMZHG?=
 =?iso-8859-1?Q?xiRaBSJs7a+skMdiB+a9VtKUxIz9pnRWucvOlPz8hAsnLmtdzwZjk8GRxc?=
 =?iso-8859-1?Q?aK5ZVELCKRkqZfGSUdARpKpTyPQNNSU3+aDHo8rHvLhWpE1iZt0ZIExGtD?=
 =?iso-8859-1?Q?411aq/CPfu/S2kkGYrtX6cwDVVdA6XkDH3EEDd9i1Ns7zpp1g0hacD961K?=
 =?iso-8859-1?Q?UpKbAJPrlJ4juoVrUnXqyAS3M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d656136d-985a-4033-3ef0-08d9b4978bb7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 06:55:22.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8s+kFryNM63qOq7z4rLfy/KK31C480VO52alk5mef2W4+pYl4zNQYPOVMADqmago61Tuv0HkLo3UD0rHZtwerJZSIyer6pMbOjfJHnt8r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2254
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010039
X-Proofpoint-ORIG-GUID: gu6HF-tCg2NdV5NmE3PcwPA5FdB8HmI6
X-Proofpoint-GUID: gu6HF-tCg2NdV5NmE3PcwPA5FdB8HmI6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:41:41AM +0800, Yang Yingliang wrote:
> Hi,
> 
> On 2021/12/1 2:57, Pavel Skripkin wrote:
> > On 11/30/21 06:40, Yang Yingliang wrote:
> > > Add the missing free_netdev() before return from alloc_rtllib()
> > > in the error handling case.
> > > 
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   drivers/staging/rtl8192e/rtllib_module.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/rtl8192e/rtllib_module.c
> > > b/drivers/staging/rtl8192e/rtllib_module.c
> > > index 64d9feee1f39..18d898714c5c 100644
> > > --- a/drivers/staging/rtl8192e/rtllib_module.c
> > > +++ b/drivers/staging/rtl8192e/rtllib_module.c
> > > @@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
> > >         ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput),
> > > GFP_KERNEL);
> > >       if (!ieee->pHTInfo)
> > > -        return NULL;
> > > +        goto failed;
> > >         HTUpdateDefaultSetting(ieee);
> > >       HTInitializeHTInfo(ieee);
> > > 
> > 
> > Good catch!
> > 
> > There are 2 more possible leaks, tho. rtllib_networks_allocate() and
> > rtllib_softmac_init() should be unwinded too.
> The error path of rtllib_networks_allocate()  won't leak the dev.

You've misunderstood what Pavel is saying.  He's saying that we need to
call rtllib_networks_free() as well as free_netdev().

This code has a "goto failed" and that means it is either going to do
nothing or do everything.  It is a bad style of error handling and it
often has bugs like this.  The best way to write error handling is to
use Free the Last Thing style.

int my_alloc_function()
{
	a = alloc();
	if (!a)
		return -ENOMEM;  // <- there is no last thing

	b = alloc();
	if (!b) {
		ret = -ENOMEM;
		goto free_a;  // <- this name says "a" is the last thing
	}

	c = alloc();
	if (!c) {
		ret = -ENOMEM;
		goto free_b;
	}

	return 0;

free_b:
	free(b);
free_a:
	free(a);

	return ret;
}

In this style of error handling you only need to remember the last
successful allocation and the names tell you what the goto does so it
is much easier to check if it's correct.

Then to create a my_free_function() you can just: Copy and paste the
error handling.  Add a free(c).  Delete the labels.

void my_free_function()
{
	free(c);
	free(b);
	free(a);
}

The free function for alloc_rtllib() is free_rtllib() and it looks like
this:

drivers/staging/rtl8192e/rtllib_module.c
   150  void free_rtllib(struct net_device *dev)
   151  {
   152          struct rtllib_device *ieee = (struct rtllib_device *)
   153                                        netdev_priv_rsl(dev);
   154  
   155          kfree(ieee->pHTInfo);
   156          ieee->pHTInfo = NULL;
                ^^^^^^^^^^^^^^^^^^^^^
This line is pointless and should be deleted.

   157          rtllib_softmac_free(ieee);
   158  
   159          lib80211_crypt_info_free(&ieee->crypt_info);
   160  
   161          rtllib_networks_free(ieee);
   162          free_netdev(dev);
   163  }

As you can see this free function calls rtllib_softmac_free(),
lib80211_crypt_info_free() and rtllib_networks_free() so the error
handling in alloc_rtllib() needs to do that as well.  Based on what
I have said, then ideally the error handling for alloc_rtllib() would
look something like this:

        return dev;

free_softmac:
        rtllib_softmac_free(ieee);
        lib80211_crypt_info_free(&ieee->crypt_info);
free_networks:
        rtllib_networks_free(ieee);
free_netdev:
        free_netdev(dev);

        return NULL;

The rtllib_softmac_init() function should really return an int, but it
returns void.  That could be fixed in a separate patch if you want.

regards,
dan carpenter
