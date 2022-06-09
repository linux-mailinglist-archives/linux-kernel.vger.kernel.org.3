Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857FD544084
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbiFIAWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFIAWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:22:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256844704B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 17:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOUnLszLGhRPchCIHktp0LAj6ku5IqfGNDW4Cu8/tk0l1WnpQ/bHTXMNe1+bjvrjum22OopeuvhkFcFTdJqZFmL2Dm0mxyzAKiwBCFsbvAT8wxwVB4OyuXU7WDp+1ZB/w/H4BBtRTwQdObuug0ACVzjM3TmSNdGQmJ/3CoOStQTSWqYpKXYSEfrq3NGIROSr00DM8U8ETeVgn0QPYVyqF4OP79deN+A7s4Nir8+wB+43uCUFovvtC7aM0RpJsq9bwv5ou9qZQt0RK+ibIWTmbheZD/LfpXndqL9QBqjK1dvEhhfrkSJhuS7h2jFrD/BjIiptL/sMAWK/fR1VqRx8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGgxIE5MN2DxuI/Er03xABq1m8zEfnQK09dPLOnqvUU=;
 b=KAttPhT/HFIQteUdEAs5SO3qQbx2XXQ6AuapPCa4V241dDTmWy2HIaRqzMW4E0CwnBObO5OMuQF5ttqeaPd4jvgS4QNI6bfGd5xQ/rpYY1BF8WgDFdE84PAUMgzPPBvze3/m8mU4WT7qvahvPHphSpDxXjBSn4lmMA2CkzpUrCRKeevBp6OZZapnH2DGxn8vfmkDyQrf/RvnbnB8g+uH0yD0iZucysLiepE1Dfynew0yi6dIwPszB1Lzog0ASp8NmdiaxN1IgWg8Tikpy7JQlmfC+jYq4xhkpcgJJbpI4427P3pWmNkKcQBJ4E2RThJ79jKQHBLaUk6BRRd16dR7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGgxIE5MN2DxuI/Er03xABq1m8zEfnQK09dPLOnqvUU=;
 b=ihsNfDv9n84qoadyiPTX9Sm1SUMYhaexL3NRJ8a1EJ/cR/W0agTjlb+ulpzl7JtLLIcMt08CNvw75ybiipLA2t+0I26w4xSTAoOLuv+IbWFdnuPYVvvKsgzL1QTfu9mlFVvt5VFSHi2ExE6Yt6pp8DUwpQf23KpEmC5M0WKnxwiEC5P+WkNPD6XaSGuW+uZkX+l/WrFLPoHaujxNchZeo3WyCyjWxdMpnGwH4gKWaqm6y6DCWTj+3+Z+o7g90K52tDYIA8I3YPhT+DGxNmWCQqt5iGv1xc6JhadIOmIA77Gob68cyiZam97b8PGDSpae/xDz3vxPlypdC6ljbXIRww==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 00:22:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 00:22:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "caroline.subramoney@microsoft.com" 
        <caroline.subramoney@microsoft.com>,
        "riwurd@microsoft.com" <riwurd@microsoft.com>,
        "nathan.obr@microsoft.com" <nathan.obr@microsoft.com>
