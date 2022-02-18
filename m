Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC64BB6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiBRKXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:23:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiBRKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:23:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F432B1AA1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:22:51 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21I7q3k1021769;
        Fri, 18 Feb 2022 10:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=W2s3Pqit2+GxHnAR+JhGmYN2lIAR+Hr3rQiM6QlnBkk=;
 b=fNQYKAVknWx6RJj54GB4/KjO3/Jaut/+gL5GqK15OzWBQDbXvR4VL1ohMAWyHAL/YTrK
 BqqXYoTf+wWwjLHSiOg5+vHNiLI1OMlbXvTu0wYJ/jnnNaklpDcXrJaUEV3NiRWAeSRm
 m6nhvslLz44D/49dAae7lUzSDoCFxb8HtfOWzZQOexRs/xHOHEGlKcwhj2J+tI1+ZkMY
 rpqDte72Rfn5l5xQOqweGEssAXU0aiPz/V4GqjQFeLL+8Vn33edn4VT/kU8rw1nDSDBK
 OmS91m+gPcB7xN3ugYV7JcWbT2ZtnG3GwKHXUd3jqzv1QJyfE3dM1i5iN1Ar0gggpg2w xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fgbpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 10:22:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IAAdoB027572;
        Fri, 18 Feb 2022 10:22:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3030.oracle.com with ESMTP id 3e9brdjgk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 10:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjvF0L78mLPI2jYXx/mapr6HXTBwKlR2O//MsVshpd1J1T/mg9RyEF/GZbeMhHcrRqwWabrpm0eCBkjgrtHNX+IxPSSdkw2g3b+MbYM+couYVpw78aNhuntgdrVLAm/mnv78Q2WaLrB6lLzVGXpb3VD/pJ83oEWuaml1gUrB2T48poRelqMAnavZoUNPkk4+tRBVZ/L2aywmv7cIuNkKhxWRzELaqqm5PHIcJEEs+sDyzr81PzZsnBggTiu6dsroWq89qMI2os2TkBVs89RbnAyrxQHglGCuO6QfHKFCEn+mODqtrrEDMJLR4EM+Viz3s8j0xTRezh2jnXB3pbPKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2s3Pqit2+GxHnAR+JhGmYN2lIAR+Hr3rQiM6QlnBkk=;
 b=g5MnLWOPJljd0Sh7Watdv9xOuyK+s8pXae+g1b+3eKq8OdFsZOD//uCKxK6CLL7qB5VQuPWUGD0Csr80vSC3VNMt8/TkIR56zY+Ln6itYpjITqtZ6Vabv9xi+iPTCNZ/4GvBbV2WGTW4yVReIWbVY5OdKGmR3zQyfseIWiP5AiDEp1nrK+NV6ZeLedKC5bAmPofHL/18ZOpS2K4neBGzL6arMGuoQVkr9Tlru/rxVeUPqiZ9mH8+GMWtaDq7b7e/gptDfspK0FgcH+xlhUIbMGXS958Uldh8KDB5vbxU/0coAw50ZiRXd3s/51E9/HSfhTPOgKIYaDIh6/9WYLCdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2s3Pqit2+GxHnAR+JhGmYN2lIAR+Hr3rQiM6QlnBkk=;
 b=bi3HQPTt8KWH1VYmGEhwVswoI/j1E62djadXbyje6Wau6d1OkZ78QHrFDpAmGd7PWk3tiKm7m323XdJCutNR0BD37N+hgwcZe41XQ9+yToAhEyYjmE8mxsxEEniZl6mlS3eCefmZRwXEO8zUAm3WoDOx5joQJb9y8f7qtLztcjQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3670.namprd10.prod.outlook.com
 (2603:10b6:a03:124::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 10:22:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 10:22:37 +0000
Date:   Fri, 18 Feb 2022 13:22:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] staging: r8188eu: comment about the chip's packet
 format
