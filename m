Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043BE55D76E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiF0Qy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiF0Qy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:54:56 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED5318B20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:54:55 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RBQ5bG024015;
        Mon, 27 Jun 2022 09:54:40 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gx1vkyn6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 09:54:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFDvShTmuk0b6UYjTqWA3WF6oPYXYqiBGsO47xzA9ilhwOvgMrWqaG/bxo88jtRKxvH0JPnFGeLoOf8GQqGd63Ziox+vm86xwXwBwfIb5zmAS4+RJUn70I7dtFnu29cVsl5qcZlDdCHdg19a3NPlH2yVKfHTdd3yFNSxzkr/LJTiWAsM+6yt/j+zKX10D/7pksw1YlgqWs2TJGjguqEtV1C5zQ26+FnPDViQLPJe+ilBQQ980BzelMzQV9LclHCb4DLII9lAmb9ImhsaDgriJWz/PoJ/SIVtxEw1dsZgGZJRgvgarSPi1qyoHpi3kP5JArfmPXCLenVr5vb3JoaRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuY/jrNj/yHQ3ltCwCi7kbCfnniez1PtimQNktb9ZzI=;
 b=og3Gu5wHGeiHS3m4uaBNHp3TpKD6qBK7KOL/BGrD9kCMDvl9rsjhvTqzQ4MsXyLYz3hLFnkt1W9neg5FSLH6gUZiIwzvzi6dxM4x0ZmT9SezlQ4rTruyMf9Y4/p3RzFyFi0GWJKRkSXvQ88juO1A32YU55LLRR9Oi/8HxyT9Hi3sP4bN+n4yn5PUGI/mpLMjvWFVXx2Q7rBrwyCmL/BigeZcgfYHxmTYnON7yz+Oh3MCAmosjDE/eMUcXX9Z/ZoiSEUNXdJDooEULyLBeyXKhQ3pOCCkZ9T/JCKP6andUmMfx6wm8zzmYI2YAIO3MIhgTjsV0Tyb9KSUU9RdHJ8+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuY/jrNj/yHQ3ltCwCi7kbCfnniez1PtimQNktb9ZzI=;
 b=Q/gN3TKkbdPSrWgI8hpso467WIbmfUHlJEf5Gha3dpprZIMq2xRkakIJx9is9DJWjnnoMfif808Wh3qyZGdqsyu8iRnd3JIH8K/q/Rmh8PWviUzOb6UbgP0lmyRKWGAZ0y5BJYS+TKLwn165uKPtRGIkPPgWXq8TEXuyRoY/56c=
