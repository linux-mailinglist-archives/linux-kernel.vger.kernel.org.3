Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99F58F210
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiHJSA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiHJSAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:00:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D0F26120
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:00:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaUvLsxzsv7ofyKbhUyPA94lzFXekcRO0zuqEmFZXkhaJRDbTUPbQFXA0FoLsNT47PEgj1UgD0ksQBtJK3VKkE3iE8sZMnf7nAErb0xng6LUVbQRskzVv6a9GlKGfuTazIaeBhBCj2fzYNeI9RM3dSgt2D8NkefcYlOPO133FigaR10sikaHEJYEgTiei7IBYblpIx4HquSsPsZ7ycpjMC+VAMTfjO9kz80l820x0Tccvz4niFBh8lcpr+z28thk+Bhnl/vbpq7dBmPxIyVi6jW0WTSKYoLTCBiSjOroF2ysvV3cq+UtF7iufmdlITu8Mkl8Diz+Bk1R8vfxLkMHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BTdxPgPg+Nhgg+TzYXHnurXA1h+LWOHt5cYHzQnOIA=;
 b=drnG3F5irqj4SJRLg5U0/gUg6oCb/RVi+kR2OTiXIols3QkX462Y/Tg5vFQs51D6h9lkZCSBm6xVgWKlB5D1SSKNrD6GyQzJ3rmCN/lnRFlh9gggBewzI7/AztSk67wvtShYgpRY2iZdHH9TTah3Fif8nME9vk5Ga6yHL/dANh5gBzaGZyuZniweNSScDTn46qzfSZXUoBGym29dM8Oe71dVcUiCZg5JKp2Lml6LxoQfgKIjjN5Mv9SwdTXK7mqt5S7cEneVzKb8NW+Ydg6jL/qIenLBTfZVfihxmAvMc3rADnAqSw5ftiR/C9vGlYjFzv7W9wIZrU7sQboGwfM7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BTdxPgPg+Nhgg+TzYXHnurXA1h+LWOHt5cYHzQnOIA=;
 b=1sYEiYciO0RP1uGPqjySLK4WCRCdHggiQJTPEuI4WpkDeTMhwmhsmA8g4kKUFSwSmMov4D56P0fOcqk+GTcWGhD0Ft0m9TABKKkApiQ7mgdZ5rShwdMyTS8u/eIGOHLy//fp1WcUKbfKNxnNMhSNG7qboKvtiefcuG3WF2lCV1o=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by MN2PR05MB6462.namprd05.prod.outlook.com (2603:10b6:208:da::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.9; Wed, 10 Aug
 2022 18:00:48 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a%5]) with mapi id 15.20.5438.010; Wed, 10 Aug 2022
 18:00:47 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
