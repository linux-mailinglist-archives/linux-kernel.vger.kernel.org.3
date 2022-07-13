Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204B6572E65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiGMGsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiGMGsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:48:31 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2111.outbound.protection.outlook.com [40.107.95.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD9DF3BD;
        Tue, 12 Jul 2022 23:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOJOfCP1fI3RFAW8PFmrNTornExrqp1H+u9CXySaASqdqz1+niA1JM05rFnL6YfzkPKmKkDdy2/3kA5ZfZMgQjYC2S2cr1M6z225oZ6APPg2o5du2FyFP8nXATaEpf9RISqlrU8dZ4WAhE1A+5dQQUo1gR6A/U8mmbCpDM0htzlpQUHTfGPxtmNr2g/0hruZmiLUd2TCCEy4+A1pW2bIdm5K7gxPYdy4T0GrFGk6IKiDtQdjkxgRLH32eibqsq0fRpDOSweWtnm89LxIbKOSQaiQMa2SyZeMojz8z2SHWNPcZam415fm1JMkpyese4k5gfp+VwlNoN3RL6sU/FEldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bP9LvpJKMefbhjqFTryKuXNe5ZZSgZzKqWEu87wKTU=;
 b=dqOT5IGMlFI69tsXBtPpYPztlZqHfsY00kRagReGosTva6MY9RcAvdGdebvL2tEEZmPrCOiNllqmcuqHtyDSHISN+f9Ww0kAivC1fsQXS4Au2E9b2669JgWsa/1OXaDCb0E2iL3TkdHYnAPeoMbftX3abXNrgg/7DXbjbEicTZHc61SdJ80PdS2jQ9KsceUcbhGYvdH/sqMgBQt6zcDKikMXkPoVkHe9kNwpR+aIZC2AE/KYrCTFIiCJ5NxRqxHQLGzjmLFnfQ/DopYwPRsYpv1H/rbFtRx8pOi5yItqHtdP7g2o8oFq4biJnhHE1RBFPRinCi+p6loFTbOwa3lKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bP9LvpJKMefbhjqFTryKuXNe5ZZSgZzKqWEu87wKTU=;
 b=QUW+Y1io4C141GLf8NRMErQnAFKRvpbmWm2nXwsKz677P/3jgioU+KQ4HZflp2U0GmzIBJJqHRAFF1WskXD8oWGZc8VFBGoQKh1tUBKHofl5NRq8kLhMvcY74WffKM6KeLjqt5Vvygy6d2BMQivjwurinBSPEJnewvhCXhq7wJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from CH2PR04MB6741.namprd04.prod.outlook.com (2603:10b6:610:96::19)
 by SN6PR04MB4688.namprd04.prod.outlook.com (2603:10b6:805:ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 06:48:25 +0000
Received: from CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::5400:a1a0:be8f:34bc]) by CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::5400:a1a0:be8f:34bc%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:48:25 +0000
Date:   Wed, 13 Jul 2022 14:48:18 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v16 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <20220713064818.GA2789090@anxtwsw-Precision-3640-Tower>
References: <20220712090534.2783494-1-xji@analogixsemi.com>
 <0bd85140-f006-8b29-0a43-500733f1654c@roeck-us.net>
 <Ys16lEvhVSSSRMP7@kroah.com>
 <20220713062845.GB2788915@anxtwsw-Precision-3640-Tower>
 <Ys5oBTeIcLjf7gnX@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys5oBTeIcLjf7gnX@kroah.com>
