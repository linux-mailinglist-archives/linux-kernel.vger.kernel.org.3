Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915055A1028
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbiHYMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiHYMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:16:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A77AD986;
        Thu, 25 Aug 2022 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661429808; x=1692965808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O8h+GT4E+zHG1oIag4w7dEXAPtGeK1Abyd6dATPI75I=;
  b=ouXYWLtofpc/J4mGYcokkToBSEuEMGdjl0FA7rlS8rNZLrOugqaki6QM
   4ZWL04cbcVOkNX6CEb3B78Or77CZ+tdqs8gm4Jpg0RQVg1c9KZl6GwdDH
   5OTTGW05aqs6weg5kPf5pIbKEPD+jsJ8+2bDwcn6WSxn4iKNVrDP74v7T
   7oQcrV8UC3bxVEmzLNQoi0e46KFhADXzr6pOPhjt3vV50peWbsdZOk3hd
   sL0sZVOqHRD3BKCj6D71kXOW1iGM6gMd07yEpujV0T6PLK+t0/mxueBuS
   qydBv7jy76Y2LDoFN2MCvwnOrQMrYAW0JUhfen2F1K1OMXaNnKZgDCbRk
   g==;
X-IronPort-AV: E=Sophos;i="5.93,263,1654531200"; 
   d="scan'208";a="208086521"
Received: from mail-bn1nam07lp2043.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.43])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 20:16:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpdNS4l+kz0Yf7eJbdt39ghacbPRvwZGads9VH6Y24FsrUAzHmxcizCYQ1+1WEwuZy295XAFQIQeaq9ziuioe/TG9FCKx5nwXa6hZxwWqFT/EUh0M6XJ2a60MCP7B5WbFR26W8SowCu5wna73jpnqpSAuTpkcp7PQhYxPiopZc7KwDe6oGd3ydCuLPMxengcX2uQc95ozDUE8vrm3k6kC6xrM4lWQF1rgHzSHDPi0Z19Nk4St7Uc9pFZXd0zsIw9tSaxrJ9Qc3IZIYuPHLRLADaFQYIVtsHUr5AGrTGPY6DF05WrF4vcnUccGsRpwWkRM3feBnQvzlQ+6UT9NV+QCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8h+GT4E+zHG1oIag4w7dEXAPtGeK1Abyd6dATPI75I=;
 b=OsrnHGIEWU/kYDgHNcStRT2pK0+gzGPxUbWWABbADsEH38aJeSP7eeFLxb3qMNGbI2hxfeNCw3xCPMm9Jepy1MutoFYbfewWql/9OMhOHS3n/AXbsoBI6VjR/p/TDpr8zIXWgQpIXXPwTTTjBoFe92l7x2WtoM5z3vJ71td7L9lrJHxUr4uKboGiaXNXohYDhwQVEhvdq1Ac+jXm8W6tpDsLss4EhiZi2tEAZYdMmxe55qBuVzXtmfk98GOh3K6sz9E11JFQ7xkvEQ4eeMDx74roNIsa/sNA4OzoCKn7h/IyJQN+ecucfmdhMe+9vrTtj5O01dB4mbB7l+0AlNixAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8h+GT4E+zHG1oIag4w7dEXAPtGeK1Abyd6dATPI75I=;
 b=aVwtrm0oYWH6IJytPCx/WitTSa/Atw4PkfNbEk5NTpnLMT0rTwDpX0VmgyfHOPkuPzPC8YWPnOvnG9/3NGHxwmlsncvMQGzcLK2lUMcgqIlZta1cV3r4WO0C8/MSG5bt1bqMJzH9CLgpr3ddJhb2ysvsl0yv7CIu8L9UE5eNqhc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN6PR04MB0308.namprd04.prod.outlook.com (2603:10b6:404:17::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.19; Thu, 25 Aug 2022 12:16:44 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::eca7:e175:b67:5002]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::eca7:e175:b67:5002%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:16:43 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?5p2O5L2z6ZOt?= <lijiaming3@xiaomi.com>,
        Jiaming Li <lijiamingsofine@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External Mail]RE: [PATCH] scsi: ufs: ufsfbo: Introduce File
 Based Optimization feature
