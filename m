Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9A4EAC50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiC2LbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiC2La7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:30:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643A821BC64
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:29:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oVJn017309;
        Tue, 29 Mar 2022 11:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HGkGL6xSCxJPwQsE7rhrCEYZOGQ/uJiEuLvBpJ3ofrs=;
 b=MtJfYGAvxbMj06/qfBk21G/40GGyS08N2xiOiVrbSWsHdQ5gr8FdSJUtDSMS2tl9FRZo
 Wg4PpAFvXO1OEE2PYhusL6N94FDycJ9CdnWjU9Ly0P8Jn71+z2pwEoYGkOjHzcm17q2F
 92+W0RDOEuPm59P0+/hONj7WJxGIWUJpI33As8u9XlIZMJR0lezjIW9w+Jc8S12stSBy
 D5imkE+7UciosLkKW0beNG+ZKEEKDeRJOylTrfPKl8SDC1yRLPu00lTwHDWrnpUwW99D
 3GGrlm/AgC2tVTFzzi82buArI6zG8q7ZVZ2hlsfH1Y5gYRNdMaN8Fh5APBX93RmUbfeN pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cp6uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 11:29:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TBBABW041734;
        Tue, 29 Mar 2022 11:29:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3f1tmyk27t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 11:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8fx0AtzVwhtTchRqm1lvmnBALFxWs8xl1mmqWPReuRAyYxbXbSPeTbv9FLMx+OWlLT+aGbueiNAZV6cP2n79xGB2CtnF56SBCY41YsvZQdOiVEoNub0e1LyoOtfM7Q3TtLRCXltaP2rqeiLenMt7fWxS92FaKU+8qtK0xbtLaNYQu+yGWYC70izxxwKtDpj1ds+I/Yig+rqxiLoGbeVtBrmqs7M5V0colGQIai1ScLFhi3Auo4SxeHXLH4SzSfjnEXxKY6QiS/9dvi+g6MzGJ0SBRDWeHCjDWxnXR1J0eysFEa71XgyutKtV3mAFAuTjvyCP30p1KuzSmBJJNw/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGkGL6xSCxJPwQsE7rhrCEYZOGQ/uJiEuLvBpJ3ofrs=;
 b=M7QLiMXA3WAf/pqHoli8cms0pwoEuXdSFGEBJbFXzknYFPmrY7RNL8hidtjUIcgM3L5mlyMRqwp6mW47Z5bstwu12UFFQSKfJ00JuVgrfbTkApOq1LgzILlL3n4TE3+6JEbTMm8z8l2J9ghYYaMm/gCtcBPdRMv237l2f1eMVH0EjWf+s/k1bfIdUUB0Df//FL8aOO0COxXe3zCa7+xN4TemNMY8LfKoFaxr1MYDDbmtxgpLmSjOvPbPc7t/+TzlwlrXIQo4FI54Pd1yVjUVBeYJa+ERQlws6uvwGr0+6d75ShIPov0uQExkLaV61XeLf1jTgchARntdynB9FwsNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGkGL6xSCxJPwQsE7rhrCEYZOGQ/uJiEuLvBpJ3ofrs=;
 b=aVnyVcC1+G2bM+cjebUgCA1h40NzFkFxecJEk9MBl7AvT03/O65BW7r5B2rnEQdctlU2TSTJJrt2HAhpBwBl2nl9H79WRcr8Csdlhgn0BeCWWh94qQkxxbBn85zVH7tI2Q+O77EnQ6+SA7beD85vhD3CUqfTJDtRUWgs2XQg7vA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2223.namprd10.prod.outlook.com
 (2603:10b6:301:33::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 11:28:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 11:28:58 +0000
Date:   Tue, 29 Mar 2022 14:28:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] staging: r8188eu: Directly return _SUCCESS instead of
 using local ret variable
