Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2138F594568
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 01:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351286AbiHOWls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350767AbiHOWhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:37:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD3F12F72D;
        Mon, 15 Aug 2022 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660593033; x=1692129033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DwWO2VSUSb1FH96MNTNsseTgiSnrDkvaB/r6HvnPJf4=;
  b=Vtb7DbJgYAB/eonjEvbJSX9XDAfIxSo0DmIzxukFqyUv7ZVXamXG4HYt
   9K65ZvGRmrkXhgjRvycnFivh4W2wyCFGzBZviGHdTlgyse141r/t7oXFQ
   XKlbOGTGfT1mBKFmBPyh/VrPi5Lh9QGRBXDPdzgdgOmaGGtxpCA4xa584
   arnAmqvDfTjAQ/HYZOwj9/SMB0vW0fWAY/u47Kex29NdewCXpmnCv5a7G
   2IDjGFU54DuvoQnAIUNZrQs2KSSz634olQwvBzqa6CmdnbWmtqZzimB4d
   EiXCbQPqxrMJDNnsdEIXZVAGlGJblPIDPNO2+8PO1odkXBj62hQlnACfy
   g==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="176328255"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 12:49:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 12:49:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 12:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BerCerAtRTcNDAwxgl2KFPTtrzMyEEPcrr5mb9gUe8SYyhn6FMLfVP95DF109xmgOQPV/Ck0NQhzQdQ4xLyzrP3zdET/qMeCYx4vDADssNW9I0Szfd0cz5n8mZ88HLMj53Z1g4Try8CJ+VII8PxVnQO0s5FhNx02//dRrfHMaxP90qYCEp/6ja00RYK7rklT0dKxQDs8iWVgf5bQtRSVJofqRcMPspI/TTHza4v+IC04C+sV0xllTnb8WYD4CIImEoqdx1xE1EtN5895iHYCeZd4FBEZikTsVqCO/D962CHLarDmQuuf542a6+Wz1dM6/bsXT6MttXhUfjy4ryYbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwWO2VSUSb1FH96MNTNsseTgiSnrDkvaB/r6HvnPJf4=;
 b=lreyxzDsW2DCeHdx9Ry0Bx5Vuk9wjhdZqCEldLNWL5Jt+8AfQQssWQPv8FbAr08mqMZ8UfKx+4VerpmuPGcH82rc91fR9HI6IaHewTz34DTwmg/FSGbgkWiXLa5pNgsFS1c67RT+vgNPmSKTAmu+Mvzt/TffnLXKE3Qjjoq1wxXvDbTbRBBOtR5cvAtS2H0GxGgxjsWdwSlxTS0tfk+r6j+BHq1k5qoqSdqWynuEudn3mm8iWq9fptaGIH+nBKmp78n44saY/ZkqD6ef6U04stR2+7VHQF8/Dt+iswS2PrTmqfzMaUbLTwYiCiHA7CyJ24mF4JyDuUxPq4wRf9GjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwWO2VSUSb1FH96MNTNsseTgiSnrDkvaB/r6HvnPJf4=;
 b=AvS+paJUn1TbXPk6z3Gr9CJFJErA0vrGfy9FZq3Y0dwEDE5Dql1XSduKr/ESQjNd4B3N8rPsI5PUuHPZeLMByGWbkPm/GwGzyMX+5ohespHw2EFQiTN+mEhcqEb++N7HV29eAdov06jGSbF0Rmsb1tst4plbkFHQOkrw0+nE+JA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 19:49:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 19:49:06 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>, <Conor.Dooley@microchip.com>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>, <anup@brainfault.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 8/8] RISC-V: configs: defconfig: Enable Renesas RZ/Five
 SoC
Thread-Topic: [PATCH v2 8/8] RISC-V: configs: defconfig: Enable Renesas
 RZ/Five SoC
Thread-Index: AQHYsLoNIrzcJ1b/ykeOQ3jLymgw4q2wTvmAgAAOjYCAAAEtAA==
Date:   Mon, 15 Aug 2022 19:49:06 +0000
Message-ID: <c7889bcb-c765-a30c-6d93-c6c1ac0152e3@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ca555430-055c-debb-fdb4-fa7f78129780@microchip.com>
 <CA+V-a8s=RoZmMvDqnBpYZTR2uotv6srumeoRn2=828zhAbOQZA@mail.gmail.com>
