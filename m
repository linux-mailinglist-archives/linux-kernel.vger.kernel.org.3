Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A712D525B46
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377180AbiEMGNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbiEMGNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:13:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880626CC5B;
        Thu, 12 May 2022 23:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9iI90EEUgJls4vUNNIdEfVLVcbP/gCIUKFUQJmmE1gTHyke3FeKq0kwKpQJdxmCFLRXrbU2Z3TsUfNbYjA3MsCCODQc8V+SfD+7vLAppAn8e1lQj14rAgoFj1Bq6otup3ashzWm9Y9oixyDbuh5b9EsxuJxvnadccXYWye3hiLYfjUPqdp53tYOIG0T5ilAshOGADg34d4qDNUS0A+jKQA2H1LKEKByXR/woZUeo94hlrIs6K4V7o28EHtCcUkWCkAHVQCIdLk+R5CpVKyBkbHSGhXJBaCILVc90ILjW1xOEwfAiOmn2coRSvvSZ0YxdyzIbNUUjei2MoF339qjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e8Wv4VELYB/ehTnVMm02f2TgZEWN3lEgb+kzAhQ6Ew=;
 b=g/ST2C6BSuetQAk9bpSK+RlAC2Sw9v58NfOVa+qNETOY4AJqP3/WHoQgsIiQETQSWoVdZxmMqycpn1hcyB8DURR4sBuRwqDl6t/1rzJPEF3c0RT1i2G0NomlR+mtQ/pT4q+MS63IrIYew87lReYxt38PEWEBw/vj984P1fjsvhFMF1NwJn5ml2Hx6uuss4lL7f+lv95H93MD+dmZayxaEb5+ksx+g1V6pv5Brk68fiJGmxAFFvJKfgANU+bH8Rd2Nmh/G24yNPot1WE0qWsYD9W14fLoXYLyeqMbyS4D7hpLcoFPTDmNlbkJWAcs3yvBubtcSv/5cp09PTfynoZhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e8Wv4VELYB/ehTnVMm02f2TgZEWN3lEgb+kzAhQ6Ew=;
 b=hGUze4PeMO+yC7eaPjVA2FQQTCnJdRKklJXGeoHqr04CeGjG3aYzVmyOkR94Kc8ZpwFYWGC4mf7h53NgPjLeMr/zI+sdirUqGLtGrUtJSzsQFosqyTTrkF7wRvkxkTyQvv7ri5tUtORMB2ewlIEHMDidef1UWyLXXJbA24t7wrLt3jenc50kKN+NC4qYUiXiTvWhZ41y2melH4kzjEEGz6gZuJTQUQ538AVFx0gOnRvbpOSHpZJWQPlYVfxevSykGJt03qmQ4Yel0EWmfwBKtM1O27z3OMyxLu8l6L406jBgaPAYc2gBIFhjM168VKJtp9jUP6LWlLHbNoKvIJIqyw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB2492.namprd12.prod.outlook.com (2603:10b6:300:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Fri, 13 May
 2022 06:13:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 06:13:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yu Kuai <yukuai3@huawei.com>, "jack@suse.cz" <jack@suse.cz>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH -next v2 1/2] block, bfq: protect 'bfqd->queued' by
 'bfqd->lock'
Thread-Topic: [PATCH -next v2 1/2] block, bfq: protect 'bfqd->queued' by
 'bfqd->lock'
Thread-Index: AQHYZnAlrSuvmBGG30eKyGWNl/BJDa0cVCIA
Date:   Fri, 13 May 2022 06:13:02 +0000
Message-ID: <76d12440-83f9-963b-da3b-94cb7ae26d94@nvidia.com>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
 <20220513023507.2625717-2-yukuai3@huawei.com>
