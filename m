Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F785A58E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiH3Bio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH3Bik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:38:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20A73932;
        Mon, 29 Aug 2022 18:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661823519; x=1693359519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YupAFta2ZZmT4x7uH+AGnk7KxbQ6Q/hsLuFQdp6/69M=;
  b=M5obQ2EadII2gqfEhRCpTHoloFrvxorILBXVfNAoV6CCiuION95rAw7h
   jisbbAmo0vuEZS9m5Fk+dn/fg3M824gi1bJvCidwylTadrn6bYIN/p7kP
   ROKwFVnj99egPryAdNbMQahfvFYJEaDH1kaH5YfT6ewvXH3Qde6QcKFOr
   btFMKko0/Kzuj7qHZjfhACfkxhjhbghcW+al8qLe8YjKk3H0qysOz+6GO
   yur9KFxLNARd0Kr0Gb4ucW5rgreVQSlu8qkk2kbrhOVUQ8QRvRNJZ7WzH
   T3FdJ24lzOsnJd5c/mHMxrfHKDPGzLmCZva+/08tfMwmnf7DapAiGfo2U
   A==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654531200"; 
   d="scan'208";a="314263267"
Received: from mail-bn1nam07lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2022 09:38:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2PwUTThaNIqbKn9faRkrvKF6sGXScC/fjO/JWFiHoHvM92Y0bCGd5zDHcV4c0No7+XfCyzijFWcN9Hd/Lz2lQBAzSSGgK05BkeAX7v8Hgj1xRVKqYQU2l6nOV3l2TUUDD7PlZWKepLAQuJXHQQ23yIHG2McUcea5eJ4yFd2i4DhpYdJzNNebp/J6I/Ihq3Q1hDUWntNoLpKeQUvVF174WgnecH0GSKSIzQNB0Vt40CoWlsFcRFOPDr1F0Pu7/JnS+mGstiNwozVz9+vz3ho18jLSVMYC4knsGAHH6vsxXUQZVy7dqDV8+qgifwqOiy3RbWjRBSm/ezMTPvfwe/rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YupAFta2ZZmT4x7uH+AGnk7KxbQ6Q/hsLuFQdp6/69M=;
 b=cdLL4dvre2MpZ9OdajietbipELweRE8CHIjyLvjf+CtHrxucpNsaeDRuhn+ccVGkezKv8RSpps0THwmcd/D/Qe+DcnOISJTLajIeZiv2IqMRIJQpAMXhuCj2wwkd9gLtudshevl/Y2U+AGagMktvhci/8kbalNs9aFBCcHFACefSTgLiI02cIG4EaTVBJSDZYrVBcvrb1Nqenli71+1TrvCFnAjEG7LjViZ4dxQgrl93DWSUqrZt47dw5UdRCLGfAn8hbOPZy+OV+ehqPsrron39q9MvMLJRPB57JxLFrHFKaomnBHRFBNi5vi9kQlYybORpsuNLNA7H0bk1ofpnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YupAFta2ZZmT4x7uH+AGnk7KxbQ6Q/hsLuFQdp6/69M=;
 b=vD7aKkhAx0eRmKjkyqTA5CW+9vmUhYV0t7wzeE41bjr0zrDL7+W23pS/5JoWQRTrKhHVX/FR1QsTi1hCoaOdfNp1Wf2MpoCJ9wUTqWLTU2InG7/GtGBRfaUpbMiGGMcMUlMvk71X3/636DwhpVjsdIfllilc2Ze4Sf8Y32OitAM=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by BL3PR04MB8155.namprd04.prod.outlook.com (2603:10b6:208:34a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 01:38:36 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::74bc:2d28:7316:8da9]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::74bc:2d28:7316:8da9%3]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 01:38:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Li Zhong <floridsleeves@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v1] drivers/ata/libata-core: check return value of
 sata_scr_read()
Thread-Topic: [PATCH v1] drivers/ata/libata-core: check return value of
 sata_scr_read()
