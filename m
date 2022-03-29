Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B27D4EAC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiC2L3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiC2L26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:28:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206AD1E95DE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:27:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oY3m020165;
        Tue, 29 Mar 2022 11:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XX41wyZt/rmYSzRL3n0zs4c5nDoIAFRewgbwSQr7EkQ=;
 b=ZY0STf1oAGXxgAJYfTNj5yxpK5J8VHKwDEuaOm7Urgjboeltp2i7VscW55dPsSGLn5bz
 kmnynDwPAySOoLBU3OjNatrgOamll7e8c5axVVKepnaUUYBAeq/Oag9xIG9+2Tuv4IfC
 xtL4gT++c/PxLPYp+zma0oQRXYJjl/q9/gQ5jcMLA4X6o9jFC97sGTKZApVfUoW4crI1
 SEtzDwIthMRmlaWst8wZ74FLRWhjKuw0zefR+Qt40bXaz90r0UzkXdwmAqE4Treg19ar
 F8/2nn0PdNIXer5l7IaLLB/i5FJWy8SNzrxbm7EnVEJLsJ9Q2cik7loqzt7zLWF1b6E4 aQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctpcas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 11:27:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TBAns9104524;
        Tue, 29 Mar 2022 11:26:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3f1rv8ce5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 11:26:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1PsqpgwmuwpcUGHMTcXzc/LGczCUPcOUc5zxY1CT2dXocjbJ3aROM0XJLdNCQXcIIUbOxJ9Xhzigz6ytVfajVOxMlqlVBcN/fS8+0Gyun9DzNMnEfpw1Whttn4aC9qUxRqmaBXApGL46+Aal0iyB05mgVQmdDA5QVS4ZZECKXHI/jK0mqlWqEUCvci9EERkb4ePqRd9cIV8q2Qbo5ksbX1UQloro+jeeeIIBM+mGaOIk1ztnjCwE4UFRduk3I7e4vY0TabCw8RoBsqjAZViOggzRc+tMUZ0OxK/7fCO6uniIKOaevU5G0vJrx80yNBZ7+4Mg8dt88CEz/s0dmJyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX41wyZt/rmYSzRL3n0zs4c5nDoIAFRewgbwSQr7EkQ=;
 b=cNpSbdUTrii1ifrOMDgO4Ko7/kzQgIZgBgMvzduo97+rEd9+ZHQHPtqBQmInuuTn7VbbXAoGGqFVQ5Driv0FSjkV6wP6o7T1f3zNTxLlZxDoTyIRN7sUdcAmvOrojg+OI6LsvAuAfTNKKG+x/cjxtj5NHihRrCjg7d0xqFTL6DZIYFiW0EHA4Fp56cS8K+LEa0ftRoWYef/cdF0JFvYcukj/9Xk8e+As8hmE0liClKECFYFs2LBEgyl2RVt8Ybmn6RZRtQ5leZnjMHbX43CQFPJFCUAd8E4wLBMFltGeZXj0OXmL2xwhvkWIbTsecHN3UJ+ejQ9w2phUqdT4PkjGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX41wyZt/rmYSzRL3n0zs4c5nDoIAFRewgbwSQr7EkQ=;
 b=DU1YaXeXm7Xtd00zjTOFGE8SA/rDXYkSi1f/CtVP5hx7iLeQkdq/MDSPWZvJDT4gc1yWObI+pixpWVBYXP+aIU8wawc1Itoftl/ba20R+5uEs91ZB1oUZtbWMapku2nUlkgT6YLgFdsB6B0Ve7gHqh792msckScajLCSHZXyEac=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5006.namprd10.prod.outlook.com
 (2603:10b6:5:3a0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.17; Tue, 29 Mar
 2022 11:26:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 11:26:56 +0000
Date:   Tue, 29 Mar 2022 14:26:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Directly return _SUCCESS instead of
 using local ret variable
Message-ID: <20220329112644.GA3293@kadam>
References: <d293aee5-6065-9d87-0906-438542a8be84@meizu.com>
 <1648551967-23627-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648551967-23627-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0023.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f791c2-7920-4b0e-9ffb-08da11770818
X-MS-TrafficTypeDiagnostic: DS7PR10MB5006:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB500608261D660CEE841BD47A8E1E9@DS7PR10MB5006.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WZIoM0M7tkygmfgdn/8/JKepOHDWzD9PVf79ttWybAcSBQm5M95knLtQmH7/HviiNpy4zzJpO0HCYzd1dVwZUW7gyNyYkGCQRymY0/HUK4OxTuUbiQmWrAnsQsgh+Pdba+kiiKBunxNOBdf98ShlUtmAxFi54QUSD/gw/kQqP2NQ3QNkTgpEOBdvpKGKBAcakGMWNsM54AJPZnBaAES4jrUCs3Kf92SgdYownlVF+EeIYzy3rx+znu99ooei7tqLMl6PirUSU6Lcr1S6SaYB62cOG0zvigcTbnoIQJVF5qUE3nE378F4uL8zzLmkhlWz5mILV5iggregty2nLlDGGbXMldFPr0/nJ2YiUoeRYFbg6YipbV6UOKK48pWbObNNPLTZDb+bBBPR8wQEAuaEr69oBtxS0X9p7K8NTfpuwkPIM40s+ji7LJoHFLQTOuwH3T8emTJC58/Sb3e41ujWNrkPLCSEsohD1muCg3Az/MIyDJ0W5G7oKlpToYjsjRzja37TCFCHS+dudV/+YRH98Tde7GMqMuPN1CBc3vjXQR3e5l/6vn592/c3qxXIQWiVK2vpDXhtKV/qpWSMmrYY94yuRPw6Naka5LvLbZbkeVe3JFI0QOm35Fk35Y/E/NZiXvA9v6HFBh7GkkX0jM/J2oPzkEd1+FbLQydYSUFilcCaZyouhM2C7WHPxqwRBeobPg+wgab/aHREgFp4Sx5nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(33656002)(66556008)(4326008)(8676002)(1076003)(186003)(26005)(4744005)(33716001)(66476007)(38350700002)(38100700002)(66946007)(44832011)(6486002)(8936002)(508600001)(6916009)(316002)(6512007)(9686003)(5660300002)(6666004)(52116002)(6506007)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6OMzYYSBKoaenhulcoatQeQHRM4R4+s4BxiuJ5L39bODeEaaNY89w0tb72aG?=
 =?us-ascii?Q?M3Tnm/bZXTyY9mGEy2vKDkCB1W+ehhLtjj8eg54PplDUfxL6OjVuMtfweZzB?=
 =?us-ascii?Q?BJ+WHRvoWEhaw2iIYrb3w9dkKsxamGLZFEjI81iDRo5X6EtoaxqRumxK6wbB?=
 =?us-ascii?Q?F6vYzTwm50tHU/ESHZzLC4xdZ6KVb0AlzgGbtzWvDdl435ekN+KIqA9ScV04?=
 =?us-ascii?Q?3W4NrbzGE10XtoaESgCLcyy7a+zbHvXVJUopSQIRAcDuCVw7ZT5JAojB5lpU?=
 =?us-ascii?Q?aUcL4V5ZJybv8f4xObp74uAJ9uA8/8mAKcQqPlwUxZs5pyzkcRs8ILyXTZGE?=
 =?us-ascii?Q?wyvTkSEG+qgqBy7kPh5Ymjto8RNxJCcRQCkj9BD/ajGuF6SHvjGi01Ot75ZZ?=
 =?us-ascii?Q?SAFQTm68CDP5nzX41oK0mEX0Rz/fQ1+eHDlJsv1/7KxeH+K4DGtUhLAZHSzT?=
 =?us-ascii?Q?JfglS/Tewa0EvrVuPcbDaYqMOEdJuGPbUsV4z8BH7n1oFnhTmeL9QpYae6Cy?=
 =?us-ascii?Q?63n8c0DKl9kkDZrxQoTtLDVm9bcTeUmrWwCKtFhlt5/zcKMsTayTWpE1CbSU?=
 =?us-ascii?Q?CR+NsYTm4nTRjp9XvJMIlMPvuWvlpY9euVYHvj0Q7WL6m7fa6MGptNnMmMp4?=
 =?us-ascii?Q?id8ubj0NsWe36wrINw3zLyWurXtDxck8hcXNyjDZxzeOokIkjeJ/X0UdEcrl?=
 =?us-ascii?Q?diCJ2IWoHXj4RwwtcMsGwb7TBZbemzlSgS2OxyD6a1+n5txbBkQVS/lMTU1x?=
 =?us-ascii?Q?Qb8hP8hqWZVq4Cg+TW6QGttzvgtNylgvo3T/9gxq3ekyWbZwWH9OalP/GmDT?=
 =?us-ascii?Q?7cBf1iCkspv23QWZaLiGUNrMPNSg2cI1yqJl4COhw0h9t9eA9PehqMNWd4YG?=
 =?us-ascii?Q?1CFCfras9yiB+LFujNdd0zFYZe7UX2CsFQSFgWNrgvsAHjdHhxDUcYOTHjOi?=
 =?us-ascii?Q?hfmULB2CI5OzvqhsX5jde9+dIuFmFWxlbrGrtxtu7R6ZD/Nnxl3WF1CNna8h?=
 =?us-ascii?Q?c6JgpW53asUmBLYA/H9J9/zdqkxDA4R1OEjKLohsCBTF0zzggbTfJIZWXjPk?=
 =?us-ascii?Q?i7wpMBArNxjuod2oNCW78dyQEh0ye6iABc6YXE8vqfeBPPtJrET1FwRrHg/r?=
 =?us-ascii?Q?hbzYvdIcZ/JqxdyE+mm4VOZwo6fXkfiXZCceJl/f3fT5X3eaUrDrY/m8vv80?=
 =?us-ascii?Q?/v1Er2zokH8kbQxh3q1GNGiPxSm3R5u/CPabDYHd/xsnsj4IiGXIQTjmAJkJ?=
 =?us-ascii?Q?XywXQ6i1IJ0uuz3lJQlgKFYJObSspqKBwVekZ4shMq8W+FGu6GAxRmroiNpI?=
 =?us-ascii?Q?KsvIZiRP32XRIQwHLvLnj66NH+pXZRY0MAnfKhkMCG1LJ8zCco7tnKtYgGaS?=
 =?us-ascii?Q?6oEg/IGLI/Ut7u0M20aZDyvj2chfRq2kMFiXBzewQValq+G2ASeYTwjQyYqH?=
 =?us-ascii?Q?HsErIrLc+XipA0HK0fC1lbJqZecPFVuZ7KlSyLDmb6WVhEy63sygxjbG9i/C?=
 =?us-ascii?Q?fAv+KpRv93b1naRmyFy67ju61MOQm7PiKOUhdOZfR/4dG7c1RabKzgadGKLD?=
 =?us-ascii?Q?oG/OF5ZYW//mpTeA+MqjaI2c9afmsTJUHENUSgykkp6gmHk+718EiOX1XLn1?=
 =?us-ascii?Q?Melvn52/hIyg/Giwlh6lyDNSIvtZhAD6qSzCe4/2BLNG44iSffEQsAfD2L4b?=
 =?us-ascii?Q?Dx2iF/bnIOIgcCzKC6xequ3j2V7KMt7f5L5pU1FWv+ItIfWr5qC+mMiJkK6X?=
 =?us-ascii?Q?9Ggnc8r8aZkTdsKfMk5Xoft+sDy7pFo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f791c2-7920-4b0e-9ffb-08da11770818
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 11:26:56.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19RyOYXUQLbekyyqI35bWxsHClTkCYkC9f3M1cnDxDQsbnabDZyeEwuwwXapg6IX12INSUHdBD6WzvLhHZsltMWruw1ME1TulZauSR2vZhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=847 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290068
X-Proofpoint-ORIG-GUID: DdhGrKs1Qu-GzQ8ZWi_zO7xox4u3FmgJ
X-Proofpoint-GUID: DdhGrKs1Qu-GzQ8ZWi_zO7xox4u3FmgJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:06:06PM +0800, Haowen Bai wrote:
> @@ -534,9 +531,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>  free_mlme_ext:
>  	free_mlme_ext_priv(&padapter->mlmeextpriv);
>  
> -free_mlme_priv:
> -	rtw_free_mlme_priv(&padapter->mlmepriv);

No, we still need to free this on error.

regards,
dan carpenter