In-Reply-To: <20220513023507.2625717-2-yukuai3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abe47802-b606-44f3-a40d-08da34a7a348
x-ms-traffictypediagnostic: MWHPR1201MB2492:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB24928F8A1EEFFBEC35609DBBA3CA9@MWHPR1201MB2492.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXk17DpXkO9Gmx61e5JmcsHO2IHwOUIzgGxqvXzBl5bSpp2tDoJCkvvxPMtyNU2Wv7dgsD6Ms8eULN2XL823Ue6TvqZQv8WfBGpqL1uyHLxcPhMymwrvY1YCPKn1A1VpWyLoBDAG+1Nw0DPVegLk86Mp6LoaaCc8KBoS9/ycWMEer6vKiA8lnzJFvLn0vt5A5Ym+yinHQY8Vmq97gW3Z9div9Z1oRrpKabOGkroF/gQUZLS1uCIpQ32WkW0BvG3XA3MZlFWDHddbFxlSjd0JAaQKiU3dQ4+PIh8IY2bTSrts3VO+pWoPAa/F4V3tvTuRFBcxqzruPd1lX5EyL0DsUxMJ2qVay9qCc6fqJvm8u9qymB+/zitPzpx17cG3qDv14xKEuDvACI+jrXK1mYUgW+5BuO8/bQRR0oIjQbO6bnmQND2FDjtOcMk/a61qy8pPkRvU2SS1D3zaXvif1OjNzbQF/zsDTzarO3QWCfYT81FJIiBVTsaApu8l2hfB99PEeyA2nRaw2Zud1pjGRemRTS8XXJDy+mgXmjsUm6SAF9n9xBh7quZhkxlFt+Y4T0Utc4+Ovqax+Q85EvP49CZGdPkTVqodG4RykOw0xXpebCanaR6E+BtSS20lH7W7oRZ4t0RnkqlpivYRwHZpKqPIEngFareuyP9nEES6t+xQ7Ps/Ijoi2Z28GWwbgVYQi1KbLtenrkgT+CVaCdkfjkWLqCer5lfnKnBHgmhaz2Od4TL0DY7LTIWnp6+VZ3HYdthkFBvPiRKZuHZvQs6Usf1pvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(66476007)(66446008)(64756008)(186003)(71200400001)(36756003)(6512007)(2616005)(83380400001)(91956017)(2906002)(4744005)(6506007)(53546011)(76116006)(31696002)(66946007)(110136005)(8936002)(66556008)(316002)(5660300002)(4326008)(6486002)(38070700005)(38100700002)(508600001)(122000001)(54906003)(86362001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXFXWkF0ME9zNjc0WHAwdjBVaDZRWHZURkpOallCdjYvdmhTdkZyUmpDZDNZ?=
 =?utf-8?B?ZG8rTjBraFIxeUt1KzV5Y2tDc25XTGd1aDBPNjB6eklUR1pjanJHNXhMRms1?=
 =?utf-8?B?WnVnM3lyamtGa2cxNnRhendYeFJxNWU5VnhiS1RBelNWbzBic0w3dm5IR1Nn?=
 =?utf-8?B?L1pPaUZBdDJiNVlFZzUwRDhYL1Q4LzJzVTJGVkpRb0VMYVR3OEdhRDdFUzhM?=
 =?utf-8?B?WXlDL1pKdFZESGl2bW5DRUlUb0VKSFhFcGlnZy8vK2tZN0hHMzZkRU04M1hP?=
 =?utf-8?B?YmhJblNBZXJzcUR0NVNjdDd0Tk5iRmRpSEFPc1A0ek1JTEZpM0hpQThORm85?=
 =?utf-8?B?dmpNUDhpTk1tQktpKzRpSHBYV0R0QU5sVjV2YTlsVHF3V0Q2aFBjWnVIQUJO?=
 =?utf-8?B?VDVISzJxYVgwWm9jbmJ6RUlSOUdjOHZ0Q09Yd3ZpN1hLN3M2TVdPL21jcXJ4?=
 =?utf-8?B?TFNCek1QSWI5aWlMVDdwbUE0MDExTjBacStOWjVSNUFINW95bklBV1lMZjVM?=
 =?utf-8?B?TFo1dm5TZUVzRkNPTVFUdWtNcEx3azFLKzRkWlBkT0VDeTRYSUxjMHc4Tmhw?=
 =?utf-8?B?Y0t0VGdMVklhQW10YU9IVkNHRlA4Wmk3enVFZFNmcnhmRjZ1Nkp0c0tnSHls?=
 =?utf-8?B?ZVU3bXIyc1FkN1Z5dUV0WVl5ckUvMjJSb2hNOE5Eby96VkpKamxYRU1tSS9V?=
 =?utf-8?B?V1pLT3pPd3g0b3dJSnU2K2pDc01mS2VOQjNKQlFKbjJRcTZxeFpQaTAxZ2k1?=
 =?utf-8?B?QUIxRWJnVERBSE1MTnZWQTA0WkZEK2NvSFQ5aEUzMGZETWh4aXduK0lORWhS?=
 =?utf-8?B?SHBrZXVhRmpUYklvcmxJLzY2bjFLUSt0TWFCblltbVdXWjh4dE0zY0RYYVBN?=
 =?utf-8?B?c011NmlScnVoWkhFQytLQVdYVWlBUmhHV0V2bCtzK0xjMzJJc3IwdWdFRlpC?=
 =?utf-8?B?aUhvTG1TVDFMMUZBWU9JMnQ5YXJJSStSRkZ5WGhHTmxQMXkrL2lhMVlmRFk1?=
 =?utf-8?B?dkY4Zkx0bkRiQUJNa2hUY2JPbVpnQnpvbnM5T281bDFLQ2VkMHkxaXY4blp0?=
 =?utf-8?B?RWMxSmxRcWRrR3RlZ29sYlc3MnRDU2lRaHZKTHoxcGtEM0dxNXFHb3RacFVO?=
 =?utf-8?B?UUo4RnBpc1RUWHkvb0k0a3h2OExGdzBaQ3VTSW1pRWdQVklWVGFqcVJMb0Ux?=
 =?utf-8?B?V1pzVHlFTTI1UDlmTXlWZm9UdnJyaFlCTHBvQXJ5bDdFUGxGUWNoUFBjMEJW?=
 =?utf-8?B?NW4zbWZJV05xaTVsbUdpbnNPSHovZmpkWElpZ2xGUlEvSFBXNTJHdWU3SC9F?=
 =?utf-8?B?QmJwMmRRRlZQeEhhTHJpTlNKZWoxNHZ1M1Y0N2FCdjhkQ090YkJQZmdScjRm?=
 =?utf-8?B?YmdOSU1CdkRSTnZSV0pDeWRxUkRHbkdSSU5FanVWS3MrSmhTWkJGNHZSNVJr?=
 =?utf-8?B?UUt5S3IrL2lpWnh2KzVua1RzUDZMK29wSmdyc0hSMWk2YUN2NHpOa3REQ2hX?=
 =?utf-8?B?aHhGWGFRbmFCakUxc3hRUzlqcmlYa1BxUlJZOTkvYmZWRnRmZExvc2J0aXU2?=
 =?utf-8?B?d1JZaTNxU3dwUHcxRDZhVkRWQlZuTkROdHpPTG1haXRweStMNmlsTFdqdnVv?=
 =?utf-8?B?YTZpUVI4V1ZmWDF0N3h0dThLY01DTDl1YnJoVC8xSlg1UDZGVGlZYmlBODlV?=
 =?utf-8?B?MTZRRkRHWnlqL0xINm9ZOFhTZkQrbEs2ZjFHZ05tS3hKUlZIMWtXMzNTTWpL?=
 =?utf-8?B?QnJZb1ZnL3ltUFpYZ2xBdWM0cU5SNWlTSStEM25ZMDBYMFFsdlY0RW1FYi80?=
 =?utf-8?B?UlBxa1o3TDFqUmNJbVllUEVNVnVhTEpQR0RiRnRvU1VLVHZwK1F6TG1uVlVL?=
 =?utf-8?B?UFFyd2hNSUpyVnRwYnlQaTEzWEV3bXFzMi8rMEFGREpJSXhRRUFPYnQ1UXUv?=
 =?utf-8?B?TGdkeDl6S1RlWkNIZTFUNlJTelVHaTN6NVRaTGl4b1RYRmhHeDdqK3krS1BY?=
 =?utf-8?B?d1RoRnRHV1lSSHBUWk1NTE5IQS84RjJoQzhpaXJKMjFPR3Z4TGdnT1dHMVJt?=
 =?utf-8?B?eEEwdDJDei9iWEtrWUhabWJUNFZ5b0xJZmluU1VIcXFXQkZ1K1lGTzF3Slh0?=
 =?utf-8?B?RlM1N1hDYmFqLzZsTTN1OXZqMHh5amJHT0J1VnZWMGJxVUdMV2kvQUpoa3Uv?=
 =?utf-8?B?VldTSExyTngxdklsbndkQnl2VlpaZFlCZ0NSVUFKbkpqVnlPeUx4Z0g1alFn?=
 =?utf-8?B?WVlEbktQMmh4bnVkdUNpTTczQkoxWmpkUU9FdlRSd2ZVR21heEtvdWlGQmFy?=
 =?utf-8?B?U2lwZTlLSzRKM0YwNTkyVVROOGlXdmFxMnN4MW9wNDlnOVZraWRtY0RXaFNj?=
 =?utf-8?Q?+Hse/D1/f9nUPCRlb2EU4vxbkXbh/E2DomconnTN/kSWE?=
x-ms-exchange-antispam-messagedata-1: 5KeI5XHmQ+8CwA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA589C9D4CB034439F7041FE559851BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe47802-b606-44f3-a40d-08da34a7a348
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 06:13:02.9507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: in+IaS6opQLVWfarJBv8PrKx1h9KUlMVDhmr2uLkWUV6677XC9o2KMzpGcJxRAEBETumXd4XR/BPQYZngZPiRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2492
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMi8yMDIyIDc6MzUgUE0sIFl1IEt1YWkgd3JvdGU6DQo+IElmIGJmcV9zY2hlZHVsZV9k
aXNwYXRjaCgpIGlzIGNhbGxlZCBmcm9tIGJmcV9pZGxlX3NsaWNlX3RpbWVyX2JvZHkoKSwNCj4g
dGhlbiAnYmZxZC0+cXVldWVkJyBpcyByZWFkIHdpdGhvdXQgaG9sZGluZyAnYmZxZC0+bG9jaycu
IFRoaXMgaXMNCj4gd3Jvbmcgc2luY2UgaXQgY2FuIGJlIHdyb3RlIGNvbmN1cnJlbnRseS4NCj4g
DQo+IEZpeCB0aGUgcHJvYmxlbSBieSBob2xkaW5nICdiZnFkLT5sb2NrJyBpbiBzdWNoIGNhc2Uu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdSBLdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+DQo+IFJl
dmlld2VkLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
