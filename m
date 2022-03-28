Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B52F4E8C67
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiC1DB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbiC1DBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:01:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E246147;
        Sun, 27 Mar 2022 20:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL5tzO5Bcpdad0hhvgzHucD8xGQFT3nvd1LR1R9PqNyjdTPcET41/D56HVMvZ8lvYlTAcDrzx3vz4F36lcVOyfuRDSkxXhJvfGxW198fAuRWjuSXc+fVGUPfz8Tg/QmcRmqkTxTZ+RivgXFnXSxbOkpi6g8BnoAr8VZVoKSJvOZARitXj+O3Ww6KQbEK/O1NhDtR8koK5JvYX3ba/Y77aiXV8gpUx5ECzxdei0oFWVmxQbzqyBd+mZCs4c+Y0EotFcJI9QlXRsTXQ97fl0rZYRsRd8a1UpNi2uvLSoRsM0Pbx1m9547FxhHZ0kOWUM1rT6hkRXrrbUOJAxwm+QRnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gU0FDGCMxXsCw9D95XYmO4LbxvmRLk/PFR3km1Nu6g=;
 b=CMuplUUej0moCfecRkx2br8VuseD94LvYKeJ7JQ+EG3idG+5DROoGrCaNIdMVCnOqzw8ZXxoKum6xEpUldhwEKfA6lE5PAZHz9PyPMj/5bP9HLyuNmZy6LM+++ChT/EBYbDJT7p7+Xn1ccx1MelCA1A4ryH820tKzvlIbPA+LmJM6mqOzQ78T18TVUCcnO0qm8q7D74CWXdt9i5ZqYm1Idy+YRIuGhKSG71aisBjXZWFoIUmXEvtQTbopK5cge4JCiNYLXtGS8tmUTg0GqmgA/3QIsDk3qcZXX1U3ni12IcFFym2YdG5F//gWGRekgt005NC7L3zGI/y7Tg6e+FT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gU0FDGCMxXsCw9D95XYmO4LbxvmRLk/PFR3km1Nu6g=;
 b=iRI239N9nnL/kiQNCtsnwWmX150fjZ+CA1ToEMpL+1VRboOVhuk3BesT2oHEiWX9bTwFZbJQS0r8xFf/4oRSpilgYdd/BlLYsDdn4fJuSw0VkjCZ1TTYreDByA+zmwwNRGGSkldutMshZU8Y2u73gUskQVKfy9VHTw9K/2FX/Iar0qc79WEiesGGLikTNVdfBW6VpdkcKYtlNsIxXvV44+iOZ0i6zOMkMAvo7yVBQ2Gy3TjQVvIcJkkxeHj+bv/9eKS1VSz/mqhDwDrTXK5E9yJZznnnY9c/yYxls9NKLJlXzHSr9nyJbMLevSWfiR84pU7ADcgw7EbuMg/t/VfU5Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.22; Mon, 28 Mar 2022 03:00:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 03:00:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] null_blk: Update ida_simple_get()/ida_simple_remove()
 to the newer ida API
Thread-Topic: [PATCH 2/2] null_blk: Update
 ida_simple_get()/ida_simple_remove() to the newer ida API
Thread-Index: AQHYQgtQ4Eut1/orY0W5+eN/bYn0HqzUG8kp
Date:   Mon, 28 Mar 2022 03:00:10 +0000
Message-ID: <5AC28FBB-D03E-4C01-A2DD-AED52A403216@nvidia.com>
References: <876904b8334049a3be89d8bd278b04a421601baa.1648406899.git.christophe.jaillet@wanadoo.fr>
 <0e758e026fae17eaaae7a5d918cce3490e476a2e.1648406899.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0e758e026fae17eaaae7a5d918cce3490e476a2e.1648406899.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f66f222-ac15-4b86-59c2-08da10671299
