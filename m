Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331374CCBC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiCDCag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiCDCae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:30:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2114.outbound.protection.outlook.com [40.107.94.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0923108198;
        Thu,  3 Mar 2022 18:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMfGQXWvYDPuHa2P6yVdodex7mklBEz/5oZrLVGA25JV2WyQVoSJkLMGvN1pwRLapQq1VVlrazcKGGSW0k/WzrHVdEuKkr8CW8xlz/HVn8U8ynkUvSJCe1hNsOXj1mxVHqnpLp/UBk6FNofIctjOKl/nC8PjA0ePRnF8uE+g4PYcFrGXo/K6/d2aGUNLxUs0g3v0ccBTJhu06IlfJmIP/YKVLNDJkgTim9uXd+MntbY3hEss/7hcQmQimj7shxTOxE+TINQpHBBm125ONX7w/Fs/91S8M99JPpyFCc+aeVroGP6NNGAAi8Kf2Fgo7mr79WLz4W5wpHBxrkBdGULxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS3sk6gyFp7CBC1YI/+GDQlN6KpmWhsnlOs36Q6eI3Y=;
 b=XQ+fT6osdjDsbiFK5xzT4DYFiitvRquqrpXVdUBHp0YVxuGr5j4nWOKiNaTUSG5rAS6Ywx7D3jNGsQjsqG7ESBsTT7Hu7elJCq2ln2YwU/D5cgav3XS8PS0/5S2fHAu4OTPSgV1aMmjaq3r7H2rQSVj0KoyoqzjLOpdTMxGgUQHxxBmLrQNjuQEVH7QEjEMA+xP7iO811o00snuZeuHFO9yTcXxdD/0MaGZHGOU4wiy5oJPJR6KYuFmwAqTbto5Fhvq7+ZsynzlSrFC2HyeKJghScNF8GFiaaOCrCax0OvJCrZsDzFbaKPul4ThyFrjW86P0yG4GZO3vBl1e4+dWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS3sk6gyFp7CBC1YI/+GDQlN6KpmWhsnlOs36Q6eI3Y=;
 b=ZUxST9XNoVDaNKWcX1lCesEKCjLvAHQWSCMebr6fW7MRSoG7i/twGJn1eG2dJHpRmswwRJvHG7IuG4fY9xObkYxA3BxpmYXamRi42W/VuBqAIec4ekEm/Lc8Gxxuzz3wrarmP6bxd3HRAhtflGbFVWj4BfTl5nt78FXMbV+tN8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by CY4PR04MB0841.namprd04.prod.outlook.com (2603:10b6:903:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 02:29:43 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 02:29:43 +0000
Date:   Fri, 4 Mar 2022 10:29:36 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220304022936.GA4164495@anxtwsw-Precision-3640-Tower>
References: <20220223102353.3833578-1-xji@analogixsemi.com>
 <20220223102353.3833578-2-xji@analogixsemi.com>
 <Yh9dBlrWm3OicQWa@kuha.fi.intel.com>
 <20220303024757.GA4159259@anxtwsw-Precision-3640-Tower>
 <YiC+/ccRvR/+mAkT@kuha.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiC+/ccRvR/+mAkT@kuha.fi.intel.com>
X-ClientProxiedBy: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28eb0f48-3d1b-433f-84cf-08d9fd86d76a
X-MS-TrafficTypeDiagnostic: CY4PR04MB0841:EE_
X-Microsoft-Antispam-PRVS: <CY4PR04MB08413C4936E45E276B54A627C7059@CY4PR04MB0841.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcqF64HTAHxcWO2eAXS1LNPe9UXLYVeXOn1g8Fr2YFAuZYqkjav7ahJh6LhEsZAPjVwkLhFf5xsVPFF/BxFrt8kHiWA1HB7iQTgpOzNcj/JEQnnyho8ATUQokd83l8HGnkjlPzgR5f3QMSa9VpHl25/qZ/JUFHvYAzxGECZMWbuNYO7Jik6+v2TkOmRfMJ/hQVcbxeIQRiXV8aZjdQJDEosfKZ7WfvV+GZl4nSlu8nF+8sC8u4E8Pa6lEcMbBI09cgtbFTumlpcv4AWMTGtJg07+WcCTN7f6Q3vApxR+OLLV8oCcH/TV6DDiuiU0b28iDrGp+CKdXPPfcxl3NpMYrt1sGVIdDaEvwG/fJcjJvMSEZI4ke+SJX1Gqvm44CDtmXOc6dQqvzPgRCArwfm4JFsf39DD+AjalyLb2cZXJ9Lz0pY+NVLks0pcaphHNm6GxIXoTLvrje+RD1GLQPmvX/YTUxJWbyKswMfgsrDDz1+z2S+YJU1oiJ7GGgDqnGY1UYsAOjv3zeWZGr+UyfPcog3/Ei/t3odFogKZxKFITjcn8pA1RcBvnt9YMz3w9ZGiaJgCCjs8BL4DqZEt8CWr18pO9Zcq5L/9Xwt8Nj4B/0NOdIZ3YMpGy/DQHzOEHMeEZs5j8qjSm3JwrkP1CnOcZkrzjMGMvyZEQhcP0aYJpjY6L79UWolOXonPHJcwkwaArBlpMmoYFbxRhRsXnXWwTfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6486002)(52116002)(55236004)(498600001)(38350700002)(33716001)(6916009)(4744005)(38100700002)(5660300002)(9686003)(1076003)(33656002)(2906002)(6512007)(8936002)(4326008)(66946007)(66556008)(8676002)(66476007)(86362001)(6666004)(186003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KcIXb3mKp8HrxTzcs9ZJQ2oamPvuRd9fSyhN8FfYynIuPdZQwtfKRt8ypc3A?=
 =?us-ascii?Q?/z2AUoJHqXhWCtRiInuOHAS6w+TVRYlNivGXoJnkPpowh+Yeganu4aKTBoHY?=
 =?us-ascii?Q?xmzGK/k9XllQTB2e60tPAJ3M05gTJZVAulKZUsCuQSFIZPIgPvMOid58xi1R?=
 =?us-ascii?Q?fNuOlLOiNDsTk4HxCCY2kWBwMcAYKx87NPBKYg3SIdXlsptW/YgS+ltdssKm?=
 =?us-ascii?Q?PPB7fNOKyqlF1TLiPM1YIZAKmC4B+BpBdw+Q0siN5AKlrJMT32n0OpbvzUa+?=
 =?us-ascii?Q?NmS2OU86XihVUAIy8bpXCugiMnonLAi+5/P+KRn2xw8nhpNtrk5Nfnp13GQq?=
 =?us-ascii?Q?HHsXfWPgmIIYahDoA6sy5tOkj1jsb2xC2Qx3GHJRu2ZgxWl/9m/Akpe0kQ8g?=
 =?us-ascii?Q?Ft1FsUEv1ld4dO0CCLpviJKOJ76mEWw7Xa7JSz0Kl9BNS9q/9ZCKgmqpClKL?=
 =?us-ascii?Q?TFoGmLqvNSXOEwEVpWGfHe5mMCSe4UbGqljlB+axiVg1ItJFMmM3lsu/tNV7?=
 =?us-ascii?Q?fdpuINkeHKAG8T04gGvMSdXa+6RlnuTXShZmyNqfDdB28CVy4hs7Yl/Xsk07?=
 =?us-ascii?Q?KtKMCX+saJ7ZI8wtIcz13InLUNLZgb//7nHt5UL4g0HbMyEoHdA8QnF68KIL?=
 =?us-ascii?Q?fmXdHC89zfzJyy7J00okyzGoy5JoigiH4OsZZYQ71x/IRIttXwjNUn5tb3Pw?=
 =?us-ascii?Q?SUR0Z+tfc8TxdNG9UYRFzIzXMso3KZy5wSJ4zfy8ZAjROqvzhbuK6M76d+2n?=
 =?us-ascii?Q?5rEeCjSEWdBSPnHVciXGYqO0pZIjrxb2ASPtqomXmdRqYBeiZ7OvW0a5/Jh+?=
 =?us-ascii?Q?vULERkllP37MelQ5cRDA2CKoGNSw7GRL5RhmZ2FGjGReJozOcPj0RzCqki+7?=
 =?us-ascii?Q?z13S+3zWT3SmxAGdDphAs6R19mZRrWccXRqseIhCvqqFp7U91i6kUoR1yuh/?=
 =?us-ascii?Q?j7vyuvgX+UbCM3nem/BGb1Pusv3xLkB4qK72DjlrfQRJh6YVLsz8NVgPg2Zz?=
 =?us-ascii?Q?DGlr2u5w8T81ACBn/N/tQ9AFJBqH14frCuSum6aRwSSC99uXR1Y4zrrlDIQD?=
 =?us-ascii?Q?zlhhzNBwG2Lc4r7Ac59DczawmDL6Y63J8eV+YDHB02KSLYnGaqK4FbQH3cAL?=
 =?us-ascii?Q?fnrh7hh6IAfvA1VfKmiyPVjKjINWMcRj3TWj1FzEsrsO2iqHgA1fkx1SYJl8?=
 =?us-ascii?Q?cYajxDy/PtTxPvw+U+mEYkCkcjIxuMA78v0DmJqTu9WQWRzTHuH1tj6HYZHI?=
 =?us-ascii?Q?scJlWPe0wIdcVJwg4ykaxuyY1NGJyfjF0O9INOJ6oEd8BAQ/waw5Ct0AUIik?=
 =?us-ascii?Q?zz/pE8ItDF8tTAPXRV0GPX9r2lq7FS2m5kCoyJCGgBo/pt1gHKeWnfFrFbbT?=
 =?us-ascii?Q?oID9H+CPeTdp13AfdG6YSeMnE/0wpQDazV83TlIlfT71WZMWsvggyEqLmZyT?=
 =?us-ascii?Q?aPAWzHI2n4Z7k5eKR5jbnjwGiVPOLFMA3A+o4tx3GwaAuSuO7TNoWbnqln6d?=
 =?us-ascii?Q?oLrBJBDWneU/FAXaPaxa9PJQlPWwyq7AcCqmtTQSgJuZbVAA7Mfopd8onanT?=
 =?us-ascii?Q?DjIrqF/FFs+oVJPzseZ6KkBCKZHRr+ZcluPqbLQ4S1lQ5GwrgGuFBYebUyNT?=
 =?us-ascii?Q?AjOzzriLwJiKgAVvlC47MLI=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28eb0f48-3d1b-433f-84cf-08d9fd86d76a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 02:29:43.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5a0xjABRwgP2IB0dLl57fQkxbKOkD1J7UoVjRij64bR7eZPY3WZIg9prEC+dtEhAfESDPLhAKIxvBoWKX21TpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0841
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 03:13:33PM +0200, Heikki Krogerus wrote:
> On Thu, Mar 03, 2022 at 10:47:57AM +0800, Xin Ji wrote:
> > On Wed, Mar 02, 2022 at 02:03:18PM +0200, Heikki Krogerus wrote:
> > > Hi,
> > > 
> > > This does not apply on top of Greg's latest usb-next branch. You need
> > > to rebase this. There are also a few more nitpicks below.
> > 
> > Hi, I didn't found tcpci.h in include/linux/usb/
> 
> I'm asking you to create the file.
> 
> So create a separate patch where you move the register definitions and
> command definitions from drivers/usb/typec/tcpm/tcpci.h to
> include/linux/usb/tcpci.h
Hi heikki, I'm confused, do you mean move total tcpci.h to
include/linux/usb/ directory or just move our driver patch used register
definitions and command to "include/linux/usb/tcpci.h"?

And I think the other way is, our driver patch just include
"tcpm/tcpci.h" is better(no need to create new file). What do you think?

Thanks,
Xin
> 
> thanks,
> 
> -- 
> heikki
