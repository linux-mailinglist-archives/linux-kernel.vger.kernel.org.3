Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDBC4CA879
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbiCBOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCBOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:48:09 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B085F7B;
        Wed,  2 Mar 2022 06:47:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6S8D9bcF/uiPl+jCU/iM9dRcInNZbUfdvR2/BRW2O9DtLZ/fRXXsHe8XcsjNEpjXtMnxJLdArR/aY/VuBiWsCBcUCqDiyPibjniIwV9KwHNtqdbL8wt3x05biGtpqTue5xK+wQ5otQOTOL6AsoHkZBDpxK9zNRAf2+tuaZXibfhaRDFPPwblHqQHb52jFlLrfXC7//OPWb4NYK+FN+ft6YyApv0RypNEgAlJ2EdpLqLIQjjXQtl0c0MSYczzmFV0OvIzSQU4hhbjxxalXWMeuZoZ8hnKPzIXAC2LNrPhdvZyfPJUxmu+0gZ7OTJ4UZv2yT46PM8RLMhViEbu/0gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om3ZI6fnqgsD+QxRNUPzoLhNEGvEbBq2qfX2uUkhObk=;
 b=O+Q6vV/mqh9oOE9kJq+ZHsNoY9m3E8ge3eJHieeQlwyLDb3/czG33M23+ym6cSf2D/lT4krClZOMtEGenuJF9PAEHx8VWNk2qgYG6b9JJB0wLxR99bihMymVe947Osrw0TpgceTHcVdA4v2WBqsOs3ojVDRUmPaDZQ0RJtE5kKXUiAF/frlYsMTPFJ+VKbosh9d0PMMm5Hj59yYD76L7gYxKS7RoAcbGZgNzKBhawH5p5yWRc3lJsUqHcaLKpYF1oy1Mg/FtrOvUy9Cceg5KzxNhMD1P17OrjvHfFIpZXIjY7+mYUi3g5tWsgKtaZ5heTzFrzUY9SkmPlIJ+ce+U5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om3ZI6fnqgsD+QxRNUPzoLhNEGvEbBq2qfX2uUkhObk=;
 b=PEGT1pdDoS0EqU2sT2giqE8w3uaLdSulNvc+ix9tVUm6bDc7kGBm8HIpYgqqVrxiiTJYwrsSNAhsH3lLHmD9Upc6fUFDRvHx/DV/KHGtlvRMjgytTGzHUg6E8vmY9dgp37Qtxf9ZadFK+M9czmjrI3BVUfMpKMTFRt23istdScVSXGJ6Xr4uvJP4lX61g9mwPrX1Usn/rDeYBDx77z+Wu5Agl9+18AUb98uKXZTpBQUn6i7C+2UDtCHzaQ7QQebT6Z50g8s5WUCZbwfrIqVhbeO+UyVRu+FlIpq1tgyJ7YDSottSXqLbOvtcTMFbeMPgIl/eDX7FwpKRytapjsri7w==
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:98::12) by DB8PR10MB3740.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 14:47:20 +0000
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f909:2310:3487:4150]) by AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f909:2310:3487:4150%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 14:47:20 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/1] tty: n_gsm: improve standard compliance and feature
 completeness
Thread-Topic: [RFC 1/1] tty: n_gsm: improve standard compliance and feature
 completeness