x-ms-traffictypediagnostic: DM5PR12MB1625:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1625705C439486396FFA896BA31D9@DM5PR12MB1625.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQE4gOv+totIHkyDZaN2p4Y7gXzNgUVJ+UgIDrJMD8B2IIHjD7fkaNa5bDk1qO5iAKJ0jiCG33HbueT4AbLUWK8SWfniQssjsTnGwQDgYnS7JHpd3bJxcDqlW8ubiawc8cA1nUdSakMaVWSIVmt+q5aE+xXEkRgm10bXYBtJrJCRhIX7UTSNHylDOtUzP+zSUXOnd6duczBhfGF28E4sCnAhEzdfSFI5pYSrNrFBhhMXpOrWn7OYNf972aUk7OlXmPraPKHwcdhg+MakoJAbMyPjRSFAgfD6TK8d7Ro5NRpohvLS/zu5Q+1m3h7JtVzNBbGWcIulS9aIVBqk5JW9pdmweQ5YibaXVDG17NKC3RmbnpyBVxSNjHQ60b9ab7I4v5tOs/0wrK6EvGZQEkE4YqjaYMBWDZxzQEErKx114QloSbEY89sa2CJhoLqxgZb8ZgzDT9UM7I2JFd1jY9M8U9XL46DdOIAw1JflI3Flqq00pWXNNSS0g3Si/nx/SpAfUugBo/HCfwMscg8spirt+ZRNIbft8ggiDTZWfUDo7ARV1ehruDONiN7PhHdXuM+dJmpZfcu22JL73FirVsl4XCNKsegvHxSRyc7DiWmYEBYusoFdbIbHKAaf1EOVGBeXSzLYAJDx7tsPGC64Mus06eV8Iq5CFJim+4S7KiJjwhKaguNnoYrQ0ac3ROFZjb1E0oSctDGpdjl88kkmMsFPRZGT6rK04UvQI9eBa/4jRgNQjZ4ua0AR/16/DRr9hdhV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(508600001)(186003)(38100700002)(66556008)(5660300002)(8936002)(6486002)(2616005)(38070700005)(71200400001)(53546011)(6512007)(316002)(6506007)(6916009)(54906003)(33656002)(36756003)(558084003)(8676002)(76116006)(64756008)(4326008)(66446008)(66476007)(91956017)(66946007)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTJnR3Y1UjlIK3JTd3VIYTBGbUptR2l4dVdwRUg2eE82dkpvS09LUmhnenBr?=
 =?utf-8?B?ckxvcm1YNStaWmNmK1hIYTJsaHBtNU1LTWFUWnByK3RyWkJhbWJ4NUtsTDVR?=
 =?utf-8?B?clNGUjkzMStlS1RLWXhyNytUTmxmK2MzMDNESUJQRW1Lc0NNd2V4SG5VUmhw?=
 =?utf-8?B?RGV5TFJ0T1NTMlB5UlFDL2tsaWwrd2JxVzlKVFIyWHJLc2cwcTBGb3dUMkJV?=
 =?utf-8?B?OTV2dWI4UHFLMFRDZDhReUJGdzZ1YmIrVEh4blZQOTV4SlJsUFR0a3RBdHFp?=
 =?utf-8?B?SnBMSVo0djgzbE9wVVcra0RSeHVGWjIxRFFkOS9McU1nMmVmdzJLRUNjUzIx?=
 =?utf-8?B?TjJkY2Z1bEFVVmhXYVV4amc5QWE0allWcGVQVTd4VElkM0JUbk5PbnZFWGZm?=
 =?utf-8?B?bGRFVG1sSXkrbXNENHk3UW1YeEVDK1plWFQzSzNySUxpSGhRbHhTVmMzeEd6?=
 =?utf-8?B?MVZ5RGVpME5LVkFOKzRURi96bkNsR1k0cWpjNmlFRkdFdGVjREtIcTdPSUwz?=
 =?utf-8?B?aUliaTdNMFh2bXN0K1h3YUprRkwwWVdjUGFwVUIwK1Bzcy8vTUlWZ1Z4Ryti?=
 =?utf-8?B?M2lueTZNVytNS3dCb3VvbmxOZzdFYWtBUWJ0azVrV1Q2VWpDM2ZaVXRuN1M0?=
 =?utf-8?B?aXArdHFjUUZGeXc1SVlrZkdJYVNkK0kxdWlxOWNHVS9TYXZsdmRsbk0rL2t5?=
 =?utf-8?B?L2lkVTBOd3BvVk1pSXo3OENpaEpKRzhxQ1Z0bVViQ0ZMSEp5TS9rcTdnZVN1?=
 =?utf-8?B?S2o2L0l1eDhQbEhaU1pYSFY0N2Y3dEppdk5WdE1uM095R1RWNEdUdmtqaUV6?=
 =?utf-8?B?T084KzdUUVdyMjJLTnErb2dROSsyNk9XNjZXSGdxQ29uNGs4MWRiRVpZZy9S?=
 =?utf-8?B?Zjh0emNnbnpiWVdWdlhNcjYvajVyUDJjYmJQM2lWTmxNRFFicXMvRVIyL1pR?=
 =?utf-8?B?ck1jYTFLNkYvcUp6byt2eUc0aUNkSW10WjZHSXdkSU9rV3NSa2IzK3FobmlT?=
 =?utf-8?B?NUs1MEdvQXRQbTF0bHE0bG5NNlJkRzdVZGRiZHdmMzBJTXhXY0c1aXJNeEIz?=
 =?utf-8?B?WkNjT0VvQTdYZ2xpejY0TjJzdGRxYktIN3hLMDNqMENTb2ljeSsyKzl4Si94?=
 =?utf-8?B?VFZOUGJKa0tCbENGcHJzNnFPbEl3VzFxWHlXSXhlQkE5NEZDOVg0c2xzUlRu?=
 =?utf-8?B?RU1uQ2Via2tJU3YzSGdIenZEQlpBeDZ6WTdLNWNOWHZVWU1tMlpWMld6UDhC?=
 =?utf-8?B?eG9SR3JmS1BXb3BZNTFtb3RXdE9va3UyRjJ0RTcxdE1jeXA4aFcya254bjZx?=
 =?utf-8?B?SXNObFVRcjNxWDhqbVJCTEF6aEg2NGdlMXBVRjN1WmFXeWRGT1VseFRpNkJ3?=
 =?utf-8?B?KzlpSHpYcGIwVVBPY0Joa3hzRWg0ejVFOWVnOUFRUVorYmp3dlNsTWxkT2hT?=
 =?utf-8?B?Wnc1bjdPdlcvNlN0aHJRRFEyTGFpZDFLSWl1U0M4NG5xNGUzTU90eFN0QU9T?=
 =?utf-8?B?V1daM2RTUEtzYXZmZkpDU3VZR1QxKy9aMHoyQmhuME4yZ0hqbVJqd0FtZjFI?=
 =?utf-8?B?R3ZvcVVkRXQvNTZpNENkUC9Pd2lKNnRZcjFkSktnRnpYSUh1eEdYamVNT3Vq?=
 =?utf-8?B?Q2xEellNKzVTT0VhNmtLNG90Q2ViQjJadXdpN09CcjA3NVdPRFViNzhJM0k5?=
 =?utf-8?B?UzEyM04rKzhFYjdDeGZzUjRSSWVTM2hRK1VtT1BLNDJ1WTBISHgwMXpQd2NF?=
 =?utf-8?B?RE9nRE44UWhnWHhnY1NqdUtiQTVwdjdsaFR1eER2UU5qM1NZa2t5Y2JqRmlh?=
 =?utf-8?B?R09ObWJIdU1DOU1mZUVBeEpsQVhTcy8rK3R2Z3E3MnRPTFhQdklWUmc4NzJz?=
 =?utf-8?B?ZkNUc05rcXB5czB3TmZ5Y3lrTFQ2L1VuaG9LZFZ5c1JqMWpNOVRnVVRQcWtE?=
 =?utf-8?B?T3dqdEw3SzBUMW9yWXpIcnIvODJIOG1FYmcyM09YRmxYRzZVK2d0RDFsU1pB?=
 =?utf-8?B?M2Rxc21Ia0I2ai9sRGlFRHdhOEd2bnlZbUNjVHl4NVZ1ODA1c1RGRElMYm9i?=
 =?utf-8?B?VzZHUDlybDhWNWR5VHNmNFJLNGllcmFtZHN4OGszdEN6RWpMSFFTQTFWK2Va?=
 =?utf-8?B?OTdqKzJYWHlWbit5b3o3R3FHSUJZTVNkSjYxL0kremJTY0R6amVlTzkyYU1j?=
 =?utf-8?B?VksycGdTL1MxMWJ6eUFZT241YlMzYmV6MWtHOGloUzZqcldwbG1CNHV1Yytt?=
 =?utf-8?B?TWdnbTNmbWI0ejZHellQckd6eTNpaVNYUERISnpyTGN2V1k0Z1IyaGVBMGlm?=
 =?utf-8?B?OHE0ZWdNNGhPdFZXWEpvT3A5a2NVVllJb1Rna1pXenVnKzJxY3MwSEg4OG5Q?=
 =?utf-8?Q?+hqa5jfi/N4QFY9fLsGQk5VJeO2XBMkIgN/62UyKpGDBX?=
x-ms-exchange-antispam-messagedata-1: jdvRiVVIYAiOB9YIBmbzr1KlxHr3JJRH7IY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f66f222-ac15-4b86-59c2-08da10671299
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 03:00:10.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWzRoXlUPeusOUBku7W1gmIZPQQYHTNCerY3y92jLaPF83m3/fVLOXt3dYSeNLHJhOoc0JBP4raaNkGcnM+DvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1hciAyNywgMjAyMiwgYXQgMTE6NDggQU0sIENocmlzdG9waGUgSkFJTExFVCA8Y2hy
aXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+IHdyb3RlOg0KPiANCj4g77u/aWRhX3NpbXBsZV9n
ZXQoKSBhbmQgaWRhX3NpbXBsZV9yZW1vdmUoKSBhcmUgZGVwcmVjYXRlZC4gVXNlIGlkYV9hbGxv
YygpDQo+IGFuZCBpZGFfZnJlZSgpIGluc3RlYWQuIEl0IGlzIGxlc3MgdmVyYm9zZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdh
bmFkb28uZnI+DQo+IA0KDQpJIGhhdmUgYWxyZWR5IHNlbnQgb3V0IHBhdGNoIGZvciB0aGlzLi4u
Lg0KDQoNCg==