CC:     Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: general protection fault in vmci_host_poll
Thread-Topic: general protection fault in vmci_host_poll
Thread-Index: AQHYlRUw3jUKUNdyf06vNUbt7DhwMa2onBGA
Date:   Wed, 10 Aug 2022 18:00:47 +0000
Message-ID: <465D4025-6451-4810-B816-E93D255BE9A8@vmware.com>
References: <YswCW3yBdaI7CkOn@archdragon>
In-Reply-To: <YswCW3yBdaI7CkOn@archdragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9841ef3-8df0-41a2-55b2-08da7afa411f
x-ms-traffictypediagnostic: MN2PR05MB6462:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zjXqtecDIzzcQHz6+7TvjiapTLi62mp0zaaSl0yofiaaZm6uszOmibtsqq426qbJdX4ZI/wYcWDH/j9Rk77LuT0wgnQl9ElpCl5PHBrbyE0qXHqYrpHOMrwt2iEP8AiKC5D7wVKW9tYv8vLZDsMGAGzTESjoGKfMf8nbbNReCVn8XxbhBFv1edBZQ6wYb0e1Fe56oXvIFZ+oPTbNPB8JinhDErjV7gcN+fBNY83osW1Ikufha6YIO+t89jNzwzQUvAnn98ZQGI6rO1QAKOF3jr3okC5srx3sVN0e9pntscKMyAGtQGQdL43fdWtOkGhDy+gDH6rKQWOJD+YAWyzJJaUjgsv0k7piIHSTPtXSc+6oWghsDoCvYH+GdPpnrIgGSClREigKUvP0/WPhLRS+/ftQKOEVc+WXeZ9Z+sWdkLOL31SxI3baP9z2MHDGwdrcqXR2ofTn+naKScd4uCihgww14BRagVlLYEIVaNTSbCDtY2qfrKxdkwWpCf9EhzGGaOYigxVBQnhKbI/RkuvBqxG2919dyuK1i58TkO3nTi0FXI6mmHVRb7+BuRYz7bLnDLtxwDhDpCt2AjLoP2CQbBwMeVu8JlNGgb+nDtdfnxDrcTTCzkcddmjlESiLP0jmCpb4ih1ZISSJgd0LXh+JLBIxMdb9nXoGGA/g55Y+dhdv6T/rzqRgQYKlyeX+bWa9fvScdDqFD7uaIzBNShrZtW4MA08GDe1FHFjskduD/PKidR5NtcMGRg2wL2jX2hOcp9f6TMd1FIDZuXd2WkKA62hDSdkJ4cXh5ayx884Lic0pHR5m83bVfzEmMckgFG0MBqRDvJfhv0AZ5r1CvqWBog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(66476007)(36756003)(66946007)(5660300002)(66446008)(6916009)(76116006)(8676002)(316002)(4326008)(54906003)(66556008)(478600001)(86362001)(8936002)(64756008)(2906002)(122000001)(83380400001)(53546011)(38100700002)(38070700005)(33656002)(41300700001)(6506007)(6512007)(45080400002)(71200400001)(2616005)(186003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejlSR3p1NG9QeloybXpXd2E3QzNpa2pYYzlQYzlCWW5wd01XeXl1bzhaY3dl?=
 =?utf-8?B?MTZWWmxPZk1TWlZtcU5ZNFRCN1hXS09zUGlySVZIT1lvc3g2K05pLzhxNEpL?=
 =?utf-8?B?WUZjdUE4N0FQdmpvVnJDelYvTzRvcjRwUEJreXJQV0F6NFhOdm41elRScldp?=
 =?utf-8?B?enM1V3ZHNkQzT0NpczJUaUcrVG5pTzVpMjEzaVlxeE5iaVE1T0pGUFhuUmhS?=
 =?utf-8?B?a2hnOHNZRDBZYy9mNzZnaDU1QjhmU1BQdmpuQ0w0RkVtekZGcjJJR1RZY1lr?=
 =?utf-8?B?VGt0STEzbW5yTCtQWXMycGY4VDNQZGliZGZFelVOWEh2TGgxQzM4Z2R2QzVR?=
 =?utf-8?B?amJ3OFNDa0FENjdFMWdWY1B3UmdyMkJFSnd4ZzcwV0owSFRlaGZLMmlQcmYw?=
 =?utf-8?B?dVFqdFdtN3Z0WWlWOFBoM1pRRFdldjdLbVU4bW1pMXhFVVUwaVJ0aHhaZmRR?=
 =?utf-8?B?NTBFNTllbEFXcnFsL09MclZaeUoxUno4S3ZkNStNbDc3MCt0Sm5OM0toZVJP?=
 =?utf-8?B?MVcrc1FXRTBCaGhVVnVYeThORmNlcVh5ODU0ZzRQeW92SkJNb0NQVWxnME5H?=
 =?utf-8?B?UTNLS0FyK2E2ODNreDhXQ1RncXV2SDB1Vlc5R3BVSHFYSERhb3A1TnhGc2pi?=
 =?utf-8?B?UGdPbVdEaExmMURIc3Q3MjJDakpXanorRjZGTUlOYk5abG9kSVphTTRGVkVS?=
 =?utf-8?B?THNMSWx4Vlk4ZEtQdnZiWUpTYmxwN0l5NUgwSW92cXhnSDNRdUdubjBUZHJM?=
 =?utf-8?B?dDVmU1lnc2l5K0FPanRpaXE2SkVJRW9oOTJtMGVmaERvOHg5alZmWW9ZNktz?=
 =?utf-8?B?ZmtaT2dMNVNMeU42RnAxSjNRb083RmhhUFd2aG1JaGlUdG9jck9UVkJobGt3?=
 =?utf-8?B?UzM4ZUtIOW8wUEVFS1JhbzVIRkVSVjJzaVBNMFI4MEIzRitqME83SVdlS3BU?=
 =?utf-8?B?ejdoL1U5ZWZLYXErZldBM0tRWm9uU1dPaWZuc3VaZXNPcTgwQjdEdjlWY1Y2?=
 =?utf-8?B?azV5ell5YVBjTmlJOUh0VzVqRGV5dFlzQXRRbnplODRRUVlxUlpLVWJBbWJG?=
 =?utf-8?B?NFFlb2RjLzg4TCtiNWxrMG9nV24wS1VUMEJHbTRFS3lSMi9RUUJZbEV5dnJZ?=
 =?utf-8?B?dmthZXRFcjViZWcxMmRNSTVtR1ZaYzVqMEVrUjNwMkRPcmJsYkVBcTYvUFpQ?=
 =?utf-8?B?QTFrZmxmdi9MS0J5S3UyS1Bka3VUZE5RS3UxdW5kVGo0TUc0TjNDWmFXQ1pJ?=
 =?utf-8?B?SjhJV2Q0RU1zemFtRzc1MTB2YjNDOVZBWldYSFhkeWkrQkJCc1NRczBLREVC?=
 =?utf-8?B?K29yRXFZc1FLTGplbDUzOGlEZ2hkMlpxYUo2cHF5VTV3cWVtNFpTZ1JaN3lI?=
 =?utf-8?B?bnJYQWovRHFHeUlSYUVjNGNKWUJXNHNhbEliVjR3R1IxbUVybU14bkd0ejRh?=
 =?utf-8?B?eGZTYnhtT1c2bXhXZ0krUUg4dVhiYjJnN1VWMDlRRnNkUnNZZ1dnVy9wZUgr?=
 =?utf-8?B?Qm1sb20xdlhua1JBT2R3SHN4RVFsM21QK05PZVNIQm10U2srWEZPM2xFdDhI?=
 =?utf-8?B?T2t0MVRIWFdmTFIwd0RPR3lSV3IrcVNaU1ExUk8xZElMZkhXNFJyZzJuanhn?=
 =?utf-8?B?Vkg0WFFoN2ZsdGFqYklWT2xJdkczNUYrNU4zMkFhU2ZkRlUxSXJUMHpidjZV?=
 =?utf-8?B?L2dvYWw0Q1RySXpnS3lkNTVCQXRUSGNhalNSUkg1NHAxSG1KVWxBSWxrS09T?=
 =?utf-8?B?TUNnRkNMWkdmUzlGQ3AydGpJYkh3Z1ZWTzFGVEVyeDVIYngwMkhtS0xMakxZ?=
 =?utf-8?B?cDFVTWFqR2Z1K2VlcThPSVVWNFhFbG9XS011U3ZRZFlra1JpOTFJWlpSeVla?=
 =?utf-8?B?SE95YlF5dUxwL01yd25KZEFpVEs1Slg0c1h1b3pQa2s5OC9FN2pxK2pucWIy?=
 =?utf-8?B?UXduZjFRTmNWYVZOUk55UWI5NlQ2WkI3Y3pISXVDalJXbUk0dEVONk9Qdjdu?=
 =?utf-8?B?U1VmejJRL2tZeFoxYVlQdi9BWGhwc2lIdk92djEzRzFLenYyWkk3ZDF4ZzBD?=
 =?utf-8?B?WVpnQ011eFRwcFhQdnkxdnZxb0Z1K21zbEVOU3FyR1FJRzJyN01KVG1Hd3pV?=
 =?utf-8?B?NWxJV2dmNzlCcEtiY1p4eU00S0hueHRReFNYSU5FSDNGdmxYZmJJZjVNMkNw?=
 =?utf-8?Q?btU5W3aScCteGH8uMCXDhUKNShmpY05lLuDu4YiaWfRk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <698A1B2EC401DB4982B76214103CA347@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9841ef3-8df0-41a2-55b2-08da7afa411f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 18:00:47.9175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ECsLvPFWFSUe/xRPYy0tKoIoxBRI6sbyINQej0DC53PCqr9SBA0ERBOWj+yOG0VuPSfaikeBEmfW9kJYR4Iiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6462
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciByZXBvcnRpbmcgdGhpcy4gIFdlIGhhdmUgZmlsZWQgYW4gaW50ZXJuYWwg
YnVnIGFuZCB3aWxsIGxvb2sgaW50byBpdC4NCg0KUmVnYXJkcywNClZpc2hudQ0KDQo+IE9uIEp1
bCAxMSwgMjAyMiwgYXQgMzo1OCBBTSwgRGFlIFIuIEplb25nIDx0aHJlZWVhcmNhdEBnbWFpbC5j
b20+IHdyb3RlOg0KPiANCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBIZWxsbywNCj4gDQo+
IFdlIG9ic2VydmVkIGEgY3Jhc2ggImdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCBpbiB2bWNpX2hv
c3RfcG9sbCINCj4gZHVyaW5nIGZ1enppbmcuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCB3ZSBoYXZl
IG5vdCBmb3VuZCBhIHJlcHJvZHVjZXIgZm9yIHRoZSBjcmFzaCB5ZXQuIFdlDQo+IHdpbGwgaW5m
b3JtIHlvdSBpZiB3ZSBoYXZlIGFueSB1cGRhdGUgb24gdGhpcyBjcmFzaC4NCj4gDQo+IERldGFp
bGVkIGNyYXNoIGluZm9ybWF0aW9uIGlzIGF0dGFjaGVkIGF0IHRoZSBlbmQgb2YgdGhpcyBlbWFp
bC4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IERhZSBSLiBKZW9uZw0KPiAtLS0tLS0NCj4g
DQo+IC0gS2VybmVsIGNvbW1pdDoNCj4gOTJmMjBmZjcyMDY2ZA0KPiANCj4gLSBDcmFzaCByZXBv
cnQ6DQo+IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmlj
YWwgYWRkcmVzcyAweGRmZmZmYzAwMDAwMDAwMGI6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBLQVNB
Tg0KPiBLQVNBTjogbnVsbC1wdHItZGVyZWYgaW4gcmFuZ2UgWzB4MDAwMDAwMDAwMDAwMDA1OC0w
eDAwMDAwMDAwMDAwMDAwNWZdDQo+IENQVTogMiBQSUQ6IDEwMzM3IENvbW06IHN5ei1leGVjdXRv
ci4wIE5vdCB0YWludGVkIDUuMTkuMC1yYzMtMzIyODgtZzBmM2IwODI5OTQ5NCAjMTUNCj4gSGFy
ZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1Mg
cmVsLTEuMTQuMC0wLWcxNTU4MjFhMTk5MGItcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNA0K
PiBSSVA6IDAwMTA6X19sb2NrX2FjcXVpcmUrMHhmMy8weDVlMDAga2VybmVsL2xvY2tpbmcvbG9j
a2RlcC5jOjQ5MjYNCj4gQ29kZTogODkgYmMgMjQgODggMDAgMDAgMDAgMGYgODUgMDIgMjcgMDAg
MDAgODMgM2QgMWIgMTYgNjYgMTAgMDAgMGYgODQgOTcgNDMgMDAgMDAgODMgM2QgZDYgZWEgZjkg
MGUgMDAgNzQgMzEgNDggODkgZjggNDggYzEgZTggMDMgPDQyPiA4MCAzYyAwMCAwMCA3NCAxNyBl
OCA4MSA2MyA4NiAwMCA0OCA4YiBiYyAyNCA4OCAwMCAwMCAwMCA0OSBiOA0KPiBSU1A6IDAwMTg6
ZmZmZmM5MDAwMzcyNzMyMCBFRkxBR1M6IDAwMDEwMDAyDQo+IFJBWDogMDAwMDAwMDAwMDAwMDAw
YiBSQlg6IDAwMDAwMDAwMDAwMDAwMDEgUkNYOiAxZmZmZjkyMDAwNmU0ZTg0DQo+IFJEWDogMDAw
MDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDU4
DQo+IFJCUDogZmZmZmM5MDAwMzcyNzZiMCBSMDg6IGRmZmZmYzAwMDAwMDAwMDAgUjA5OiAwMDAw
MDAwMDAwMDAwMDAwDQo+IFIxMDogZmZmZmZiZmZmMjM5NGQ1ZSBSMTE6IDAwMDAwMDAwMDAwMDAw
MDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IDAw
MDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwDQo+IEZTOiAgMDAwMDdmYzIxYjEx
YTcwMCgwMDAwKSBHUzpmZmZmODg4MGI5MzAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAw
MDANCj4gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0K
PiBDUjI6IDAwMDA1NWI4Y2ZhZmQ3ZDAgQ1IzOiAwMDAwMDAwMDFjNGFhMDAwIENSNDogMDAwMDAw
MDAwMDM1MDZlMA0KPiBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAw
IERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPiBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAw
MDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiBDYWxsIFRyYWNlOg0KPiA8VEFT
Sz4NCj4gbG9ja19hY3F1aXJlKzB4MWE0LzB4NGEwIGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo1
NjcyDQo+IF9fcmF3X3NwaW5fbG9jayBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrX2FwaV9zbXAuaDox
MzMgW2lubGluZV0NCj4gX3Jhd19zcGluX2xvY2srMHgyYS8weDQwIGtlcm5lbC9sb2NraW5nL3Nw
aW5sb2NrLmM6MTU0DQo+IHNwaW5fbG9jayBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6MzQ5IFtp
bmxpbmVdDQo+IHZtY2lfaG9zdF9wb2xsKzB4MTZiLzB4MmIwIGRyaXZlcnMvbWlzYy92bXdfdm1j
aS92bWNpX2hvc3QuYzoxNzcNCj4gdmZzX3BvbGwgaW5jbHVkZS9saW51eC9wb2xsLmg6ODggW2lu
bGluZV0NCj4gZG9fcG9sbGZkIGZzL3NlbGVjdC5jOjg3MyBbaW5saW5lXQ0KPiBkb19wb2xsIGZz
L3NlbGVjdC5jOjkyMSBbaW5saW5lXQ0KPiBkb19zeXNfcG9sbCsweGM3Yy8weDFhYTAgZnMvc2Vs
ZWN0LmM6MTAxNQ0KPiBfX2RvX3N5c19wcG9sbCBmcy9zZWxlY3QuYzoxMTIxIFtpbmxpbmVdDQo+
IF9fc2Vfc3lzX3Bwb2xsKzB4MmNjLzB4MzMwIGZzL3NlbGVjdC5jOjExMDENCj4gZG9fc3lzY2Fs
bF94NjQgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NTEgW2lubGluZV0NCj4gZG9fc3lzY2FsbF82
NCsweDRlLzB4YTAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6ODINCj4gZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NDYvMHhiMA0KPiBSSVA6IDAwMzM6MHg0NzhkYzkNCj4gQ29kZTog
ZjcgZDggNjQgODkgMDIgYjggZmYgZmYgZmYgZmYgYzMgNjYgMGYgMWYgNDQgMDAgMDAgNDggODkg
ZjggNDggODkgZjcgNDggODkgZDYgNDggODkgY2EgNGQgODkgYzIgNGQgODkgYzggNGMgOGIgNGMg
MjQgMDggMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCBjNyBjMSBiYyBmZiBm
ZiBmZiBmNyBkOCA2NCA4OSAwMSA0OA0KPiBSU1A6IDAwMmI6MDAwMDdmYzIxYjExOWJlOCBFRkxB
R1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMTBmDQo+IFJBWDogZmZmZmZmZmZm
ZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDA3ODE0MDggUkNYOiAwMDAwMDAwMDAwNDc4ZGM5DQo+IFJE
WDogMDAwMDAwMDAyMDAwMWI0MCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOiAwMDAwMDAwMDIw
MDAxYWMwDQo+IFJCUDogMDAwMDAwMDBmNDc3OTA5YSBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5
OiAwMDAwMDAwMDAwMDAwMDAwDQo+IFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAw
MDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwNzgxNTAwDQo+IFIxMzogMDAwMDAwMDAwMDc4MTQxNCBS
MTQ6IDAwMDAwMDAwMDA3ODE0MDggUjE1OiAwMDAwN2ZmY2YzOTEyNzkwDQo+IDwvVEFTSz4NCj4g
TW9kdWxlcyBsaW5rZWQgaW46DQo+IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0t
LQ0KPiBSSVA6IDAwMTA6X19sb2NrX2FjcXVpcmUrMHhmMy8weDVlMDAga2VybmVsL2xvY2tpbmcv
bG9ja2RlcC5jOjQ5MjYNCj4gQ29kZTogODkgYmMgMjQgODggMDAgMDAgMDAgMGYgODUgMDIgMjcg
MDAgMDAgODMgM2QgMWIgMTYgNjYgMTAgMDAgMGYgODQgOTcgNDMgMDAgMDAgODMgM2QgZDYgZWEg
ZjkgMGUgMDAgNzQgMzEgNDggODkgZjggNDggYzEgZTggMDMgPDQyPiA4MCAzYyAwMCAwMCA3NCAx
NyBlOCA4MSA2MyA4NiAwMCA0OCA4YiBiYyAyNCA4OCAwMCAwMCAwMCA0OSBiOA0KPiBSU1A6IDAw
MTg6ZmZmZmM5MDAwMzcyNzMyMCBFRkxBR1M6IDAwMDEwMDAyDQo+IFJBWDogMDAwMDAwMDAwMDAw
MDAwYiBSQlg6IDAwMDAwMDAwMDAwMDAwMDEgUkNYOiAxZmZmZjkyMDAwNmU0ZTg0DQo+IFJEWDog
MDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiAwMDAwMDAwMDAwMDAw
MDU4DQo+IFJCUDogZmZmZmM5MDAwMzcyNzZiMCBSMDg6IGRmZmZmYzAwMDAwMDAwMDAgUjA5OiAw
MDAwMDAwMDAwMDAwMDAwDQo+IFIxMDogZmZmZmZiZmZmMjM5NGQ1ZSBSMTE6IDAwMDAwMDAwMDAw
MDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6
IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwDQo+IEZTOiAgMDAwMDdmYzIx
YjExYTcwMCgwMDAwKSBHUzpmZmZmODg4MGI5MzAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAw
MDAwMDANCj4gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAz
Mw0KPiBDUjI6IDAwMDA1NWI4Y2ZhZmQ3ZDAgQ1IzOiAwMDAwMDAwMDFjNGFhMDAwIENSNDogMDAw
MDAwMDAwMDM1MDZlMA0KPiBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAw
MDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPiBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAw
MDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiANCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCj4gDQo+IOKaoCBFeHRlcm5hbCBFbWFpbDogVGhpcyBlbWFp
bCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2Vu
ZGVyLg0KDQo=