In-Reply-To: <CA+V-a8s=RoZmMvDqnBpYZTR2uotv6srumeoRn2=828zhAbOQZA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c295472-07b6-4959-e1b3-08da7ef736bb
x-ms-traffictypediagnostic: MN2PR11MB4759:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xRu2E50+2AS1l4CXlfExsMhNqVwdOmBVVky5LfHi/1xXM4ZGQr9F3pOUH/ZVqbPkFouX4CD9QaDIO4xLf2WjV+WBU5cYk4MySATZxCYn+wv03jM8XxfDl5YjFvp/tFZz1ob1yscqheUW87cYr/KZcOPJaYcgHZovKjtmJkOhubGGlv5prwVa1/M1RKuKvhcCbTZh6TJ50aGTMLyzaXPUR4b8rCoWOTS78PBBiTH4sMciMGarkjG3cONaXT1HN/gADYbMUzGQ0M9Qgc0EgvsyTaEDn24sZWqWbsl04JxfO3UcCA0LONGh9C/4MF+nKMHiQrYgoNliokol3357e2apgqw41+yAky+7/du5t5Q4Ztaf933q2IJAK4N+CValOkoHlx+R+sMS1bJ+Eq8TdUduobMzTg61yYZfJ2bUAzMYtNE8aCyqrc+/F5jI9n4Ac1CFA6SNgKrx8SAUUirwMnV7TcEgLKwQr08yLAdAqQY+OSKCPybg0T0IhCDcdnaCHX4p5Dgle4UcXYk2fRiMBCG44ZFEGntwUQVaV+WhFaheJJ2J9vV4FIHrmrArAnRt1JBHnY8EYH+8K6DGoBmfviCXvckYjsqVXtyWF9LQ4UKciV//VTjvOKuzLApMu2y57G4k46PUJgY3+uJR+tSMsFuDspR9nWoDnCg6nB2v2QaspdJ1dnPcSqy/671B+Emzhs5GNIIoFzYMBI2pEwr6LCJ7r/y9IWZMPnPEgrubEFr7rwHWFbH7Zih9orUZrKZc9XwRKwXuzubEMn85CVV/jV7J33RsyNWhnMz8i1qo+gHtBds42ZP9VOfIEgeQfsrPbYiHqQKNsma/LW/0tyXcyB2v0mY343zP38uXzqBB123sr0TH/Hbe+TGb2hJ0/ev/Q9a5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(136003)(39860400002)(83380400001)(2616005)(186003)(6486002)(71200400001)(478600001)(38100700002)(316002)(91956017)(41300700001)(66556008)(7416002)(76116006)(5660300002)(38070700005)(54906003)(31686004)(2906002)(122000001)(66446008)(66946007)(8936002)(26005)(4326008)(66476007)(64756008)(110136005)(31696002)(8676002)(53546011)(6512007)(36756003)(86362001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzNCZWwzU2ZQbEtWVXlFcFhmTEt4ZGRMc2tQS3V0ZW9tZXZoNERKdGcyc25y?=
 =?utf-8?B?RWhkd3VQQXA4cCtlOWdZR1U1aWNRWldxM3VmZlRZZ0duaitjSVBrdDV4WUJS?=
 =?utf-8?B?OTBIVXBlL2ZMUEdqK3RFS3IzQ0hUWGJZWEVSNzVYVloyQklVS3RGYWg3NndB?=
 =?utf-8?B?K2J2YWNRdlYva0wxUnAzQkdLeTFzVnpnN1RZM21NbGZiRmhHSjhISWRKUk9r?=
 =?utf-8?B?d3Y4cEdiWEFVSmpYdlhUV2NQMjZIWnJyTTBRM1kxbXFSWlU3aHRxbGpnQlB4?=
 =?utf-8?B?L1NnajgwZ1paOWx6N3ZhVGVJZ2kvSUhDcDh6UmZ5R2dEVEt4aFFvcWtNNVJH?=
 =?utf-8?B?cjZuM01CR0h0dm50MGt3Y1NYdHR2ODNVZ1JSUUFldWpwV3FQWnp4VzVZNG1K?=
 =?utf-8?B?NURXci9mQWNiSXhMV24xb3JKRk9JTWw0ZEsraFhOaWlLUXhpMHc1MHBZblZC?=
 =?utf-8?B?MkFVN1d4RGt4N09VZFRkcStJS2NiSWkrdlczR09QU2xHWEFNdEgwNEx1MHBL?=
 =?utf-8?B?ZmMxUDhKTkIwbHdwc2t1eFBJdU9KR21TWDA5eFZvdUtwSStONVNkZ1UwM25F?=
 =?utf-8?B?Q2tHSkFjWVVrMVpURlVpb2dkNGJkT2ZCQU1CL1BKYk11OE9aZUt2WnpQbkF0?=
 =?utf-8?B?blB3WHZGT3AxZzdwbDBKeTFXSi9EdWlCb1Q1TmZmQ2dxT2pxcEM5bWswd1Nr?=
 =?utf-8?B?Vmh5VGNSNytRTndBYVMwZnZidS9Ed1NrbUFCYmlMbVFyanBYV2FYSmtQbU1H?=
 =?utf-8?B?RUZwQzdKYmVoaXVPYS9sU01oU1RpL0QwN0plMnVrdUI1eHYxUkRtMHYzZFg4?=
 =?utf-8?B?MkcxVlR5ZXNzT3RUQ0RnN0QyTEpaK0NOOTBxRVdhN0swZHM1bkFLdm1UTlJL?=
 =?utf-8?B?ZG9Ld3VSeU1sdlNZcHBjTngyNjdEUjhnZTZ2Y3cwTHJCWFQxcnBxc2VBcjZI?=
 =?utf-8?B?TzFaa0VaQURKVE84TTFBbURMR3NmQ1Q1U01QYUc5TFZQM2xsU0FVY3JENEdi?=
 =?utf-8?B?aWhubExZa1lvZXluY3hlMmVVQ1hjRjArTVEwL09nekYrMG5JaFhjbWJCRWZ0?=
 =?utf-8?B?QTFoc25YOXNqczdRZWcrVUdOY3lVSTJ6QXhiNi9GRkMvTEc0UTcxbS9LL2NQ?=
 =?utf-8?B?Zk93YVBkcDVGM1g2Tzc5OThxSldzZVpMdFBMWml4NjBGTWtuWWxTekhGZVlW?=
 =?utf-8?B?aUtUMXpPN2J4a1AvYm96ZXF1aEx2elMvbmxES1pNM3A2bjgvMlRBY0JpRUpX?=
 =?utf-8?B?WHUwMkltY3RkNlBsMWdmb1l1WWNRUll3NjBtWnVOWU5HREhTM1FlYzlGQXd3?=
 =?utf-8?B?eU1NZ0d4VXVrRk80R292dkdMVE1BVGZDaEZYRUxFMW5ORHY0Q0phcDlCamV0?=
 =?utf-8?B?a3dKTHRtcjd1UGdXcjEzNTE5ZUtVWjBUKzNweEp4Vy9QUXorM3VoTDlsSURV?=
 =?utf-8?B?Z1Y0TDVmOVFnMys4Vy9GZGZ3WnFWNWw2bHZlVnBMN0ZxVjdGUUhxb3dxK01V?=
 =?utf-8?B?ZHNhcFMzNlJ6cGJDOVlXTXpHZjVjaGhyM3NMNFRDT0kvWHEzbHBWa2grZGwr?=
 =?utf-8?B?N2w1R0FKek1aak15M1BvVXczanVURjBLclNRc1diNFlicG55Y3cxbnRXenBr?=
 =?utf-8?B?RWhxU29oa3pGSlJoekRtNzlxNW1uUnhOSUJpeXl5RzhDOXZvRzhWQkpQelBi?=
 =?utf-8?B?VDM0cDJ2OFpGNjN2Z3hjTW1MTUFrQzY0RWRrOXJFQ2FoWmxYaXdIblhHYVBz?=
 =?utf-8?B?dFpWeWM5QVBKVWNkTTl0aDdFSFBkODVuMjQ1bkk5MkhmTHQzUWFzVVZFeFhj?=
 =?utf-8?B?YlBVY09IRjJXcW93QlFzSTg3OGJaek1PdytJY1k1OWkwdklyajNWWE5rZjR2?=
 =?utf-8?B?b3ViaVVSOU9YM3BOWEorcGJtMXFMbmJtdC9KWk8yaGJkVHVrYy90WSs1disz?=
 =?utf-8?B?TEgzNTR6QVFZa1dxWU96N2c0am5qS0tNV0M5bFdhVHJOYTBHbEIyN0l0c3dt?=
 =?utf-8?B?dVkvM0NaWEVWNkRvZjZBRm1ieXJEUU9PeGFnZGpTNnIxTVVwNTg3aURUdWRz?=
 =?utf-8?B?QzBlL3h0QkpGckY4VU9DRzhocjhoZHh2QXIrcGdDQXg4QktKVzVzNHNDZkFs?=
 =?utf-8?Q?jgZFor8XicPK7HyrOQZ8W2YE+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <413DDB1BFB0D9E4BA58B03DD1BA2178A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c295472-07b6-4959-e1b3-08da7ef736bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 19:49:06.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5i8JT09CCOMFDl2XTL59A+1fgnpl7BxAapoJDVJNfW1Seqlgkug9Otunu3DYGEafnJ3D+x1GAOfEwRnK9OimEhHfCz3Fa/LE/5hdhurYbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDgvMjAyMiAyMDo0NCwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+IEhpIENvbm9yLA0K
