Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA825739DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiGMPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiGMPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:16:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD043F300;
        Wed, 13 Jul 2022 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657725409; x=1689261409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fABvcbkUbpc25gTQRPOQ6Ut2LhphBQCvxCgQOo+CO3E=;
  b=T4GYgqQg7cfhMeWS8KEdm2EJzZeAPUX4KFgmBidNdQ5My16NwQcWoK7c
   zJ07E1fs2W5a5hzepD2xXUqfJuEtpvpcP4Ow5dFscUa1IuSRH2H46zCVo
   BJZue50TVtEAFEPtMtVreunCRZeAc5TUR304pErs0iHTdI83CWXdy+wUt
   bh49q84I0MEQWHFhVcYGlgHCUIB8401y1sTknr1XxqEVxTLVCZX7zvQr/
   9Pc3CipsJ5JR3qM5H9vLVmUa9S4ap6Um67Z6DXwJgfm6E9BxythA+BVRx
   9udm0/4q5Nl8rXM6wSBMg7UIz/QkdPPYHtdIiKWtoW2J2er9uuhs05XWw
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="181977413"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 08:16:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 08:16:47 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Jul 2022 08:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwqHZ6MHBLb/4ck5Fr5hTZLrm32KOkI9vbCHLzvTUyTYE34+3TRc5f+zaymUGX7rx5wr1uxTt+3mKPgDL2kGpf51kgLM5C38gscT1qArW1zxygnRK18KiVcwhuHt+8NriSAvHzeVgm4pZlIE35+k3aA27zyKu93BqR21qu55gCUCem69sVnDPTXZxK+RtlALlaI1P1yS+tCM0vKbpborQdluPDpyQa0PCfSjMCDl/WMBmgthWokjWGohZjJFMaam9Q+7RZ0dc+9iMm1uqSStmQ+qRXblP3BXGK7OUZSdRF7V7AYrtW/ujyxgsUFD4Ejawb1AVKqxJ6rBgpdZcsqsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fABvcbkUbpc25gTQRPOQ6Ut2LhphBQCvxCgQOo+CO3E=;
 b=FwaeoAlus2SItKEzQTXdnoLC6ZVAzKqcR5q0TaBMiyliyH+T4aTwrGb0PafOToC6N7YpF13k6W1zKpzz2p1FMbJYIJheSRS1Sh9RXvfoY3/zzXpadp8mTs73nQSmNcAp0CmYEIaOZaXjg7/W95DIvofX9yXcg4K0H5A/GGCZVbcHXVvctz7R9Qku48Cg99AmZbyH5/o625W5iDlklpvIAHvLzSyQIKDkrVfPixgoxCImAiaAgbobXggBPavPCYmJy+oTe/yM8ZVJ78wXxcYvGcdVIAfp+LgY+uByCUydA0gDYi0mTqjqNUoO5fGNbry3rNlbWsk64qsNPNfgz9XzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fABvcbkUbpc25gTQRPOQ6Ut2LhphBQCvxCgQOo+CO3E=;
 b=h7gdutfpKjJ1oPwAO46kyOMuD0mx9DKNSIa5MtPCbzuTu69CCdy4HZnI/ucKIpvMt2qitKvHeyg1hoZg1I3RSRYBoErsJqN9dfKmUh/lHWmQcBxzYCUTLRvDISCGaJzn4ZB2c+AHwGntpcIcI6/57F/m/sQ8Ou66bt1w5d0f3gM=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by DM6PR11MB3257.namprd11.prod.outlook.com (2603:10b6:5:5c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 15:16:45 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:16:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <icenowy@aosc.io>, <kernel@esmil.dk>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <Conor.Dooley@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor core
Thread-Topic: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
Thread-Index: AQHYlVY+6t1yOzd6XkeyUffI8zZgAw==
Date:   Wed, 13 Jul 2022 15:16:45 +0000
Message-ID: <224a7ec2-62ca-a8a5-ff36-37de4186e05e@microchip.com>
References: <20220711184325.1367393-1-mail@conchuod.ie>
 <20220711184325.1367393-3-mail@conchuod.ie>
 <2303fc91e5110f22fc9ea6008fa4bbc77c1bdb13.camel@aosc.io>
In-Reply-To: <2303fc91e5110f22fc9ea6008fa4bbc77c1bdb13.camel@aosc.io>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 508ffb45-05ab-44d9-86dc-08da64e2b301
x-ms-traffictypediagnostic: DM6PR11MB3257:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CIEZLp8V56oci0cLx2wSPsGwAehDe6+eRK8zsAlpJqJQE8teZattqt57Qds5SxHLD5xxlRbQ2YLquu8b8VG4zTSzhFnQvQxEudmDnBzKX0rCEHaGwI53EVGG+8NXQW4xNblHwpP3VAe5+tYC2DVr8Ulo3uCtUXONytz6Dsw6ybrwBRa2JBTDrpzHVKzgGW0J9PiFTu/BnZ+kP/GiRjnEFcPdJ1/A4upJVlv/LbOqsacjwqTbvYNgzpDRoe9XjgTFcav0V8POHA8XfDWCKhOZtRdUuenuf9Tm5W/WcU8zlBeNwlYjbo5F9B0AvYtbsGcpvQsQTILw8WI8lWbdfSWxgRZ+SgyGucynjvF+Z/7qJkp/oreVm72maSM7Pda3LxR3UiwpM1I2RTolXaa5pnYFbjI7d6lKx9BrJkwPVsXM5L6W6Idj2y55gB4o06fRIfaUTn4EllT02JhMhxv8yHyacvzjSW2hKzJTkpSwLEeJgPki4LNXGp1/mwCMimjNi0TWeVmdCUOjWBXnawha0UKnJZqKqHj7jYDO1p5oBv99QAlVaIQRBfC9K/cND4X6CEixUmOrysdGNjPiYF6XBAv5CA/h7hC6GawiO2zrINsGbYA1pqobO9vf/QYU49zOuuipTURF21HEBgZVKXWcx4DDgmldP6mS2/A8peONlvfswEMgBKWnnYVPdaLy99aBAoeIwK95VGYT2bzIUAeEhlOkEUiiNFLtxmSK26lItSoKcFPQzuOjKEUBMbSZsLhg2zh5O2VPM2HgF+oE9qm2psVN4CL1r7p3nMOnHZywqxSo4NX+HKclrLuoTZ1jCEBnoHckWu9qBT8ayXZkZ2zOf3sL7mqQpPEzT9+oQ8S0P3K7wJwHcybUJS9Y9RqIyGoXvaM1VAJSyvSkQPsqkW9NPZHrkoFFHkpkIww/HONDijPu6c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(366004)(346002)(136003)(396003)(122000001)(31696002)(8936002)(86362001)(66476007)(38070700005)(83380400001)(8676002)(66556008)(66446008)(64756008)(4326008)(38100700002)(36756003)(2906002)(66946007)(110136005)(7416002)(5660300002)(91956017)(71200400001)(478600001)(41300700001)(31686004)(6506007)(54906003)(26005)(76116006)(6486002)(316002)(186003)(53546011)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnFRcVZJcDJOa2tKN1lRZ1UyeUk5dm1XUW4zUTY1ZUprTEFKNUlnZmFyUEw5?=
 =?utf-8?B?YmNIdlp4bjlDU3ZZcUZLTmxjYm1MTHI0ZnZTOWlpNGxtaUREVW9kNkVYU2dM?=
 =?utf-8?B?NTNiVU1UbTdlT0hRZndPQlNtS2JwZ0dsdFRnYjJLYUZCWFVPSHZSOTJLVjJN?=
 =?utf-8?B?K2w5SjBkMGlzM1ZoZytqeGdETGlrekxYelZhZm8zNkFvM0dLNFlPdHRDODZj?=
 =?utf-8?B?SExkY3UvVTBEVFdDYnFyclcwU25NamxieHRhMTNGQmFKOGlPNDhYR3lYN3V2?=
 =?utf-8?B?NHNFVktldFNzOWUzYWg3bmlHTkYzbWtNSEw0VFBCSW5GQXN0RzBuOWQrTXdH?=
 =?utf-8?B?M2o0Y0llZkprb1UvOWZLMTliRzZSdjZ3R09Ca2VBN0VsUko1eEFXSFRrd1lN?=
 =?utf-8?B?akxHUVNlUnNjZjdHZ0FSNUdnRC9KMHdQZmlEL1dZdTJnNjhrV1BoTGI3NXpU?=
 =?utf-8?B?SWUxeDF3WFdUU2w5R3MvZUJxR3JRMmNpVnhCSTNRQWcwOFFiL2swREtEekFP?=
 =?utf-8?B?SFRsN2NZeXJpN2pWdFROY3dqL0NRU2dscXJxREN1Rlh6a1M1RFNEcDRIYy9T?=
 =?utf-8?B?ZHhWOXd2SEpwMnBUU0VMWlRGbWhmVkdEL0o4SkZHWmYxaklBT2x3SG4yOEZZ?=
 =?utf-8?B?V1VzYVBwN2x2NTBWUVJHZkpSeFd4MXVZUXRYQjdnZ0JWdzVyeDZPb3dzQzlT?=
 =?utf-8?B?YnRWakF6WXkyZElKeGtoek5RdDdYbENPSmg5S3ZTNVlRN1gvc1lwMnp0SFJy?=
 =?utf-8?B?Qzk3U2RqNlJNd3NKdnk5ckRzZGtJUU5MZmFTOWNZMzRwUStNOG5mcEYzc0tt?=
 =?utf-8?B?NkNDUDVIVURmbko0clIwT0s3aVZ6R1dHdGVCRnMraFlRcStWOEc5byt3NHlj?=
 =?utf-8?B?c0x6QVhLbTA3NlBpcFFYcC9KOVMxNkRkUjZVR21jSTVhbGFwaTlZdGg2RFg4?=
 =?utf-8?B?K09QSlZiY1dqZkh1WEp4R3d3dGpTWUZNZWFFNTZkU3ozT3EzYVpMOXlpZGtz?=
 =?utf-8?B?MWg0bktmc25VRk9nbGx6bEN0a3QrRy9zYks0OG82OEVveGFhQTJtMmd2cjEx?=
 =?utf-8?B?YWlVMnhFczhYYkdGbDI0SEtxWksrVExQYnZVbkRoS0gyZlBWUUwvYVRNNjVN?=
 =?utf-8?B?cmliTHgvRDhzYjJzazVDV0JLZkJNNjZNYnNFZTh0YU1xdjJINjlvdWY2djdk?=
 =?utf-8?B?VVh0YWhzSXhSRnhMMGRQTU1nZ1lib0doQ04xZVVNMEswcXdqTWFuOXlscnZp?=
 =?utf-8?B?VUV1VU9wS245SHYvL2lCSCttRTFpNzRzbHN4dzVQR25ZbXMrM2ZqTDBPTHlL?=
 =?utf-8?B?aW50UFQ4RllqS2lKQUxicTlaWC9Eem5lZjcvUjhzNTBzNm5pY1dic0Rra0Vx?=
 =?utf-8?B?YzI2K2dVb2doR3hldWluMkdYZXY0Uldza0xqUnhIZ2VsMDlNYUVvb0UzSkZO?=
 =?utf-8?B?cjJVbDNrMU8zSzVKRXNRS1RSQk9sRHhDbG1iUXJJemtjZHQrTElSaGU3QlQr?=
 =?utf-8?B?Q0pkYkQ4ZmVKZGRqY2F5MUcvbVlNY21oMUdaMXhqc2Q0NE93Ym1qdGRxZVhs?=
 =?utf-8?B?NnNQVytwVU5VMmxZWVF2Q0R2VXR2L28rR2g4WUhXWEwxUUsxcXJKMXdZYk4w?=
 =?utf-8?B?SGUxOWh3UTFlS2lVcDB2ZVV0ZWJpK2YwUmdveGhsVSthR1h2ZDhsQk8xMFdv?=
 =?utf-8?B?dlNXRi9YYkgwL2VHckRRMDBMczUyQUhXUkRDN2dkWGJETUFCMER3YU9IaUU0?=
 =?utf-8?B?SURGc3l5L1VnS0lrQXBsMHE0ZlNSWENLMGFHYUk5NmZGUWUxV3RwWFJ3aHJk?=
 =?utf-8?B?Y2R6dkF6ZGRvUTBIYUFtRU5ndGw0djJnN05BeHlzbHd1R1NBcE5ZSUQrYWQy?=
 =?utf-8?B?aWtib1VkQzBhRDlaWDdmRUJBaXNXUmdBd1JLMkxrVEYxZ0Z5RlBTaDRvY00w?=
 =?utf-8?B?bDJXVWpZWUhFaUVWMmxuK1BUQVYrSTRxcDRyS1Zuc1ZHakZkMVNhRHpUQVBB?=
 =?utf-8?B?TDNDaFhzUnUrc2hiZGhIamtwVjRlV1hydGQ1VGNQQzVKVHN6Y1pBNzFUL2hy?=
 =?utf-8?B?bURVTmgreG1OL0p0ZTRiS0NqVXVvUi84RzlORW03SVhlU2dza1J6VjBJWVpO?=
 =?utf-8?B?YWpXWS9RRWYvUCtVQm1Xb0d3U3ZNY1NnVEF4RktqMWVsMEJxRGp5eXZ6ekNN?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <644DA4F5C3DC6B4FB2734B6A8AF0F010@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508ffb45-05ab-44d9-86dc-08da64e2b301
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:16:45.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKQ75DdVRVDgtDQyD21x9I5gRpuAMXN4nm+JEuUXjpZkCjxkCzimEFndb2jMYKsMszsLe14wSZpDQS5eCkkh5QTarachWyi48oFLWr+f7oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3257
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAxNjoxNSwgSWNlbm93eSBaaGVuZyB3cm90ZToNCj4g5ZyoIDIwMjItMDct
MTHmmJ/mnJ/kuIDnmoQgMTk6NDMgKzAxMDDvvIxDb25vciBEb29sZXnlhpnpgZPvvJoNCj4+IEZy
b206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhl
IEpINzEwMCBoYXMgYSAzMiBiaXQgbW9uaXRvciBjb3JlIHRoYXQgaXMgbWlzc2luZyBmcm9tIHRo
ZSBkZXZpY2UNCj4+IHRyZWUuIEFkZCBpdCAoYW5kIGl0cyBjcHUtbWFwIGVudHJ5KSB0byBtb3Jl
IGFjY3VyYXRlbHkgcmVmbGVjdCB0aGUNCj4+IGFjdHVhbCB0b3BvbG9neSBvZiB0aGUgU29DLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hp
cC5jb20+DQo+PiAtLS0NCj4+IMKgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAu
ZHRzaSB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0KPj4gwqAxIGZpbGUgY2hhbmdlZCwgMjEg
aW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0
YXJmaXZlL2poNzEwMC5kdHNpDQo+PiBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3
MTAwLmR0c2kNCj4+IGluZGV4IGM2MTdhNjFlMjZlMi4uOTJmY2U1YjY2ZDNkIDEwMDY0NA0KPj4g
LS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQ0KPj4gKysrIGIv
YXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQ0KPj4gQEAgLTY3LDYgKzY3
LDIzIEBAIGNwdTFfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgfTsNCj4+IMKgDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgRTI0OiBjcHVAMiB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAic2lmaXZlLGUyNCIsICJyaXNjdiI7DQo+IA0KPiBP
aCwgYnkgdGhlIHdheSAic2lmaXZlLGUyNCIgaXMgbm90IGEgZG9jdW1lbnRlZCBjb21wYXRpYmxl
IGluIHRoZSBEVA0KPiBiaW5kaW5nLg0KPiANCj4gSWYgeW91IHJlYWxseSB3YW50IHRvIGFkZCBp
dCBoZXJlLCB5b3UgbmVlZCB0byBhZGQgdGhlIGNvbXBhdGlibGUNCj4gc3RyaW5nIHRvIHRoZSBE
VCBiaW5kaW5nIGZpcnN0Lg0KDQpDaGVjayBwYXRjaCAxLzIuDQoNCj4gDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwyPjsNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2aWNlX3R5cGUgPSAi
Y3B1IjsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aS1jYWNoZS1ibG9jay1zaXplID0gPDMyPjsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaS1jYWNoZS1zZXRzID0gPDI1Nj47DQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGktY2FjaGUtc2l6ZSA9IDwxNjM4
ND47DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJp
c2N2LGlzYSA9ICJydjMyaW1hZmMiOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKw0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjcHUyX2ludGM6IGludGVycnVw
dC1jb250cm9sbGVyIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmlzY3YsY3B1LWludGMiOw0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjaW50ZXJydXB0LWNlbGxz
ID0gPDE+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07DQo+PiArDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNwdS1tYXAgew0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2x1c3RlcjAgew0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNv
cmUwIHsNCj4+IEBAIC03Niw2ICs5MywxMCBAQCBjb3JlMCB7DQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29yZTEgew0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjcHUgPSA8JlU3NF8xPjsNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Ow0K
Pj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY29yZTIgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNwdSA9IDwm
RTI0PjsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoH07DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB9Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Ow0K
Pj4gwqDCoMKgwqDCoMKgwqDCoH07DQo+IA0KPiANCg==