Message-ID: <20220329112844.GB3293@kadam>
References: <1648551967-23627-1-git-send-email-baihaowen@meizu.com>
 <1648552158-24203-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648552158-24203-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5643134d-aa19-41da-1a2c-08da117750fc
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2223:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB222373EF73B71471E5D661E58E1E9@MWHPR1001MB2223.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHqcLFTm1sURk5GQMJlxjeySIMPbKeazRwLlwu9FxS5OHHmKfhaih5ZQFmFpW2WzRYP3AG2RWqdJ+FksNFjvZRxH3CxttSIf8Lsr2s751+ccpsxQvtTYLVoOQQaAOhN11nHXtknvYAN96bRi1BkehQl0DLUIEsqMDX1a3vKIr8EahH3OphT+A4rJtfKInzEaRgsqQDHP8RrEsRCalESpMJFntj2rltPDFqtdMbnJmZNueqTziNJMXJEd4vnt6Z11aJYR/XA8ejETBnCoM8BaoQv9Qo8g7yGJEPIVeTS7Dr+E5K1nVFUEPydEWES+EgkHRiiAXAA7Vim0gqAf05eke66vibea9hxMxg7v8aUjXZCK1SOMu7kk1dax8rOjG7smTQ4HwwfYWHPljyMFGO1pvfkYdKxz1Ry2/ihRb2mWv3Eljt48G5KZHXbn41LHkX3BeH3PqQbUrZl+KMCVsxgt9qB8xtMUVodd2nElrSKf6+OC4S2k9XPb4jObPcBFthgxO+tkPk/gkMmS0QR+ccLm79peDb2vjI8z0XvzeHmF0heo9X/WSdAkM9n3BPYlUX3lAn0LLv/9TG3O7mxa6v1tWuJ1zQxcFiD79jQVc5baKWfe0XvjyaCdxN49mHzJxqA9q3q+2fgbCO6JlV1RRCSYsDeAlMAf7QjG2RkTq5j/7TikUAsn+37DmLbhjpxMn4b1x6GBdE4cfK/8i6DHjXhozQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(54906003)(38100700002)(33656002)(33716001)(6916009)(6666004)(316002)(6506007)(52116002)(86362001)(66476007)(6486002)(4744005)(1076003)(5660300002)(66946007)(508600001)(66556008)(26005)(8936002)(4326008)(8676002)(186003)(9686003)(6512007)(44832011)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0jPsKBUzGuh7yDvDn2a9/7j6nicWtip1SQg6ZOK9zugvvOyv/apHRZ7b1lJ?=
 =?us-ascii?Q?Fkp/mGfGb2HEKK6cvESwoogR57Xj9cT+vf5pem1Uqq45X79WdhebsB1PYeB9?=
 =?us-ascii?Q?NLISt9Qlujn6ghKAzAjIvPCh5FOBNC7SbAkwXyM0wmTPNOSHsnxYLGcJni2m?=
 =?us-ascii?Q?X2am9nt4XalDygzfptgi0HFi65GsDxyuFOIIdmRQWId+FQRz/JTFC2/QZKqp?=
 =?us-ascii?Q?jPPavUlNQKAxcwgkaweFobYQSuPzlEzvv5kFz9xQ8BbhCcLFpigfpsA1T1K+?=
 =?us-ascii?Q?Jf4J34JU4XuUUY1LaRJ41yYEdHrvBe7RxuL9xIMtkehVa+mMP68hZiYks706?=
 =?us-ascii?Q?RcRbI4WSNKulh2/ClLqcsxiWzhEvNMEH+fl8YChc5EtqbICXFVvqlWn1/QJE?=
 =?us-ascii?Q?BQTNo/7KXUphGjNAzxRIbXXuX+reY62a+jRoOQ1GwLcGqJDKQWQ0RnLtR7cI?=
 =?us-ascii?Q?4/tCwnSfJlB69Z29NUM8bRKHj9yrb181HYM+nacmImmxK99+G3OEgkZPc4Js?=
 =?us-ascii?Q?GG0Ur1/dS7WnfXrqQOARHTv8DD240dj1fGoI7vNOs8YiMUPzFbvLUn9MKoCn?=
 =?us-ascii?Q?MlmcG271xHW2cSndO23C7yakKPpwtXI2zzEXYevvLt1Rb1y+eA0FEMDZLD6L?=
 =?us-ascii?Q?hLT4Q7htbpfTwTszRyro6gYmGZSdgolhzvU647RP/X8mkd2JBkJhodtfccZl?=
 =?us-ascii?Q?cVUuSzqK82TrD6va4VNTEbv+AeuNHy6xy8Ac6Fcd4q24UD0QJOT5GarjisQH?=
 =?us-ascii?Q?P2wy3i9sdxmsuCDt5EWNf8A2A+vg/+LqrguNnjsfHmiL5f77z1FgU3uovrdx?=
 =?us-ascii?Q?1IlTat2j2zQxLO2kLPgAhbRhap9TydIhUPMkCL5oTqOEYpATf9VV1/n30qHg?=
 =?us-ascii?Q?0ENrWeRkjEVX6qhxgiwJ1Bd0FmGT5Y+wG4jFz4eEg85MF77qglcasWtswmDY?=
 =?us-ascii?Q?Nx1wvylkaAsyzwTEKJxSFsAr3FmCWZ//rk1GFXl38us0JNmgO1K5wQSGOxrJ?=
 =?us-ascii?Q?VQSSUDMRgBhTupo3nEXNo8HeLW+x0BUvHcrS0g5dbYJE9fXr6NPH7YtoAHIk?=
 =?us-ascii?Q?H1Yr57ubobOuTvNy8ya/sfO5WA/PBpwJygQyXIO8FoLdSYNFbXKiaJhFwkpJ?=
 =?us-ascii?Q?Zk/nacTY9oZnh8sAepFYEAvUEQxGiq04y/tiDtp52h1lNAwd8T6L3Hlt3rLT?=
 =?us-ascii?Q?z1KiuG0EdDvxYn4PrsdJci1i4MBQIs5xbKNMg+1GYmi18cLBUaMNLIkYMLxy?=
 =?us-ascii?Q?NwXZ12MSLWyIFwvEN6FzVkdi/XjEhg0CI1geItyGzFYLvudowOq9Iu3CFCBP?=
 =?us-ascii?Q?XbzPEGOqjyIaG2YIY82vxu9hoeJfuGnPiK055VCiebsBSvWjdkBkkuDAqJjm?=
 =?us-ascii?Q?J/8SJaB7m9wLtNRmEg09vk068rT8xGoU97Ximv+JGi4GbEOfpWuKE3EEmZvB?=
 =?us-ascii?Q?eGbF8+dLEahxL08Gjchtl687ztMn4ZYUG78rhogVvQ+4CsiUTiF1TNTfAAAU?=
 =?us-ascii?Q?UryiJawst3DgfqKG1TvhBBJLraI4Wb+9YYwH546HuguIINZ2IbNt4/Nh8N73?=
 =?us-ascii?Q?awWsd+oHlwrQlgkfeb3Lk2jvrZDCu08JKRC5+MRuVD+jZ5m1kc8QhD6FA7rn?=
 =?us-ascii?Q?WZWv6bBqeGDOsitIRWb3W1AHYJiH5pRJA1X0g202+VkP+7bRS1MwxEoS8C3M?=
 =?us-ascii?Q?6YGMKr2/JzqhzkHmnyNEOFoHMJkb7dOJYlOP64uONiT7KCdlIQCzzlkL/2/0?=
 =?us-ascii?Q?+VW9P+WtTZ0bnWCRJbD3qOoOWVHJPXw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5643134d-aa19-41da-1a2c-08da117750fc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 11:28:58.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAJ+Y+UZlxdYqdYxF1GZB4k29Fn649KXD13gZLuvBk2BHqoesS2Y7XG1W5R/2OBi5AYxrTCv6fLB0QAIs+fOGxWT8zZIY41eIZVdg7tMiLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2223
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=878 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290068
X-Proofpoint-GUID: EOT4TWuEbKOYJ1_NU90BLFINw6Zq_uaz
X-Proofpoint-ORIG-GUID: EOT4TWuEbKOYJ1_NU90BLFINw6Zq_uaz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:09:17PM +0800, Haowen Bai wrote:
> @@ -534,9 +531,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>  free_mlme_ext:
>  	free_mlme_ext_priv(&padapter->mlmeextpriv);
>  
> -free_mlme_priv:
> -	rtw_free_mlme_priv(&padapter->mlmepriv);

Nope.  We still need to free this on the error path.  Just delete the
unused label but don't delete the free function.

> -
>  free_evt_priv:
>  	rtw_free_evt_priv(&padapter->evtpriv);

regards,
dan carpenter
