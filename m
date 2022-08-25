Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62E75A1080
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiHYMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiHYMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:30:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737E76768;
        Thu, 25 Aug 2022 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661430643; x=1692966643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9o1jOYSVdGeocBFITx9yjGuJdoH4mezrM+akeksBjJI=;
  b=PoFAVzAwZipRS4mG+xObaYqNmMKvnh2ryq5Pxfyh3AqLzk2F+M66opHD
   nC8P8Q6Jro5UHq3ZuQGvTpyQu1jzOxnXmnrACZ+HcTbJM2pCpGataaV6f
   JUQdprBRSEiDbicdPvGrEMJCpOX196fqpreqZrqCHB/GM5O5tlIcERSp3
   XvVY4HQ9l7mMCFxejWjiubhcifdj/6P3dqqFye1DXrGDwlsuKVDAzpyY9
   qcwXzM8W8WDv5fJ0d5ajl/PE92JpEOQi3S09qK0bfl7+r3g+RgPlKN9pk
   j1J2KOgGYJ2LOu19hM4PoQjcEhwlXhVgVfwCq/vZzSlMD1y8EIk6dzPef
   w==;
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="177708302"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2022 05:30:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 25 Aug 2022 05:30:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 25 Aug 2022 05:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+z7mPmbOeFlTFPb9px5mdf/hCsq4kg5cHUcZIISHNik02XVw2Zojn80/s38CibvM1HVVhbacMcq7Lewyw4s/zNN1VzCyjQeqkhj3EWBQbEElU1ZeHn1F3thfbMBtUjw08woV23qHi3OHBUOy2KL4FEDN672SHEJWaMP/CMvXQW9okhS/vbqoq9o/3cFc1h07RcMe6Lix1QJymUMbeIW1gJWW61cdyJYlqkrDOOlBlJX15JoirPA9MEVyhWE26iTkEr2iWtR9kRAJ6XsyZdN5LGHA2hQ4QpUbBZtIHR2RYsQ9UyOT/+asPWkGaS4TqQ+HnbE2+6hadvn2lyFBo9DQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o1jOYSVdGeocBFITx9yjGuJdoH4mezrM+akeksBjJI=;
 b=bdzHh2AmjaQs4BE0U+tQiIxQb9sUoCXZr7Hdzcmi0oJ8c+3jGH/XbQsNP3PUyz9RE+Bo5J4OD1wyM2tjcTInvAEoilC65yv9uol1c1pl0fY/mWZOYKmUMHk7zSJavarDS8ocEFJzHllZS01SSDcN6htthqXxNt8hwofEfTbp7CP2w+wsCMPoUgZ3hUiu1jgtj5GuxQpx9XDeJRkDSEcmy6giUlHI4vyGc59o6vACwnidyrRThram3SIJuNlss4xBBjR0hW4htDe+FvQ2UNvgmHrWqVBH9h/42Jthg5lfY9LB/Vh0uRAAdNPExdDRIHZHIMCZRYGVZcbWQy6vH6NnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o1jOYSVdGeocBFITx9yjGuJdoH4mezrM+akeksBjJI=;
 b=mkDpEkrw/bGACk7b8CHbtobGh3uovjMEoKFCdNjbN66+ZOGzADiAKDPYJ92hAJf9Cd0VBP7aJXyDvf6WOp/Xw0dNy8ESHx23/KQLv/F6xwYzDgIA2V18w0p0cPj0GHJKzXJsVBh1+w4NfBBrGxW+PUm7nPEx8WFy8zduVs8F1YM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 12:30:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:30:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mail@conchuod.ie>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: gpio: mpfs-gpio: allow parsing of hog child
 nodes.
Thread-Topic: [PATCH] dt-bindings: gpio: mpfs-gpio: allow parsing of hog child
 nodes.
Thread-Index: AQHYtNXjrXcUZeoA+U+yOP8cMQNzh62/jagAgAAFigA=
Date:   Thu, 25 Aug 2022 12:30:35 +0000
Message-ID: <e94c1de8-e5e3-2325-38f9-1606c9369aef@microchip.com>
References: <20220820204130.1380270-1-mail@conchuod.ie>
 <0ecf1664-03a2-71ac-b967-6905b96c7ce0@linaro.org>
