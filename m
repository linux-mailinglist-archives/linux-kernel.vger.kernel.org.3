Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4E5B14FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiIHGra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiIHGr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:47:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6060D2932;
        Wed,  7 Sep 2022 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619623; x=1694155623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XdML9w+cgVBrLO8YYSnf1+X+LwzjVFtq/KrMdFRgbyI=;
  b=LQbcpu863Mx9sHI/85IUqgnQfyRjGvDTkDZpZSEuNV3u+YHtpBpNf2MW
   l93HEE5VrttPjoGSI+f52yUvsabRtVDtEFqH0d2ASA/CkryDWq/yerX3K
   wVkvc+eVvLXuhHjJvHR1pW1jzBiRWlv2S1jL6ri3MklGA8pOeDcNxCk9b
   xBqO90n4Vr0ITd8bDb1JG0kNGdNIXgP3p5P0157TJBR33oT0+lgjebPw6
   cjv3EVIQDk1iUv8eAD2qWn/neMpbZNzFf/Z3cQ4bx20GTCzimR8szCFzp
   m03tphjcm0S4JoBTQNJCQANDpCiKhVeETJ6uFv+BFgozFUYjNf8hidJoQ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="176154942"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:47:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:47:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 23:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm1TXk5bl39eP57jLFMjz3uL8bEBkG3jyezHpmpO71hH1zZ3WZXBNdlQ1nmbYHKtmN0e0goJX+uJZTciV1txLxWxOYwsnpDLPnzlwDjtjnr4hOXf/qmEFXwnPMapuubWjeyFxiAfjEbdZEi6rCuiuyYx9RyQ4ou61n6jD3nBX6ZbEZXNvt/khyC7l9SImnufZ5jGmOAo8C6fv79EkL1Kjwoeadw73Vn39UtVpoHE7xKkqAIF5v/0xJnyO0BtEemwB70gUwA8Xg2LZz4r9+cl2InEOrTADSUJUlzpot+yaSum0Lbu5AeJedI/ykt+g4sCmINdboY0mYnl4kmZK93J0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdML9w+cgVBrLO8YYSnf1+X+LwzjVFtq/KrMdFRgbyI=;
 b=VZW1wCnwr1uliAlbEA276NMyfBZzpG6UmEzHVFfvQERE98EkhgETWe1+lq2wpVj3U++/vtIKyXziMMMpD36twE8sxoW91rt/JxmPNuprjE2vfCPtzXEhfYgWb2lcAoUS6PWqJxppE4FBG8A2A/uZ5hxxCq6r6AN+Co4ki+mX9mjnRIdim56i/+bdFTf1TqR2VjCukU1P84AEPcQe9tCujegaog8xAiiGLFbsf1uiizd8MViGQlrgez9/y7E5MVkrcNVW82VGZA7OoZ3cXSlvV1REguB1L/v09y5vwpFUkHSRxzhy6D4qmFblCaUr+r3qBVPEE6dB4qajn6YASuNe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdML9w+cgVBrLO8YYSnf1+X+LwzjVFtq/KrMdFRgbyI=;
 b=BucB7/KIl/VbAXw5moRiAFbq8foFxz8Yk/wzslje2nwDruDgF6ZdjyBC+WewNud7gyFeWI9qr9dlFuVx1QlufMEr96MMz9knWQxFe2CXD9kv0S2ggtWGL4IkRKg6bMMX1zv+dhLUoAph+SmGNxZD1ak939Zu4bs6kgwDLkK3W/A=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 06:46:47 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 06:46:46 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 09/13] clk: microchip: mpfs: simplify control reg
 access
Thread-Topic: [PATCH v4 09/13] clk: microchip: mpfs: simplify control reg
 access
