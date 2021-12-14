Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBDA474853
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhLNQie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:38:34 -0500
Received: from mail-bn8nam11on2091.outbound.protection.outlook.com ([40.107.236.91]:52159
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230260AbhLNQia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:38:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2g1Zid6GgXRUGiiBmmQSdIOAgd3aeVV5XQacb5f4o9cZEG2tBYTuqBrDtHUdqTXi07wUDPocZf+ktrxhr2FJeeA2J4ODF9wM+XNfavHX/ReB6lqwnvihoVYQZ4PbdPg708CY1Ddkux5SRVZvknPGQUf+4hnpT4sY3OACKG77hZvol/w6eGOygPTMeJjTugi2pcEyM0UYJMqRKjwOwzPd35VSJR49odvSmvk2bCplFTVpJ8HzLPCQGjK/TbHibmkcsIVXyickzAbptaN2HKmW/EFrWwL4J35rUEZc/5N9udpOQqC2rd4bFyJyXArdg5X1VlOGgK6DhVp3vClTofhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjNrnASnMtQvlpU1gLDTsFBKvI9qETcCLvEslZ8qlzM=;
 b=c8c9rk1qRdGubGsIqXrthJ1lEkdNGyijgz/aziAkpM/x20GggkYmhbD78wGREc37Y+V2i3L1X9wsXBJCMtmCxW6JkPMBJukGcUyKhxDpebiHaxds+j4LEO6lc+3KPsHFQ5y/JD2PWe28/1NW9+CLH+1Uuvyc5dX1Am9xaf49AK0+WZ9ELQiVswg/hSAqNQHTnfcX4E6VHjiIMwsvhOVk0++EhaUDuYsMWBTlOPAnImUckrhSqUEfPhcENMT4bxA6XZ2Fv+P6IyrRyzNOQYL+l4bYZ/+9XJod4oZHwM2yeVYVVAZDfmNiKUvgwSrAmJEGrLIBP98y+WmgGs4APm0UQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjNrnASnMtQvlpU1gLDTsFBKvI9qETcCLvEslZ8qlzM=;
 b=XBwNzDml//t28qy+iNDKmhJt/zku/8/vrgKXjkEshChw0P0mOMcg2tV1WpADWIrGIKExiTUBOu+g8tttVYELZFQgM4stPfj9HMsDmVM0Rs31BZKjRpqlhOWDoe2+YsHQgCVfWQOCvM6ZxnEu4xuOvcLCp2cPp1t808K6M/QVAbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CO1PR10MB4804.namprd10.prod.outlook.com
 (2603:10b6:303:94::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 16:38:27 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f%4]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 16:38:26 +0000
Date:   Tue, 14 Dec 2021 08:38:18 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Radim Pavlik <radim.pavlik@tbs-biometrics.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Sean Wang <sean.wang@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org
Subject: Re: [PATCH v2 2/2] pinctrl: Propagate firmware node from a parent
 device
Message-ID: <20211214163818.GA2429@DESKTOP-LAINLKC.localdomain>
References: <20211214125855.33207-1-andriy.shevchenko@linux.intel.com>
 <20211214125855.33207-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214125855.33207-2-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: MWHPR1201CA0017.namprd12.prod.outlook.com
 (2603:10b6:301:4a::27) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
Received: from DESKTOP-LAINLKC.localdomain (96.93.101.165) by MWHPR1201CA0017.namprd12.prod.outlook.com (2603:10b6:301:4a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 16:38:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b61018ad-ff09-4a5d-4f11-08d9bf2026d6
X-MS-TrafficTypeDiagnostic: CO1PR10MB4804:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB48048BC2F31CC20029B25C22A4759@CO1PR10MB4804.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DVWcaoJwmrbfuGxIJmxqYpoEkU4195QXxDInDOyNXTW7iH4U5G1+DZAdmTGD6r7zLC8ex7ucqHppfJGjjPhiPgPX5Oy5wrv8FO3/zkxYo6uqdJRKvhkE8Jbq+NmTricNzpYNGlGsTRJn0O8ge6LrffXKXe0JabGBlp9SAkKPrcC5L0/ouSdJ8QXYclTWv0Q87nnabt8s2YsevWX/NnYa8Lns5O0THPVPogy+5CxbSnMBerW6LVJTWar+QGDHCWOetZjoBNoOkwpxI0gyAdUBdIBkXGcmvWdZ1lcvatpI8Xxmpm8eMvs13q7LSXMn5eKZsotmgEjPDtTepJAc6dqAjR8RPHKEqn4eVWqKlD3AeR0jEatlB0a3+eyopDp57Cfj6bU+ritNt+rdmqFzVbTZPg07x2MUxThvaz28s5iEL5enKEIYDMVioVfGAZUHee5BLinf6e2E+hVobuEEcmK1SOrxKL2LuCJbqRXx1ch7ponOZhUSsZ4QbwUUIsnmca0HTWU4k+V5B8NgmVOysMHOXTmBnz721yXsFa/X+ge+mXwGRVuvNVwzpVzHEjtNWHySR4cZscYGgBzkRNLMqgZyfEa1apkqD6a+6jFVbh9h4EgJbOm0fJKPXVkIxg3P3vSKGSzFEinmAcSa3V+FNpNeyQ7qxqiXHtvEC8Uu3sds+w9W8pmM8FgEVuxvfoMzsjUE6qvznhA/wZa/OzUwsmGBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39830400003)(346002)(366004)(186003)(38100700002)(66556008)(66476007)(66946007)(6916009)(38350700002)(8676002)(6506007)(4744005)(54906003)(33656002)(8936002)(52116002)(7696005)(7416002)(26005)(55016003)(956004)(1076003)(5660300002)(316002)(44832011)(7406005)(4326008)(9686003)(508600001)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFz/c0kvXMW9FuDIb72FSPcsUheUAxhwNc4S8qlcryCgoWO6kIZKW7ypbr+8?=
 =?us-ascii?Q?E+pZD5Aj3IRTAeWUcAVJs2dHO9CLVMO031M6CHU0J5JHMVk2G6y38AKurSYP?=
 =?us-ascii?Q?YodrVz+nuWgn9lNsaqz6SyQD45bet/2kNQ1cMH2xtL+hqWu6N+4gupTMCcF3?=
 =?us-ascii?Q?eONFwtZcC6kB8u3KocmBcJzj5J/Z2Ej9l4I3n+WHYeG00qdZuPr+t0WpytUc?=
 =?us-ascii?Q?wGhlutB0KzUlIsLb2u15A3PygM9y2rFK50Unke/2cgmQZh1YEjMYN7iamHkA?=
 =?us-ascii?Q?x0wQCQh+9Oo7/PqbdXbSLoOLQRHF/GiLL6K+8ijTtU09E7iCwsaAE12DJ2Mg?=
 =?us-ascii?Q?i6S4kHs+mQDxt5GV8+POOdEMS5f932yYamnuy2j2tATmTwbPaP0EFMbdDxBU?=
 =?us-ascii?Q?nfd+Yn5cKZotpQQvw5SPCYdkhzGl445xmulsubPVTM/J3MjXR7RyQmA7Bjl1?=
 =?us-ascii?Q?ZGmFzXWK6xeNVaAeSY7fSe17a7Xomz6kxyHlayFEdE7CNoSk09UgmA6NkfvW?=
 =?us-ascii?Q?+dylVuB5lRr/YQPnlskBt3xFkgflqybb3p43DZovM46m81Q448Ai4R6ryW+v?=
 =?us-ascii?Q?5zO5+w/xoNqdmWUpDvRCzsgKn4crD7ARojod9MrXTcUwszLGpZ8Gxp9xk6AP?=
 =?us-ascii?Q?SoyQZBLOtF5GbbPBGIYt9NHyaRoZBFFJrYo3cTMWRrqgg0fHyF8ej10Y90P4?=
 =?us-ascii?Q?YKUIdjc0Zn72bLb9QcAvZGuAkw52ax5dz3u07RHhGsgRSv4I9/j2Uz/o2iX4?=
 =?us-ascii?Q?kkuYdWhAmixLFdP3E4kZjUQpMZ9vZIDc71fhUGM6CxUWFfYtQ2PX9WNXwmnl?=
 =?us-ascii?Q?4eYKGlOjpfzB8ObEINH2CoTwi/wtKKYS94duvwzSVeE+bX/hYojpbvXcBxzV?=
 =?us-ascii?Q?maXAuUypG4zBT9vhxcpDI1rtto6T7TcCCS3ztthVmRyXHAxt6NNargtZ5L6E?=
 =?us-ascii?Q?jAhti48l7Y4OEgt3SnJ6dIDsyQz+xSKMmjOFgIapz33eDxhmQVZgXhEBy1K6?=
 =?us-ascii?Q?Fwj8u6wkUShnU6J1K8Xf8A92wl7HFPRxMUUo5QH3Rb1XhaQ5bRBWk0a6r7+W?=
 =?us-ascii?Q?987lg646Z5nNnWkDov05osZe5HVmJn965cIeKd8sNUpuNjt00XZaEYf/BNha?=
 =?us-ascii?Q?wTb9hPz6pBixx5PerRncqHfcVszskh2xs14KWbIdcfAOLTDIBzoWg/ku45sJ?=
 =?us-ascii?Q?/UDoaL/zmk5O/AYuCCwYplLftkp4NWSUpSqZVusx7UbxnMl2A9CR2qMjzQCf?=
 =?us-ascii?Q?53GA6F2XxVSd+g+/3p2sLYbRCixYEtlLK7/3+YxYIe2LikWXZN1rVcbnUFGb?=
 =?us-ascii?Q?5OCKN4UBEDjzyBgf56b5K/WJ1Sy8OJ/pS09Fwczbe5QEVtKO34etKSJQ05d7?=
 =?us-ascii?Q?Mjt2KWn9s3k46zX9fFhA9YDNsjeeCbb5bQcWHCtUBLJXGGmDHVm1NhZUG76z?=
 =?us-ascii?Q?iMFf6dq+N7v0BkJlWoaYbga0xKx4a0K+XEtAaWGQSEh7SmtDvOrdl4ZO8kI4?=
 =?us-ascii?Q?V0tGRsfGAv+/TVQ7WaJMXPDD+/KLr6rO+G2UBpwGhSZ881oBgRCEAnFXKcn6?=
 =?us-ascii?Q?BgGFe7CIiUVFjQyTKILnFK8g/FV+5+cos2H635XSUp0KHzQOPtp09OK2T7qg?=
 =?us-ascii?Q?BR6V7I8nvMm03l0Q3UEN+pp05tWu2wpjGeK4mVbMYzVafwW+9pQ5LDBq2vk2?=
 =?us-ascii?Q?pXuI3w=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61018ad-ff09-4a5d-4f11-08d9bf2026d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 16:38:26.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IvMb42RJzlphk+bAr135bBrAbt1TUaj6E/XPPI676cdL31JmlXRjSF41e/SWndEba5qvTdUN8gwvifoQiIMFKPZI5A0TmPRnCKUoMsRROQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4804
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 02:58:55PM +0200, Andy Shevchenko wrote:
> When creating MFD platform devices the firmware node is left unset.
> This, in particular, prevents GPIO library to use it for different
> purposes. Propagate firmware node from the parent device and let
> GPIO library do the right thing.
> 

I came across the same thing this week. By populating the of_compatible
field of the mfd_cell, the child device will have the appropriate
firmware node populated. Unfortunately that currently means that I'll
have to put every device type in the MFD instead of in an of_match_table
in the child driver itself. Figuring that out is one of the next things
on my list. 
