Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A885B093D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIGPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:53:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C8140561;
        Wed,  7 Sep 2022 08:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQfUGYdaS40bD0eykdw5BXJBsziWghgW3iJVq70sn8VCGmhrdjnLBxhhCzJ7g/Q2TJImFUe+tYbJ/T9wHnMfuCQskJZoUFkAyxBv07RYp6kCpIHlqfbFyKo0dgrc63FPCK19ABhyTPY2seFChNfvBrmbNW5jroFuciNMQBnu17AsqC9tN9Wuo6Y7NO+gbxjzTdmq4SZgLDV8Rod5HAykxQsJofJ6bCbSxTYD+gG4mal3GACR8O2bwjxlD/k5FE0SBTyL6TiN9qFxKEYqFs50z3SncDMSnSw/DryAKvxAAN4Rn+rMZCAG09wCYr7MzqGKjCB8QTUbVMsQUKzXufSzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgblFOR9wmcl4riricvVkd9Li9SNpZmazbgJek3iNTY=;
 b=jkUeYezYwikmqQEOWVNNsDz0owbj3g60/XPUsIq0AzOe54yig23GdAZZJ3AwviOrChj78gtFc4dPqqM0uJ2d0V2QT4L3QTxFK7/NTxXVOlTeZqT8EZu/FR6PLJd4ZM4bc2J1ga/bf/tTgRoDXVWV0igZ6DM1O1AKOtwW92v6LQtdjsJvbY9/39xzvR+W+TIuFsipchurrL2VsqvYBCXErfi0EC0mJ5WnCpwaUKtDVdGIbQy6TjKkYI6YHcOeccLrpw2spxmxS5Na5Nre0YWIBzULN4MH0DucNlKz49Ld+7ItjC/A+imaGscwRHzr4zkBfWtbURdogSb/CrY9O7IuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgblFOR9wmcl4riricvVkd9Li9SNpZmazbgJek3iNTY=;
 b=MYVdknUgFp9fkXnddnZaxROFYDKFYPS1I3/hI3LgYvixIoufOxUcCFiZCPTjWGkWRUVEvx3DMSwI1EFMAlBAUVT9A9BcwM18CPrgGez5hEBZp63dk4jQMTPQi03acBmvRUiT/WpgZ5xvVO8jgoy46FrPfRexzGf4u1NIOvjPvMSJkV0AIqI446IV7b8Y0csHCqcRicELQQP29rkmtPL1h2kQjChChdidCcmTT11XcHBFY6zEpMiY+8xCRS5g0+YBcczYPS+dlt75lCb/z3xPZ/hTjK7lSp/ap7osIn+1/ZbnHM9Pa5tl4/1gfjycuL4W4gCKpa1cQHpylDdmQlq2nw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 15:53:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 15:53:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Thread-Topic: regression caused by block: freeze the queue earlier in
 del_gendisk
Thread-Index: AQHYuWcagyYf9mwy0UOiJ8D06Vd2Ya3KL88AgAl1nACAABI4gIAAZTyAgAAE9YCAAA87AA==
Date:   Wed, 7 Sep 2022 15:53:13 +0000
Message-ID: <2f956a72-7704-6394-4408-26c3f502524e@nvidia.com>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <YxhYjaA3CrMz5njZ@T590> <44ab9f7d-8f00-5f80-210e-f65f02f6fd82@nvidia.com>
 <YxixoYNB0VTc8Zd+@T590>
