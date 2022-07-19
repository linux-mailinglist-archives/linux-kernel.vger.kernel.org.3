Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235AE579459
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiGSHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiGSHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:36:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF1725F6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658216187; x=1689752187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1dbLOySNwur9SZR1OSLMrokXp5A96iBC5PweTcFjous=;
  b=eTbDsb3l3iVommtPjlQ3YC1FqErIrhyKcbO3qM8UZV5ouTovD53rcFBb
   cXikjt65FsuqkzeEeCn33nuJ3Q3YTICHfwTdCc4acV41Rm8uhAQMIKt8m
   Yw7c91XX6gCbnWylwtAhcx13NSjb81VY7umS66HZzW1uPi+w/sjWVXLvg
   PX1qZKUklYFBxBPv/ws9FPQCCVNtyp1felF6bT/hEDrHRz/77A49OTgeC
   eLFpJt0IrS1/r8h4bJfGguu9zqQQmqRgmz7SWFGTMtKRS7lW1TGEUFQto
   pWhwTN9SOvwwHbiB0w6MlGmih6lm+BVIT59SKbZZ8ueeMUJdUWjXJ6/4O
   w==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="182776564"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 00:36:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 00:36:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Jul 2022 00:36:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjT4EEZbjP8BDfhB/FNphix0hm5EvD6PGD6PrJmrmp+Jj0ySLR2ZxITKEYpU5j5hDAIlKh/1LW8TaY7CRJBsBHG2zGmwJrePj8C7AT9WVMhXFzHd2hab+ycJ/Rbo9gI9M8/90lAuAx6x0WMdSQYvjyTLDmTVZGAwR97LO52STLL16bdggofTNUFkbkdCfxNP8Xjow8qc28/ji/7o7idfctGoV7/zW/Qfcw6f7hD6I6OFS0DXfu3dE90LNd4snQcQa2xz6+6tPebYYQUnY8RRCMHZyN5J7tskjM5+4BHy2YwuzTfCQjPlF5O+9Y26f9UuOyd9euhy9C1pp+imzK0DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dbLOySNwur9SZR1OSLMrokXp5A96iBC5PweTcFjous=;
 b=deJ8AITWBKB9NAiB9j7i87rCyXHDmHhV790GQW1K60beIseL/efRH10EHm5bYu0nvXuCcY1RwpvF33Fe6FrtClet29/SPf4U7cm+eZBhdAVE/ZKS1zB7MHLawAOARFaUgsWBPAgJgDibUhWTpilxjBt1R5GVTudKMTTddvUjK1t/JY6DKVXB0B8FdJYefFdWyHHR6DsjEFGKolWGtZu0cXYPB85FDNSgFltb/4PG38WJVRnWNlIvhL/8vf865o1jG6+n+SBFQOdHOjpCifm9tZOrPqs9lUXr/73glnuQZqESkXvmMqXwLTTyV5PwipKE/lzRyA3D+A3MSZgwKFrZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dbLOySNwur9SZR1OSLMrokXp5A96iBC5PweTcFjous=;
 b=HjVGLhChrBlrdDYnikad2s3gaCKI0acjcq4reCQD0dLGZDOWwUQOOnfZxKjj5GVbz49AF/My/c4f5mjaRWCqPm6etWasXv084ut+EnSz7G++oavwVL1Kuare+CnG1L23TxRS35h3TG6Ujusyr1GAoUC0jPImdB7l7rgOcsmTCQA=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Tue, 19 Jul 2022 07:36:14 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:36:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Conor.Dooley@microchip.com>, <p.yadav@ti.com>
CC:     <tudor.ambarus@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>
Subject: Re: [PATCH] MAINTAINERS: Use my kernel.org email
Thread-Topic: [PATCH] MAINTAINERS: Use my kernel.org email
Thread-Index: AQHYm0I5xTsHtamg50WbpqwXvnFVuQ==
Date:   Tue, 19 Jul 2022 07:36:14 +0000
Message-ID: <d8bb24a9-ad36-0acd-2672-731ae08af77f@microchip.com>
References: <20220718151243.1149442-1-p.yadav@ti.com>
 <165820520992.90015.1804934724521244853.b4-ty@gmail.com>
 <6b9a2433-12de-eee4-02a0-3cf9ea8843e4@microchip.com>