Subject: Re: [PATCH v4 1/1] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Topic: [PATCH v4 1/1] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Index: AQHYe2kcP72pVk+OVk+EwBZ9BRmAeq1GN0KA
Date:   Thu, 9 Jun 2022 00:22:45 +0000
Message-ID: <0e57d8c2-9a30-f15e-dc38-da397ac81c34@nvidia.com>
References: <1654714341-41189-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1654714341-41189-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ef335a3-bf9f-41f2-02c1-08da49ae2d09
x-ms-traffictypediagnostic: DM6PR12MB3372:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3372335F3238AC20369BCE14A3A79@DM6PR12MB3372.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBrFTIcqTmk0HO8K5aSBGkjHUqF8ymiO3z/ECMgnQQiM3wRLWjB4YLK2Hw2m/ofEry//vVootpBesa0yzIlr0Lags8mcRuuPkMz+G9EwECGLqpAvekn+GFYxJihmC5R+5VQwhwUDvhgFBaRXWRJTl9TKvdmaSlrE99I4guQJzbw8obwZYutOQgdsRhB/Nv4eysom5Po45/h4nGAjieso0AibbV/b4xJiMF8pMk7PKnX3aMGqPD4qy/Xv31C5CCFlGfZg9ZFpMCmT6DO/M0yE8a7BGmknUFg9UqFhYdA88wExGLdzA2M7ziKCTmaYo07qt81a5Rf7Jn2J7R6drfpb/0z+nVOBCrk3y8lUx3Xh9v1seytgA9o1RT71+mrHrwsPBjUud//R6hPZPbFIH7PqArAdYnsxGGrm2ypXWujO8ISGAJ6OfAG2AQ6m5ZyoQNOpUf8nzW8ZJ+l9Jb0zFtE48nuUX70aseRFtvBRCGWajQGiyeYQdrKSTrGkezNrN8tSuVNQh9FOrlhKoEYvZ78qo4IgX4JvuuQXSRep9TMrjGtjsTC+K3nQ3PHmZW4qtSNU+5aUPnMNrBqQG8mcN8EFhhjqhX9SDGBIg8ZKuYeTg887yOLVScBPWSQ6uCIpBDKu+m2+Vgy3BbElr5KIvABP6A0zfPVjeOCubpBnUWOzImFlelWtiG+KV7ongt8BKax52VlCbdY+/rWczkvjG4W2xLtZchHXhYMiQbkWhCqscPheot4dS2NaM0DLz93D0dTbn6oGujLQpUHau0c22EYkyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(76116006)(38070700005)(91956017)(316002)(31696002)(122000001)(6486002)(86362001)(6512007)(7416002)(31686004)(71200400001)(4744005)(508600001)(36756003)(186003)(5660300002)(8936002)(66476007)(8676002)(2906002)(66556008)(66446008)(38100700002)(6506007)(64756008)(110136005)(4326008)(54906003)(66946007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkhnRDR2VlhUVmZBVUtZOStTM29vekVHUmo4UDRBNlhOZktHZ0hUK1lWUHpu?=
 =?utf-8?B?Y1VUdGtudW1OVkZyN1FSVC9GVS9WOHVSY2VhRHNLeGxyZSt2bVlVT2ZRUTdq?=
 =?utf-8?B?YmdwMHVzb0hlZ01mcVpLK21SYmt0cTVVS25zM0VIcHppUlhrMHkwRWdNemx1?=
 =?utf-8?B?SU04REZndGNTRVVxMTVmOHNhKy90YmRVSGN1UTgvbGFZTFowZGxqUCtKRjhZ?=
 =?utf-8?B?N3BkT0tYR08xdFNNSW9XK0FHVWs2RDNTb0xCSVRtMGJQT1N4Z2xsQmQrM3Ji?=
 =?utf-8?B?QmI4WDVLSDdTL2hxcy9aMmJYaUg5dVdOS2RHWGtYNHdkenplYUowd29Tdzls?=
 =?utf-8?B?YzNXeSszL1F5TUs4ZHlmTlJLdGZ4S3M0czFNUm8vTDFWSGcwZWVEQ21NbnJ4?=
 =?utf-8?B?VFc2UEwzSE00bnFvSkZBT2xvcGNkSFJub2pSdVk4aGxOZ3htdXhTckZrbzBU?=
 =?utf-8?B?dlJqZTlnOWhUVFY1cmd4NU9PYUZ5cWh4a240bW8wR0hSMHR5UExwbmdzWEVE?=
 =?utf-8?B?ZnlEc0s1eWZTYjkxWHo1MkMwZE44dTViUWNpWWxOcklTZngyUmJWcUxvQU5v?=
 =?utf-8?B?U3NhSjlrMmhSNDIydi9LeDhLS0tiTWZZaWVOYUswenhmWVNKdXVGdUx1TWxl?=
 =?utf-8?B?aGJENVRaN2VyN3NvSGZ3TTBpVWo3MS9RQ0dnN3M2cTd0ZFUrRWdXWkp1eVZl?=
 =?utf-8?B?cjlYdHJiM1lyWkNEQ3RxcWNxNmlnVFV3TWU4VG0wZVZXMXlVMEFrTmtoQXg5?=
 =?utf-8?B?K3JTVDB5M0lqZkY3Q3g1empPVGZ0OGc1ZE4wL0xsanVVZlBSZno5c1R3Tncy?=
 =?utf-8?B?VjhxNW95OXFTNnJiMkF1R09SQnNnck9NekY0dThQSHdpZTR5cVREb055NURz?=
 =?utf-8?B?TjBGOGpjajhFa0lTRkN0azUrZ2diZ3plNkd3bUlVTHlkY2dwVit0Mlg5TCtY?=
 =?utf-8?B?S1N3aUs1a2U2OGRaRzhJdXk1RFkzaVRxSlJqYzFSWjR4YTEwMW5YRXdQdUtI?=
 =?utf-8?B?Vmc1ZEl1ZnlhZjRTUGhiYUM4Sm83LzZaeVhXZ3NLOEpldVMwOWQrRlBhWDRL?=
 =?utf-8?B?dG12R005WnAxanVpREhURDBkU2FZOXdJNDlvcUdlU25UQnMvY20yaGdEaGNO?=
 =?utf-8?B?OG5sWjJQdUUzZnB5Zm1KOGpqeE5TT3hhNXN0Wk1TWE5XZlVBTFowTVQvVzVo?=
 =?utf-8?B?UlJZSFVaQkZWV0hDSnAvMkhuYjJ5cytDWHdKeHFKNzNGUE43cW5MUWp6Ti9O?=
 =?utf-8?B?d1IwYlFydG1QRzBBQmg5N1F6WnUzVFAxYlBCQ0Eya1pFcDk4ZitFM2VDNGtv?=
 =?utf-8?B?S1VaN0FnWVc2OGkwd2tCTlAzdm1hWnlGdm5GWlhsQUxnMk9oRlEzVVdVdm9h?=
 =?utf-8?B?dzNUMXpKaEExMmpYYzhlZ0FMSEpWd3dWbUQ2MUp2b2NzUVNTQ1BsczBPRlEy?=
 =?utf-8?B?cHROeUhUMVE3RzZpczRmQ1NTUkxLZzc2aGpNTWZmQ0hRL1g4UlRFcDgrU1Bl?=
 =?utf-8?B?RjZLZnhJdFVIbnVlemxVcEhLUGlmeHFiSjRaZ1NUbEtOUDQwSlJoR2hFM28v?=
 =?utf-8?B?QUtINTgwNmQzLzRUR3d5YW84RU9iVG5PN2JOTVFsbjhmRnQ5cEt5QkNvVDgz?=
 =?utf-8?B?cDV3QjZ5c3NLRGJ5K1dzNU5tTUhmVmZIYmNVVzh3T1UzQnRucUlJeVNvNzZa?=
 =?utf-8?B?Ynh4aWJQNFYxNkNtT3dvZzRzaXFGcDhpTmM1NlFOUUo0NnRZc2FWM0lOcDc3?=
 =?utf-8?B?K0hlbkFSQlU2RWorMHVaVTNDcnlCZVgwU2wxNDQ3Zk1VcHd3eW9UdnQxYkRO?=
 =?utf-8?B?MlZzNVdqUjZvNzB0YmlWSnJlbUJRL0c2bGdCSEJjelcyOXZOVnZod1RnZVp2?=
 =?utf-8?B?Vm0yQjdsRWZTcVNUQkFBRXZwU3YzbExCU3VQcG9mT3ZFTnVaQzdUK2s2UjBz?=
 =?utf-8?B?SzQyQUFBYmFJQUVvWnl0YWxtLzE4NVBTNytUMTZHYW9BbExzT2p0QjZUU1M3?=
 =?utf-8?B?Zkd4ZXhtL2haVEpXNDdxNkhjenNqaE9LSTlKd25hWGxoMUlJSmg0TXF3TEFR?=
 =?utf-8?B?cUtBT2VFaUZqODlpcExsZDRrZ1hQVkszU1NKYVZvTUMvUEJuMlZNWlJqNDFN?=
 =?utf-8?B?NHgwY0FFaE1VYkJkMEVvak1OVTR5M2Qrd21Td0tCK1BkalJZMXZCdGgwYUFk?=
 =?utf-8?B?YzNTZFhZNXdtUFBwR0VvZFNpajZSbEJ4M3lnYjlKdVRBVE9rR2NWR2xmUEps?=
 =?utf-8?B?c1grRitld202NkMzWUVhM2lEaG1zRkxwTnNlZ0hsa3JJOGhHRmUyL0FpcHhB?=
 =?utf-8?B?UllkZm5LRDQ4TlF0bGh4VEVieG9nV0tpSGtNcWpLQmRrR1dFMlhnK3N3R2oz?=
 =?utf-8?Q?BD/cLClSDUhBJpVLrv30YGeY98ARepiHLMDu1ROjvb9+Y?=