In-Reply-To: <YxixoYNB0VTc8Zd+@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7638:EE_
x-ms-office365-filtering-correlation-id: 7f0f379d-6468-468d-09b8-08da90e91214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MpaPgoM6ccHgrDLxuuOGwdb9zu+41WfJUl4x6bXxaGbDhcwYCeJUK26j9gDQyJBO90p8S/Rv/YSeuUQdkDosilibYfNGTP5yFuAjaoxI7IUlSXNmFmR2vq5gvQJp8VprQBWBx1JS1vZlcIFwmexpmyXd59bEqunXbP7qMweTCxt1XiAGEOH6hG1qkR13mbneTf9UPliCfrQx/ka7OnuWL8ltytT8hfnkMS03gl8r/0N0Eeh2yccv7NGfv8J+AheWKJhfPPbEcAyhooZC7BfK5OzrgrNnWWSGgXUNeEXVIi/GHeynDfV3b80wlqJH3Cjmk7c8sX0/aiyY/IFwLIgd1R9Jrj8AbRJ1IH1sdkIN/gfLP4iswcxmfhpHvxCJIsyYoHEbK1xwmJk0JKyzfOJd/eV5T2kT0/P9EcYmfvC3+vaD0az1E72hfXSu1N3Y3eeka2IFDi7h/eFLEnMaIe58GbL0Q8SWmRGtShKlWQyuMT4BIDBNRHe8o+pgqAV+/+e/WvxYicMIu7fLPRjieRtq9N72RR9oswQbRDiWIeuORLhqYxPfWlQtCv02oobBNvjp7pSCPxMLuHzs1Xbnl0H3pvT1gawpZyCu90aL5gFJzf/+qG/Nu+GzcT/2uQRl31ofzV9KuYkT4jt8k9+bpp2ZhvvPGmDMDGtEHCfKpuK7Y1atgFzydecH/T+SHVEPHsGOIAzgdGErvKMoRMmhROCEynUKjr1NVE+DFe39o6x+ooNIo4CbOtQnj09C8BzI9H7NivMju1GEzAaBcE7hSUaQgWX9QeN4U95J0g7R0ejXwBji+2RTqqh3g9IyjqIqLw9QIY5PAe/sneEfLW+pv3BzzctVZ3uxjqaFHVLHV+3qJNAHj9Pt9seMvCEej9BJ41s6kghX7nwcyQLP6ePO1M7P8NsUhcBBbf52iSFn+x59m8E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(36756003)(316002)(122000001)(41300700001)(31686004)(5660300002)(83380400001)(71200400001)(38100700002)(38070700005)(54906003)(6916009)(66446008)(6486002)(66946007)(64756008)(4326008)(91956017)(66476007)(966005)(2616005)(86362001)(8676002)(186003)(478600001)(31696002)(53546011)(6506007)(66556008)(2906002)(8936002)(6512007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGtEelprekEybVpVYUIyd0s3MEptb1lsU0w0dHRHbXBXRDNVUHBYNlMvaXB0?=
 =?utf-8?B?eU9KWlFOcCtBc2pqem01OVNLb3l0K3NoVjJqWGVYL0lPZ0g2bWMyMFk5aUFv?=
 =?utf-8?B?QS90dmNhK2l4VWNXekIyNFBYYTA2eHp3dHpxN1Z6aW9ObyszTXZ3RVNCaElC?=
 =?utf-8?B?YXpCa3hqT3RWNFhiaS9lMk9YcFJNcXhQL1lrbEM4ODQxeWovS2x0cjZNc1I4?=
 =?utf-8?B?RC8zNG1TZldoWGt4U2p0Mm9yT0tsaHBDaXVFVkVvREMxaHcyYkZNdi9Kcm85?=
 =?utf-8?B?TkU5ZzFpT25jQUFxNjB0MnFFcVk2NTdWUWMyRFBoU2tSTmZESVBhWFc3dFZl?=
 =?utf-8?B?bEdDUTJGVXlaREwvRDNROVhOR3VQc2NYVWZGYmJpRHRiRnY0cUNuNUxDeUNw?=
 =?utf-8?B?elpreUtwelhvSXRUeHlOUm1Ta2FvRVZjaElXNG1NQ0JjZTI5K2M0ZnJ1Ym85?=
 =?utf-8?B?SUxUK0V2Z0VuOUJuMGVUZEpNNnVjTlpkY0l5REFYbG1PK1dOaTJhU29lbnFm?=
 =?utf-8?B?b0dGdktTczRLd2VEbWxvaVhKOWlNaFlQVThmNnBZVWUrOFUzS0Qza2xjcFdy?=
 =?utf-8?B?K2dtY2l4aGtpcDgrYzA0a0h4bCsyUXNNRVNnOTVpbHZ3VUpMcFZiSE9xWW50?=
 =?utf-8?B?Z21HeXBtV3plMWRZTHE5WENDdUxVRWRGRzBDMzZDbjBxQk82RHQwTXBGZDJF?=
 =?utf-8?B?MmY1aVNEWjIvOUlMMlZ6Ylp1azRZZnRIMHRKa1ZkaXlmMSt1L2ZCVlQrdFdM?=
 =?utf-8?B?RkEyaUJVYVEyVmQ2eHRUUkpjeGRNS3kxR1ZOdG55UGtLaStIWC9QQXRLVjFy?=
 =?utf-8?B?NEJtTU1GYkxUbXl4Wlo0WlI4ekV3NHdZM3ZkV2lpWkFRQTJaU3JWRnZzWDNk?=
 =?utf-8?B?bzVQbGFTNGxadGtaVXdXTTVqRHNlQjBiLzlkY2FKQ2VHSi9rY1Fsa2JxNlp6?=
 =?utf-8?B?T3g1bWhBcExBejZWRmI2Y0dOckVWR05kbzNDbCs5UXg0N3lZYk4zc0loVDNK?=
 =?utf-8?B?Z2w0aXdOR056WDd4bWk5TkhzSDZHRW92eGtJdlZMTk1ET202RURLL1RmSGt2?=
 =?utf-8?B?ek1uUHlVdWYvUVUvRjBmUllxeUdHUmF4em9WT1NoQkcxVElGOUpHRVRwV05D?=
 =?utf-8?B?ZGxKVDlKbW9ablRLSlZyYU1vYWQ1YVphU01jRm1GOFhMUUI0elVMZXdNRmlv?=
 =?utf-8?B?dUdxbzFQME10ZFdtMTNIQ2NhSjllc3JkbHEwMEdxTnBsVExWcng0VkNzWWhD?=
 =?utf-8?B?eGhwdTl1c0t6SXQ4aVdQeXd0aGdtYVptMU1tS3A2R2tHbHhLeFdwR2Q3bFNW?=
 =?utf-8?B?cWVhbEM5TUJuM3hENXJ4WmVQaXJ2OVY2VURybTkwVDVGQjdDa1pURmR2SVVr?=
 =?utf-8?B?TVVyYm53L3p4YUMrMWNCQy9jQzE0QVl6STlGcE5KZUpxMVR0MnZ3K3Z0MGpo?=
 =?utf-8?B?Nmd4YWZ4T2FvTXprQWdsNnVEelZhQjJsTm50ZG40bm5NcWVUeVFYWTJLTVoy?=
 =?utf-8?B?ZkJicnphNk5pNFRMcDBWcFV4VG04dml6cXEwWE5KdjYzams0MzVwbmsweDlv?=
 =?utf-8?B?L3RNaUVlSnY1TW9OYVZkZjRvcldYVXRkK0tyTXh2WTlxdVZKM1FGaldnNlBQ?=
 =?utf-8?B?Um5lSDdkMGVPY1pqNWtFenZ3SWplYWdBbzFLbWhtYStLT0ZzTGRlcjJEdnRh?=
 =?utf-8?B?Z1lHT0EvMUMzc3ZzY0JXQTZTMDNYK2w4VGR0U1oyZ0tBY01DVnRNUHA4T3lN?=
 =?utf-8?B?ZXNTKzhqdlZ5MjNQNmRFa0JvYzhhR0RNRzRFeTF6VUpqUWN2c3FRQlNvZVZP?=
 =?utf-8?B?TVF4Y0FPdi96RGpqdGlKaVB0dzhDUSsvK3ZXRG1nSDMva3ZQSmpQQkQ0Z3Fx?=
 =?utf-8?B?YjM0UUk3RkE1TUY5NDl6VHc0SkxMS1I2a0ZCY1hNMjdrWFJoNVo4dFpyV2F6?=
 =?utf-8?B?TmhLeWNqTVBYWmQzenNEclJlRkl6UXpvYy9SQzVQMjdhZnRTMnhrdFdkRzk1?=
 =?utf-8?B?cThMWVRBQ08wNlhjVTUvMnhQUit6SEltK3FTNGJGSkYzSHFWMDIyQUUyWUVt?=
 =?utf-8?B?eFRhQjd2K3g2bEpGNzJTd3J4cXV4L0VweFJRcWZyNDJuNlI5Zm1jK2hnVmMr?=
 =?utf-8?B?OFRVTERGeVplZXFvTk9rSWU5TjZ4K3U1ZEpoTFg2ZnVyYnVuZ243K0lNZlRp?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2797B5BF3F7E754E9C9E9CE24FE1A63E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0f379d-6468-468d-09b8-08da90e91214
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 15:53:13.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6i8naTuC38F//9oqTXjF9jzGG/+xaGI66j65ELEGYKYXAyFLn2+OA7MJanPST2sAtH1pJfXM9xI+Gs+39pyl3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

T24gOS83LzIyIDA3OjU4LCBNaW5nIExlaSB3cm90ZToNCj4gT24gV2VkLCBTZXAgMDcsIDIwMjIg
YXQgMDI6NDA6NTdQTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gSGkgYWxs
LA0KPj4NCj4+IE9uIDkvNy8yMiAwMTozOCwgTWluZyBMZWkgd3JvdGU6DQo+Pj4gT24gV2VkLCBT
ZXAgMDcsIDIwMjIgYXQgMDk6MzM6MjRBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
DQo+Pj4+IE9uIFRodSwgU2VwIDAxLCAyMDIyIGF0IDAzOjA2OjA4UE0gKzA4MDAsIE1pbmcgTGVp
IHdyb3RlOg0KPj4+Pj4gSXQgaXMgYSBiaXQgaGFyZCB0byBhc3NvY2lhdGUgdGhlIGFib3ZlIGNv
bW1pdCB3aXRoIHJlcG9ydGVkIGlzc3VlLg0KPj4+Pg0KPj4+PiBTbyB0aGUgbWVzc2FnZXMgY2xl
YXJseSBhcmUgYWJvdXQgc29tZXRoaW5nIHRyeWluZyB0byBvcGVuIGEgZGV2aWNlDQo+Pj4+IHRo
YXQgd2VudCBhd2F5IGF0IHRoZSBibG9jayBsYXllciwgYnV0IHNvbWVob3cgZG9lcyBub3QgZ2V0
IHJlbW92ZWQNCj4+Pj4gaW4gdGltZSBieSB1ZGV2ICh3aGljaCBzZWVtcyB0byBiZSBhIHVzZXJz
cGFjZSBidWcgaW4gQ29yZU9TKS4gIEJ1dA0KPj4+PiBldmVuIHdpdGggdGhhdCB3ZSByZWFsbHkg
c2hvdWxkIG5vdCBoYW5nLg0KPj4+DQo+Pj4gVGhlIG5ldyBkZXZpY2Ugc2hvdWxkIGJlIGFsbG9j
YXRlZCBmcm9tIG1kX3Byb2JlKCkgdmlhIGJsa19yZXF1ZXN0X21vZHVsZSgpLA0KPj4+IGFuZCB0
aGUgdW5kZXJseWluZyBkZXZpY2VzIGFyZSB2aXJ0aW8tYmxrIGZyb20gdGhlIGZlZG9yYSBCWjIx
MjE3OTEuDQo+Pj4NCj4+PiBbMV0gaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVn
LmNnaT9pZD0yMTIxNzkxDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gTWluZw0KPj4+DQo+Pg0KPj4g
SXQgd291bGQgYmUgcmVhbGx5IGhlbHBmdWwgaWYgbWRyYWlkIGV4cGVydHMgY2FuIHdyaXRlIGJs
a3Rlc3RzIHNvIGl0DQo+PiB3aWxsIGdldCB0ZXN0ZWQgaW4gdGhlIG5pZ2h0bHkgYnVpbGRzIGFs
b25nIHdpdGggb3RoZXIgdGVzdHMgd2l0aA0KPj4gZGlmZmVyZW50IGRpc3Ryb3MuDQo+IA0KPiBD
YW4ndCBhZ3JlZSBtb3JlLCBhbmQgQ2MgbGludXgtcmFpZCBhbmQgb3VyIHJhaWQgZ3V5cy4NCj4g
DQoNCmFsb25nIHdpdGggbGludXgtYmxvY2ssIFNoaW4naWNoaXJvIGFuZCBtZS4NCg0KLWNrDQoN
Cg0KDQo=
