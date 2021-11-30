Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90490462CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhK3GlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:41:07 -0500
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:20480
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233463AbhK3GlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:41:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNV0r+Obw7LiTDRrOYfwIFn6ARBY2exHnuPK3q4aIFJWxVLw9s1sC4zZPXQNBr9jcQdyAGBT2eQMhoJ3KqkiHHNHDrzvJHB/2zldXkWBt3IDwGBNy/vekeEmBD2ZV5og8x9I6oMVlvvxnNDrqQidxvpmNJ3+pwPyttqraHVwWkNe3f/jvzulAjl7YbcEVojMkKd3omeVRd2XiyGpX0bZva+hwxakXxy/21j6HGdmolKxeRwZIu8aX53tpHYY2y2CpTi2JpiTXC2DPJbp/aO+6mp+N/qWW9kej6RGo2e3DT5pCO2DNmVHqoNji6gwAwcEfvdDyQb3gWXEZH7QY3FR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuWnsctZcA5Is/TzFk+ay3fOqRuGz4B2G1+qlD0eyg4=;
 b=ixAKntzX4cpsl/tpwwzD5YToIhZV1i66ddLKhcKQB26vBnJNsTS5ycTvMrD5JUvZ1vIRYo6LO1l2BuGSAuZsD7YAn4qq072THQ4wnX8aKuPFSiOTePuHJkv2RXgm25X8/uj8rrLxfTTtZojnwfr5YG8IUxHzJyNX6NGLsIRC96ovZA+B6YlvTgi180fwy4Q8+eS1ksI9SI/cBZ0jKS/Vs+QHEzm/zP5ZWFyn8qO4LthUgCqFSWoRmclel+jpg2rpk+zihbHEsHfhQTY/SXzTqbReqgJI6+4gBu+ARBFEz867JcZGIc0ady2V5HW/wad+PUEKBHZQuvJOXvwYPBjQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuWnsctZcA5Is/TzFk+ay3fOqRuGz4B2G1+qlD0eyg4=;
 b=VDnE7sd0rHhy8xqWiYT86yj26ByFhRHuAegRtI9BP5AoSjmWMnjzy0Dbu2vmeLfs617J0CE1Eo32o4g7hQeQ2evjM1WUgSC8la/tZIcRhPVUV6iLfxXB9Dvmx567PSWopGL1OOcwZGcvPezUd75otC+J5LVxvAanHZycbqs2qUQ=
