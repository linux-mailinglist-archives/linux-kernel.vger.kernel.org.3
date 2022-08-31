Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0C5A791E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiHaIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:34:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C38C1650
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661934845; x=1693470845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MyXAmZ0IejXOBRPce8owp3m/AjDie3c+u5mdqD220VI=;
  b=eVRx+xP4Tq+++Gk0lPAOTtMqs0uRryUv0KWQqZYQpIyk3AebHUPHWIxX
   XNt96Z4iHHe+6zg0e+vbqQ6gGiEyeDQ17vPPqoIm8x/yRoG7+vwLV/qRQ
   aOAk8B6fRlAjYIzrtOxNZzv2hqkngz5zTTs3niEsW4e5a9oVrF0sQMOT1
   +WnivUzS5BiuQn44OZdgfax6uX+JY8WSTfsieuc8yKPzCsYZeORP6TZPK
   TR6eFnwFkFEca9t3py4JpD3nmnk82NaiA/QYgVmYhKsoHZQr8LcwU/m4a
   /gEgiuXcOaaBjd+5Oa3Q1aLDGCJTWzo+ApE1eObKTeVqwFCtZkMJS+JXf
   w==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="188788735"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 01:34:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 01:34:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 31 Aug 2022 01:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSSMF6TQVb7FcXxRMO2/pT65E+EKqotdVIXTSbhTACVd12xGnbwIb0lptTN6hyJ1cusVP42zP/KNQeN3777VFDfhOgmouV9KCCxdvX/m+urd5PD12u47DV/a6cjfl0h51vALZi/Anev01gRapIrEI2XNB4c/Gac3lcy3pY1zV/7/ySUQtyNiOgQfaCgVvE+f0MyOMk7QotbXKu37tHfQSOc+IKWIcuKWogAzAnuAvEOe4ndm3yvEMZEakANqBLXA7pbRVI0dupayRcqZHjxSmHXvyvIECKYh5VYul5YxvzNmKRWAZyNzXzJLiPu5kTBQmTO7PA9xjnegX7SsO0TXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyXAmZ0IejXOBRPce8owp3m/AjDie3c+u5mdqD220VI=;
 b=iQNXI9MuceQtkmKdWQewdYsqEH8gu9MA5vEHVsBpTMEOSn5+2Y737Ib/TQ9hie9QfIXETfZQ0u29W31l0pe/OPDzm+qNz0vaCAEKHk0rtvWeXnqSd/8WHdA4aC8iT67UERcNgLPF6ivpV2j+jEbMATH4xHKnex+dgr2OTGCk0DwZ/NqtqN34X9VBnm1h6xzZwpD0mOkj2NYPvGlcQIzaDTy3dDxDCtQ6dmd1tp1pFFddkJH8+24vYtzBT2paWcJlT0SZuLM9laPai1/AkIViUfRBOnQaEUy18durYSx9qt4HbaB1oYbiP1jrLamB8EEOyzab/lglq7OhUgZmJUgHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyXAmZ0IejXOBRPce8owp3m/AjDie3c+u5mdqD220VI=;
 b=Oqplorntic9Wfak5dTLLAU98IOfqLTAoL6iExqn2V9NozgVdoMWxFJSiwD02+aCoOvau0G4EYpcPl22EhwGzn7u292zkwm/AseJLE1LGbF+bXrKmi4Ye3uDQHJxeLsTgR3ARHHyb6GIP306zY58AilkFMK2TUJgdDzKEl9bbXO4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CO1PR11MB5122.namprd11.prod.outlook.com (2603:10b6:303:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 08:34:00 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 08:34:00 +0000
From:   <Conor.Dooley@microchip.com>
To:     <chenguokai17@mails.ucas.ac.cn>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>
Subject: Re: Resend for Pure Text: Re: [PATCH] arch/riscv: kprobes: implement
 optprobes
Thread-Topic: Resend for Pure Text: Re: [PATCH] arch/riscv: kprobes: implement
 optprobes
Thread-Index: AQHYvO/eaHU6+YdQhkeJ6FHUUeiIQa3Im1yAgAARTQCAAAI5gA==
Date:   Wed, 31 Aug 2022 08:34:00 +0000
Message-ID: <e25608de-1e4b-7f8b-9879-2d2fd96a7f8f@microchip.com>
References: <20220831041014.1295054-1-chenguokai17@mails.ucas.ac.cn>
 <882e9efc-7222-c3af-e37b-f339789e94c0@microchip.com>
 <45BFA130-3B41-4FDA-896C-2FD78F854399@mails.ucas.ac.cn>
In-Reply-To: <45BFA130-3B41-4FDA-896C-2FD78F854399@mails.ucas.ac.cn>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c92ed7d4-f781-4061-1db8-08da8b2b8dcc
x-ms-traffictypediagnostic: CO1PR11MB5122:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e//1mEpCwcLzXvWw6alq8RksXmtA6UQhFqjcC3fwLW67oylXXjVLZGAJ1sMwe3t42eKoymaVPYmedpt+QXyqkxcfyZIn/eaf1x9FYYu0caQa7wwnmTkS6NcqfUm0eB8szpelrEwm6Pu47JdWzFVXExxDw1MzW12lDfsEHweT7gj1M2RtiBWo/48feUUb25bpd2tq4zG9US1vLgJjzEmYPwMspwmvbx54Rrs3V1PrqhpcBHoHTV0REXLnA0lhYiTzOf1zlED3uXBCaA0P6Q94J1UqtdYMb0NtPNAocf/N1xGsgiAnUIljs6ivTqJ1RbKqGak8mpvs1nqlhjjjgcioRe3L2CUqrWVonC73TyABCVleljqbM46HkxLSaqT27KIzIYggopUadJccSWjfuqZfAyQ3Fx/1576o0QOf4FbdEEf6uDkq1sBn1qE5UdekYDg7cKYZNXXziuBlYT+Fe+C/ASUeN3TwhsMb5lSCRQHYmDU7RuQpGY2rMlgJ4coE7d9d6tKncOKsNVKgM0zEavOgNHO5oAX0i6YzHBS4QlKAAmeWeQede8DK7UIu9nL5pssblmDkZsrvhxg/5uprQbqQRlzN6w46TE13KalkI5TwY8mArapaI8qymEfY/8EvWauahQJhFf4OuTjAoUn0rJL07pnCDjoOqoWX8fKp/DKf+bKY0XeOi1QZv9kz7LtHes9Yq0HARsixJSHOvOG6ipNFfvpVIuJhVhmDyX8OjXb12RpMPY/7t/EWk4MhSDHMx3FgwXATpEv2smKQWD6VvVrb1CG7QccdaQfceYCqDofCT68W1AMHgcW5ex3oSqSww4c+QxQ4uiSx59MpQD0FCdcsmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(366004)(136003)(39860400002)(91956017)(186003)(2616005)(71200400001)(316002)(6916009)(36756003)(6512007)(31686004)(26005)(2906002)(53546011)(6506007)(31696002)(38070700005)(122000001)(66946007)(66556008)(7416002)(8936002)(478600001)(5660300002)(54906003)(66476007)(6486002)(41300700001)(86362001)(4326008)(38100700002)(76116006)(66446008)(8676002)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3JxeVRCU2F3R2FjODVFUUlUU1VWcHQyWEdnaVBCY0hXWUdXWHlaZUZPa2Mx?=
 =?utf-8?B?VUVIYlZLWGkzcFUwQkpGdzNybXlkR3RUeDVGeEhYZC8yWUZJQXh4eE5IYTlh?=
 =?utf-8?B?Z1JGOGhGOHpDRzc0ZThuNWpVTThyRFFLU2J1WDBzRUhyVE9SalRndkprWGpn?=
 =?utf-8?B?THVoWkI3MFJ2SlpNSHdxKzd0ZFd5OWJTdjVyaDRLWDlKZEl2Ti82OTV5dWJr?=
 =?utf-8?B?c0VacW9HSlM5eGFKY3V0a2kxQkpHVDdyaGxsQXByVnVESGxZVjI5T0YwUVFl?=
 =?utf-8?B?MFVqQkMzK2ZXU1hVT05sQVRuYTQzN3d2NmVmQkZKR1huRGdXK2FVUVRlTHVP?=
 =?utf-8?B?Um5NWXlTY2I3Wjd0L1ZKalRySmQ2aVhjMzIrY0JaVzJhaVZGQXE0U1NhVkEz?=
 =?utf-8?B?Tng2djBSbjBrWEhwcVI3T2U1VklZamc0bFY0aFYrSmZiTmVuU3RWdlZ4NnA1?=
 =?utf-8?B?cCt2bTZNTXpIak9pOStJQ2dBUmpnbWxOcEF0NU8wSHNTVDNCT3Z4N1VKT0R6?=
 =?utf-8?B?VlRMS2VyaGc1K3AzVzVIUmsvL1h3QUtxVHhFaTY0azh4dGt6dVZpRlR6RFhq?=
 =?utf-8?B?V0pQUUptVHc3bUdDNk8xci9mUHlMR2tNdjJYbndSWGw5b1F0ZmdXWElIYWlj?=
 =?utf-8?B?YTlYNmt0WXlNT1pzTjFJSGhpdUJCdnBiOUpOQWZvZXAzVTNHYnFTbFJmOG9h?=
 =?utf-8?B?YzVuak1DK2l5T1gzSEhncUpneWFMNjBDSXU4WlMxMmVFUkxwMGc0Qk5PU1Bn?=
 =?utf-8?B?OWhGOGxyemNEc3oyb0t2K3B3VGhibUxzbU91SG03SzZ6Mm5zYXJneVMxRXU1?=
 =?utf-8?B?aEpVR2QwWWk5a1UveE41QUI1MjN5d3ZGbWdvQTFTM0t0aS9COVI4QkVTbDZw?=
 =?utf-8?B?ZzZQcUx6NGIzMi9lb0YzdjdGaDVSbTVJOEFGYW5SMCswT2JTUG1aa1VER1hO?=
 =?utf-8?B?SmdTZVpkeVI4L0lMeW83Q2NIamdCNXJsKzZUL2xSZ3k4dEdUSjcyQnZrc2xH?=
 =?utf-8?B?K0dlb2MwaFdtandyNHQ4ZmxHNUtwcXY0Rll2amhEVnhTaWFIMDVLRnI1Ui9J?=
 =?utf-8?B?ZFo3ZmlSb1VodU5odnJvaDY2clltMmtoM1N0MCttUnFyOThZcm9zSG40cENq?=
 =?utf-8?B?ZXQ2a1RVS1FLSlB2cmxPdlVqajF5SkxjUmZJWUw1bWw4Nm5PaFY1VkF5UDM3?=
 =?utf-8?B?clE4R0NMT0RCblppdDlSNWlaTE5yMVNFWGQxb2lhTm5VUnU4QjJYR3ZZUWRV?=
 =?utf-8?B?aEt5OWlqWTVlenJyVXhiR2haR04wNnovbFpQL0dGOGpFRjl3YW03eHc4RWw1?=
 =?utf-8?B?Mk1iTHRYTDZSNXFrRGdXN281ZFhDM2dWdTJRa1RwcjZ5NnlGQnJMR0I3UU85?=
 =?utf-8?B?eEt2UXk2anRISzVWSzA4T1hoYzEwNlM2eFlUdUNaejhoUXdGSThxcERWZDZq?=
 =?utf-8?B?cVJwanNTU3dtbTJaSGJaQ3ljdERrUTRxbkJSV0tvYkJTbUlzSjRYWmtFUUFI?=
 =?utf-8?B?dmZGN3d5LzFuTS91TkY4VmFBR20yNTFPaWgyQ3FGSGtqb3ZtUUZPMTBKRFRO?=
 =?utf-8?B?blJhMng5N3I2c2Uvb3pXbVFPcnRLaGJWS0srWnRrZ0F6bnlPczc0MTQ0Tzk3?=
 =?utf-8?B?VEs0cXBJZ0FsMGE5a2VNQkp0bXcvL3l0MUdTMGowY3pMbUJWRjJ2d0t3QnNr?=
 =?utf-8?B?dDBETXBoMDBZeHJQU1U0UFFMOFV3OUVncDFFUmpiR2RZTk9VL3ZQUFowbW1n?=
 =?utf-8?B?RGk5a2hydkhZZzErckxVN1A3WU9uOWMxUW1TYm1BZmNXdGpsTFBMb3ZuY1Az?=
 =?utf-8?B?TmtnblhKUGVnWHE5N0lXR3l2c2dzU2FHMVd6OUZ2YXg0TlpVMXZOeXppSGdu?=
 =?utf-8?B?M1JjV0o0Y3JtRWZjVUk4TzBrS3hhNTY1My9NcDI1elZFVnRCQ2RpQVpFdVZi?=
 =?utf-8?B?THJxN1V4SnZGUFFoMndPTDFsRTY1cnBNYldZN25YR2dIRXcvTGYweU5hOHUv?=
 =?utf-8?B?ZkpOYjVaSUNXNFFwZnpwUG9VWVBpeENveGJmSmdqM3hnalpDRTlFdWw5OWRj?=
 =?utf-8?B?SHE5cEFPaDBodzFHdEs5cDV5dXhHZXdqekRpTkp3TWMxelBFSUFRNURETG5i?=
 =?utf-8?Q?32v6xflFIWq5rzlXHcc+pIr5g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A171ACEEE9186E4594A4FD5722CBEDE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92ed7d4-f781-4061-1db8-08da8b2b8dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 08:34:00.4696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byCrYi+JGFjESs25t71B2RdJSO+9wfSwbfdKh/rxaqHkaOhxovvUxquDByGMMBhAhkazIguQiJ/kztPHeC0orOAabfq69dTNnU1DYT4dk78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5122
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEvMDgvMjAyMiAwOToyNSwgWGltIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4gDQo+IEhpIENvbm9yLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHJldmll
dyEgSSB3aWxsIGNvcnJlY3QgYWRkcmVzc2VkIGlzc3VlcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0K
PiBJIGhhdmUgc29tZSBleHBsYW5hdGlvbnMgZm9yIG90aGVycy4NCj4gU29ycnkgZm9yIHByZXZp
b3VzIGZvcm1hdCBpc3N1ZXMuDQo+IA0KPj4gMjAyMuW5tDjmnIgzMeaXpSAxNToyNO+8jENvbm9y
LkRvb2xleUBtaWNyb2NoaXAuY29tIOWGmemBk++8mg0KPj4NCg0KPj4+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogQ2hlbiBHdW9rYWkgPGNoZW5ndW9rYWkxN0BtYWlscy51Y2FzLmFjLmNuPg0KPj4+IFNp
Z25lZC1vZmYtYnk6IExpYW8gQ2hhbmcgPGxpYW9jaGFuZzFAaHVhd2VpLmNvbT4NCj4+DQo+PiBX
aGF0IGRvZXMgTGlhbyBoYXZlIHRvIGRvIHdpdGggdGhpcyBwYXRjaD8NCj4gDQo+IExpYW8gaXMg
bXkgbWVudG9yIGluIE9TUFAgMjAyMiBob2xkIGJ5IElTQ0FTLCBDQVMuIEhlIGhhcyBiZWVuIHRh
a2luZw0KPiBhbiBhY3RpdmUgcGFydCBpbiB0aGUgZGVzaWduIGFuZCByZXZpZXcgcHJvY2VzcyBv
ZiB0aGlzIHBhdGNoLg0KPiBQLlMuIEluIHRoZSBmdXR1cmUgcGF0Y2ggdmVyc2lvbiwgSHVhd2Vp
IHJlbGF0ZWQgY29weXJpZ2h0L2F1dGhvciBpbmZvIHdpbGwgYmUgZGlzY2FyZGVkLg0KPiANCj4+
DQoNCj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvcHJvYmVz
L29wdC5jDQo+Pj4gQEAgLTAsMCArMSw0ODMgQEANCj4+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+PiArLyoNCj4+PiArICogIEtlcm5lbCBQcm9iZXMg
SnVtcCBPcHRpbWl6YXRpb24gKE9wdHByb2JlcykNCj4+PiArICoNCj4+PiArICogQ29weXJpZ2h0
IChDKSBJQk0gQ29ycG9yYXRpb24sIDIwMDIsIDIwMDQNCj4+PiArICogQ29weXJpZ2h0IChDKSBI
aXRhY2hpIEx0ZC4sIDIwMTINCj4+PiArICogQ29weXJpZ2h0IChDKSBIdWF3ZWkgSW5jLiwgMjAx
NA0KPj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgSHVhd2VpIFRlY2hub2xvZ2llcyBDby4sIEx0
ZA0KPj4+ICsgKiBDb3B5cmlnaHQgKEMpIEd1b2thaSBDaGVuLCAyMDIyDQo+Pg0KPj4gU2hvdWxk
IHRoaXMgbm90IGJlIHlvdXIgVW5pdmVyc2l0eSBoZXJlPw0KPiANCj4gTXkgdW5pdmVyc2l0eSBk
b2VzIG5vdCBpbnZvbHZlIGluIHRoaXMgd29yaywgc29ycnkgZm9yIGFueSBjb25mdXNpb24uDQoN
CkFoIEFwb2xvZ2llcyAtIEkgdGhpbmsgIGdvdCBjb25mdXNlZCBiZXR3ZWVuIElTQ0FTIGFuZCBV
Q0FTIQ0K
