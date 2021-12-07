Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51A246B72A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhLGJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:37:20 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3275 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhLGJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638869628; x=1670405628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QpdEVsxy60Dvo2I06l2yNl7o1KqE4ET4HXgEiyZ5Ieo=;
  b=mB6hVjuVc58dqVPmYVANwYPLH7oGmClEs69iebRZP5L5acWYNtY1bpjx
   2X3i7BY5usa9iNTCByfmvT3kuZbD0JC+N1gZ9f9TZJ6bCqDLwteZJZYMb
   NjOZpzj6X8UHcJiP2j4ineq84ipqzBiCotm2Tc4zPKaf+8c1hJ+IdQBcP
   +SDS+OlPM2pn85cjuTJBxVnBEqbQQ8+vMJRtWxvRmnt7klaEkCpqoWZ53
   kY2I50HKKPNkRVYzaGSnrxJqmO8e/hwDmDbHSGvwopG0SqKXdIQcrreSd
   qddUrP5qcS3o13C1JDtGu4agQhQMz1yuqj0udHH6YP4HJGBfTtFK/pBf+
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="187640107"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 17:33:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPQq0E7h+gpqJXcnmMaNB/nOjT40mtMZ1C0v3srEBWX7T2NctV1TdbzGG7IDbvi7VGYoGHeKruflk2T7fFkAf5juh2FsY0RjwIq+vkwh0l9PTaHAf0Jjtq6OnPLqZ9w8g5laFW1RKEpuc/cwGlJW2gHo7ozTm4/DTa/bTTLjyoAQe9NHBkrvsw0CICc80dsPaLSiOQqyII2lPkreiuu3aiPtEq75M2yVv9u1l7NYM+s1RyEPf2lQFT3J7RECG1CGy0lzs6mZVAH41FQnCE46wlcm4vTGofinHb8FyCO0LrovCT8gJFSm4ZkGfsan87/oSgzf1RjXcdJPjajDLMnLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpdEVsxy60Dvo2I06l2yNl7o1KqE4ET4HXgEiyZ5Ieo=;
 b=GOYFJZ5CtzBzR7n3P3N2/XhvkP3pDIJmx8pWNeN+nZdfmZKC/VCiBKnuGv1Gxycmjhf4RtW7S4zssqyARB/IBuRDTkoHytXilOsgFWTpJGddUqGhIRUrcTmeZyXUOWVSSlCoElBeeruTleRV4t7Bg2vpvE/016gEG7VwvZa1FGgr8y/7X1Np2yQuLLEuWjjD2g3GHHoe5ZeJfoioQ4cdwtvUn0zWN0Lofu30jFQU9Urhk23/xlmEO9Abw835xMbG2I6T6LNinfbLAY1/DKAwdHk0WK1XWiqR1FZgIoDyHojPHyy1hqedgTDf0Lq+VIK6YKgV3piuoa7w9QE5UVlDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpdEVsxy60Dvo2I06l2yNl7o1KqE4ET4HXgEiyZ5Ieo=;
 b=tQyHp+kYY9J0qmUiDkNHgmPkAXE4MN2p5VAfGEpPT6DruxeGx+k/CJvOVSx0Ul9tLrmCY5RkltxeDYbDZINqBE2v1LDH3OM3/wKH0oJmPoToYtVsbKq6ADTORMOaCUUoDu2GGBbs+7T2LOF5npaNt7NhM+c+WBC1xGJfqzg9N28=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5450.namprd04.prod.outlook.com (2603:10b6:5:104::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.22; Tue, 7 Dec 2021 09:33:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::970:e4c6:a13d:7e24]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::970:e4c6:a13d:7e24%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 09:33:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Thread-Topic: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Thread-Index: AQHX6gvX/BT/iVXcEEKk0MhaGQh9w6wms6wQgAASTICAAABG4A==
Date:   Tue, 7 Dec 2021 09:33:46 +0000
Message-ID: <DM6PR04MB6575BF4FC2DE49885D0EEDF0FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20211205191009.32454-1-nishadkamdar@gmail.com>
 <DM6PR04MB657527FCF325EA9760032DA5FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20211207093009.GA11794@nishad>
