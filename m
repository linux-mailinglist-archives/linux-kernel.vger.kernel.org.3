Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4285784CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiGROHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiGROHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:07:03 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10046.outbound.protection.outlook.com [40.107.1.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A18E24BC2;
        Mon, 18 Jul 2022 07:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibZyKTPk5AUwVWKHRSv7KCWggYn7jxEjcbtj5Wtfy068sKbI/qZSd9kvIxafpEM1ZGziQq3bQ465K9CT093gAPxfVL1ELDJuyIcTcXbaLarbBoOE+mN0Fyu8mPVb8v0xkPc9rWzCGJsIZxzmd9LtgNBim5F91s33ceW7fD53BgGmrDQkqh03E3u3UUvDK6zmGm2V6tJV8knRFEisNSV4z2SiV6Ffe+QW4Xnfsnsvfo7+vC8XNRVo0GemZV38DXRc7xPJh+FLsnF/A2OCOQUsJzdDsiyTQbFxeQgl/zrS+awrg2gMoYKi4HPK6zf2tiX4FMqtmYJn80mQbU1q0TTWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0jJYdSAJl81NHi0LFfU0wDtIuhgZQPUYnCRxkk96GM=;
 b=an3ixyw8C5qqXPePiNSw8lRogEdX3PddQPFpQ6XvYz/Ty0RR+yBvAhHXTX0wPSw0/wsY62C8bPRvqvJr/P3wVei4nwtxPXishKHVyoVa7g1bhSAcX/pcFKl5fWT0aFp9wntwNlbWKfR2sBs+mpSKRcNSpIMwi6UCnfcjVQB3C2pAmU92x7Q1Ck+bo7KWXUez3682h95VZFZyHp6QOxCxGyPnOJl65n9xoiVkuhyvvo9hZvHLvpQmC8pUNR2FsmCOgXeqHicLEXWsE2JXczZpeF8/lcHsCTF2n3kcVfM9v625cstSHoDaw28U9HjXUSHW0JAzPNT8TGkm0nA28ll9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0jJYdSAJl81NHi0LFfU0wDtIuhgZQPUYnCRxkk96GM=;
 b=WjTZaENDHR+2hk9THKkN6Td+Li8U6E1tBNuYwQC4KXBL561zPAVL4U+FHm62SOqmpTovWyY/Tlwik1AtNkfL7faJBAqaFSRUlGi7dAivQWmpVj/oetQqCvGcaBUejA8nDkvRw8YNCZwwMSKCChvS1ohhsUUmthrp/BCRuMf3c68=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 14:06:59 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:06:58 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
        =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 0/2] Fix kernel splats on boot with armada-37xx irqchip
 driver
Thread-Topic: [PATCH 0/2] Fix kernel splats on boot with armada-37xx irqchip
 driver
Thread-Index: AQHYmW0ch9mIta18dEqCAV8CZhAZb62EJdOAgAAGnAA=
Date:   Mon, 18 Jul 2022 14:06:58 +0000
Message-ID: <20220718140658.dbm6hq4jfgw2ndg4@skbuf>
References: <20220716233745.1704677-1-vladimir.oltean@nxp.com>
 <CACRpkdZ4tdKwYBaTGzc4DX6H8Bsib1cDLkTnpTiipCL7uFquXQ@mail.gmail.com>
