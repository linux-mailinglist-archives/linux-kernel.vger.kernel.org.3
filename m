Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCA14DD1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiCRA07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiCRA05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:26:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F306A1A9C82;
        Thu, 17 Mar 2022 17:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCFw2h5snUFor7boPt029wvxAwhGMIvPjU0XVkHy1z2MfdOby+Wu/dFhh1NNxwtUVAGRKC4oYnRIYjiNjongZd1e4FTR9jMpi5ly4qOT1uGqvVYV2y+JryaWH5UKFBDLffr+iLDiWw3+SH3YbvFaZPPGRdFTF3TR4CHGNtAyyPTIevsi/3uQfg1y2c2on0XQeCHtkqF8CXE1aYBYQ5LyGqAzFHJLIjdltHPLd/hKqagdmGn3v2hh3oTm/Xu88PQME4OnKnzxU3zOzTqduzO5eIrLUxfmmuSuCXOb12uGshVelW603MGL7WWEWDrVgeYFowaipiYKQ+oy8S79+yCbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKGmbYbQmSx4Px24SmQ61FKfkVUbvVzBFa0IqeIXdyc=;
 b=FbkzdYPclkWOjtAqUqqY4Nx9F1Bml7xTWu+lS85T2rxbrPlg7tff9hEw4nxbFBTCOR5FVbTV09aeRv8n5Fu3Gq/5Y2+agBUWpvzz9IGIZz1yfuJB/nQfyK5qKBkCh9hI8P67uJxz8A0T6ZP9I3gs9S4uYniQ2Mgs/37wXAQsUEXdS6bIqWnrGhEwJYrs95wxeR/a6eJf5FELsjpH9jeO+U7ziA0Bqlh34UwGZtLwHC3fpC0FZ/fo8+Rs/hUiD9IqOIe8xn+YxNjm/MDnXh0f5G+WxETD1XYWfTcWHSqJN3PPQ0hfI1CwaM01rqd9GMW+EDZIxjjKrkexwSxMqGV6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKGmbYbQmSx4Px24SmQ61FKfkVUbvVzBFa0IqeIXdyc=;
 b=GD1LPI3PWb0oB44TxJKNJPdCMCYU2s7ZNC/6TlsOjtICA9pWYRycRSjRxhc7imYZCRcvdWHmd7cgWbcuCZulPyfiVQZd9Fgmv+rfb2U92UVr4ExPxxkLJsZYLJdim3r68TsxphnfZ4wacfOsi/jgV4c6fZb5xK+t4SbhOv/JTp2TfMNtg/YnklTwI/lU3IjoBecv0GBaTAi5gJ81s1m0+NzCKBvAmOLimv8GvDkHGnEqmWCsRxouy9kISvk0q5gCk0VaODq3gmKEMGK7MgdNneJLYCAEIM8EXeK7wFvYYWOAv35k8+WYqUyQXB0mq6L8X8ieq+HecBdt5dMmcUjU2A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3201.namprd12.prod.outlook.com (2603:10b6:408:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 00:25:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 00:25:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] xen-blkback: remove redundant assignment to variable i