x-ms-exchange-antispam-messagedata-1: X1DGplWBuLofLg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5912FA75A761DF489E7B64E8A2B3682D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef335a3-bf9f-41f2-02c1-08da49ae2d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 00:22:45.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qskk1cUCuzRjFJvHWc2uzNqnY2MBcJk5LHJ4uNnNXI65YRS9NHmYrPEMYK43WyfSoAun3Sg8oFXqDp0L7EUdtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi84LzIyIDExOjUyLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gSW4gdGhlIE5WTSBFeHBy
ZXNzIFJldmlzaW9uIDEuNCBzcGVjLCBGaWd1cmUgMTQ1IGRlc2NyaWJlcyBwb3NzaWJsZQ0KPiB2
YWx1ZXMgZm9yIGFuIEFFUiB3aXRoIGV2ZW50IHR5cGUgIkVycm9yIiAodmFsdWUgMDAwYikuIEZv
ciBhDQo+IFBlcnNpc3RlbnQgSW50ZXJuYWwgRXJyb3IgKHZhbHVlIDAzaCksIHRoZSBob3N0IHNo
b3VsZCBwZXJmb3JtIGENCj4gY29udHJvbGxlciByZXNldC4NCj4gDQo+IEFkZCBzdXBwb3J0IGZv
ciB0aGlzIGVycm9yIHVzaW5nIGNvZGUgdGhhdCBhbHJlYWR5IGV4aXN0cyBmb3INCj4gZG9pbmcg
YSBjb250cm9sbGVyIHJlc2V0LiBBcyBwYXJ0IG9mIHRoaXMgc3VwcG9ydCwgaW50cm9kdWNlDQo+
IHR3byB1dGlsaXR5IGZ1bmN0aW9ucyBmb3IgcGFyc2luZyB0aGUgQUVSIHR5cGUgYW5kIHN1YnR5
cGUuDQo+IA0KPiBUaGlzIG5ldyBzdXBwb3J0IHdhcyB0ZXN0ZWQgaW4gYSBsYWIgZW52aXJvbm1l
bnQgd2hlcmUgd2UgY2FuDQo+IGdlbmVyYXRlIHRoZSBwZXJzaXN0ZW50IGludGVybmFsIGVycm9y
IG9uIGRlbWFuZCwgYW5kIG9ic2VydmUNCj4gYm90aCB0aGUgTGludXggc2lkZSBhbmQgTlZNZSBj
b250cm9sbGVyIHNpZGUgdG8gc2VlIHRoYXQgdGhlDQo+IGNvbnRyb2xsZXIgcmVzZXQgaGFzIGJl
ZW4gZG9uZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBt
aWNyb3NvZnQuY29tPg0KPiAtLS0NCg0KDQpMb29rcyBnb29kLiBUaGFua3MgYSBsb3QgZm9yIHRl
c3RpbmcgdGhpcywgcGVyaGFwcyBjb25zaWRlcg0Kd3JpdGluZyB0aGUgdGVzdGNhc2UgZm9yIGl0
IGluICB0aGUgYmxrdGVzdHMgdW5kZXIgbnZtZQ0KY2F0ZWdvcnksIHRoYXQgd2F5IGl0IHdpbGwg
Z2V0IHRlc3RlZCBieSBldmVyeW9uZSBlbHNlLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
