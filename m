Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44EE4B0A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiBJKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:08:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiBJKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:08:57 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80131.outbound.protection.outlook.com [40.107.8.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B5BF28;
        Thu, 10 Feb 2022 02:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdrGsyaUyuU04Q9PYtTvFgQspJQe3nctfWsC67j2/GF2JmmM01aXQGQjCarOpVwMoQUv0asjzeImAuOew05wfiFeoEJjRoKT02wMQ+pHWEX4OooGvggtyNuGpTSfuLjvmduJyzPOP6cCYlB3rmhUqHnE5vFNEOzWuo7hQdio/y3JLfdP5ROF28iNLZaiM8nsTtVeVfzy55e4dlrRMCAgEAgbkeLez6qOQjjoeGJxGJY+dwARB6/d2h60ws2kp7d8Yu6MUh63pzQ/FVESXWxGI+dKRLG5gfpxtTw36o6RWnnwxTBSBcEWCSqg2SG+6IUAePp5c5wSCohHXo+IWkR6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OEeOQ5UIMhWVKRE3BkTw8SLE3d0cEDq0+e85iqmx4Q=;
 b=f92Sa+pzqFD0A/T+irEqXqx64Kc/oo+4N1vTp/QXL9srh5MHooLfkl9FwqsXk/QVNQ1bP8/OWWKVFKzgXOSDypY4qQo4vUXxDJ68Hl40axSi/gKll7T9eUhGvus3z0JGUkX25USAvSSCOQmhYjqjxI16YTtJ9JPOtF7r8xxlaFn9uVhPCmtA7saIWY3rCG0T65Higz3e7nWgY5jREfXIfnQLd8oRpPv746DwU2k1R6iQ+borgZ5Re70IdYFc+3tAz+2g9tDTdMkjbIb8pofx7dlxteIc4y14dEM4UGRCMRXxwI4+fWj8t5qFRJZ7gWqToM3a5JWZyK3LqxxKzUMaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OEeOQ5UIMhWVKRE3BkTw8SLE3d0cEDq0+e85iqmx4Q=;
 b=zN5m7nvEjtAZSpsMRNRTYXAMjVSS+ZqrO0JA8hLPmz/xxP4yKqeuGEjJagWef69ECoUs/cb5uzp4E15keS+L/MofsAB+EO5rCsa4elTejZ+QhGQUBo0wpUTMyr7X+XfFYnsGz4VwAO57RG7gK6CSjGla8Fbsew+4YEg4sGWY0ek=
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com (2603:10a6:20b:3aa::24)
 by DB7PR06MB4156.eurprd06.prod.outlook.com (2603:10a6:5:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Thu, 10 Feb
 2022 10:08:53 +0000
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::e8c6:e6c0:5876:6f13]) by AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::e8c6:e6c0:5876:6f13%6]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 10:08:53 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 2/6] iio: accel: sca3300: Add interface for operation
 modes.
Thread-Topic: [PATCH V1 2/6] iio: accel: sca3300: Add interface for operation
 modes.
Thread-Index: AQHYEQZEw8eRHjGaB0STCAeuxY1jn6x7ej0AgBEgbFA=
Date:   Thu, 10 Feb 2022 10:08:53 +0000
Message-ID: <AM9PR06MB78448AE3641602CA8E52603AD72F9@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
 <20220130114014.38923fb4@jic23-huawei>
