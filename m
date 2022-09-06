Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6885F5AF767
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIFVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIFVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:53:32 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C03BADAD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjE1Lpy7qsKRwj/rPHQvDZ4wRmQBDiRyEOuxniKnDM4nf5VGDxUkhYYRPhGfKf2ZAZX/DLVP9G6gLOC2FuIdHuMPdvXEk4Egf6deFqyLzVd2SQPUNRmCCEAgBiZRhTlCc8uuGxxkXsS4vdWWlbauzTwjhA4CpSSHjxfinJO7GJqs6bYLetW2Tt/ckB6jiy81lfM7LectvqRK5S6ZKqFDVaHDJC7RnDyMludEGnTpVKlvZqLxJvK13yJUabZ6fUi9fL+vsrlIlIkgxn9xNK6C7VfEo7Bovq9+XsNTuUPfGpGaF0K/SC3BWH24Dwd613C7tmRcvw0fGKMYaTX2nrB9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4emhNmPXgRWdNXq9SFjC54dKE3W+gKD8Hk4s/jsmXLs=;
 b=kyqM1hLXDeX49wWrhSlN78TuFGQBXOh5dnnj+hpNKby4gQE15V9CeqfJxYbWNR+w21JFebuZv2qpZTzV+OaZK7QIdQ+JTfhJ43bo46UI4By1HspZjAI+xByKiqP5LvdAZ+7zTu0rplbSJXc0fooY99OCGlQrdR/nvCRwSHnUcyNTSyIYMAZx3LbTGFOnnYmxNVaA19vLgxZlXL4k8//Zk3TOVNK41gvZoODQ85sndczBS6JClJi1nzT/klR/g8wRCRFFWAuCj3/WiI/4Sgw5q9u2250OHPPa/AeBXIv7PejPZGmRBSzEvEZOZqQyvywPu9RQ7lsLAkPHoXvVgC8WIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4emhNmPXgRWdNXq9SFjC54dKE3W+gKD8Hk4s/jsmXLs=;
 b=Lw7WCnBwKxg61QfGQwUOZRV6513Zp2oJyek1a84t+eUmgp5jZCRfBnleDuBrZ6TcV579iDGF+jO76crwn+JffoVBv/qzrY8Jmj0sqDSgHVZsSv/HPIJHlTKo6BEq1/mGB49u97YH+Aba8g/b1TR43Y0x9NT5mp0H1sfGElp8nXHlgbv4Brb19N39nTeF4Y5Yp8tayrUHy+IVlxb7VccTmv0xUoey1KA6stjQPi1MHoxZINqAExr3zUM5AvRqm9JhLsxq9wJx8NBI6dwUGmPvEUZAU7ENyM5BbhoOinwv+OkH3KmfiS5fm9KYNUyVPXFeTMzNTFxCNV8zEb5+FH3jLg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Tue, 6 Sep 2022 21:53:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 21:53:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Niklas Cassel <niklas.cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Thread-Topic: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Thread-Index: AQHYwcPRcm6CrzlLu0+cYsV2b6mBrq3S8p0A
