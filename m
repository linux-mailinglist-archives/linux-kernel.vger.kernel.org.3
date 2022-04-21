Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039FD50A74B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390874AbiDURnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390859AbiDURnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:43:22 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36D849696;
        Thu, 21 Apr 2022 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1650562832; x=1651167632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VwYhz9ZA/wWaNFbxBfmev/PGFzdSUXcKcuOU4CzOj8w=;
  b=VinrYcB0KkKIb//2IxZlgUX4e8eWMeqQrYri8O6NOKOS06ak6CucBDPo
   QymY7HVwzMuuIT//qhj44tCMTjz9Hxk70XPoJtZyEpt5r8169z1nva5gh
   5elZAXPWF+uDPoQmDfFmOssSNgX6QAaqwb1NI0fn8BHzABllY2u/j34z6
   g=;
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTTtE7gwiUJ61Rp1sCj0JoLZl6r5lEzGON8eyP5dHOpsIbLhLBAraZvzQ7LYeHvD7oJ9Rm7PILHuNZTUc7pjjaqMMtVT5akxmKXsnejQOYqflaKROItwPTcFvodj7WkUxi2oE6s9fRyBDdTyk00KHAo2sYGlw+nP0JngQON9U6DGFfrKJ3NkHAdwritt/1Y/mh9UoVsy0ixT0N+9bvIO/IK35aLSBXj7Ym1E41a5eOyjsmxyg+FuXxsUmtbYn+rKrPs8qUFlxT7uGgUyswPo1PJw6/x9qTuKJch2R1QlRB0m3cOhc4p11uj6xWc7qndQTg4W8KCiaJf3R0AkuiVL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwYhz9ZA/wWaNFbxBfmev/PGFzdSUXcKcuOU4CzOj8w=;
 b=HN1MfLUKtGe+H6fRF8k6pZ3IyeCUAMsReMq+KBTJGAz1Q7Esdhc3Auz7rtlvooGxXtWTayATCtxWQA3q2RnwHcv+UNskkT0Ahgh6Aamojor/eubsQvCdVrvyQ78jTV2aiDmiE4VeZUHIrcpAV+lnlIJ88177viVpjOfZE8KSW3pP//bjRD1Y5BSkP3O0k62WmfWRtzJk42KiaS/Bidi8QxGn+1PxUAGZ0Ej4phPKfRT2FrpG5Rv9eGMiFkPQicyaCdOz9pz+hnJevW5zbK2ItPAQf5eoyEDK/eWQqKa8pR1/hoWbrcy/8+G27g6rj65Rek0PsDb2Z1cR9vTsn2k8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8102.namprd02.prod.outlook.com (2603:10b6:8:1b::24) by
 CO6PR02MB8834.namprd02.prod.outlook.com (2603:10b6:303:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 17:40:28 +0000
Received: from DM8PR02MB8102.namprd02.prod.outlook.com
 ([fe80::b400:70ec:8e3a:b361]) by DM8PR02MB8102.namprd02.prod.outlook.com
 ([fe80::b400:70ec:8e3a:b361%8]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:40:28 +0000
From:   "Taniya Das (QUIC)" <quic_tdas@quicinc.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Taniya Das (QUIC)" <quic_tdas@quicinc.com>
CC:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: RE: [PATCH v3] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Thread-Topic: [PATCH v3] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Thread-Index: AQHYUQa0+EFzuij68UuZQWSkxZ5ZaKz6q1ng
Date:   Thu, 21 Apr 2022 17:40:28 +0000
Message-ID: <DM8PR02MB81025CD159F1B2158EAE979CF0F49@DM8PR02MB8102.namprd02.prod.outlook.com>
References: <20220202053207.14256-1-tdas@codeaurora.org>
 <CAE-0n52T9Z+LS3KMVeSBsad=Em3e27J=rEzHTB0WS-b5M=owFQ@mail.gmail.com>
In-Reply-To: <CAE-0n52T9Z+LS3KMVeSBsad=Em3e27J=rEzHTB0WS-b5M=owFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b476b0c8-fdd7-4fa7-15af-08da23be065a
x-ms-traffictypediagnostic: CO6PR02MB8834:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <CO6PR02MB8834032CDE781D8087F7C7A08CF49@CO6PR02MB8834.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52jrvvMDqHJRma6eg5l6qD6UipYj8K1XuCzjkXX6qWJoxULXYCZyVdrYnlbNhABpkcE0t+jkvsc80gNI+XdpJGvkS5QbXQgZXWBCox6CjiyTJiXb9OZGBGVgRcZ9ypA6Cdk2lEuj48f9Gph6hlK+nzihzpiYSYErJEd3+a/A898w3domuRce2+xSbYit7h/sU2qtvodSq95maDOO8Eojwx+VxhzYpdiK5umZRP5ENOnakU9uQaO1e80lzO7CjIY70lVdgFXkZVo/7ILIWwibmTwrkHkdyLJBvgS9owUI4Wrz9F5uJ9crKcj8RgdfjeYRXfVBqpT/r62GJ/tiENBlqp0YxnQgybIU5TnzIVoBCxbISPOrXOhE49QljU4GjTKwZTzswFjTuyUhkLBq+YFui8PJr9NwLZCiTcXBqY9Ud0Z4zC9Qd3t9357fzop3LE+UgrcTiL+yLTBYhK2amqH8g/QcBF7r1BwtL+LR4fkWHY5xIUodePlbxDzhoAHqQs/gcpPh6gFAEQsc/TrNxIHM3csFyR/q4S8Mlm7xxt+s6eNAqtTOooo66KcOCeJd4wPiapaI2zRCSiwXU0zsDsieGlu70qyFO/Ax9zcoZ/dTHT7CG3f1cdKP0pwFp1x43VygQVLftJYLOrYv7N1con7dQsfkqf2wxZB0gaHzw7ubr1FB3mv2fH9YwWHJpeRObGMY7vqeFtxsZ+q2FcbKdsqdDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8102.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66946007)(64756008)(54906003)(66446008)(66556008)(38070700005)(71200400001)(110136005)(122000001)(316002)(8676002)(4326008)(508600001)(9686003)(55016003)(2906002)(66476007)(76116006)(8936002)(86362001)(52536014)(26005)(53546011)(83380400001)(186003)(6506007)(5660300002)(7696005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXVqV0g5cy9Ua0dFaXZ4UXBoRHpUanNmWmtGOVU2OUltbGdmVkN6Q3pVMjh5?=
 =?utf-8?B?L3BwdCtubExjamxUS0wzWmZ5TVdFTUhWZmkrbE5GT2JtSXd6SEh5T2V5OHpH?=
 =?utf-8?B?d1VSdkd5STR2SkdEcitTL0dmdlJhQnRXU2plb3drRXJwdXFaTjNpdWpObFlP?=
 =?utf-8?B?QkNORWk2YU13UTYyVGYwOHYvYlJQcndaTzZzcTQrK2pEUW1kUDlQNWNXOGI3?=
 =?utf-8?B?NkpNb3RWSW10elJVYm9weDZJdW9PbllxNU5pbnVMWWFqWTBMUWtMVlVFOGZm?=
 =?utf-8?B?QW1sZk5EVFNXbTdhN01sUmE5NkZnZk5abGxZK1p2aDhpN3VwVHNOb1k2NFpC?=
 =?utf-8?B?WTEvN0psL1RVMURiZnl1VlBKQzJIWDlaMDRRd3dCcmZJeUdITjZFRG55Um11?=
 =?utf-8?B?eWZuOHJEL2FXLzdVZW9vMXlSTXVTUFZqMFErVk9QYUVSeHZiSGRJSU01bXRI?=
 =?utf-8?B?ano0Rm1jMUNRbnNtMGZKREtrQnhpRGJEQ1ZOTW81ZjlsdEVrUnZ0RFVYRmpi?=
 =?utf-8?B?MjJZTy9adGJHYjR4a0hhUy9SM2tzWFF3aFBYTnQ2Ym4wZmFWVUE3am81QWph?=
 =?utf-8?B?UWJVZnQ0di9QeWU4YklkcXBIdjdVY29Yb2VLanNrMlVZeERCRVU3NWlUUFhh?=
 =?utf-8?B?elV4WHBsNDlZd2Qwa25ld01QcUg4ekxvNWp3TlJlYlVrSHdqNSt2Ryt5L3hn?=
 =?utf-8?B?Y05CQTA3cWhERWRtQkNoakNNSTMyb2lBUkYzYzdVeG85YTRHVjdBN2xZcGE3?=
 =?utf-8?B?OG1kVmRyc0FpOEx3WnFQVHRGRThtdHRmSkRONi9sZ1JJcVJvUmdmOGtlMTF5?=
 =?utf-8?B?Qi9VdzZCZXBialpEN2sxeTJqSjhZcFNkeEd0b0NrNUdDT3NsZ0N5MWJtMFJ5?=
 =?utf-8?B?MVBCRmhFcW1OKzBPMGF6RjYwV2NnOWFiM0FXamk5elBWSmdLSlNDZE4zOGtt?=
 =?utf-8?B?aXcwZjR5MjVGeWVKZGV6UkNWUjVwaUEvRW1PbHYrMEpuMlRCeXpoR05rOXZs?=
 =?utf-8?B?YnRoZFZ5OGRUV3BBaXh1b2RVMVhoT2xkVkZxWTlZUnZFS2ljS003RWZNYUQ4?=
 =?utf-8?B?L3VyU0pqSjgxek9NUGZPejhTL2FaM3NHdEEwTUhCcHJiTlh4UXBxSkFZTkVt?=
 =?utf-8?B?L2tCOE5rTkdVNlhCRGJqeFZubGM0TVNzR3NLSlhIc2pvckdJaFVIbExTTEtp?=
 =?utf-8?B?YUR1dlprY1NpTGViUlhSZlFpQVB3ODhiNnJiTFdBZ0Z5YTc0UHFHSDBqUitB?=
 =?utf-8?B?eVJBUFdPa2hUTFJSSmxzbitZNUNXSDZOdEJOZzgzZHdrNmZwVGt4QlUzeEVG?=
 =?utf-8?B?SFZZT1M2WjIxa3p2REl4V1htaHVWTitxdFRjd3ZzSXF6YURsNTI2WEVBSEsv?=
 =?utf-8?B?K2xGaVp5ZUZud1pwYi9kMC9EUTZaam5UZHVKVHFZeEdPL0M4M2pkVjVDMzdt?=
 =?utf-8?B?TkpnckF1a1pIYXlzc1BacGRFTWVyalE1MFJGdXJlTFo1NU1FRnlydTVwa256?=
 =?utf-8?B?Y1JuNWZVRzRQRU9ENGZERUlGTXladkJmSjlYWGxWQ3RlN0VsZGxuWGFsOGo0?=
 =?utf-8?B?ODIxUW5VVVRPY0VqQms5YklsellCUEdhTlYzUWFHT1E3NlcxbnVGeTE5aG5o?=
 =?utf-8?B?N2p6YjJ4c1E3SVhzcGxyRkxCUzNOaStPdFRFb1VwVUVHcGdNazRmNVZmN3dL?=
 =?utf-8?B?NWdpdThxZXJwU0tYcmI2QXg5eXhWSmVwQ3FKN3IrOEcrVVBXTU1ZNzNzYmhh?=
 =?utf-8?B?Wld4Mlh1NzNWaVpBc3hXbmtadndyMU40VkNTcncyRFdpTklSNkRIZ2h2Q29v?=
 =?utf-8?B?TGxwYmp0TStEcWU2NmtTbGMrQjJQTHYyYldjVzEyejAvMVBEc3F6MHZseVJr?=
 =?utf-8?B?Z2lYRytJeWViZklIZXlEKzQ4VVUzVmZHK2kweUlXbGd4TzV1NDRPVndvamRX?=
 =?utf-8?B?Q2tzaVlmeFFQKzZpUFJ4eFE3bURvUHd2NFlMV0ZGbW5NcmdYYURBcnY1czlq?=
 =?utf-8?B?U0hFdVBTeWtnNVJrWXh1SElhdXhOM1E2Qm5MWlk2bytTN0JkbmcydEpvV1Fr?=
 =?utf-8?B?V3lrNVB4K0xkMERoTUxmdlZWQzJUVjBIUHUvT284MzVVLzArUmtBdTJEcm9X?=
 =?utf-8?B?UHNibFpDS0UwWlE0ZEszZFU4b1BMTGFNQnpwbFkwVUh1UW15L0Y0Z3kwOUNs?=
 =?utf-8?B?S09iQnI3WndiMS9HeGtCdGphdjliU1BTMkNLTzg3VENjMUVOOHdzUWZqclE3?=
 =?utf-8?B?eHZLT09LNFR4QWo3TTVxdHBkVHBpVkYxUU8wYzExMy9XWmg5dWEyZUQyREJo?=
 =?utf-8?B?aXBRNCtnbFp4VGs1SENvK2hZcHMzdnR1R3Q4UlBkVWpjOUZrNnE0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8102.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b476b0c8-fdd7-4fa7-15af-08da23be065a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 17:40:28.3671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoVazgiZrDTHHdAI2IM9H57fC5u42eI3FVbq1tK4Jg55od7OQ6dCJtsJy44j8xeiXOKsctEBrRDT3Znqqc2A9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8834
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNClRoYW5rcyAmIFJlZ2FyZHMsDQpUYW5peWEgRGFzLg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogU3RlcGhlbiBCb3lkIDxzd2JveWRAY2hyb21pdW0ub3JnPiANClNlbnQ6
IFNhdHVyZGF5LCBBcHJpbCAxNiwgMjAyMiAxOjU0IEFNDQpUbzogYmpvcm4uYW5kZXJzc29uQGxp
bmFyby5vcmc7IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBUYW5peWEgRGFzIChR
VUlDKSA8cXVpY190ZGFzQHF1aWNpbmMuY29tPg0KQ2M6IERvdWdsYXMgQW5kZXJzb24gPGRpYW5k
ZXJzQGNocm9taXVtLm9yZz47IEFuZHkgR3Jvc3MgPGFncm9zc0BrZXJuZWwub3JnPjsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYW5peWEgRGFzIDx0ZGFzQGNvZGVhdXJvcmEub3Jn
Pg0KU3ViamVjdDogUmU6IFtQQVRDSCB2M10gYXJtNjQ6IGR0czogcWNvbTogc2M3MjgwOiBBZGQg
bHBhc3Njb3JlICYgbHBhc3NhdWRpbyBjbG9jayBjb250cm9sbGVycw0KDQpRdW90aW5nIFRhbml5
YSBEYXMgKDIwMjItMDItMDEgMjE6MzI6MDcpDQo+IEFkZCB0aGUgbG93IHBhc3MgYXVkaW8gY2xv
Y2sgY29udHJvbGxlciBkZXZpY2Ugbm9kZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFRhbml5YSBE
YXMgPHRkYXNAY29kZWF1cm9yYS5vcmc+DQo+IC0tLQ0KPiAgKiBGaXggdW53YW50ZWQgZXh0cmEg
c3BhY2VzIGluIHJlZyBwcm9wZXJ0eS4NCj4gICogRml4IGxwYXNzX2FvbiBub2RlIGNsb2NrIHBo
YW5kbGUgPCZscGFzc2NjPiB0byA8JmxwYXNzY29yZT4NCj4NCj4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvcWNvbS9zYzcyODAuZHRzaSB8IDQzIA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC5kdHNpIA0KPiBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcWNvbS9zYzcyODAuZHRzaQ0KPiBpbmRleCA5MzdjMmUwZTkzZWIuLjBkOGEwZDlkMGY4
OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC5kdHNpDQo+
ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zYzcyODAuZHRzaQ0KPiBAQCAtMTc0NCw2
ICsxNzQ2LDQ3IEBADQo+ICAgICAgICAgICAgICAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwx
PjsNCj4gICAgICAgICAgICAgICAgIH07DQo+DQo+ICsgICAgICAgICAgICAgICBscGFzc19hdWRp
b2NjOiBjbG9jay1jb250cm9sbGVyQDMzMDAwMDAgew0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gInFjb20sc2M3MjgwLWxwYXNzYXVkaW9jYyI7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHJlZyA9IDwwIDB4MDMzMDAwMDAgMCAweDMwMDAwPjsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgY2xvY2tzID0gPCZycG1oY2MgUlBNSF9DWE9fQ0xLPiwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDwmbHBhc3NfYW9uIExQQVNTX0FPTl9DQ19NQUlOX1JD
R19DTEtfU1JDPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiYmlf
dGN4byIsICJscGFzc19hb25fY2NfbWFpbl9yY2dfY2xrX3NyYyI7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8JmxwYXNzX2FvbiBMUEFTU19BT05fQ0NfTFBBU1Nf
QVVESU9fSE1fR0RTQz47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICNjbG9jay1jZWxscyA9
IDwxPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwx
PjsNCj4gKyAgICAgICAgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGxwYXNzX2Fv
bjogY2xvY2stY29udHJvbGxlckAzMzgwMDAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJxY29tLHNjNzI4MC1scGFzc2FvbmNjIjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDAgMHgwMzM4MDAwMCAwIDB4MzAwMDA+Ow0KDQpJIHNlZSB0aGF0IHRo
aXMgcmVnaW9uIG92ZXJsYXBzIHdpdGggdGhlIHRoaXJkIHJlZ2lvbiBvZiBscGFzc2NjQDMwMDAw
MDAgaW4gdGhpcyBmaWxlLiBUaGF0IG1lYW5zIHRoZSBkcml2ZXIgZm9yIHRoaXMgY2xrIGNvbnRy
b2xsZXIgZG9lc24ndCBwcm9iZS4gSSBkb24ndCBrbm93IHdoYXQgdGhlIGNvcnJlY3QgZml4IGlz
LCBidXQgaXQncyBlaXRoZXIgcmVtb3ZlIHRoaXMgbm9kZSBhbmQgbW92ZSB0aGUgZHJpdmVyIGNv
bnRlbnRzIHRvIGxwYXNzY2Mgb3IgcmVtb3ZlIHRoZSByZWdpb24gZnJvbSBscGFzc2NjIGFuZCBw
cm92aWRlIHRob3NlIGNsa3MgZnJvbSB0aGlzIG5vZGUuDQpbVGFuaXlhIERhc10gU3VyZSwgSSBj
YW4gcmVtb3ZlIHRoZSBub2RlIHdoaWNoIHNob3VsZCBiZSB0aGUgY2xlYW5lciB3YXkuDQoNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZycG1oY2MgUlBNSF9DWE9fQ0xLPiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmcnBtaGNjIFJQTUhfQ1hPX0NMS19B
PiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmbHBhc3Njb3JlIExQQVNTX0NP
UkVfQ0NfQ09SRV9DTEs+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9
ICJiaV90Y3hvIiwgImJpX3RjeG9fYW8iLCANCj4gKyAiaWZhY2UiOw0K
