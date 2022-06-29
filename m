Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869475609B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiF2StG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiF2StC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:49:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8C13F8A;
        Wed, 29 Jun 2022 11:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kULM/H+zjpoaVXQnI0TtYrfsDqBeHRmzxjoFwise9D7+OLzBpAwKsA4fFK5/4iGANUD3IFSK//Y/wgvt7UA1JeBzJfs8+X4QtJl0dSy+/n25PPEmwaPMloHUxaOiOWLCk3hergJZy3A2P86RyqyuWadB7mHGGUox2zMK95/8PAeyWpuKkONCa0nPgXWnl8LjiLV1p1g5Mwq/W71tq+K0ERE0T+80OMI9FT7aWr0D6sX5NQYDvoLUe2RCu4CDUJvL71irjYmF//kfItrngocoj+nk7WKt2Ez83EZ0kTju4F2DYKHTYBk/nkHKBcwtTmFKS5OXhD3aDIXT4PF9a8JO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0QPXbEL3pO3vFx+MfUmNcSda5Wp67uI2LIYgXzupAk=;
 b=G4rfWvx7fMut+MnfFHoShW7flZRrp+ZYGu9JS7C9ii7UNBZ0SaSzUjqSnS0aUmVTTq1NFpgso3UksS0UoFiWrGCLKYgSmHiNoz8RizLxfxCGm6quWSIaGUjzosiK+NZ7NabXdDOeilJsNWzeayrzOnEHDvlSWvI5GjTNV/gMHQAPVjb0xFuHWdRFHG1V6bgMYD5uSDkTDOEwcYtDAhCvEk+9QPZS7E00u837LC55snQzgonBqhA30wQR9K6LonUgsnvSAovBdjh3u3lOcOxgmYbarxxUuG27Nj53oZVWJ474hL7+xpsQIs/yn4Ei+q+IZy95hiCD2Tm/01lZah7bMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0QPXbEL3pO3vFx+MfUmNcSda5Wp67uI2LIYgXzupAk=;
 b=rr/6LlOKb5xZ3T/dX+sZgRJ4ATkkEQf2zgc6WCUjslW/P3XInaSpHlCcC3ky+7pG0yv2RxIzmpnaRTaNreTzpZx//STygYpvCxcsVNcmCGkipzbgXjRnRrJWi/IVFtM32VYXoYT6cvXcyPXwaZI+p5d7TEsFRZXi6S9c7vkIL8I=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB3886.namprd12.prod.outlook.com (2603:10b6:208:16a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 18:48:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 18:48:57 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
 supported
Thread-Topic: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
 supported