Thread-Index: AdgqRLP0Ru7aD6U7TgaTrJ/9eV0Tog==
Date:   Wed, 2 Mar 2022 14:47:20 +0000
Message-ID: <AM4PR1001MB13789D432A1DB69A1B35B0A6E0039@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-03-02T14:47:17Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=48f1dd68-5ba1-4848-aff6-636d870d18fb;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 513e5183-9b7a-4524-9fdc-08d9fc5b8de0
x-ms-traffictypediagnostic: DB8PR10MB3740:EE_
x-microsoft-antispam-prvs: <DB8PR10MB3740532A408D4847B7B421C2E0039@DB8PR10MB3740.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pE7e/kiwdBtpdcueMu7Z0purgBaDBlKZo0IVdomb8SWqqBV6qDgNhGAo8Kp92xU6Vpf+TPvR7oh0GoHFKe+bDZZ10MdiEvDgFpldHDUYUet8rEKflADatXnxiuFgWSh/T3LVj1ktPG2glNujFdDkPQf6inq4dgvzZdllmyLRC8jtAf61MFvn3HFxsch8K8k18eD5zt4meAeSVyJTkSMvJklvyTEev8OmIjVhFIrYtrPJnopU06wUVG3fUfSY2Ar9PIJGHDHjWBN8mFUMp1aAI6i/hn6KMwBvVnVZo9l+uW7ur6DNtQat1CemSHJQ3Gskt+Iu9Yh9CpdUy684FfV0hMDBmJwW6DUMQOGAL7JgOJ4oT97tboQ5Z2m7bVOHCAgUOAIXKRDt3XjXCTHS90X5cFeZl18GgqhFfl8a2yb/KW49I7Nfx8JU9IR9ttqvadDIbAnpAaRsBfJ2QaaZpIAFtwAws9eZQK06TJ3Lvb3UXAgdH5nNZVpnlQTJ52a3uhL/g4dExFt7g3aXH2yFcDcix/yxiS/PwBUftuQe+JCO+ncC2FVbkBmoJ/JAjq0Je+8HZTEKK17tZtJTydwpBY3fNINTzcYIcG1I1zEsf6dQ7cbFgWZOd97A9D/55LFM15JkgALQCu0Ax1mYzdSzMh+x4k9fuXcXfgiykh4WVxAkYdLEeXU0W9fD4erfhXUu+n/J1FVBxdK6KEQhYA6VhAl7j0h46MfWQ9PBcoQqCzLcvtukKOl84G/UuD64DpzdNgcS4BB60+k3W6BADZt6c8wpMI72ok4Z5SyqcMBab64L50E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(86362001)(122000001)(55016003)(55236004)(2906002)(83380400001)(38100700002)(82960400001)(316002)(71200400001)(508600001)(54906003)(38070700005)(8936002)(186003)(6916009)(26005)(4326008)(5660300002)(76116006)(52536014)(64756008)(6506007)(8676002)(33656002)(9686003)(66946007)(7696005)(66556008)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXJZZHM4SjFFZFpQbElTNGljbjY4MEtUMnRWSDFlelJqRjYxWmRIdWM0bFVH?=
 =?utf-8?B?VDg3ZGdjbko0T3NQNFJNNzlDT05DUU0renhidGhZUFBsM2lVbTQ2Z01ldHlU?=
 =?utf-8?B?THo0dEYwdGVLdDE1cmtTb0JsL1pEOXZwUFdqd0xmaTNMcGgvL2FXZkJBWG52?=
 =?utf-8?B?WThVVzdDeGdFb2ZXRGNZRCtNcDZOd1Y0SENtbHFSRTM5UjFFdlpmeFRuc0xt?=
 =?utf-8?B?eWkyMlVFaXVSV09UQ0YxV0d6K0lNaERDWEtIV28vam9yWk93eituSEUzbUdR?=
 =?utf-8?B?eTZaVGdKMzVqd1ZSTkVqNTVGanJONHc3TzQ4UGhLU1hTNGRvbGNqVEJseXJ1?=
 =?utf-8?B?OFpDZ3ZVck16b3czV0NxUkt2QU1UblFIZEtMTll2SVdBbE1DOGVjdm8yYzZ0?=
 =?utf-8?B?aU5QcmFRTDg5QVc2ZlRhbjBFYlRuMjVHM1lrak9rcHZzeFlCbFNEVG9nMHRu?=
 =?utf-8?B?eDFSbTdNb3IySU1BZFhESjZGbFhqcFVZVGI3UVZQUXF4czFrd0ZGUnlubnlB?=
 =?utf-8?B?b0lpaG51UFRwVTEyeUJxbUtrbVhFaTJpZmhFK1k4MGthd1AzR0FvSnNHcmgw?=
 =?utf-8?B?RjJtYmh5MVJibExxTGZ6OFNGaXFycjREVS9NL1FyQndKM0pyYTdTSnZjQXgv?=
 =?utf-8?B?OHV0Zis1YXVWZWQ2a1pqQ3FRdGdISzRiVnAxL0dlQ2JFSkZBNFZYSFdUTmIx?=
 =?utf-8?B?bkFUU0tYL043a0JJVFB4MWlSaWJwWXRZdDhVRzBiZFRNN0xocEtySFJ3MFJu?=
 =?utf-8?B?QnVrck5lZnNPSVlDaGNDZHBUNEpDWTJaREZNbSt6eXZxWGNDSlozZFB1eWtY?=
 =?utf-8?B?Q0xmRTk5aWEzZWJOWkFqSHROL2k0OUJlVGdGVW5GRGh3TGxsTE5hOVFNZVJP?=
 =?utf-8?B?cHhvcHpDclJ2MUZRNEZiL3RkSkN5UVFieS93aHI4UUtqVUpEWWYrWDFxSmk4?=
 =?utf-8?B?V0w4V05aaFUzZHRicTBwZHhUQ255Zk0yc2hkaXE2SVVTbm5jZjhLWFZLQ0p2?=
 =?utf-8?B?SUY2UDB2U2pnOVkxd1ArY2cybzlqMWZMbHdOdTFkZStwb1pmL3pSK2laamhv?=
 =?utf-8?B?Slk4V29GZFVIV01MQ2FyY0s2WW1aVHh2OElQYjJOQVlpb0dYTG9JQ0VKTmR3?=
 =?utf-8?B?QWJNQTRxVVdWMlR1TGRWcTRYWklRZXhJY0FGNlBpUmllOEEyME1tOVFaQi9X?=
 =?utf-8?B?bXJVVGhKc2hRQTNBVzZXdjZTZURZQjc5ODdPOURicFZUT1hvVGtXcnNpOWVU?=
 =?utf-8?B?TGhnem9sVm5OUjhMRzhRaS90UnBYcW9PRVNhN1YxelhGV0cwTjljWTk4d1Vj?=
 =?utf-8?B?OE5ZWENVZkxhZnp2SnNlYk85a3ZyaDU0dEVsT2RPaFgvU3RJVUc2OWF1RXk2?=
 =?utf-8?B?VHVrWW5kMjRjeTJpNzlKcE5SMy9VeStDZnY2by9WMmRaZUc2SU80ZHFZN2l2?=
 =?utf-8?B?VTkvajF0YjQyb2VNUGxFVlZUMTFVYVpFTktOeHhZZUM4SnVra21lbUREeWVI?=
 =?utf-8?B?WkNXbHVVMUttRDZ6QURMaXVHY2hIa0FsM1JidG00YVZqeEJSZlJOZ0NvbmVj?=
 =?utf-8?B?bXVvRkRpS1M5ckVMQWNtSUxiNGgycVM2YTJpTXNkOEhUNjJEb1dLSjJsbzl5?=
 =?utf-8?B?Zk9memgzSUZLR2toNko2WXJqZGF6WVAvSnRjR0RFYzBjbzdRRzFRWktuRVg3?=
 =?utf-8?B?M2hSSWZpY2hsS3NKQUk3Y0dEUGd3VHBmUEN4OXJHMVNmZUR1TElYMWpjWDZ6?=
 =?utf-8?B?N1U0d1F0SllmYTYxSlVjcm5OMG1SUnFlUFV3WW1XRjVhMHpFbmMvMVFuaW92?=
 =?utf-8?B?QzFCeXJuaDA3OEdCWmpvL2VFR2wxQzYvKzRGbHVkYld3bndLbDN4WXNHVGQ1?=
 =?utf-8?B?aC9KbEltWTFGYUovUzNEbS9CN2FzVUlkb1FJc1VFU3JMdkxiWXQxWmNRbUd2?=
 =?utf-8?B?MFQ2NEZtencraTdiL2JnYVg3T2xGU2h2NDN3U2JnZHZhdmFkK2ZPZGtUNXdz?=
 =?utf-8?B?Y2VRaWhHc1dIbVBwM3FmbnJQNWNWL1Ewdk5MSURha01aUE9LaGlmWHJtYWhw?=
 =?utf-8?B?d1FaY0MwbVBlNHYvK2xtWUVRMkhJelloV3IvbExqdE15YThSVDB5T1g1blZp?=
 =?utf-8?B?Zk1MUXJKNWIybmwxd1dOb1pOcDdaNy8wOWdZTDAvZzI3SloycDJDZTZCZGM4?=
 =?utf-8?B?N3h1MWIwZzZXcWxRTVFrQTNhaVBVN2RBMVoweEFQeXFZb2lHbkxKd095Z250?=
 =?utf-8?B?ZFZLblVIR2FQNm4wdGJvaGhOd2NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 513e5183-9b7a-4524-9fdc-08d9fc5b8de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 14:47:20.1855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4dgT+OrNMuV7mxJRs/8F9VMlrFQxLIe6dhTxszdmqevD58V5pc2G0SmObXaUW+Moteun1yOqwGPsy1Mzi4jFDc4QsepOfWv5Cawyp7jrCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciB0aGlzIHF1aWNrIHJlc3BvbnNlLg0KDQo+IEknbSBzb3JyeSwgYnV0IHRo
