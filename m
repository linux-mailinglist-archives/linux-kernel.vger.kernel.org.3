Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164064B1EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbiBKG6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:58:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiBKG6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:58:39 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E606410B4;
        Thu, 10 Feb 2022 22:58:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYljCTQODvmgzRAt/GbtOzufp4ZqBlh0FjM2zlg+tlEoT36W4undpJUzyhBtVyxjqagdBGb7hAFbJHGK64y3vMzrDs4Dm0HuMff0m/qBTzW0fdFqI9lPDyzhC8UbFt0Cae8L+MAv6rYO9+GGx6yGJujOhZSXnSJaOKnQXzFQRIIGgfHwCXZ1TmYSXeCU8TwifWDlyHaLuhFlUnEuTZ/szjh5AOpMU1tZqrm9YkUxlbZ3P7Fe7TxhFQqYpKjo8SOlQg3sNAny0eQKmzEkH9UMQ3Ah/XGzCV6y0+9/qMzPc9ZH8uGD0pdYb26hmrovHi/bZJgU88GhcUuRILI3HLCVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T67x83oIC5ki2rKONS+sRgtUPtYETG+G2aMfTvTaSO0=;
 b=Y9X/ZFZJfAxIs0P99F8EvLVO+mwd/HYE6fPMLIspwmy4bcswssS2pKbk2Ji5Hi/6IhvLwVWXsW6DQHwjoh7djRnA8SlOg3teQWsJmWohheG0lu5VDp6MvdlfA8eFkQE5bX4br4JTkZuIezgDvyFaIgPcpAh0SFQhKDgCZaERZYWjQH/lIeaXF6RKSm6OsNJb2qx2YlcnZuBO00PbdjXzyKgluNmTDNN7yx7CAG5tieRM/3HSfE9BY5Z1Ue6+wICk0h355eM0Beu9tSLmt3KKHYGaZkK6RRSJHLP+2qn4Jxa0AB1F4C+A+EuFWWa6O2WVNXkezgYmO9+Nx5+pArba9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T67x83oIC5ki2rKONS+sRgtUPtYETG+G2aMfTvTaSO0=;
 b=QVu96cNXNV8gxyaag0+5A+tXG3XJfQHceNmCX1QUCZuzp7/QUoTDLGJxbvSxQU/p1RMBa5nL6ELvdMWyikp7zI5I1JRIlXSxrK4OFJ2e6m0LsqxJrzWizJxtZNeAxnNs2HZG2S0d8TnhVgRSpJRsEVSwxbfnVm7BCbJ61OoI7GY=