Received: from PH0PR18MB5017.namprd18.prod.outlook.com (2603:10b6:510:11c::22)
 by PH0PR18MB5018.namprd18.prod.outlook.com (2603:10b6:510:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 16:54:37 +0000
Received: from PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::fdf2:92aa:7940:a6c8]) by PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::fdf2:92aa:7940:a6c8%8]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 16:54:37 +0000
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "james.morse@arm.com" <james.morse@arm.com>
Subject: Re: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support for TAD PMU
Thread-Topic: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support for TAD PMU
Thread-Index: AdiKRj05ogoh9I3iTLqgKkAn/V1j4g==
Date:   Mon, 27 Jun 2022 16:54:37 +0000
Message-ID: <PH0PR18MB5017F844A6045E9D9C846F79D6B99@PH0PR18MB5017.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d79cb730-fc1d-483d-cdb7-08da585db85f
x-ms-traffictypediagnostic: PH0PR18MB5018:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfzPh5ekNMokhfdEInwjFFKvcT3lxA6jILxIfp0Og6HUJtnrsWehNiwUfNtmk/A/d56OVYtawWPzdAc31iO/+jROkq718mWysg+mumM6y/3DJ3Mma7epC8gXmgOxLW4xbp2aoxXeeDglGaPbSsYQMdmn6TG1UoK+8fgESMmwSDUaI8l6Q3OR+ZvgqucGfDjLtwCKfVN8g7p7UpqAwoUmQ5eghzFL7XFU2FtUQ7wSEfnxFYbmU/WBXV2397d/bJtFTVY+l8hjxbW9J6POmBHVO6ENtjOpo1kxUs100pWyq8xWdzyWnRHZd57i6foWWUZIniDvWs4Yj0EdIh+yF07tYCVnrwKEQqz02uSN2xaJC0MsYdu200MYQLcuSZzHFX68I6UeV21C7oR+AfZRAsSaAS/7a3njZ5Seu5Q4a0OuH7Ht4wQ85ufV+CuihxZPp97feEZtBSAPcoCo11mrlbvUy4zcBGUzkgm8LGCaNaacRdR6ZFNJyjZOAdEFB+iW9lCtN9IMDibBlQBeVPaNkAQTq/4zFQG94qQFk1dG2i69s85AuLOzpDmHOLfsr3X+Qys5mnYzSLlP7Fde90H9fw+L/PlyHmYWt6Q1Ub3PkXhW9CQvh+/STTSAEnyo2uGPH9bxQQ+j4HaOJe1xE2DFpAWDsEWQ4JIQffr15p8+1OxMeYGXHLxpg47m3ElHEVH3gf68qrg16TRCqeMvIOGqdXrJWXsligg086GEZ0ZtMagvzaANhZ6rYwfzbU22QIx27ZdjqaOCBtRIbFPlazNurNCR87lPuTRpDC0vW/srZNIRSxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5017.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(5660300002)(316002)(110136005)(54906003)(52536014)(55016003)(2906002)(71200400001)(8936002)(8676002)(122000001)(33656002)(76116006)(41300700001)(186003)(478600001)(7696005)(6506007)(86362001)(53546011)(55236004)(26005)(9686003)(38070700005)(66946007)(66476007)(38100700002)(83380400001)(66556008)(4326008)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzY4ZUVIalB2NGt5TVpMbS90ai9IaUxyVmcwalRjZzNnWWVOUmRxY2Z2S0gx?=
 =?utf-8?B?ZFY5a1c0SGNndXh5NFgrdEY4K2o1aG5hMUVWREhSMUpvU21EelMvTmZJYnl2?=
 =?utf-8?B?ZHFQUGtaU3Q4MzlKbnJOZ28zMG0rQlY1dThlQ0k3VDMrMW4wYzR6cmNPWU9k?=
 =?utf-8?B?RjlyT0l5UnltdDZta2lEVXVQNGdtdkFjUVI0cWxGcE5tWUx0MVI2NGdlSzk4?=
 =?utf-8?B?ZXpnaUlFUUpOa1Fha3lUR1RWc3IxTVEzQndOWHZQZHZiMGVjMXl4bTMweWhT?=
 =?utf-8?B?SFBYUTFiSmJDY0twRzNQRDVPVDJiTkpEQ2JDNXdra2RrNFczMm1HbWRvQWQz?=
 =?utf-8?B?enZER2dYaVVoemZ3MnIrb1krWERBTENIdTVGVEF4WitKOHFjVWJiY0ZIaUF1?=
 =?utf-8?B?d0QxQjFPQzQ0d0t5OVRzUVRCZlkrdkJNSm5sWi9hSlBwV3BtRld1MXdHbU9Z?=
 =?utf-8?B?Rlo5SjBZNlJnTER5TG9kck5qMUJZZmdCL0ZZU0YvY3hWTXQvUW9SZ3gwYUF5?=
 =?utf-8?B?TVlZVEp2ckN5c29zQW5LYXBEUkl3WWNOUm5tT0Y0VHptcWZNOGRZbXdMY0JC?=
 =?utf-8?B?TlRaU0ZTSmNrWnErY3dQUFIzZjNMaVAvZ09CYnh3V2RWWkVZZEVHcW1WbTN3?=
 =?utf-8?B?aE1YbjFGcFMrQkRUbjBMMjZpS2d5YkV1Ulk1SUQzVit0amRVeHY3QUJ2cjdK?=
 =?utf-8?B?WC9hd1BuRG1QSE1vQkFzc3lNNlROR3lJNkh6WTlWNDBzUHVVc3RmMjN3WkFs?=
 =?utf-8?B?cE1XaG5RYWFzS0NWK05ieVR6QVRTOWIrdnN5cGNBSkViaGg3bTRoNzJzak5E?=
 =?utf-8?B?b1FTWWRqNVlueWhTeU5OU1VjbVB1enRRVlI4eDl2TnRsNGVTbzZ1b3NKZjNw?=
 =?utf-8?B?Qmg4c3hxbVpJa2dmTmZUTStoRXpyaE42YXBEa3V0OXpEQWNac0RmQThqNmNR?=
 =?utf-8?B?VWVESkwzajgrK2FIcGhhem8xbmc2d09ZNjh3RmxjL2x2RlN4eTc5eXQ1VHVx?=
 =?utf-8?B?b2lPblNOSXVOQ0V4QWo3Umo1OFA3enpNTmtxYVRsM0U0aUhoQnpNam9tRGJS?=
 =?utf-8?B?YXhkTGhiVXYzdDh6SlI2MVVZeHpQOXpzRXNGYjcrVGpJeFJ2SUVFNWQ4OXQr?=
 =?utf-8?B?YkdOb3RDV21YS3BwMFZQZW1DN3NCT0RSYThFWWxXQisyejcvQmJCS09rMi9Q?=
 =?utf-8?B?V29HQ0oyRUFyMktnUFB5V2VOelA4Q2FkSFd0eWlTTEZqbkhYY2Z2ZWVma2FB?=
 =?utf-8?B?dFBvSkFVd3VtNDcwYjAzUElyYjVsaVBUeklQbXJkTmx3NEZoZC9QNXlLRHRH?=
 =?utf-8?B?VUdNWEFUQ1Y1eEZub2JtT3I0TG9NaGtYcm9jOGZteVJsOGNpaEpmaXVObWo5?=
 =?utf-8?B?bW5uRHZINGl6MmY5VXpNMHZITFBrMFNzSDdRM0tRa0c1d2o2amtsaFdkQ1Nu?=
 =?utf-8?B?ajg4c1NId0xpRVpNZGgxU3luaDhaeE15UTl0SWY4QjlRV0xSUVNOQk0zYmpo?=
 =?utf-8?B?bEVoRFhVbVdKU1AwazdpM1pPVUMvQzc0YVFJeTVDRzBBTGtzOUhzUXJvTzRF?=
 =?utf-8?B?a1kvcnU5MDBSMU1uM3k0cTFBUTd6akxUM283Z0t5MTMycUhXK3U4djJSSTNT?=
 =?utf-8?B?S28xL2xjTVg0Y3JNME9DQXM3dGhHMUJ6YWRmL3N3QUhUb3MwUEpJQUVCYmlE?=
 =?utf-8?B?aVNIMDNZK04wcFM3Sm9zQURQUzFzamNka2xQN29lamxjK0tESk14dGM1U2E3?=
 =?utf-8?B?STY1MjY1SlFYNHVIMXpsbEdKUnZSbklOWHpJVkxYRTVFWURYb3paYThLNnBC?=
 =?utf-8?B?L000aTJQTGVwMmpoZkhTeVo3TDFEbmhRVlRnTFR5cEI0Yk9TTG5Gb285WUtr?=
 =?utf-8?B?aCtWc1pYK2l6TGRVemU1eHZ2ay9qYWNMd3JiaTBPdUJGVkhFdzZPUlY4NDli?=
 =?utf-8?B?bzk3aDgrUWQ2cFNxNHNDZTYzc0RTeHFwazMwYjhpSkxCNm1yTEZ0Y1cybm5u?=
 =?utf-8?B?Nng5bjVNOFZKSTQ4c3UwMXJsNGwrUWhqR2kwZUI1bllyT0pzTEVUSUZIcG11?=
 =?utf-8?B?SDdzQmFDcndnSmRQZTVZWDJxU0FUQnIzSnB3cmZGNkQ4RHkzYjVxUnozOTdp?=
 =?utf-8?Q?pj/68As46jLeyS4U98POCOpdG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5017.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79cb730-fc1d-483d-cdb7-08da585db85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 16:54:37.4679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOhOabbayQgaKJhr1TbWBI8T3dOT3VfD44Y0WRZxuLkWK9avl3UzeH8pvf3oQQYmooVkqDW3Zy+J6tGkAeo30Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5018
