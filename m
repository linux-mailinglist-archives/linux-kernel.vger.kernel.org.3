Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE05B0738
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIGOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIGOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:41:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25192F50;
        Wed,  7 Sep 2022 07:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUvtu7oe6mOiwrRpBbT2Wemcg2RnXRg1NJ/PpSCjtkQp/g3l1+mynv7VKhoYCKwwrvaYagDSlffndEhOVWRDbsnTMktsAM3PLhNBgGNsm3QfCWnU3ON2q+NHP5oYdyg4OACVYS1S2ErMfDIITd0cBVu5z/MwAO2/maaMBA2aCunMGiImni7eWGV7W5NaEkESMKr47GkwmecXf11eSiyPrAGBlnD7ughY9WBPCsJR5yzf3rvwL0z/J2LJEl66lM0UJg8SZEegJsRDL2SfgHxdjHGlkNC0LNToc9dI0XaaG8SCES9nFqp4fobQMUH/0Ujm2tUISaCUO/HOXq1xCDynng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQDkmgIa/S9UAXd3IMaD1OzcTjGD8Uxr8m1npplBfQs=;
 b=X8KTjNv/Yd/YijLxRxvKoeN+yAGc9letRYcT9DSeyDwoEfktvJeR86c4IFIgFBK4ufM9/XxFZiJeadwmHw8WsOqzngiNXEwxP/k6hLC+KruOF/RLEVwo8bbVOuN+/4lEQXRufNK5JmgZLDfTt0zks+NYV1ycgfSsLNP21Ao6JVjVGzcJoUZxR2lB3UwBwUMkpz0hARIxuMtx9IYlS44I/jaJos7Cm++IwdfePBRtnBXBRrF/OCeEb/dk6UrffLqCeAeBQ1VhoQVcy5NTDiBhleoCxZeI+kNdQCxMDRGvsVrWH57P3Q5Rh/vdtlMmYcI92wr5I/WuuP/5oVcIJXupaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQDkmgIa/S9UAXd3IMaD1OzcTjGD8Uxr8m1npplBfQs=;
 b=jQjWvI4glvldu0n/El4vbw0W2caQ4QTSAxfA8dpHFcRWdnyfJRce9v/5mYihPibAB8xETn+4k86JTXNzCpWy5RUeuTZjvZ4qzAIvRekGSruXOgF+g2DLlUdMag4bnkn8yeJAW/o0rynmep7YjplhajRXjUMP9xCQ+RYUcpwXpfzUGtB3TQPhUoYSjNDxRtFyaoCddMP5p2O5Ul93xL6NnInabBv8Sr8cfsvK+ub+EBiqmRftWyXOvxz4X0dDVHaDZkDU89VAvwawDCrxdH4ee3Z2Ek7Phy6CSNRguM27fCvevhV761TwQ0OV7LMb8rLIKujN+wstO4Fi0RRdjr7w4g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4904.namprd12.prod.outlook.com (2603:10b6:a03:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Wed, 7 Sep
 2022 14:40:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 14:40:57 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dusty Mabe <dusty@dustymabe.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Thread-Topic: regression caused by block: freeze the queue earlier in
 del_gendisk
Thread-Index: AQHYuWcagyYf9mwy0UOiJ8D06Vd2Ya3KL88AgAl1nACAABI4gIAAZTyA
Date:   Wed, 7 Sep 2022 14:40:57 +0000
Message-ID: <44ab9f7d-8f00-5f80-210e-f65f02f6fd82@nvidia.com>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <YxhYjaA3CrMz5njZ@T590>
In-Reply-To: <YxhYjaA3CrMz5njZ@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4904:EE_
x-ms-office365-filtering-correlation-id: 7cfee2e9-1be0-45c6-950d-08da90defa06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S82STfh7rC+6hPcmQ3KKNGPCuIY3gP3znDnZLD36PnBts4M1PxY360I8gl88JvNlgC0/xOjmLz+SekoYT3tI5nNp/kplUUflE3YB+YYhAYC73D5X2PWx1SvuwQIcqv+ueGz+Vkm7115B4+9fZQLz3rxuE2nkbRHBMPmy8P5BFCvREzJrDvl1JJIZPr56Fg/rRIET8vVELVKQVOwOjgjY+B6B0eQlzEyx4TKp7ZMwmXPhzTub7EMBR+dh+k1NEWKAl8C9otA1MS0dsRITVHs8rgWCkkcnzALIyPg6muH6jyJCkxaTDQ/9SRx0Hs4etb+WEDGXGUgyR69k+ZsHz5WQraujHtzMT0tqhY8qyAM5UXaDqeI/zEjPPN+wegvF51T8t7/PrHDoD3TpJs9upJubqqq8DWo+pCy6ozWS4WBA+w1Gv2Q5Qa9f3xe+mpgRFoeF8DdyLRlvFNtO64dQbpus1DxpDMhU2qUk9Iu9tiIIue/oknpVC0ZXFtrCLeQ+JYv64FQT3tkqVXLiSOFexjjXPgAiGNumzdGBmh+qI/baBDGRkTydlVvMOkCsO/PgnBvv5Dut7VnmnRWQIRP2rmVIRP0acv2XTD/GmjQEe9dVVzZxQ8eB/wVzoprICKJI60knrT2YVx+E9g/1kNEZVpUZXsCnHeszd1vhqLv1SEyY5J66tK2EkEK0As7R35tjnsOr7A+CIuAy6fo8hJOEPfVLlkoWdWusy6iiLauepd9HBAS0ItnFm0rEkSsGqYNFnckbE9z4dGjwZsSl55YshkTlzg9P/1BLOlzfBZ1CzMu7V3BgY5DgMvzVasWFZN+1w6NKoRSoc6l0NVNuMAvyY/Ws/6Br+vw3LiEfBkSjcBwzBy/aykoYg0KOIoKoMKMiQN7JJiMn6Pz6BBv3hozTj+oW7UxisbJqrD3N62XTp70X7Ek=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(966005)(6512007)(186003)(76116006)(71200400001)(6506007)(41300700001)(478600001)(38070700005)(8936002)(6486002)(83380400001)(53546011)(122000001)(2616005)(66446008)(31696002)(86362001)(5660300002)(4744005)(38100700002)(36756003)(31686004)(2906002)(66476007)(91956017)(316002)(110136005)(66556008)(54906003)(64756008)(66946007)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dS9Da0RxYjRUTCtHVytCV21EVjkvcmlzNlhSSEU0SnE0ZXRTRmZTc1VWODRi?=
 =?utf-8?B?aWRlSU4wRnNPalZ3OHdLYjdnZTNpWkdQRFhoR1BpSTdIem9VNWh2cTk5YVBW?=
 =?utf-8?B?bFRZcWh0TW5JODIvdVlpWWNESHduQjljejhZTmg2RU1UNFN1dUdybDNLWVhC?=
 =?utf-8?B?TmtmdWVaTXlaMStzTWk2Z2FBUkJHVVZIODIwbWxEV3ZmelJNazdEVytZenlw?=
 =?utf-8?B?NktySTR0VFhsNkd5VmdrUWwwcWVSL0JuV2h2U3dia2xmTkkraXNIV1ZPRmtU?=
 =?utf-8?B?NUluMzV0b3F2OUZWY1pUQjVXVnhNMDYwcUEzMXF5N05jVlVsdHFscmJyQjVU?=
 =?utf-8?B?Z0pjMlkzNHRHMjJPTE9hZHZlbTJ1TjVaU1B1NGQvK0tCNUc1dVJkQ0dMV0Uz?=
 =?utf-8?B?bzhZckVGaUxteTlwbHdxMEJSUVlSdTR4bm1IVkVZWlRJZ2hUOTRiMkVjQy9N?=
 =?utf-8?B?VDJGMko0WWd3WmFKRm0wK3pvbXNvTDFyTTdhYjh2ZXZUdVg0bGc4aDRRbW5t?=
 =?utf-8?B?dlNob0c2OWl4bmJkUWt2bmlmZTB1NFYwdjlQaDZvcFBTSFQwYlVkR0lQMUpE?=
 =?utf-8?B?WFVYUHBXMnJrR0pTSk1paU45MUdiYnJPTUx6TE9XT0V1d2JMNWtWdXhETWNF?=
 =?utf-8?B?aldWVEk0YXA3ZFV3bzh3WTMyYUZDdWVrOWdmNk1CWW1jS0tqSlRUM2VvbzlF?=
 =?utf-8?B?MlVadDVMbUYwTTBhd2lVVnhmK2FxUGd2YjAzTFpvVDI4SzZvUTJTdHR6Z2Zy?=
 =?utf-8?B?SUZWZTlScS9qQWNvWHIwN3JoZENwYkZaclJiRkV6SWtRdUVIdE01QjdXVEZY?=
 =?utf-8?B?bzZLMTFrOTc5L3kyYzk1M2U3R29MYTBhS3lld2NuUmVLN3FTbjViaE9nb0NF?=
 =?utf-8?B?NllEWXQwQjA4di9acnd3TmdHajlONW5rejFFUUh1dXhjSmJTT2x0MUVyazN4?=
 =?utf-8?B?OWU2YnhKZnBJMHloYWxwdkZNT2xwaEh3eHRkSDNZSmg2cVl1NXk4Y2Y3dTU0?=
 =?utf-8?B?RG5ka0hsWGM5RG1BWHppRGkwdW1vRlN3MXpLRUtCWGZwVmw4S3ZFRmUzVlA5?=
 =?utf-8?B?WTFKdEU5eFloKzR3N3dRdjJJcXl6bDRydzY0VWRTR25qSmh5UkNxVWc5K3Zl?=
 =?utf-8?B?Sjdtc3YyQ3o1dkNmVkhFMUFDbzRzNWlzMDhyZWdmZ05UUUVyMVpxeEpqR2Vs?=
 =?utf-8?B?V0JlYjVEbzJ4azVKTndRd2hzMHVMQUtqTnZGYStCVHhuTklOMElIZTdXWVBV?=
 =?utf-8?B?eUhrWWpZVWpWbkkrR29Kdm5ybFhLL2RZNFJsWG9oZG1xZEdtc1MwMXNFYUtl?=
 =?utf-8?B?TmRtYVd1ZjBmeWx4RC9Nb2pFVHZuMUdWRkw1b0YzeHhMTlFaa3AxSzQ1d2NS?=
 =?utf-8?B?R2ZEVkNOYThPS0VMSENVUlY3U1ZrRnQ3Y1l4VDE2cXpSdDU2QWlGaU1hNTJs?=
 =?utf-8?B?bEJLT3U5SVRNSnd4WXRjQWRhei9LNkQySGQ0cnlzRm5wRUhZZU1lNldZYklB?=
 =?utf-8?B?SWNwbGx1dTV0VFMwNjcrKzdFYkhKUXZyYmV5Z3dCYVVuZEUwTVRBRXRyejNW?=
 =?utf-8?B?SEVOT2NyZytnN3gvQzhzQk5JOTBkbFRGTGJUMFZGVWhVelBQWllaaVlLdjVp?=
 =?utf-8?B?bVdHaExTS0x4dFFiYitUTXFlMXNUTXhEV09hU0wxdmNvK25pemJSMDM4OXVI?=
 =?utf-8?B?RGRrc3ZSNXFvdDhWOXNacEJpSnlJdkowbmRVSjVmTFplTVVxNVBxRFAxcC80?=
 =?utf-8?B?dlNrOWMxQTg1S0pQeVlyYmpXOGhEblZOTmsvWlZXUkt2bnBIOE9CYXlkdElC?=
 =?utf-8?B?TGw3Ri9nSi90eHhhV1MreG1OZmZJdTB2NGcyMi9hTzEwR0pGODZ6YjRGd1ow?=
 =?utf-8?B?eXNlckRXLzhtVEY1RDhtMmZMUlpSbGFNUkFOei9BZG5SazlDQUNBWW9JalI4?=
 =?utf-8?B?Sm5udE1KVGdnK3NuRnNKU1dJOVBiakFuT3grTENocEFOWmNYMlVSSUFjT09G?=
 =?utf-8?B?V0FpdEJPNE4yTjNlckVmVzlkVnJSSXVoNTJESTRaV2lpYXo1YVllVHZSY2d0?=
 =?utf-8?B?QldqMHFQSGxEUE9VUGtZMnp0ZXU4Z3AwaWlUT3dHV0lCNE82YmF2Zms4RFAw?=
 =?utf-8?B?ZUVOVlY2UjI5U1JZMDVHQmhiUkRKYzRGS1E3ekZ2S1NvaWxZY2V6MU96dUpP?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA3AA9D70A28684395FCD05DEF5856C9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfee2e9-1be0-45c6-950d-08da90defa06
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 14:40:57.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EeRID2057bmek4FqC8VFg/3cAlsbQVRXOAcKAvRtByRI3XhqD3j5dQuF3XfBnL+KKOj2XeMaxmsfHAAnygGFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4904
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsLA0KDQpPbiA5LzcvMjIgMDE6MzgsIE1pbmcgTGVpIHdyb3RlOg0KPiBPbiBXZWQsIFNl
cCAwNywgMjAyMiBhdCAwOTozMzoyNEFNICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToN
Cj4+IE9uIFRodSwgU2VwIDAxLCAyMDIyIGF0IDAzOjA2OjA4UE0gKzA4MDAsIE1pbmcgTGVpIHdy
b3RlOg0KPj4+IEl0IGlzIGEgYml0IGhhcmQgdG8gYXNzb2NpYXRlIHRoZSBhYm92ZSBjb21taXQg
d2l0aCByZXBvcnRlZCBpc3N1ZS4NCj4+DQo+PiBTbyB0aGUgbWVzc2FnZXMgY2xlYXJseSBhcmUg
YWJvdXQgc29tZXRoaW5nIHRyeWluZyB0byBvcGVuIGEgZGV2aWNlDQo+PiB0aGF0IHdlbnQgYXdh
eSBhdCB0aGUgYmxvY2sgbGF5ZXIsIGJ1dCBzb21laG93IGRvZXMgbm90IGdldCByZW1vdmVkDQo+
PiBpbiB0aW1lIGJ5IHVkZXYgKHdoaWNoIHNlZW1zIHRvIGJlIGEgdXNlcnNwYWNlIGJ1ZyBpbiBD
b3JlT1MpLiAgQnV0DQo+PiBldmVuIHdpdGggdGhhdCB3ZSByZWFsbHkgc2hvdWxkIG5vdCBoYW5n
Lg0KPiANCj4gVGhlIG5ldyBkZXZpY2Ugc2hvdWxkIGJlIGFsbG9jYXRlZCBmcm9tIG1kX3Byb2Jl
KCkgdmlhIGJsa19yZXF1ZXN0X21vZHVsZSgpLA0KPiBhbmQgdGhlIHVuZGVybHlpbmcgZGV2aWNl
cyBhcmUgdmlydGlvLWJsayBmcm9tIHRoZSBmZWRvcmEgQloyMTIxNzkxLg0KPiANCj4gWzFdIGh0
dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjEyMTc5MQ0KPiANCj4g
VGhhbmtzLA0KPiBNaW5nDQo+IA0KDQpJdCB3b3VsZCBiZSByZWFsbHkgaGVscGZ1bCBpZiBtZHJh
aWQgZXhwZXJ0cyBjYW4gd3JpdGUgYmxrdGVzdHMgc28gaXQNCndpbGwgZ2V0IHRlc3RlZCBpbiB0
aGUgbmlnaHRseSBidWlsZHMgYWxvbmcgd2l0aCBvdGhlciB0ZXN0cyB3aXRoDQpkaWZmZXJlbnQg
ZGlzdHJvcy4NCg0KLWNrDQoNCg==
