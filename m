Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B8E4B6CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbiBONBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:01:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiBONBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:01:19 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2652E8020E;
        Tue, 15 Feb 2022 05:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9ipcSoqolC4DZNy7nHePrmxmuQ1ZPOEqvIJMSgCfbWM0Y1H6wgtCwG6OWARu/isjQDsrsBizHmK6B8a3YwyNaEOMpPozLShsSot4HpL7JfvJzMb0IrK1tEImDQhJmJ+zNfhKRTVystpA6yOXzZdzlgRrao/x3bCe6G1EOKFPm+Df66LRI24NBaJJsmWSMOvOyxPvLg+3wvRaH7CIna2mDTgyYMVBw3w5chXK2SwEDTVC6utphQbtHW9ZjlBUojOZfFcsEdUPBIHII9/jHSVXunHZt2uJ67BOdr61XVkglYY8h2KLvByG4khGvPRqVmMoOPf+qZ3XlrOb8ySRCJM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W56PhEffbKIn/VvbaiPNymS6wpxskR5gR5//KoLtuX0=;
 b=np78KSHd8x6YHL2JGnNTPRWCZMpFDa/g0gvIePmFMTZ9KBMkNm9lQLZE1S3tULnu+gpSM7dfGmo54jRiiauc24qEyjBrrSYQRlUBPXysn+WwCSipflP27Ca1dSIuIfRmDmfOX66BepiaG97st7Z7c8cTClNPclk3Mpm2CWHAltQ7EWpG/yNUKZrqO93+/fpQcPQbl/Byvr0g9qodhLT5SRjy55kRm5hz9195Z1K2AtMnv8dDdvNIm1Q6ySao6H0MNa2+udUmJCXKkrzVBwZ7AYcHq+6AuvKFgn03OK99v1XprSufyXrqK/rj90K8TqjWMEKZ8VLSnSAz6l9P38g6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W56PhEffbKIn/VvbaiPNymS6wpxskR5gR5//KoLtuX0=;
 b=EbkvXxQoyhEmZ2no5Kraw0nHYKVL0PPJJb5mQs+aDBygGMJfARoc1GLY0y4hFRlH7YzywLmY/SL7mr5G14Jnej2kNw8E5R99uxgqjwEM8tGyx0abVTGCfckx+iLD7Yiydpv6noAp2mJDbVKpvFiFEOiWN9go4uRYOVD4Tz2MPyCTc6YVPmRbFvKE4dik4xUWh1J5Jpxb0AVYy2XGCJSW0m//8qI/lSDpHYv4oiX18X0by4Q4M5lXWO3td+cl0niDMs5zuF5Gh2wRK0avZMLtk3niQXXR1Z5m/IiUyRL3StRu/3CxceP5F1+++Ep3gss4/3ZHu2XNyIWWjqbL2+n0bQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 13:01:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 13:01:06 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC V2 0/6] blk: make blk-rq-qos policies pluggable and modular