In-Reply-To: <6b9a2433-12de-eee4-02a0-3cf9ea8843e4@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa43a3cb-d0bb-4056-be64-08da69595c48
x-ms-traffictypediagnostic: CY5PR11MB6533:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: viAJOIb7wPowvzUj6jqOK6QNLk4pWVqWH8QsK23Vj8ISZf/O3KaDKiSi0Xv01GminoB7rjON549ODjTU9lg8z+bUKnvrp7cZgIAo45GfG77DCwWWS88XDVzVJcPoxQa24qelv9OxvapO01PoxCxZxG/jP/WRkb46jJXS1usKdmQulTsJGhh7zASgKTWX4/fZj0aaaFnE+Tfcum8z8QOPxMpXP+kEPp8IwOUD/boFrHXjmdN7WEPAEJ2y1MWqa9iqFMWEuL0b2xQ9+eCe9dkV9e8Z636azDSRa71ZQ3w65n1fPIpxcwfvt6+Ka+pbxUqZBLy01jTp8d10ER9Siz8VT+OzbSBJy9PqbdCyQAczOx57qR9jDoZLhOqjSu6Cicbp3mYylZyUkGsTJzYClOZN4NVzJ+4qxJGEq03dJrDT4fZcKgdF5Y8OmMvUys9A+mQBe1PnnUNOhstwdhUruF1j6NcjprjL4CADfa7PzpweWWWkGyFIpd00geSjV/53vF9MIT7AMDJEXQPSqob1kjBDpLKLgcT/1eKMWSAnr/ykU8Q6UPyJ0t9mFrzEFz5Riq5h7ymCIFqQ6OIoEabvSy1YLM3sBKhs68XL86puZEJAW7oCgd7fyDnt9Fz9032ODr0JOA9k4aQ3JTat8jBe15VBRtw0bVXPQHX4RcUi4mfYAiXQvMoG2wyNsfYAos7yhQzVicVB3rF+dq0nlJbqtTfNplHCeShrZ/ruXED9WcqKaR7n0gm5Hclj2nxqCT8Pq61IoOrTrlVl+AxrLdLm2U3HNgYTtbQU/AnFPiJpIpU/q4G70s8r6NQxvxl93EYf4IBMMp9m4TO5MVM7m8sSpfFi8mLbQ27VRPJALzlQl6c0eDrnf6cq/mGWaMOpm9kwZKXfVEsaXdeY9W8MzWzMwz1B/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(366004)(396003)(376002)(54906003)(316002)(110136005)(6486002)(5660300002)(86362001)(8936002)(966005)(2906002)(6506007)(31696002)(2616005)(41300700001)(64756008)(31686004)(4744005)(36756003)(478600001)(91956017)(4326008)(26005)(71200400001)(38070700005)(76116006)(6512007)(122000001)(53546011)(66446008)(186003)(66946007)(66476007)(8676002)(38100700002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YndiZ2M1d3lXaDhnTkI5SmZneHBURmwxRTVhM1QxdDJud1ZxVWtxeEszWTcw?=
 =?utf-8?B?eVZ4YXhneXBhTm1kaHByY3VTMWlSclhVdHRPcjRPZzBkWURFWU9WKzhOTkdK?=
 =?utf-8?B?ZytrRnFmTkhERnQ3dkx2UEN4RjRaSE5mVDlCVHdxYU1oNFRCeUJVQzNEVjh2?=
 =?utf-8?B?d0VpOUxhWDJpNldPYVF4VVJKR0M1dm03OHlSV1l4T0RWUDRFOTJBak5na1Q0?=
 =?utf-8?B?ZGhRMnNSRFZpNVZIdFN2bWFaMmpRU2V3NmZEYjFlWXk5b3N0eHppSWFSV3Zn?=
 =?utf-8?B?bGVjcUcyTDBjc0hWTGFzMWx0aDZ4ODQxSk1Mam04RDhoN3JlaUxjQXVwNnBX?=
 =?utf-8?B?OE4xVC9hV0c0enJKekNXOTRxMlhtMEtqUjhNQU5ZQVpMYWhTUUJGSzJkQ0g3?=
 =?utf-8?B?SUc2L0wvaDJ4WmFjeE40U1NkTFNQeTNycDRYdjRkUnJxUzVUdEQ2YU5RQWEv?=
 =?utf-8?B?anpMa0RkcWFweGRyVjNDeThmeEdFTzduVTJhTUlYTUh2OFJiMFpCYTRGdytW?=
 =?utf-8?B?WUZqN1BuVUYrSWl3VGxjR0g5RUx0SzlZd1BBZzdjL25WUGFqN3pYQm5HaUcr?=
 =?utf-8?B?SjRIU0Y5VUV2cDU5cUNUR3piMllEMlBBK3haajNucGJTdDdqVEN3QmVJK2tz?=
 =?utf-8?B?Q0ZLbVEyZTExcXY0Z01BZGJxSVo1WkhTMG1VSmdPYVZoNjArc1NKM1J1dUxw?=
 =?utf-8?B?cHJpOHp3YzYzS3ZxcmZoZlFFeW14UUw1elM2NGJaMS9lTTBSYi8vV1ZHNDdz?=
 =?utf-8?B?SHc3NVluSEtTdWFKZGcyQktXZC9rVXUrRDdpdWJ0N0Z1OGFac3lNMWwzeHEz?=
 =?utf-8?B?YWwzcEt1MDJCWEdHVi9QcldZK2xsS0dwY1R6SGRnUXlmd3BVeDNsQWVxZldN?=
 =?utf-8?B?akVQZzR6cXVLc2V5OXpBV21hczRPcjFJTzFhOGE0NmdKVjRCS3BaM1lFM2Fw?=
 =?utf-8?B?eHozWDRhUVlWb1lHNWgrQU5vdUV4WHF2QkFMVm9LNVE3VnJCbzZWQ01qRmRD?=
 =?utf-8?B?RHhZWjBlMitkM0ZRZEZ2OEgzakptQlgvZkRhMFpQYVJuRHUzZVIxN3FHMWdj?=
 =?utf-8?B?Mk1UeFVqSCtOTFVPN0Z1NVFEOWtsVHhrMjhxZjduaWdJdnROQ054RWdjUkxw?=
 =?utf-8?B?eGxXOHpIQUE4bFMydmRwcTRlR0UwTUw2RlhJZUJvWWJxQ2dEMGJ5NUlSbTRH?=
 =?utf-8?B?RjcyVlg4czVGZUlwMG5uU25pUUpoSkd0UGQ3aGZvdk8xR25CNWZlcmJyU3oz?=
 =?utf-8?B?RXJsRG5rNDNKbEgveXFneGh6TlFOS2ltZkJyL1Ywa05LOEwvcnc2ZDFlNnhP?=
 =?utf-8?B?NnNZVzl5L1k2RHJUdkpYbmtRMk9PYXpPeDFpTWNGRzN0VjN5eDh4WEVYSHg4?=
 =?utf-8?B?MU16cUx4YWN2amJFUVVsL0d6RmpIZllWdk55MUtxV2dUak9rdTRvWnhKYmJ1?=
 =?utf-8?B?K3AyRm9kOWhDYjNPZGc2bkQzZDFvaGhPeDlnc093enJpc0lXcW1hQklvYTNR?=
 =?utf-8?B?aFY2cHhpak02UVVRYlhmTUVSU0RtUnc5NUIwQmlDb1g2Qkt3cVBpR1IySWU5?=
 =?utf-8?B?YTRBZEt3WWNjS1ZYVE9xeVE0YVZmTGVkeHJtV1lZWUNrRElCdE9ydk5YeFM0?=
 =?utf-8?B?R0VJSmJ4Y3hpbmdGNkxyVXg1S2JzOUlaemo3dUVoNVhTU2lzdmNjMkFWMjdz?=
 =?utf-8?B?bEFycVRpcGUyaTljamhXV3VGQTRRVm9BZnJQakhMMFEwUXVLTEpiNTMyVmtu?=
 =?utf-8?B?dFNod0NGS1BLSnZ3TjJORlpPaHR5N1hEQ2IwSU0vdnBjZWJxTGhRdHRUcFhI?=
 =?utf-8?B?aGNoTThLdUlFbjJONFBrbTI2SWFleGFHc3JJQ1FiajNWOFdNRlVBZXhwKzIw?=
 =?utf-8?B?Snh4UExEZ3FZbXQyYU50OUhYc2c5VlF3R2tJUkVPNjdyaDU3SEcrRUF3emxu?=
 =?utf-8?B?VkNYeFRqdW1ZcnBuVFdqTXEyZnlQQ2ZPSXZNUkNrbVFaRWJNTFZvWkNacUM2?=
 =?utf-8?B?YTBnaU5lZFduVFp6ak5aK0x0bGlqRGE5QnNrenVLblJKNjc0OXFZQU50cVU2?=
 =?utf-8?B?TmV0S0lvcWlUaEZmUnhqMXVCblJyMUV5aFp2bEtSd2JYVmlZdys3Ym52aUV2?=
 =?utf-8?B?aERtM2RqMkdIeFA2RzE1VHptcW5keTczTWtNclNpb0lhbmtUeEdXL1h6RkdQ?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F26EE0B412A5342B8EA5254B1F290A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa43a3cb-d0bb-4056-be64-08da69595c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:36:14.7623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EbhNrltMR+T+cbDiW/GSBi/R+Q54dY+JktauiFumnU27TJpU40BxlAlml7cssYDU9WWhFy1FYGzrUICgvAuOlExwUJS4A/fW3owq6RrKCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOS8yMiAwOToyOSwgQ29ub3IgRG9vbGV5IC0gTTUyNjkxIHdyb3RlOg0KPiBPbiAxOS8w
Ny8yMDIyIDA1OjM0LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4gRnJvbTogVHVkb3IgQW1iYXJ1
cyA8dHVkb3IuYW1iYXJ1c0BnbWFpbC5jb20+DQoNCm9oLCBhbmQgSSB1c2VkIGdtYWlsIGhlcmUg
OikNCg0KPj4NCj4+IE9uIE1vbiwgMTggSnVsIDIwMjIgMjA6NDI6NDMgKzA1MzAsIFByYXR5dXNo
IFlhZGF2IHdyb3RlOg0KPj4+IFVzZSB0aGUga2VybmVsLm9yZyBlbWFpbCBJIGhhdmUgZm9yIHJl
dmlld2luZyBwYXRjaGVzLg0KPj4+DQo+Pj4NCj4+DQo+PiBBcHBsaWVkIHRvIHNwaS1ub3IvbmV4
dCwgdGhhbmtzIQ0KPj4NCj4+IFsxLzFdIE1BSU5UQUlORVJTOiBVc2UgbXkga2VybmVsLm9yZyBl
bWFpbA0KPj4gICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbXRkL2MvN2RlMzA3NGIyMThm
DQo+Pg0KPiANCj4gSGV5IFR1ZG9yLA0KPiBKdXN0IEZZSSB0aGF0IGxpbmsgZG9lcyBub3QgcmVz
b2x2ZSB0byBhbiBvYmplY3QuDQo+IEZvcmdldCB0byBwdXNoPw0KDQp5ZXAsIGxldCBtZSBhbWVu
ZCB0aGlzLiBUaGFua3MgZm9yIHRoZSBoZWFkcyB1cCENCg0KPiBUaGFua3MsDQo+IENvbm9yLg0K
DQo=