X-Proofpoint-ORIG-GUID: vjP7bao1_O-IL7da4dPQ_2o2CTe3angh
X-Proofpoint-GUID: vjP7bao1_O-IL7da4dPQ_2o2CTe3angh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCBhbmQgUm9iaW4sDQoNCj4gT24gMjAyMi0wNi0yNCAxMzoxNCwgV2lsbCBEZWFjb24g
d3JvdGU6DQo+ID4gT24gU2F0LCBNYXkgMjgsIDIwMjIgYXQgMTI6MjY6NDdBTSArMDUzMCwgVGFu
bWF5IEphZ2RhbGUgd3JvdGU6DQo+ID4+IFRoZSBUQUQgUE1VIHN1cHBvcnRzIGZvbGxvd2luZyBj
b3VudGVycyB0aGF0IGNhbiBiZSBmaWx0ZXJlZCBieSBNUEFNDQo+ID4+IHBhcnRpdGlvbiBpZC4N
Cj4gPj4gICAgICAtICgweDFhKSB0YWRfYWxsb2NfZHRnIDogQWxsb2NhdGlvbnMgdG8gRFRHLg0K
PiA+PiAgICAgIC0gKDB4MWIpIHRhZF9hbGxvY19sdGcgOiBBbGxvY2F0aW9ucyB0byBMVEcuDQo+
ID4+ICAgICAgLSAoMHgxYykgdGFkX2FsbG9jX2FueSA6IFRvdGFsIGFsbG9jYXRpb25zIHRvIERU
Ry9MVEcuDQo+ID4+ICAgICAgLSAoMHgxZCkgdGFkX2hpdF9kdGcgICA6IERURyBoaXRzLg0KPiA+
PiAgICAgIC0gKDB4MWUpIHRhZF9oaXRfbHRnICAgOiBMVEcgaGl0cy4NCj4gPj4gICAgICAtICgw
eDFmKSB0YWRfaGl0X2FueSAgIDogSGl0IGluIExURy9EVEcuDQo+ID4+ICAgICAgLSAoMHgyMCkg
dGFkX3RhZ19yZCAgICA6IFRvdGFsIHRhZyByZWFkcy4NCj4gPj4NCj4gPj4gQWRkIGEgbmV3ICdw
YXJ0aWQnIGF0dHJpYnV0ZSBvZiAxNi1iaXRzIHRvIGdldCB0aGUgcGFydGl0aW9uIGlkDQo+ID4+
IHBhc3NlZCBmcm9tIHBlcmYgdG9vbC4gVGhpcyB2YWx1ZSB3b3VsZCBiZSBzdG9yZWQgaW4gY29u
ZmlnMSBmaWVsZA0KPiA+PiBvZiBwZXJmX2V2ZW50X2F0dHIgc3RydWN0dXJlLg0KPiA+Pg0KPiA+
PiBFeGFtcGxlOg0KPiA+PiBwZXJmIHN0YXQgLWUgdGFkL3RhZF9hbGxvY19hbnkscGFydGlkPTB4
MTIvIDxwcm9ncmFtPg0KPiA+Pg0KPiA+PiAtIERyb3AgcmVhZCBvZiBUQURfUFJGIHNpbmNlIHdl
IGRvbid0IGhhdmUgdG8gcHJlc2VydmUgYW55DQo+ID4+ICAgIGJpdCBmaWVsZHMgYW5kIGFsd2F5
cyB3cml0ZSBhbiB1cGRhdGVkIHZhbHVlLg0KPiA+PiAtIFVwZGF0ZSByZWdpc3RlciBvZmZzZXRz
IG9mIFRBRF9QUkYgYW5kIFRBRF9QRkMuDQo+ID4NCj4gPiBJdCB3b3VsZCBiZSBncmVhdCBpZiB5
b3UgY291bGQgZG9jdW1lbnQgc29tZSBvZiB0aGlzIHVuZGVyDQo+ID4gRG9jdW1lbnRhdGlvbi9h
ZG1pbi1ndWlkZS9wZXJmIGxpa2UgbWFueSBvZiB0aGUgb3RoZXIgUE1VIGRyaXZlcnMgaGF2ZQ0K
PiA+IGRvbmUuDQo+IA0KPiBFc3BlY2lhbGx5IGRvY3VtZW50aW5nIGhvdyB0aGUgdXNlciBvYnRh
aW5zIHRoZSByZXF1aXJlZCBwYXJ0aWQgdmFsdWUgdG8NCj4gcGFzcy4NCldlIGNyZWF0ZWQgTVBB
TSBwYXJ0aXRpb25zIHVzaW5nIHRoZSByZXNjdHJsIGZpbGVzeXN0ZW0gaW50ZXJmYWNlLg0KRXhh
bXBsZToNCiAgICAgICAgJCBjZCAvc3lzL2ZzL3Jlc2N0cmwNCiAgICAgICAgJCBta2RpciBwMQ0K
ICAgICAgICAkIGVjaG8gIkwzOjA9ZiIgPiBwMS9zY2hlbWF0YSAoY29uZmlndXJlIDQgTDMgY2Fj
aGUgd2F5cykNCiAgICAgICAgJCBta2RpciBwMg0KICAgICAgICAkIGVjaG8gIkwzOjE9ZmYwIiA+
IHAyL3NjaGVtYXRhIChjb25maWd1cmUgOCBMMyBjYWNoZSB3YXlzKQ0KDQpIZXJlIGRpcmVjdG9y
eSBuYW1lICdwMScgY3JlYXRlcyBhIE1QQU0gcGFydGlkIDB4MSBhbmQgJ3AyJyBjcmVhdGVzDQow
eDIgYW5kIHNvIG9uLg0KDQpSaWdodCBub3csIHRoZXJlIGlzIG5vIGZpbGUgd2hpY2ggZXhwb3Nl
cyB0aGUgcGFydGlkIHRvIHVzZXJzcGFjZS4NCldlIG11c3QgcmVseSBvbiB0aGUgc2VxdWVudGlh
bCBvcmRlciBpbiB3aGljaCB3ZSBjcmVhdGUgcGFydGl0aW9ucw0KdmlhIHJlc2N0cmwgYW5kIHVz
ZSB0aGF0IHRvIGRlcml2ZSB0aGUgcGFydGlkLg0KDQpJJ2xsIHNlbmQgb3V0IGEgVjIgZG9jdW1l
bnRpbmcgdGhpcy4NCj4gDQo+IFRoYW5rcywNCj4gUm9iaW4uDQo+IA0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBUYW5tYXkgSmFnZGFsZSA8dGFubWF5QG1hcnZlbGwuY29tPg0KPiA+PiAtLS0NCj4gPj4g
ICBkcml2ZXJzL3BlcmYvbWFydmVsbF9jbjEwa190YWRfcG11LmMgfCAyMyArKysrKysrKysrKysr
KysrKystLS0tLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZXJmL21hcnZlbGxf
Y24xMGtfdGFkX3BtdS5jDQo+IGIvZHJpdmVycy9wZXJmL21hcnZlbGxfY24xMGtfdGFkX3BtdS5j
DQo+ID4+IGluZGV4IDI4MmQzYTA3MWE2Ny4uZjU1MmU2YmZmY2FjIDEwMDY0NA0KPiA+PiAtLS0g
YS9kcml2ZXJzL3BlcmYvbWFydmVsbF9jbjEwa190YWRfcG11LmMNCj4gPj4gKysrIGIvZHJpdmVy
cy9wZXJmL21hcnZlbGxfY24xMGtfdGFkX3BtdS5jDQo+ID4+IEBAIC0xOCwxMCArMTgsMTIgQEAN
Cj4gPj4gICAjaW5jbHVkZSA8bGludXgvcGVyZl9ldmVudC5oPg0KPiA+PiAgICNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPj4NCj4gPj4gLSNkZWZpbmUgVEFEX1BGQ19PRkZT
RVQJCTB4MA0KPiA+PiArI2RlZmluZSBUQURfUEZDX09GRlNFVAkJMHg4MDANCj4gPj4gICAjZGVm
aW5lIFRBRF9QRkMoY291bnRlcikJKFRBRF9QRkNfT0ZGU0VUIHwgKGNvdW50ZXIgPDwgMykpDQo+
ID4+IC0jZGVmaW5lIFRBRF9QUkZfT0ZGU0VUCQkweDEwMA0KPiA+PiArI2RlZmluZSBUQURfUFJG
X09GRlNFVAkJMHg5MDANCj4gPj4gICAjZGVmaW5lIFRBRF9QUkYoY291bnRlcikJKFRBRF9QUkZf
T0ZGU0VUIHwgKGNvdW50ZXIgPDwgMykpDQo+ID4+ICsjZGVmaW5lIFRBRF9QUkZfTUFUQ0hfUEFS
VElECSgxIDw8IDgpDQo+ID4+ICsjZGVmaW5lIFRBRF9QUkZfUEFSVElEX05TCSgxIDw8IDEwKQ0K
PiA+PiAgICNkZWZpbmUgVEFEX1BSRl9DTlRTRUxfTUFTSwkweEZGDQo+ID4+ICAgI2RlZmluZSBU
QURfTUFYX0NPVU5URVJTCTgNCj4gPj4NCj4gPj4gQEAgLTg2LDIzICs4OCwzMiBAQCBzdGF0aWMg
dm9pZCB0YWRfcG11X2V2ZW50X2NvdW50ZXJfc3RhcnQoc3RydWN0DQo+IHBlcmZfZXZlbnQgKmV2
ZW50LCBpbnQgZmxhZ3MpDQo+ID4+ICAgCXN0cnVjdCBod19wZXJmX2V2ZW50ICpod2MgPSAmZXZl
bnQtPmh3Ow0KPiA+PiAgIAl1MzIgZXZlbnRfaWR4ID0gZXZlbnQtPmF0dHIuY29uZmlnOw0KPiA+
PiAgIAl1MzIgY291bnRlcl9pZHggPSBod2MtPmlkeDsNCj4gPj4gKwl1MzIgcGFydGlkX2ZpbHRl
ciA9IDA7DQo+ID4+ICAgCXU2NCByZWdfdmFsOw0KPiA+PiArCXUzMiBwYXJ0aWQ7DQo+ID4+ICAg
CWludCBpOw0KPiA+Pg0KPiA+PiAgIAlod2MtPnN0YXRlID0gMDsNCj4gPj4NCj4gPj4gKwkvKiBF
eHRyYWN0IHRoZSBwYXJ0aWQgKGlmIGFueSkgcGFzc2VkIGJ5IHVzZXIgKi8NCj4gPj4gKwlwYXJ0
aWQgPSBldmVudC0+YXR0ci5jb25maWcxICYgMHgzZjsNCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4g
Pj4gICBQTVVfRk9STUFUX0FUVFIoZXZlbnQsICJjb25maWc6MC03Iik7DQo+ID4+ICtQTVVfRk9S
TUFUX0FUVFIocGFydGlkLCAiY29uZmlnMTowLTE1Iik7DQo+ID4NCj4gPiBUaGlzIGRvZXNuJ3Qg
c2VlbSB0byBtYXRjaCB0aGUgbWFzayB1c2VkIGFib3ZlPw0KQUNLLg0KSSB3aWxsIHNlbmQgb3V0
IGEgVjIgdGhhdCBpbmNsdWRlcyB0aGlzIGZpeC4NCg0KVGhhbmtzLA0KVGFubWF5DQo+ID4NCj4g
PiBXaWxsDQo=