Thread-Topic: [RFC V2 0/6] blk: make blk-rq-qos policies pluggable and modular
Thread-Index: AQHYImkO+BBQM1c3ykqSN6DbIjyAAKyUk10A
Date:   Tue, 15 Feb 2022 13:01:06 +0000
Message-ID: <44f86e8d-45f4-f40e-bc8b-00aa4f488f3a@nvidia.com>
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
In-Reply-To: <20220215123705.58968-1-jianchao.wan9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe680d98-b4f3-4100-4c55-08d9f0833acc
x-ms-traffictypediagnostic: DM4PR12MB5795:EE_
x-microsoft-antispam-prvs: <DM4PR12MB579586B1781739E80BB31057A3349@DM4PR12MB5795.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3wIHiVEbD1Ujn0m7WC7+s+WIKy2OwhTz0NVEF5oJTGcu0yXHjYj8ZZXYgjA0iF+GwHxpEdlr39/UN2mrVCkhw+QNzR7RyBCrLjUmhWsNr9/PPRS7G1RN1Zh7YkoZiMPUBIVLKnjMGTZpDygo2BQ5iZ12veLF9cvBfIgVAWHiB6P0VJK/8FPbNJgOd2POQ/PtUOt/GhOGorn8j/FrIAwQeOsi1Kl9oWVc+23BAyOW/08BabHginD4Kagp2Fweqi0Vi1g4DLHFW1I23WfLBbE85SVtjhfnu5wl8koJwGsX+uO38tvkNlPEJq5UehPyhOeQxDs9mFLu+jsAnqsI5OqQg2L7Htttzh7Flmy4kzC2Yr/R+u/YgrLzf3pgRXJmqIoMZjAHyuP3ZviWPDx/jyNP8SdrjwXhaFY4gEYFpAhCJUuOvw38zQfNjOefJ4LybDCgCXjNCsXm3IVVyx/t8yZdWvXrmOQrD66TExavTiZ707fjTEbGPYUsZDrOP+1MKeCDEOYTc9+yRxXH6RByMpxdx44C0TuiGMS6TNI8MPasXhGZHnY4JWzfm86iBSTRCocyYeEvBkdrHn9JrTRe9/AXnk1VC+xE+n5NqaQZuy6BOCQQ/eaJ39J+oU14CYpZkWmWuepQmbVgOkcRTIiLzmlld7rJV2xN8dwnVQszOp5EGJJsGwwVjBjTalZud9aWfgORVu1B6m97rLUdjERG55OlMPkHNJ/y8XZrcHIkP6qlLbHj4SifJH0Frh4n+Ekj4X73UQwWhQxvMEhXfuepYykhq5F8R383t0ZbXEqUI5Cg9VlcHHLPBuSEH/4Zai6yxmW3sD6oMwn0RFPSjo9sNy2TIAd4wGLQFM6+GaADL0YrKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(83380400001)(54906003)(66556008)(76116006)(66946007)(91956017)(64756008)(66476007)(66446008)(8676002)(53546011)(4326008)(31696002)(71200400001)(6512007)(6506007)(38070700005)(86362001)(6486002)(508600001)(31686004)(2616005)(122000001)(4744005)(36756003)(2906002)(38100700002)(186003)(966005)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkQ3b28yaXRXNUU2djdxcURFNTZ3MC9HdnQ1UXJhL3hRL2NMRWI0b2FMR1NU?=
 =?utf-8?B?bVBuTis5Zlo1WmhaQ2luMmFOZE13MFQwbkRWTlhab0J5U1U5MFVGRFhtcnBo?=
 =?utf-8?B?QUcrdXhtcldQQlgxYkhWOTFLaDdsRTZ4bFR3RnhhYlV3OGs4bFBhK01QdHJw?=
 =?utf-8?B?aFE5eWZTZ29WTXBmMW5VRmU0eWpVUXhYTDJRbFg3TzRtVzU4NHhLUFFMclJU?=
 =?utf-8?B?bmxsakUwcno2elJlQkdjTzNIVDV1ZFl0MXV6ZFFsdG1pZ2RUSlg1T0VqdG9C?=
 =?utf-8?B?aFFjM0FoN0dwNS9tN2lyWWVQaVhEVmFjLzZPY0ZTeFlxSWVHRUZReHNYNU1K?=
 =?utf-8?B?QTB1Qm43Z0FreUhsR3ZMaUs2bzVDbVZxZ3dVb3VFQ3RKaFROeG1UNlJ3TnY2?=
 =?utf-8?B?UEhNS3dGZnBxMkFTNVRZUThFUmpJSi9KQVdDWmhRd284Nm1ONWxuR1lUelpN?=
 =?utf-8?B?V2hBYXV5cmpGeEM5WmlnL2hwajVKUnV2UjBNazNkM1BaeEVEVVJlT2Z3YkFH?=
 =?utf-8?B?Szc5T2twc1diemI4dm9UMVJxQzNWZzc2dStoSUdjWDVKUlhHYjRuSGZSL2Jy?=
 =?utf-8?B?RWRrMzAyek93cGdFOTRPUTd4c1ZZcWVLNW8zNFpiSmdxWjNQOUhSR0NnWUE0?=
 =?utf-8?B?TmZlREFXbUxUdXlBd3NBdUxucFVacDJLZkNDeXo3L2R3RGV4ZklPcmh4NzhK?=
 =?utf-8?B?M2N1elRRTCtMem5VekVCelFGOXR6WE9jNmNobDhISEw2NFJraUNSN3VDeUVB?=
 =?utf-8?B?Z0dVbDR1cnVubm9IQzQxNS9jeVVGczFWN0x1N1VzekQ5RGhQM1lkRllwM3Zt?=
 =?utf-8?B?aDBYdEF0UUlMV01OYVpVVXJ2R0xsMjUxd2U4UXFhSkxPUUhwQndESVZ4Qy9z?=
 =?utf-8?B?QlJQZjRCRnpUeHA1NTY3cm5Yemh2Z3RVOWd3eGc1OHJ1T1piYVkyMXR0aTJG?=
 =?utf-8?B?dlJTaGpQMzh0VzhEZVRKSlcrR2xqVmYwc25QenVmMUVhRi9ocGtCK0dPZFVO?=
 =?utf-8?B?SmpkNmxIc0NyN3FTaVN2Smo4V3dLVUNReTJrdkVLdVJwajFiR1gzdVRzMko4?=
 =?utf-8?B?TUJQSjdZdmZwL0FiamovclVIVkhmdkd4R1ByN2g5d0IrK3lkOUNjQUd2bkZP?=
 =?utf-8?B?bWZkV1FXTWR1ZHlZdHhWT3hVMkVjaXNGNHdrZzVEQ3dJZyt5RmNldTNQRjJC?=
 =?utf-8?B?QkdWenhIQlA1bGdHT2JiR1VzRWwxSERKMEpHNmlUdTljMnhVSjA4Q3JtRzEx?=
 =?utf-8?B?THBSbmJPdzlPZ1BjaDlXSkVzRUdZTVN5UWRmbHhxeVJ6SW5kNTZtUkQyMFJn?=
 =?utf-8?B?b3dQRk9WaWJTK3FTUGluUWRhSFBHbVhFOXZqREkzM3VvUzM1NlJ3aWVIYStr?=
 =?utf-8?B?blBzbmRKREFpeUpTUSswSjRGZTkveWY0UmpPN1pkZXZwblpEemoxaUVKWWMw?=
 =?utf-8?B?K1R4cUpQbnIwRUMxOVFlQWQrN1VWeElVYmJBbm5yWURJNnFpRU9RZTNYZFJY?=
 =?utf-8?B?SUtGKzRIYzdDQ2NSYXF5UmFqNE04TXYrdXZzaW5Dai9YVUNKdDFFVWNEelZB?=
 =?utf-8?B?WGdlcXl1c0s4UlZQVzdNdldLTkxOakJ1UjBud0VTY3ArTnJXMnpUQjA4cGs0?=
 =?utf-8?B?NmJyV3JaSmIxV1RMSmY0Zi9EbWsvcnJUZVFyNytNMk1zOTZZVU1TSVF2RlZ0?=
 =?utf-8?B?eUlSMnJveHBacGZSbEw1L1pHR3ZOSGQ3Q1NXS1NNcVJsNUdjK1NTN3Y1ekhR?=
 =?utf-8?B?dUl0QUc1REE1UlNhOS9YcnVrTUJuQjlWWlczaC9uNkVPYUdrMTdaN21aZkRV?=
 =?utf-8?B?VFY4Z1p2NXZrUTBRS0R4VG9iejY1OUovU1pyMTVRa3l6VzRobVJ4aWczTmlJ?=
 =?utf-8?B?K2xYZVRwcWtQRHkydVNOS0QycFV2bWZaZmx1WEIyR0dxUzdQVHkyclhqSTVv?=
 =?utf-8?B?WlZkTHgxZFNsZ1d2LzZPMkc4VlU4T3dDbWIyTnN3VTlnNVFab0dVWVY3YXBz?=
 =?utf-8?B?Rllwd0xuaVlkVUtHck5CRll0WDRTeDlQbG9Bc2xDa1o4QjFrRlhTMWthWnJ3?=
 =?utf-8?B?ekVxT0Q3aWwxTENHRGdtRHZxNVpLZ1hndUlYcmR6VFZPWDVOeXNhVytxTFdF?=
 =?utf-8?B?ZDkzZXpWQnROL05FMVlpbEZaMWZDWGo5YXBMYlIwNTgxYzFxMHFKbzNiWXBV?=
 =?utf-8?B?TEJHRkRyVjZtWlN5cDhtejh5UFJkVklqV3JGd3Y4ZGFZNWRqcGhtc0VMdFh0?=
 =?utf-8?B?eXpvSDVwalVqUXZYRVpWTTR4SWZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90E9FBD72FDE994EADF3AA834A3DA56B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe680d98-b4f3-4100-4c55-08d9f0833acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 13:01:06.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XI868UNzOlFnRcG3wp6YFJFc0Hrcn9TMgBH0RLtfPq9WLAhjbm+UOMa+FuUuBMtjfJZcU9J46HCIi1MS0n3w+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2FuZyBKaWFuY2hhbyAoS3VhaXNob3UpLA0KDQpPbiAyLzE1LzIyIDA0OjM2LCBXYW5nIEppYW5j