Thread-Index: AQHYux8N79LlsiiSjkSFGyeLhIBGUK3GrDKA
Date:   Tue, 30 Aug 2022 01:38:36 +0000
Message-ID: <0b17a51f-1de7-600c-7379-c68cc8fbac60@wdc.com>
References: <20220828204443.1954661-1-floridsleeves@gmail.com>
In-Reply-To: <20220828204443.1954661-1-floridsleeves@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6f4bb7-d972-4952-3ef1-08da8a285b7b
x-ms-traffictypediagnostic: BL3PR04MB8155:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRQeCXvVbLaLfxVuOh3rtfjonyrzpcLZTHJtwkw/WZgvMUkh8elg4KvAfE2Jid4sYwkaRtHSvfdCAMKvC+NbVfLNNXVUUHLurKE8JSIZTNXRBWp3D78v9kBYBv1E4Ay+vcE5V5yGS54kXHqY5EY3fOatPf/Pc8QpqbTfT3DBjydHdnyn2jLDF+NnHT2a9LmqPbmmv2S2umIEkjhsTEF3ejkhbGiFDNh98p+Ho8FRTZN7MOHomhlUhfnv3b84o+Z+2tm9DvhO11RyrQIrUAJOGuBQ8deciInZP7UfCwtE8JvS5vJ31WHJEtzkpNdWtBXYgbLtMImAvgyS1r3AaQJLTDHXB36YcLI7FoVR4Bdm3/qogNMZoSeD/6tC6v18DqHG25joMumOTTqRPUVDLjC7cfN0zVxm3cEU59qBDePXflQUn+4ZUnbCqV0cuY3Gu5CKkYCK4OxtYDUHCGy6ErFD1BBnODykE75rXEEFhzAviOgQJtO52tG7/mXzLzk4XqxCvBsNabG3Js0Ubq0tPk3LMLnjQcOPJTiq6MnS4AaUZN7htHQHF5brpauY/ezzSlDsAOkxllVLdES19qI/DD7H0ZY56aAZZj3HDeiRvdGajlB87kWni7QC4RMdmgeAnpwY0NBmb8qDvFz3IZ9XTpJs8rNtNMJj3ckGjay18aOsWAcG3Ue182fbqhIIz0N4croxFNMnj4igC06v1XssBQRXbbizIXUe+mOMeApZfWf6kCntWDnhEO3BtbsOWMKkmLEsf7FH4DY6P/mUzcJr3fXNcvfhj5lbBKFiGz61Xna5eiO+EN4VTtkgL6/AYhXzbLSYDgcMsIbkH7aBGOcwEGQDPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(6486002)(8936002)(82960400001)(110136005)(66446008)(66556008)(66946007)(66476007)(31696002)(4326008)(8676002)(71200400001)(64756008)(316002)(31686004)(91956017)(76116006)(41300700001)(5660300002)(36756003)(38070700005)(86362001)(478600001)(6506007)(2616005)(53546011)(38100700002)(122000001)(6512007)(2906002)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0lrQnVTN01xN2VueTdRZXh6eE5sTUhlYXhkdDJSYUx2V1BiN29JRGNhd2N4?=
 =?utf-8?B?b091Um13MXk2OG9SRlg1MFN1NUpsV3d4VUVROW92QlJTWG11V0V3bVp1VE83?=
 =?utf-8?B?MXJ4cCt5TjJ5b2M5RnJWQWR3UDBBV1RkUVIwWU1iZEVDZFIvaG5zVitIUlJD?=
 =?utf-8?B?ZURLRVNEcFQ1c0lUQVJDTU1NcC9GOUpBdCs1QXp6YjMzTFhiM2dDeDE0OWVQ?=
 =?utf-8?B?K0U3ZEV6QnVQTk9TeTlna0JId2t4N2RFd2JGM3lZVnUzRjRQblAyakpaQjJF?=
 =?utf-8?B?WXVvSUk0bXpkTm5mekJ4TU4xZ0Z2dTBVbGZZOXpoalFMSWFJeEY4QlRmd1Q1?=
 =?utf-8?B?MCtvWlNEekQwN3ZEdU9xZlRjeEdUTEhORUhEQnpuTFE3VW8rNHh6eE1teVZK?=
 =?utf-8?B?Z2FGRjhGTEpxcEhxenBIUHkvcng3MGxmRFlockRFSjNZNlhzSW92dnJoWXNm?=
 =?utf-8?B?L3o5MzFpd21VYWFPSXBFS281MHFRYzczY0RyT2dnSlVDNVdUUmpzY0dMamxx?=
 =?utf-8?B?SWlvbVJwNG5pYkFtT0E5amcxbElXYnJDN09lbjBqMThWK3Jjb3ZLeUdnR2lk?=
 =?utf-8?B?TXZ1WU5GYVc5clBMUnJ3ZTQ5dUlTWlQ1K1BsdnVLNkVqb3RSNnQ1K1BsSmFh?=
 =?utf-8?B?OVE2TENJckg5N0FwZzljN3QwUSttbngzU2Ezb0JKTHN5V3V2TFdFQ01XVzJ6?=
 =?utf-8?B?bUpKeUVYUldaMWRRUUhpdG5jTjNQYUdOVTcrWUh1WFhlTG1rRVZZbERUUExT?=
 =?utf-8?B?QkhOSEtaa05ndU1BV2hEeTJ0SE5KWDNnRmtiK3FuRlVSaUg5N1J0NEVMTTNx?=
 =?utf-8?B?WWcwMGJYL0dLVlh2RkVGSDZncDBabTZ5OVJhYlNHYkV5WmJsOUlENEN2aEJp?=
 =?utf-8?B?MWY1WkNSTXpwZzFHcWNPRWZMY2hYRHNoVE1Pd2h6VnIxaTRDejhPZDFRY3RZ?=
 =?utf-8?B?dGRrZHIyRVhES29FdE1jTTE1M00zaStTVjQyRFJuTUJicHpYUlhNTHFTMWcw?=
 =?utf-8?B?SEErWUtucTdoMHNrSEdHbVh1YVM1cXJFSXhRRnppUkZUamZFSUdkS24zZ1Ny?=
 =?utf-8?B?ZlI4dXNRSUN2U3RlNzJlb1FYK3hrYjhrRmI1UTZDOUtuRjVTeWxLaG5EdERq?=
 =?utf-8?B?TUlUSFN2c1lHeEkxZ2djNG1ybVBJeHJIeE9oVmdhb2IzWUp5VHF6bnpzY3RW?=
 =?utf-8?B?VHZ6UnIrZmowMDlwQ3pvTkVuaW9OQXpXK1VTTnhvczB2QStUVENQMmFUbmRX?=
 =?utf-8?B?Q0pKSis1WUE3MzRNdXMyZVZHSjZkUDVDRExXUTNWY2NjR0c3V24zQ2lodmU3?=
 =?utf-8?B?ek9hdlovRVRhVE4xN0Zsc1NCRW1sbUh2SnY2eWpqUXZLdlFtdGE0QUVjM1Zw?=
 =?utf-8?B?MVNxU1hVekNWeXdqbk5leG42L2NINVFxTGlQWEpWdDRPY2FWeHNIanIzWmZK?=
 =?utf-8?B?T2U4Si9OZlViL0dTUnYxT1p3WENIVittNzk3YW5LMkRjZDRCdXg5TElJL3pn?=
 =?utf-8?B?OGJPU1U2aEQzWVZvQzYxQy9UZnI2UlRjcjJIMi9nQUJIL1VseWtuTjJTcXJ0?=
 =?utf-8?B?REF1M2xoRVNTYk5KdDNDdG9zWDJyc0Z2bFUrT3dVcXArZStOdURlTmVzeEhz?=
 =?utf-8?B?L29PeDdzS1BNSDU1MFF2Ull6cVA2Y0pGVlp3STNydUtKTjJXZHF1akxlTG0z?=
 =?utf-8?B?b3FiS0lBL3NCTldQZFBYNE1lK1c3cm5ZbTFxem1jak1KMmJqZHVGRldMRk8r?=
 =?utf-8?B?ZmdOZkV2UGpwZFRVR3l3Q1FJaEZHNk5LeHFVWmh1ZmdkYXhiTVp5SWlkSWwx?=
 =?utf-8?B?ajJkcHVmanBBR0hiR3BPMDJOckx4c1FZYi85ME5tSm1WQ0tzeVVLOTBFaFk1?=
 =?utf-8?B?bjVheExiMHlGNVRXakhDdEtEUGM0VThzMTZhNVBVQm9sbXlNdStxY3FIVHVI?=
 =?utf-8?B?elc2UFo3RWMrSzQrSVovWkR6d0YrK2hDSnRwSGZJamEyd0Z4T3ZsSWF5ZFYr?=
 =?utf-8?B?RjVnWDJ2NVcwd3JzWFFWTmdmTDVrYjJ2VWNoVHRYdWRvU0xhZzRMdVB5WWJu?=
 =?utf-8?B?bGdHNkIvS1I3YXJCaU9GNEl1UnNlaHhzeTA5c0hyaVFvaW1WVnY4b0QwVG5z?=
 =?utf-8?B?WmxRMjk1SFVqTG00cDZwVmo0M1ZnRUxCbiszUE5CVCt1bDJxdzJIM1VSQkdr?=
 =?utf-8?B?RmE3THRVbmNuVWlqZCtIc0lRWEMzT3lveHFMOUMrVEdoWHpRRElyWWhsNDZ4?=
 =?utf-8?B?dHk2YzRDSmhkTzZ6Tktwd3JUWG9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B0A53318A1C0B499AC121C082B941EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6f4bb7-d972-4952-3ef1-08da8a285b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 01:38:36.3850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRcKCcTZl9XY+pF6Tyg+92DDQs77uBr4l0RUpm2hwQbrZrCU2RyF7MaqXM+/njij9GT5b2o2M5RzfSQMVtOOLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8155
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8wOC8yOSA1OjQ1LCBMaSBaaG9uZyB3cm90ZToNCj4gc2F0YV9zY3JfcmVhZCgpIGNv
dWxkIHJldHVybiAwIG9uIGZhaWx1cmUuIENoZWNrIHRoZSByZXR1cm4gdmFsdWUuDQoNCkxvb2tz
IE9LIGFzIGEgZml4IGJ1dCB0aGUgYWJvdmUgc2VudGVuY2UgaGFzIGEgYnVnLiAwIGluZGljYXRl
cyBzdWNjZXNzLCBub3QNCmZhaWx1cmUuIFNvIHRoaXMgc2hvdWxkIHJlYWQ6DQoNCnNhdGFfc2Ny
X3JlYWQoKSBtYXkgZmFpbCB3aXRoIGEgbmVnYXRpdmUgZXJyb3IgY29kZS4gQ2hlY2sgdGhhdCBm
dW5jdGlvbiByZXR1cm4NCnZhbHVlIHdoZW4gcmVhZGluZyB0aGUgY29udHJvbCByZWdpc3Rlci4N
Cg0KQWxzbywgdGhlIHBhdGNoIHRpdGxlIHNob3VsZCBiZSBzb21ldGhpbmcgbGlrZToNCg0KYXRh
OiBsaWJhdGEtY29yZTogQ2hlY2sgZXJyb3JzIGluIHNhdGFfcHJpbnRfbGlua19zdGF0dXMoKQ0K
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaG9uZyA8Zmxvcmlkc2xlZXZlc0BnbWFpbC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYyB8IDMgKystDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYyBiL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMN
Cj4gaW5kZXggODI2ZDQxZjM0MWU0Li5hZTA4YzdkMzVjYjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvYXRhL2xpYmF0YS1jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYw0K
PiBAQCAtMzAyMSw3ICszMDIxLDggQEAgc3RhdGljIHZvaWQgc2F0YV9wcmludF9saW5rX3N0YXR1
cyhzdHJ1Y3QgYXRhX2xpbmsgKmxpbmspDQo+ICANCj4gIAlpZiAoc2F0YV9zY3JfcmVhZChsaW5r
LCBTQ1JfU1RBVFVTLCAmc3N0YXR1cykpDQo+ICAJCXJldHVybjsNCj4gLQlzYXRhX3Njcl9yZWFk
KGxpbmssIFNDUl9DT05UUk9MLCAmc2NvbnRyb2wpOw0KPiArCWlmIChzYXRhX3Njcl9yZWFkKGxp
bmssIFNDUl9DT05UUk9MLCAmc2NvbnRyb2wpKQ0KPiArCQlyZXR1cm47DQo+ICANCj4gIAlpZiAo
YXRhX3BoeXNfbGlua19vbmxpbmUobGluaykpIHsNCj4gIAkJdG1wID0gKHNzdGF0dXMgPj4gNCkg
JiAweGY7DQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA0K
DQo=
