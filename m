Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07FA591413
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiHLQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbiHLQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:39:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150085.outbound.protection.outlook.com [40.107.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FF2ABF31;
        Fri, 12 Aug 2022 09:39:38 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=l0oEyZKxSkcnd9lzlDCZwkSK78Rz37pzqR0rgmnVZ/b0P6UNfv5m0R/gXiJlntKSepmXji15zOt6Qr5HYZTui3+W8N4F1GoUV39Joy99MUHlR1aqkUNCSZUE5Rnybl4FupcGf7V4qsHloB++/mfQm0xbkpdD3ducAgWudBXBzNdjo0s9iE2n/t3CzX70RqsDwbqDzq9VNmBwrcBlYo7cAk8Wrd9UAjMXzmJnSf0kq35yOYsnDJ39VWCratORj7SGxFYRwKTXgwwXvstnHZdeGQyDCWqGw2HqTMp9vs8D4Kx53SMMW6EpZv1ZOhtDNRogAn1AtmxqTIGsz7ucoBVtbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T6MsxHUqEbPFlCy8q58n+JAr0cjUsaiu3Jkbd/Lfqs=;
 b=MXp/xzhKdOPVbM/kNlNr5vPf1TAQrOVTh4QiGUqTzcfjADphpwBRqvkhwIX7F8A/F4PcxMqxw/dU0R0RWOrcIFy9YDwhgh/qsTUxsGfnrWFimyiE+RAKHiv3ZyY0L2p/1fjWoVFBI0+0cSsQpkQr85fBMpAVHRgZLWh/uUW1d9EVFZDguO/Ur7lgqSH/BCjdUspwzoHkUtCP2MWJv3HUmQvFg3aqsfvhkmP1ytxh5nrqvm8PCJ4O1b6lAPflgVcx41J5lTmH9R7ScWhNZH7orjOBqNjNx1Ud5wY9Wo2k+g80GS5yG6aa985xBBZIGb2fsk6tDAWJzP2Piip8Ul311g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T6MsxHUqEbPFlCy8q58n+JAr0cjUsaiu3Jkbd/Lfqs=;
 b=i9dN+B7GwbMqZyvJTFQTh+eqg513zPZd17AujF4mMMi5HTNzVda2tVvww0AnxrNy/QREHu9o/u5/m1j0SiTyZ6t/ZikMLgTRzDSguKGc9lvEZeO8mFqWbIo5KvK/fDp1BotSC4vfPxJHc6/maxDsPPrqGRY1NcIGwf1q3vqcTIY=
Received: from AM5PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:203:90::27) by GV2PR08MB8124.eurprd08.prod.outlook.com
 (2603:10a6:150:74::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 16:39:34 +0000
Received: from AM7EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::1a) by AM5PR0402CA0017.outlook.office365.com
 (2603:10a6:203:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.13 via Frontend
 Transport; Fri, 12 Aug 2022 16:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT061.mail.protection.outlook.com (100.127.140.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Fri, 12 Aug 2022 16:39:34 +0000
Received: ("Tessian outbound cc6a8ab50b6b:v123"); Fri, 12 Aug 2022 16:39:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3554cbd9211e95e4
X-CR-MTA-TID: 64aa7808
Received: from dbc98588f6be.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 130F002B-321C-45A9-9F12-FBCADDDA3572.1;
        Fri, 12 Aug 2022 16:39:27 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dbc98588f6be.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 12 Aug 2022 16:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdkOdf+eTEgTUQtZxg8DUdEIOGrnsrn8S+kyudaOAzN2Xq47KiXWjsWMIc770h1wwc0OEETg51tqFEX2X/QRNLOpHlCxLMqFzjjfZKGdNZga1EHzpumCfQx8PI/p2Y0WeXud4AlWAjwqEOnCs8tTu+Vud39aicuJRXAWsItFph9N1Pc6+InA2MMoeNow91TLhF8eoOKhSfHaez9EuO8vaUq93leDKn5LX0z0J6Txe49hZWzty4N3Tm2dCrhmDiU998hD3Yr5mxwtlYckIQwew11DjGJpME6E9ZusBjBQVOoF2nrrnvmGpVkh+ud8N26t4xHMQ97j57ZgSX1y+6hjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T6MsxHUqEbPFlCy8q58n+JAr0cjUsaiu3Jkbd/Lfqs=;
 b=iNwJJXEoxfxC2bVh9PzaVTXFPqKPLsdql7+zwrSH8uWz9RrfF8K1p+9+VBw7akUIDR8/HByihuRYAtwnKsiJLT1TjiHHO90GgUn+c5gQLHvlrZ2G9emBcti+mH7yFwQSVCxTqrqspMfPEYAtyHZJkK7nCI1zHgmWHevWn8ETB10EChRMTI4w4bB2yfknwXZkuuMqGTpFtG/2s6h9/mlQZ7JaXCQptXHzSAm+UFCOjqXP581pdvjTAL1fgGGY2vnodQplQ4DBEquMhNDoyZZ3Agq/tQBOH2W3eaaih8De1RvIspUj3WWTicd66Q0CAK+ZT8Xn6v1fBEHwBeCf9Q6pnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T6MsxHUqEbPFlCy8q58n+JAr0cjUsaiu3Jkbd/Lfqs=;
 b=i9dN+B7GwbMqZyvJTFQTh+eqg513zPZd17AujF4mMMi5HTNzVda2tVvww0AnxrNy/QREHu9o/u5/m1j0SiTyZ6t/ZikMLgTRzDSguKGc9lvEZeO8mFqWbIo5KvK/fDp1BotSC4vfPxJHc6/maxDsPPrqGRY1NcIGwf1q3vqcTIY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com (2603:10a6:10:2a2::15)
 by AM6PR08MB3783.eurprd08.prod.outlook.com (2603:10a6:20b:8a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 16:39:25 +0000
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::6cf7:a261:295d:1b8e]) by DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::6cf7:a261:295d:1b8e%6]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 16:39:24 +0000
Date:   Fri, 12 Aug 2022 17:39:22 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Olivier Masse <olivier.masse@nxp.com>
Cc:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>,
        =?utf-8?Q?Cl=C3=A9ment?= Faure <clement.faure@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>
