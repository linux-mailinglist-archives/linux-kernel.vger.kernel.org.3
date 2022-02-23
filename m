Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA74C0D67
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiBWHlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiBWHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:41:06 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC75D65E;
        Tue, 22 Feb 2022 23:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1645602038; x=1646206838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xthi6l0q2KgGeHHEuS0owtUgLh08OQn48BIG1toRdSs=;
  b=wI6VZHMJS77Y9NxUly/9ja289Dd2Vzc6HwrAbNCqh1GCVSsrJEfCf3KZ
   mP1yRr5mo+cf5DD6ZgG6s9yvng3iIG1jS/VXrBoKDoblH7zY8bYT6DhE3
   lGcCShY+LpOfhcZVTkGTvG8QqTaeKj5VZBIGtq/ScGYfqavPlOsZNUyTR
   s=;
Received: from mail-mw2nam08lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8KBhc9Y+LN680Ke9HUunFwt/yW3D8S9afKyGVIVwFu8t9VsXqcr9ZRQNed9WFBzBWcUFNDPqMfYTZwzjydQYbhyL631oGdHWHhEqSU1Q2de0OJL69g3RX5l21onJ+YifwXD6u5bDquyaPEnvxGBMx4rWmIdlHmnEoYc8th1BtP/dDflK6PDmmPOG6N7VT7wduo6NQoYmyAa3fdG1YJz+PSgez2VYR9gtTBUuWSLQozAgGk1d+Iixek2hZE+TqhO6/XxloVdphMqr6CZpaUdl+0oX5Lg/rEZDHdrubQIneLVqnwbQ65XSGXuLm9ZjIMHkmLhv8mLHd1AOHan6OxRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xthi6l0q2KgGeHHEuS0owtUgLh08OQn48BIG1toRdSs=;
 b=G9GwBoIbNzb5ZiISVQXlPaamsqiNXcvJQr000iVY3rg4IeKXQoNSOFNhNjq6BPWuLUG9h59lvh4Wb8Ee+0JnmOIXXHqIzHhY/q7a7g/eIVFJitDlMQmSWKDSb5uE31g9x7hM4cO8JKOOuUKNQpaiHskwxSWyaO71RpvnhgAi9ZC6dElkSwdp+dwxEqrgHvRqbbHBDy0y60aRn6hPADmiv63rz2nIwhdpMS9ey/rzwOPLoYxk945U6Vi31wt0MfLptr5qosZ/li5szy/Ybi+yuZsNFnPAe7TQflSScrV8aFiA/khIQ60PUPW26HY0fAerZ88xJYfpDk1GWrSi2WPLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SA1PR02MB8606.namprd02.prod.outlook.com (2603:10b6:806:1fd::12)
 by DM5PR02MB2778.namprd02.prod.outlook.com (2603:10b6:3:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 07:40:32 +0000
Received: from SA1PR02MB8606.namprd02.prod.outlook.com
 ([fe80::40b0:637a:8e2:b188]) by SA1PR02MB8606.namprd02.prod.outlook.com
 ([fe80::40b0:637a:8e2:b188%8]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 07:40:31 +0000
From:   "Tao Wang (Consultant) (QUIC)" <quic_wat@quicinc.com>
To:     "mka@chromium.org" <mka@chromium.org>,
        "Tao Wang (Consultant) (QUIC)" <quic_wat@quicinc.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "ravisadineni@chromium.org" <ravisadineni@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFJlOiBbUEFUQ0ggdjIwIDMvNV0gdXNiOiBtaXNj?=
 =?utf-8?B?OiBBZGQgb25ib2FyZF91c2JfaHViIGRyaXZlcg==?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBSZTogW1BBVENIIHYyMCAzLzVdIHVzYjogbWlzYzogQWRkIG9u?=
 =?utf-8?B?Ym9hcmRfdXNiX2h1YiBkcml2ZXI=?=
Thread-Index: Adgm6oYw3Ao4YYHKQym2TOgy1H3w2AAADyHwAEfsywAAH4raEA==
Date:   Wed, 23 Feb 2022 07:40:31 +0000
Message-ID: <SA1PR02MB860602E0AC4D9BD0BC4245B5903C9@SA1PR02MB8606.namprd02.prod.outlook.com>
References: <SA1PR02MB86067ACF0C96F18B7306D208903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <SA1PR02MB860660B6F33011E5A97F7930903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhURQAksLKVuzU36@google.com>
In-Reply-To: <YhURQAksLKVuzU36@google.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4ecc04e-e9ed-4213-8f7e-08d9f69fc54b
x-ms-traffictypediagnostic: DM5PR02MB2778:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB27781A812A3F786861783FB5EC3C9@DM5PR02MB2778.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQWrXcL2fZPmHsF5PJn4A5trJSDQmnfOaecflZkRnNfhiSsBMFWQ+09Y5sbyT85ltkOgLVYjPg/af2KpVUAIcFKxf6fQMOPW5oAJFvJx9kB+7/LcEgMyzjGeItpV7oNrbWQQWKI0jXUN+siBbFI/IMnwE0Qn+Cqya1PsgtA04JopK7blLB+rTSyFXyTgGIuHZILmceODGATcn+wvmlVFrdMBvyjm3zd3YFk1gFtvkKXo7nzWYPw36j9PCrheYKMTeOzSb71YI0umwgaJ5u44Dm4+0F/ESDD9n9jhGwh7qOdRz6e48o2BldnP929kP0v/U2zyTr5Vy787I5ab/6/T/ST2Gp+z2hwamDzs7UC/qRpCW19QByjpHI7kqs+CLVoGI6LYZUKrcHi/fkllAZpclk58C9rg1FgUKPBFimlgdfDkirsx+iuysUGgEopruOEt0Dtkvq3H0t2DNf+KhW3bhBWvHOlIehq/vIDde71SLbQTGSvjZmSTd0E6NYnLeaAQVQcVqE/cs7bqDwHHWCfizaDXVW+t7qxSBuf0+Oy5HPS0iwnLwYFSLBMjBj4PC2WPqQSlhtV1R5yOkRoLQg2lI/yXWsooESz+RFyFiHJIdo55q9N4ufsJ8yJpRj3NBF+jPnrriS3mrUr/C8v2igG7JtjN0EHrYUSyhEwaN5e5YIKpTNv8c48EngBfYxjDkx/jABLkd2IF1IKpsGfLZtCVbWWirWYVKuud9BG9Mr09fcb625dez7ihaOhx1h/lADmKBX3Yf2DHNm39F+oBTMouZ8Dk5VJT9hmLF/+ZyS/HzjmVDB+87jyJal0hJGjv4IZQHvTruvmbCtITKHo//iQF8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8606.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(86362001)(55016003)(38070700005)(122000001)(54906003)(71200400001)(224303003)(26005)(6506007)(110136005)(66446008)(107886003)(33656002)(9686003)(7696005)(508600001)(316002)(76116006)(66946007)(5660300002)(4326008)(52536014)(8936002)(7416002)(186003)(66556008)(66476007)(83380400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anNHWGJKaXlqcUFDWVRaTEQ0Z0drSWgyeDhlU01seTRwR1dSRUpab3dNYjJ4?=
 =?utf-8?B?K2NNbnArcWF2RlJZRGVYckFVZG40MTlHOTQxanF4a25JakV0QmVTOEU1dkhG?=
 =?utf-8?B?emhueWxIeUFmRlZqMTJENXFNYTZLczZ2NjhuaHJiMGtFa1BNbmxEdkR3YlZY?=
 =?utf-8?B?emFCa3Mrc3o2WWNsNlMxVnU5WHlmR2o2WTliWUtBSFhSb2JkTWlYaFZ0d2Q3?=
 =?utf-8?B?Tm1oeG96OFFtZUVuamtFdXBOalA5cjRxclF4TzdYUjloSDgyMmhUbDRyRmx1?=
 =?utf-8?B?c3NrOGxoZUtFRG53OEg1ZEV1UFU4ZzhJa3M5eUFPdE5EQklRU3RFZUFzQjIw?=
 =?utf-8?B?Q290MWNSSFR0ZjhzVzdiVnk1YThhNTRqNmlxRGRWVGJlSmE0bE9MUEE1WjBi?=
 =?utf-8?B?WWY3VGk4akhxZjhOVE9HUjNLZFpiRklKcHZWZ3pFaHdYSHVIek5iYUlwMXA0?=
 =?utf-8?B?RnZjVkJoSDl6L21Gd3NVLzlpelRxWGFCeUx3Q2FSS3drT2t3MWVCbFdrR1ox?=
 =?utf-8?B?QzFyWHc5bW91d3BEVmJDRmM0U3gxUUNEc1hRbzZtUkUzMEs3Y3lzOUsxQnFy?=
 =?utf-8?B?aFhIeEhmOXMvWCtXQmFPem9UTGNnK1FNUVlDeUJoYkxodndvbHBCQmZDSkps?=
 =?utf-8?B?TzNjbEd3Z1g0cmZnZElLWlVjeUYwNUw3TmNHeEVvaHVNSUlwWmt5YWhyR1dm?=
 =?utf-8?B?b24vR2tHbS9MVUlLQUVwR25uejBWdWt5Q2k5OXdDVEV4cDhDTnlOcGY5ckNQ?=
 =?utf-8?B?YlpXOGRCcnorMWFxczJ1QXJITytXUTdwckwwemZuU0pVUnZJWmMzbng4RDI1?=
 =?utf-8?B?QVI0QzFaNS95YTNVaUpXQ0J4bDNiSDdvenZpTTg4MnRhRmkvdEMyTTV0NjUx?=
 =?utf-8?B?eUtFaXprVFphM0lYK3hUT2JuL0ZBWG1UeU1KM2pkU3hhcGhOVmkrT1MxektX?=
 =?utf-8?B?dmFNMGJEQmpmeDZ1SWxuY0pzZzYzV3A5ZjB3ZDIyL1dnb1Q2WWlrV2MwQUVm?=
 =?utf-8?B?OFNHcE5oRFlyNHlUSHl6VUxlcXl6bWxJVktFYWJ1N2dhSFBEOUs2dDZSdjhj?=
 =?utf-8?B?U2RleGF1RnRxM1pLb3U1OXFSNXZWRlNJbjd2VmxmSXc2Sk1IVE45UEZ3bXhV?=
 =?utf-8?B?by85QUljS25MWTNGK1Y2N1ZJZ3AwcFRRMG5jVjFZd0k1d1VnS2dzcmpQVVZz?=
 =?utf-8?B?QUoyMUZSMGVoUFZjbzBvWTRBa2xvcmZQLzlWalJpVlV5clFCajZoL01lNUxm?=
 =?utf-8?B?YU5lVUdJdS9DUkdNQjg3VmJvRzdHTDZ1bUQ2MUhFOEwxVG9NQ0VOeUNhTTh4?=
 =?utf-8?B?T0c1ald6RzJTckJmNytQSTJBMTRMaStQWGpCckY2YWkxVytDdDd5OVNlaXgw?=
 =?utf-8?B?b2RXSUFhbEtJb25BV28ybnNOT3dwMXVicVMycFdaZ0xHL3c0VFJBNlY3amxw?=
 =?utf-8?B?QU5KeUpVYkdYcXY4Ty9oYmowdFhQOEFtdm5KRUtqTnJxWVFmQlp5YkdXWFQz?=
 =?utf-8?B?OUljcHY0Q0pjdXE3eFA0KzdpY2FLajlhNDNyblFYUTlxSUxXeUFOa0hRSU1r?=
 =?utf-8?B?ckUzVnFTRm52RXFHdDR5YUU5RXVuMGIxY09rQVloazBzdjNqMlg5Um5pWkw0?=
 =?utf-8?B?UW96T3FOYUUxTlhER3FqamtETFZkcHhGejBCbEdGYk5wS2JjNCtONjBjTVBz?=
 =?utf-8?B?TGF2dEdBRm1iQXBTQWVFajNCSXQ2UHJOckMyazltbU9LZlNCcXdQMzhrT3JD?=
 =?utf-8?B?RFpYRmNYcWJLbmx6WmwvM0VLRElJOUlhcmZKdTBsdVI2czZNVkM5T3d5R2xR?=
 =?utf-8?B?eVlhK3JUSDJDa3JDTUlxUi9ucVhUUW5RbjdGZDVCdUdRNkR1V2YyTGdKaDVD?=
 =?utf-8?B?eVY0R283ZXFoMnNyTldqTi9rVk0yeWo5L2ZLWmlPWERXR2ZDRnpEVCtBSVlH?=
 =?utf-8?B?MVQ2dncyR1htWGdRUC9aR3M5NXc2RVVJc1VuRVpNUXhXbnJkR2JHQzJkbTN2?=
 =?utf-8?B?dDlaMzhXaDl2RCtBTEVkRDVXMGZYQjFrc0F1Q3JFTld1ZlpqaE4vbUhEaFh1?=
 =?utf-8?B?SzVJV1N1c1lMZVoxYlZUR3cyVUNXMDFnR2VMeFpNVnBSNmJUN3RWS3dmZ2Nj?=
 =?utf-8?B?OXpEU0wzYWhCQytXd0U1c1oyMUIzeW5KbTUrV1ovYjhDNk9tdUlDbEtlOUZw?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8606.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ecc04e-e9ed-4213-8f7e-08d9f69fc54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 07:40:31.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjakCv095l1sQmSZFgJeMdapWvn02SUiLomvdUAlSRdHyN8qqwM68WpkLSsJep31clzzAR/Kbs6hzhay2y+Fxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2778
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2ssIHRoYW5rcyB5b3VyIHJlcGx5Lg0KDQpIZXJlIGlzIG15IHF1ZXN0aW9uLCB3ZSBtdXN0IG1v
ZGlmeSB0aGUgZHJpdmVyICJvbmJvYXJkX3VzYl9odWIuYyIgaWYgd2Ugd2FudCB0byB1c2UgaXQu
IEJ1dCBpdCdzIGhhcmQgdG8gY29tcGxldGUgYmVjYXVzZSBpdCdzIGFuIG9wZW5zb3VyY2UgY29k
ZS4NCg0KTXkgc3VnZ2VzdGlvbiBpcyBjYW4gd2UgdXNlIGEgY29tbW9uIGNvbXBhdGlibGUgc3Ry
aW5nIGZvciBvbmJvYXJkX2h1Yl9kcml2ZXIgd2hpY2ggaXMgYSBwbGF0Zm9ybV9kcml2ZXIsIGFu
ZCByZWFkIGNvbXBhdGlibGUgc3RyaW5nIGZyb20gZGV2aWNlIHRyZWUgZm9yIG9uYm9hcmRfaHVi
X3VzYmRldl9kcml2ZXIgd2hpY2ggaXMgYSB1c2JfZGV2aWNlX2RyaXZlci4NCg0KSWYgc28sIHdl
IG9ubHkgbmVlZCB0byBtb2RpZnkgb3VyIGRldmljZSB0cmVlIGlmIHdlIHdhbnQgdG8gdXNlIHRo
ZSBkcml2ZXIuDQoNCg0KQmVzdCByZWdhcmRzLA0KV2FuZ3Rhbw0KMTM3MDkyMDI4NzkNCg0KLS0t
LS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBta2FAY2hyb21pdW0ub3JnIDxta2FAY2hy
b21pdW0ub3JnPiANCuWPkemAgeaXtumXtDogMjAyMuW5tDLmnIgyM+aXpSAwOjM3DQrmlLbku7bk
uro6IFRhbyBXYW5nIChDb25zdWx0YW50KSAoUVVJQykgPHF1aWNfd2F0QHF1aWNpbmMuY29tPg0K
5oqE6YCBOiBiYWxiaUBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZGlh
bmRlcnNAY2hyb21pdW0ub3JnOyBmcm93YW5kLmxpc3RAZ21haWwuY29tOyBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZzsgaGFkZXNzQGhhZGVzcy5uZXQ7IGtyemtAa2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbWF0aGlh
cy5ueW1hbkBpbnRlbC5jb207IG1pY2hhbC5zaW1la0B4aWxpbnguY29tOyBwZXRlci5jaGVuQGtl
cm5lbC5vcmc7IHJhdmlzYWRpbmVuaUBjaHJvbWl1bS5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsg
cm9nZXJxQGtlcm5lbC5vcmc7IHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU7IHN3Ym95ZEBjaHJv
bWl1bS5vcmc7IExpbnl1IFl1YW4gKFFVSUMpIDxxdWljX2xpbnl5dWFuQHF1aWNpbmMuY29tPg0K
5Li76aKYOiBSZTog5Zue5aSNOiBSZTogW1BBVENIIHYyMCAzLzVdIHVzYjogbWlzYzogQWRkIG9u
Ym9hcmRfdXNiX2h1YiBkcml2ZXINCg0KT24gTW9uLCBGZWIgMjEsIDIwMjIgYXQgMDY6MjA6MDBB
TSArMDAwMCwgVGFvIFdhbmcgKENvbnN1bHRhbnQpIChRVUlDKSB3cm90ZToNCj4gICAgSGksDQo+
IA0KPiANCj4gDQo+ICAgIFJlZ2FyZGluZyBvbiBib2FyZCBodWIgZHJpdmVyLA0KPiANCj4gICAg
WzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjIwMTE5MTI0MzI3LnYyMC4z
Lkk3YzlhMWYxZDZjZWQNCj4gICAgNDFkZDgzMTBlOGEwM2RhNjY2YTMyMzY0ZTc5MEBjaGFuZ2Vp
ZC8jUg0KPiANCj4gDQo+ICAgIEkgaGF2ZSBvbmUgY29tbWVudCBiZWxvdywNCj4gDQo+IA0KPiAg
ICArc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZGV2aWNlX2lkIG9uYm9hcmRfaHViX2lkX3RhYmxl
W10gPSB7DQo+IA0KPiAgICArICAgICAgIHsgVVNCX0RFVklDRShWRU5ET1JfSURfUkVBTFRFSywg
MHgwNDExKSB9LCAvKiBSVFM1NDExIFVTQiAzLjENCj4gICAgKi8NCj4gDQo+ICAgICsgICAgICAg
eyBVU0JfREVWSUNFKFZFTkRPUl9JRF9SRUFMVEVLLCAweDU0MTEpIH0sIC8qIFJUUzU0MTEgVVNC
IDIuMQ0KPiAgICAqLw0KPiANCj4gICAgKyAgICAgICB7IFVTQl9ERVZJQ0UoVkVORE9SX0lEX1JF
QUxURUssIDB4MDQxNCkgfSwgLyogUlRTNTQxNCBVU0IgMy4yDQo+ICAgICovDQo+IA0KPiAgICAr
ICAgICAgIHsgVVNCX0RFVklDRShWRU5ET1JfSURfUkVBTFRFSywgMHg1NDE0KSB9LCAvKiBSVFM1
NDE0IFVTQiAyLjENCj4gICAgKi8NCj4gDQo+ICAgICsgICAgICAge30NCj4gDQo+ICAgICt9Ow0K
PiANCj4gICAgK01PRFVMRV9ERVZJQ0VfVEFCTEUodXNiLCBvbmJvYXJkX2h1Yl9pZF90YWJsZSk7
DQo+IA0KPiANCj4gICAgQ2FuIHdlIHN1cHBvcnQgcmVhZCBWSUQvUElEIGZyb20gZGV2aWNlIHRy
ZWUgd2hpY2ggcHJvdmlkZSBwbGF0ZnJvbQ0KPiAgICBkZXZpY2UgaW5mbz8NCg0KQXMgZmFyIGFz
IEkgdW5kZXJzdGFuZCB0aGUga2VybmVsIGV4Y2x1c2l2ZWx5IHVzZXMgdGhlIFZJRC9QSUQgcmVw
b3J0ZWQgYnkgdGhlIFVTQiBkZXZpY2UsIHRoZSBjb21wYXRpYmxlIHN0cmluZyBpbiB0aGUgZGV2
aWNlIHRyZWUgaXMgcHVyZWx5IGluZm9ybWF0aW9uYWwgKHRob3VnaCB0aGlzIGRyaXZlciB1c2Vz
IGl0IGZvciB0aGUgcGxhdGZvcm0gZGV2aWNlKS4NCg0K
