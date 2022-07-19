Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F857963B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiGSJWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiGSJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:22:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52C92714E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoeEaUO6Yu7Wkd0mqA34mqBP0FbYo5Isg8SvGO1jHrC4+dHqvzXdYGRhPCSSrpjjTQjuWX6HsJrnnCfyJPDxPFQW4cCEimjkNEdpRJHbSTfRrHW3A6A9g/noNKGMA49hhA+C8FS9xeifeXeP5dOo6uQQbgPJi2fcgMVUHvXiv4IQCzsgIv+Y7MYldBB1lFMIBSDiVkQyH6D1Rmqgq0hZ9SkXlWKHuz5sBZXx5LY5YCrxPthJnow0nH7NHyIumfYxYfMKXbqQdiO9wgcrYbRP9KVhXR1Y5hhOH16Bo9N3VVisfzsfWA1vhnl4WIRsaiRqOI7gvaMZPKFaSQ5M+Sd1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyOP6K3vAY+GLg6fEKk7MP1pwciIyyyq6KnOaqETOiE=;
 b=PGq2q4q0G+9NmcnSoLUpHRxDOmAFZz+mym+120ZOisDrCvoBnQ3AJ9Wb4T8Nyyj76Pkrj3xVGDs2IuFZ9PsJP/GEJ7MEBt89ClfdSzSkeCYoXLAQgRvXHXrtXnsA5eYklvp46uVzOzXIVT1S/HCe1xHpzD3b/C1gsr9wBSBBK097LQ81XtS3kwfjP7kEpw1SyZinbXxk8zPv8VDD8fqbQJhycYqkXUoAOJmZW3MLBD3tG7OlAN1dfKvqPQKhzu9DGm1VxXL4xoXqYMLKniZ/0JYQkkDZaoL3GIjEGx2qUbPg8JomAc+Ot+VZK3RbjMJaVkC19Qf0lWqPeDu5YvPnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyOP6K3vAY+GLg6fEKk7MP1pwciIyyyq6KnOaqETOiE=;
 b=JwFScbfWosCj/7+xYCZSUTQzZs3aP6N6QAhD4f1fLa4/bIvGVVH0P6uxtcxaMkKziY1mg59SLDT8Mld5YqvYRbczCbjF/lH3Pri3NxEjNnatUbWkTqLufASnH+AFYcYylG1ofuAavOyY1ZrzQlBV33fHFfx6f1vgiZPaaUtU56M=
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17)
 by TYAPR01MB5674.jpnprd01.prod.outlook.com (2603:1096:404:8054::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 09:21:57 +0000
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05]) by OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:21:57 +0000
From:   DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
To:     Benjamin Bara <bbara93@gmail.com>,
        DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
CC:     "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
Subject: RE: [PATCH] regulator: da9063: disable unused voltage monitors
Thread-Topic: [PATCH] regulator: da9063: disable unused voltage monitors
Thread-Index: AQHYlrdCq5lz15FMVUKTHjEqq/kPea19nLfQgACh+ACABzVPcA==
Date:   Tue, 19 Jul 2022 09:21:57 +0000
Message-ID: <OSAPR01MB50608227855EC6ABEA3A2CCAB08F9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
References: <20220713124958.3094505-1-bbara93@gmail.com>
 <OSAPR01MB50602133D5009DFE59C93458B0889@OSAPR01MB5060.jpnprd01.prod.outlook.com>
 <CAJpcXm5t0bd9McYAipKVVc=_N0ddvxLQVbZuX9LUysmn3ivzKw@mail.gmail.com>