In-Reply-To: <CACRpkdZ4tdKwYBaTGzc4DX6H8Bsib1cDLkTnpTiipCL7uFquXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b89fd4d-b49c-4903-a576-08da68c6c79a
x-ms-traffictypediagnostic: PAXPR04MB8192:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UpLbjCmpvH6oGDBwRXYOfD/LwXNUweQgLazXNw3r2At8QZy4mFfpMMwIE7Z9+Vdj3o8UzQv+e0ITK72DJOlHHHAdlVxeQzg/Uu4JZtYs+zqYEqwV3uEwH9vJ4MCaazqneAV0PIzb+ina/wUjBZK+/dm46KnlKYpCaNv5ai7hlaIjXb+fRY/XERcUsxLdVbqJ+nPctDgSkfD6IeO0IcgwcZPjxXR8oG839bXN2falqMcRq+leDQs7DE5WmHlArdKwWQX4MfBy9+tZ9VYusSRT8sx8VW7fYrzyZNSLNPQe/TwQVxYRdpa6TpKLVmZo5PybavYLQYYWvJ+Uw4zH7ljev5olgRqpc1vwwtbcG7oL365UisCZL3BNutWGH5RU1suuIXQvD2jzdGhiQygofQt/x4ydvUewVYs2wgcuLXJ8qKFhP1NMEySd7MNo4VxyYjMHedGUu9T5jkv95Y0bZ+x9Npbt27vxbIo+UvDgdsUcixcesIGMS3G6WHvVXEIxOD82qYDVMnT1mjUHhy/nMCBzWRyh3ZnJCvOBR4C7Jivdi/TWdPVCHm1Vni3LBuP9vK8TKxFXHn2uppTUne6D9+w8ZmluUIqlT2GfVJLgH7ienyv/7xJtNTVi84kVwDOqoNESB78dRtZ661kiyoeFmHnQyd3dLSRN2VMmIWNnmVu5n+Zqdo8hjbIqrx3noxSwZ0qoj2V1EA/dsfDGh+D7qfc0zu8YB1VStfQgSFBIvG7JOUetsV/EexmwzBSpQs1iegncqxzuf9KhrywJtVlacVKPxtL1fDkZ0NNFR0zRIJwZVNeF6gNkTg50+I8G73ZfWH40
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(366004)(396003)(39860400002)(376002)(136003)(41300700001)(26005)(122000001)(6512007)(9686003)(6506007)(83380400001)(38100700002)(2906002)(1076003)(186003)(5660300002)(66446008)(76116006)(66556008)(33716001)(6486002)(54906003)(316002)(86362001)(8936002)(478600001)(4326008)(8676002)(71200400001)(91956017)(66946007)(66476007)(64756008)(44832011)(6916009)(38070700005)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wi8JtoZSVNCvGzXF9vWBiTceFg7H471tNgptGM4hLKIDBA7pVyevibT1O2?=
 =?iso-8859-1?Q?EMiQLFDwKXTsce589yl98NHWtxMFM1tLrJcVwmcyvmYwNrlBtxfE1shpBv?=
 =?iso-8859-1?Q?xQjkB46rQ+xGsslLHH7Qq6AvT1rA7+8JIBIoBZbu8TI0pu8FsEZoWhJovl?=
 =?iso-8859-1?Q?PaKe0csE6fXrEhhKt6ICN1wYNHJ5tOC4nxhKx32BSigWjlyHasdipvEdm6?=
 =?iso-8859-1?Q?SXqKiqADpKKfftfrexqc7/Wwg1IggoshBCAfEHwH0SBm6b6sRYEOJX2bz9?=
 =?iso-8859-1?Q?gw+LPWEjvTbGefhVUMvWAXgL2lM3BQrDSe4duBJ5N8mkJr9z/yk81hFGNS?=
 =?iso-8859-1?Q?rpao25hh2M+nsyw9wAu4qbWI37npfKTzXhrFmzLFb0pF4CQTOLtViZy01D?=
 =?iso-8859-1?Q?alqgEYPNSPQuhK1eYRArpYhTMK2JAFBkUARoV52T2+xFB8VChgXSpfhXs9?=
 =?iso-8859-1?Q?iVfzVkf+ZsWf9MxSCxf0BCv/6OI2tzFU8I3TtPRQ6no5Ca8LrJ+n5xb2B6?=
 =?iso-8859-1?Q?tvb2L0xTHnXjZyIpFADV9iJFiybSK0JY9QsUCG5/pt0GqZcSAms9c+4Wye?=
 =?iso-8859-1?Q?nSkWf7X9XsRks8U5lUiJbUVJTrbTqmw8DPbPhdt3iyrSJqh83r5D4wuE1P?=
 =?iso-8859-1?Q?ezTdXp+Brj1RXoVLG4N62UdGs0DJtN6WgU22ptanZTX937WV57MoMizjfI?=
 =?iso-8859-1?Q?OAnQWtxF+0lzMeVxi5Cgc1PMnaIjKeaJF5TFQtSb47EMUjgHqJ1RFTXnRc?=
 =?iso-8859-1?Q?kcXpuRibrvFtthHAMNLjz4C2sIgDnZq9884oV6AT1ZdRjlNpFFPGoH4ObQ?=
 =?iso-8859-1?Q?T4+r/HGN3hCLbDbssk3vZvxe/boUBVMqf67gcbYceO0JmFE5ZmqFbeqNMG?=
 =?iso-8859-1?Q?EqSzd7AZqk8tePLlMB4kpcRdZwebMPHkILOl9SW+7KxRzmZobHg3thddWB?=
 =?iso-8859-1?Q?3y0zcDKrsCk5H4bjemUD8GToY+MSUB/ndhTN7ajI/vBsHwvI8hvqx7Om+o?=
 =?iso-8859-1?Q?RZymL12byM2ELFFLKDTrRNWtEWndqyCnY3+eAg1M0j8PntM56bsl2dIDWc?=
 =?iso-8859-1?Q?nN2QAC0OCIEcJ3EHDY2lXth53RX5Erjxij2uFBbZjaxFJLFIC/Ah5cd0/A?=
 =?iso-8859-1?Q?K7PeSJEqg+0ZE9wj3ZWjb6XiTP8p1iRLDSIywipJw4EC0lLjtRfR8r03g3?=
 =?iso-8859-1?Q?rgydOPWUHuHQTAwqtxhhZCxBO3U+3F5vT/88981mjoBu/4I2jipW967dv4?=
 =?iso-8859-1?Q?DB7nHdXAOmpkkQfzdLTwQU0USA/JaSzrNokYgFKwlCCLQk1u5Rwb3rHAq5?=
 =?iso-8859-1?Q?QAXVzCXX3uzsBeMTyTrlY+nUy+YSev0vzR5tl4SgvZPLAhz0JZMg1GRFfo?=
 =?iso-8859-1?Q?AY8cgilJJVVYHhIEPLTvCJfBZL5Ln9HZDbJHxPUz7G8VS8IXbq1uSrwLl4?=
 =?iso-8859-1?Q?1LN2oYo+kK1zrJJuW158oh2OrA81a1eT19+23c7qqC7hUyeFpsN0kXzcxD?=
 =?iso-8859-1?Q?ttdKzJsUHj7z0uMyej4UsWRTyKVLdbL6TAH0Fm88DlwsLuGuLATcpvCPrQ?=
 =?iso-8859-1?Q?oQIA2h/sgY7zwgNALWIbOmjup5x39jhSueR4QC6PZl+zrBLaC9eZ8N22rS?=
 =?iso-8859-1?Q?S97z4vmsTKGwdWYa4Qf11hhoqze7zK1lw/O3JbikSu1VdrYg6SHLSf+Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <50570F7A289B2547BA6FDF5A94D81DDA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b89fd4d-b49c-4903-a576-08da68c6c79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 14:06:58.7648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHa20ckc5hq7j5EcX7isbTl3EzmuJ9boTxS5ML6VWWDx2xSx6hlC4M3rGfraZhcPuv0EpIJx9DS0rEzMm6a3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Jul 18, 2022 at 03:43:19PM +0200, Linus Walleij wrote:
> Patches applied for fixes so they get some rotation in linux-next.
>=20
> Reviewers have some days to react before I send this to Torvalds.

Thanks for doing that.

> Should these even be tagged for stable?

They could.

This specific lockdep check was introduced in commit de8f5e4f2dc1
("lockdep: Introduce wait-type checks") which appeared in v5.7.

The fixes depend upon commit 67021f25d952 ("regmap: teach regmap to
use raw spinlocks if requested in the config") which appeared in v5.15.

So at least the stable 5.15 and 5.18 kernels can benefit if lockdep is
being used - that's without any extra burden of backporting the regmap
dependency commit itself any further.=