Thread-Index: AQHYw07DPY7eVTRU6kSF4CNiITunOw==
Date:   Thu, 8 Sep 2022 06:46:46 +0000
Message-ID: <e2a8edee-3bf3-2ab9-48c3-9f6f3c04f3b9@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-9-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-9-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f54d0f98-4b3f-4ed2-cf5a-08da9165e663
x-ms-traffictypediagnostic: PH7PR11MB5766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 43/ufOSPtlGhWYtzMa7niKhQM/q1EvZIbE8rpgzBwEUx72Pc+q/Aqu+xk0e0sgDDNaHw//t3Sj2aiuQVQJtC3stwETMSdlOkVBfRqk6bd/fD5yvSOYfFgKiVzBmKxCwQSy9/rVOFp9XX+FwmJSvlAE1+HoFtnjrUn8C8tMMg4e6fJ+/8ccYYhOntuKyN9QdX4u6dPh9u4JFTQtND5Ciip0mMccRkgFWBPHscKBYUzfV+u+VNMF7TJO475HhW9g8EwaGUUXO6ZB+vEH2N017AVORDZb3+5U2gRQBtodpA9msN3GMWXWo6IpdS4j7VBmMD1sb0a9TR4XDXwZquQTXW+zRBk4phqWyVUqktNSOCDDnEZz9ALwOBJQkNR6hBVrwtNgZ8vqzgqOu450eE0KPWCheWjIZP7KKI91xD6pAt+I9ofl+tI6WrC9ZtA1UfVQxRKLVesgmRZECr7v7pD060DnwaAe7mBhsx+H/IlLRfhrvD9R71SNWW87E2+s7J8VTkZIWxQoy4BxYaS5T14q4EuehIEhMAUvxTcVZ/GoWAMWOWLNTtrokH3UB0IfKFEH4XFx4vZmQ7yM/fhnysuI7Rj7GSyLCl+ELJrdEr9Wyws+1WhryaJvhA41PpQcjCiDLJlg1BVBGDpjlxabENejxcOvgN/LTVZtua+NWitiliKOQGJ3p58/I4JiechX006v5q7bYFPkpFP9juMMwFWShARRZGAqeJxBWwOwhrOwt7w93EquWO+OiExYstCj8NomSnNtulkCwhS34km3UpvIXWPVPOj4knsDAnEeUFdjSEnGzBAq7ScMi64YoT1rvizk5PC4Sam6/lp2n83G96EOgAHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(110136005)(316002)(2906002)(6636002)(83380400001)(6512007)(53546011)(6506007)(478600001)(54906003)(26005)(7416002)(5660300002)(38070700005)(31696002)(36756003)(86362001)(8936002)(66476007)(91956017)(66446008)(66946007)(64756008)(8676002)(31686004)(122000001)(4326008)(186003)(71200400001)(41300700001)(38100700002)(76116006)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3ZQcWt5MWFKUUdvSm1oMDByUVoxVkNkQkcvd0hrakpXSGlNSXV1RWhxckp6?=
 =?utf-8?B?TmJYN3dxcmJMZzZUNkpkL3lPSStEMi9xUWtXcStla0lLYkl5T2VpZTBmQnQ1?=
 =?utf-8?B?ZGMyVVZuYVUrc2loYWpPOTBIWGV4dzNJOENhNi9hRUgxTkVacWxPRUk4R0FM?=
 =?utf-8?B?UGxMWkl5TG9UeVRaUlFFd2NDM2tOc2ErMWd3a1lrYUpqRElXSEw3bW1ReWpB?=
 =?utf-8?B?SDJGdTg0WUxBQWdWNGVvNTlOUnZNS0NrdDdwSmFycnpoUnZtSG9jYkVmbXdY?=
 =?utf-8?B?YUVHQzF2VDJWMnhyWmJmWWc5VmZjRGhsY1lLNFBlaVU0M00yc0NpMi9RZ0x1?=
 =?utf-8?B?YXVMci95L0xWbFZDZVJjMktVNDJKM3BoeUUxVU5weC9XUzBET3pGYUNpSEhh?=
 =?utf-8?B?NWJ2L3NFYXBPSHNId0daU0x2MHY1RlZTc2gwYU5EMjVuVFZaSnk2RGhwczdt?=
 =?utf-8?B?dHM1L2FUZXZyaFZRSnJMTFp0MFF0NjZmOUFNd2hmWkYrbWlIQ05rQXpqR1Bw?=
 =?utf-8?B?M2MremhaSWtpeFdYSTVuajBvcnd5UmVXdzRrSmdqVDhHSHlRMWFkZWR3QlJn?=
 =?utf-8?B?aGJtbFRQRTZpSTVoKzVXVUI1bFNjUHBBTzNYa1JKN3ZtZGI1QnF3WnlYMDZo?=
 =?utf-8?B?bGovT1p1ZkdLV1JvM2hpaWE3VjZVdzl6bXBZZUVFSGsrUncvSzlWblV2Sm51?=
 =?utf-8?B?OFZ1d0x4TEtURlk4UXZZU0dtc2pwbTdvclBibEVJeU1pWmJKQjVNMDRBSjNJ?=
 =?utf-8?B?eFluRk9XTDV5K01lcFVLdy9LdzhmdG1QUHg1aktNWTVOL1lDQTFQMjd3V3E3?=
 =?utf-8?B?L1VhWng0TVNMY09aZnIxMFRrZEo5ZlVNbnlEbXJHaWVUbXNLWmV2bFZ4RzFN?=
 =?utf-8?B?VjB1enZDY1MyOFlINER4V1BoK0h2QlR5S29iR3RBalAwTWdXYUJTaTc1SjIx?=
 =?utf-8?B?ekZjUWFHOGo0QWpsTG1FVUZZQXhlSk5hUndQRE5ZWkF3R2dkNXZ2KzIrbFJZ?=
 =?utf-8?B?bjQ5c2JHQkRzRXRYZm1ETW5TWFlZeTl2Qm0rYldBVFdhN2Joc0dIRW1COExX?=
 =?utf-8?B?TUJXQnhxL2lEc3dlNDgrQ09kbHFMaXlaYUpOM0FYc3dhUkNlY0pYOHhJc0tL?=
 =?utf-8?B?R3M3OGFaU3J2ZGo0SER6cUlzSk9McllJUEJvRTRCQ2c4ZGtNMWNXRGNFTlVN?=
 =?utf-8?B?M2ZHYzlCclBFRzBCamM2N25hZzFDZkNybkNZa3lRNDk1NkYzWVNTZWNERksv?=
 =?utf-8?B?SmNDZHAxS1lGckZIOHExMlpUVDlnWlFvNWJiM0oxR3VidFJVRUlyOGlxc1VY?=
 =?utf-8?B?MGJmOVJBRGJNcXdjdXEwMjBXRHE2MERSaHZkZlRzdUdXS2RDRkRRN2F1QWxV?=
 =?utf-8?B?NWpxWkk0ZTl5S05IV0dtTlhvNkRxS1VCUi9hNnJUM1RjSXFUbUJLaUUrTk5U?=
 =?utf-8?B?dXZHQWZ6SXlqc0I5UVBUYWNwcXlLdVJudEpQMDI2SE9lZXRJZGZ1ZUo3ZEZE?=
 =?utf-8?B?UWlQNUM2ZzZKamNDM2lwWmd2UG5FTjdpUjFKZzFvK2FFQmJtWjkwL0ZHU2FV?=
 =?utf-8?B?TlF3T3ZiU0xXVTVMSmExZlRKcFlNQ2V4RWlZZFBoL3czcDBVU25FUnM3QkM5?=
 =?utf-8?B?WGx5T2RsaW14Q0k3YnJRanM1TUV1MHRFSElLazBCR0JtR2lldkpPdWhlWjVi?=
 =?utf-8?B?Lyt0dzFnZSsrZ3puYVdZYWxCMFkzRmg4eCtXYzhJYVBxUWozWTBudEFYUmlv?=
 =?utf-8?B?bjFUV2NIT1pyN0VIamlyYnJTVTBMcjFTTGE5ekJMNnRnakpZTU1rcWkzcXdQ?=
 =?utf-8?B?aFFTb3N6UXpGWUVrRDlLekRTTE92TEZCMFBISW9MS1J0UzRtZGNEY2J3Zldn?=
 =?utf-8?B?U2Q2ZUF5T0N2R2xWelNaRnpySFhyRS9RbjVpYkIyVTJUM2p1YStmR0R3aW1i?=
 =?utf-8?B?MDcvSVR2WWF4cVM3QmxFc3VHOG5sU0d0MitXN2Y1N0lIc3FZbEJDL1VSbXR3?=
 =?utf-8?B?YjhtS1l3Mm5sL3RTZ3JkSU5Tb0x6SmRyOFF3QnN4QmtkTTN5U0p5b2kvVGR0?=
 =?utf-8?B?Uk1Mc0UzK2poYjZzclBHL3ltNlFOZ2d6YmlKc1dtalFmWExxNWR0aU5HbzF1?=
 =?utf-8?B?dnlMWlVxajBTQUVnV0JSTVIvZmFJOWcxRGtlZjIwRzVaLzVLc3Vtd25yOWph?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5361FCA14500D94AB04BC18F81E7D116@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54d0f98-4b3f-4ed2-cf5a-08da9165e663
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:46:46.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xZ+yccI3EnG+IYyQRHwum+BP/Wp/1pFGvcfa4oJ3VcBu/NIHW7cvMi4HzNbFnZCwviUpp+uuZX9RXCPPbT1z/NGWfQWiPxVdO3E5zcRrBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDguMjAyMiAxNTo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBUaGUgY29udHJvbCBy
ZWcgYWRkcmVzc2VzIGFyZSBrbm93biB3aGVuIHRoZSBjbG9ja3MgYXJlIHJlZ2lzdGVyZWQsIHNv
DQo+IHdlIGNhbiwgaW5zdGVhZCBvZiBhc3NpZ25pbmcgYSBiYXNlIHBvaW50ZXIgdG8gdGhlIHN0
cnVjdHMsIGFzc2lnbiB0aGUNCj4gY29udHJvbCByZWcgYWRkcmVzc2VzIGRpcmVjdGx5LiBBY2Nv
cmRpbmdseSwgcmVtb3ZlIHRoZSBpbnRlcmltDQo+IHZhcmlhYmxlcyB1c2VkIGR1cmluZyByZWFk
cy93cml0ZXMgdG8gdGhvc2UgcmVnaXN0ZXJzLg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhaXJlIE1j
TmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdlZC1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0N
Cj4gIGRyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jIHwgNDIgKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAy
NSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9taWNyb2NoaXAv
Y2xrLW1wZnMuYyBiL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+IGluZGV4IDg0
NTY1ODc1MTY5MC4uNjBlMWU4MjkxMmZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9taWNy
b2NoaXAvY2xrLW1wZnMuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMu
Yw0KPiBAQCAtNTIsNiArNTIsNyBAQCBzdHJ1Y3QgbXBmc19tc3NwbGxfaHdfY2xvY2sgew0KPiAg
I2RlZmluZSB0b19tcGZzX21zc3BsbF9jbGsoX2h3KSBjb250YWluZXJfb2YoX2h3LCBzdHJ1Y3Qg
bXBmc19tc3NwbGxfaHdfY2xvY2ssIGh3KQ0KPiAgDQo+ICBzdHJ1Y3QgbXBmc19jZmdfY2xvY2sg
ew0KPiArCXZvaWQgX19pb21lbSAqcmVnOw0KPiAgCWNvbnN0IHN0cnVjdCBjbGtfZGl2X3RhYmxl
ICp0YWJsZTsNCj4gIAl1OCBzaGlmdDsNCj4gIAl1OCB3aWR0aDsNCj4gQEAgLTYwLDcgKzYxLDYg
QEAgc3RydWN0IG1wZnNfY2ZnX2Nsb2NrIHsNCj4gIA0KPiAgc3RydWN0IG1wZnNfY2ZnX2h3X2Ns
b2NrIHsNCj4gIAlzdHJ1Y3QgbXBmc19jZmdfY2xvY2sgY2ZnOw0KPiAtCXZvaWQgX19pb21lbSAq
c3lzX2Jhc2U7DQo+ICAJc3RydWN0IGNsa19odyBodzsNCj4gIAlzdHJ1Y3QgY2xrX2luaXRfZGF0
YSBpbml0Ow0KPiAgCXVuc2lnbmVkIGludCBpZDsNCj4gQEAgLTcwLDEyICs3MCwxMiBAQCBzdHJ1
Y3QgbXBmc19jZmdfaHdfY2xvY2sgew0KPiAgI2RlZmluZSB0b19tcGZzX2NmZ19jbGsoX2h3KSBj
b250YWluZXJfb2YoX2h3LCBzdHJ1Y3QgbXBmc19jZmdfaHdfY2xvY2ssIGh3KQ0KPiAgDQo+ICBz
dHJ1Y3QgbXBmc19wZXJpcGhfY2xvY2sgew0KPiArCXZvaWQgX19pb21lbSAqcmVnOw0KPiAgCXU4
IHNoaWZ0Ow0KPiAgfTsNCj4gIA0KPiAgc3RydWN0IG1wZnNfcGVyaXBoX2h3X2Nsb2NrIHsNCj4g
IAlzdHJ1Y3QgbXBmc19wZXJpcGhfY2xvY2sgcGVyaXBoOw0KPiAtCXZvaWQgX19pb21lbSAqc3lz
X2Jhc2U7DQo+ICAJc3RydWN0IGNsa19odyBodzsNCj4gIAl1bnNpZ25lZCBpbnQgaWQ7DQo+ICB9
Ow0KPiBAQCAtMjE0LDE0ICsyMTQsMTMgQEAgc3RhdGljIGludCBtcGZzX2Nsa19yZWdpc3Rlcl9t
c3NwbGwoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19tc3NwbGxfaHdfY2wNCj4gIHN0
YXRpYyBpbnQgbXBmc19jbGtfcmVnaXN0ZXJfbXNzcGxscyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBtcGZzX21zc3BsbF9od19jbG9jayAqbXNzcGxsX2h3cywNCj4gIAkJCQkgICAgIHVuc2ln
bmVkIGludCBudW1fY2xrcywgc3RydWN0IG1wZnNfY2xvY2tfZGF0YSAqZGF0YSkNCj4gIHsNCj4g
LQl2b2lkIF9faW9tZW0gKmJhc2UgPSBkYXRhLT5tc3NwbGxfYmFzZTsNCj4gIAl1bnNpZ25lZCBp
bnQgaTsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICAJZm9yIChpID0gMDsgaSA8IG51bV9jbGtzOyBp
KyspIHsNCj4gIAkJc3RydWN0IG1wZnNfbXNzcGxsX2h3X2Nsb2NrICptc3NwbGxfaHcgPSAmbXNz
cGxsX2h3c1tpXTsNCj4gIA0KPiAtCQlyZXQgPSBtcGZzX2Nsa19yZWdpc3Rlcl9tc3NwbGwoZGV2
LCBtc3NwbGxfaHcsIGJhc2UpOw0KPiArCQlyZXQgPSBtcGZzX2Nsa19yZWdpc3Rlcl9tc3NwbGwo
ZGV2LCBtc3NwbGxfaHcsIGRhdGEtPm1zc3BsbF9iYXNlKTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJ
CXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIG1zc3Bs
bCBpZDogJWRcbiIsDQo+ICAJCQkJCSAgICAgQ0xLX01TU1BMTCk7DQo+IEBAIC0yNDAsMTAgKzIz
OSw5IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIG1wZnNfY2ZnX2Nsa19yZWNhbGNfcmF0ZShzdHJ1
Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyBwDQo+ICB7DQo+ICAJc3RydWN0IG1wZnNfY2Zn
X2h3X2Nsb2NrICpjZmdfaHcgPSB0b19tcGZzX2NmZ19jbGsoaHcpOw0KPiAgCXN0cnVjdCBtcGZz
X2NmZ19jbG9jayAqY2ZnID0gJmNmZ19ody0+Y2ZnOw0KPiAtCXZvaWQgX19pb21lbSAqYmFzZV9h
ZGRyID0gY2ZnX2h3LT5zeXNfYmFzZTsNCj4gIAl1MzIgdmFsOw0KPiAgDQo+IC0JdmFsID0gcmVh
ZGxfcmVsYXhlZChiYXNlX2FkZHIgKyBjZmdfaHctPnJlZ19vZmZzZXQpID4+IGNmZy0+c2hpZnQ7
DQo+ICsJdmFsID0gcmVhZGxfcmVsYXhlZChjZmctPnJlZykgPj4gY2ZnLT5zaGlmdDsNCj4gIAl2
YWwgJj0gY2xrX2Rpdl9tYXNrKGNmZy0+d2lkdGgpOw0KPiAgDQo+ICAJcmV0dXJuIGRpdmlkZXJf
cmVjYWxjX3JhdGUoaHcsIHByYXRlLCB2YWwsIGNmZy0+dGFibGUsIGNmZy0+ZmxhZ3MsIGNmZy0+
d2lkdGgpOw0KPiBAQCAtMjYxLDcgKzI1OSw2IEBAIHN0YXRpYyBpbnQgbXBmc19jZmdfY2xrX3Nl
dF9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsIHVuc2lnbmVkDQo+
ICB7DQo+ICAJc3RydWN0IG1wZnNfY2ZnX2h3X2Nsb2NrICpjZmdfaHcgPSB0b19tcGZzX2NmZ19j
bGsoaHcpOw0KPiAgCXN0cnVjdCBtcGZzX2NmZ19jbG9jayAqY2ZnID0gJmNmZ19ody0+Y2ZnOw0K
PiAtCXZvaWQgX19pb21lbSAqYmFzZV9hZGRyID0gY2ZnX2h3LT5zeXNfYmFzZTsNCj4gIAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPiAgCXUzMiB2YWw7DQo+ICAJaW50IGRpdmlkZXJfc2V0dGluZzsN
Cj4gQEAgLTI3MiwxMCArMjY5LDEwIEBAIHN0YXRpYyBpbnQgbXBmc19jZmdfY2xrX3NldF9yYXRl
KHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsIHVuc2lnbmVkDQo+ICAJCXJl
dHVybiBkaXZpZGVyX3NldHRpbmc7DQo+ICANCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmbXBmc19j
bGtfbG9jaywgZmxhZ3MpOw0KPiAtCXZhbCA9IHJlYWRsX3JlbGF4ZWQoYmFzZV9hZGRyICsgY2Zn
X2h3LT5yZWdfb2Zmc2V0KTsNCj4gKwl2YWwgPSByZWFkbF9yZWxheGVkKGNmZy0+cmVnKTsNCj4g
IAl2YWwgJj0gfihjbGtfZGl2X21hc2soY2ZnLT53aWR0aCkgPDwgY2ZnX2h3LT5jZmcuc2hpZnQp
Ow0KPiAgCXZhbCB8PSBkaXZpZGVyX3NldHRpbmcgPDwgY2ZnLT5zaGlmdDsNCj4gLQl3cml0ZWxf
cmVsYXhlZCh2YWwsIGJhc2VfYWRkciArIGNmZ19ody0+cmVnX29mZnNldCk7DQo+ICsJd3JpdGVs
X3JlbGF4ZWQodmFsLCBjZmctPnJlZyk7DQo+ICANCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZtcGZzX2Nsa19sb2NrLCBmbGFncyk7DQo+ICANCj4gQEAgLTMxOCw5ICszMTUsOSBAQCBzdGF0
aWMgc3RydWN0IG1wZnNfY2ZnX2h3X2Nsb2NrIG1wZnNfY2ZnX2Nsa3NbXSA9IHsNCj4gIH07DQo+
ICANCj4gIHN0YXRpYyBpbnQgbXBmc19jbGtfcmVnaXN0ZXJfY2ZnKHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IG1wZnNfY2ZnX2h3X2Nsb2NrICpjZmdfaHcsDQo+IC0JCQkJIHZvaWQgX19pb21l
bSAqc3lzX2Jhc2UpDQo+ICsJCQkJIHZvaWQgX19pb21lbSAqYmFzZSkNCj4gIHsNCj4gLQljZmdf
aHctPnN5c19iYXNlID0gc3lzX2Jhc2U7DQo+ICsJY2ZnX2h3LT5jZmcucmVnID0gYmFzZSArIGNm
Z19ody0+cmVnX29mZnNldDsNCj4gIA0KPiAgCXJldHVybiBkZXZtX2Nsa19od19yZWdpc3Rlcihk
ZXYsICZjZmdfaHctPmh3KTsNCj4gIH0NCj4gQEAgLTMyOCwxNCArMzI1LDEzIEBAIHN0YXRpYyBp
bnQgbXBmc19jbGtfcmVnaXN0ZXJfY2ZnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNf
Y2ZnX2h3X2Nsb2NrICpjDQo+ICBzdGF0aWMgaW50IG1wZnNfY2xrX3JlZ2lzdGVyX2NmZ3Moc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19jZmdfaHdfY2xvY2sgKmNmZ19od3MsDQo+ICAJ
CQkJICB1bnNpZ25lZCBpbnQgbnVtX2Nsa3MsIHN0cnVjdCBtcGZzX2Nsb2NrX2RhdGEgKmRhdGEp
DQo+ICB7DQo+IC0Jdm9pZCBfX2lvbWVtICpzeXNfYmFzZSA9IGRhdGEtPmJhc2U7DQo+ICAJdW5z
aWduZWQgaW50IGksIGlkOw0KPiAgCWludCByZXQ7DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBpIDwg
bnVtX2Nsa3M7IGkrKykgew0KPiAgCQlzdHJ1Y3QgbXBmc19jZmdfaHdfY2xvY2sgKmNmZ19odyA9
ICZjZmdfaHdzW2ldOw0KPiAgDQo+IC0JCXJldCA9IG1wZnNfY2xrX3JlZ2lzdGVyX2NmZyhkZXYs
IGNmZ19odywgc3lzX2Jhc2UpOw0KPiArCQlyZXQgPSBtcGZzX2Nsa19yZWdpc3Rlcl9jZmcoZGV2
LCBjZmdfaHcsIGRhdGEtPmJhc2UpOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJcmV0dXJuIGRldl9l
cnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gcmVnaXN0ZXIgY2xvY2sgaWQ6ICVkXG4iLA0K
PiAgCQkJCQkgICAgIGNmZ19ody0+aWQpOw0KPiBAQCAtMzU1LDE1ICszNTEsMTQgQEAgc3RhdGlj
IGludCBtcGZzX3BlcmlwaF9jbGtfZW5hYmxlKHN0cnVjdCBjbGtfaHcgKmh3KQ0KPiAgew0KPiAg
CXN0cnVjdCBtcGZzX3BlcmlwaF9od19jbG9jayAqcGVyaXBoX2h3ID0gdG9fbXBmc19wZXJpcGhf
Y2xrKGh3KTsNCj4gIAlzdHJ1Y3QgbXBmc19wZXJpcGhfY2xvY2sgKnBlcmlwaCA9ICZwZXJpcGhf
aHctPnBlcmlwaDsNCj4gLQl2b2lkIF9faW9tZW0gKmJhc2VfYWRkciA9IHBlcmlwaF9ody0+c3lz
X2Jhc2U7DQo+ICAJdTMyIHJlZywgdmFsOw0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAN
Cj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmbXBmc19jbGtfbG9jaywgZmxhZ3MpOw0KPiAgDQo+IC0J
cmVnID0gcmVhZGxfcmVsYXhlZChiYXNlX2FkZHIgKyBSRUdfU1VCQkxLX0NMT0NLX0NSKTsNCj4g
KwlyZWcgPSByZWFkbF9yZWxheGVkKHBlcmlwaC0+cmVnKTsNCj4gIAl2YWwgPSByZWcgfCAoMXUg
PDwgcGVyaXBoLT5zaGlmdCk7DQo+IC0Jd3JpdGVsX3JlbGF4ZWQodmFsLCBiYXNlX2FkZHIgKyBS
RUdfU1VCQkxLX0NMT0NLX0NSKTsNCj4gKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBlcmlwaC0+cmVn
KTsNCj4gIA0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm1wZnNfY2xrX2xvY2ssIGZsYWdz
KTsNCj4gIA0KPiBAQCAtMzc0LDE1ICszNjksMTQgQEAgc3RhdGljIHZvaWQgbXBmc19wZXJpcGhf
Y2xrX2Rpc2FibGUoc3RydWN0IGNsa19odyAqaHcpDQo+ICB7DQo+ICAJc3RydWN0IG1wZnNfcGVy
aXBoX2h3X2Nsb2NrICpwZXJpcGhfaHcgPSB0b19tcGZzX3BlcmlwaF9jbGsoaHcpOw0KPiAgCXN0
cnVjdCBtcGZzX3BlcmlwaF9jbG9jayAqcGVyaXBoID0gJnBlcmlwaF9ody0+cGVyaXBoOw0KPiAt
CXZvaWQgX19pb21lbSAqYmFzZV9hZGRyID0gcGVyaXBoX2h3LT5zeXNfYmFzZTsNCj4gIAl1MzIg
cmVnLCB2YWw7DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gIA0KPiAgCXNwaW5fbG9ja19p
cnFzYXZlKCZtcGZzX2Nsa19sb2NrLCBmbGFncyk7DQo+ICANCj4gLQlyZWcgPSByZWFkbF9yZWxh
eGVkKGJhc2VfYWRkciArIFJFR19TVUJCTEtfQ0xPQ0tfQ1IpOw0KPiArCXJlZyA9IHJlYWRsX3Jl
bGF4ZWQocGVyaXBoLT5yZWcpOw0KPiAgCXZhbCA9IHJlZyAmIH4oMXUgPDwgcGVyaXBoLT5zaGlm
dCk7DQo+IC0Jd3JpdGVsX3JlbGF4ZWQodmFsLCBiYXNlX2FkZHIgKyBSRUdfU1VCQkxLX0NMT0NL
X0NSKTsNCj4gKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBlcmlwaC0+cmVnKTsNCj4gIA0KPiAgCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJm1wZnNfY2xrX2xvY2ssIGZsYWdzKTsNCj4gIH0NCj4gQEAg
LTM5MSwxMCArMzg1LDkgQEAgc3RhdGljIGludCBtcGZzX3BlcmlwaF9jbGtfaXNfZW5hYmxlZChz
dHJ1Y3QgY2xrX2h3ICpodykNCj4gIHsNCj4gIAlzdHJ1Y3QgbXBmc19wZXJpcGhfaHdfY2xvY2sg
KnBlcmlwaF9odyA9IHRvX21wZnNfcGVyaXBoX2Nsayhodyk7DQo+ICAJc3RydWN0IG1wZnNfcGVy
aXBoX2Nsb2NrICpwZXJpcGggPSAmcGVyaXBoX2h3LT5wZXJpcGg7DQo+IC0Jdm9pZCBfX2lvbWVt
ICpiYXNlX2FkZHIgPSBwZXJpcGhfaHctPnN5c19iYXNlOw0KPiAgCXUzMiByZWc7DQo+ICANCj4g
LQlyZWcgPSByZWFkbF9yZWxheGVkKGJhc2VfYWRkciArIFJFR19TVUJCTEtfQ0xPQ0tfQ1IpOw0K
PiArCXJlZyA9IHJlYWRsX3JlbGF4ZWQocGVyaXBoLT5yZWcpOw0KPiAgCWlmIChyZWcgJiAoMXUg
PDwgcGVyaXBoLT5zaGlmdCkpDQo+ICAJCXJldHVybiAxOw0KPiAgDQo+IEBAIC00NjIsOSArNDU1
LDkgQEAgc3RhdGljIHN0cnVjdCBtcGZzX3BlcmlwaF9od19jbG9jayBtcGZzX3BlcmlwaF9jbGtz
W10gPSB7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgaW50IG1wZnNfY2xrX3JlZ2lzdGVyX3Blcmlw
aChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtcGZzX3BlcmlwaF9od19jbG9jayAqcGVyaXBo
X2h3LA0KPiAtCQkJCSAgICB2b2lkIF9faW9tZW0gKnN5c19iYXNlKQ0KPiArCQkJCSAgICB2b2lk
IF9faW9tZW0gKmJhc2UpDQo+ICB7DQo+IC0JcGVyaXBoX2h3LT5zeXNfYmFzZSA9IHN5c19iYXNl
Ow0KPiArCXBlcmlwaF9ody0+cGVyaXBoLnJlZyA9IGJhc2UgKyBSRUdfU1VCQkxLX0NMT0NLX0NS
Ow0KPiAgDQo+ICAJcmV0dXJuIGRldm1fY2xrX2h3X3JlZ2lzdGVyKGRldiwgJnBlcmlwaF9ody0+
aHcpOw0KPiAgfQ0KPiBAQCAtNDcyLDE0ICs0NjUsMTMgQEAgc3RhdGljIGludCBtcGZzX2Nsa19y
ZWdpc3Rlcl9wZXJpcGgoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19wZXJpcGhfaHdf
Y2wNCj4gIHN0YXRpYyBpbnQgbXBmc19jbGtfcmVnaXN0ZXJfcGVyaXBocyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBtcGZzX3BlcmlwaF9od19jbG9jayAqcGVyaXBoX2h3cywNCj4gIAkJCQkg
ICAgIGludCBudW1fY2xrcywgc3RydWN0IG1wZnNfY2xvY2tfZGF0YSAqZGF0YSkNCj4gIHsNCj4g
LQl2b2lkIF9faW9tZW0gKnN5c19iYXNlID0gZGF0YS0+YmFzZTsNCj4gIAl1bnNpZ25lZCBpbnQg
aSwgaWQ7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBudW1fY2xrczsg
aSsrKSB7DQo+ICAJCXN0cnVjdCBtcGZzX3BlcmlwaF9od19jbG9jayAqcGVyaXBoX2h3ID0gJnBl
cmlwaF9od3NbaV07DQo+ICANCj4gLQkJcmV0ID0gbXBmc19jbGtfcmVnaXN0ZXJfcGVyaXBoKGRl
diwgcGVyaXBoX2h3LCBzeXNfYmFzZSk7DQo+ICsJCXJldCA9IG1wZnNfY2xrX3JlZ2lzdGVyX3Bl
cmlwaChkZXYsIHBlcmlwaF9odywgZGF0YS0+YmFzZSk7DQo+ICAJCWlmIChyZXQpDQo+ICAJCQly
ZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byByZWdpc3RlciBjbG9jayBp
ZDogJWRcbiIsDQo+ICAJCQkJCSAgICAgcGVyaXBoX2h3LT5pZCk7DQoNCg==