In-Reply-To: <20220130114014.38923fb4@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3e83ace-bad6-4ed3-9fc2-08d9ec7d5787
x-ms-traffictypediagnostic: DB7PR06MB4156:EE_
x-microsoft-antispam-prvs: <DB7PR06MB4156989D8159819C5C8F00ACD72F9@DB7PR06MB4156.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJU6Xz4oD3D4O1Pxi+n0CA8cf74kj3edj/itXJZoFKIMVWod80og0EHrzBlBy5/X20EU8z/kd4gz7XduWh7x+4x7JYG3g8nl1dNFP+VjshylUHqP2B3VR/MZ2qvwxyFdUjX6+QQbza6/4mk6g4+30ORkqmEga+cfl+IlEK5q5wLRmisTli1+Vx7FtHU7N86JtFOB2x9MZcfo9JP/P8wfWMYQV57TtfEtalsJzsmfV4t8Mg0aCPDi4mufl0AoDw+lsB2s7OROFogimvPN552gtn+Tr80hNzqh613IR/UptQNcFUE48OMIg+hmYxQEjWEUuSpxXbJD77KO0C1qMgWM8KqCAipWSQgpUPABkkjpKNVc6SzJ7dQbATSh0TRx5/oBGfbJY9K0jrchi94wCnBFoZW6iJTlOXipO+k27r7DsD4zaBhD1ZsobSE82F7esIeei8CT/jabd1D/o+O25Vm4jM/DaZ6T9+5ec4khAk2EqpBzgdIALobRMw8asapwYeq/HhzUOMmWFP8/eYcGW5weXxXqFw9rXKPoC1i6dgqpwwwOzbdBnG486jBbu/mvd2GPPrQuoUr2gIPV4R59XNo0sPykUhPfQgAucCPSJbyNfKSa+wJ6YL2rOAEt0Ts3JbBijNZrcTUAYpSghxTa/VmDahcoImEhFRdGIdSXnU/g+sQTtXoC9JNpJstABubv0KrBwqlg9ia6+edRBW4PqYTxXhM/5SSzszrvjfvzZBDP1uTb13hbmb+bV4HZFG64oFi/kQLIPtj/Cj+IKvfPE+L26KGK8OyqqXC5I+QkXgT9YZo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7844.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(186003)(38100700002)(86362001)(83380400001)(26005)(5660300002)(316002)(66556008)(53546011)(66946007)(71200400001)(6916009)(9686003)(6506007)(54906003)(76116006)(52536014)(8936002)(4326008)(122000001)(8676002)(2906002)(38070700005)(66476007)(7696005)(66446008)(64756008)(966005)(508600001)(33656002)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVJTSVplQ2RRUXEvTTUrVUZmM3NMK09WZkt3RzFMOU9aTFZOcmxCMWpLbWMr?=
 =?utf-8?B?SERkS04zZklheEFsYjNlYUZOMmR6WlNzRERoYjZGRGVPbFZpMEJlSDJDMnlX?=
 =?utf-8?B?YklHTSt1OHQ4MzhFbGRocEZZSXBFYU9xeVZCalBEbTk3Y3E0dUMwUzZDNVB5?=
 =?utf-8?B?WE1LN0Q3ODg4WWFWRE1zbFk0d0RjZFp0T3I4UE12bGFwTHNaL2RFL0c5ZnpL?=
 =?utf-8?B?YUwyenJ3N3FRc3Y5amJaVStyRzZQSXNZTjdxdnk5SHdrbjN2bE0yTWxPNEdC?=
 =?utf-8?B?TFFHTHpPS3NiUnNwd3VnRm9tdGQ1ZXNwNDhqRy9UNGJZRy83cGsyQUxISzN3?=
 =?utf-8?B?WEtqUG1yQWdzbEsyYXVpL0VIN1JRLzhFSTA5WlFuK20wVWhFeG14K3llNVpY?=
 =?utf-8?B?YmNGS2EyZXRTV0JTR1VPeUJSNUs2WjBtM01idG5VZ1dlOHlCdSs0Q2dpTU1X?=
 =?utf-8?B?QTVMSk9IcGhtT21TcEZYRWhnanZlb0xpOVhpUElzbVlzM1J6TnB3cndHR2lo?=
 =?utf-8?B?Ym5ENUhJUHNoYmFtN3FuQ3I0QXNYWjRkdkdXU0hvUDE2aGEzUnRvelNCZjdR?=
 =?utf-8?B?Tmw1OHNSb3k2UTdiTlFta1Z4dlIyTzlza2tySFNGVGtzcW9ac1RpN3BqcldW?=
 =?utf-8?B?UFpvbDJDNjNpZWN3bWFwN25JYmc4cmJMVFV6MHJyQWlxb3cwVXdKbjcwWGVZ?=
 =?utf-8?B?LzFucEl3WVFOZDdFaTMxNDVIeG1RbTBnaW1rV2RqQ3ZYTGJYOVFYNHc2YVBH?=
 =?utf-8?B?aUdFdFhUUnhxMndNOFpIK0JaZHJtalEycVBpeHg1TWJoQUswUlhOVUJoTFpj?=
 =?utf-8?B?NGdEU3I2Q21GdE4rQTdpVUFqelhPL2JXaitudU9vcENmVnBRVDJCRkd5WCtT?=
 =?utf-8?B?VCtsbGVLNkhqWXpCWjhKdkJBQkR1VG5RQUZzWmtUNFduQnB2YTh1bk52T2V4?=
 =?utf-8?B?OXhZUnBFUnNzVzY2RmQwSU9wT29rUlMzbU9samFIazNrVDNRLzlKUW13WEZY?=
 =?utf-8?B?K2xzcEtwU0pCczMxd1J0bnVSRm9kUlBFalJ3U1FBN3NGTlg0SlJpaDR2OGdp?=
 =?utf-8?B?L3hiam9xdUdISElqdUVCcEN4RzM4QThlTWVWcjJCK0tWREJheDdDTUNJOW5W?=
 =?utf-8?B?SHB4RzFXMVE0YllvaURWaDN1NXRQK2ZZQVVYY2owd2drMG5CV0Q3MmlkWUVq?=
 =?utf-8?B?ZVJKVXlDSFhkUmdzQlZqZnpVa0JPSERYQUNSMmlha2ZrbDMxWnFxbzI2c2tD?=
 =?utf-8?B?OVNVWGdTT1dhTytabmd4ajFvK0k4NXdUekttMkNac3R0eC85dXF4YzRyUUFO?=
 =?utf-8?B?QW1OQ3FxdWt6aFNVaG1HTGZyZWpHZUNCbjBjNmVxRTh0eDBGV1lTRzRTOEVO?=
 =?utf-8?B?WDdZeC9BTUtPOUpicE4zTlpQTTdOc2FlTkhDYUp6T0ZVUjZXeHpOR3NiK00y?=
 =?utf-8?B?SVFvdGFqOENJSWcxbDdIOHhScXZLZUJCR05rSUEweURydkJ1S002dVR4NTNr?=
 =?utf-8?B?ZWQ3dFMzUFFjTU0vWURyUDkwRFJlRGpTR0l0bkhVY3ZBdnZwVnplRU5HeXUr?=
 =?utf-8?B?dGgzZnVVWDhvekd1UE9RR0VlYkNoTVp2czJxemVjblp6R01BaE1RVzJmUkdV?=
 =?utf-8?B?RVdWZStCN3MrRi9pY1lkem5Nd2QxSkUvb3N2VDl1MWY1UW16dklPeGoxSVFo?=
 =?utf-8?B?elhoUmI2WFBKRmlPU1FWbnpKYkpqdm5IeUtFVGpNK25OczZXU2p1eFVzZEVW?=
 =?utf-8?B?bWQ3T2RaS1BiY0NqeXkzLytZemUySTZiQkREcGZITU9PWkRpN0diYjk4S2Rl?=
 =?utf-8?B?dS9aZ0E4SHZUb3lGNWFUelNoSVlab0IzOGZucnpoMXBKQ1RqRnl6anlYV2s1?=
 =?utf-8?B?MjhmbnNjRklEMGV0TnNvbmhYZmlzQXJFbzBpL2NzUmlweFphSHNjb0N1TFpw?=
 =?utf-8?B?a0VmVE5mU0pvbHQ4L0E1MFVoVURvd1A2U1JXUHQrK3p1aEZOclk5S3Y0Wk9V?=
 =?utf-8?B?MlRoaDhmTnVoU0puSzNRY3gyeEQrVURUWFVid0ZCSkRBUVhJdmg0M212Qms4?=
 =?utf-8?B?MG9BM2RobkNjbjZvbnlXSjhGU3JlRGY3TVdqSC8rM2JXK3F1OVZoajZOVXRV?=
 =?utf-8?B?UmRRR3dNWGVNTVR2MU02S2pPbHM5eFhFemhzaU1DS2VMUVJxek9VakFJZkZx?=
 =?utf-8?B?VXp1aEJ0bVBSM2g4WCtpS1NSVGtqemVRSytQYndUQnIwdk95Ni9QeUZGSVFl?=
 =?utf-8?B?VmFNS2dzTE9zSEwzbko2VGx2dTJPQ29uUHNPYndkMDhDNTBod3FyQUp2U0Y4?=
 =?utf-8?B?NHJ3MDI1VEJlcEJScklpUHBzeWdSdlA1VXkrOXdnTkszaEY3cnBtdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7844.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e83ace-bad6-4ed3-9fc2-08d9ec7d5787
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 10:08:53.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9l/yK3psVC7X3Wmu83YPCB2taeBZGIZxb1qDPUXnM/EI8SsYd2KK2Zb0GR1QYukpJNjkLHKe9X07a4ucjp6MR4PrtBNORKPjG3LDLio6XNhk0NS0FNe3m03Owp7XNaEj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGEgbG90IGFsbCBvZiB5b3VyIGlucHV0cywgSSdtIGp1c3QgYmFjayBmcm9tIGxvbmcg
aG9saWRheSBhbmQgc3RhcnQgdG8gcmV3b3JrIG9uIHRoZSBwYXRjaGVzLg0KDQo+IEZyb206IEpv
bmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgSmFudWFy
eSAzMCwgMjAyMiA3OjQwIFBNDQo+IFRvOiBMSSBRaW5nd3UgPHFpbmctd3UubGlAbGVpY2EtZ2Vv
c3lzdGVtcy5jb20uY24+DQo+IENjOiBsYXJzQG1ldGFmb28uZGU7IHJvYmgrZHRAa2VybmVsLm9y
ZzsgdG9tYXMubWVsaW5AdmFpc2FsYS5jb207DQo+IGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb207
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjEgMi82XSBpaW86IGFjY2VsOiBzY2EzMzAwOiBB
ZGQgaW50ZXJmYWNlIGZvciBvcGVyYXRpb24NCj4gbW9kZXMuDQo+IA0KPiBUaGlzIGVtYWlsIGlz
IG5vdCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJl
ZnVsIHdoaWxlDQo+IGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBs
eWluZyB0byB0aGlzIGVtYWlsLg0KPiANCj4gDQo+IE9uIE1vbiwgMjQgSmFuIDIwMjIgMDk6Mzk6
MDggKzAwMDANCj4gTEkgUWluZ3d1IDxRaW5nLXd1LkxpQGxlaWNhLWdlb3N5c3RlbXMuY29tLmNu
PiB3cm90ZToNCj4gDQo+ID4gVGhlIGFjY2VsZXJhdGlvbiBzY2FsZSBhbmQgdGhlIGZyZXF1ZW5j
eSB3ZXJlIHNldCB2aWEgb3BlcmF0aW9uIG1vZGVzLA0KPiA+IHRoZSBzY2FsIGFuZCBmcmVxdWVu
Y3kgYXJlIGJvdGggbm9uLXVuaXF1ZW5lc3MsIHRoaXMgbGVhZHMgdG8gbG9naWMNCj4gPiBjb25m
dXNpb24gZm9yIHNldHRpbmcgc2NhbGUuYW5kLmZyZXF1ZW5jeS4NCj4gPiBpdCBnZXR0aW5nIHdv
cnNlIGlmIGFkZCBtb3JlIGRpZmZlcmVudCBzZW5zb3IgdHlwZXMgaW50byB0aGUgZHJpdmVyLg0K
PiA+DQo+ID4gVGhlIGNvbW1pdCBhZGQgYW4gaW50ZXJmYWNlIGZvciBzZXQgYW5kIGdldCB0aGUg
b3BlcmF0aW9uIG1vZGVzLg0KPiA+IHRoZSBmb2xsb3dpbmcgaW50ZXJmYWNlcyBhZGRlZDoNCj4g
PiBpbl9hY2NlbF9vcF9tb2RlX2F2YWlsYWJsZQ0KPiA+IGluX29wX21vZGUNCj4gPg0KPiA+IFND
QTMzMDAgb3BlcmF0aW9uIG1vZGVzIHRhYmxlOg0KPiA+IHwgTW9kZSB8IEZ1bGwtc2NhbGUgfCBs
b3cgcGFzcyBmaWx0ZXIgZnJlcXVlbmN5IHwNCj4gPiB8IC0tLS0gfCAtLS0tLS0tLS0tIHwgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSB8DQo+ID4gfCAxICAgIHwgwrEgMyBnICAgICAgfCA3MCBI
eiAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiB8IDIgICAgfCDCsSA2IGcgICAgICB8IDcwIEh6
ICAgICAgICAgICAgICAgICAgICAgfA0KPiA+IHwgMyAgICB8IMKxIDEuNSBnICAgIHwgNzAgSHog
ICAgICAgICAgICAgICAgICAgICB8DQo+ID4gfCA0ICAgIHwgwrEgMS41IGcgICAgfCAxMCBIeiAg
ICAgICAgICAgICAgICAgICAgIHwNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExJIFFpbmd3dSA8
UWluZy13dS5MaUBsZWljYS1nZW9zeXN0ZW1zLmNvbS5jbj4NCj4gDQo+IFdoaWxlIGl0IG1heSBz
ZWVtIGNvbnZlbmllbnQgdG8gZXhwb3NlIHRoaXMgdG8gdXNlcnNwYWNlLCB0aGUgcmVhbGl0eSBp
cyB0aGF0DQo+IGdlbmVyaWMgdXNlcnNwYWNlIGhhcyBubyB3YXkgdG8ga25vdyBob3cgdG8gdXNl
IGl0Lg0KPiANCj4gVGhhdCBtYWtlcyBzdXBwbHlpbmcgdGhpcyBjb250cm9sIGEgYmFkIGlkZWEg
aG93ZXZlciBjb252ZW5pZW50IGl0IG1heSBzZWVtLg0KPiBJdCdzIG5vdCB1bnVzdWFsIHRvIGhh
dmUgdGhlc2Ugc29ydHMgb2YgY29uc3RyYWludHMgb24gZGV2aWNlcyBhbmQgc28gdGhlIEFCSQ0K
PiBhbHdheXMgYXNzdW1lcyBhbnkgc2V0dGluZyBtYXkgbW9kaWZ5IGFueSBvdGhlciBhbmQgLyBv
ciBjaGFuZ2Ugd2hhdCBpcw0KPiBhdmFpbGFibGUgZm9yIGEgZ2l2ZW4gc2V0dGluZy4NCj4gDQo+
IElmIHlvdSBuZWVkIGEgcGFydGljdWxhciBjb21iaW5hdGlvbiBmb3IgeW91ciBvd24gdXNlcnNw
YWNlLCB0aGVuIG1ha2UgdGhlDQo+IHVzZXJzcGFjZSBhd2FyZSBvZiB0aGUgY29uc3RyYWludHMg
cmF0aGVyIHRoYW4gZXhwb3NpbmcgaXQgYXMgYSAnbW9kZScgd2hpY2gNCj4gdGhlIHVzZXJzcGFj
ZSB3aWxsIG5lZWQgdG8ga25vdyBhYm91dCBhbnl3YXkuDQo+IA0KPiBKb25hdGhhbg0KDQpUaGFu
a3MgYSBsb3QgSm9uYXRoYW4sIEkgY291bGRuJ3QgYWdyZWUgd2l0aCB5b3UgbW9yZSwgdGhlIG1v
ZGUgaXMgbm90IGdvb2QgZm9yIHVzZXJzcGFjZSwNCkkgd291bGQgbGlrZSB0byBhc2sgeW91IGhv
dyB0byBoYW5kbGUgdGhpcy4NClNpbmNlIHRoZSBjaGFuZ2UgZm9yICdtb2RlJyB3YXMgYSBwcmVw
YXJlIGZvciBzdXBwb3J0IFNDTDMzMDAsDQpGb3IgU0NMMzMwMCwgbW9kZSAzIGFuZCBtb2RlIDQg
YXJlIHRvdGFsbHkgc2FtZSBmb3IgYm90aCBzY2FsZSBhbmQgZnJlcXVlbmN5Lg0KVGhlIG9ubHkg
ZGlmZmVyZW50IGlzIG1vZGUgNCBpcyBsb3cgbm9pc2UgbW9kZSwgYnV0IG5vIGRpZmZlcmVuY2Ug
ZnJvbSBzb2Z0d2FyZSBwb2ludCBvZiB2aWV3Lg0KVGhlbiBpdCdzIGltcG9zc2libGUgdG8gc2V0
IHRvIGJldHdlZW4gbW9kZSAzLzQsIGxldCdzIHNheSBub3JtYWwgbm9pc2UgYW5kIGxvdyBub2lz
ZSBtb2RlLCB3aXRoIGluZGV4IG9mIGZyZXF1ZW5jeSBhbmQgc2NhbGUuDQpTZXQgYmV0d2VlbiBt
b2RlIDMgYW5kIDQgaXMgbmVjZXNzYXJ5LCBJIGhhdmUgbm8gaWRlYSBob3cgdG8gaGFuZGxlIGl0
Lg0KDQp8IE1vZGUgICAgICAgICAgICAgfCBGdWxsLXNjYWxlICAgfCBmcmVxdWVuY3kgfA0KfCAt
LS0tLS0tLS0tLS0tLS0tLS0tICAgICAgfCAtLS0tLS0tLS0tLS0tLS0tLSB8IC0tLS0tLS0tLS0t
LS0gfA0KfCAxICAgICAgICAgICAgICAgICB8IMKxIDEuMiBnICAgICB8IDQwIEh6ICAgIHwNCnwg
MiAgICAgICAgICAgICAgICAgfCDCsSAyLjQgZyAgICAgfCA3MCBIeiAgICB8DQp8IDMgICAgICAg
ICAgICAgICAgIHwgwrEgMC42IGcgICAgIHwgMTAgSHogICAgfA0KfCA0IChMb3cgbm9pc2UgbW9k
ZSkgIHwgwrEgMC42IGcgICAgIHwgMTAgSHogICAgfCAgIA0KICAgICAgICAgICAgICAgDQpUaGUg
bGluayBvZiB0aGUgU0NMMzMwMCBkYXRhc2hlZXQ6DQpodHRwczovL3d3dy5tdXJhdGEuY29tLy0v
bWVkaWEvd2VicmVuZXdhbC9wcm9kdWN0cy9zZW5zb3IvcGRmL2RhdGFzaGVldC9kYXRhc2hlZXRf
c2NsMzMwMC1kMDEuYXNoeD9sYT1lbiZjdmlkPTIwMjEwMzE2MDYzNzE1MDAwMDAwDQoNCj4gDQo+
IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9hY2NlbC9zY2EzMzAwLmMgfCA1NQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDU1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hY2Nl
bC9zY2EzMzAwLmMgYi9kcml2ZXJzL2lpby9hY2NlbC9zY2EzMzAwLmMNCj4gPiBpbmRleCAwODNh
ZTJhNDdhZDkuLmUyNmIzMTc1YjNjNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hY2Nl
bC9zY2EzMzAwLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9hY2NlbC9zY2EzMzAwLmMNCj4gPiBA
QCAtNDIsNiArNDIsMzggQEANCj4gPiAgLyogRGV2aWNlIHJldHVybiBzdGF0dXMgYW5kIG1hc2sg
Ki8NCj4gPiAgI2RlZmluZSBTQ0EzMzAwX1ZBTFVFX1JTX0VSUk9SICAgICAgIDB4Mw0KPiA+ICAj
ZGVmaW5lIFNDQTMzMDBfTUFTS19SU19TVEFUVVMgICAgICAgR0VOTUFTSygxLCAwKQ0KPiA+ICtl
bnVtIHNjYTMzMDBfb3BfbW9kZV9pbmRleGVzIHsNCj4gPiArICAgICBPUF9NT0RfMSA9IDAsDQo+
ID4gKyAgICAgT1BfTU9EXzIsDQo+ID4gKyAgICAgT1BfTU9EXzMsDQo+ID4gKyAgICAgT1BfTU9E
XzQsDQo+ID4gKyAgICAgT1BfTU9EX0NOVA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNv
bnN0IGNoYXIgKiBjb25zdCBzY2EzMzAwX29wX21vZGVzW10gPSB7DQo+ID4gKyAgICAgW09QX01P
RF8xXSA9ICIxIiwNCj4gPiArICAgICBbT1BfTU9EXzJdID0gIjIiLA0KPiA+ICsgICAgIFtPUF9N
T0RfM10gPSAiMyIsDQo+ID4gKyAgICAgW09QX01PRF80XSA9ICI0Ig0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBzY2EzMzAwX2dldF9vcF9tb2RlKHN0cnVjdCBpaW9fZGV2ICppbmRp
b19kZXYsDQo+ID4gKyAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2hh
bik7IHN0YXRpYyBpbnQNCj4gPiArc2NhMzMwMF9zZXRfb3BfbW9kZShzdHJ1Y3QgaWlvX2RldiAq
aW5kaW9fZGV2LA0KPiA+ICsgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMg
KmNoYW4sIHVuc2lnbmVkIGludCBtb2RlKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgaWlvX2VudW0gc2NhMzMwMF9vcF9tb2RlX2VudW0gPSB7DQo+ID4gKyAgICAgLml0ZW1zID0g
c2NhMzMwMF9vcF9tb2RlcywNCj4gPiArICAgICAubnVtX2l0ZW1zID0gQVJSQVlfU0laRShzY2Ez
MzAwX29wX21vZGVzKSwNCj4gPiArICAgICAuZ2V0ID0gc2NhMzMwMF9nZXRfb3BfbW9kZSwNCj4g
PiArICAgICAuc2V0ID0gc2NhMzMwMF9zZXRfb3BfbW9kZSwNCj4gPiArfTsNCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlY19leHRfaW5mbyBzY2EzMzAwX2V4dF9p
bmZvW10gPSB7DQo+ID4gKyAgICAgSUlPX0VOVU0oIm9wX21vZGUiLCBJSU9fU0hBUkVEX0JZX0RJ
UiwNCj4gJnNjYTMzMDBfb3BfbW9kZV9lbnVtKSwNCj4gPiArICAgICBJSU9fRU5VTV9BVkFJTEFC
TEUoIm9wX21vZGUiLCAmc2NhMzMwMF9vcF9tb2RlX2VudW0pLA0KPiA+ICsgICAgIHsgfQ0KPiA+
ICt9Ow0KPiA+DQo+ID4gIGVudW0gc2NhMzMwMF9zY2FuX2luZGV4ZXMgew0KPiA+ICAgICAgIFND
QTMzMDBfQUNDX1ggPSAwLA0KPiA+IEBAIC03MCw2ICsxMDIsNyBAQCBlbnVtIHNjYTMzMDBfc2Nh
bl9pbmRleGVzIHsNCj4gPiAgICAgICAgICAgICAgIC5zdG9yYWdlYml0cyA9IDE2LA0KPiBcDQo+
ID4gICAgICAgICAgICAgICAuZW5kaWFubmVzcyA9IElJT19DUFUsDQo+IFwNCj4gPiAgICAgICB9
LA0KPiBcDQo+ID4gKyAgICAgLmV4dF9pbmZvID0gc2NhMzMwMF9leHRfaW5mbywNCj4gXA0KPiA+
ICB9DQo+ID4NCj4gPiAgI2RlZmluZSBTQ0EzMzAwX1RFTVBfQ0hBTk5FTChpbmRleCwgcmVnKQ0K
PiB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+IEBAIC00MDAsNiArNDMzLDI4IEBA
IHN0YXRpYyBpbnQgc2NhMzMwMF9yZWFkX2F2YWlsKHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19k
ZXYsDQo+ID4gICAgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBzY2EzMzAwX2dl
dF9vcF9tb2RlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gKyAgICAgICAgICAgICBj
b25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2hhbikgew0KPiA+ICsgICAgIGludCBtb2RlOw0K
PiA+ICsgICAgIGludCByZXQ7DQo+ID4gKyAgICAgc3RydWN0IHNjYTMzMDBfZGF0YSAqZGF0YSA9
IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKw0KPiA+ICsgICAgIHJldCA9IHNjYTMzMDBfcmVh
ZF9yZWcoZGF0YSwgU0NBMzMwMF9SRUdfTU9ERSwgJm1vZGUpOw0KPiA+ICsgICAgIGlmIChyZXQp
DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgIHJldHVybiBtb2RlOw0K
PiA+ICsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBzY2EzMzAwX3NldF9vcF9tb2Rl
KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gKyAgICAgICAgICAgICBjb25zdCBzdHJ1
Y3QgaWlvX2NoYW5fc3BlYyAqY2hhbiwgdW5zaWduZWQgaW50IG1vZGUpIHsNCj4gPiArICAgICBz
dHJ1Y3Qgc2NhMzMwMF9kYXRhICpkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiArDQo+
ID4gKyAgICAgcmV0dXJuIHNjYTMzMDBfd3JpdGVfcmVnKGRhdGEsIFNDQTMzMDBfUkVHX01PREUs
IG1vZGUpOyB9DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19pbmZvIHNjYTMz
MDBfaW5mbyA9IHsNCj4gPiAgICAgICAucmVhZF9yYXcgPSBzY2EzMzAwX3JlYWRfcmF3LA0KPiA+
ICAgICAgIC53cml0ZV9yYXcgPSBzY2EzMzAwX3dyaXRlX3JhdywNCg0K