In-Reply-To: <0ecf1664-03a2-71ac-b967-6905b96c7ce0@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20a52246-147f-4921-1f78-08da86959c2b
x-ms-traffictypediagnostic: PH7PR11MB7049:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRAJY9a5viq9Ydu2cv99NSXUqJa9/ZhhXaj5ASUR9KvEYZxs1TPZ0/4aXBLvM1TrKvMVK4eib37CLnSVHTUQtsSy8FrFNH6DxL71MNCqdAHmqqzqYEXCxzVicB7kYVKwiPk41j6BGKQeXSOZeFd/Vn4aM5HjQ9C8RhmfUrVesAorG4xDOqKe/GQdODPvsJxl54viFVwBQ7RpWLPI45/UPFLw4Gbs8s2Mh1+TvcE4qT/2GBzxiyRVvHtgOTEjgpsqxbF12nv2sq6KShB6afIWE8XlrVuQ5pSXvL1o5jYmekaTxnGdIt/Lea8PE2CCvbcPVyLfKdjPCmHNBCEJQmdOOUmibng2kd4L1iLTpYiHiJAPKjYsTz3DEejjtBu7TY4eo3d6hIQJHLDD9lI58UrcBSPE/FDuyk9ypJkX0qia9fyrzHen+7oJDuJ8Fq6q71PQKNwbnEqHrGewvI7G7h7vItc/DBTXbc8cRCywmGYUAeSMWdH7lWDejhqDXS7L70C0aW2kAYLfjiZBKOBJ3YMA16NY7ak63+djR5n38flGc8W3SigNWMYSn5sYTrfwSfCNIj0VJ9a/IuDDoaz6mFKtZGn7VbWkoTExlTvVi8lRMfow70wVVNTbhrU7M/6oHCa6PVYDd0tfUeGDuLkbNU1Fulr/HJDZqS5j/zITFEHzkwRhnZQZRu0uUg/brrGPwmUpnboY3HbqJ2eFOXLDb2HB+bVUykhDKVvaB05PW+gwSF43vN9tjfVDp4G8MYnYmOIImucmox+pyrahnSUqlWFO5g0YjwDD6ywbD/nYlTtrN/rtn6zHLXzdk86r6SmDCiYMoU6/a5WjPZAyPZGOQnSRqPTp0MRpGGj+AdQHb8stCso=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(376002)(39860400002)(366004)(8936002)(36756003)(91956017)(76116006)(5660300002)(110136005)(122000001)(966005)(31686004)(38100700002)(41300700001)(8676002)(66946007)(66446008)(66556008)(478600001)(316002)(54906003)(6486002)(66476007)(4326008)(64756008)(6512007)(86362001)(2616005)(6506007)(71200400001)(53546011)(186003)(2906002)(38070700005)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUNzTzJZOGNKMi94RkxOOVdpYXBWbDZlNURzcDQ0MDBmT2dURktFbDF0TnZI?=
 =?utf-8?B?ekQ4ckRRdVZGQVBzZWVsd2VldmFaNEtwVDBweWxHSk9QSE1TTDRKWmVwUE94?=
 =?utf-8?B?aUlZZG9pc2xIN2hka2tPbnNXcmZrb0pkVlFuOWRGMVNIZlN1L2FkczJJWGZ3?=
 =?utf-8?B?aWZNZHRLa2dMVko0REZta2toV05RWmdoUjZiZnBJV1puM05rdjY0VzliVW1q?=
 =?utf-8?B?d2pTcUlwc0FJcFltRjlyYUxHb2Y0YlBQanIyeUluZmIyQlcxc3lBYXJZSjVW?=
 =?utf-8?B?Z3phYmgyTVBvZFJLNEo1Q0RwT3ZUMXFEVVUrVEwwTGIxbUJ1OHZxa1JBS3pR?=
 =?utf-8?B?Q01mU3N5bmdrY2VWcFBwdXhQRlVjNm90d2phcEUraTU4VlZ3aEdWSHhEMUM2?=
 =?utf-8?B?Qi8zalZ0NE1iOUlhQUdDMDVtTHovdWl4cWh3SnhTY2Y3MGtvbzFDSzJ0aEh2?=
 =?utf-8?B?dzNFai9QSWZLeWFKalZaTzBsbU91a05JMnNjMGxNMDNXTmRGTUIrbEZHTzAz?=
 =?utf-8?B?V0tNNEg4SnRwU09qOFdQS2d2VWFTNXA4K0hxRlg4VWhVTjNnZk03dFVLVDk0?=
 =?utf-8?B?OEJMeUJ2d3JOUW9xejdhc0d6OHZXUkdVcVlDQUxtMDlYU2JEZFZ3ZHBaUEUv?=
 =?utf-8?B?R3UweSsvYVpENndSZ2RjUDd2T281TkJybXdMU05QTVAzRzMzNVZnS0hzUU5s?=
 =?utf-8?B?aTRTcmxQSXQrMzVEYmpPenNJRU9CKzl1RC9sMVhTT2R0SWJ1UjBjZ1Z5dkNW?=
 =?utf-8?B?UGV0ZEpEQVRvSkdJejlnM1kwbU9ZK1RyRDhGSnZ3Q2xqNDFiRnp4Z1I0d3VG?=
 =?utf-8?B?ZVFtMGVXWVBERGIrQTVDWXJWWGhMTkFuLzZSTDF1cGpDbm9JbENGNERkYWVE?=
 =?utf-8?B?Vjd3VFpJNUlqMWcwenh0RTlLdWhidnpuQ3hDa0g5cElOTndnWnBDUVdxSkhG?=
 =?utf-8?B?bEFGQS95Z1NPTTE1ZVhuMmhUNi8yQkdjSkF3dGx6S1p2eDVwNGdmYWZMN3pM?=
 =?utf-8?B?VGFCZnZYZE1tK2dGU0d2eUIrbDY0a0RsVWo4WlpRS3NvTmQyVmozZk5iS0l0?=
 =?utf-8?B?aGtlL2VHZ0F4Z3lPVHhyMGZKTGg5QmQrZVV2aVR2c1VMSlI4bk0xMTlVT1I1?=
 =?utf-8?B?VTJEVHRZTTZ6ZENFR1lFNm5KTE5XMFh5WXZUNXArWDh2ZlN4ZmhIL1JTWEw4?=
 =?utf-8?B?STh5QUlVVi9tSCtoN2dySWhyUGJEaGVuM0s0SEVTbkNkd1VBZ0hIVkZxVElt?=
 =?utf-8?B?UFJxODlqcEZ3dXJPUFBUWlViaU9oc0tKYVl3ZUJlWGx2TGI1dzJhT2VLd045?=
 =?utf-8?B?elZROWpqWnd4aU05eEFSUmI2T2JPcVBjK1RQN2hlZ3lYc1ErNC9qbzZGQkNO?=
 =?utf-8?B?NWVaejZudlBmcWN4SDFIWGNHNk5EVFBrT0R6WG5ZVUc3NmFlQTZxaXBGSXNF?=
 =?utf-8?B?K0FDWncya1R0Zy9leFhQc3R0cHgrNmtlMlQ0MkswQ1JEZUlSMHIrWFo5VXlM?=
 =?utf-8?B?UnFVTTlsNkRkQU94Y1lvRklNdnJJNm4vemQ5VXRNcS9ZZ3BGS0IrRGt1NmYx?=
 =?utf-8?B?Y2lCTmlVQ2F3MTIwalh2M1JFYi9HRi90TisrR2NiWWV5Qnl0T3hwaTlQczBY?=
 =?utf-8?B?MlRMRk5YbjJpYXNpUmZDdXVNVWl1TWUvNUczb21YSEZPSENwT3B1QkdLT3ho?=
 =?utf-8?B?Qkx5WDJFVmNaUVhZU1Z0dDZtcEFEd0hEYWN0WW40alMxS0IvbjJmYXdVbEs3?=
 =?utf-8?B?QmMwMmswOXVNcUV1RVBLQzdWaThBeU5ONG41L0VpRUhlbHlKYWtqTGNWNU1J?=
 =?utf-8?B?VW1OL3JuL2NRaEdWNkhOOGppdDVpbFJvbEVSd3M2QVlNZDAvRG10cmVrd2Fx?=
 =?utf-8?B?aExpSVQ1V0JXY01KOW9XOWM5NkdXOGxYWGlPYkxEWDRXSlowdnByZEFwbDFN?=
 =?utf-8?B?Z1FDSUg5eXFnbnY5b0VYeGtZVHh5M1g2b0N5NHJobGEvbmpPZEFHMWlsU1pC?=
 =?utf-8?B?YThQMVVsNVlqRm02ZFg3V293clNSdGxYYTZsUEw4YlJZY1hVRzY1WlRma2tt?=
 =?utf-8?B?MUpqVXVlMkRRd2RoUUo2YUoyNWtDZURlUkY0bWRBZHNQRHBscUhrUHRVWEIz?=
 =?utf-8?Q?xsBS63Vtu0dtkuudqSiaLeYRy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E5C76E4EF964D449F3EDDF92B8B014F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a52246-147f-4921-1f78-08da86959c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:30:35.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJ5JUzHGRcJpozUmNRDT8RXDAYOu3tQRpdCRlYWiBHwEtGxCmOtpPQxH1L/zTNM+LrNrx7NyAgxPMqhPMvlGdQ/3QkRmM/9OQPzGePYG/6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUvMDgvMjAyMiAxMzoxMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyMC8wOC8yMDIyIDIzOjQxLCBD
