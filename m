Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC194837B3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiACTqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:46:39 -0500
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:45760
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234203AbiACTqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:46:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjwFmqp/s1t2WLMg7T6rTPjjnNV+SkDCb5dF3vBbgroQuB1fp0e80Q24a7jPjajbuhSbuR0Abw7zba94PJCSJ4jIa1pUfKjm3Z9JMLbIWIrSs9rQ+9ewevOM6bRaaIMlA7GuULuUIFNw7Xxef8sBDewZLQYB0fRzUOx2H5aHuSO1pdUoCJJ91hg7o71/oiPFwCyoLOv7h8JWcqJr5iqNnBWsLS9GcDaO8HB75JfL+FRYON7FFhWuzq0pdzodqRXpO/rvmIi7/ovuS0pycKBhcyB8ni9G6AWwm6+4/UtSLStzlHAxRfLPgZ7XM8O+ezGYLuhwb+e7Gsbql6ipHT9NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKvQC3Y9m/kRCD91E1Oy2AaI+BRrEeIDcGm+21S2Uro=;
 b=g/Oa1OzylJoSgVFg2Egg3WEeTUL96SftTVwAvxQLhPc6LlcDu10dGJxetgvnC7fTmI9tq82r0XYoaHPrXnHu1DFnwX3a9u2uzzZJgsadu9//gca6gCzA7J+E/3A1X4M9uMiZWVi8cWzT1Q6l8RgxdPvcm4aRtdj/roYfYmxEXJioYnjyC3L5HYhJHSAMIhYFDa4NwG6lzR/nqBl/lw0Aujm3FzPgpolkApGWBI/cu4r2PFsRijz7swqSTSUBFGohkXKzOv4IyOhWqAhj5rN/b1rCeQMQCD2aNu4e/YoXezLoPDZtN6AJkGd86YZ3WCXAltRmv9WMnDHhDghhNuBsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKvQC3Y9m/kRCD91E1Oy2AaI+BRrEeIDcGm+21S2Uro=;
 b=JAZV1qdsjFD3FYpw6fxO5oDUwJjbyUiPP3O9mDetUftc2Snu/EshcW5tgwITqJKKwCMsdA1IRDFQMhZDRwBy9x3l25/B4VgSv+Apxc48COBC0wDmgdWzV5YWLDIpoukjkRMll9Lq93z6XozUbAhYF4UYXaHHkmoU//f4WI3RPuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5296.eurprd04.prod.outlook.com (2603:10a6:803:55::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Mon, 3 Jan
 2022 19:46:34 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 19:46:34 +0000
Date:   Mon, 3 Jan 2022 21:46:32 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: Add i.MX8QM rtc binding
Message-ID: <YdNSmA2wXINLXvFx@abelvesa>
References: <1640088948-3690-1-git-send-email-abel.vesa@nxp.com>
 <1640088948-3690-2-git-send-email-abel.vesa@nxp.com>
 <YczU26vFxiO0wWKa@piout.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YczU26vFxiO0wWKa@piout.net>