PiANCj4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KPiANCj4gT24gTW9uLCBBdWcgMTUsIDIw
MjIgYXQgNzo1MiBQTSA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4NCj4+
IE9uIDE1LzA4LzIwMjIgMTY6MTQsIExhZCBQcmFiaGFrYXIgd3JvdGU6DQo+Pj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBFbmFibGUgUmVuZXNhcyBSWi9GaXZl
IFNvQyBjb25maWcgaW4gZGVmY29uZmlnLiBJdCBhbGxvd3MgdGhlIGRlZmF1bHQNCj4+PiB1cHN0
cmVhbSBrZXJuZWwgdG8gYm9vdCBvbiBSWi9GaXZlIFNNQVJDIEVWSyBib2FyZC4NCj4+Pg0KPj4+
IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBi
cC5yZW5lc2FzLmNvbT4NCj4+PiAtLS0NCj4+PiB2MS0+djINCj4+PiAqIE5ldyBwYXRjaA0KPj4+
IC0tLQ0KPj4+ICBhcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnIHwgMiArKw0KPj4+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9y
aXNjdi9jb25maWdzL2RlZmNvbmZpZyBiL2FyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcNCj4+
PiBpbmRleCBhZWQzMzJhOWQ0ZWEuLmRlMGNjZjgxNmMwOCAxMDA2NDQNCj4+PiAtLS0gYS9hcmNo
L3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnDQo+Pj4gKysrIGIvYXJjaC9yaXNjdi9jb25maWdzL2Rl
ZmNvbmZpZw0KPj4+IEBAIC0yNiw2ICsyNiw3IEBAIENPTkZJR19FWFBFUlQ9eQ0KPj4+ICAjIENP
TkZJR19TWVNGU19TWVNDQUxMIGlzIG5vdCBzZXQNCj4+PiAgQ09ORklHX1BST0ZJTElORz15DQo+
Pj4gIENPTkZJR19TT0NfTUlDUk9DSElQX1BPTEFSRklSRT15DQo+Pj4gK0NPTkZJR19TT0NfUkVO
RVNBU19SWkZJVkU9eQ0KPj4+ICBDT05GSUdfU09DX1NJRklWRT15DQo+Pj4gIENPTkZJR19TT0Nf
U1RBUkZJVkU9eQ0KPj4+ICBDT05GSUdfU09DX1ZJUlQ9eQ0KPj4+IEBAIC0xMjMsNiArMTI0LDcg
QEAgQ09ORklHX0lOUFVUX01PVVNFREVWPXkNCj4+PiAgQ09ORklHX1NFUklBTF84MjUwPXkNCj4+
PiAgQ09ORklHX1NFUklBTF84MjUwX0NPTlNPTEU9eQ0KPj4+ICBDT05GSUdfU0VSSUFMX09GX1BM
QVRGT1JNPXkNCj4+PiArQ09ORklHX1NFUklBTF9TSF9TQ0k9eQ0KPj4NCj4+IFdoYXQncyB0aGlz
PyBUaGUgcGF0Y2ggdGV4dCBtYWtlcyB0aGlzIGxvb2sgbGlrZSBhbiBhY2NpZGVudGFsDQo+PiBp
bmNsdXNpb24sIGJ1dCBJIGZpZ3VyZSBpdCBpcyByZXF1aXJlZCBmb3IgYm9vdD8NCj4gVGhpcyBl
bmFibGVzIHRoZSBzZXJpYWwgZHJpdmVyIHVzZWQgYnkgdGhlIFJaL0ZpdmUgU29DLiBTSW5jZSB0
aGUNCj4gaW50ZW50aW9uIHdhcyB0byBoYXZlIGEgYm9vdGFibGUgYm9hcmQgd2l0aCBkZWZhdWx0
IGRlZmNvbmZpZy4gSSdsbA0KPiB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpTR1RNLCBm
ZWVsIGZyZWUgdG8gYWRkDQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlA
bWljcm9jaGlwLmNvbT4NCndoZW4geW91IHNlbmQgeW91ciBuZXh0IHZlcnNpb24gaWYgeW91IGxp
a2UuDQoNCkNvbm9yLg0K
