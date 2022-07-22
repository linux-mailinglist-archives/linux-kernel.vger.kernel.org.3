Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3CA57DBB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiGVIEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:04:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04hn0227.outbound.protection.outlook.com [52.100.17.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CCC9B54D;
        Fri, 22 Jul 2022 01:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpyBeq2h0BTjBTQQTl84XjjVNrY/2GknKCq2ALsq/IK564SbK5dDxhjRFTn99Ett9I3v2mg0hTKvNueJeNBbA8xBQ8NPvIVnFXKnQ5kqMDWRZNsNB1AEyfnIe9FAXuI+MtuWf8gv1iaZ0emL8biaMPsEZS+BCImgRO/37KfyfrnLZDHH3VOwj1jXLFi4rI4hYE8O7npw+goONFsbW8nnRKpUKNpV39KPdCDpGMhKkVuCBWHClwvuoix2jySaZFFdcQqD1hYTdSi5JaruEVY80Ndn9qBy90312DVr4uWj99sXIj9zX/vnQZ70HausrcFFeNTPZMrIWSOCtf4iRrTOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPRvuS1lylBXPFPS7bRSqdxncLyN3FrXzLFg1hRG9Ys=;
 b=FMiwlrHIB7Sb2AgvKtyCc2pLLRJ0iZoDLsCpnJQh188/Agouu43oYrBerpGJ8yNrYNXS6yTvExEbH2W78Sqi/BksVkLIObh3/5h1e2/bAQE4GXIn25qmk4eSApxretftk2epZO3+AMZZHsLnyuq2y0B4mjO5lL+V5gXoRAfydfTuQ51qBs0ZNO+x1kUxcXmoxh5I62vFeMthUtpTpPv84XVNHORCULrpx1Kw/vHCHpcZsKpN+DKmMCGCNZ0AznezM2pgba6DZ4KBpmNODkOW2kjlNadCoIzLKLf9O2duCM6GIaZatNE7O8gfk4PF/YHGl81bhegPAYII8LT7NOt02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 193.183.126.23) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=hkma-online.com; dmarc=none action=none
 header.from=hkma-online.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Husqvarnagroup.onmicrosoft.com; s=selector1-Husqvarnagroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPRvuS1lylBXPFPS7bRSqdxncLyN3FrXzLFg1hRG9Ys=;
 b=kX3lXm0vuNHQ/uOJmyi7x5LqHOo1pB3fYZ+KXzSF9wXsfG4V+n5aJeXlZBEr/wnr9qE0JQ5ppEELYyyCQdtwHvSlDMoJBjZTyFA3kmLyKP/9VH4qZ+yFk/4A6AfVpuLeqbxQ1Iw/B2y5SEQItyUJbU+A0YSF6Fdj2dzsDr0ucq4=
Received: from AS9PR06CA0096.eurprd06.prod.outlook.com (2603:10a6:20b:465::25)
 by AS8PR04MB8515.eurprd04.prod.outlook.com (2603:10a6:20b:342::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 08:04:42 +0000
Received: from AM5EUR02FT084.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:465:cafe::c4) by AS9PR06CA0096.outlook.office365.com
 (2603:10a6:20b:465::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 08:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 193.183.126.23)
 smtp.mailfrom=hkma-online.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hkma-online.com;
Received-SPF: None (protection.outlook.com: hkma-online.com does not designate
 permitted sender hosts)