Date:   Tue, 6 Sep 2022 21:53:18 +0000
Message-ID: <d3b4ef13-62fc-1bf4-3a5d-3cc740df82b8@nvidia.com>
References: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
In-Reply-To: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 764ba18b-4ff0-40d7-c4d0-08da905235ab
x-ms-traffictypediagnostic: DS7PR12MB6215:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kbLljYZu7aRQzCHS/h0IAnH6+/zXfieF+AdFKt5tYpoxShzwE/8PrcBdqIv+4XSUE/MIk1HABogLZh4ATo9z/vIYw51xHUpVRTH6EDotq16HAvxTwB1VkitLUZbp/hFj1hUXcEYEO86dDTsTurnkbqPsHqkFFkXzx3ticYfdenAJ5G9cc+Vb+n4AQg20QY7su9pm2eolakkoN8TH++jaMKdoEsb/gvo8aSVRndqVt1XpuXfegwbuMB4iepL3DF3I6K/puQf2FErkbHG7PN3QLvns/R9WoGaOl5kMUbL/tjnSDZse7cLV3QnARYqhLI6EQLCFda/Y2AwiDpGzi7Ai3SjBQIPV68vlBZ6nBG+P5HOFDYk7ljCpPJepRODqh6sk0sY3sSIiEbhBXKdb+5+nfQLeQXjwdhTVWtwFTFsDfx6Fc2lJmotiXvlY6g2EivggoU9S5KSRs56uovELed1pk0MumA90hwHaTYnHioKxLvneiH9mCQY20xkgVEYBt8TDhIAVChQPtvIwDIj+w1wvoRfpNzyT1UjBAN6KYDDZAoIQ4XFmDM9UXn2XlchiKIn3bba6O4WSKjWx156Sl/GNkq5h9ZsRGDAS5lhMukfebGfEAikqh6JsBOysDaKQ0dHClw88vd5hwp4VsKCMQn+bbaC931u+e+0FW9bWBCW8CLiVMyXhElR/UQ9fbkMUHkwjZQk6cyG9OyNL/YuB8frx+N5rhFIk/9eWHI1NBU4kc73WFeFO/iC4PMxdW9mhzsK02RjgjjDKvPspwOU7qwHI+Ie20l6F94/hV7kpr35tg9eUFMC3upGRvm6T3SfBL/YRPQn/kGQv44ruvRk1Ie55g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(83380400001)(36756003)(66946007)(2906002)(186003)(2616005)(31686004)(5660300002)(53546011)(64756008)(316002)(76116006)(4326008)(6512007)(71200400001)(6506007)(8936002)(66476007)(86362001)(66556008)(66446008)(38070700005)(8676002)(122000001)(91956017)(38100700002)(31696002)(41300700001)(54906003)(110136005)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW84K0JTQzZCTzFNaHQ1TW8vMDdrSEdnMS9ObmJUam5nVkJoeXloczhGaHpS?=
 =?utf-8?B?NnlhRFNkL1UxZDRKSTlrYUd3RENIMjRMSHgxT1BZRVFZTm5MbnFqNmM2dHN3?=
 =?utf-8?B?ajJuMWo3YVEzMmFmYmVURUNBNkhHT3Azald1aDVrSlZ4ZmthUU5IcFhsVXhT?=
 =?utf-8?B?Zis1R1AwQlpyeXlvUHpLaWhmNW9MbmdFTlRPR2FhZmt4ODJoYzNPKzNOZmdi?=
 =?utf-8?B?KzJHS0VrWUc5VlBhcjFUR1FkUkliVTdyMzV6ckgzQkJLckx4c0ZsSXhGRVN3?=
 =?utf-8?B?ZmVBZWZlY0ZnekF4anNVWDlwYkxVdFlnL0txODdxYy9VajV1RFQ4N3NvL3gx?=
 =?utf-8?B?amswd1RoVzZKM0J6RTZiTnRTZDRDK1FzcFRNSXFyeEJTMk9haHdON21SMG0r?=
 =?utf-8?B?WlEzTUhUdFI2T0c3U1RHVzJqYjRuRW1aOUo1cndVRk1MT1VuUWtFNHpoSmVW?=
 =?utf-8?B?TmxsUVc0TlNVOEJDU1VQSmRWUkNGaWhNYWxNdDgyRjRGdzNHUHY0S21SaHVp?=
 =?utf-8?B?VW5mT2J5cm1kV24yZGZUWmdrMm4yMExuY1RsL2RPZXk0RE81aTMxaUNWQWUy?=
 =?utf-8?B?b2UxWFJPa09oSzcxM1BUYnlpUkl2NEJwR2htekdxMWNya054T0pYYUZnUFkv?=
 =?utf-8?B?OFZRamJyd0tzQ2wxTFJoWWFVTDVGNkV1QmgvdXlSRHZjbW9GSVpRYzRWdWc5?=
 =?utf-8?B?NEUvWkdCdU9sZHRzVE51UE5EbnhLbWFjcG50SkNidHlvaTdNN2VuZXA5eU1Z?=
 =?utf-8?B?QWJzN2dXSEs3d00yOUxzUXJ6V0tzeDhMMFlkOXpHbWdvTHF4MmJveXlCK3Fp?=
 =?utf-8?B?WnpHRm1McWlteEZuUXFvVnk0TWdHSkpPeWRaRmdQanpSd1dCR29wQmZNWWFl?=
 =?utf-8?B?Y2lRdFVtcTVtWTZPSktWdStoRXBmT01rK3B4ZkErTHhZVFZScllpM0drSjVK?=
 =?utf-8?B?UGhaS09telNjbUwxbVUwbTNRdVc5d0dBbVNVUXlnWmlTMS9sQW5iTW9Pd3Zr?=
 =?utf-8?B?Q0JQVk5MMi9KRTN0RzRoVVpMTzVmanJsSkxld0ZnNkZqZ1U3dS96cGM2NXYr?=
 =?utf-8?B?cHN2dnZBYnRIMUlxNWp5ZkxtSk9Fb2h1STd1cGFXV0RQLzUyRUFKWDd5NEEz?=
 =?utf-8?B?dE1ULy9udCtOaEozcklwc0xieDlrYzA1a2cwTjR4RnRrQmJXWGV2QVlZU3dl?=
 =?utf-8?B?NEg3MWVrdGltNG5sUlJwTVVPd0tDQjJQQng3RkpncGxIRGFJWGtBMVFBK1Bl?=
 =?utf-8?B?Y0o0S1ZuTWxtYnB4T2ZEb3RXa0xGbHNnQk13bDJKaktPZGt3cHVheXZFVysr?=
 =?utf-8?B?RmdZeDBBQkxZNHBrbTFlNGtSUVNHc09iWlZVUmhOaTQ2VU95TUtHbWREMlFH?=
 =?utf-8?B?eXhCaHBQYVlzbGk4OTBzbXFaekFnbDJEWEJqN2lFTXA0OEJvTEJ2SlI2YWRH?=
 =?utf-8?B?RXlvVEN2S2EzTVpidGh5UnNWZkVTYU5RYk9NYjd6MkdWaUhVTFM3d2I3bnBn?=
 =?utf-8?B?SzBCUU5IaitvRlBPa3VadHB0Nml1U1p1WXpxYlpoSTNZMmZwekErbHBDTmtm?=
 =?utf-8?B?QXpLSmlpQjcwOGpEQnVrSnFjajNTVzR5ZTBabnRQOGpibWpSYkNGRzVTa3Mz?=
 =?utf-8?B?dlc2TzArT2VGQU1NOUU0MEdFN3crL3lHZFcyaHpKSVk2a0JkU3hnb0dHVDk0?=
 =?utf-8?B?anpsQTA2NFRMTjUwcS91N3ljbnpKcFhBTGV1RnF4bDJmVjB6MlZpeXJNWW5v?=
 =?utf-8?B?cVU4Q1Uxd1FVNnZteXBCaDI4NWdMVWZaN3VENmdpaUd0YngxUHc1NGthWW9V?=
 =?utf-8?B?UDg4eGRuc1dQSUJyMlEvWTd2TFJZenVBT28xcmo0V2tWNE1vZGtRcFZ5ZDVR?=
 =?utf-8?B?WG1idGlrNkJCQkFnMHJJR0pnRXk5QW55TFVPT3ZMa1JRbDc5cmZ2RnNBUnFZ?=
 =?utf-8?B?d3d6cGREMGo3Rno0VWZwS0QrdTJGMnAxSmRXVW9vNTFxSXhLSU9XMFRlQ2lU?=
 =?utf-8?B?RFZCZk5DbmZCVWFoOGdjdFBRUHM1QzdTcjdoS1FhaThpSWxCTkk2Nk5QTHJ0?=
 =?utf-8?B?Nmt0dm1KWXZpSm5PVFZpYklPUG1QSnFVVDdHd1paZTNSY2RYZy83TExXc0ky?=
 =?utf-8?B?b3J1cjVHY0F5aWU5VTRWQ0ZTSWpjYWttazNhZGg0R09QamF1bjJER0E5RlBF?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D8E037758596743A02F37530E51D3FC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764ba18b-4ff0-40d7-c4d0-08da905235ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 21:53:18.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NL19gc4jch9BtF5A3ZXNT7zbqaScA1geAafrK+Xuzc2CysUhk4sBvEDsJ9Yrx/nKZt8BKjjlkg9LqPIZr6vwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS82LzIyIDAwOjM5LCBEZW5uaXMgTWFpc2VuYmFjaGVyIHdyb3RlOg0KPiBGcm9tOiBEZW5u
