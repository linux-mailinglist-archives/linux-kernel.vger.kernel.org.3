Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1C533691
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbiEYFvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiEYFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:51:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8581652513;
        Tue, 24 May 2022 22:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM14m/JDV6SqEUYX4kTRR2TF2b3uauuEyuoVxUhRbGd+lvF1g4sTpBnbeEmxBI12xHkyO6AXaWDFPcfhFaYsb6ekIjoDglRoafNOUmLvGAqXIuY1WeM/R4gN1LZwI4rlgwosSK6Osy8bHQ6GnpLvhhY1qHRe5cZYbD73ku1LhEItuiha/hmM1StXRPir0Ql962g8H0vxf32wKF80RKqokz8mBBIb0pIR5nSLRCRqT+X0+1QeOs/dl8tAPRmatyu9nPattRN4RUmvdvLfrefpaOV+tFS9nGo0Y3M+C0O6ReMsR9oX0wO4jlD8T7gbXm8VdSfAZqEb/DzPSBKCHgqFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8RxvayOi4f8YT93+KB6r1fQTH/COpnc6UNHg6Knknc=;
 b=m64ibysU37Sp6wgqNoJf+15xnS/3hzfOzXoX95QMTKl6gmN1S/VulcdtmQ17oNyd3XKNnvUfPw6eGi+T6P5nDUhajgxVSPeKwkQAC5A26UIZOnxDwDUZ7QfbteEIFtBxHRcM6h5e2gsI357N9acPRta6HmsPFjQFURoVqHPqJJqIzYGRj+MoezE8To80MdLsM7G4BRw8IQQsIBHae3p6nWeiE0jJ7Kdlc7K42Hw8NJRa1DbK9Gh8VNN//ofr234vDA18NfnRZkHRiC33qxn1oEY3v/9Esh6aqaNkavfEeSBAlZ+GfSDEf7jEMIUVBbYSH+yNgtkRjAaw1k5g9+OmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8RxvayOi4f8YT93+KB6r1fQTH/COpnc6UNHg6Knknc=;
 b=KCefSXNfhZQUmZs8EPAl/YlRoCv5G9lvrsdPHeupQk19P90SNOREgEpR8FdDArgcvOoudmgnB4ZOF5QMdgGVTIQP7sgI+vs/00hfQ+ip2hBfXQuG4VeVSraO3O7nj/SWc7YpwYW32N+kEQpjh5yNja/JmLBvf86fLILxgTktctcvn5bnoaUTuXbtjprxXzEWmcr/4QIrFGOXLnW37aLZiSS9SU6bxfHi5RHktDglEuMA8gLK/KhNou3MThlBvcvDwC0FQPVlnSfG0J00Yx85XZmoG1LGgjbveP4rIFOQWBy+0aWWJbptSH70KQ1Bv7JVhyo4lRAP+nsgEauro/O5rA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 05:51:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d9a5:f1df:5975:a0d6]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d9a5:f1df:5975:a0d6%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 05:51:36 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Christoph Hellwig <hch@lst.de>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: fix typo in comment