b25vciBEb29sZXkgd3JvdGU6DQo+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBt
aWNyb2NoaXAuY29tPg0KPj4NCj4+IFRoZSBTRCBjYXJkIGFuZCBlTU1DIG9uIFBvbGFyRmlyZSBT
b0MgYmFzZWQgZGV2IGJvYXJkcyBhcmUgc29tZXRpbWVzDQo+PiBzdGF0aWNhbGx5IG11eGVkIHVz
aW5nIGEgR1BJTy4gVG8gZmFjaWxpdGF0ZSB0aGlzLCBlbmFibGUgZ3Bpby1ob2cNCj4+IGNoaWxk
IG5vZGUgcHJvcGVydGllcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNv
bm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9iaW5kaW5ncy9ncGlv
L21pY3JvY2hpcCxtcGZzLWdwaW8ueWFtbCAgICAgfCAxOCArKysrKysrKysrKysrKysrKysNCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vbWljcm9jaGlwLG1wZnMtZ3Bp
by55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vbWljcm9jaGlw
LG1wZnMtZ3Bpby55YW1sDQo+PiBpbmRleCAxMTA2NTFlYWZhNzAuLjY3MDRhN2E1MmNkMCAxMDA2
NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL21pY3Jv
Y2hpcCxtcGZzLWdwaW8ueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2dwaW8vbWljcm9jaGlwLG1wZnMtZ3Bpby55YW1sDQo+PiBAQCAtNDQsNiArNDQsMjQg
QEAgcHJvcGVydGllczoNCj4+DQo+PiAgICAgZ3Bpby1jb250cm9sbGVyOiB0cnVlDQo+Pg0KPj4g
K3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPj4gKyAgIl4uKy1ob2coPzotWzAtOV0rKT8kIjoNCj4gDQo+
IFdoYXQgaXMgdGhpcyBwYXR0ZXJuIGFib3V0OiAiKD86IiA/DQoNCk1lIGJlaW5nIGEgcGVkYW50
IEkgc3VwcG9zZS4gIigpIiBpcyBhIGNhcHR1cmUgd2hpbGUgIig/OikiIGlzIGEgbWF0Y2guDQpI
b3dldmVyLCBpdCBkb2VzIHNlZW0gbGlrZSBqc29uLXNjaGVtYSBzdWdnZXN0cyB1c2luZyAiKCki
Og0KaHR0cHM6Ly9qc29uLXNjaGVtYS5vcmcvdW5kZXJzdGFuZGluZy1qc29uLXNjaGVtYS9yZWZl
cmVuY2UvcmVndWxhcl9leHByZXNzaW9ucy5odG1sDQoNCkkgZG9uJ3QgbWluZCAmIG5laXRoZXIg
ZG9lcyB0aGUgc2NoZW1hIGNoZWNrZXIuDQoNCj4gDQo+PiArICAgIHR5cGU6IG9iamVjdA0KPj4g
Kw0KPj4gKyAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgIGdwaW8taG9nOiB0cnVlDQo+PiArICAg
ICAgZ3Bpb3M6IHRydWUNCj4+ICsgICAgICBpbnB1dDogdHJ1ZQ0KPj4gKyAgICAgIG91dHB1dC1o
aWdoOiB0cnVlDQo+PiArICAgICAgb3V0cHV0LWxvdzogdHJ1ZQ0KPj4gKyAgICAgIGxpbmUtbmFt
ZTogdHJ1ZQ0KPj4gKw0KPj4gKyAgICByZXF1aXJlZDoNCj4+ICsgICAgICAtIGdwaW8taG9nDQo+
PiArICAgICAgLSBncGlvcw0KPj4gKw0KPj4gKyAgICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCj4gDQo+IFB1dCBpdCBhZnRlciB0eXBlOm9iamVjdC4gRWFzaWVyIHRvIHJlYWQvZmluZC4N
Cg0KU3VyZS4NClRoYW5rcywNCkNvbm9yLg0K
