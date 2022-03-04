Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425CE4CCCE3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbiCDFRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiCDFRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:17:46 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA18182BE9;
        Thu,  3 Mar 2022 21:16:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElpzeDtggr/VkLUq7q0k4p6IlKZcm4e3jpsq/nwKCeOzCOe/a815Q6eBGTIBneKv38g/0uWbqSi6wAq1oYp8ZDgS0rEhl0X/zT9X6n9inz/QOs/a5IpGqgyJ68YhOjs+KZFLpfevW/co3e62F9sPmtDbQDZyZVCMYKGXAdvR7IDc1gG16vnrDDbQU1gxWdO/WJfO380rncDOxMvnDkyNn4jeasjW213EYCXJzHBlGTtzkXu1ZG+RWP8nkxmCTRdbNQynamnCjkl/0I7+uqOk/tNyMwlaB47KT0HlJgovOYHfKoNkqiiB89+CzM3x25DpRA+cP9ybhxCioStMgTn5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb5JuGmX+BXFaAHAJfVcUy0e326/mH+Ze2qCcaVqbnM=;
 b=gX4ZkeUS+qIVwjRH4+U4396VLVSy9Xy1+gBDXFd5CW/5A+LfXcVQPZohDK+NbM4VNq/qh/qzhz3LFr7tgZhi49D/5ypAOqDv878YSgNe3RBgj3fQA+tXoTsnuWa32ly3B5YDLDwo7Fhth0Ue5aai3uJ9ZMgcx0Ssdckt8nFpf3xXe/Hmn5ZxJhCZPWvb5j7yeZCN7qJQe9QZX6a6wEnQacVVIqj8dMnFCDTrhi13eS5hj38Dr4DjG7x4k0vF4o42a7JNp0u1qZ166CisFKnEbgPfIUaEtx5HH6sa4y5IJgmo80OW1QPJLn14c/SiOYuhfnQGI2IxXMyySw57E1/CpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb5JuGmX+BXFaAHAJfVcUy0e326/mH+Ze2qCcaVqbnM=;
 b=K5Pl2XI3TioGVWq0rXFHzAfxHdLF/gLD4d1kFl2nErmEey2/uuDIiFGXbky8EegilPBpPOgcJTjf9WpDCB0MMgx7RUSvnUChpA77z9mCM3ZHk8cKXlsI3jNXfY8jXxeMNZjCHxsodIN0IKr0Ruh6mz6ERCS5EF4NPY46Hu94I9Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7837.eurprd04.prod.outlook.com (2603:10a6:102:ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 05:16:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 05:16:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2 0/6] mailbox: imx: misc fix and SECO MU support