Thread-Topic: [PATCH] nvmet: fix typo in comment
Thread-Index: AQHYbQObpRgZPB8DQECEJV4e3qoYWa0vHPYA
Date:   Wed, 25 May 2022 05:51:36 +0000
Message-ID: <86ea84a6-87a2-856e-75e3-7ff4d52715b0@nvidia.com>
References: <20220521111145.81697-26-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-26-Julia.Lawall@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c95d08f1-9e6c-40bb-cf80-08da3e12a1a1
x-ms-traffictypediagnostic: MN2PR12MB4064:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4064D7FF2C1D52E6FF555516A3D69@MN2PR12MB4064.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dqE+Pd9fqFT/1D2zpBvUL9SrDXf6+DniOt+Q0hbozUJHP+9kNJA601HMnF/LYDCxxJrU1BlDxFZNWff2KLzFTTKOFlk2LFnRil9IS2a7c5HDehdjqNQzX4rqSRD2ppMy8E0ZRy/IaabSxwypgMc6jNFNbgr/6II3dD9eoTgVyh0BsadsGiy+e38sSDasjUr3UtNWuetN9EOaZTb2cgSWvHWjnhulvip479/6pOOPr7K1UsuDNlpu7G1nKolOZP8THbOOny11OKculyvCsY+gba0vLQqAF86UMEIdje/uBGkX+w+bKyV/MtzQwGqHOiE6GxMFK2xt56a1mIcG1h0k52p1DWWV1Q5XxzzilBHy2Wy2PPyOwosZBfb4QZBGOqH4Qecg2TAajT7uZrschJbQ80FVZR0xuz3propD5Z+nF7j7/WCJ1ToqMQrgJyM/Y4EvplpvWNIv4gZa//H/dD1AZocYgx7avNnkmAmulH443/IV0qlM8Cnxny9gh+W8N9ygwqzRtKenVYnQlD2K9qMZ5jijN7AbusOdKMrwFqWhkIk5XlmRUNUG++ad0e4yj9VjORdZJOwPo++ZBaiKieHWja+1jlrIf6mfzPTt3jcsiIG7Jw/wvycK4dA5FytE69WUwsjPpcl8fyWXPsGwRx6oActeECIuGM8K1v7TqxAHCQBiXcfQH6YVMfbUenh0Gqyv9CRXWyjHHAkEiav+sX3jUZB0zYSy5A2EgXmoeSbrVWwDXCiIffSXWY7GFWvuu3yjjCeaV8H9aJX+/GGet+94g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(508600001)(5660300002)(36756003)(110136005)(54906003)(71200400001)(31686004)(83380400001)(31696002)(91956017)(6486002)(8676002)(4326008)(558084003)(86362001)(2616005)(38070700005)(38100700002)(76116006)(66446008)(66476007)(66946007)(66556008)(64756008)(122000001)(6506007)(8936002)(6512007)(53546011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWtIMW5jTnpjVXo4RkZzUEV0RTcyOVJKL2hOZzRYMUhkSi9HSjk5VGFuMFha?=
 =?utf-8?B?T1JKWTJmRFloamttL0hqRVFkRzJSVGY3bzN2OHAyL3c0UmZFd01ZNU1Jc2VL?=
 =?utf-8?B?a2JGaE9EQ040ektyRFgrQ3NrZnRtelA3UDBzTnV4d2FWeUhxRmlRR1NWV2xP?=
 =?utf-8?B?bzBBbEgyUWlGTjllai9oMnJDUUFPdGdpL0pzSUUrMWpraytkLzNIZHVSOEZ6?=
 =?utf-8?B?Tk9uMzNwalVRNElBUGFqTVpzMndEKzAvcW5SOFBHQnVDUTdVeExkT2x2WnJX?=
 =?utf-8?B?d1lla1EzK0lETmUwOXRRZlZ6RlgwdGdRcDFmdnhrMEl5RmJIcE0yY1dNcVNU?=
 =?utf-8?B?dFFBbjhBNitPeUhJSXNoWXJWNnRSaUdOL1B5aE5WOVNRTmVkS2EvMTZXYW1v?=
 =?utf-8?B?K2hIcVdNWEIvejhKSFVLbkIvRWpqLzJtdEtMeHJRTnhSbTU4eVcrbzJOaTdi?=
 =?utf-8?B?dEpnSk5JcEFSbWZ5amRqdTlGMUlHRG9zSjg5WldpS0p1TnZFbmM0VzNBT3hS?=
 =?utf-8?B?OFNnenFwYmw5YUxNNnl1VHBiaDZHdXh5UmNiU2hra2UreGpZekNKWXBueHd3?=
 =?utf-8?B?bmlaczJxcTExZkFWSlE5NGVrdHlCVWw3L3JJSkFObUdQK2IzOGNJL1RCMDdH?=
 =?utf-8?B?TFc1NlJuRS9OTjRNMDgrSGRBVVFOYVFWMEZCd3puTHZjSnAvWUxCZWR2NGpm?=
 =?utf-8?B?V3dUVFZPaGsrUWtGa3ltMUpBdm1QQjhYM0d6WFZMVk1EOWQxekwvM3ZoNUky?=
 =?utf-8?B?WXhFRVprK1VoRUNTalN3aUJjaGRNd0l4b0NHeU45NmVVNEUvUXlRSFV6a3E4?=
 =?utf-8?B?NjBHZVFFcS9RMVFDaXRMVlZjQldUZVVmWjlhSjE0elU1NG9KL2VvdlNyTWl5?=
 =?utf-8?B?V1pFZ0pLMXkxdFN6VnI4UUVjWFRhZVluZ2pZZlNDMUNxYk1ZenA3b2hPak9L?=
 =?utf-8?B?NUxodUhjOVZGMDBYNDBVRXJMaWd4R1hSKzM5dk9TT01GamdwUVgyV2pKVUJQ?=
 =?utf-8?B?N2M5U3ZmM0dtQ1lMZWVyR1FsVGlqc2xub3daTmNuTjYxY3g4ZXpBSlUrYm1I?=
 =?utf-8?B?RGYzZkdCbklPTHdBa0c2b0E1cVdKc1FnSmpyT3ZJYVNmK1M1Y1llT3ZnN3ZL?=
 =?utf-8?B?R0g4Z3lSMkZyMmUwMWRnSWZwNkx3UUd3cnhOU01sR25BU3h4VHYwV0lueHBj?=
 =?utf-8?B?YlArVnVOTE9haG5yMGRjckpXT2QwSllJNHR1cUljVFlwNU9WbDF1MU1nWGo2?=
 =?utf-8?B?MC9TQzVUeGphRW53WTJ3R2VOZ3l0UXlYN3lXNTdUejdzcVJDQkJEbFBGOVow?=
 =?utf-8?B?Uzk5Q2Iva3BjODdPNEtOaUh3a2JWNmJqUXQzVWE0MWh4NVFxcTdYdGZ2TXFn?=
 =?utf-8?B?QmFXbE1UU0dhd3dLQ05VYThBeG9BVmpjOGNNVkhHbXhPbXZ0clZrclBJTjZO?=
 =?utf-8?B?Zk04NlY3cGZwb1kzMS96eE51bmlycVlMVEhzNnFUWktDZ21qU0RlVWRUeTZp?=
 =?utf-8?B?RHhMR1JFcEVhSzAxakZTaG93QVJWdG5SU3VNaVIvclgzTHlvemJEZm5LK3ha?=
 =?utf-8?B?c1lBWkxBWHFaVkNXalJZV09DMzV4L1FTTFQzV1VBanhaMktUL292dnd4aHBs?=
 =?utf-8?B?RFErTkV3bTJ4ZTRpejgyVkFxVjZqcVlzQ1JiR1JTUEYyeE5ScEUyUGhiRHg0?=
 =?utf-8?B?SUNiMTNad0tFNFVwM1hUTm15czcya3FKNWVENzA2c2pOT0d5OXRUekFwNFMz?=
 =?utf-8?B?TDZ3VEloL3pjTEs4S3ZDUjlmaG9wSXhET0VkQU95RnJmMHBmWVJpWnJVczFL?=
 =?utf-8?B?TXdmM2ZCaitLdnpLSmxmbkJsSkozTDVUNFRKcjMza2dBa0VMNFoxTGJtSFFo?=
 =?utf-8?B?c3hzTlFjWEFvOE1uK2ZHaW0rd2NsUUNHQkdQYXdGL2tDbWVOdTIveFB3U0hl?=
 =?utf-8?B?TjM3aSt1dFFuRFNmOEt5cncyWmZaQUJGbEtVUUZKRGtmUXhMakFsMHhyR2tC?=
 =?utf-8?B?SWFYUG1YbE1TcWo1S3ZMcUdRUktaaERiZTU3c3dsZm5EdDBlUENjOG9vUWw5?=
 =?utf-8?B?cDl4WXluV05xVm9tU25vOThxcG92SFJkc2N6ck0wdW9zSVphMzMxRTZlZmJT?=
 =?utf-8?B?WmI0by9YcHpLbHB3SGZzL0hUMlFLRmVxS05EVHRYUjY3eUw5Qit0eitZb2xt?=
 =?utf-8?B?dmNidXlWKy9CNWRLRlJ2QWJKOVdyaGJUOVNuUm1VNG9pODJkdDg0UmlKQmpF?=
 =?utf-8?B?UkkveUxtWDFhTDZaWDNmVFlHbEdrNEFaVDQ5cTUyZnJaMzlFUXE3K0krbVI1?=
 =?utf-8?B?aVlJeG1aRGhER3JXMk5idW04MGdaSFZjVVAxUW9hVDFmUmVBdnZpc1FIU3gz?=
 =?utf-8?Q?vs9BwYCn1McuNRJr2Y3ZMJEF2wfTI7Uc8cBoCnOlKVBb4?=
x-ms-exchange-antispam-messagedata-1: ULUVxC1o9ZW+2Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <445F6285CD67474DAF9CDAD8D509D11A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95d08f1-9e6c-40bb-cf80-08da3e12a1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 05:51:36.7791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSWf1OSEXsfaZ2LSWyJyEO/9EREY9gj0bxw6hVN1Vl46jt0eBtyQgKav1vwYC7bv//f6+R+ljaI8Uv3I6fAcmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMS8yMiAwNDoxMCwgSnVsaWEgTGF3YWxsIHdyb3RlOg0KPiBTcGVsbGluZyBtaXN0YWtl
ICh0cmlwbGUgbGV0dGVycykgaW4gY29tbWVudC4NCj4gRGV0ZWN0ZWQgd2l0aCB0aGUgaGVscCBv
ZiBDb2NjaW5lbGxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSnVsaWEgTGF3YWxsIDxKdWxpYS5M
YXdhbGxAaW5yaWEuZnI+DQo+IA0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