X-ClientProxiedBy: VI1P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::19) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 964e1b52-03cf-43dc-649f-08d9cef1bf1d
X-MS-TrafficTypeDiagnostic: VI1PR04MB5296:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB529679616FDCA6ADF611F98AF6499@VI1PR04MB5296.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NS+bJ/yY7QWj6+KMfJD8BkpoJEgjWPGBv16h1C6hPI1OPaBDS936Y2Y9QeyHB5WjnkdNtFzbP+1Rd+BQQ1fkpkGiSy4to4Msk8CZCanXKN/bw0AMhKfYXOnToZ6X0j87MaLPRBD9Ld5zbvGsiFzuGeBWI/aruobe7+FWive7a1UIfl+JdhEfnd6GX4fd5Q7ypB/hdLSL3QtyWYmd5XTIePATNdt2V9H4o1nzopvDKNU/N4OM30DocXAcm+tdajDtwzlY6iYMPNZG7/N1M+q4ofdRiTKJknqvZRoYRx1jppALSubDl6nzbzzT1lT2v9wsmP9Hf43z9bObINKlm2+xjp++i8IdeP0pQa1ZQ/ydSnIVTqSKG06ie1WW8NftZvp+jd2OlAjW2tKjDEdwMpPB7CoT8TmfW2g0FlNz8ROZPw4QrxDQrx5ChGtlS+L/MBiWgNdSfNWTAKnu1KCkM6N2Jpe8aBs5LaTteRbnPbPYeqMn8GXLPLiVAtmM5X1bGXbpBfFj95e2t+Ki2Ge7JGDgzCMED7tPCod1FhPWKTHdWzgH3b1zOAH8MPRTdUF6seiKm4TLqRIdqRWfB9k9eJY8ohmEj9DaDN1GSiZ6Xj5nAJk/NjaRqSxn9MDp5vA1r6GvhqIJ8+2UUAE9ChdfLKmY2+grJ1C4nCLr2i2Iz535vKkSsWhCDoRek8xHEencYfTOPfrcHFzOOMIs7WgvRGIFKUh3db8ocpTfvIf0sinLdMb7uPiPsLESKbuiAe/YZSDYe8u1TUNe9a5BfrDEl7TtdCRcDRPQB05pcmFRHbjsxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(66476007)(66946007)(44832011)(52116002)(4326008)(8676002)(38100700002)(54906003)(316002)(8936002)(66556008)(9686003)(6916009)(6506007)(5660300002)(6486002)(33716001)(83380400001)(186003)(7416002)(6512007)(86362001)(2906002)(26005)(38350700002)(508600001)(966005)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7u3M8maKHNRlMB/2XmEf0XqgZ9LYqFP0mFy6p67YCDI3wvDX1ET4gDBc9Yp6?=
 =?us-ascii?Q?2lPGsgS5Wkk7Cc3FxUomCdgQNx0LGKiVvA8zPUXCnFkv9XVhPy91L7wO662N?=
 =?us-ascii?Q?HQBUj0pjqq8vJxb4vYYCnZwtbCyPEuTSqr8zPgTEytBkbJwaRc+pR9UBqH6E?=
 =?us-ascii?Q?FzDDFqDyPj4UdV4fTPzgmBh4DQSFIkoi88A1YXcknSgtsz+56A5J3v63oMyy?=
 =?us-ascii?Q?nFvufJOxhUisLz+/RDBfeyK2J89SJcrKZQ4gmuTyaN9KRkmdi9wRiCJ9jaKB?=
 =?us-ascii?Q?z9aXaPyaK0MIjxVMLDDK2qg5Uy7j8xjcxcaBYY0K0YBj8bMjTf2iVWqjBndE?=
 =?us-ascii?Q?LNMKMgIN3C2yrD9VEEa8oxgYmGnFA3itQp+UYoUombm+k6ysE3QHdZ9yMUwx?=
 =?us-ascii?Q?tiPce7MM0+5ogg/Cjnm34rivTchhc5yB17glqzL/fnDYbrngOsSNZ57hknxL?=
 =?us-ascii?Q?e3UXfSoBbx8vHhbJ5fVKHGHWSYY8GL8Mw37cv0B1oWHJ/zJfrWONf1/afxdK?=
 =?us-ascii?Q?Ecg8CLNiQRbFBK1e0MHewuq1oRLEhnYysJNuyoITLu0ViwkkP03Fzrup5k9Z?=
 =?us-ascii?Q?4arq/UYMcw/zPtiXay0T5lziRO+UFp1e8BSv7PAMdGTVzgPukUksYJUydxPi?=
 =?us-ascii?Q?ZADPFTusfK5XqU2XYrDijKfcKIJ2Xpzp1qa3VWgHa1Wxe8nQrzyQtCOoPp0f?=
 =?us-ascii?Q?/xE64xGxw9tb1ZWIYzgTdD0t6CxHXdZ2BPUZF611W3pCzrzBxYxKMDQgYfHA?=
 =?us-ascii?Q?9VcrcDqmBdbf4x1te8qCeJR6JzSRXBcR8SB94UC2q80o9Y6TTzrDz71RinGu?=
 =?us-ascii?Q?ic8o52k3g9bcuRUFSb3Wb8HuzYgBxq3nsfGLqDCt6cOoW1zUV15BM0ac7fNo?=
 =?us-ascii?Q?67WZTu1jBa8tbv52ub0wwZYEIrJbO0SzpVh/vjX6NmE9zB1KU05xydVUU5sw?=
 =?us-ascii?Q?ZFSivD50/jQPzxfayXPdXSNzNqwZ+69MLP2dGz04Pr/HgPBjeoAfEEljmsN7?=
 =?us-ascii?Q?jgAb31Uc8N20lzGFFT0cVt2haCRibyPb55j5OMeF7akWaHYeN5LB3vW+WiSx?=
 =?us-ascii?Q?1m1byxWqINKpcWy8cFlndKZqGxdqU/sc8h5X46P3GYTVUq1EmXINnZf5YBwq?=
 =?us-ascii?Q?uPLri623a2JVJgE54XPBh26kCgViW9pKakSLZC9gUaWKC1eLZbKKnC6moPbS?=
 =?us-ascii?Q?JrcksGyPQllGeo+x59KkURPVEFmbfg4TATA2Gyvbs7NW8+O02haRwGPhcG2y?=
 =?us-ascii?Q?faCRHQluZSYL0NM7O0Oo7XPTkaS0up8cAHZvMWA9w5vYSFbzaarfcPOX7kYN?=
 =?us-ascii?Q?D9xLKp3qUiL8tCY+p9CW7diSOAQ/uLRdFNBOEeJhOD0LMfFd0p2uL1tDtH+N?=
 =?us-ascii?Q?iQLGTxUv8RvbNz+aMSZ0oFM0bnQ54ujWxx4vpJVAICcdlHY40njWrM8rfS2w?=
 =?us-ascii?Q?6DJcNgy9JtE8J5ygEueRfsVVTniVyGIQ4BKCfbu+VHRlyTlDZ9vrd/OmWdqO?=
 =?us-ascii?Q?lhgrcJ0Ex/P7vIshWAz74zSW+Kwxwr3Ef0H4nUZKsksyu66m6MTddCXGwug+?=
 =?us-ascii?Q?M8oxtxIIpinjJXY/GYMenBVI2fBI+cKYuBu1TFH38F9M6GfZqnLehUG3Xla/?=
 =?us-ascii?Q?ShSZaBiewIrrP5DNyb9+UrA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964e1b52-03cf-43dc-649f-08d9cef1bf1d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 19:46:34.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pe6d7X0Lqzdr/reBlS6B6fpr+9uyGpE6qpferqxopLNkq++kmHiRgdiekOosXUMaOfRdbY+s3ACQOj5NCPWAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5296
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-29 22:36:27, Alexandre Belloni wrote:
> On 21/12/2021 14:15:46+0200, Abel Vesa wrote:
> > Add i.MX8QM rtc compatible to the SCU bindings documentation.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > index f1470d562156..4633be2182dd 100644
> > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > @@ -134,7 +134,9 @@ RTC bindings based on SCU Message Protocol
> >  ------------------------------------------------------------
> >  
> >  Required properties:
> > -- compatible: should be "fsl,imx8qxp-sc-rtc";
> > +- compatible:		Should be one of:
> > +			"fsl,imx8qm-sc-rtc",
> > +			"fsl,imx8qxp-sc-rtc".
> 
> Are the imx8qm and imx8qxp SCU actually different? I would hope you
> won't had a third messaging protocol for the RTC...
> 

Sorry, my bad.

No, there is no difference between imx8mq and imx8qxp.

I'll replace the compatible in the imx8qm.dtsi with fsl,imx8qxp-sc-rtc,
drop this patch and the one that adds the compatible to the rtc driver.

> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com/