X-ClientProxiedBy: TYCPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::16) To CH2PR04MB6741.namprd04.prod.outlook.com
 (2603:10b6:610:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f22c135-1304-4a7d-5552-08da649baf12
X-MS-TrafficTypeDiagnostic: SN6PR04MB4688:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKNiywvwG3KkcosNM3MS34KlxVcMBIpSyAorbepfu0c2JLnwTR8UKZODaJpJl5jnG6bgJaGO9q3Zhj+A5CK21rzQLuMLEXmhMLXWx+nza9Lz8IJPDRaeARK5Bh1gwot7tRJyVwM7aNgK94cPjQuLr8Fl//gNPVennFXEc1HsHpo4JFrSg2FsDkCg614tqncX1HsWmgyIBiR/GU6Tl1h1MjBrQ6z9JvehorLP+BLoebqIp7lxeLd3ViI80Cgn4nkMqMFxUs53rxtg4LJbUeglRDGiUZWaLPjulEOC5YryHRvTo0sUTSft5aj+jX8SDhyB17E6GIjkpcqxLVPyxBNVRrJPrJgjwg38hLV10N1WFhBzOzqxkNV8MWZIjlVEwvxcbZ7h3TxKbiz2O0FwBYhk5lxA+2ooYyedtiwc9KbrgrtmvfnbFCd00VlMW2E2dX0DClBuWWpqBRHqusFWjywVSPRj/fvdbhW23hShyGcjfDoRIzLZ1oplWcL3yFU+6Khx4vW10xUf28eTHz4WNdRa/628sltMh/ZaljchhZ7yqcn8Nyjut82tZ8L2wi4Mfj7tyr+Zr+y3gr1o1xF9/DyYxcJw+QETZ6LFccnCfgmQtsv3zxIs1vH41TJk1HYfMdss/0U+Qe9cxWSPuu5AITWBrmHI5ul1/TG0JdOzVyqtUbJrpVIfqnumLaC8V4D2XZxTGB5n09x2OuC9KQrJBnmXuMWV+nj5/NI8AeMyudDJ8QxeAW26/GXbr8EByFb87M9zuOhk/scTjHSsfpZLdTql+jTuGiolakJP3dpE2lpTCEZCrV1bcGIx5lfti2AHWAan
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6741.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39850400004)(136003)(366004)(346002)(376002)(396003)(6486002)(54906003)(6916009)(4326008)(38350700002)(41300700001)(8676002)(52116002)(55236004)(66946007)(478600001)(66556008)(86362001)(26005)(33656002)(186003)(9686003)(53546011)(316002)(66476007)(1076003)(38100700002)(6666004)(5660300002)(2906002)(8936002)(6506007)(83380400001)(6512007)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cYDSTZhPOxnAXY0OoPiEO10a3eYxT/l7yRo+otku/8ViaDcVoggDwl1BIdnU?=
 =?us-ascii?Q?rIWHyjwl4impQ42bA603IwaYu9idqy9c9BOY8KqOXWdnZ+mHfqrcuW35lxVE?=
 =?us-ascii?Q?3qX3SyOsUKMgaybvtnM+QE58f4oJKlRwZJZZa/j4w94agKJ9yJ9bEXNihnmU?=
 =?us-ascii?Q?FqLittPLF22KZKGsYKD3cEWTiCkn7NbgxJQ/uu4kpgSXUE7IkCIo8hipFJPI?=
 =?us-ascii?Q?xMwT0oJoVRPLS/7VPUHo52PBxS0zFNHPqSiPI7ubA+K3tkLqkWSSq0RflXxZ?=
 =?us-ascii?Q?Puzs4gbFHNTbA4ee+5B9xgyI/S5vD62tGgXoYN0cisKG4y9ukTBLIcHAq1Cu?=
 =?us-ascii?Q?c6usUj3kcxP0ksc/Rkr2WHjuYyi8xjuCJcyfn0uPcEGmAAV/BMWe0Jp05nQX?=
 =?us-ascii?Q?gdQPKBqqa7DpLXMGOzQ2meKKy08LzeJNuca9c+h0TZsExf3V0IUClCD2rxFO?=
 =?us-ascii?Q?/Yuh8fZ411eyLr4QNgPgiUvBizzxoKLhm6/AywQTlWWL8Un5JFp63vasuRiP?=
 =?us-ascii?Q?3BDugCO+6Gx9IkUGU2+uY44RrnnimFD6c1exglliBORdrz9wnrlj1C55LB/5?=
 =?us-ascii?Q?fJI7nR8UIbF5JtHIdXfJp+i+rZN7EIgI+EXFEGoF55rrtiM9H3yyAHwkBc/Q?=
 =?us-ascii?Q?OmyPEv3XqNWQYv21YLRckxn5rAF5eoGL6dKJh3NqWQ5NT1W1JTUtq/MDIKmF?=
 =?us-ascii?Q?H5NDbDydN8u3LlgzgAd89buUSgyBEih/mCoP8o32YGpB8JVCq/efpUD8uSka?=
 =?us-ascii?Q?L+FZeZr9bebvuKZKjf5EnhvRye5Un1YQjctM5A2BRH8yK5ryMWdC50oRXJig?=
 =?us-ascii?Q?7MbQk9GAzpD91tt3sAHF/pl7O8ELuniweUsy+XwhmU2W1ldpb1/nGJfCJIZR?=
 =?us-ascii?Q?4aIxBMWMYD/vL3X1m07PzDhS8lVcJAlH9hK1LgeqvWx9yJOqMREH9OJZM9+e?=
 =?us-ascii?Q?llxZC58Ue2AsA4NSb5STYlqh2NAu45kUoGsXgDa4R03doWgYRGVacubWs53a?=
 =?us-ascii?Q?c8YsTFwVhR3aNOir+ltAdLGIhlkitdehioY5zJ/3E46NcjrdJuHg9H+FoMR4?=
 =?us-ascii?Q?X0qH7DXNfmuea8Vnd26qaM+cttLV8wQUAcpLvOF72frXKO23kx1u1InMH9Ut?=
 =?us-ascii?Q?pzknbUtgYeCQ4GskRrjlMXb0+tQ3DoR936ClJ9JM/81kCs8XcDHYW22/Sfzj?=
 =?us-ascii?Q?wwcsawTwOTqGV82eZrTr4L7I5LPh2WumOC/LATGM7zramHI+6v3K+eqRoMAk?=
 =?us-ascii?Q?RBLbYznvxSMEMglvS+SjTtR1nYOHwEMb3gJc6M6dG6Nct1qtvMIeplJiuO+9?=
 =?us-ascii?Q?Egxvg4JaoBz+1NJ29+3l8Lmr4nFXMhSCVBDTbjoaTs7oTBRNPJgS5RggY5aV?=
 =?us-ascii?Q?ju6G36QnjbWYizrjmnUaeOOyPYw26/dXlffW0KyL/07BNRT3Nh2dwjPd8+g/?=
 =?us-ascii?Q?rd4nMvA1O3fgl0VjqguHh/ChbvOKoaP9wNrAb0Kf31TG2rR189Qt4e+0Uv/n?=
 =?us-ascii?Q?We1KHtcEkSkP9hIOSyB/KnMKQc4KFV6dfDflJkCMEz+V1pw08RLoM6shZFTH?=
 =?us-ascii?Q?1Tif0dHR15NUk9oFAw0LcP0dGunIDAYLaKc/Aybc?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f22c135-1304-4a7d-5552-08da649baf12
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6741.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:48:25.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JMMM777g6XAYDVxSYOILS1wz1LxndYz2Hnhl7c7DDQLKHTdS7+5FzR07meGjLkp9PttypuMZDNh6UhUMwSqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4688
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 08:36:53AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 13, 2022 at 02:28:45PM +0800, Xin Ji wrote:
> > On Tue, Jul 12, 2022 at 03:43:48PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 12, 2022 at 06:31:22AM -0700, Guenter Roeck wrote:
> > > > On 7/12/22 02:05, Xin Ji wrote:
> > > > > USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> > > > > and a port controller (TCPC) - may require that the driver for the PD
> > > > > controller accesses directly also the on-chip port controller in some cases.
> > > > > 
> > > > > Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> > > > > 
> > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > 
> > > > > ---
> > > > > V9 -> V10: Rebase on the latest code
> > > > > V8 -> V9 : Add more commit message
> > > > > V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
> > > > 
> > > > We are now at v16. The change log has not been updated since v10,
> > > > making it all but worthless.
> > > 
> > > It's also already in my tree for a while, so I have no idea what this is
> > > being generated against :(
> > Hi all, I'm little confused, do I need update change log from v11 to
> > v16? There is no changes since v10.
> 
> I'm confused, why are you sending a patch over that is already in my
> tree and in linux-next?  You got an email saying it was merged, see
> commit 7963d4d71011 ("usb: typec: tcpci: move tcpci.h to
> include/linux/usb/").
> 
> thanks,
> 
> greg k-h
Hi greg k-h, sorry for that, this serial has 3 patches, so I just think
need update all 3 patches in each upstream.

I'll only update the 2 patches next time.

Thanks,
Xin