Thread-Topic: [External Mail]RE: [PATCH] scsi: ufs: ufsfbo: Introduce File
 Based Optimization feature
Thread-Index: AQHYt5Yd7MdiBMU/V0WwXjppS39zs62/UTVAgAAxe1CAAAWoMA==
Date:   Thu, 25 Aug 2022 12:16:43 +0000
Message-ID: <DM6PR04MB6575E82370969004852323A1FC729@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
 <DM6PR04MB657511C55B06E40552C03378FC729@DM6PR04MB6575.namprd04.prod.outlook.com>
 <8500789bbd0b4a5b8452ee15d8530a32@xiaomi.com>
In-Reply-To: <8500789bbd0b4a5b8452ee15d8530a32@xiaomi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea039d36-cd81-44da-33a9-08da8693ac88
x-ms-traffictypediagnostic: BN6PR04MB0308:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc3l7zoQiq3tYG6Rd1ZpQg9kFEIgfcxCnEr0A47ieGsPSwlcnGrvd7LieLFBgiftAjcaGH6C4YnfD0/qEdM1WePX+XVziKBBoYTuCAvbkZOy7wjnBk0PvuPp1VL3gnf2MRlLsjx9NlHScm7aEQAKpbyMsW7zeJP5eXLxpgoy0Ofb411V3bnjTqC92yMWFGmFwvOhOWssW+cyI9NAon0YXUL4sOk+4ZUQRLyEIRlw/kmcy0KPQmiofltZZ4p3PjkS9oIm1DqYIJtq1/Hh/yJTsT2iik2fMvDVfxPJAbE2+cfrtxhxwnI11+PB3T3IrnpUDmoBe2X+npslnBxoYsxXIO2rW0c1k3J0fICcC9bV1SPvZmww8K/Zw3ZXUHLluWoWyW8IyYNwa6vFFLBBDPpi5UvFx5jS6H9ABGSLANCxcTkkbZEcXbzm/MxwZrZSizg6O89UAy3rq9RiFY/4ReaJ4DxxVRiqWXbk9SAoYOSJLG81QwhVVroge18yfoYV8kNDVIGXrMF1ttEg5VCyYIsJbkLAizhE6DkLGN2TnxGmjKdQhkCpXPY8dtQG3L1XqHsk90uRaOjSWoANBhyY3O14jaHMahvy688rVWdZq4zJ30+M9EFOt4Jb+tVam+AHFHbgCwupqac/5YXMsMCFCAc4fXc9nHu/wYi+tQoidPEikbo9M8QSEk+ft7SBoilBC0/2x4o/kVUZwaSVx+B+jMVED44ddFMq/4tZZ+yq8IEvMAoYb73sqbSAxQzwECMm2rXoqqDQQ6wJ66qJ8bNRi/R9TXm9JCP1o51OmSNAFPSGQgg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(7696005)(478600001)(6506007)(82960400001)(38070700005)(33656002)(86362001)(9686003)(41300700001)(71200400001)(83380400001)(966005)(186003)(26005)(122000001)(8936002)(64756008)(66946007)(66446008)(316002)(66556008)(76116006)(55016003)(54906003)(4326008)(52536014)(110136005)(38100700002)(5660300002)(8676002)(4744005)(2906002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnZJbGpZeTVoL0dhY1JaMFN1T0hkeVZGS1JKa3VXOG52dFprNWtEclpmRFFY?=
 =?utf-8?B?UERyMUtoeWJXOG13N1A2bGVSRVBNVk1zOW42VGFqSmxjUGg4dTdjK2IxNWNs?=
 =?utf-8?B?WmtJYmN3ZGFZVGdDNkNWTmwrQVVOQmc5bXdpUXhGa3NGYzBRaUJDYlF1VHVp?=
 =?utf-8?B?czlLT2JBbUZzN2hpSXh2MHIrTnc2TzJhRmdSb0JNTmtxRUQ3TlVJT0JocG54?=
 =?utf-8?B?Y1luQnpITDNFNUp3U0RQVXZncCtuK2JVRE9OWU1uSStvWmNFektpT1pLeW9M?=
 =?utf-8?B?aVN4clhyOVlKRW5XZXBBMnRTREZ2djVQcjdGckhZTmtnanc3ejBmR3hvNVBn?=
 =?utf-8?B?Y3lzMmcrd0lnUEVXNS9udHVvZm1wRDhGV21YOEUrS2xlV1VRbDNMOE5pYWZS?=
 =?utf-8?B?UmZaUmx6K3dDcnpUb01teHAvV1FvaTFQV0Zaclk3Sk1xVGF1b1VScTJubkhS?=
 =?utf-8?B?UXBUTWxEUUNhYVNueE1nVUV1aVdwclRNNzdwNlJ5YkhaOHk1L0U0TzlGVTF3?=
 =?utf-8?B?QmxVRmhENy9yTXE5a2FnaEZkZzV6bFJ2YkNGNmtlcm13NGlIRWs4WDdmVnBZ?=
 =?utf-8?B?WUloRWNhSEp1R1RpYkhmK01UR1crVk1wdHIveVRDM2EwMDg5M3hydzJOWGU2?=
 =?utf-8?B?YktWTUIwM0FWSUxySnBtZzJZZzREV3p0a0JhWlpSeDBpQ1V6MmNLN3JyQ1dZ?=
 =?utf-8?B?V0srZFEzc2E1ZTg4b3AwQUpZaWJVUXkzRXN4bHJWQTVTcmpQZ0s0aUVWQWt6?=
 =?utf-8?B?S3UrdG56S0pOYjNQZlprMnZ3a2JpcTJOcGJiSVR0M3RKd3U1eDZGR2MxM2Mv?=
 =?utf-8?B?U3YvVXQ1UFpiY2o0dVViaTQ0Y0hwaTJ0ck10Y2tqMlAwSHJacW9KOWtGNFlT?=
 =?utf-8?B?djBvcmNYTWdGRk1YOEh4NUVmNnF2cW84V1ZxUE9hL3k5R25EeUcxSllOU1Ny?=
 =?utf-8?B?b01XOEhsclV2TjdxRDRQTWxWcTZUcVBiSGlZVll2eUw2YUplM05vQlNzaE5W?=
 =?utf-8?B?SnVLeEFkSm5lWjF1bFhjVWJHSWdJaEhHeUNqQTNnMU1uU2kxNWZ4emdFbVdF?=
 =?utf-8?B?ZXpMcUZIODNPaU5GVHBoNkwwUFh6WWQyYjgzOTJBZnlaSE9NK0ZKZTgvZTRL?=
 =?utf-8?B?ZTFQbk5hUXNJcmkwRjAvbVVPbEIwT0dONm15NUt2aGpobTJkb0RQdUF2aG1l?=
 =?utf-8?B?ckxrL2tOTXlvMXVVUnQxcFVlUDhXTkJPbVhqT2wvYjA5NGZTY3k5cEkraXZL?=
 =?utf-8?B?bVcrUy95eGhoNExUWkNycGIvVkthcUpxZzZUWmIyakFqb25XMWs0WlpyMWg3?=
 =?utf-8?B?V0paeVlCQ0p2YUx4RVJDOEFXRWpacnl6YWNQRW5wWUZYN3ZKM3ltU1VwcGYr?=
 =?utf-8?B?VGtOUmJJRll0aVdZT0FnNFR1UFo0eUJSYktISitoK295c082OEZJdzhrNHpx?=
 =?utf-8?B?RlI3ZlE5eDFKaDlpTEg1R2gxc080SDkwUEpsV1FrQlZDRnY2TndjUFdjMjBj?=
 =?utf-8?B?SzExRGN1TEZ2UVVINFVnUFI1VWZzbUlKQ1ZGTFhJL2doeS9lc1ZoUklBWnNq?=
 =?utf-8?B?NlB3NGYwWWY0RlZ0eDBWRkQ5WTlBWG1oc2dacDRIL0tLb2FvTXlJVjBCMStS?=
 =?utf-8?B?N2NEcjNESWJ6Mk5TV0xrWjkrMEdiQUN6eERkY25QQUdjTjkzY3d6SjNoTDhn?=
 =?utf-8?B?ajh2MXhGNm80YWM3OU1aYlBaN0MyN05UWi8vMXNJK0NSZUMwb2c5bGl0aUd0?=
 =?utf-8?B?R1kyMWhJdlUvNTNDK3Z0Rm4ycUFLbnZLNmd3STJWVmlSbFdseW5FeHNacFdR?=
 =?utf-8?B?dEl5ajE0UmErWlc5MkNMN0EwTm51eG43YStKL3FpeTVQOUtVZGdaV2tLNmo2?=
 =?utf-8?B?OUZZRm8wTk5HRWNnMGxXN2ZJM2xLNlFjUWtrUG11L3BnRHUrMzNrK2Fkc3JM?=
 =?utf-8?B?K1pWa2ZodzZtUy9JdEpGbDhZRTMyZmFKNEEzQzBBUEtpVUFlS0QxMG5xbHQw?=
 =?utf-8?B?WWVBTUZ2WlhTQ0creGdES3hWL3lkK1NkM0FkRmtDaEtsaTBwcU1xV24rcVhG?=
 =?utf-8?B?TGpkZDRMZXFva0xoUHpxTjJQY2cycjRZYWpZOWpuMVVtS25ZWmhRMzdRKzlB?=
 =?utf-8?Q?IJI4piPAvyTYls4Ed2Li0xFiw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea039d36-cd81-44da-33a9-08da8693ac88
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:16:43.9112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiaIdS8sbtp2NRNTvp1LUSmUcOoqmiqDhcWYAvLn3ODhmfhQtg0PlEU8DAIIvfBte1c0yopMbMjeHUFV1i5W8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0308
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBEZWFyIEF2cmkNCj4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4gSSB3aWxsIG1vZGlmeSBpdCBh
Y2NvcmRpbmcgdG8geW91ciBzdWdnZXN0aW9uLg0KPiBBZnRlciB0aGUgbW9kaWZpY2F0aW9uLCBJ
IHdpbGwgdHJ5IHRvIHN1Ym1pdCBpdCB0byBNYWlubGluZS4gVGhlcmVmb3JlLCB0aGlzIHBhdGNo
DQo+IGNhbiBiZSBpZ25vcmVkLCBIb3cgZG8gSSBkZWxldGUgaXQgb246DQo+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1zY3NpL2xpc3QvID8NCllvdSBjYW4ndC4g
SnVzdCBzZW5kIGEgdjIuDQpUaGF0J3MgZmluZSAtIGl0cyBvayBmb3IgdmVyc2lvbnMgdG8gc2ln
bmlmaWNhbnRseSBjaGFuZ2UuDQpKdXN0IHJlbWVtYmVyIHRvIGRvY3VtZW50IHRoZSBjaGFuZ2Vz
IGluIHlvdXIgY292ZXIgbGV0dGVyIGNvbW1pdCBsb2cuICBFLmcuIDoNClYxLT52MjoNCiAgIDxh
IHNob3J0IGRlc2NyaXB0aW9uIG9mIHdoYXQgaGFzIGNoYW5nZWQuLi4uPg0KDQpUaGFua3MsDQpB
dnJpDQo=