Message-ID: <20220218102227.GE2407@kadam>
References: <20220218092252.853807-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218092252.853807-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194f958e-b847-46d1-b190-08d9f2c895a7
X-MS-TrafficTypeDiagnostic: BYAPR10MB3670:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB36709891BD0B5B6CE1E7E1DF8E379@BYAPR10MB3670.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcvFw6WDPN2uniiRUWzwiP2UNJpMHlhrnnBuh1mhRjXGBfXo/UtNB8uCwfleTIXILCNd3Roqcf592Rdekl81TTISy+hBbLIPROKnBwjczR1vITd1GUe1Ws4ecgG7QP+K0n+SKQ+6g32bdSr9machCIvMZQurVVZbzaINEXDQXNtVTRB0LqMAe6eQAnA2GaG40Jks6hSpmY3imCja3Pf4s0yGDEjQQhzOLvMINyWc4/rpHaE5cIbahDiu7GMAnas7jhM0QxdXxkxb4eBvLOLNV1sna3I6P3WUi0/7F3HBL5rfy1U49W0cippFmviLZtnMeMX0ABhe/F7pp1WPCV92zl0TZq7ch3WFiKNvZlAIikiVu3qWp3Cbo3+xFfA3EWOVr9raMP8BXDWmmRwgTj3cSm4vDUaqAl6HMBDUb2ZEYsm1RZMOkvNAVzESL1sHpKBDjxMjWar3vo5DIH/ApsSOk6qqgf2f6aHeV7h+CyjVaF/n8cxUqWS4SidtpAH4O6k5phfUOpiCR5M6KVGDvfSnsY9qHaVVogwAgCBlFRBPiRXcHQ1RAz1cCrBZSaV3J87m46BYKRgqPeGlFDsdPFiTVwEXyAVmAH3LYPuSXu4q5sUHRUKA9KASo3995Dm47pHSN31u9WYhD39mJvYpWYAbGgO4t7256y3ZaYgMndIbu4u4wvuxU78JuRMR0javc/r9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(508600001)(6506007)(6666004)(6486002)(2906002)(86362001)(33716001)(54906003)(8936002)(6916009)(4326008)(316002)(66476007)(66556008)(66946007)(38350700002)(38100700002)(4744005)(44832011)(5660300002)(186003)(26005)(33656002)(1076003)(83380400001)(9686003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4m02FVQL1U752QA+g79i404b/1mUHFessyqRvBVqDZfiROz2As/OTneZgse8?=
 =?us-ascii?Q?bBdPGZ+yEZ1ePnkij8SAXJGV785MRcSRikOBzc92GnQDV5MUbSuqd/b6vBVW?=
 =?us-ascii?Q?B1HmbiPG23atDhtAdFgyvTXjckoopJOr5wOjJutf21wQI04W5wZOcX+UYOw3?=
 =?us-ascii?Q?xBqU5vytA5kgx5xnrhkBcdfhRX42C4TSFHv4xwKq0R7b56Y6rvFEAx9Ymyv7?=
 =?us-ascii?Q?DNgnu6gybmY+x1nXRKNYBjxqqzF81AFS1DjMO0IF6IdHm+PlHvoQth+9uN66?=
 =?us-ascii?Q?tuBXwPlrUPkEsFM+7o+1gf28HXjcqSUmS1qyeTbdH67MKDX2S3D08EmFHspm?=
 =?us-ascii?Q?SneNiWBEhmyuyIU8b2bB8EQorJtBIIbHQ/dX9Kla6J2y+DwQOsjZslHU1hAZ?=
 =?us-ascii?Q?Ty0tLCnC1uWXTtDmMcb29NcY5kkvu6QoyiAegbvaNqmndbLtUN/aCDbu9Jra?=
 =?us-ascii?Q?gpaLzd6boClY/ly7Nb2jVc/MNOd70NhtX5SY4Hso+v9WmnGNCBIMstDm71Us?=
 =?us-ascii?Q?0ChmfQQAGOtOGrt1CmtlgMBbIFlObuBqZ89MmypEfsAX68oScwBjL4Xmuhhi?=
 =?us-ascii?Q?4mry9ZPIlusEn7p+sOejcELm9i2kdmu4ruhsw9yIDjxDQ39ueKdMcrZ4USJ1?=
 =?us-ascii?Q?AZtzlUSuSkXpNdAGlna6g4EbwN+gVPCeOB7g/Jm9fuhWtJghDazpLtMQPzLQ?=
 =?us-ascii?Q?HQxZpvx+GCDvMvbgG4FyTzcjOpglb7Rl+oFiORMEuADsN6QmlZphSDxdCj+C?=
 =?us-ascii?Q?VA0l1gAV0kKHQsAHBLmFr6YzedJPsWTlcDUEQ3GxGwRpNUvZu09BCajX4b8m?=
 =?us-ascii?Q?BRPGUNOefd3yAFOJMU1i/nT9+/WC8Apf01lb5jyj+j1FeYPHvp2whTwiCOAI?=
 =?us-ascii?Q?5HzBFEElT0hZ2m/2xhTATu/OODWgbANJr4tVTcKLWORvktU5ZO2WG2j6cDKo?=
 =?us-ascii?Q?ko9rdwZ4j0KsIQSS3LUlTLoJ9VczJZkwYUL4fPihFGNmMK99okP5zfKbb/J/?=
 =?us-ascii?Q?OGDK0umQbNLMtI04QAWxYAv98Qe3CtMmxPVbKcg5VDabKkvHtprurw6IoqZp?=
 =?us-ascii?Q?cLFohVmUP9viaqBhctmqUbQNTUFNPqbhvQhPXxFMVJir/3IMH4LKT+/f2m4J?=
 =?us-ascii?Q?br1Cbe12G0B3PEyaQfS8o3wxuQRRn0KsK1qfIHxC0cDKkFP+MBYqLjZm1yF6?=
 =?us-ascii?Q?Tihl43DtTEfKKkMwbd6QVBZwFlbhpab/IeZIW84v6v6v3O7riZqdRIBlSPJy?=
 =?us-ascii?Q?ZQZnCZ7ITChVa0fqNHzHXhLC4WgsQNMqLnmfFTlyTy0GNm6BzMu3kDE9Xdzr?=
 =?us-ascii?Q?wjAQXDXpwnj/y1Y2zX8jmiz4dlBulO5lcWbOCmhejBiQ/P708wwc+be8ECc1?=
 =?us-ascii?Q?yruQMwubphLmjsPRb0YMeZpEefE8ic6m4kdIF69DfA6tntfnltMMOG0kU8w+?=
 =?us-ascii?Q?Ej1v1mhfXspZ4ov2ufTXGSPtRvvihjDivqOOeCRfabzH9gUjToEaXZMpb3Yz?=
 =?us-ascii?Q?8fb+kXPnAd/avV5smtPykRgfAsuCcurbr58VLfxpasM0ZLMqj55wukRgLhDR?=
 =?us-ascii?Q?kk8v4akdj44NParC19LTegGIDiXH+Nt1uShFEJscclS7CYTD4BBdOWi/bMlz?=
 =?us-ascii?Q?/baMLg72AqYrbVPoIfvFxt5bUSpxqtuHtZFTMHipW6MDs448P3wVCq56x5H9?=
 =?us-ascii?Q?yJ7Hog=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194f958e-b847-46d1-b190-08d9f2c895a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 10:22:37.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igyPKz+fR34MJUw/vAUU7hSW2yQc2BzuMzadeYCgx6DOVE86Qv3gY+2wIxpCD1QNFV1TWcpByb/8gI67HYVZjKXMBmuTwlPbQ5MUBuPS6DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3670
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180066
X-Proofpoint-GUID: KbI8JelOPDW6kWOEsv6pz7YSVjOpdHVw
X-Proofpoint-ORIG-GUID: KbI8JelOPDW6kWOEsv6pz7YSVjOpdHVw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 10:22:53AM +0100, Martin Kaiser wrote:
> The structs phy_rx_agc_info and phy_status_rpt define parts of the
> header data that the r8188eu chipset sends to this driver via usb.
> 
> Add a comment to clarify that we cannot modify the content of these
> structures and remove seemingly unused fields.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> 
> Dear all,
> 
> I experimented with "cleaning up" these structures and related code before
> discovering that their content comes from usb packets we receive from the
> r8188eu chipset.
> 
> Would it make sense to add a word of warning to prevent others from
> repeating this exercise?

Just the fact that these structs are endian means they're from the
firmware or the network.

If a struct has a pointer in it, then it's rarely part of the UAPI but
if it has endian data then it probably is.

regards,
dan carpenter

