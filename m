Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393C249D77D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiA0Bbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:31:52 -0500
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:4416
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231940AbiA0Bbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpYLEU5YhL5UvvWm3TLuC/DsV2wceNKpr3G5pQkFopk=;
 b=NM1vHAgK2g8PU8ZswTuv2Z4Q1Qb0qTtCayXaYKdgnrnoeb2woi4S98dz5G/7vb7hLFUmzj7CmXyJHTxReTRa6EGYdIdXriXrUMC6BlUgHVtLZfCrPHR9N4dDjOh3mzVhR4VWf5Ifcw88NAUegtQd5DYXHUYLnJhzjw2EOqz6a24=
Received: from AS9PR06CA0172.eurprd06.prod.outlook.com (2603:10a6:20b:45c::35)
 by AM4PR08MB2659.eurprd08.prod.outlook.com (2603:10a6:205:e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 01:31:47 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45c:cafe::b) by AS9PR06CA0172.outlook.office365.com
 (2603:10a6:20b:45c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 01:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 01:31:47 +0000
Received: ("Tessian outbound 826a6d8e58c3:v113"); Thu, 27 Jan 2022 01:31:47 +0000
X-CR-MTA-TID: 64aa7808
Received: from d510b130f701.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 67DA4F27-A979-4B13-B3B8-D7BC06ED40D4.1;
        Thu, 27 Jan 2022 01:31:37 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d510b130f701.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 27 Jan 2022 01:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh/J/quyf6COxWo2i5Hb7UwJZPLafjFh7LK3j9BpnALN5BJCMVP796ad23nD/Z5t08GV9TXzyGpC5n1CaviBAiSK4bmHm9YMpestd9LDGsVG0QBCCF3wbFLhCbe8XkChQ0O95lnnGWyzCAmqSlYXC6ZcEzpHPJ3QYYBfl+cnsCwOAF2xqzuz1H+BqlcjMK4n2VVRrdTVemtctXgh51Avf/yS+9LEwiW8fn6kpM1497BS2BhPp6Vi6odQt8HJfDi0h/KdpeY8VxSNbBRMW7kS650N8Vu6LLdhid1GbUhGC2QU6zCCVSBsODWSafW6YfhSPCg7cIk6E52+E4EUwSqKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpYLEU5YhL5UvvWm3TLuC/DsV2wceNKpr3G5pQkFopk=;
 b=eTWEGHXlrROp/ci7zqpjWE/7vbk49qvfWbs+5jB9CzUHlX+iSpuPHwYeoA5OWAA9qBOI2Co8NV9oNDLYu8CqTpYwzEOtLtvxqqaHHoe4GvoKN1N7zJ91jRRBa6NAV9NEWXoNNiQGytAYCu1tVdMYIH7ZOV6srx4IFJ6sNfwNKwosEPmE0jPXPFyUF7BFNVLs44qMZPfnaO7CRhILVstlropuzDSgBM/dLaIeZGwI6+HMzt0nqWkStkCPnlbqsQY/cNbvvt8BNP3XcrzsV7q5cXO5Dc8QtXFs5UJ00me9QedRFGnvuBXhZ8RAYKjheWlFdqmd3P/0CzB8sUpg0pycWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpYLEU5YhL5UvvWm3TLuC/DsV2wceNKpr3G5pQkFopk=;
 b=NM1vHAgK2g8PU8ZswTuv2Z4Q1Qb0qTtCayXaYKdgnrnoeb2woi4S98dz5G/7vb7hLFUmzj7CmXyJHTxReTRa6EGYdIdXriXrUMC6BlUgHVtLZfCrPHR9N4dDjOh3mzVhR4VWf5Ifcw88NAUegtQd5DYXHUYLnJhzjw2EOqz6a24=
Received: from VI1PR08MB3742.eurprd08.prod.outlook.com (2603:10a6:803:c3::16)
 by AM6PR08MB3096.eurprd08.prod.outlook.com (2603:10a6:209:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 01:31:34 +0000
Received: from VI1PR08MB3742.eurprd08.prod.outlook.com
 ([fe80::dc36:d5c0:73b9:4b13]) by VI1PR08MB3742.eurprd08.prod.outlook.com
 ([fe80::dc36:d5c0:73b9:4b13%5]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 01:31:34 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Jianyong Wu <Jianyong.Wu@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
Subject: RE: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX8lbtE25Jxomi6EyEj6gGYJIT7qxU2ImAgAEOxwCAAF/yAIABIQaAgAAZqICAHI870IABKecAgAEJrWA=
Date:   Thu, 27 Jan 2022 01:31:34 +0000
Message-ID: <VI1PR08MB3742D95CC6B9EC2B07E2A020F7219@VI1PR08MB3742.eurprd08.prod.outlook.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
 <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com>
 <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 344CB0323FC0F14484FC579FA9724300.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 884ecb34-3e53-4d6c-517a-08d9e134c8f5
x-ms-traffictypediagnostic: AM6PR08MB3096:EE_|AM5EUR03FT004:EE_|AM4PR08MB2659:EE_
X-Microsoft-Antispam-PRVS: <AM4PR08MB26592840D2C2E9EDDDBF6B55F7219@AM4PR08MB2659.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aE2fBGVkTGF5ESbB6EiZuJmMY43jUU5djPlO2S+M3HiGpysUHJ/UmQ6tSnvaXNh1urpW+GlONr+sj96uD0VY5/oUD24REn2e8JH/MgpO8q5lJIas0SvAIsroM+f0aKCzHSl1oPTqGH4Z9n5x30VWvOZHgmnzuJEHK5l/UXkcWbKlUN8utuZjcYwkZETIb0sCLhvYMD+OAwnETqRkiW6yrP7Ypi0gwQ7Q2aNnUq3Af0ruHoC6uBVwL9bvbJ7ueuxWUvseGBdPDEdtALfTA3A26t0uKZDwG9ulUWgEAmnVccGCsaG9FS+r8Fl2ChBIj6dsjYEnY4IkQd0mkyQLyLBtpxmN+88h60DBTmola4Z3CPCymJGeN5R3/XPDQrnRPLeKmsGzvpQyMxscetAAcHIf1E7SO3VnCcf8SYY7XTVviYrUHjMKh1+q85vGwAJg//svX4dccXWFo7loCbsSKY3lBpM2Ugn4v5nmLBclehTRhFU1X8jJdAEJXwXiFf4X5e13OLniQ9uFF9kIaEbwhjXPt3rA3NkNt03/NFtgI0JwvC/lKozyzTmtDqBFVcPWePD4DxNrG3b9uY7WHR6Sbok3C0hRlXuBbjLY2S7X/5RVRaMLkIQBI6tGmPt+BAZcD+Ae+qFKATR/k84BxfiTenvYl9xXLvG0QAJoD1HmyWLARUwyOJg5/UqPxwJ9dzXoy83irIe8jtrAFow3o2SBtTI3Gg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3742.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(122000001)(7696005)(6506007)(38070700005)(38100700002)(4326008)(2906002)(76116006)(66946007)(9686003)(66476007)(66556008)(66446008)(53546011)(64756008)(83380400001)(86362001)(55016003)(508600001)(52536014)(186003)(26005)(5660300002)(8676002)(8936002)(33656002)(316002)(6916009)(54906003)(20210929001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3096
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e24054a7-19a0-47f8-318d-08d9e134c12d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHqFOmPn9h9HJDp2BZnuSTDwTtzezv780/RHsMoszLdstOyI8zX3jvy3vUhZNn8X6DtyViAuOeROz9rKYjR80q5FyQVB0C6rOZSYfH9BoZPh3/cMzbbj3LBFuc9vBlrJCIm/Hk7oHElwrHBbh0kZC9ulwrqGhFSalJgcai14cHSmPqMW76fgfQ7z9LTwmOcnp0MoAt5LZtcspdL9nSxYDQRKlUrQNXiOocGTFJ1pbixnkU5LqGRr/XB/r2DxBthHWNtkRvWWrLGwm0gWdRz8PBzW1h+YBbGKAZLOxyIaNoxyeXX+nU9r+z6QoPwCqbzpGJ4lVFQwfNTBIuEyfXOZR0aVv0/jhNDqD2jBrTCTMlubsI6x8LrArQKngS/WUJdaVk1OoEDRQstabdDAVq4klbPRwDY8isHnma+hLZ/ZsUu17f1fQTt9/xKIUMW11s7RKW27Mx6Y7gHSNGm4BeyNsW2cWH7Q2drwtdaNXhtZdybUwfriwQ5vEYbM3KCBev5X4cyFU+TekRu6kVp8aHx3KfIYLu0oQV+1Paj5fzXWb1EC9R+ezOTr7nSnml5wF7BFJ/rAr4D9HWJyry2WFUvd6Ms+M8L5uZnKVoClrxwjyHKr9Wht11ujBfd20bw0bbP3mbkKlCpc/PZdtpXfoF0VGrzwf/uJVSb3cL0Nd0meog7Zc35CLa34ruTJ/TAxw1Rx
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(356005)(36860700001)(9686003)(508600001)(47076005)(5660300002)(40460700003)(81166007)(52536014)(2906002)(55016003)(82310400004)(4326008)(86362001)(54906003)(70206006)(316002)(70586007)(83380400001)(6862004)(8936002)(8676002)(33656002)(186003)(26005)(53546011)(6506007)(7696005)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 01:31:47.4924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884ecb34-3e53-4d6c-517a-08d9e134c8f5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2659
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJkDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNo
ZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDI2LCAy
MDIyIDQ6MzcgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENjOiBD
YXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgSmlhbnlvbmcgV3UNCj4g
PEppYW55b25nLld1QGFybS5jb20+OyB3aWxsQGtlcm5lbC5vcmc7IEFuc2h1bWFuIEtoYW5kdWFs
DQo+IDxBbnNodW1hbi5LaGFuZHVhbEBhcm0uY29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9y
ZzsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcXVpY19xaWFuY2FpQHF1aWNpbmMuY29tOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBnc2hhbkByZWRoYXQuY29tOyBuZCA8bmRAYXJtLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2M10gYXJtNjQvbW06IGF2b2lkIGZpeG1hcCByYWNlIGNvbmRpdGlvbiB3aGVuIGNy
ZWF0ZQ0KPiBwdWQgbWFwcGluZw0KPiANCj4gT24gV2VkLCAyNiBKYW4gMjAyMiBhdCAwNToyMSwg
SnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBDYXRhbGlu
DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBDYXRh
bGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KPiA+ID4gU2VudDogRnJpZGF5
LCBKYW51YXJ5IDcsIDIwMjIgNjo0MyBQTQ0KPiA+ID4gVG86IEppYW55b25nIFd1IDxKaWFueW9u
Zy5XdUBhcm0uY29tPg0KPiA+ID4gQ2M6IHdpbGxAa2VybmVsLm9yZzsgQW5zaHVtYW4gS2hhbmR1
YWwgPEFuc2h1bWFuLktoYW5kdWFsQGFybS5jb20+Ow0KPiA+ID4gYWtwbUBsaW51eC1mb3VuZGF0
aW9uLm9yZzsgZGF2aWRAcmVkaGF0LmNvbTsgcXVpY19xaWFuY2FpQHF1aWNpbmMuY29tOw0KPiA+
ID4gYXJkYkBrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0tDQo+ID4gPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZ3NoYW5AcmVkaGF0LmNvbTsg
SnVzdGluIEhlDQo+ID4gPiA8SnVzdGluLkhlQGFybS5jb20+OyBuZCA8bmRAYXJtLmNvbT4NCj4g
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGFybTY0L21tOiBhdm9pZCBmaXhtYXAgcmFjZSBj
b25kaXRpb24gd2hlbg0KPiBjcmVhdGUNCj4gPiA+IHB1ZCBtYXBwaW5nDQo+ID4gPg0KPiA+ID4g
T24gRnJpLCBKYW4gMDcsIDIwMjIgYXQgMDk6MTA6NTdBTSArMDAwMCwgSmlhbnlvbmcgV3Ugd3Jv
dGU6DQo+ID4gPiA+IEhpIENhdGFsaW4sDQo+ID4gPiA+DQo+ID4gPiA+IEkgcm91Z2hseSBmaW5k
IHRoZSByb290IGNhdXNlLg0KPiA+ID4gPiAgYWxsb2NfaW5pdF9wdWQgd2lsbCBiZSBjYWxsZWQg
YXQgdGhlIHZlcnkgYmVnaW5uaW5nIG9mIGtlcm5lbCBib290DQo+IGluDQo+ID4gPiBjcmVhdGVf
bWFwcGluZ19ub2FsbG9jIHdoZXJlIG5vIG1lbW9yeSBhbGxvY2F0b3IgaXMgaW5pdGlhbGl6ZWQu
IEJ1dA0KPiA+ID4gbG9ja2RlcCBjaGVjayBtYXkgbmVlZCBhbGxvY2F0ZSBtZW1vcnkuIFNvLCBr
ZXJuZWwgdGFrZSBleGNlcHRpb24gd2hlbg0KPiA+ID4gYWNxdWlyZSBsb2NrLihJIGhhdmUgbm90
IGZvdW5kIHRoZSBleGFjdCBjb2RlIHRoYXQgY2F1c2UgdGhpcyBpc3N1ZSkNCj4gPiA+IHRoYXQn
cyBzYXkgd2UgbWF5IG5vdCBiZSBhYmxlIHRvIHVzZSBhIGxvY2sgc28gZWFybHkuDQo+ID4gPiA+
DQo+ID4gPiA+IEkgY29tZSB1cCB3aXRoIDIgbWV0aG9kcyB0byBhZGRyZXNzIGl0Lg0KPiA+ID4g
PiAxKSBza2lwIGRlYWQgbG9jayBjaGVjayBhdCB0aGUgdmVyeSBiZWdpbm5pbmcgb2Yga2VybmVs
IGJvb3QgaW4NCj4gbG9ja2RlcA0KPiA+ID4gY29kZS4NCj4gPiA+ID4gMikgcHJvdmlkZWQgMiB0
d28gdmVyc2lvbnMgb2YgX19jcmVhdGVfcGdkX21hcHBpbmcsIG9uZSB3aXRoIGxvY2sgaW4NCj4g
PiA+ID4gaXQgYW5kIHRoZSBvdGhlciB3aXRob3V0LiBUaGVyZSBtYXkgYmUgbm8gcG9zc2libGUg
b2YgcmFjZSBmb3INCj4gbWVtb3J5DQo+ID4gPiA+IG1hcHBpbmcgYXQgdGhlIHZlcnkgYmVnaW5u
aW5nIHRpbWUgb2Yga2VybmVsIGJvb3QsIHRodXMgd2UgY2FuIHVzZQ0KPiB0aGUNCj4gPiA+ID4g
bm8gbG9jayB2ZXJzaW9uIG9mIF9fY3JlYXRlX3BnZF9tYXBwaW5nIHNhZmVseS4NCj4gPiA+ID4g
SW4gbXkgdGVzdCwgdGhpcyBpc3N1ZSBpcyBnb25lIGlmIHRoZXJlIGlzIG5vIGxvY2sgaGVsZCBp
bg0KPiA+ID4gPiBjcmVhdGVfbWFwcGluZ19ub2FsbG9jLiBJIHRoaW5rIGNyZWF0ZV9tYXBwaW5n
X25vYWxsb2MgaXMgY2FsbGVkDQo+IGVhcmx5DQo+ID4gPiA+IGVub3VnaCB0byBhdm9pZCB0aGUg
cmFjZSBjb25kaXRpb25zIG9mIG1lbW9yeSBtYXBwaW5nLCBob3dldmVyLCBJDQo+IGhhdmUNCj4g
PiA+ID4gbm90IHByb3ZlZCBpdC4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIG1ldGhvZCAyIHdvdWxk
IHdvcmsgYmV0dGVyIGJ1dCByYXRoZXIgdGhhbiBpbXBsZW1lbnRpbmcgbmV3DQo+ID4gPiBub2xv
Y2sgZnVuY3Rpb25zIEknZCBhZGQgYSBOT19MT0NLIGZsYWcgYW5kIGNoZWNrIGl0IGluDQo+ID4g
PiBhbGxvY19pbml0X3B1ZCgpIGJlZm9yZSBtdXRleF9sb2NrL3VubG9jay4gQWxzbyBhZGQgYSBj
b21tZW50IHdoZW4NCj4gPiA+IHBhc3NpbmcgdGhlIE5PX0xPQ0sgZmxhZyBvbiB3aHkgaXQncyBu
ZWVkZWQgYW5kIHdoeSB0aGVyZSB3b3VsZG4ndCBiZQ0KPiA+ID4gYW55IHJhY2VzIGF0IHRoYXQg
c3RhZ2UgKGVhcmx5IGJvb3QgZXRjLikNCj4gPiA+DQo+ID4gVGhlIHByb2JsZW1hdGljIGNvZGUg
cGF0aCBpczoNCj4gPiBfX3ByaW1hcnlfc3dpdGNoZWQNCj4gPiAgICAgICAgIGVhcmx5X2ZkdF9t
YXAtPmZpeG1hcF9yZW1hcF9mZHQNCj4gPiAgICAgICAgICAgICAgICAgY3JlYXRlX21hcHBpbmdf
bm9hbGxvYy0+YWxsb2NfaW5pdF9wdWQNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBtdXRl
eF9sb2NrICh3aXRoIEppYW55b25nJ3MgcGF0Y2gpDQo+ID4NCj4gPiBUaGUgcHJvYmxlbSBzZWVt
cyB0byBiZSB0aGF0IHdlIHdpbGwgY2xlYXIgQlNTIHNlZ21lbnQgdHdpY2UgaWYga2FzbHINCj4g
PiBpcyBlbmFibGVkLiBIZW5jZSwgc29tZSBvZiB0aGUgc3RhdGljIHZhcmlhYmxlcyBpbiBsb2Nr
ZGVwIGluaXQgcHJvY2Vzcw0KPiB3ZXJlDQo+ID4gbWVzc2VkIHVwLiBUaGF0IGlzIHRvIHNhaWQs
IHdpdGgga2FzbHIgZW5hYmxlZCB3ZSBtaWdodCBpbml0aWFsaXplDQo+IGxvY2tkZXANCj4gPiB0
d2ljZSBpZiB3ZSBhZGQgbXV0ZXhfbG9jay91bmxvY2sgaW4gYWxsb2NfaW5pdF9wdWQoKS4NCj4g
Pg0KPiANCj4gVGhhbmtzIGZvciB0cmFja2luZyB0aGF0IGRvd24uDQo+IA0KPiBOb3RlIHRoYXQg
Y2xlYXJpbmcgdGhlIEJTUyB0d2ljZSBpcyBub3QgdGhlIHJvb3QgcHJvYmxlbSBoZXJlLiBUaGUN
Cj4gcm9vdCBwcm9ibGVtIGlzIHRoYXQgd2Ugc2V0IGdsb2JhbCBzdGF0ZSB3aGlsZSB0aGUga2Vy
bmVsIHJ1bnMgYXQgdGhlDQo+IGRlZmF1bHQgbGluayB0aW1lIGFkZHJlc3MsIGFuZCB0aGVuIHJl
ZmVyIHRvIGl0IGFnYWluIGFmdGVyIHRoZSBlbnRpcmUNCj4ga2VybmVsIGhhcyBiZWVuIHNoaWZ0
ZWQgaW4gdGhlIGtlcm5lbCBWQSBzcGFjZS4gU3VjaCBnbG9iYWwgc3RhdGUNCj4gY291bGQgY29u
c2lzdCBvZiBtdXRhYmxlIHBvaW50ZXJzIHRvIHN0YXRpY2FsbHkgYWxsb2NhdGVkIGRhdGEgKHdo
aWNoDQo+IHdvdWxkIGJlIHJlc2V0IHRvIHRoZWlyIGRlZmF1bHQgdmFsdWVzIGFmdGVyIHRoZSBy
ZWxvY2F0aW9uIGNvZGUgcnVucw0KPiBhZ2FpbiksIG9yIGdsb2JhbCBwb2ludGVyIHZhcmlhYmxl
cyBpbiBCU1MuIEluIGVpdGhlciBjYXNlLCByZWx5aW5nIG9uDQo+IHN1Y2ggYSBnbG9iYWwgdmFy
aWFibGUgYWZ0ZXIgdGhlIHNlY29uZCByZWxvY2F0aW9uIHBlcmZvcm1lZCBieSBLQVNMUg0KPiB3
b3VsZCBiZSByaXNreSwgYW5kIHNvIHdlIHNob3VsZCBhdm9pZCBtYW5pcHVsYXRpbmcgZ2xvYmFs
IHN0YXRlIGF0DQo+IGFsbCBpZiBpdCBtaWdodCBpbnZvbHZlIHBvaW50ZXIgdG8gc3RhdGljYWxs
eSBhbGxvY2F0ZWQgZGF0YQ0KPiBzdHJ1Y3R1cmVzLg0KPiANClRoYW5rcyBmb3IgdGhlIGV4cGxh
bmF0aW9uLCB3aGljaCBtYWtlcyByb290IGNhdXNlIGNsZWFyZXIuDQpJIGhhdmUgYSBxdWVzdGlv
biBvZmYgdGhpcyB0aHJlYWQ6DQpTaG91bGQgd2UgYXZvaWQgdG8gaW52b2tlIGVhcmx5X2ZkdF9t
YXAgYW5kIGluaXRfZmVhdHVyZV9vdmVycmlkZSB0d2ljZQ0Kd2l0aCBrYXNsciBlbmFibGVkPw0K
DQpJbiBDb21taXQgZjZmMGM0MzYyZjA3ICgiYXJtNjQ6IEV4dHJhY3QgZWFybHkgRkRUIG1hcHBp
bmcgZnJvbSBrYXNscg0KZWFybHlfaW5pdCgpICIpLCBpdCBpbXBsaWNpdGx5IGludm9rZXMgZWFy
bHlfZmR0X21hcCBmaXJzdCB0aW1lIGJlZm9yZQ0Ka2FzbHIgaXMgZW5hYmxlZCBhbmQgMm5kIHRp
bWUgYWZ0ZXIgaXQuDQoNCldoYXQgdG8geW91IHRoaW5rIG9mIGJlbG93IGNoYW5nZXMgKHRlc3Rl
ZCBpbiBib3RoIGd1ZXN0IGFuZCBob3N0IGJvb3QpOg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9rZXJuZWwvaGVhZC5TIGIvYXJjaC9hcm02NC9rZXJuZWwvaGVhZC5TDQppbmRleCA2YTk4ZjFh
MzhjMjkuLjM3NThhYzA1N2E2YSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQva2VybmVsL2hlYWQu
Uw0KKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvaGVhZC5TDQpAQCAtNDUwLDEyICs0NTAsMTIgQEAg
U1lNX0ZVTkNfU1RBUlRfTE9DQUwoX19wcmltYXJ5X3N3aXRjaGVkKQ0KICNpZiBkZWZpbmVkKENP
TkZJR19LQVNBTl9HRU5FUklDKSB8fCBkZWZpbmVkKENPTkZJR19LQVNBTl9TV19UQUdTKQ0KICAg
ICAgICBibCAgICAgIGthc2FuX2Vhcmx5X2luaXQNCiAjZW5kaWYNCi0gICAgICAgbW92ICAgICB4
MCwgeDIxICAgICAgICAgICAgICAgICAgICAgICAgIC8vIHBhc3MgRkRUIGFkZHJlc3MgaW4geDAN
Ci0gICAgICAgYmwgICAgICBlYXJseV9mZHRfbWFwICAgICAgICAgICAgICAgICAgIC8vIFRyeSBt
YXBwaW5nIHRoZSBGRFQgZWFybHkNCi0gICAgICAgYmwgICAgICBpbml0X2ZlYXR1cmVfb3ZlcnJp
ZGUgICAgICAgICAgIC8vIFBhcnNlIGNwdSBmZWF0dXJlIG92ZXJyaWRlcw0KICNpZmRlZiBDT05G
SUdfUkFORE9NSVpFX0JBU0UNCiAgICAgICAgdHN0ICAgICB4MjMsIH4oTUlOX0tJTUdfQUxJR04g
LSAxKSAgICAgIC8vIGFscmVhZHkgcnVubmluZyByYW5kb21pemVkPw0KICAgICAgICBiLm5lICAg
IDBmDQorICAgICAgIG1vdiAgICAgeDAsIHgyMSAgICAgICAgICAgICAgICAgICAgICAgICAvLyBw
YXNzIEZEVCBhZGRyZXNzIGluIHgwDQorICAgICAgIGJsICAgICAgZWFybHlfZmR0X21hcCAgICAg
ICAgICAgICAgICAgICAvLyBUcnkgbWFwcGluZyB0aGUgRkRUIGVhcmx5DQorICAgICAgIGJsICAg
ICAgaW5pdF9mZWF0dXJlX292ZXJyaWRlICAgICAgICAgICAvLyBQYXJzZSBjcHUgZmVhdHVyZSBv
dmVycmlkZXMNCiAgICAgICAgYmwgICAgICBrYXNscl9lYXJseV9pbml0ICAgICAgICAgICAgICAg
IC8vIHBhcnNlIEZEVCBmb3IgS0FTTFIgb3B0aW9ucw0KICAgICAgICBjYnogICAgIHgwLCAwZiAg
ICAgICAgICAgICAgICAgICAgICAgICAgLy8gS0FTTFIgZGlzYWJsZWQ/IGp1c3QgcHJvY2VlZA0K
ICAgICAgICBvcnIgICAgIHgyMywgeDIzLCB4MCAgICAgICAgICAgICAgICAgICAgLy8gcmVjb3Jk
IEtBU0xSIG9mZnNldA0KDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