Subject: Re: [EXT] Re: [PATCH 1/3] dma-buf: heaps: add Linaro secure dmabuf
 heap support
Message-ID: <20220812163922.v7sf3havi5dpgi5u@000377403353>
References: <20220805135330.970-1-olivier.masse@nxp.com>
 <20220805135330.970-2-olivier.masse@nxp.com>
 <20220805154139.2qkqxwklufjpsfdx@000377403353>
 <7e61668164f8bf02f6c4ee166e85abc42b5ee958.camel@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e61668164f8bf02f6c4ee166e85abc42b5ee958.camel@nxp.com>
X-ClientProxiedBy: LO4P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::20) To DB9PR08MB6812.eurprd08.prod.outlook.com
 (2603:10a6:10:2a2::15)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 84c41acb-58bf-4dd2-ea0a-08da7c813d2e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3783:EE_|AM7EUR03FT061:EE_|GV2PR08MB8124:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: f7K3UQWIEuGznb1LSfd/Tid1L9fm8x9H2lEni/GHzHpU6WCQDq1FTuWFvZgbeIPrlbSir3xyEMETonbHA11M753N2xxo9UAXfH4Sor6Bu1FOuW34IKCbFlImqJNC72S7cbyMFNRnuP2T+dOcxYXpgRp/YFrdlWebkgRbylJHnIh5bN/mEYZSBgaj6AHsbRSwWzsxChZx4POdU5dMx+OGDpoVNv06rfw1bUczGFKZVgudn30V2DsKbdiszEOq6h2Fwqh+sE+McYTfJTpJDNKCXzo/0ihbzQjp85umEjYHrKa9XYdEzYg44iyXY5SuNtk9eyiqnMkENqVRFYJPf4K6rcu0sgUylne2yCzXH5wJWG50AmVHyj3M8HtePM3t0Z2JCMWZ8ERabLFT/+StOTYyS6fT5MADiXavJg5vA6RyU2127BT11VCV6Vl23njodjrkLS0ZjjflQfGMRui7WcasoY3TG9kPcy/E9a/rVeh9XMZLCMkVDZLuBVPSsVCLQGKes/8/tfFXivlEHo4zqwWfxn1M14daJ1PUMPJtOwLxEcX/mTy45tvyio0LNXCvsNrWHwd6Eggjed2jhnxue3rN+OQAMZBJuKrtVSaEASnC9WWd71k4oT/rPgEjWXXhbQ1GLj0NFWYJwfIPRx8P5+hPuUYU41bZVjFdro7clzxqAviCezDbRfCMLPiuSCJ3bLcq
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6812.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(8936002)(1076003)(186003)(83380400001)(44832011)(86362001)(38100700002)(2906002)(5660300002)(66556008)(6486002)(478600001)(33716001)(966005)(6512007)(6506007)(9686003)(41300700001)(26005)(8676002)(66476007)(66946007)(4326008)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3783
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b1eb25f1-9ead-4003-382e-08da7c813747
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HDWvwgVi0iXsSm/Ij3exGM6QnxeGRz+kbHTabxaMO4xgLiEZd7u4Dx0iGtPP3Ck5tm2SLarsmIJr01dRPFnz+eAxeRjcod7cN+4T4Xhgc7+CskgOfcJIKLy5k2zdMwgFT3Kr4P7YtpRl4WCbjnO1oAJO42Gc5C/56tvR85Lv+TR0CoyILrLIyM4n9P1oJ9sQqZDPvY5dwNWHZ5vrgG3n2BbmZkojvAMK6QytKJognEhmU25mmz6fLS9jiRtylM0ifgFfw9CdwV9xFIYvuHcCQ/G4JopvT0FFiyLJLsV89ks9JYdGs9MacujI3l/2lbIoGC/9LdxTrtogS2Q1ryzBFixNopvJJZ9ULWzraY2vIGS7u/3naiT7Rgj01RkY2DVXlDvMLoThDlBmM3RTEwDJcVx8peygpVAKcauH1WPnODo27+LCMw7NP8mXlzw/GNlv4d+htDXKGlauxZ7r7pXOt646B++KaOcMZM3V8fFo7Wsqt5BhVnC/KQjajKTa3y66edOIAgTImx9BC+OlQLPJLt7r3pDeS6JDIZHFJxwqRsgL1snsRiwZi21rn5T9KTR7eRBW0abauzQRj3bteIkV5Zkj14bUwMiZpJg6n8o3Vd3TvbjG0d/IgW7mj1ZkizvtMxZ6I1IhY1FmX3yUOc6nwkGER1+kqLXfoPhenaxo4hnO7mxcDEAnsPmiRDu7VDrwI/yk56CjmQZCb8SY+ajwEDy1YWr+9D1QqhLM7gtRD5Vqje+wdvC4kzbkTmddxHsw
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(376002)(396003)(136003)(346002)(40470700004)(36840700001)(46966006)(5660300002)(356005)(6506007)(81166007)(41300700001)(26005)(6512007)(33716001)(6862004)(86362001)(9686003)(8936002)(316002)(40480700001)(54906003)(70586007)(6486002)(82310400005)(478600001)(70206006)(966005)(8676002)(4326008)(450100002)(2906002)(36860700001)(186003)(44832011)(336012)(83380400001)(40460700003)(107886003)(1076003)(82740400003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 16:39:34.4675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c41acb-58bf-4dd2-ea0a-08da7c813d2e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8124
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 08, 2022 at 02:39:53PM +0000, Olivier Masse wrote:
> Hi Brian,
> 
> On ven., 2022-08-05 at 16:41 +0100, Brian Starkey wrote:
> > Caution: EXT Email
> > 
> > Hi Olivier,
> > 
> > Thanks, I think this is looking much better.
> > 
> > I'd like to know how others feel about landing this heap; there's
> > been
> > push-back in the past about heaps in device-tree and discussions
> > around how "custom" heaps should be treated (though IMO this is quite
> > a generic one).
> > 
> > On Fri, Aug 05, 2022 at 03:53:28PM +0200, Olivier Masse wrote:
> > > add Linaro secure heap bindings: linaro,secure-heap
> > > use genalloc to allocate/free buffer from buffer pool.
> > > buffer pool info is from dts.
> > > use sg_table instore the allocated memory info, the length of
> > > sg_table is 1.
> > > implement secure_heap_buf_ops to implement buffer share in
> > > difference device:
> > > 1. Userspace passes this fd to all drivers it wants this buffer
> > > to share with: First the filedescriptor is converted to a &dma_buf
> > > using
> > > dma_buf_get(). Then the buffer is attached to the device using
> > > dma_buf_attach().
> > > 2. Once the buffer is attached to all devices userspace can
> > > initiate DMA
> > > access to the shared buffer. In the kernel this is done by calling
> > > dma_buf_map_attachment()
> > > 3. get sg_table with dma_buf_map_attachment in difference device.
> > > 
> > 
> > I think this commit message could use a little rework. A few
> > thoughts:
> > 
> > * The bindings are in a separate commit, so seems strange to mention
> >   here.
> 
> what about:
> "add Linaro secure heap compatible reserved memory: linaro,secure-heap"
> 

I'd say something like:

Add a dma-buf heap to allocate secure buffers from a reserved-memory
region.

..snip

> > > +
> > > +static struct sg_table *secure_heap_map_dma_buf(struct
> > > dma_buf_attachment *attachment,
> > > +                                             enum
> > > dma_data_direction direction)
> > > +{
> > > +     struct secure_heap_attachment *a = attachment->priv;
> > > +
> > > +     return a->table;
> > 
> > I think you still need to implement mapping and unmapping using the
> > DMA APIs. For example devices might be behind IOMMUs and the buffer
> > will need mapping into the IOMMU.
> 
> Devices that will need access to the buffer must be in secure.
> The tee driver will only need the scatter-list table to get dma address
> and len. Mapping will be done in the TEE.
> Please find tee_shm_register_fd in the following commit
> https://github.com/linaro-swg/linux/commit/41e21e5c405530590dc2dd10b2a8dbe64589840f
> 
> This patch need to be up-streamed as well.
> 

Interesting, that's not how the devices I've worked on operated.

Are you saying that you have to have a display controller driver
running in the TEE to display one of these buffers? If everything
needs to be in the TEE, then why even have these buffers allocated
by non-secure Linux at all?

I would have expected there to be HW enforcement of buffer access,
but for the display driver to be in non-secure Linux. That's how
TZMP1 works: https://static.linaro.org/connect/hkg18/presentations/hkg18-408.pdf

Looking at this SDP presentation, that also seems to be the case
there: https://static.linaro.org/connect/san19/presentations/san19-107.pdf

Based on those presentations, I think this heap should be implementing
map_dma_buf in the "normal" way, using the DMA API to map the buffer
to the device. It's up to the TEE and HW firewall to prevent access
to those mappings from non-secure devices.

My understanding is:

* The memory region should never be mapped or accessed from the host
  CPU. This is not a security requirement - the CPU will be denied
  access by whatever hardware is enforcing security - but any CPU
  accesses will fail, so there is no point in ever having a CPU
  mapping.
* The allocated buffers _should_ be mapped to devices via map_dma_buf.
  Again the HW enforcement will prevent access from devices which
  aren't permitted access, but for example a display controller
  may be allowed to read the secure buffer, composite it with other
  buffers, and display it on the screen.

Am I wrong? Even if SDP doesn't work this way, I think we should make
the heap as generic as possible so that it can work with different
secure video implementations.

> 
> > 

.. snip

> > > +
> > > +RESERVEDMEM_OF_DECLARE(secure_heap, "linaro,secure-heap",
> > > rmem_secure_heap_setup);
> > 
> > Is there anything linaro-specific about this? Could it be
> > linux,secure-heap?
> 
> for now, it's specific to Linaro OPTEE OS.
> but in a more generic way, it could be 
> linux,unmapped-heap ?

If these buffers can never be mapped, not to the CPU nor to devices,
then actually I don't see why it should be a dma-buf heap at all.

If this is just an interface to associate some identifier (in this
case an fd) with a region of physical address space, then why is it
useful to pretend that it's a dma-buf, if none of the dma-buf
operations actually do anything?

Cheers,
-Brian

> 
> > 
> > Thanks,
> > -Brian
> > 
> > > +
> > > +module_init(secure_heap_create);
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.25.0
> > > 