In-Reply-To: <CAJpcXm5t0bd9McYAipKVVc=_N0ddvxLQVbZuX9LUysmn3ivzKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e54b49df-c70a-406c-36cf-08da696820a1
x-ms-traffictypediagnostic: TYAPR01MB5674:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Y0dgcWgkf+tonqAVjzhE1jIVmi0CoxIukbjxSNFRqqEqoE3hglRDB2lFhY923A/j1xH4ubC34umFFZrZOzGCnhEZ0E9PKW6Kh8ttFXdR9wLFvK7jIYwSktTZCCECi+Ay3WTfOrgYl8oiw6yWeH3q/XR1LtQ3MjTJTGHEyOnVr1dTJcy4oboicpzgBPWL+PoLT2SFwf/T+1jOnGt53wwW5EUdRVNS+pu+lYgyFOuOMNpQR3XRW8DWgWZxJReMwIH4+uYhkaTuSB+nUP0sazqh6Mq7998ivD6FIjE/dIaa5eq4ihf2lP+6sB2EPCj255hMpGZ2K3XUtGuzpyK7n2kflA07okcmF8ZjFduE+p8Rzx9pzdaJ5FQgBHTgzZ1M5ACOtPmXgVlwm9erY20oS0RNZHQ5V/WG7N6fRPUU8ueJcDML6EoiD4QOGok9n71Zzd/mqH7E7x8IS+C+/U9JaSPwEnJRw9WEeZVQxpyB7/EM8FPDDGVSqMJqNRthnwjM27vuo6VxRNjXNlrAnDFkNI5K9zUmS7shPYPcnxkl4bH7g6KsNorbQMC5sfHO4UMZeiHzYbqN1uoNytaI+UIrGQTGyJNUi5uFvgrP4TNVwcWNOayjZATlB09GDAGQaGHWs9bUuSDfg63liIQF0mxaoCOpngWzOLXiEO+s5Ts6fvQ5Ui4GotVZCPbUPQ7SZOuP2C7+lZPjkQ3DrwmeuJ//QxIwAazVKbmkyZrncKdNGQTFjAPyj2smVJj0zABZ1uxru21nEddf6tqgMz/cIurkC7DruIf5yquQYWNoPsk6ZsiN6JG2KYJ8Y1cFqOBnQQ75dYu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB5060.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(86362001)(122000001)(41300700001)(9686003)(110136005)(316002)(54906003)(6506007)(7696005)(71200400001)(2906002)(38070700005)(26005)(33656002)(5660300002)(52536014)(66946007)(64756008)(38100700002)(55016003)(4326008)(66476007)(8676002)(66446008)(83380400001)(478600001)(8936002)(66556008)(53546011)(186003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjVLOUhVaWJzbS9zZkluVHQ3cWlJTU5OeHhzUXhsall3Rjd5bXpwbExUM2d1?=
 =?utf-8?B?eE8yODVmRUEwSGpkWUI4UlpiS1FEeXhsVjZPNHJIM0h4UW04eXNqZ1BpODNL?=
 =?utf-8?B?WjdvSVFIMG90Y3dsTGNpQkhUVW45b3hjYW9uR1dSZ0E4WGk2Vjd3bHhoUFZQ?=
 =?utf-8?B?Um5QbXU0ZHIzdXFDWTVNOVozZWpSTW5IM2t2UnRWOVQzL3I0U04xQ1RFd0ly?=
 =?utf-8?B?YjMzYWRjbmxUckQ1NTNnSFphd2p3SDVmQkx1V2hzakxNUmhDZCtIcUR3d2kw?=
 =?utf-8?B?aTNzVDRCNmI1WEJ0N3RiSmQrOUU0dEo5U1hCeWlwWFliOEl2WjRhT0RBQzdk?=
 =?utf-8?B?NzFkREVyL1FpZGtnSmc4cGttSWNnQ3NpY21pdDZWam9LNCsvZEVXeEt5ZjVZ?=
 =?utf-8?B?OUd6anlRNGZNenAxWWdZZVVRQXZsbE1PdENXcG5sQmszc3FnK0pyUXRjN0V2?=
 =?utf-8?B?c3Era2w3R05BLzVWc3NibFNHOXZQZHoreXlKUHZDYU1lc0dnWEJaTlA0ZkJE?=
 =?utf-8?B?U1FoRUFmcUlzaC9NWTFxRlJxZFN1ZzZYN29uU0NLOGlIYlgxU3E1L3RHMCsv?=
 =?utf-8?B?UHMzZzIwdDA3T1k1SjFGdmlxTEJJNW9kcm55OGpqQXFKbjJBcUNzVW5HVElt?=
 =?utf-8?B?TFVzd0RuR2drdG9yQkRNUmdsVEZRODdlQUFIcTUxSVdjYWxXSXhjU2FqN21Z?=
 =?utf-8?B?VkVIU2FjQ0p3M1FPSjdZK0VqajRNOUV3VUUwelloNlZtSjQzZFNWeFdtdVVh?=
 =?utf-8?B?TmVVWVErMG5iVis1QytsVkltVnQyc3h4TE1VYW5lcml4Q2Jpby9mdTVydlQ1?=
 =?utf-8?B?OGFRbXBOc1E4bDBIaHp2VSsvNjgzYmZVanJITWlhY0RHcnF4alpKSy9ydHRN?=
 =?utf-8?B?YkxkeWRyVHRqa0JDOG1ZWHlVQmdkQmFwanRLZCtWcXl1c2NOcldMSkg5Z3lH?=
 =?utf-8?B?TFNRazkzUFBvZ1VwZXhXdkdiRnRRc1lVbVFYKzNIdU1SMXdQTStSZHJvWTlt?=
 =?utf-8?B?dTBDc1JyNnhYTWhicm9xcDN1bHg2QXFENUZVK0ZKK2xvQUVldDQvRXpSanpQ?=
 =?utf-8?B?VFcyRWNScTJJWDFtQ25hMkpsdFR4WENoblNJRWhsN1IvQ1Uva2ZibmF4QURk?=
 =?utf-8?B?M2VXQXFra0UzVjZ5NTJTN2l6QzBZVlU5VkFHMU93YUZHblNQd21EVXBWdWlI?=
 =?utf-8?B?MlNsalZjZWVPR0dNaEladG5pNDg1SXpMdWV1dDNsMGpOcWRCcWZGQlFjdGhO?=
 =?utf-8?B?ZFBTbE9iWTFIa3VFQ1NxTE85WUNwa1BoUnVDYmdGamRjRjlpRlU0dVFKVm5m?=
 =?utf-8?B?TTFqb3h6UjZJc2RBZzFmWjUyYWxLcWFzMzlON1RwMnFRWms0OVB5c1BaNVQr?=
 =?utf-8?B?dng2WnN4VHEyeG1DQ200WEt6VlJ3SHRvY2s3VDJ2bkVCZWpKMlMybFFKQW11?=
 =?utf-8?B?TmRzSSsxSDdVcHgyZXdxYmd5VGI5ejdqUGQxaWpEZ0cvVXArbGdqQ3JSN1o2?=
 =?utf-8?B?WEhMVGU2dGFsMEZTS3QxTXpycWRna3greVJLanA2NDdXb0pnL2lER1R5OEQx?=
 =?utf-8?B?bGZtSzVCZVo1KytaZGplcE1lQUhCQk5GenhNcGlyTnpaT2s4Q1lVSnFpRE9i?=
 =?utf-8?B?YUlCbkJkaE9adUc3UGZWSHZPeHFQdmEyWVEwTFoxSEVWT05xM3NncHNEN2Zq?=
 =?utf-8?B?alhydmN2bFRZVCtpMzhrczFHcjdOMHR6VG56RnZleUxsdzNybUtockVWNzBN?=
 =?utf-8?B?S29YNU92ZUVTVjlKbmRQa090OU94QU5TbzNiQ2ZoSWFoOTROTDV0eldiMmRt?=
 =?utf-8?B?bUI1QkRMZWZ4UDU4RE1pR0RxTVNBMGJjeGNiTkdUc1BrVTR6dy9SbDRNVVBr?=
 =?utf-8?B?MHppQm9qZVgvN3V4S2EyOWJMS21xUStPeDIvdUZwaWxZd202OEhsVCtWV3NJ?=
 =?utf-8?B?bndhU1c3VUVxd3hldUlrRnNJQXpwTXorRGlkZk5QYUFydEkwUHRiRllGVDdD?=
 =?utf-8?B?Y2MxR0E4MGpEWnNueTdYNENUdlIwNU1OU3hPZDIyYlZKRW1sUXhrQnZpYm9P?=
 =?utf-8?B?RDlQZTZpaEs0ZUJqNGJKbmRnOEJFTTBQUm9kdVJ2SDlRL1JjUHl1dklRK0VJ?=
 =?utf-8?B?aDZiSnNWK3FjcWg0cVIwMUlPUFVYM2VGMzA0Sm1aZTdEVW5NTTJzbUFMZ0lK?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB5060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54b49df-c70a-406c-36cf-08da696820a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 09:21:57.1141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INV5014saztOrUBV2h6MgUb2rHS5A0MhASKzVPo7jOcE1t6Wkt7p9sNucKZJHjQagvRun6EL9FnQnEa9xPb0/yK5oARmgGMUaax4lURkMv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5674
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQgSnVseSAyMDIyIDIwOjE1LCBCZW5qYW1pbiBCYXJhIHdyb3RlOg0KDQo+IEkgaGF2ZSBz
b21lIHVzZSBjYXNlcyB3aGVyZSBjZXJ0YWluIG1vZHVsZXMgKGUuZy4gYXVkaW8pIGFyZSBub3Qg
cmVxdWlyZWQuDQo+IFRoZXJlZm9yZSwgSSBoYXZlIHJlbW92ZWQgYSBjb3VwbGUgb2YgImFsd2F5
cy1vbiIgZnJvbSBteSBEVCB0byBsZXQgdGhlIGtlcm5lbA0KPiBkZWNpZGUgaWYgdGhlIHJlZ3Vs
YXRvcnMgYXJlIG5lZWRlZC4NCj4gU2luY2UgdW5mb3J0dW5hdGVseSBzb21lIG9mIHRoZSBsYXRl
ciBkaXNhYmxlZCBMRE9zIGFyZSBtb25pdG9yZWQsIHRoZSBzdGF0ZQ0KPiBiZWNvbWVzIGludmFs
aWQuDQoNCk9rLCB1bmRlcnN0b29kLg0KDQo+IEkgYW0gYXdhcmUgdGhhdCB0aGUgcGF0Y2ggaXMg
bm90IGNvbXBsZXRlIHRvIGhhbmRsZSB0aGUgd2hvbGUgdm9sdGFnZQ0KPiBtb25pdG9yaW5nIG9m
IHRoZSBkYTkwNjMuDQo+IFNvIGlmIHdhbnRlZCwgSSBjYW4gZXh0ZW5kIHRoZSBwYXRjaCB0byBz
dG9yZSB0aGUgdm1vbiBzdGF0ZSB3aGVuIGRpc2FibGluZw0KPiBpdCBhbmQgcmVzdG9yZSBpdCBk
dXJpbmcgdGhlIHJlLWVuYWJsZSBwcm9jZXNzIChjYW4gYWxzbyB0YWtlIGEgbG9vayBmb3IgdGhl
DQo+IGhhbmRsaW5nIHdoaWxlIHNsZWVwL3N1c3BlbmQpLg0KDQpUaGUgcHJvYmxlbSBpcyB5b3Vy
IGZpeCBpc24ndCByZWFsbHkgYSBmaXguIElmIHRoZSBMRE8geW91J3JlIGRpc2FibGluZyBpcyB0
aGUNCmxhc3QgbW9uaXRvcmVkIExETywgYW5kIHlvdSB0dXJuIG9mZiBtb25pdG9yaW5nIGZvciB0
aGF0IExETywgeW91ciBHUF9GQjIgbGluZQ0Kd2lsbCBubyBsb25nZXIgYmUgYXNzZXJ0ZWQgc28g
eW91IHN0aWxsIGhhdmUgYSBwcm9ibGVtLiBJIGd1ZXNzIG9uZSBzb2x1dGlvbg0KbWlnaHQgYmUg
dG8gZW5hYmxlIG1vbml0b3JpbmcgZm9yIHJhaWxzIHlvdSBrbm93IHdpbGwgYWx3YXlzIGJlIHBy
ZXNlbnQgaW4geW91cg0Kc3lzdGVtIGFuZCBkaXNhYmxlIG1vbml0b3JpbmcgZm9yIHRoZSBvbmVz
IHlvdSBrbm93IHdpbGwgYmUgZHluYW1pY2FsbHkNCmRpc2FibGVkL2VuYWJsZWQuIE9ubHkgcHJv
YmxlbSBoZXJlIGlzIG1ha2luZyBzdXJlIHRoYXQgb3JkZXJpbmcgaXMgcmlnaHQgc28NCnlvdSBk
b24ndCBnZXQgdG8gYSBwb2ludCB3aGVyZSBhbGwgcmFpbCBtb25pdG9yaW5nIGlzIGRpc2FibGVk
IHdoaWxzdA0KZW5hYmxpbmcvZGlzYWJsaW5nIG1vbml0b3Jpbmcgb2YgdGhlIHNwZWNpZmllZCBy
YWlscy4gSUlSQyB0aGUgb3JkZXJpbmcgaW4gRFQNCmlzIHByZXNldmVkIGluIHRlcm1zIG9mIGhh
bmRsaW5nIHRob3VnaCBzbyB0aGlzIG1pZ2h0IGJlIHRyaXZpYWwuDQoNCj4NCj4gYmVzdCByZWdh
cmRzICYgdGhhbmtzIGFnYWluLA0KPiBiYg0KPg0KPiBQLlMuDQo+IEkgY2hlY2tlZCBpZiB0aGVy
ZSBpcyBzb21lIGV4aXN0aW5nIGtpbmQgb2YgZnJhbWV3b3JrIGZvciB2b2x0YWdlDQo+IG1vbml0
b3Jpbmcgb2YgcmVndWxhdG9ycywgYnV0IEkgY291bGRuJ3QgZmluZCBzb21ldGhpbmcgc28gZmFy
Lg0KPiBJIGNhbiBpbWFnaW5lIGl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSBhIERUIHByb3Bl
cnR5IGZvcg0KPiAicmVndWxhdG9yLW1vbml0b3Itdm9sdGFnZS1vbi8tb2ZmIiB0byBvdmVycmlk
ZSB0aGUgT1RQIHNldHRpbmdzIHZpYSBEVCwNCj4gYnV0IEkgYW0gbm90IHN1cmUgaWYgdGhpcyBp
cyBzb21ldGhpbmcgdGhhdCBpcyBuZWVkZWQvd2FudGVkL3JlcXVpcmVkLg0KDQpJbml0aWFsbHkg
SSB3YXMgdGhpbmtpbmcgdGhhdCBod21vbi9JSU8gbWlnaHQgYmUgdGhlIHBsYWNlIHRvIHN1cHBv
cnQgc29tZXRoaW5nDQpsaWtlIHRoaXMgYnV0IGxvb2tpbmcgZnVydGhlciBJJ20gbm90IHN1cmUg
dGhhdCB3b3VsZCB3b3JrLiBJbiB0aGUgYWJzZW5jZSBvZg0KYW4gb2J2aW91cyBwbGFjZSwgZGV2
aWNlIHNwZWNpZmljIERUIGJpbmRpbmdzIG1pZ2h0IGJlIHRoZSBiZXN0IGFwcHJvYWNoLCB0bw0K
c3BlY2lmeSBmb3IgZWFjaCByYWlsIGlmIGl0J3MgbW9uaXRvcmVkIG9yIG5vdC4gSWYgeW91IGRp
ZCB0YWtlIHRoYXQgYXBwcm9hY2gNCnlvdSB3b3VsZCBuZWVkIHRvIG1ha2Ugc3VyZSBpdCBkb2Vz
bid0IGltcGFjdCBleGlzdGluZyB1c2VycyBzbyB0aGUgYmluZGluZw0KKmNvdWxkbid0KiBzaW1w
bHkgYmUgYSBib29sZWFuIGZsYWcuDQo=