ZXJlIGlzIG5vdGhpbmcgd2UgY2FuIGRvIHdpdGggc3VjaCBhIGxhcmdlIHBhdGNoIGhlcmUgYXQN
Cj4gYWxsLg0KPiANCj4gUGxlYXNlIGJyZWFrIHRoaXMgdXAgaW50byAib25lIGxvZ2ljYWwgY2hh
bmdlIHBlciBwYXRjaCIgYW5kIHdlIHdpbGwgYmUNCj4gZ2xhZCB0byByZXZpZXcgaXQuDQoNCllv
dSBhcmUgYWJzb2x1dGVseSByaWdodCBidXQgdGhpcyBpcyBzdGlsbCB3b3JrIGluIHByb2dyZXNz
LiBUaGUgYXR0YWNoZWQNCnBhdGNoIHdhcyBvbmx5IGZvciByZWZlcmVuY2UgZm9yIGFsbCB0aG9z
ZSB3aG8gd291bGQgbGlrZSB0byBsb29rIGF0IHRoZQ0KY2hhbmdlcyBpbiBkZXRhaWwgb3IgdHJ5
IG91dCB0aGUgcHJvcG9zZWQgd29yay4gVGhpcyB3YXMgbm90IGEgcmVxdWVzdCBmb3INCmNvZGUg
cmV2aWV3IHlldC4gQWxzbywgaXQgc2VlbXMgdGhhdCB0aGUgcGF0Y2ggd2FzIHRvbyBsYXJnZSBm
b3IgdGhlDQpsaW51eC1zZXJpYWwgbWFpbGluZyBsaXN0IHNvIEkgaGF2ZSB1cGxvYWRlZCBpdCBo
ZXJlIGZvciByZWZlcmVuY2U6DQpodHRwczovL2dpdGh1Yi5jb20vc2llbWVucy9saW51eC90cmVl
L2RzdGFya2Utc2llbWVucy9uX2dzbV9yZmMNCg0KPiBQdXQgeW91ciAiZml4ZXMiIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgdGhlIHBhdGNoIHNlcmllcywgc28gdGhleSBjYW4gYmUNCj4gcHJvcGVybHkg
YmFja3BvcnRlZCB0byBvbGRlciBrZXJuZWxzIGFzIG5lZWRlZC4gRG9uJ3QgbWl4IHVwIG5ldyBm
ZWF0dXJlcw0KPiB3aXRoIGZpeGVzIGFzIHRoYXQgbWVhbnMgdGhhdCB0aGUgZml4ZXMgY2FuIG5l
dmVyIGJlIGJhY2twb3J0ZWQuDQoNCkFsbCBmaXhlcyB0aGF0IGhhdmUgbm8gZGVwZW5kZW5jeSBv
biB0aGUgdXBjb21pbmcgZmVhdHVyZXMgaGF2ZSBiZWVuDQpzdWJtaXR0ZWQgYnkgbWUgYWxyZWFk
eS4gSSB3aWxsIGRvdWJsZSBjaGVjayB0aGUgcmVtYWluaW5nIGZpeGVzIGJ1dCBJDQpjb3VsZCBu
b3QgZmluZCBhIHdheSB0byBzZXBhcmF0ZSB0aG9zZSBmcm9tIHRoZSBuZXcgZmVhdHVyZXMgc28g
ZmFyLg0KDQo+IE9uZSBub3RlLCBwbGVhc2UgZHJvcCB0aGUgdXNlbGVzcyBNT0RVTEVfVkVSU0lP
TigpIHRoYXQgbmV2ZXIgYmVsb25ncyBpbg0KPiBhbiBpbi1rZXJuZWwgZHJpdmVyIGFzIGl0IG1h
a2VzIG5vIHNlbnNlICh0aGUgdmVyc2lvbiBpcyB0aGUga2VybmVsDQo+IHZlcnNpb24pLg0KDQpU
aGlzIGhlbHBlZCB1cyBkdXJpbmcgb3VyIGludGVybmFsIGRldmVsb3BtZW50IGFuZCB0ZXN0IHBy
b2NlZHVyZS4gQnV0IEkNCndpbGwgcmVtb3ZlIGl0IGJlZm9yZSBzdWJtaXR0aW5nIHRoZSBhY3R1
YWwgcGF0Y2hlcy4NCg0KPiBTYW1lIGZvciB0aGUgbGljZW5zZSAiYm9pbGVyLXBsYXRlIiB0ZXh0
LCB0aGF0IHNob3VsZCBub3QgYmUgYWRkZWQgYmFjaywNCj4gd2UgcmVtb3ZlZCBpdCBmb3IgYSBy
ZWFzb24uDQoNCldpbGwgYmUgcmVtb3ZlZC4NCg0KPiBBbHNvLCBubyBtb2R1bGUgcGFyYW1ldGVy
cyBzaG91bGQgYmUgYWRkZWQuIEVzcGVjaWFsbHkgcG9pbnRsZXNzIG9uZXMNCj4gbGlrZSBkZWJ1
Z2dpbmcgZmxhZ3MsIHVzZSB0aGUgYnVpbHQtaW4ga2VybmVsIGRlYnVnZ2luZyBvcHRpb25zIHRo
YXQgdGhlDQo+IHdob2xlIHJlc3Qgb2YgdGhlIGtlcm5lbCB1c2VzLiBUaGVyZSBpcyBubyBuZWVk
IGZvciBhIHNwZWNpYWwgY2FzZSBmb3INCj4ganVzdCBvbmUgdGlueSBsaW5lIGRpc2NpcGxpbmUg
bW9kdWxlIDopDQoNClRoZSBtb2R1bGUgcGFyYW1ldGVyICJkZWJ1ZyIgaXMgbm90IG5ldy4gSXQg
aXMgaW5jbHVkZWQgaW4gYWxsIGtlcm5lbA0KdmVyc2lvbi4gQW5kIEkgZGlkIG5vdCBwbGFuIHRv
IHJlbW92ZSBpdC4gRXNwZWNpYWxseSwgc2luY2UgdGhpcyBwcm90b2NvbA0KaXMgY29tcGxleCBh
bmQgaGFyZCB0byBkZWJ1ZyB3aXRoIHRoZSBwcm92aWRlZCBrZXJuZWwgZGVidWdnaW5nIG9wdGlv
bnMNCm9ubHkuDQpNeSBhZGRpdGlvbiB3YXMgdGhlIHBhcmFtZXRlciAic3RyaWN0IiB0byB2ZXJp
Znkgc3RhbmRhcmQgY29uZm9ybWFuY2Ugb2YNCmNvbm5lY3RlZCBkZXZpY2VzIHdpdGggdGhlIHVu
ZGVybHlpbmcgcHJvdG9jb2wuIE90aGVyd2lzZSwgdGhlIHByb3RvY29sDQpncmFjZWZ1bGx5IGhh
bmRsZXMgaW52YWxpZCB2YWx1ZXMuIFdvdWxkIHlvdSBzdWdnZXN0IHRvIG1ha2UgdGhpcyBwYXJh
bWV0ZXINCmFuIGlvY3RsIGluc3RlYWQ/DQoNCldpdGggYmVzdCByZWdhcmRzLA0KRGFuaWVsIFN0
YXJrZQ0K