Thread-Topic: [PATCH] xen-blkback: remove redundant assignment to variable i
Thread-Index: AQHYOllPM4KVnPDwzUOWGkhkOkBQSazESJwA
Date:   Fri, 18 Mar 2022 00:25:37 +0000
Message-ID: <4fc88b8e-302d-16aa-2f2d-3e31787edbf1@nvidia.com>
References: <20220317234646.78158-1-colin.i.king@gmail.com>
In-Reply-To: <20220317234646.78158-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86798bc4-447f-408f-c31c-08da0875d322
x-ms-traffictypediagnostic: BN8PR12MB3201:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3201D946B783E3E4BA9189C8A3139@BN8PR12MB3201.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZfwVJxRC8aG3qdyddvJ3SkAY5vYHYyPaXtqtrX8mOf3PmD9CTCIVqJUad1YVSYd2yMfd+HnSjKjBbsfqBNgmzXm9EGVLVXnKHgHnDMij+c9HjStlKqO1A83e/wZ4spnfoa3eYzE6cTqozShjBK7kldsv09pCKYMwXC3U8Q9SBHlisdc9+6HDbohM0mjSgcj5LfDRAq12MAsPUoqu6tf71EiwwLCYUl3mEjBD9CeOfP2drytFLoeZhMbS9aT6x/WtsLkCvmEmlS+IKagFIp70dHTMODUKrnW6JqcVJlJ6T0htDqMgTVEdNZJBpbGnwd6qQbJ/7IXwn7cFOaraZiVvt6IoMyNmNr62Q5yQuixP2dzIoMeTUB+RzcA3Vb1gdozVf7+D7d23ZLVSsMpqSaTqmpYLZDi+2wXaYrZnlCaCSd8S88Cqp4xmB7otos/cEkoeUzYCuwKpNUBPv2cuCEFyxT0fG4CItrz60c/mbRX5bo4sxeUS7ohErOf4k+/WyfAC8h/ZQWOSGdKhaEZk2oSsJyfEIc/qkZ2VjTWsNHug7oq9oLmFl+FUGyzUSfxJ1eAxu6DASomA4K+Koenhl0k033Ql/ixPTApAkaegUxD+RAD7U/cNoLguLUCZlm0o3OhTES06j7lorCgi2tyb3kAv6jqeLZl22fJ7MhDL3c7MH9drXT1EGd+KWthcUAEAdt7MW/35XScLe6DDh7W1qEMsjn6aXw7LYILcOl8bZor6iC294RIfoLqBspZZO+m3QrOF4eYZIeKaKXdh9NH+kl9+QXsBBHxOUJ7jT90xf9c3uvA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(4326008)(64756008)(8676002)(6486002)(53546011)(66446008)(66946007)(76116006)(66556008)(8936002)(66476007)(316002)(38070700005)(2906002)(110136005)(4744005)(5660300002)(31686004)(36756003)(122000001)(54906003)(38100700002)(83380400001)(186003)(2616005)(86362001)(6506007)(31696002)(71200400001)(6512007)(508600001)(129723003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDBnT3NyQTNOL0grQ2dRYWU1ZUFNV3dnNzRGMlRvQURlRXIrSmtqTTBRSFUz?=
 =?utf-8?B?TGU5WmYyNUZLL2laY1gxUTFqTElQT3NoUE8zYVVId1J0NEJkKzk3bTlsdVRs?=
 =?utf-8?B?eGRxUWtBRXdhdWNsWVR1Q1pDbkhpTjBBZ1hENHBNY2V2Z25PRDIySGdlWVo2?=
 =?utf-8?B?djFTaWRtOXUvWFdqV2xFZ254cjhOcVhaUEkzZnNqREEyV3Z3OUcwRmtYQldp?=
 =?utf-8?B?UW4wNjVMc0t0UW5ScDh3N0QzTGNITDVzSENlZGgzQlRUb1A3TTFnYWlueFFQ?=
 =?utf-8?B?U2xNa1RreFdFRmJYRThCNkN2T2UrUFRJei92ZWpPd01GWkM0MnVZQVFmY2pU?=
 =?utf-8?B?NHdqMFRSYllic2dGNDhtMlphcVhxTXFXb0RacFhnUk12ZnBTemQrQzRucnNH?=
 =?utf-8?B?SUh2Y0FTbE40SW1nUG1vdVBmelBoY29oVm1HZVkreXdiaVpZZGVHYTNUdEJ1?=
 =?utf-8?B?ck92dDVnZHNnT0dkRWxoay9Yam9DemtWdi9JTVdJZkZ5aFhMSlZsUldBbmJ0?=
 =?utf-8?B?eE81TmpzVFBSbHk5R28yek1nRkpNTmZrU1NVancrVS80aWtTbm91eWVEaWhT?=
 =?utf-8?B?R3hBRlNTVkxuTmRSZlRobFdpVk5uUGt2QU5id1BrV3d5a1J5Z3l1OUxjTk1L?=
 =?utf-8?B?aHQ0b1BSM2dqQnp2WWI3TERaekpNY3VsTDFYcVhwUTVGWXlQbjJPU29nRnNn?=
 =?utf-8?B?a3FhVitHbG83UHFsdjF1ME5SK3RtUUJlb3hEQmdxbk9tTG5EK0dOcG1nYVZV?=
 =?utf-8?B?YWJOeE1UcDhaUHorQkRQbUtzMFJNTkFjUVlXendXUzcvVkdsOGpDNXk2RFJN?=
 =?utf-8?B?N0JZc0h6djV5RVZzN01rTTRnL040M3F3ZU01M044eFFFQjkzTjdnbHpwQUtX?=
 =?utf-8?B?VTVXcmxiWjl5MnV4MlJoK0krYi91ZFZhODhrWFlraGVQMzFBc255TmxucmlE?=
 =?utf-8?B?V3RDeXNta3hNeks3M1ZUSFZOL1MrSTB5cEozV2dlN3R0K3J2MkJRZ2J0UDAr?=
 =?utf-8?B?eWxuQ3phVUk1enVKMzFIKzRpYXZNNUhVWWE2dTFhN0RlcUlSTnBJOVhvMzJt?=
 =?utf-8?B?UHoyb0FjS3B6dlVFMEdTNVEzM2xWSzFqQ0RML3V3UXJjY2J2VGFXMzl3dzgy?=
 =?utf-8?B?WHpVSVJhVzlmSllyeGJneW10WDZ0WWFscUhZakNhejl6bE5od0pVM3FaYXV6?=
 =?utf-8?B?VmNVVEVkM05JcFpRNVFHdGFMYmxlQVRPbWJWYVc4ZWh2Nk5iRzZlT3J0VWJW?=
 =?utf-8?B?WmdkSTFhd2lGR3RpeDd4Y0h0SXY1bUxZamZQRy83YkZGM1hTek9MT3VEMElu?=
 =?utf-8?B?TytKMVpEOENiRkZaZzhRVGNOOVJRZlMrczk5azJKOVd2K0cydlJyYVd6VzMv?=
 =?utf-8?B?WDRDUlQ0QytJa1BxTmlZbnJJaEptTHd5ai9JMEFETkh3dE9FSFhuT2dneDhU?=
 =?utf-8?B?Nk1HbU9LakZjMXU3amVaZE5XTzIxSWFUZzNGYnJxbVRrVjc1M0k4NTVtVmh6?=
 =?utf-8?B?dHR1dlppR1FlZnUxdGhiU2VDNVlNN0hoWGZLcXpQOVd1cDR4NVhxU3Nrdkp1?=
 =?utf-8?B?d1ZZUm15SkJJOENlVVpOaUQ0cUl3S0EyZ0lHR1VBY255cG1xWFdRL2NZTmxj?=
 =?utf-8?B?bHdPdk05VlFrZ3dySDZwNERWTFgrTzQ2NFQxK1MxWXRGVnM5YU1hcVNoWE04?=
 =?utf-8?B?eGtzVFVtMlZxSVJteUpvNzJvNHlXbDlMNVhQSjdXS2JUM2xad2dRcjhWOUZw?=
 =?utf-8?B?WXBYeGpqVG5XNkwxTDVoamlUMkN3ZWdGVGd4R0JKbEhJT3BGdWRWQ0l5djFl?=
 =?utf-8?B?TVFWRjEvSkNoL0tPU1lCVlJTaXB1M09pUyt5encwNkJGN2kxUjcrbWhOL3FX?=
 =?utf-8?B?MkhRYlRjNXpseUsrWUttQWV2clNhRFNVMUdlbFBFTjFOVWRaREUyRm1LSTNJ?=
 =?utf-8?B?K3FOTzBDK2pzcjJGQ091bzU0TEpZWjliODhKVGlDV0cxV0FzWUFXVFBkQ0JG?=
 =?utf-8?B?aFlxbWZ4ejZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39E414D16177E043AA5A8671299F4A79@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86798bc4-447f-408f-c31c-08da0875d322
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 00:25:37.2031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WP9UnmogmyOOb512wuLGuh7+8KkiMwOLxkMzQ2VWmFOXbz0lVCKw6gWjJD5ECosgD2vBXX81tJ3MKp/B9LTOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3201
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNy8yMiA0OjQ2IFBNLCBDb2xpbiBJYW4gS2luZyB3cm90ZToNCj4gVmFyaWFibGUgaSBp
cyBiZWluZyBhc3NpZ25lZCBhIHZhbHVlIHRoYXQgaXMgbmV2ZXIgcmVhZCwgaXQgaXMgYmVpbmcN
Cj4gcmUtYXNzaWduZWQgbGF0ZXIgaW4gYSBmb3ItbG9vcC4gVGhlIGFzc2lnbm1lbnQgaXMgcmVk
dW5kYW50IGFuZCBjYW4NCj4gYmUgcmVtb3ZlZC4NCj4gDQo+IENsZWFucyB1cCBjbGFuZyBzY2Fu
IGJ1aWxkIHdhcm5pbmc6DQo+IGRyaXZlcnMvYmxvY2sveGVuLWJsa2JhY2svYmxrYmFjay5jOjkz
NDoxNDogd2FybmluZzogQWx0aG91Z2ggdGhlIHZhbHVlDQo+IHN0b3JlZCB0byAnaScgaXMgdXNl
ZCBpbiB0aGUgZW5jbG9zaW5nIGV4cHJlc3Npb24sIHRoZSB2YWx1ZSBpcyBuZXZlcg0KPiBhY3R1
YWxseSByZWFkIGZyb20gJ2knIFtkZWFkY29kZS5EZWFkU3RvcmVzXQ0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQoNCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==