Thread-Topic: [PATCH V2 0/6] mailbox: imx: misc fix and SECO MU support
Thread-Index: AQHYG8V+6zyXtHlnqUG2v4cVSruU8qyu1pXg
Date:   Fri, 4 Mar 2022 05:16:57 +0000
Message-ID: <DU0PR04MB941714DB00452D87D941E60688059@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220207015211.394297-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220207015211.394297-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9eef08d-f3a5-49dd-e6a3-08d9fd9e345d
x-ms-traffictypediagnostic: PA4PR04MB7837:EE_
x-microsoft-antispam-prvs: <PA4PR04MB7837F99A73878623374B9C8C88059@PA4PR04MB7837.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcPd4l43+x5JVMIbcFSMAUIfI1J8P1bwbGaPw0PIV4TRE+A2x+M3mDjTdQra8T9OQFrpya7GApJPpIbUPp2LzNg8hBc1EWIxw5uwYnuhTLCLf5DwKDlUYHleFS9bTthnvBL9kVHC56guDz8yomtz3xmEEgdrxi4973+xrC4PNT5YkMHPtu2cTcvIj3hPtR1+J7qcGuhbaSK0uYsIkXi6tvSt0fSTjyYI3Z/Yid/8TJOV7Z3NHg+cRtglWhjrmVflD8GoceyO/yNEDYmqDVDxURYQxaZiROqHT3RNaWaEoNJLaqJAQudg88Z+ftK+IejmMsKQi3Q7wMOVhDvbCcv1ExU8LP8kQk06xCJJPr3tv4BOA8pmstWGZWQ4lcAdHhFZL9Bjc1s1kS760j6J7f28zrf4sz+AX7A43NVUsaWsKUHskL4VZOZ2XJgwHpiqDcNnU6v4rnZaV3WhtwhESSh+aDb2OnkYXoNr6eXa+EONFPpCmxRPvg6GBQYE4DAGuRN8VKUBZ2msfa0ErrO9qLQ0bkF0tvMQiOgkjjhLCTz+P/igLJX2WINjtq6bVUrQL7m6Bnvl2prnH3GhmPDihgCy42P+WOIsmoZ+oXEMXkbum0WPGPsttRKaLnuuMuxtquHdoC/70VSoKxbOW12SVpQ2Ue/gE8VGJ08OCDzeF3dWvMiYj525hqOowjyCPvj8005Pc0kSeny2Ff7oaBJDSseibh7X0bFTKYMixyJLG7pZaNGN4wr2IzSjPOb8i+6/DGUIeoX3TSlPy1NqQys/IrXQYWzh8AiIz7YDSMvieA78we4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(83380400001)(2906002)(33656002)(15650500001)(44832011)(38100700002)(52536014)(8936002)(5660300002)(9686003)(6506007)(7696005)(8676002)(110136005)(76116006)(54906003)(86362001)(64756008)(66446008)(66476007)(66556008)(66946007)(55016003)(38070700005)(498600001)(4326008)(71200400001)(122000001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lrc09f8LQtK1D1s5H+/TdvIk4bBRRyiQe2cn40s/RYWt6mZWyWusOsildBAu?=
 =?us-ascii?Q?P1/cGedmhvS6p9vPKyz7aFEjZJipWWDb9xiHkyv0smjOT56VQRTbgcFc8Ktm?=
 =?us-ascii?Q?++9e9olN82nS2/W4AeWcZ6yHviq/jHxgoeGBI/RRxALFr4LeehC1ggn+oach?=
 =?us-ascii?Q?DZUWYofQZ41CUOvHF3SyGO/9AtiMjnJWAhIMqH8VWK5PXBQOy1s0l/Jbi57P?=
 =?us-ascii?Q?VxC0su1vHXngdNtQccsbAza6i+pZCpCT7VDZCW//u6v1zZaEKaArLTUjR14l?=
 =?us-ascii?Q?t83KBmBcYdSWVmmrSEkbGcdavmoOaaXpOoxqqCAvCnlrAXrP+oVLBUwnd/fq?=
 =?us-ascii?Q?YEK1/d/njPsVSkB/5s4MaYBSfkUx8/eUXcpuitTTlJl+pj1ULnt3U83/R1Xy?=
 =?us-ascii?Q?b+n8tV4XlobBMW5O6MIb2zkAbnZW6KRdebt3s5BdY/TaXtmhRcsKG0U5c4Bq?=
 =?us-ascii?Q?d411/v+LIRkvTmrHM2RKmCiROu5O64P+fYEQ6+BW6ZS5GMPo4Ewewzh/OOXG?=
 =?us-ascii?Q?QsiS2Utyl36nIMerv3UzxFIX2VhwN59pPywr1sTsZegEUSkaF9i2mU24wQCQ?=
 =?us-ascii?Q?Hw2/fyVM8igkGppQyg/xoNXzvEmr3xgKaLPU21szY2WdqWwCyI3YDbgCAcMF?=
 =?us-ascii?Q?5I6ABcITXugIcjHs7FfCVLaySWxK8mKumzvzSGwW4xlIMdeMU2e4CzKcR4Di?=
 =?us-ascii?Q?4eG4/GnVcQaK/E4efqF9xuQ3mXD4Btdnmqvrzi+15cC5x5FR94F4pzEX/kkL?=
 =?us-ascii?Q?ANHqlciZVej8mdmUH3tg9p/QP+sM9OqgOTXrZlV9iW+WBmnsw62TAsOam3wg?=
 =?us-ascii?Q?iB6gDHff3q9+hqKddH28rzfs/My+bU31eoJX3FwnBPE3WoQi99wTN11bP4P0?=
 =?us-ascii?Q?ay8k5EO2kbdWdi0qIQ6K9NY+ZWgqnRxWbz1MyL0q2Y3m6JsDv5MirJ3kZnqM?=
 =?us-ascii?Q?FNax3dnPuLDAMeaHuGuWaXIA72L481bq4MfACoMRItfSeDS4c0vgoD97bxkW?=
 =?us-ascii?Q?qcTpnF4mHC9GNyYqkVs5N0Kb+F4Es606044KEkGwbdUEZKIpoROdlDkj7WE6?=
 =?us-ascii?Q?C5bxOlHO8l06fhLcdl+l9orfuCdoKq30muktx6G989rhjdcmRXpjh0m5zC3O?=
 =?us-ascii?Q?whSIB3yfHmGUT4ELUeBObGYazd1MyZHo5ARrg8P2Q3O7fFWuI9lesfR+Do52?=
 =?us-ascii?Q?MWJeH03nCidzhm6F99QMp2UKi9AI7FlD4NUsrIJySoywalvLqupin8kQZ0Ld?=
 =?us-ascii?Q?GZN88fslMlz8Yqvu+SmtzaU3+U1y80fskudIb0TyJXKY6v3EQsC/JwGn9oBG?=
 =?us-ascii?Q?w2BSGbtyVa6xj85yzPYx0hFAk1sSiUWQVnlt9MsDL4OJ1IbqzvY8rNHwz+pL?=
 =?us-ascii?Q?aDN4QbMQGx/+64HGEvDzUCwGR7YoiHRRJviMO6FdlxSEJvuyJNP/wJKUm0Vh?=
 =?us-ascii?Q?95dQFbPpaJTtuwYsPR58RhXxyIb36MIi+HgC6ABZ4uMHdnGf1OTes4g0VNAO?=
 =?us-ascii?Q?VDrk+7hEfyS57ayLz2Y6F1Cy/+T5QY4k9QZ6FtAoY3/9li/dbq99TJnKQ+pc?=
 =?us-ascii?Q?anzMay89MX/swrKlbkXk07x8sXrJM57eQUd1PQ4v6ak5uhK9gwNS4XnK6NKy?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9eef08d-f3a5-49dd-e6a3-08d9fd9e345d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 05:16:57.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fwdv9o+J4qAlPd/MiPoC8ikE3I5n0Y7Y2xMuRYuq5+kbYyRCzVfH9ZYKcD4+HZxNtqWekFvlJeZuhKMDjsoO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7837
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jassi,

> Subject: [PATCH V2 0/6] mailbox: imx: misc fix and SECO MU support

Any chance to get this in your tree for linux-next?

Also do you have time to give a look at
https://lore.kernel.org/lkml/20220302022522.1789588-1-peng.fan@oss.nxp.com/=
 ?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V2:
>  Drop "mailbox: imx: Add support for identifying SCU wakeup source from
> sysfs" from v1  Add A-b from Rob
>=20
> This patchset includes a few fixes for low power and i.MX8 SECO MU suppor=
t
>=20
> Franck LENORMAND (1):
>   mailbox: imx: add i.MX8 SECO MU support
>=20
> Peng Fan (2):
>   dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU support
>   mailbox: imx: introduce rxdb callback
>=20
> Ranjani Vaidyanathan (1):
>   mailbox: imx: enlarge timeout while reading/writing messages to SCFW
>=20
> Robin Gong (2):
>   mailbox: imx: fix wakeup failure from freeze mode
>   mailbox: imx: fix crash in resume on i.mx8ulp
>=20
>  .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
>  drivers/mailbox/imx-mailbox.c                 | 249
> +++++++++++++++++-
>  2 files changed, 243 insertions(+), 7 deletions(-)
>=20
> --
> 2.25.1