Received: from SA1PR02MB8560.namprd02.prod.outlook.com (2603:10b6:806:1fb::24)
 by SA2PR02MB7836.namprd02.prod.outlook.com (2603:10b6:806:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 06:37:45 +0000
Received: from SA1PR02MB8560.namprd02.prod.outlook.com
 ([fe80::4513:36a7:3adf:3b0f]) by SA1PR02MB8560.namprd02.prod.outlook.com
 ([fe80::4513:36a7:3adf:3b0f%7]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 06:37:45 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Srinivas Neeli <sneeli@xilinx.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Michal Simek <michals@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Srinivas Neeli <sneeli@xilinx.com>
Subject: RE: [PATCH V3 1/2] dt-bindings: rtc: zynqmp: Add clock information
Thread-Topic: [PATCH V3 1/2] dt-bindings: rtc: zynqmp: Add clock information
Thread-Index: AQHX5a78uI2umgdOiUyv8fs35l1KgqwbmrgA
Date:   Tue, 30 Nov 2021 06:37:45 +0000
Message-ID: <SA1PR02MB8560D9A6A6C90DC1A90A2364C7679@SA1PR02MB8560.namprd02.prod.outlook.com>
References: <20211130055541.2789-1-srinivas.neeli@xilinx.com>
In-Reply-To: <20211130055541.2789-1-srinivas.neeli@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20907d96-2ed9-4485-987e-08d9b3cbeb15
x-ms-traffictypediagnostic: SA2PR02MB7836:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SA2PR02MB78363C5397252DFE02A989F4C7679@SA2PR02MB7836.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6etNoHdbWO5j2jwoy/AtPjJKqpetgLFN8Q+DLJR5hjOdfcZWhbsJJJYCcyHNV9zzbrbMgFSk8OeULd6RyUAilV2O1X/q4FrZfnddfAKafidcPLab2KrpQzPqymX+y+KIVQbrO4K3gQQQ982d5kY60V3U4VtjkgkUz+vH5z6QmiWZ9qjgjiH3BRbdNJAxIE3IuFnK0wclqArwM07CeFSDh0Pbs4IpKZG5f3LCCG5LkpDEH+r7BoUgrOY2/CvuYFGnzL1spmbgT71YHB8Pf0x5Ckg4oVUi1dJcUosIT2iQNOETTa1R0pLJJxqqMdE0yQ9zf0R1XQED5/HnhmuAW9eAdj2sIo0gdT+A69bFbwiG2qNjT/XAXkvugWgGJFu1LrYpuHL2geO0dys/KSU9jRK+4x9/ruRkkkZ/7nOSP+mqZjS6197xaDDiKFxVFNyum94W7hP88sac8OSeE65eEZFDhB91DVG8BQ271Z5Ja/RdZzBgYOr6J7WLWOw/nyXYOlHPZS8pU9WqmZxt/FAQXqFKO0c93qQkYxdbPpOEqJFGh3/7SDa8V65YfLpMH0CzMfj0GgoX61s4EEDStu0Ih9V4PaqM0FhBbECAbJ/MalMJywcpxsQyjX35kKuMZ7WwbTW++vwLM1ttAK9pVbMbPeGKtuTnsMU9QF6WEY+f7GoP+6RqgJFQOTT+VRHoy3zZdBjwIKxyckUK4/ky0QM+DYG2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8560.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66556008)(186003)(5660300002)(107886003)(66446008)(8676002)(26005)(66476007)(66946007)(122000001)(2906002)(83380400001)(9686003)(55016003)(33656002)(86362001)(6506007)(53546011)(71200400001)(508600001)(54906003)(110136005)(6636002)(76116006)(316002)(38100700002)(8936002)(38070700005)(7696005)(52536014)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?89BZ6OiC9ifljl3yuv7BXaVy6DE/4N6eDEVMWZQs5OhBxNkspnp35KGpemC2?=
 =?us-ascii?Q?uzJc2c3gxXSO3QYkksOxbh66xseyZUzXLeNc6VOcDICNZb3m5hM6FrMjrU1r?=
 =?us-ascii?Q?HXFO59RIWfxPHvLHbNZtZ0Tt2o3RVdnq1Wt47wz0RnX0zz7It8xGn4J3H+ZK?=
 =?us-ascii?Q?pMlCTM0HgwY+iSmmu4xe48g4aknRMg74SjbrnrMhIByKDCAxvAszxcthVE9e?=
 =?us-ascii?Q?KymczSIHzgUlKCkoO4dN/DFaQ5N0W1DV3qBQ0z6Kv/7JGCTU/a1UWpKRrHtm?=
 =?us-ascii?Q?FSaCV3wZyaoPFRsBsnxx5iQVz4m9F/IQwP5ADKQJ/kj5GFiXeUywpWenVHnc?=
 =?us-ascii?Q?A7Gnz2GctjrDf8hwuT8P4atHcMj6Bxxs9h3w47sf1AuE0hrp8dYSfGNjzwOS?=
 =?us-ascii?Q?932gAR2ZSdkR05XBkshBV/doxHj8cc5o1yQ3FRcLXovX7gFo/P6cety5m7so?=
 =?us-ascii?Q?RZhLGaudjYTGgH+voD3eLNEtfW0r9lW8K7JLTcX3lGRRh16X98OqlcXbLTbv?=
 =?us-ascii?Q?2ObH8rtntDALvVQjozdt32Endbmg/+8AQr1lVRNzZxg076T0Xnss5UaQgpNy?=
 =?us-ascii?Q?aIgps2V6QiXeG5tkDVZYdYlwI/bXvL3OH9l1lltp1SpzO1y4Ymkyt9h5uO9q?=
 =?us-ascii?Q?K32AvZYYVYdiZ3aGfxFBe1ZLCrIsyTOM9KThmzeuD305uskhv4mKEuuto4gX?=
 =?us-ascii?Q?70/UPg8pbg1xP9JkYzMPWGTk42aMxjtgsje4qOjF7eurNsJgse/tCsTI4RCv?=
 =?us-ascii?Q?b3pY0h6cOPjsRSlvsvtuPblPE1hqkSvzXYwXTmJ98iQDfhQzNMkVdesaOnlI?=
 =?us-ascii?Q?nH3uJEoZI79aHQOxNa/kgj4UAvTl+F14b2z0y7UtL5UDMm5NJdpZz755peah?=
 =?us-ascii?Q?U6gTKt1klJ+osFBBoaELwEHjykvC1gLZRKJveZmenzdZMFtbt1ydMCWyIPXt?=
 =?us-ascii?Q?Bdj5BGiP0ImqFugmNvdjVPK5vpJNrkvmJOU9x4CW4CKBOlEvDkouKT/SxUWA?=
 =?us-ascii?Q?0bHB1H+LgBf/iqw1MsenRG7sd60NTmU6u4T1JYvmCBGEmWyH2UcrTdlxpMoc?=
 =?us-ascii?Q?ZvlUmdzcI9MA7XHwMqgaeDfoE8TSdlRi00jGPxG5YeCall/55BOKMs6AGx5B?=
 =?us-ascii?Q?kUZzQ/80JS9XQQT79OblvMl+Jzp5p3nN40/jXFDydUf1G4Cqo8TNEak4ffMh?=
 =?us-ascii?Q?T5O2xwmNeix/icRoR8rHAX5VEju1JAiOKQA206BovJty7WBaOgTW7hgbVqLT?=
 =?us-ascii?Q?Ytc2n/oWhTU8vFfrNXbYifKgYsq+6STy3Tx/Ap9MIFgmMts6GCeh+QAkabyP?=
 =?us-ascii?Q?Cx+VMQi6HMG8K5ALOMc/ZXz+BSUK/+nJAGGsdNcdC+uewa4SkpyrJH63sG5i?=
 =?us-ascii?Q?GE/OHem9B7OnsDqrh/pNepOKYQokqIc2SR4oB18ZxdXfXyFYSDfA4WZiDRAj?=
 =?us-ascii?Q?ayNO/YupJSw0TCjdOdOSdPahkMV7F76MHeFeKeWvTdEToccHdGB9JJVCnbhj?=
 =?us-ascii?Q?i8bmvwSrifdc4PjpegBLMEs3AeiVboxudcxNizb22OF7yNA4fDrcD9fSpILb?=
 =?us-ascii?Q?JQa3sJGZ+Zn9k3TlaGbuBtLZn3BByIDwndv4iWYhuUxcuYIp+DbShcow51ZL?=
 =?us-ascii?Q?68rE3hkh75wlvb+5aOyazTs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8560.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20907d96-2ed9-4485-987e-08d9b3cbeb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 06:37:45.1279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NOknixTyrjtakt0OwblVxnL4RWo8ThvZrjys9ohR2xzluV6NuxX2o4dUlSVboHvCv5YRMhT4gfXlj155KtsQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Sent: Tuesday, November 30, 2021 11:26 AM
> To: a.zummo@towertech.it; alexandre.belloni@bootlin.com; Michal Simek
> <michals@xilinx.com>; Srinivas Goud <sgoud@xilinx.com>; Shubhrajyoti Datt=
a
> <shubhraj@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: linux-rtc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org; git <git@xilinx.com>; Srinivas Neeli
> <sneeli@xilinx.com>
> Subject: [PATCH V3 1/2] dt-bindings: rtc: zynqmp: Add clock information
>=20
> Added clock information and deprecated calibration support.

Better to also add some background for this change.
>=20
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>

Please add Rob and DT mailing list.

./scripts/get_maintainer.pl <.patch>
> ---
> Changes in V3:
> -New patch
> ---
>  .../bindings/rtc/xlnx,zynqmp-rtc.yaml         | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> index bdb72d3ddf2a..7e87bc1ef9df 100644
> --- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> @@ -26,20 +26,19 @@ properties:
>    interrupts:
>      minItems: 2
>=20
> +  clocks:
> +    items:
> +      - description: rtc_clk is the operating frequency of crystal.
> +
> +  clock-names:
> +    items:
> +      - const: "rtc_clk"
> +
>    interrupt-names:
>      items:
>        - const: alarm
>        - const: sec
>=20
> -  calibration:

What about existing users for this property?
> -    description: |
> -      calibration value for 1 sec period which will
> -      be programmed directly to calibration register.
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    minimum: 0x1
> -    maximum: 0x1FFFFF
> -    default: 0x198233
> -
>  required:
>    - compatible
>    - reg
> @@ -60,6 +59,7 @@ examples:
>          interrupt-parent =3D <&gic>;
>          interrupts =3D <0 26 4>, <0 27 4>;
>          interrupt-names =3D "alarm", "sec";
> -        calibration =3D <0x198233>;
> +        clock-names =3D "rtc_clk";
> +        clocks =3D <&rtc_clk>;
>        };
>      };
> --
> 2.17.1