Thread-Index: AQHYikckkfPFKMg6CkqPB4GLDcaQGq1muz6AgAAAOuA=
Date:   Wed, 29 Jun 2022 18:48:57 +0000
Message-ID: <MN0PR12MB6101BFCBAA33B98D438B25E8E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220627165832.10246-1-mario.limonciello@amd.com>
 <CAJZ5v0g2qfA00=ukatTxSXPnoOaquwvn8tk0oNHaY-0F7ODZQw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2qfA00=ukatTxSXPnoOaquwvn8tk0oNHaY-0F7ODZQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-29T18:42:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=07a5ac81-5606-4bc4-9995-8877f497bf5a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-29T18:48:54Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8602ab9c-6fe4-42e8-933d-d158972f2153
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cb040c5-e35f-43fa-4f53-08da5a00060d
x-ms-traffictypediagnostic: MN2PR12MB3886:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QES8nKTpKSzir1sp4HjnzabuAsur8WzhJ641t3GUMYAJFlrC4uT/galM/ZcXD+nm6wB/xaxUZiyokPF6/IW9lYizx3M9QL0cqHB3Lwi4aB/9/4dOKY6KPtbF8THQ1P88oUk3wWuwreAXJChyfA1rVrj09EnXBRI7Tu/g8/fj3W2R17et/Mrm4vq75IgSq7OJuscqZ9ShKekV65MJQO+DyC0cwqeiIVegns7Z/r9x1eyMJgSzPibban1NqO+TByJQ5GmjqtH9dCBQzGuWwDuxAKg4W50+KEzLenmC0+nV9Ao+wgfjfR4BWlz8nfd+oqt9yflU4DmeVkh8qTgh4hZWCJ3DhfI7sHzxDOZv1F1O5DBH0ciGw1B/IJ+solCh7tpuXNiMij20VClGJY7i1QPjQhSLCxb0F88RgzNTmLRvAwsRAi/V93EWWznZpelk9jHNMajf/pjsH2852za/9n9Z2FtwOLAIdfkT7DZysjR0vA6j1lkYM2gT/SoBfMkP43ReYKRE5l/WeFqmXHHX9vIchS3YxcDZZmJpzjEq6DXM1aTUrmjwnKSf2e2DXC3YnPsekGM2B/y49YAnlQQFQNJMJczoWunYnDphJKWUlBlCxGMguT8pJ+JRa84AaajwFL5Huxgz5XlzcmMhHNBoZ6FgkwY490SSauxTfN0abmp/vpF3PdhbAqAEFR0ZhFEvqf1EQyS+Zh5ACjQBiy/5jcH22ynAmbLmZGtZjiidWKvp9k+hWIBX5kCmJDiIbeuYNnMC5wLCpWOmNpIO7REqcd2MpYt+xb5umoDmPhR96yvDjRM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(4326008)(64756008)(8676002)(53546011)(8936002)(66556008)(9686003)(26005)(66476007)(66446008)(7696005)(38070700005)(52536014)(38100700002)(83380400001)(33656002)(66946007)(6916009)(122000001)(5660300002)(186003)(316002)(71200400001)(54906003)(86362001)(55016003)(76116006)(2906002)(478600001)(41300700001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGhoSCthYk5CTGF2bDcwSzlndmZ6NTY4TCtQdmNkUWF0YmltTHhRREQwTVNE?=
 =?utf-8?B?R0FKUlpmY0huZjhNZWtvcitPMDRXUndsM2RrMUw4WE9sMU1WMFB2SUYva0xj?=
 =?utf-8?B?RndnbWdvWGNNU3dZRlpJQUJET0t5WE5LdDJQTDhWYVpsUWxmRWJIK1M3RVdS?=
 =?utf-8?B?TW1TUXdTYUN4Rko1VENKT3lCS2w5dHhFTC83bnhrcjRMT1A4NzNrUVZ3WEcr?=
 =?utf-8?B?WFZrbG5qOTdIdGc5TXNXbTlMbFdJQTNlSGI4Wjc0OEJwVHA2d1VpSndmNUg5?=
 =?utf-8?B?VWZldzRBdDRGOXpmLzN6Z21XZlZhN25hRjEzSlRlUXJadzJrRHVxRE9xbVpi?=
 =?utf-8?B?ZEt0azNjTnh3Rmhjc2N5MzA3MnRjdXo4UDFiZGdCei9jWisxN3A1UndpaHBJ?=
 =?utf-8?B?NjVyQVB2ZENxUVZNWkhCWDZKejJaWHRXSUNtZHR3OTJsTUxMcXlPQ1ViWWVG?=
 =?utf-8?B?VzBxZEY3SndETUxYVEFOL0pkc2NoT2RzcllicjZKUnVRNWNGZ3hzUks3WUIw?=
 =?utf-8?B?TlhzUzVQaUZUc0pwMGI0K0tqZFJOQ2tpRGNqUVFkVG0vT2J6cHA3OW5UcXFo?=
 =?utf-8?B?ZlY5SnBzWjU2OExoZlRxcDJ1Qjhkc1phM2k5blQzTGllWkVPaEhRbWlmdFVP?=
 =?utf-8?B?Sm1zZzlYS2wxeWtCQ3JsRDJvTFRRZTFsUUIwTk52UE9jUFgxYXZCWmhMbURB?=
 =?utf-8?B?NnpmODgveHNqYXNjb1JXVmVLa0lzZjFEcjViQnpRUzhMYXRGRENaNXRodE1M?=
 =?utf-8?B?NFJxdHVFa1c3ZFpTM0U3Y3RDdUc4Z3FwMGNHVGRuVERQWDI3Wjc0dU84V0Rj?=
 =?utf-8?B?Y1RFQ2tIN1ZmZ1BhRHowbUZzU29JR3IrOGJqbWI3SUpVMEhZYS9hZ1FFT2Mv?=
 =?utf-8?B?R0xRQzllS2JxVTM3NXBsK25FNFFYQTJJWUo3U2JMZklvMjVNL2VvZzhIaHBl?=
 =?utf-8?B?Wjh5SWRXQTZQaUtZMXlWUi8wUllqb21OL2dkV0FpUEVxUENWL2ZGUzMxMWVO?=
 =?utf-8?B?ZmgrQlBUNjlGSU9BT2Z0T0J5czg4ajRjeTFYdnJBOEwrNVYrOWUyZ25oeTdG?=
 =?utf-8?B?cEgyN2xjUEd2aGUrWjlXWlo3NlA3Zk1BYVdkWk1ZVFV3R0dRdVhBMDJzKzNl?=
 =?utf-8?B?aVV0NXlOdUsvcFJSM2lGMk5GZ08ya21DYWY0OGZ4RFpEMHR3dmZpbThDeDVj?=
 =?utf-8?B?b2Q5UWtFZVY2TmoyWXhPalMzRm1yKy80N1EyVHBqeDcxSXZoeUhFMVhYUVRZ?=
 =?utf-8?B?bG9FQUM4SlBPNUVJWUlHRU0yT2c5Rko1djZ3QURnTXpMaTlrTVhWajNlQjVi?=
 =?utf-8?B?ZERnNDVSTENZQnkvb0VIVG85Q3BZMUlPcndpbmpjZEd4UHFtV3NWQmN5Qmxa?=
 =?utf-8?B?aHp3Ym9BQzlCOER4RmREMnMxVDUyd08rZHZrOEpjM0lXOEJDbDBHRlBZR0Rw?=
 =?utf-8?B?RlNSN29ZL1dyL3hXbWVFUGNHbE9vcUZBazlDVlY1Wk1yRkRET1ZWeHFoeHhD?=
 =?utf-8?B?dE1sT0d2NmE1ZHJ4Ky9CcDNXZ1JtMThjVE5oL0REZVhYa29zRUdDUkxzaVdQ?=
 =?utf-8?B?L0NJTVhzTXN6bU4vZDdHeStZaFVvZStqRW1jY1Fpenp2Vy9ZMjA0VEJnOXpu?=
 =?utf-8?B?bjdTU1JLRVRDY1FLcVNmak9COG4zOWdRMlNRUTJRQjJuUXpQWTZEb1hTRHJC?=
 =?utf-8?B?eWJMVVJUbzZxZW9qbk9JWm83eE5uUk5LRkZmVVI3WC9hQlhHbS9nQzYyb25k?=
 =?utf-8?B?RDcxRFA0STc1WW90RGFVUENRNFZkOHRYR2xvR1JDdVBDRnV5Mm5oeStHV1pv?=
 =?utf-8?B?d0orbGhLU0xSaGp0REZWMW1UdDJPRXdqakE1TGxDMUJZYjQ5Ti9EM0VOcFNz?=
 =?utf-8?B?OFlUVG4wUGRuWVViMXZsbGFQSVZlWU1VemZVU29SMDFZdDU1Uk83OVcyWDRX?=
 =?utf-8?B?V2VXUnA4NWNhUGZ5MFFzbERHNzNaNVZ2KzcwVmlETmVDbnBrMWhrTnB5OWlt?=
 =?utf-8?B?WVpzUTNBR0xMYXVjK3JJODMrdTYyRFVNbDI0NUJMVi9pbER4bmszK0dYZ2Zx?=
 =?utf-8?B?WFdSQVVaRlhZOE90WFRZZ1JHZjlVU3VZM28yUlg4ZzNMdk54TEkxL09pR2lG?=
 =?utf-8?Q?vDy4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb040c5-e35f-43fa-4f53-08da5a00060d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 18:48:57.3757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZrl2Q9AtNDBFD+f/euuHoZdo1dNAVdUw8Zc7CvpUsdKnW2otlZNrb2W7aayRx9vzBomTvXZj8Ek/hgi6Q659Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1
bmUgMjksIDIwMjIgMTM6NDINCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25j
aWVsbG9AYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9y
Zz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsNCj4gUGllcnJlIEdvbmRvaXMgPHBpZXJy
ZS5nb25kb2lzQGFybS5jb20+OyBTdWRlZXAgSG9sbGENCj4gPHN1ZGVlcC5ob2xsYUBhcm0uY29t
PjsgWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IEFDUEkgRGV2ZWwNCj4gTWFsaW5n
IExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcg
TGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIEFDUEk6IENQUEM6IERvbid0IHJlcXVpcmUgX09TQyBpZiBYODZfRkVBVFVSRV9DUFBD
IGlzDQo+IHN1cHBvcnRlZA0KPiANCj4gT24gTW9uLCBKdW4gMjcsIDIwMjIgYXQgNjo1OCBQTSBN
YXJpbyBMaW1vbmNpZWxsbw0KPiA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBjb21taXQgNzJmMmVjYjdlY2U3ICgiQUNQSTogYnVzOiBTZXQgQ1BQQyBfT1NDIGJp
dHMgZm9yIGFsbCBhbmQNCj4gPiB3aGVuIENQUENfTElCIGlzIHN1cHBvcnRlZCIpIGFkZGVkIHN1
cHBvcnQgZm9yIGNsYWltaW5nIHRvDQo+ID4gc3VwcG9ydCBDUFBDIGluIF9PU0Mgb24gbm9uLUlu
dGVsIHBsYXRmb3Jtcy4NCj4gPg0KPiA+IFRoaXMgdW5mb3J0dW5hdGVseSBjYXVzZWQgYSByZWdy
ZXNzaW9uIG9uIGEgdmFydGlldHkgb2YgQU1EDQo+ID4gcGxhdGZvcm1zIGluIHRoZSBmaWVsZCBi
ZWNhdXNlIGEgbnVtYmVyIG9mIEFNRCBwbGF0Zm9ybXMgZG9uJ3Qgc2V0DQo+ID4gdGhlIGBfT1ND
YCBiaXQgNSBvciA2IHRvIGluZGljYXRlIENQUEMgb3IgQ1BQQyB2MiBzdXBwb3J0Lg0KPiA+DQo+
ID4gQXMgdGhlc2UgQU1EIHBsYXRmb3JtcyBhbHJlYWR5IGNsYWltIENQUEMgc3VwcG9ydCB2aWEg
YFg4Nl9GRUFUVVJFX0NQUENgLA0KPiA+IHVzZSB0aGlzIGVuYWJsZSB0aGlzIGZlYXR1cmUgcmF0
aGVyIHRoYW4gcmVxdWlyaW5nIHRoZSBgX09TQ2AuDQo+ID4NCj4gPiBGaXhlczogNzJmMmVjYjdl
Y2U3ICgiU2V0IENQUEMgX09TQyBiaXRzIGZvciBhbGwgYW5kIHdoZW4gQ1BQQ19MSUIgaXMNCj4g
c3VwcG9ydGVkIikNCj4gPiBSZXBvcnRlZC1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNp
ZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgfCAx
MiArKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvY3BwY19hY3Bp
LmMgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4gPiBpbmRleCA5MDM1MjhmN2UxODcuLjU0
NjNlNjMwOWI5YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4g
PiArKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4gPiBAQCAtNjI5LDYgKzYyOSwxNSBA
QCBzdGF0aWMgYm9vbCBpc19jcHBjX3N1cHBvcnRlZChpbnQgcmV2aXNpb24sIGludA0KPiBudW1f
ZW50KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAgICB9DQo+
ID4NCj4gPiArICAgICAgIGlmIChvc2Nfc2JfY3BwY19ub3Rfc3VwcG9ydGVkKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgIHByX2RlYnVnKCJGaXJtd2FyZSBtaXNzaW5nIF9PU0Mgc3VwcG9ydFxuIik7
DQo+ID4gKyNpZmRlZiBDT05GSUdfWDg2DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBib290
X2NwdV9oYXMoWDg2X0ZFQVRVUkVfQ1BQQyk7DQo+ID4gKyNlbHNlDQo+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybiBmYWxzZTsNCj4gPiArI2VuZGlmDQo+IA0KPiBXaGF0IGFib3V0IGRvaW5nDQo+
IA0KPiBpZiAob3NjX3NiX2NwcGNfbm90X3N1cHBvcnRlZCkgew0KPiAgICAgICAgIHByX2RlYnVn
KCJGaXJtd2FyZSBtaXNzaW5nIF9PU0Mgc3VwcG9ydFxuIik7DQo+ICAgICAgICAgcmV0dXJuIElT
X0VOQUJMRUQoQ09ORklHX1g4NikgJiYgYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0NQUEMpOw0K
PiB9DQo+IA0KPiBpbnN0ZWFkIGZvciB0aGUgc2FrZSBvZiByZWR1Y2luZyAjaWZkZWZmZXJ5Pw0K
DQpJIGRvbid0IHRoaW5rIHRoYXQgd291bGQgY29tcGlsZSBvbiBub24tWDg2LiAgWDg2X0ZFQVRV
UkVfQ1BQQyBjb21lcyBhcyBwYXJ0IG9mDQphcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0dXJl
cy5oLCB3aGljaCBJIHdvdWxkbid0IGV4cGVjdCBpcyBpbmNsdWRlZCBvbiAheDg2Lg0KDQo+IA0K
PiBBbHNvLCB0aGlzIGlzIHNvbWV3aGF0IHJpc2t5LCBiZWNhdXNlIGV2ZW4gaWYgdGhlIGdpdmVu
IHByb2Nlc3NvciBoYXMNCj4gWDg2X0ZFQVRVUkVfQ1BQQyBzZXQsIHRoZSBwbGF0Zm9ybSBtYXkg
c3RpbGwgbm90IHdhbnQgdG8gZXhwb3NlIENQUEMNCj4gdGhyb3VnaCBBQ1BJLiAgSG93J3MgdGhh
dCBnb2luZyB0byB3b3JrIGFmdGVyIHRoaXMgY2hhbmdlPw0KPiANCg0KV2VsbCBhY3R1YWxseSBk
b2luZyB0aGF0IHRocm91Z2ggX09TQyB3b3VsZG4ndCBoYXZlIHdvcmtlZCBiZWZvcmUgNzJmMmVj
YjdlY2U3IGVpdGhlci4NCklmIGRlc2lyYWJsZSAtIGEgcGxhdGZvcm0gY291bGQgYXZvaWQgcG9w
dWxhdGluZyBfQ1BDIG9iamVjdHMgaW4gQUNQSSB0YWJsZXMgaW4gdGhpcyBjYXNlLg0KDQpJIGRv
IGtub3cgb2YgT0VNIHBsYXRmb3JtcyB0aGF0IHRoZSB1bmRlcmx5aW5nIEFQVSBzdXBwb3J0cyBD
UFBDIGJ1dCB0aGUgT0VNIGRvZXNuJ3QNCnBvcHVsYXRlIF9DUEMuICBQcmVzdW1hYmx5IGZvciB0
aGlzIGV4YWN0IHJlYXNvbi4NCg0KPiANCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTY4NCw5ICs2OTMsNiBAQCBpbnQg
YWNwaV9jcHBjX3Byb2Nlc3Nvcl9wcm9iZShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3INCj4gKnByKQ0K
PiA+ICAgICAgICAgYWNwaV9zdGF0dXMgc3RhdHVzOw0KPiA+ICAgICAgICAgaW50IHJldCA9IC1F
Tk9EQVRBOw0KPiA+DQo+ID4gLSAgICAgICBpZiAob3NjX3NiX2NwcGNfbm90X3N1cHBvcnRlZCkN
Cj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gLQ0KPiA+ICAgICAgICAg
LyogUGFyc2UgdGhlIEFDUEkgX0NQQyB0YWJsZSBmb3IgdGhpcyBDUFUuICovDQo+ID4gICAgICAg
ICBzdGF0dXMgPSBhY3BpX2V2YWx1YXRlX29iamVjdF90eXBlZChoYW5kbGUsICJfQ1BDIiwgTlVM
TCwgJm91dHB1dCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBBQ1BJX1RZUEVfUEFDS0FH
RSk7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