Received: from smtp.husqvarnagroup.com (193.183.126.23) by
 AM5EUR02FT084.mail.protection.outlook.com (10.152.9.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 08:04:41 +0000
Received: from AS400TGT.CP.ELECTROLUX-NA.COM ([10.80.249.221]) by smtp.husqvarnagroup.com with Microsoft SMTPSVC(8.5.9600.16384);
         Fri, 22 Jul 2022 10:04:19 +0200
Received: from [107.161.81.132](107.161.81.132.static.quadranet.com[107.161.81.132])
        by AS400TGT.CP.ELECTROLUX-NA.COM (IBM i SMTP 7.3.0) with TCP;
        Fri, 22 Jul 2022 03:04:33 -0500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Hello ....
To:     Recipients <eddieyue@hkma-online.com>
From:   "Mr. Eddie Yue" <eddieyue@hkma-online.com>
Date:   Fri, 22 Jul 2022 16:04:10 +0800
Reply-To: eddy@edyue.website
Message-ID: <SW022024AU1O6YalkXh000095ae@smtp.husqvarnagroup.com>
X-OriginalArrivalTime: 22 Jul 2022 08:04:19.0723 (UTC) FILETIME=[A55F95B0:01D89DA1]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de65085c-d94f-464b-93de-08da6bb8d521
X-MS-TrafficTypeDiagnostic: AS8PR04MB8515:EE_
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?DdIawmxbT5yoSaphJkXL4XSIsSSWhV5ttCO3/wDFvqnzshR1tCv7g9vjEv?=
 =?iso-8859-1?Q?bSvY7/jsXDXbdgjG0sRR2Vxs/X9DN4jmFPbof3b1a7CnvYLyLa5MTAAtgY?=
 =?iso-8859-1?Q?jTJZIZ2q4Fq7cdO+owKRHy3RJpdV8Y7Q9Ylq/n+kcJTzuo2U+1ttKJMV4N?=
 =?iso-8859-1?Q?9o8X+vK8YTxBQddBLwjfXJ5MByV0vJVqSGwmSxHIS5LCmTDnt7ZZN7hHJW?=
 =?iso-8859-1?Q?HX1Q8f41nQCwblHC3yaJT46wX/zmza2Xo80Ec1CXSxghosB+agZEd1S+Up?=
 =?iso-8859-1?Q?lC1Ve6lERb6OO2oCeQnWZnVAGawDuxTP3wEBEz0p+Om+shRj49RyXyeL6n?=
 =?iso-8859-1?Q?XH3sAjeNFUFzwQkR58R+NzBBcQefl+PwtyazTRMBJIOxJT96DeSFuf+U9e?=
 =?iso-8859-1?Q?dq/bcGlugB1xhcOFViE8fN6eO/aI+RZQ3mZikvkMjLlj5jTPLOcpsjKKfv?=
 =?iso-8859-1?Q?gEPTz5tDa6EHQrYBPkhYZqyL8rir46LnKDS0h4LgnlXDKlLgfUpJ37Q9Q2?=
 =?iso-8859-1?Q?ax8l5w88MvTud9YGxQCWn2pDprE+WNrqOjcZk/4gJFX9RJXJdQ5GSq/peL?=
 =?iso-8859-1?Q?WyKRDU1dCk0Mv1QOYs1NfWNvtbCjN05O88QXYmcS7PS7RR2/WsgCRv38q4?=
 =?iso-8859-1?Q?zLfEpVlry53KjUoyhRDG2MB3ErX95hnYA97UClIapIgTlaOFb5X6OHWbyv?=
 =?iso-8859-1?Q?0MTJBx9CwLqzm8z7Er+UzTUZS+oXkKFmpG2D3R7UgbQENMklh+rBzOzthA?=
 =?iso-8859-1?Q?7vfARWwKHLdeD3msZ2lYobeEsaxJrNg/cu8qMYfJiNd6nGQGF8LJLm1nLY?=
 =?iso-8859-1?Q?CgD33q3G24riJSMFtdZzTLPz681tHo09AFXuN68NduArbQ4txJiQPUXetQ?=
 =?iso-8859-1?Q?gSPD9lW9Q7B3S9xIsDK15ulUPF6JpR0Zn5Akqnk24p5sLnPhrUOkhzq8Bz?=
 =?iso-8859-1?Q?wXQ5YBxvvQMUM+l7o9bQwvdC8LK/ny4Mijxvi3wGVD2ZrPA+g7NWyvQpxo?=
 =?iso-8859-1?Q?CcD1r7ZEJbnz9p0j8wdbpEt+hVqaRN41U2aCMMVoOVI3eEe8Jsw3qwyPNt?=
 =?iso-8859-1?Q?21IG6Ir9JvWNZEU9DKB0CiDcjP1phPvNOQpJ7AIc1OzwnVNn3t0IcuGlSX?=
 =?iso-8859-1?Q?SrGtYazYfOWnXiQ3kTWqzwVcMvaC3tvCMUBLD6EoHa0N2Mw2fdw3CVhSWh?=
 =?iso-8859-1?Q?EEl/mxJ0DaxjpOaDUGuLhcxwwmwxhUP5Fx5P+JlDryEo8mu8KWdL/BwfAh?=
 =?iso-8859-1?Q?iYZCkX9GNjbp2Z/BnU08CO27fGmNODw8BaJq1jj3lTrqPcd4lmqxR0Umr0?=
 =?iso-8859-1?Q?s5efNxE1RVRFSVSX8xuazAG3KWwtGGcyGNN3yDJPvX1Y7qfyjywDszRHpC?=
 =?iso-8859-1?Q?KXHA9T09iC9yxizsc24KTJecRxdRCcnws+2GoZkO09RxPe5TullVtlfpmC?=
 =?iso-8859-1?Q?gNSJwNaeyclJtUK9XBQsCw7lFCJNW8GZCyQgXCmrqrnMq+H3gL93RUUT2r?=
 =?iso-8859-1?Q?U=3D?=
X-Forefront-Antispam-Report: CIP:193.183.126.23;CTRY:SE;LANG:en;SCL:9;SRV:;IPV:NLI;SFV:SPM;H:smtp.husqvarnagroup.com;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(40470700004)(450100002)(41300700001)(40480700001)(9686003)(316002)(26005)(6666004)(508600001)(6200100001)(2906002)(35950700001)(4744005)(70206006)(8676002)(70586007)(82310400005)(7116003)(5660300002)(6862004)(8936002)(83380400001)(81166007)(86362001)(3480700007)(356005)(956004)(82740400003)(40460700003)(336012)(47076005)(62346012);DIR:OUT;SFP:1501;
X-OriginatorOrg: Husqvarnagroup.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:04:41.9154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de65085c-d94f-464b-93de-08da6bb8d521
X-MS-Exchange-CrossTenant-Id: 2a1c169e-715a-412b-b526-05da3f8412fa
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2a1c169e-715a-412b-b526-05da3f8412fa;Ip=[193.183.126.23];Helo=[smtp.husqvarnagroup.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT084.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8515
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_40,DKIM_ADSP_NXDOMAIN,
        DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_MR_MRS,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,



I have an Obligation I will like you to complete for me, I am ready to give=
 you a commission for your time. Reply for details.


Mr. Eddie Yue


The information in this email may be confidential and/or legally privileged=
. It has been sent for the sole use of the intended recipient(s). If you ar=
e not an intended recipient, you are strictly prohibited from reading, disc=
losing, distributing, copying or using this email or any of its contents, i=
n any way whatsoever. If you have received this email in error, please cont=
act the sender by reply email and destroy all copies of the original messag=
e. Please also be advised that emails are not a secure form for communicati=
on, and may contain errors.