aGFvIChLdWFpc2hvdSkgd3JvdGU6DQo+IEhpIEplbnMNCj4gDQo+IGJsay1ycS1xb3MgaXMgYSBz
dGFuZGFsb25lIGZyYW1ld29yayBvdXQgb2YgaW8tc2NoZWQgYW5kIGNhbiBiZSB1c2VkIHRvDQo+
IGNvbnRyb2wgb3Igb2JzZXJ2ZSB0aGUgSU8gcHJvZ3Jlc3MgaW4gYmxvY2stbGF5ZXIgd2l0aCBo
b29rcy4gYmxrLXJxLXFvcw0KPiBpcyBhIGdyZWF0IGRlc2lnbiBidXQgcmlnaHQgbm93LCBpdCBp
cyB0b3RhbGx5IGZpeGVkIGFuZCBidWlsdC1pbiBhbmQgc2h1dA0KPiBvdXQgcGVvcGxlcyB3aG8g
d2FudCB0byB1c2UgaXQgd2l0aCBleHRlcm5hbCBtb2R1bGUuDQo+IA0KPiBUaGlzIHBhdGNoc2V0
IGF0dGVtcHRzIHRvIG1ha2UgYmxrLXJxLXFvcyBmcmFtZXdvcmsgcGx1Z2dhYmxlIGFuZCBtb2R1
bGFyLg0KPiBUaGVuIHdlIGNhbiB1cGRhdGUgdGhlIGJsay1ycS1xb3MgcG9saWN5IG1vZHVsZSB3
L28gc3RvcHBpbmcgdGhlIElPIHdvcmtsb2FkLg0KPiBBbmQgaXQgaXMgbW9yZSBjb252ZW5pZW50
IHRvIGludHJvZHVjZSBuZXcgcG9saWN5IG9uIG9sZCBtYWNoaW5lcyB3L28gdWRncmFkZQ0KPiBr
ZXJuZWwuIEFuZCB3ZSBjYW4gY2xvc2UgYWxsIG9mIHRoZSBibGstcnEtcW9zIHBvbGljeSBpZiB3
ZSBuZWVkbid0IGFueSBvZg0KPiB0aGVtLiBBdCB0aGUgbW9tZW50LCB0aGUgcmVxdWVzdF9xdWV1
ZS5ycW9zIGxpc3QgaXMgZW1wdHksIHdlIG5lZWRuJ3QgdG8NCj4gd2FzdGUgY3B1IGN5bGVzIG9u
IHRoZW0uDQo+IA0KPg0KDQpQbGVhc2Ugd3JpdGUgdGVzdHMgaW4gYmxrdGVzdHMgWzFdIHRvIGNv
dmVyIHRoZSBjb2RlIHRoYXQgd2UgYXJlDQpjaGFuZ2luZyBpbiB0aGlzIGNvbW1pdC4NCg0KLWNr
DQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vb3NhbmRvdi9ibGt0ZXN0cw0KDQoNCg==
