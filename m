Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967C24A6DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiBBJZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:25:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59488 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbiBBJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:25:30 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2126PZjR008544;
        Wed, 2 Feb 2022 06:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=PD2o32/tR1HEux/tumY0kZL2EyzWCP8IU9ni8hZo9Gk=;
 b=qBgYl6ZsPISbrdatgrtutgB3LGV1IkKuQrTsXrXiRB3hwtXFxv8bNkFYYgLWppmFwEyp
 RTQg72CVRNlD3X26sT/2c3iMwinLj0SQNSM418lKE1H9h+WnA6CtxjjKtdLMg9l54bY2
 4WXhZKzoe5KpFp6IgTOpW0/xz4Ky4YISJjUhs96t4oQ0t8paGY2BMJbp0L3dnhCoL/yO
 metMGvBn4NxoWM1CnEiSg5riEhyrzYQugnykzENNkUSPytnWFomYSfoSWcrA5hG4qVxa
 U+D8/BghJEU8N2PS0azDJ5fTZJtNSneYF9s/oPt2v8VphDu+HXpTVvBKmMCm33nwwOv8 vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatw7xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 06:47:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2126aA5h103043;
        Wed, 2 Feb 2022 06:47:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 3dvy1rjdu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 06:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frJlNzdVRVy+Xs4jpiuh2exUP/5rieqkQX7sKfmAKWwoEp2rZpeCl+CxMZ0w9ZmkF+IbjZ6LYHfGRjJG+GMCqP6RNkLfooANsBQnNzrU3oI3mc/O4y9ql+kQzHNpwIDQrpdfQEF3EqAl/qVuHdg8nYXpPdmzx5g0UdPXTkFEhOG0XrdzdRotcMN4jPwHcRZc518DLOyItpOgWw1vTNZnpus1VmRSbP0vMwB8zRbva5WzZmSwj6GTCYqA/c51bCWq7fEBbuldwf+++p6XQCqxMUBUZQZ+Z4ThYNF7z39t4fPOVYtGvNSbOmrB2GMblMFej9KfeDeYHSO9UFe/jEfekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD2o32/tR1HEux/tumY0kZL2EyzWCP8IU9ni8hZo9Gk=;
 b=cYOikhKw7090djfgC74AbWKQknC4pGy1CYZP1qGjapZ6NvxgPg164cw+4hnxi+2H/R9QOeApmd/Txxb2vnH52ROGdgj15HayIq2HcskRWOJDlhzQFFLaatDGt/FlIxCyGhk2PHlmRuP/ec4pfXVDs1Z1vvggYDXB8+FBcFR2F/Kp/QKdCwKD+14vfs1FFWhGfMxi0Io0iJXvTeebhpYEw9SGbd+E0sd/HU2GbljvQBrn29I+sAQvtXPPmKLNsK/0OP7vV3fA9/QPue+iDkQNIFyb+Hq0Ns5yqQYDfeDWaLfFY007DFZoCI9CUCaJyXhhTc0Z7a/KE2xFDOhS8xxQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD2o32/tR1HEux/tumY0kZL2EyzWCP8IU9ni8hZo9Gk=;
 b=vWRlnrfsVIs78vZEOd1ytEqlp0Pgu6Mj3yjNJwq79HbTjfr0fdZgPMJoqbCQUOET7MoylyBVWTp+bLSVE3zHKTtXp5/0OL3Vde1X1m7FgVNW9Ye6Cfe7FkAGmsGgmKjBxTB/KpJnb6KaVKicqto0doC4uT5tG13wMKw9YeBenDc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3834.namprd10.prod.outlook.com
 (2603:10b6:5:1d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 06:47:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 06:47:42 +0000
Date:   Wed, 2 Feb 2022 09:47:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: r8188eu: Fix out-of-bounds error in
Message-ID: <20220202064721.GT1951@kadam>
References: <20220202052741.GA238470@embeddedor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202052741.GA238470@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5abdbb3-5877-4b97-3e4f-08d9e617e91c
X-MS-TrafficTypeDiagnostic: DM6PR10MB3834:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3834B9006AE6FF353CF2659D8E279@DM6PR10MB3834.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdHDcLBVmBzat9QYnNsNaqViWy0nI7mpFdBTnyaphqAZzbUt7VpN1GCNlgr1hAi20yx7DTAWSypeViZZg0s9ebjg5SCpfJldKRTYOM1Zg5rA5dQEM08av58HuQJRU7GzvS6+XfquSuLsJ5WM91oF3xu3YbVqfe3fFTWTDHXfjiPEx/DQkLBqW2kMSTsOa7uufMvhkPIrqX9agPJQfBKDOgN7OF+7DnCNeB9YmF3IpipRg70cTtteRnBAdzIAx+2aiSZGq91zQZqBdroFxAfzvppmMPZ5BLog5YDlDx9qYqrgsJSRLHWtM4SNoX6Q++xBQhxV12oTFpSvqQGSm1d/no1sLQzAwAAfclX3wL1s1qXQpb9FXvK6uYLelba4FumdlHs4Q59m0lYy8cvRAcwK01vw0MrHdvtaJeaJE/swo0uyD508F5wsmZSnaorkWwuHKrSSvc8c4OwL6SeJDRRejiPpYvA1FMtBvJ8+Am3k5dh7hjCifrTqylRhltSqXA6OqXIGsJjrLYcG4Z/Edc9ckr7A2EafqyEpJKPuaZAgX6lqGiu1p4FobZrBIKpPIre2/pdU8MkfQKDiLARLQ9WuEQkDoEoms3UCx5i7S4GmDHB4hJt5Ww9RN/iWUPQdlrA5IsHKg0xaZUc/y40spciPuDEHa/6L01knulZ8zKBpdAPCoMqQighPjVea8cxAoGaJ6a1ypnBF41RmqJPCHgKjqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(38100700002)(38350700002)(6506007)(508600001)(33656002)(86362001)(66556008)(8936002)(66946007)(6666004)(66476007)(8676002)(4326008)(6512007)(5660300002)(9686003)(52116002)(6916009)(186003)(54906003)(6486002)(316002)(2906002)(4744005)(44832011)(83380400001)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tci75pyPd2FubIvPXRsUsJ2x6303Qqh21Z/vu4yvcb10LmpwyFUBZjqO/5pM?=
 =?us-ascii?Q?oGHUGBzsm2uUFS+vhUqAnDjux7DOvCoOfJQX7A6P0g82YebmxETR9BnH0F12?=
 =?us-ascii?Q?iS+EjarYcGdAa74PrrGnqda0OuoNbz72qb9AtRATG/E9VhGe65Z1ckNViUI7?=
 =?us-ascii?Q?OOwn42xD1mH5kM9/1ptxew6VI7cH1iUKA+kT92WGyiObdkrZ5p9XDjvzNnFv?=
 =?us-ascii?Q?tpn7rRWp7tttwoc1KT0fnS7V8LhCVZZZQQn1OjMuJ/L3RtH9ME+4AQlN8Ye0?=
 =?us-ascii?Q?oHTwSDgaIyhF39SEr0SwmFYg18UlNCv5xz/D0v56t0wPaCUdPs2Ixq3QegyK?=
 =?us-ascii?Q?sN9FHrDpyiVZVlBPCiuGDz5DpHSqy7RtWh1zBX6DBSdQQFUTcdeudFLyxxuL?=
 =?us-ascii?Q?he7MYp72+DKdYGDztKku3lgoEFREM1etJxqSksG2iinVtdIo21oO2km+cyXx?=
 =?us-ascii?Q?fTKE59I9U6FjrtB9ltdUar9ZP7DxRXWUnLRbdGHIGZPhGYGnyjAllJKQoWp3?=
 =?us-ascii?Q?5K//IXBRlhmx07U4Ft3/mQvqWk4fsdPL5QdDYuSUUUJcQN/YmE9IrmFZywvW?=
 =?us-ascii?Q?er9RIGwV9qqcYo0dXemC+VWB4/iGsjlBS3KOtwe4IW+ta+96VeGWa9rkLEEV?=
 =?us-ascii?Q?3+dHVZv5pOrVyfQzJzujja1oXxOCzBn+EHWZEukC1J0b9cqgzXhzj1P0xai1?=
 =?us-ascii?Q?BGs0dlQ1oirihCzzQICBMXH/0AOIXvdB+lwKoCDNHZLrjmwhnpDHlwq/CnsO?=
 =?us-ascii?Q?J2e+uRsmwo1GQBrIgKICODW90VWfvRl+b+ctI1NnLkODQskr/Gvo7LQhMP/U?=
 =?us-ascii?Q?vrNpTklP8vUygGzzQ53HRNDFQ8t3RcxaEKyh1AzHPBrdZn99qDDPxGJDMutc?=
 =?us-ascii?Q?VzdoGi4Y/wO4tLriXyz5wjo73GURZgxAUi9i0547/yxYd73EG9ZrZxNHC4kJ?=
 =?us-ascii?Q?wXAW1+grG+/BIVFrHa2wdkcnhq42n0W8C+gH8oIsEsdAKili81rIq5/6gxMQ?=
 =?us-ascii?Q?YKc8V2HQ2TtqdKzMXNLzGZemqoprl1Ju95XgtCtTFdosfxn+ty69aAKmaAoi?=
 =?us-ascii?Q?YQaFcQAGIzWVgopX4hGrF1WXTPTQVup8O3AyuQMn/4o6YmcxZW3VflMSR7P+?=
 =?us-ascii?Q?KCIXAbfIfpwNuIAPmYOtq05KGmTYxE4AuwSS5I1/q33Qx8tEiyNQhtRTJu8+?=
 =?us-ascii?Q?cK3s/BL9AQbgWdINkoPKJbYO+OpqsaOwDDxeBIGIwy6pX08bTYvGsmnEnl80?=
 =?us-ascii?Q?O32PE2HMPXI5/fG0uKzNjCAXubF0MBgC7kOe7eyNkdOgf7Ccj4ciC/sX8Wi2?=
 =?us-ascii?Q?Cx1VG9fUEcmkVN0zLywyD6vLf4S5VHvwUb1XEseZXEEBNoLJmz73OvI9WZOB?=
 =?us-ascii?Q?elNXXVXE7ZZsD6jX8hWKwQXCf8NevlnQWgGQrAyb1k7g3vTqE/tM3Q4STZqV?=
 =?us-ascii?Q?8xmD7j0WdAOB1MlS5g8ZG5xkOZSy9ebK7+voWJhQznWEHQi6wcUq/3Gq1oai?=
 =?us-ascii?Q?FaySezXR3VJJeuoUEm1ad7p5foZO3sKknZGjmdHIrG/8weT3pS711rd4io3D?=
 =?us-ascii?Q?dBmjiM27GpXfkiAX4UqCzmRNI06XCOWIrvIRqheabSWSpJI2Q7cwkSRkVueU?=
 =?us-ascii?Q?vsNjh3tHHD1axkIggLWujiNj5wRfZ9aSkp1T8BTL4Q9lExngIbI+Cknc6d8n?=
 =?us-ascii?Q?lh04NPq++AyvYmFoBrcnq7UJ/hw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5abdbb3-5877-4b97-3e4f-08d9e617e91c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 06:47:42.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvhG/ypaLW/UypxGShiw7oxHo9ss92rrAW4Y53MCOFHcmNy5lkjtFiOAX2+33iCEBZyogU/vt9JAmeQHJEHTrHp4GtbbzSEmFNGYWWVIKRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3834
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020033
X-Proofpoint-GUID: U82bsCvEBcdDrQ_EKVp8uzEhOAp6BqSu
X-Proofpoint-ORIG-GUID: U82bsCvEBcdDrQ_EKVp8uzEhOAp6BqSu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't put "Fix out-of-bounds error" when it's not a bug.  Change
"Fix" to "Silence" and "error" to "warning".  Or just say:
staging: r8188eu: Clean up flex array usage ndis_802_11_var_ie

On Tue, Feb 01, 2022 at 11:27:41PM -0600, Gustavo A. R. Silva wrote:
> HT_caps_handler()
> Reply-To: 

Your email headers got messed up.

Otherwise it's fine.  I guess to me I would prefer just one line of
sample error message instead of the complete one pager.  Please resend
with fixed email headers and add my tag.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