aXMgTWFpc2VuYmFjaGVyIDxkZW5uaXMubWFpc2VuYmFjaGVyQHdkYy5jb20+DQo+IA0KPiBNYXhp
bXVtIEFjdGl2ZSBSZXNvdXJjZXMgKE1BUikgYW5kIE1heGltdW0gT3BlbiBSZXNvdXJjZXMgKE1P
UikgYXJlIDAncw0KPiBiYXNlZCB2YWxlcyB3aGVyZSBhIHZhbHVlIG9mIDB4ZmZmZmZmZmYgaW5k
aWNhdGVzIHRoYXQgdGhlcmUgaXMgbm8gbGltaXQuDQo+IA0KPiBEZWNyZW1lbnQgdGhlIHZhbHVl
cyB0aGF0IGFyZSByZXR1cm5lZCBieSBiZGV2X21heF9vcGVuX3pvbmVzIGFuZA0KPiBiZGV2X21h
eF9hY3RpdmVfem9uZXMgYXMgdGhlIGJsb2NrIGxheWVyIGhlbHBlcnMgYXJlIG5vdCAwJ3MgYmFz
ZWQuDQo+IEEgMCByZXR1cm5lZCBieSB0aGUgYmxvY2sgbGF5ZXIgaGVscGVycyBpbmRpY2F0ZXMg
bm8gbGltaXQsIHRodXMgY29udmVydA0KPiBpdCB0byAweGZmZmZmZmZmIChVMzJfTUFYKS4NCj4g
DQo+IEZpeGVzOiBhYWYyZTA0OGFmMjcgKCJudm1ldDogYWRkIFpCRCBvdmVyIFpOUyBiYWNrZW5k
IHN1cHBvcnQiKQ0KPiBTdWdnZXN0ZWQtYnk6IE5pa2xhcyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxA
d2RjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIE1haXNlbmJhY2hlciA8ZGVubmlzLm1h
aXNlbmJhY2hlckB3ZGMuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gICAgICAtIEFk
ZCBleHBsaWNpdCBjaGVjayBpZiBibG9jayBsYXllciBoZWxwZXJzIHJldHVybiBhIDAgYW5kIGlm
IHNvDQo+ICAgICAgY29udmVydCBpdCB0byBVMzJfTUFYLg0KPiAgICAgIC0gQWRkIEZpeGVzIHRh
Zy4NCj4gDQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC96bnMuYyB8IDE3ICsrKysrKysrKysrKysr
Ky0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC96bnMuYyBiL2RyaXZlcnMv
bnZtZS90YXJnZXQvem5zLmMNCj4gaW5kZXggYzdlZjY5ZjI5ZmU0Li5lYWU4MWY5MzkwNjcgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvem5zLmMNCj4gKysrIGIvZHJpdmVycy9u
dm1lL3RhcmdldC96bnMuYw0KPiBAQCAtMTAwLDYgKzEwMCw3IEBAIHZvaWQgbnZtZXRfZXhlY3V0
ZV9pZGVudGlmeV9jbnNfY3NfbnMoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KPiAgIAlzdHJ1Y3Qg
bnZtZV9pZF9uc196bnMgKmlkX3puczsNCj4gICAJdTY0IHpzemU7DQo+ICAgCXUxNiBzdGF0dXM7
DQo+ICsJdTMyIG1hciwgbW9yOw0KDQpjb25zaWRlciA6LQ0KICArCXUzMiBtYXIsIG1vcjsNCiAg
ICAJdTY0IHpzemU7DQogICAgCXUxNiBzdGF0dXM7DQoNCj4gICANCj4gICAJaWYgKGxlMzJfdG9f
Y3B1KHJlcS0+Y21kLT5pZGVudGlmeS5uc2lkKSA9PSBOVk1FX05TSURfQUxMKSB7DQo+ICAgCQly
ZXEtPmVycm9yX2xvYyA9IG9mZnNldG9mKHN0cnVjdCBudm1lX2lkZW50aWZ5LCBuc2lkKTsNCj4g
QEAgLTEzMCw4ICsxMzEsMjAgQEAgdm9pZCBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2Nuc19jc19u
cyhzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQo+ICAgCXpzemUgPSAoYmRldl96b25lX3NlY3RvcnMo
cmVxLT5ucy0+YmRldikgPDwgOSkgPj4NCj4gICAJCQkJCXJlcS0+bnMtPmJsa3NpemVfc2hpZnQ7
DQo+ICAgCWlkX3pucy0+bGJhZmVbMF0uenN6ZSA9IGNwdV90b19sZTY0KHpzemUpOw0KPiAtCWlk
X3pucy0+bW9yID0gY3B1X3RvX2xlMzIoYmRldl9tYXhfb3Blbl96b25lcyhyZXEtPm5zLT5iZGV2
KSk7DQo+IC0JaWRfem5zLT5tYXIgPSBjcHVfdG9fbGUzMihiZGV2X21heF9hY3RpdmVfem9uZXMo
cmVxLT5ucy0+YmRldikpOw0KPiArDQo+ICsJbW9yID0gYmRldl9tYXhfb3Blbl96b25lcyhyZXEt
Pm5zLT5iZGV2KTsNCj4gKwlpZiAoIW1vcikNCj4gKwkJbW9yID0gVTMyX01BWDsNCj4gKwllbHNl
DQo+ICsJCS0tbW9yOw0KPiArCWlkX3pucy0+bW9yID0gY3B1X3RvX2xlMzIobW9yKTsNCj4gKw0K
PiArCW1hciA9IGJkZXZfbWF4X2FjdGl2ZV96b25lcyhyZXEtPm5zLT5iZGV2KTsNCj4gKwlpZiAo
IW1hcikNCj4gKwkJbWFyID0gVTMyX01BWDsNCj4gKwllbHNlDQo+ICsJCS0tbWFyOw0KPiArCWlk
X3pucy0+bWFyID0gY3B1X3RvX2xlMzIobWFyKTsNCj4gICANCg0KYWJvdmUgMTQgbGluZXMgb2Yg
Y29kZSBjYW4gYmUgc2ltcGxpZmllZCBhcyBpbiA0LTUgbGluZXMgOi0NCg0KbW9yID0gYmRldl9t
YXhfb3Blbl96b25lcyhyZXEtPm5zLT5iZGV2KTsNCmlkLT56bnMtPm1vciA9IGNwdV90cF9sZTMy
KG1vciA/IG1vciAtIDEgOiBVMzJfTUFYKTsNCg0KbWFyID0gYmRldl9tYXhfYWN0aXZlX3pvbmVz
KHJlcS0+bnMtPmJkZXYpOw0KaWQtPnpucy0+bWFyID0gY3B1X3RwX2xlMzIobWFyID8gbWFyIC0g
MSA6IFUzMl9NQVgpOw0KDQo+ICAgZG9uZToNCj4gICAJc3RhdHVzID0gbnZtZXRfY29weV90b19z
Z2wocmVxLCAwLCBpZF96bnMsIHNpemVvZigqaWRfem5zKSk7DQoNCg0KZWl0aGVyIHdheSwNCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg==