In-Reply-To: <20211207093009.GA11794@nishad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33274b22-374b-4ba4-4b8d-08d9b964aaf4
x-ms-traffictypediagnostic: DM6PR04MB5450:EE_
x-microsoft-antispam-prvs: <DM6PR04MB5450D2D2FF559FD2BA76F671FC6E9@DM6PR04MB5450.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KVoJKEsAQMn1nBOCvZstjwpvEPV8Dwi/mNdaTsqC7V2thAcEDQwot2PHFngNtpe92YM9m3dYgn7RcsT5Nv2P9wdbRHXQrQR59AgdHVk0G+LxVjR9NawRC8qvRweB8VPR3fQy2p8FjIgVyp1GCKz+PYl2NFrIY6OOJ5+odzSsfUEPvAGvhbTWXuhadjg6wW2p2gvgLz/X3W2uea09A18Rh201sFFUxj9x/zKaVJw7orRH9aTbYBGWWA5I92nQGNgMcC/IUfTVQqHAlH3zMz8oUtVM+GF7CQu2LcbXlYyffayhHJm14rpemJuuI7Nde9dRz8HGw4d9/vQuXVglPbm76o+L3PP4T5cIPU6uW3XzCBfRi5vNsNvrodqzn85Z/Ja1c8Xbq3cwMEvvcF+Ovlm5c3aoZhiiCGTtvCBkCDVKLh88ZOOWGWcCe6l1+/OaGxhKm8mLKNUN8z6y1ebH+dHv3u6Q6GUk6URREG5jCXXGxP6t4p4L3ILh8rxAbPLOWY0jiZ8BDc/Fi9s1QjGsqzGeQ+WndWL2JXgdR+T0ydsUWnG4Ij9wzgHWt2kCJR75V0HN7x4vtWqx+0ZHS8CB6g2liPi76EKYOB87PHcLU/aBME04jmIOufald+awNotX8Rj7+gYWkJkjOjJGN0VlrcgxPezWX6rv2WVqN6lzz4VJbz2ZK1XcFoPHeHH2o7XBJ5OYvbRh7E6nE2I2LRHq0xg7jYBwFAnAEHrp1zIFKCbDHtA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(2906002)(66556008)(66446008)(83380400001)(64756008)(7696005)(66476007)(52536014)(82960400001)(38070700005)(66946007)(54906003)(122000001)(38100700002)(76116006)(110136005)(508600001)(316002)(4326008)(6506007)(26005)(5660300002)(71200400001)(8936002)(921005)(86362001)(8676002)(33656002)(186003)(9686003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cxAMDwWHFylcd3LXKpWvdOpVykQkAh8dYSNg/2vVe/K5agzqO6LmkhN15t?=
 =?iso-8859-1?Q?aHDz6ifY6hmwYRDBj0PegWnvC0of7mwUBMIKH8uspEn/Vu1sTCSzazCr54?=
 =?iso-8859-1?Q?9A/MgT8EzELqAbNRevR0rvPLiU5zIxQpA90BxTSV/8AXv7jODqJbLRMoi8?=
 =?iso-8859-1?Q?4Y2gYiaTY3CFUVO+2zTvM5cB6apy6vt6q1UPsw7NUsiDMBGZ6tQd55OBs9?=
 =?iso-8859-1?Q?Th1mrxEFHVdfECXLQWLba6DHG6VLFvu2IJjMKHjRYTvuBvXcu37V9jLXON?=
 =?iso-8859-1?Q?HW5wnRPvnLw3EaMBnRYFT+qWe3iGRR1QjrQUWUuSfzcnzYDMnHyGTFQdae?=
 =?iso-8859-1?Q?N/2+wYD2e6XPU5uK9E9Gtl031yg6HkkXNjdGc6dDoAaNMzycXlEGumnAyE?=
 =?iso-8859-1?Q?b/riaij/fVKzrEeQXrF16k/hhrLninIKc5p0JzPMXOsZJVkXWTI9TNYv6z?=
 =?iso-8859-1?Q?npnj2y+V4/+Ox1+7M/+XcnrzHwELjColZ+kBupU3SUimMD2n08XHK7fqOa?=
 =?iso-8859-1?Q?Uh9yZ7NzUUEzcvvc9PeFg1ArE6zhQPdHBI+/Qg3/3NStex8Y2CF0sSstWM?=
 =?iso-8859-1?Q?WP18A8/aHs8xhyuKK4UPmWWEBKDhO00lanH+xbv5L+3pV5mq6q02AMzgUW?=
 =?iso-8859-1?Q?wiW8ycQ12uEcpi4SECJOEdzsk5ke6vbwpQ7lFSCYBm9makwC/KSNBE24fY?=
 =?iso-8859-1?Q?dIgJjMYyziIRMgvrcBURS1TMfVNT+n07/QDzOFDcz3+2zXI6JctBr/P4VR?=
 =?iso-8859-1?Q?JK5/JjOwxcHOSIpmSiBLwT3HZN6NOLfCLZw6dUkKOGZLY9dtQxL+WApwVC?=
 =?iso-8859-1?Q?y9sFiAVE1FM8rkc2kzb9WG0R0UMoI6WMGRB/Z3Nh+HjrV1b+dLfCfarsgc?=
 =?iso-8859-1?Q?eIukOXHVYyq67vM3oTos4CCQBFoKTINsGl3nQiR+sDsfkf5uwTnCo/RsUm?=
 =?iso-8859-1?Q?BL9daVDMP8pbnHtDIGEZxGvfSBm9mAdcTwQ4ofVApFhXyaNxdJ3Nw21w4m?=
 =?iso-8859-1?Q?F5wRsN9L7LLYAptSQ4izyxTKhcyl/nZ5D2jYs+EoDPr9hqlRbo0oBNS7a/?=
 =?iso-8859-1?Q?DFIPc8c4wP/Z8ufpWpmsesMp0bF/n3/hpH7l6HILovp04FOUyt64TFL9FS?=
 =?iso-8859-1?Q?3tMWrqzuUn0yh/UV5O+p4cywPVi8VV7uL9lOIG3X6YMLPYhOHIl4qGUG6J?=
 =?iso-8859-1?Q?bP+rdBjQ5s5PeicfbrHuLb2hiU30VFFNpZ76ij8u9jMU1kJECDIqKO2atj?=
 =?iso-8859-1?Q?tPo1RkwHi1ktHzhX4kuSJVG9x85g7uoRVHc4TEk3b54VHLemLDFA/4SFF1?=
 =?iso-8859-1?Q?mdMX20EJbcqSkQu1/swXnXXk3UaZazZ+fx0y/OGBtyX58htfMpYUUNnJcr?=
 =?iso-8859-1?Q?Wi36f1ODm9M8WQapmbWO0TOm1aVHNReVozsVkyyruQ37C5ElZ6vzK9dfei?=
 =?iso-8859-1?Q?8T77sjXBnt1wOH4xPSdqYCjCAgsyAPbl1aYUYhVytUrQlUQMeFfy5mwIMQ?=
 =?iso-8859-1?Q?+OlBBL/xkWkNTx237wmb//eEREnf6U9omEh9fsDeP/bu1mo/FxtmpL38rv?=
 =?iso-8859-1?Q?Q/T5ZjGvwEK1SUstQX1Hjq9bpBo0y8agXkT9DraJOeFagfO2UzdgoYKVEb?=
 =?iso-8859-1?Q?P+4TCpch8dc7UmBrKg83hwr4mrscI1wkynqqw7kY7FzWPJTEC/EEaQXNJr?=
 =?iso-8859-1?Q?wDms/nKhon3glvnIyYQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33274b22-374b-4ba4-4b8d-08d9b964aaf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 09:33:46.4391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rAmD2tY1ipRjcoCZPKE2rAkn6NApQkot6WxiwUQujvXqBuKL27LbcoHaSuyACQbX4LtXR5vr9cZF9e9n7W0fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5450
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Dec 07, 2021 at 08:28:42AM +0000, Avri Altman wrote:
> >
> > > This patch adds support to set the RTC information in the eMMC
> > > device. This is based on the JEDEC specification.
> > >
> > > There is no way however, to read the RTC time from the device. Hence
> > > we rely on the response of the CMD49 to confirm the completion of
> > > the operation.
> > >
> > > This patch has been tested successfully with the ioctl interface.
> > > This patch has also been tested suceessfully with all the three
> > > RTC_INFO_TYPEs.
> > If this is triggered from user-space via ioctl anyway, Why do we need
> > this command to be implemented in the kernel?
> > Why not just add this to mmc-utils?
> >
> > Thanks,
> > Avri
> As per the spec, B51: Section 6.6.35:
> Providing RTC info may be useful for internal maintainance operations.
> And the host should send it on the following events:
> - power-up
> - wake-up
> - Periodically
> Hence IMO, the Kernel would be the right place of peforming this operatio=
n.
But your patch doesn't do that, is it?

Thanks,
Avri