Received: from PAXPR04MB8334.eurprd04.prod.outlook.com (2603:10a6:102:1cc::8)
 by VI1PR04MB5280.eurprd04.prod.outlook.com (2603:10a6:803:5f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Fri, 11 Feb
 2022 06:58:34 +0000
Received: from PAXPR04MB8334.eurprd04.prod.outlook.com
 ([fe80::a804:e11c:f458:a582]) by PAXPR04MB8334.eurprd04.prod.outlook.com
 ([fe80::a804:e11c:f458:a582%5]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 06:58:34 +0000
From:   Nikhil Gupta <nikhil.gupta@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [EXT] Re: [PATCH] of/fdt: move elfcorehdr reservation early for
 crash dump kernel
Thread-Topic: [EXT] Re: [PATCH] of/fdt: move elfcorehdr reservation early for
 crash dump kernel
Thread-Index: AQHYE/7NUAdCF89rWEGfCrdo+11hRqx4kKqAgAY+g8CADSN6AIACDScg
Date:   Fri, 11 Feb 2022 06:58:34 +0000
Message-ID: <PAXPR04MB8334277120948CDCCC07300D8B309@PAXPR04MB8334.eurprd04.prod.outlook.com>
References: <20220128042321.15228-1-nikhil.gupta@nxp.com>
 <CAL_JsqKWmnQde+4tnZ3d90pWguezLVqto4DRe3WRjf9PCQ=L4w@mail.gmail.com>
 <PAXPR04MB83348BB9265516255BBB2ACB8B269@PAXPR04MB8334.eurprd04.prod.outlook.com>
 <CAL_Jsq+EnQE27cfUU2xZM+kjQrmhO4PcO3WDG2yg+=sRAnxPgQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+EnQE27cfUU2xZM+kjQrmhO4PcO3WDG2yg+=sRAnxPgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0ee70bc-ffd1-46e2-d44e-08d9ed2bebef
x-ms-traffictypediagnostic: VI1PR04MB5280:EE_
x-microsoft-antispam-prvs: <VI1PR04MB52806B108926A6A561634E728B309@VI1PR04MB5280.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11TtRKdZSp6tioYj1eW+M42uLdZ3f9CML6YJ6P/QnB0lC5ltIJa1RwsaBU8sKhl1bzUg2Ksxb1UZJ+Ys0T09vEpP0ptcott2j8j9Q2Mcm5lNJvDX+CzAHTovnrJkNrZsWb1CjIqAgAbnXnUR6BIuEWAs8VFg8y8lP8WjmgTGhMYLE/kN8L6AjV+NLyibTGoQKMH5jxIy5Z4y/ofWAd8KnUNlpKGw9w8Ly2++XekJkqlgAVN7A814xuqNbL5MZKGnn6QOgk/uPKFh1BBpAc1PQndzXSuVW2UTQyWRadNtPWNeAYpRG0lZ51Sq2uFP9493Jv2kr6a9qMvh7pEkQ+wGF87lfmuakEO0anMbxdXWrQ51ECRUyXGccIhOaLsHVwXBi3hfpTWQsQ0Nd3dEveb/K3yTPdnSBbtC22luW2qy1oBaKM+9354eUFqg/qiQ9lXGUYgob7wD2Wulu/nhfw8AdQlgg4XEZVwxDzVcGuvE1UYLcW0f27QjlIkjbV/OSIs1gw8h1C8clSbBhipg0R+5CrQEmIfJJv++jVIBUZ1Dothpri+LVpfNOYWoW3f7NYVUN9P3H+/dSz7GEAuvK0N0Tgxji5fDK8UJup31rqJ4zUFHhy3hpQgqsA8lRUse83TmhVTrxdO0uzoTA71/TZWzxMrwHIF4bEWTn497dISXo+qA+9sNfypb/XiFdEcV3fDTFJDJHaA+oNO0ADNpsH8Z4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(186003)(8676002)(26005)(4326008)(9686003)(44832011)(53546011)(55236004)(52536014)(7696005)(76116006)(66446008)(8936002)(6506007)(54906003)(2906002)(5660300002)(66556008)(508600001)(55016003)(83380400001)(38100700002)(38070700005)(45080400002)(122000001)(66476007)(86362001)(316002)(64756008)(66946007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkQ4TXk3TzNpQUgxbzYrdERmTkdFcE55OEtkOFF5QkJHSTZGMFFRSTUveG1W?=
 =?utf-8?B?d1hmZnpRM2xpUG0xSFdabjJXaVhZSnVKZzU1b3hzQ0s5VlN1NlZzaktseWFn?=
 =?utf-8?B?T1RiMTVVZDV0d3h6cWZIMTJSdThacU1GSmg4RnRNK0MrQTA5WjF5Wm9ycTlI?=
 =?utf-8?B?ZktXWGdncCtZdXZUckVQT1pDTVpHemNzT1RZQ2R5dW5SZEN5SDYvUGR5eVR2?=
 =?utf-8?B?VXVHOGhCbmxkQ2RCUkJDdDlXUmR3alhJZUpZNnNKSHpNSEwrUzFjczNYMjNP?=
 =?utf-8?B?Zkowb3lwV3dqT2hSazhyRWNyWklyZGRRMXBYUnozbUNEZ1drZzBIRG9pcEND?=
 =?utf-8?B?ejNCK0NvRkQ1Q0ozUXJiUlRZb05BQ0xndS9ta2JLYWN5QXZOZDVCZDQ1RXhK?=
 =?utf-8?B?bTVxTGZxaVhDcjlzRVQxQ253M2tNVFhjUkxiWkhxOXNMcGVZWkZrZ0l5cXRS?=
 =?utf-8?B?akk2bWhrU3Aza0xjRmQveDJkNVFQZi9mTitQN01Ed2l1SWlHY1dOYi9HWWt5?=
 =?utf-8?B?Nm80MENYa0NvNlZJLzBMVWxnZ1p3N3cwSXlyRmtaQW5nYWNNY0JhSFRjQm5T?=
 =?utf-8?B?ZHp6NGVFSXY5T2NaQ0JmQlFpZUN5N0UzTzRjYjFiZFZZUWxuTzM0S21GV29m?=
 =?utf-8?B?d0hpOFpKZmFuSnBpNGlRQlhZVXEvMGRWVUFBSThhaHgrV2Iyd1cwemsrRDl3?=
 =?utf-8?B?UU8wQXIvYVdQK3BlOEdXRExuN1E4cTZvcElzQWxHVVl5b3FqRStlNUlIeGdL?=
 =?utf-8?B?cHp3Si91SGxrb2tHbldBd3JINVMyN3RlN2w1VU50S0FaY0l0a0h6NnBWeEZG?=
 =?utf-8?B?dGJ1OVNNZDJNK05vZHdPSTJtM1FUQXhUaEM2VGFKakhVTC9vc3BwaXkzOEln?=
 =?utf-8?B?dUxGcnhyd045QXZJL29RQ1JZY1IwcS83SWZLSFJhanJ1MzJxTStSdkx2ZkJk?=
 =?utf-8?B?eEFTMWkvNkJFK3RmVEs3LzkxazVOd3NaY0w5VWlEWmRmSkRqT3grNkNwSW1q?=
 =?utf-8?B?cWtXYjRlY00wMzA0bUdTTTd3ZGtiNlpIWE5xRmpRU0JXcG5JUUg1eWJEUS9R?=
 =?utf-8?B?MGV3WWJiUFV1aitQT1k0ZGE0c3lnQkJ2N1pCbG9vM2VTSVJGN2VJcER5R2RZ?=
 =?utf-8?B?SXNRTlZyQWplVUhQcWNyNmo3M2puR1NZenpKRzlzcXVDVEVYRzUzQ0RWK0R5?=
 =?utf-8?B?cEN1ZjhkREZQbVBMR2tEU1BKckNIZ283WU9VRUphbTZyS1p3WmdnTkoybFg3?=
 =?utf-8?B?SHJ3cktzYzRCaXJJSm1OTE9PY1pXeUNMNENiTGduTUxuWksydHZDNm1oMXla?=
 =?utf-8?B?c090UERZTmRBYmRiK1hjZ25IQlM1cnh1NGNteEZrbjVjRERQanVNYk5NeFJS?=
 =?utf-8?B?TkkrRVJiWHNIS091YnNXWitUYjVnYTJBajNXU01HRXlMeDA0aDFoZFdxeHB6?=
 =?utf-8?B?ZHFUQkswUzZ0b08rbUFsc0ZOM2VnVVZBTW5GUjVSVFJsSmV5OCtrZThiOHdo?=
 =?utf-8?B?bnR3cFcwcFJHS0g2UFZLQXpnTVN4ZTh5blVjYUd5by9VNmx3RVpEcVN3aWpC?=
 =?utf-8?B?dVRvVU9kYW91c0R6WllBUjhXNWNHSXo1ZXdRRkl6V0llQ3FWMVVpaVErVEhG?=
 =?utf-8?B?b1Q1RHpvMzBDYUwwWng3VmREeFBKOHlWLzJXTTFZUXMzdW0yRE1XRE5oekFE?=
 =?utf-8?B?bHdNRmphZFVuK3d1OTA3OTNXUjdqQ0RtU3ZvY2dKc0NRUGpJRlRzb0pxcjJj?=
 =?utf-8?B?Z25BaHBaa1RVa25pMTF1cncxMXdic3ZOR1IzMjBHTmFNNUEzNmVUcjlpWTc0?=
 =?utf-8?B?UzZSNFZiMFZJblJkUDIxQVhPTmNobzAvaytMeWtZM0E1QlE5S2EvYzVYaW5w?=
 =?utf-8?B?a0dxa2pPMThUV2R1aU14MjVXRm1UTHA2WjUvV2NaR2lkanM2enFReDJ2VHBw?=
 =?utf-8?B?M1Ric25rdGYzdGpIRDVhRHA0QjlkWWdHT1BBM0hEb3RNdzA0OE1mKzEvNUJ5?=
 =?utf-8?B?YW40QlFZMDUyeWc2VUlXVHV2YThmZVdjbElBK1I3YTNPQUs2dnVTTStPN3J4?=
 =?utf-8?B?ZkZYZ0M5S3ZnTUg1b0x2M0ZWYmJxWEovbURnU25Wc1FqV0IxQkZaWWlGYVBp?=
 =?utf-8?B?T3MwRG82bGt2WWg2SW1yL1BCSXBVOWM5TnZBZGRFNGxXaWt3V0swUzlWZXN1?=
 =?utf-8?Q?GUtZqpV4ZDId9vp7WPjePoA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ee70bc-ffd1-46e2-d44e-08d9ed2bebef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 06:58:34.6269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRSJJFa3Qk1eCCGYHqtCDn9EktMdJr01MWAGe8U4ygAXE6e1db9Vz1KUO3TXLleICSZdhqilGvgu6HODp8dc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDEwLCAyMDIyIDU6
MDMgQU0NCj4gVG86IE5pa2hpbCBHdXB0YSA8bmlraGlsLmd1cHRhQG54cC5jb20+DQo+IENjOiBs
aW51eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBG
cmFuayBSb3dhbmQNCj4gPGZyb3dhbmQubGlzdEBnbWFpbC5jb20+OyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFByaXlhbmthIEph
aW4gPHByaXlhbmthLmphaW5AbnhwLmNvbT47IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25n
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIXSBvZi9mZHQ6IG1vdmUg
ZWxmY29yZWhkciByZXNlcnZhdGlvbiBlYXJseSBmb3INCj4gY3Jhc2ggZHVtcCBrZXJuZWwNCj4g
DQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gVHVlLCBGZWIgMSwgMjAyMiBhdCA5OjM3
IEFNIE5pa2hpbCBHdXB0YSA8bmlraGlsLmd1cHRhQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+IA0K
PiBQbGVhc2UgZG9uJ3QgdG9wIHBvc3QgYW5kIGZpeCB5b3VyIGVtYWlsIGNsaWVudCBxdW90aW5n
IG9uIHJlcGxpZXMuDQo+IElPVywgZG9uJ3QgdXNlIE91dGxvb2suIFdoaWxlIE1TIGxvdmVzIExp
bnV4IG5vdywgdGhleSBkb24ndCBtYWtlIGFuIGVtYWlsDQo+IGNsaWVudCB0aGF0IHdvcmtzIHdp
dGggbWFpbGxpc3RzLg0KDQpUaGFua3MsIHdpbGwgdGFrZSBjYXJlICENCj4gDQo+ID4gSGVsbG8g
Um9iLA0KPiA+DQo+ID4gVGhpcyBpc3N1ZSB3aWxsIGNvbWUgaW4gc2NlbmFyaW9zIHdoZXJlIHRo
ZSBtZW1vcnkgaGFzIGJlZW4gcmVzZXJ2ZWQNCj4gPiB1c2luZyBmZHRfaW5pdF9yZXNlcnZlZF9t
ZW0oKSBUaGUgbWVtb3J5IGFkZHJlc3Mgd2hpY2ggaXMgcmVzZXJ2ZWQNCj4gPiBvdmVybGFwcyB3
aXRoIHRoZSBhZGRyZXNzIG9mIGVsZmNvcmVoZHIgd2hpY2ggaGFzIGEgZml4ZWQgYWRkcmVzcywg
U28gdGhlDQo+IG1lbW9yeSBmb3IgZWxmY29yZWhkciBuZWVkcyB0byBiZSByZXNlcnZlZCBmaXJz
dC4NCj4gPg0KPiA+IGNyYXNoa2VybmVsIG1lbW9yeSByYW5nZSA6IDB4MDAwMDAwMDBkNDAwMDAw
MCAtIDB4MDAwMDAwMDBmNDAwMDAwMA0KPiA+ICg1MTIgTUIpIGVsZmNvcmVoZHIgYWRkciBpcyBj
YWxjdWxhdGVkIGluIGtleGVjIHRvb2wgYmFzZWQgb24gcmVzZXJ2ZWQNCj4gY3Jhc2hrZXJuZWwg
bWVtb3J5IHNwYWNlLiAoTGFzdCBwYWdlIGlzIHVzZWQgaW4gdG9wIGRvd24gb3JkZXIpDQo+ID4g
ZWxmY29yZWhkciBjb25mbGljdCB3aXRoIG1lbW9yeSBbICAgIDAuMDAwMDAwXSBtZW1ibG9ja19y
ZXNlcnZlOg0KPiBbMHgwMDAwMDAwMGYzYzAwMDAwLTB4MDAwMDAwMDBmM2ZmZmZmZl0gcmVzZXJ2
ZWQgYnkgZmR0X2luaXRfcmVzZXJ2ZWRfbWVtKCkNCj4gPg0KPiA+IFdpdGhvdXQgUGF0Y2g6DQo+
ID4NCj4gPiBbICAgIDAuMDAwMDAwXSBtZW1ibG9ja19yZXNlcnZlOiBbMHgwMDAwMDAwMGQ0MDEw
MDAwLTB4MDAwMDAwMDBkNjc3ZmZmZl0NCj4gYXJtNjRfbWVtYmxvY2tfaW5pdCsweDI1OC8weDJj
OA0KPiA+IFsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX3BoeXNfYWxsb2NfcmFuZ2U6IDQxOTQzMDQg
Ynl0ZXMgYWxpZ249MHg0MDAwMDANCj4gZnJvbT0weDAwMDAwMDAwMDAwMDAwMDAgbWF4X2FkZHI9
MHgwMDAxMDAwMDAwMDAwMDAwDQo+IGVhcmx5X2luaXRfZHRfYWxsb2NfcmVzZXJ2ZWRfbWVtb3J5
X2FyY2grMHg5Yy8weDE2Yw0KPiA+IFsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX3Jlc2VydmU6IFsw
eDAwMDAwMDAwZjNjMDAwMDAtMHgwMDAwMDAwMGYzZmZmZmZmXQ0KPiBtZW1ibG9ja19hbGxvY19y
YW5nZV9uaWQrMHhkYy8weDE1MA0KPiA+IFsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX3BoeXNfYWxs
b2NfcmFuZ2U6IDMzNTU0NDMyIGJ5dGVzIGFsaWduPTB4MjAwMDAwMA0KPiBmcm9tPTB4MDAwMDAw
MDAwMDAwMDAwMCBtYXhfYWRkcj0weDAwMDEwMDAwMDAwMDAwMDANCj4gZWFybHlfaW5pdF9kdF9h
bGxvY19yZXNlcnZlZF9tZW1vcnlfYXJjaCsweDljLzB4MTZjDQo+ID4gWyAgICAwLjAwMDAwMF0g
bWVtYmxvY2tfcmVzZXJ2ZTogWzB4MDAwMDAwMDBmMDAwMDAwMC0weDAwMDAwMDAwZjFmZmZmZmZd
DQo+IG1lbWJsb2NrX2FsbG9jX3JhbmdlX25pZCsweGRjLzB4MTUwDQo+ID4gWyAgICAwLjAwMDAw
MF0gbWVtYmxvY2tfcGh5c19hbGxvY19yYW5nZTogMTY3NzcyMTYgYnl0ZXMgYWxpZ249MHgxMDAw
MDAwDQo+IGZyb209MHgwMDAwMDAwMDAwMDAwMDAwIG1heF9hZGRyPTB4MDAwMTAwMDAwMDAwMDAw
MA0KPiBlYXJseV9pbml0X2R0X2FsbG9jX3Jlc2VydmVkX21lbW9yeV9hcmNoKzB4OWMvMHgxNmMN
Cj4gPiBbICAgIDAuMDAwMDAwXSBtZW1ibG9ja19yZXNlcnZlOiBbMHgwMDAwMDAwMGYyMDAwMDAw
LTB4MDAwMDAwMDBmMmZmZmZmZl0NCj4gbWVtYmxvY2tfYWxsb2NfcmFuZ2VfbmlkKzB4ZGMvMHgx
NTANCj4gPiBbICAgIDAuMDAwMDAwXSBPRjogcmVzZXJ2ZWQgbWVtOiBpbml0aWFsaXplZCBub2Rl
IGJtYW4tZmJwciwgY29tcGF0aWJsZSBpZA0KPiBmc2wsYm1hbi1mYnByDQo+ID4gWyAgICAwLjAw
MDAwMF0gT0Y6IGZkdDogZWxmY29yZWhkciBpcyBvdmVybGFwcGVkDQo+ID4NCj4gPiBXaXRoIFBh
dGNoOg0KPiA+DQo+ID4gWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVtb3ZlOiBbMHgwMDAxMDAw
MDAwMDAwMDAwLTB4MDAwMGZmZmZmZmZmZmZmZV0NCj4gYXJtNjRfbWVtYmxvY2tfaW5pdCsweGEw
LzB4MmQ4DQo+ID4gWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVtb3ZlOiBbMHgwMDAwODAwMGMw
MDAwMDAwLTB4MDAwMDgwMDBiZmZmZmZmZV0NCj4gYXJtNjRfbWVtYmxvY2tfaW5pdCsweGZjLzB4
MmQ4DQo+ID4gWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVtb3ZlOiBbMHgwMDAwMDAwMGQ2MTYw
MDAwLTB4MDAwMDAwMDBkODNiZWZmZl0NCj4gYXJtNjRfbWVtYmxvY2tfaW5pdCsweDFjOC8weDJk
OA0KPiA+IFsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX2FkZDogWzB4MDAwMDAwMDBkNjE2MDAwMC0w
eDAwMDAwMDAwZDgzYmVmZmZdDQo+IGFybTY0X21lbWJsb2NrX2luaXQrMHgxZDQvMHgyZDgNCj4g
PiBbICAgIDAuMDAwMDAwXSBtZW1ibG9ja19yZXNlcnZlOiBbMHgwMDAwMDAwMGQ2MTYwMDAwLTB4
MDAwMDAwMDBkODNiZWZmZl0NCj4gYXJtNjRfbWVtYmxvY2tfaW5pdCsweDFlMC8weDJkOA0KPiA+
IFsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX3Jlc2VydmU6IFsweDAwMDAwMDAwZDQwMTAwMDAtMHgw
MDAwMDAwMGQ2MTVmZmZmXQ0KPiBhcm02NF9tZW1ibG9ja19pbml0KzB4MjYwLzB4MmQ4DQo+ID4g
WyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVzZXJ2ZTogWzB4MDAwMDAwMDBmM2ZmZjAwMC0weDAw
MDAwMDAwZjNmZmYzZmZdDQo+IGVhcmx5X2luaXRfZmR0X3NjYW5fcmVzZXJ2ZWRfbWVtKzB4Mzcw
LzB4M2M4DQo+ID4gWyAgICAwLjAwMDAwMF0gT0Y6IGZkdDogUmVzZXJ2aW5nIDEgS2lCIG9mIG1l
bW9yeSBhdCAweGYzZmZmMDAwIGZvciBlbGZjb3JlaGRyDQo+ID4gWyAgICAwLjAwMDAwMF0gbWVt
YmxvY2tfcGh5c19hbGxvY19yYW5nZTogNDE5NDMwNCBieXRlcyBhbGlnbj0weDQwMDAwMA0KPiBm
cm9tPTB4MDAwMDAwMDAwMDAwMDAwMCBtYXhfYWRkcj0weDAwMDEwMDAwMDAwMDAwMDANCj4gZWFy
bHlfaW5pdF9kdF9hbGxvY19yZXNlcnZlZF9tZW1vcnlfYXJjaCsweDM4LzB4OGMNCj4gPiBbICAg
IDAuMDAwMDAwXSBtZW1ibG9ja19yZXNlcnZlOiBbMHgwMDAwMDAwMGYzODAwMDAwLTB4MDAwMDAw
MDBmM2JmZmZmZl0NCj4gbWVtYmxvY2tfYWxsb2NfcmFuZ2VfbmlkKzB4ZGMvMHgxNTANCj4gPiBb
ICAgIDAuMDAwMDAwXSBtZW1ibG9ja19waHlzX2FsbG9jX3JhbmdlOiAzMzU1NDQzMiBieXRlcyBh
bGlnbj0weDIwMDAwMDANCj4gZnJvbT0weDAwMDAwMDAwMDAwMDAwMDAgbWF4X2FkZHI9MHgwMDAx
MDAwMDAwMDAwMDAwDQo+IGVhcmx5X2luaXRfZHRfYWxsb2NfcmVzZXJ2ZWRfbWVtb3J5X2FyY2gr
MHgzOC8weDhjDQo+ID4gWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVzZXJ2ZTogWzB4MDAwMDAw
MDBmMDAwMDAwMC0weDAwMDAwMDAwZjFmZmZmZmZdDQo+IG1lbWJsb2NrX2FsbG9jX3JhbmdlX25p
ZCsweGRjLzB4MTUwDQo+ID4gWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcGh5c19hbGxvY19yYW5n
ZTogMTY3NzcyMTYgYnl0ZXMgYWxpZ249MHgxMDAwMDAwDQo+IGZyb209MHgwMDAwMDAwMDAwMDAw
MDAwIG1heF9hZGRyPTB4MDAwMTAwMDAwMDAwMDAwMA0KPiBlYXJseV9pbml0X2R0X2FsbG9jX3Jl
c2VydmVkX21lbW9yeV9hcmNoKzB4MzgvMHg4Yw0KPiANCj4gRGlnZ2luZyBhIGJpdCBtb3JlLCBp
dCBzZWVtcyB0aGlzIG5ldmVyIHdvcmtlZD8gSXQgaXMgYWxzbyBub3QgZml4YWJsZSBpbiB0aGlz
IHdheQ0KPiBiZWZvcmUgY29tbWl0IDU3YmViOWJkMThmYyAoImFybTY0OiBrZHVtcDogUmVtb3Zl
IGN1c3RvbSBsaW51eCxlbGZjb3JlaGRyDQo+IGhhbmRsaW5nIikuIFNvIGlmIHlvdSB3YW50IGEg
Zml4IHByaW9yIHRvIHY1LjE1LCBpdCB3aWxsIG5lZWQgYSBkaWZmZXJlbnQgZml4Lg0KPiANCj4g
Um9iDQoNClllcywgeW91IGFyZSByaWdodC4gSSBmYWNlIHRoaXMgaXNzdWUgZWFybGllciBhcyB3
ZWxsIHdpdGggcHJldmlvdXMga2VybmVsLiBGb3IgdGhhdCAsIGEgZGlmZmVyZW50IHNpbWlsYXIg
cGF0Y2ggaXMgbmVlZGVkIG9uIGFub3RoZXIgZmlsZS4NCkkgd2lsbCBmbG9hdCB0aGUgcGF0Y2gg
dG8gZml4IGlzc3VlIGluIHByZXZpb3VzIGtlcm5lbHMgb25jZSB0aGlzIHBhdGNoIGdldHMgcmV2
aWV3ZWQgYW5kIGFwcHJvdmVkLg0KDQpEbyB5b3UgaGF2ZSBhbnkgb3RoZXIgcXVlcnkgb24gdGhp
cyBwYXRjaCBvciBpcyBpdCBmaW5lPw0KDQpUaGFua3MNCk5pa2hpbA0KDQogDQo=
