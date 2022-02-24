Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115E54C243B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiBXGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBXGxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:53:43 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7B3141474;
        Wed, 23 Feb 2022 22:53:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9/XGEPaYZcUzE4iGmyI78ZoEHtDFSYIybTWbG4oy5TtF/SYEOms5fFhr2d0gduzQaDwybyZXIZiSoB2lbSqEZFVDxF9Gja3HnTlcXwXb/DBdGPzuVzh1LtrQgMrjvcFJEdQFeBrHV6abyi2m4/QKcgQJZ7gUlTnr6rMMGh+xvUXEM+5rM3Uk6Ra3pyYK2iMEQM5KbaYpsy3Y3BzxvmBbU/mz5pTg5B7GmbbBLOhYi1u1GDjHDil7PwgQ3I2Mr/cnbLpLsdzAq/XSFXV7LBeZASMRh4yWxV4AN92UyD2umv+rakSS9fSXnbR2FTxIuctIVSJrTYNS15Lpi3zq0d5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ubz/+6XwcEUZfturYSQV9eQkz9AW/pexhuMHiGHRz4=;
 b=iWxywdIaIi+UCA41SXoVZurfxcZFi0Hw2KcLsaOWFf3ZUj/aVrdAR3YiChtSyZJTU9eLIzSRe8B5jdjPYCwZ4xa256OOV2j7RerRs68tbytO2/VqKPFCbpD5uLMDXDtWd9cue+1OxmwxS4YOyDFidcMyqffWlFMXxpPyHjHECnPVtgoKb6/ABYJ8iYDtTr+oT2IWdyr6gV3Xi9B6SaeLb8SpdArQy/kPbkUmlp6a34DoDpgqYXqJvOGZMfd/6jSbgeHSyj6h8Eenbb/1MWGkYvPx2UJ88UGyLBEcHdNAYYqKyldT9I9bz0sMZI87HoAg0UshwjNRTadd9ku7w4CT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ubz/+6XwcEUZfturYSQV9eQkz9AW/pexhuMHiGHRz4=;
 b=r43K2JznP/Jttb6mW1SdvLLM4KQbDqgRClnN8dv4UcSnateICwzgbH6jqXR1gNf2lXNbRaQdLn1QTLcxCXgyQ5S5ftuFFC0gj09etu2LYpGygQRrCsh9qT9I7NQF75y+pGf0I8+rUg+PdbT+jIO0vza1zrzYMxPoeLKv5LaUE6I=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Thu, 24 Feb
 2022 06:53:10 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::8587:7d16:1dee:4a4d]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::8587:7d16:1dee:4a4d%7]) with mapi id 15.20.5038.009; Thu, 24 Feb 2022
 06:53:10 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "acking@vmware.com" <acking@vmware.com>,
        "dtor@vmware.com" <dtor@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Thread-Topic: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Thread-Index: AQHYHs1qh1rsU2MYvUCsLtTWA1uvXqyOZHUAgABjswCAE5CagA==
Date:   Thu, 24 Feb 2022 06:53:10 +0000
Message-ID: <85DB8130-D600-464E-9717-1A0AFE795EA7@vmware.com>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
 <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
 <20220211140950.GN1951@kadam>
 <1bc15512-d811-b26a-d4f3-e14b30730c00@wanadoo.fr>
In-Reply-To: <1bc15512-d811-b26a-d4f3-e14b30730c00@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07b2e4ca-23b6-41b0-2e1f-08d9f7625200
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR05MB870307D7254C04D47F0B4471CE3D9@PH0PR05MB8703.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luY+IW1b3/95pnpJRfsSVrvES6OQ8gYOeLIxrudt4jgFtxYpPhVmlDnygI0I86+cHkUE9V7mL/j4qYjl3xh86XD1dxEHlzHtRmaMKgw2IxlTt/ulh4jHJWK5qEpBm/Bl0aWSkkrHZPM3vbEkYs2fug/kYiaWaJnQ5Dy1PlGqU1Yk63U/JTx/HosmiiU+qQ2idPFnI6buNPp1CqbTarF1niziMO1azMjN4xA+NOuDfajpx6cs/5UiYeIwwMWx11a6KAKc6zOenHiPjTasRYqQd2n644iCV4WdZFzWwUakjrLsFGF1OwbU9iF1HsB083LOYAUO34h0MhUzlgkdjfaxxI+JisO1sNIdkMI3eH11X24B94AorF47VBOeFVKNgDDdkaksuSoN3xQaM2/CIACPUnbP8G7NH2UycUOdWF/OPZtX/LzlUR8KZGJ/+FyeKbExDB+8WXo4A0TyKBnhhK42EPpRUlVX+KDDykoYNrZvTgttSHWGfTqr8SzEzT5hEVFukW8GfdotsTOsbCo/be1emdeJhGc+99J/Dydy50cDsemwiiyiVrxd/vlhZC9FkuHKsQC43hMAX9REFFdnkEe4sz6nNWNGT9wAKXoHsV4SQUlpEYYUKlr8U1xOAM8qyuI7ZT7KqFqqv1pUhcGZ3Qy4QYvZB0FA1s1cm2kKRO34zH9I0IM9g8qktlnIQFkrC/WVIVXn6tVWPJi+V0CfKztXxBe+a7eNMV61KXzfXpcvxn0tRLJqjAbolHCYxjcdOJsH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38070700005)(122000001)(86362001)(83380400001)(33656002)(5660300002)(316002)(508600001)(66574015)(71200400001)(53546011)(8936002)(186003)(2616005)(6486002)(54906003)(66476007)(66446008)(64756008)(76116006)(66556008)(66946007)(36756003)(6512007)(38100700002)(4326008)(6916009)(8676002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERwVmNGQ3g5L2VOTXU4NzNqMk5KRGxEckxGemQ3amxMRkgwMWVZYktuWk0z?=
 =?utf-8?B?M3FRODFGTkthcHc0bjlZUXdmR3Z3RGNUSG4xdFhvQXNKRmd1djF5Q1hScWxs?=
 =?utf-8?B?T0h2ZWFuejNrVE5uUjNQMG1yNHJyT2x4eWZMZWhqL00yMWdXMEdHbXR1UlhK?=
 =?utf-8?B?VEVOdzdKZkpreDJXdHkySzJBTndZUGowamdrUng1ajlpUDNVTkg4NE9xWEM0?=
 =?utf-8?B?dzQ5djZmaUhHTEEybi96Qnh0Nk13KzBLMDEyaE84SnhJNUU1VWxwb0psZWpB?=
 =?utf-8?B?Y24zM2JBZjI3MjdaeUg1V215MTEvOGlURy9zY0NJRnRQODRZd205T3kxM0Zj?=
 =?utf-8?B?a0d1UnZPRnI2T2dVdXFKVVlMSmxBcGlNOVdrcFZ6VUxvdzdhZWtLUjRoUitJ?=
 =?utf-8?B?STVCdU9MQ3gxdlZKMmpDOWRLZ3VVSXFiYXluVkJzdUxiME85WWRqN2pyR0dU?=
 =?utf-8?B?VkVOTldvZTNPamN3c1pVc1o1Ny85WEY4WXNzbVZubW8vbWJvMStGUkRaazE5?=
 =?utf-8?B?NUFXZFNvRE05U0MzNFFGQnBOZ3dXdWJQRjl4YlBQNC9pM3B1RForM3RLekhP?=
 =?utf-8?B?TW4wVHRBZEtNenl5aWpib2UzVHlNZHlDdlIrblkwZEpwdkpEdVloZzVXQUJZ?=
 =?utf-8?B?R0ZVZE9OMzFlYWNLSXN3UjBMNFlVaUp1YTZ1d3lUZ242cUtCdUNJNldyTzVk?=
 =?utf-8?B?MGdZMis1aWdaSXJpcS9uc2VndzJpaDRsa2VHc01sODdWL201a3FFRHF5ZU14?=
 =?utf-8?B?TzNaSnEvTUlJUW50ZlhFd1hOcmJRTndPQTFPREVCN3dVNnZSRHdyT3ZRYUIx?=
 =?utf-8?B?clRmbG5HMXFVNnppdjJ4c2Z5VG1jajlqalJGdEJhalNZM0JEeVJkMkJZY3Ba?=
 =?utf-8?B?UFVPQVNUYS91QmhhR2lHWDErempUQWVrWGVHcGMvTENFWFM5RlVYaVFEcmJG?=
 =?utf-8?B?WXcwMVJWUUdjWVJZSTMzR09JdTlGMThXNy9JZ0NrRlVyQWwxYTVnZHNyZlRs?=
 =?utf-8?B?N1czcTlTOE4rcWFHekZrYzVqSEY0SmZMQ0J6ZlNIZ2E0bGtGanZxQldKQ2RE?=
 =?utf-8?B?VjlPN29PTnFzcUU3ZmwzZ2JJTW1IRzE1M2EzSC9GUlIzNTkydFF2Q2t4c21F?=
 =?utf-8?B?dnJhdDI3c2hFTTdZMG9nTjMxd3R6eFplayt4Y1dJVzBOb2lkQ1dmVnZBY2p1?=
 =?utf-8?B?VWp4L0xFUUFNVzdwTTZxbVNoNDcvODh4OENHS2VndE84QzJSbmUxblcwSzBQ?=
 =?utf-8?B?QWFjazI5OFljWlBFM251d3gvMnhJcG44bk1VSzdsV24yN3RHUVZIaWp4UEdL?=
 =?utf-8?B?VzlUZXJSSk50d01WNVFqYk9FOGNQeUZkWWx1WG1vc2I5azNaWnBrVlRMV0o0?=
 =?utf-8?B?aThkOGw1VVo1dG11d3lIR29PMXllekZTSXZtZzZacldmVEE5NlNjRFJIYm1J?=
 =?utf-8?B?KzNYcnVmMDlha2dxSEFOeFE5cUZKMXUrWE1xdHdrV0xLOVRGckhtYlRyaW9s?=
 =?utf-8?B?V0N2T00vZXcvSHlnVVBHOWpOYzhlc0lwMUN5VzRwUDJIL3RlOWRvV3FYczdS?=
 =?utf-8?B?Uk1hOFA5SXMrcmhseVVjUXRNc2xkYXVwSnJ6bXNKREVUL3JmWHZjL2szck8y?=
 =?utf-8?B?VGZTTmVneXQrQzliWUdjWWxkQUtXUjN0L2pRcUFjZHJ0T29jZTNUQ3o3emZz?=
 =?utf-8?B?RFhqSitpZUUrQXZrUWp3d0FNYlA2WFc0c0FvSkcrbkIyZGszYmtRMm52THJI?=
 =?utf-8?B?Sk1aNFFoZSs5d3JjSXlyY1lkWlRwS2N6dThwNVdMYm5FMzM4SDM2VVArRGlJ?=
 =?utf-8?B?TkNJY3VjZTUwSVE3ZlZ0LzZCNE1PdDV0WWFwa2tzNWdNTFJTbEhOb0pxcjVJ?=
 =?utf-8?B?NXpGdFZNZlFCeEVCSHozRlVoUFlRTXF0RWN4V0c2aTBNQU54d21YT0VMVTdl?=
 =?utf-8?B?dXZKK1NXRW9CSVExS3pWTVFldlozN0hORDRSVGh6ei9BV1d2S3ZkTkNPSUlp?=
 =?utf-8?B?Tk0zNzViQ2xUR3J0bjRxcVI5ZjlCSmVpcklPL2tncnh3bW1pYXphSmM5cmhr?=
 =?utf-8?B?SVVhUGhJa21UVTNBY2JHV0IvMEpTaENNZWthZ1pHNW42U3REeW1lSi96NUdT?=
 =?utf-8?B?U05PenB5cktpanZObzkyMmZLeFl0UEo3NC9ORmRVRmpZR2VVMnVpcm5ERllH?=
 =?utf-8?B?bE5PRTdXNlZTUjFIaVNTSXllb2dRekY2T2ZPSEFGbXNkU2h3VHMwR0pHZjVE?=
 =?utf-8?Q?Ice2bviNGtPJ4sKYTUK6NokHEovkb4tSzvrDdV4D5k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91036E0600B3024596FB7D5318F55A74@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b2e4ca-23b6-41b0-2e1f-08d9f7625200
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 06:53:10.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZpB7Z7kc4hTITaADCQ4Cgq1EvkwySxwTGy5a2p+Ng0BgSydK6ptkAfsEwg3mqgcZqf5pXUzWbhn5sxtbv4gHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8703
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRmViIDExLCAyMDIyLCBhdCAxMjowNiBQTSwgQ2hyaXN0b3BoZSBKQUlMTEVUIDxj
aHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4gd3JvdGU6DQo+IA0KPiBMZSAxMS8wMi8yMDIy
IMOgIDE1OjA5LCBEYW4gQ2FycGVudGVyIGEgw6ljcml0IDoNCj4+IE9uIFRodSwgRmViIDEwLCAy
MDIyIGF0IDExOjI3OjM0UE0gKzAxMDAsIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToNCj4+PiBU
aGUgJ2Vycl9yZW1vdmVfdm1jaV9kZXZfZycgZXJyb3IgbGFiZWwgaXMgbm90IGF0IHRoZSByaWdo
dCBwbGFjZS4NCj4+PiBUaGlzIGNvdWxkIGxlYWQgdG8gdW4tcmVsZWFzZWQgcmVzb3VyY2UuDQo+
Pj4gDQo+Pj4gVGhlcmUgaXMgYWxzbyBhIG1pc3NpbmcgbGFiZWwuIElmIHBjaV9hbGxvY19pcnFf
dmVjdG9ycygpIGZhaWxzLCB0aGUNCj4+PiBwcmV2aW91cyB2bWNpX2V2ZW50X3N1YnNjcmliZSgp
IGNhbGwgbXVzdCBiZSB1bmRvbmUuDQo+Pj4gDQo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3Bo
ZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4NCj4+PiAtLS0NCj4+PiBS
ZXZpZXcgd2l0aCBHUkVBVCBjYXJlLg0KPj4+IA0KPj4+IFRoaXMgcGF0Y2ggaXMgYSByZWNlbnQg
cmViYXNlIG9mIGFuIG9sZCBwYXRjaCB0aGF0IGhhcyBuZXZlciBiZWVuDQo+Pj4gc3VibWl0dGVk
Lg0KPj4+IFRoaXMgZnVuY3Rpb24gaXMgaHVnZSBhbmQgbW9kaWZ5aW5nIGl0cyBlcnJvciBoYW5k
bGluZyBwYXRoIGlzIGVycm9yDQo+Pj4gcHJvbmUgKGF0IGxlYXN0IGZvciBtZSkuDQo+Pj4gDQo+
Pj4gVGhlIHBhdGNoIGlzIGNvbXBpbGUtdGVzdGVkIG9ubHkuDQo+PiBUaGVyZSBpcyBzdGlsbCBv
bmUgYnVnLiAgU29ycnkgaWYgdGhlIGxpbmUgbnVtYmVycyBhcmUgb2ZmLg0KPiANCj4gVGhhbmtz
IGZvciB0aGUgcmV2aWV3IERhbi4NCj4gTXVjaCBhcHByZWNpYXRlZC4NCg0KVGhhbmtzLCBDaHJp
c3RvcGhlIGFuZCBEYW4hDQoNCj4gDQo+PiBkcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9ndWVz
dC5jDQo+PiAgICA3MDUgICAgICAgICAgICAgICAgaWYgKGNhcGFiaWxpdGllcyAmIFZNQ0lfQ0FQ
U19OT1RJRklDQVRJT05TKSB7DQo+PiAgICA3MDYgICAgICAgICAgICAgICAgICAgICAgICB2bWNp
X2Rldi0+bm90aWZpY2F0aW9uX2JpdG1hcCA9IGRtYV9hbGxvY19jb2hlcmVudCgNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5eXl5eDQo+PiBBbGxvYw0KPj4gICAgNzA3ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmcGRldi0+ZGV2LCBQQUdFX1NJWkUsICZ2bWNpX2Rldi0+bm90aWZpY2F0aW9uX2Jhc2Us
DQo+PiAgICA3MDggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9LRVJORUwpOw0K
Pj4gICAgNzA5ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCF2bWNpX2Rldi0+bm90aWZpY2F0
aW9uX2JpdG1hcCkgew0KPj4gICAgNzEwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
ZXZfd2FybigmcGRldi0+ZGV2LA0KPj4gICAgNzExICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiVW5hYmxlIHRvIGFsbG9jYXRlIG5vdGlmaWNhdGlvbiBiaXRtYXBcbiIp
Ow0KPj4gICAgNzEyICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4+ICAgIDcxMyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtc2V0KHZtY2lfZGV2LT5ub3RpZmljYXRp
b25fYml0bWFwLCAwLCBQQUdFX1NJWkUpOw0KPj4gICAgNzE0ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjYXBzX2luX3VzZSB8PSBWTUNJX0NBUFNfTk9USUZJQ0FUSU9OUzsNCj4+ICAg
IDcxNSAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICAgIDcxNiAgICAgICAgICAgICAgICB9
DQo+PiAgICA3MTcNCj4+ICAgIDcxOCAgICAgICAgICAgICAgICBpZiAobW1pb19iYXNlICE9IE5V
TEwpIHsNCj4+ICAgIDcxOSAgICAgICAgICAgICAgICAgICAgICAgIGlmIChjYXBhYmlsaXRpZXMg
JiBWTUNJX0NBUFNfRE1BX0RBVEFHUkFNKSB7DQo+PiAgICA3MjAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNhcHNfaW5fdXNlIHw9IFZNQ0lfQ0FQU19ETUFfREFUQUdSQU07DQo+PiAg
ICA3MjEgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPj4gICAgNzIyICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsDQo+PiAgICA3MjMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIk1pc3NpbmcgY2FwYWJpbGl0eTog
Vk1DSV9DQVBTX0RNQV9EQVRBR1JBTVxuIik7DQo+PiAgICA3MjQgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVycm9yID0gLUVOWElPOw0KPj4gICAgNzI1ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGVycl9mcmVlX2RhdGFfYnVmZmVyczsNCj4+IFRoaXMgc2hvdWxk
IGJlIGdvdG8gZXJyX2ZyZWVfbm90aWZpY2F0aW9uX2JpdG1hcDsNCj4gDQo+IEFncmVlZC4NCj4g
VGhlIGVycm9yIGhhbmRsaW5nIHBhdGggc3RpbGwgbG9va2VkIG9kZCB0byBtZSBiZWNhdXNlIDIg
dGhpbmdzIHdlcmUgdW5kb25lIHdpdGhvdXQgYSBsYWJlbCBiZXR3ZWVuIHRoZSAyIHN0ZXBzLg0K
PiBUaGF0IHdhcyBpdC4gQW4gZXJyX2ZyZWVfbm90aWZpY2F0aW9uX2JpdG1hcCBzaG91bGQgYmUg
YWRkZWQgYW5kIHVzZWQuDQo+IEkgbWlzc2VkIGl0Lg0KDQpHb29kIGNhdGNoLiAgVGhpcyBmaXhl
cyByZWNlbnQgY29kZSwgc28gYSBzZXBhcmF0ZSBwYXRjaCB3b3VsZCBiZSBnb29kLg0KIltQQVRD
SCB2MyAzLzhdIFZNQ0k6IGRtYSBkZzogZGV0ZWN0IERNQSBkYXRhZ3JhbSBjYXBhYmlsaXR5Ig0K
DQo+IA0KPj4gICAgNzI2ICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gICAgNzI3ICAgICAg
ICAgICAgICAgIH0NCj4+IE9uIG9mIHRoZSBydWxlcyBmb3IgZXJyb3IgaGFuZGxpbmcgaXMgdGhh
dCB0aGUgdW53aW5kIGNvZGUgc2hvdWxkIG1pcnJvcg0KPj4gdGhlIGFsbG9jYXRpb24gY29kZSBi
dXQgaW5zdGVhZCBvZiB0aGF0IHRoaXMgY29kZSB3aWxsIGhhdmU6DQo+PiBBbGxvYzoNCj4+IAlp
ZiAoY2FwYWJpbGl0aWVzICYgVk1DSV9DQVBTX05PVElGSUNBVElPTlMpDQo+PiBGcmVlOg0KPj4g
CWlmICh2bWNpX2Rldi0+bm90aWZpY2F0aW9uX2JpdG1hcCkNCj4+IEl0J3MgdGhlIHNhbWUgaWYg
c3RhdGVtZW50IGJ1dCB5b3Ugd291bGRuJ3QgcmVhbGx5IGtub3cgaXQgZnJvbSBqdXN0DQo+PiBs
b29raW5nIGF0IGl0IHNvIGl0J3MgY29uZnVzaW5nLg0KPiANCj4gVGhpcyBvbmUgaXMgZmluZSBJ
IHRoaW5rLiBJZiB0aGUgYWxsb2NhdGlvbiBvZiBub3RpZmljYXRpb25fYml0bWFwIGZhaWxzLCBp
dCBpcyBub3QgYW4gZXJyb3IuIFNvIGl0IGxvb2tzIGZpbmUgdG8gdGVzdCBpdCB0aGUgd2F5IGl0
IGlzIGRvbmUuDQo+IE9yIHdlIHNob3VsZCBoYXZlIGJvdGggJ2lmJy4NCj4gDQoNClJpZ2h0LiAg
QW5kIHdlIHdvdWxkIG5lZWQgdG8gY2hlY2sgJ2NhcGFiaWxpdGllcyAmIFZNQ0lfQ0FQU19OT1RJ
RklDQVRJT05TJywNCidjYXBzX2luX3VzZSAmIFZNQ0lfQ0FQU19OT1RJRklDQVRJT05TJyBhbmQg
dGhlbg0KJ3ZtY2lfZGV2LT5ub3RpZmljYXRpb25fYml0bWFwJyBpZiB3ZSBnbyB0aGF0IHJvdXRl
LiAgSSB0aGluayB3ZSBjYW4gbGVhdmUgaXQgYXMgaXMuDQoNCj4gDQo+PiBXaGF0ZXZlci4uLiAg
QnV0IHdoZXJlIHRoaXMgcmVhbGx5DQo+PiBodXJ0cyBpcyB3aXRoOg0KPj4gQWxsb2M6DQo+PiAJ
aWYgKHZtY2lfZGV2LT5leGNsdXNpdmVfdmVjdG9ycykgew0KPj4gCQllcnJvciA9IHJlcXVlc3Rf
aXJxKHBjaV9pcnFfdmVjdG9yKHBkZXYsIDEpLCAuLi4NCj4+IEZyZWU6DQo+PiAJZnJlZV9pcnEo
cGNpX2lycV92ZWN0b3IocGRldiwgMSksIHZtY2lfZGV2KTsNCj4+IE5vIGlmIHN0YXRlbWVudC4g
IEl0IHdvcmtzIGJlY2F1c2UgaXQncyB0aGUgbGFzdCBhbGxvY2F0aW9uIGJ1dCBpdCdzDQo+PiBj
b25mdXNpbmcgYW5kIGZyYWdpbGUuDQo+IA0KPiBBZ3JlZWQuDQoNClNvcnJ5LCBJIGhvcGUgSSdt
IG5vdCBtaXNzaW5nIHNvbWV0aGluZyBvYnZpb3VzIG9yIG1pc3VuZGVyc3RhbmRpbmcgdGhlIHBv
aW50Lg0KQnV0IEkgZG9uJ3QgdGhpbmsgdGhlIHByb2JsZW0gaW1wbGllZCBoZXJlIGV4aXN0cz8N
Cg0KSWYgJ3JlcXVlc3RfaXJxKHBjaV9pcnFfdmVjdG9yKHBkZXYsIDApLCAuLi4nIGZhaWxzIHdl
IGdvdG8gZXJyX2Rpc2FibGVfbXNpIGFuZCB0aGVyZQ0KaXMgbm8gZnJlZV9pcnEgaW4gdGhpcyBw
YXRoLiAgSWYgJ3JlcXVlc3RfaXJxKHBjaV9pcnFfdmVjdG9yKHBkZXYsIDEpLCAuLi4nIGZhaWxz
IHRoZW4gd2UNCmdvdG8gZXJyX2ZyZWVfaXJxIGFuZCB3ZSBkbyAnZnJlZV9pcnEocGNpX2lycV92
ZWN0b3IocGRldiwgMCksIHZtY2lfZGV2KScuICBOb3RlIHRoYXQNCnRoaXMgaXMgZm9yIHRoZSBw
cmV2aW91cyBvbmUgd2l0aG91dCB0aGUgY2hlY2sgZm9yIHZtY2lfZGV2LT5leGNsdXNpdmVfdmVj
dG9ycy4NCg0KPiANCj4+IFRoZSBvdGhlciBxdWVzdGlvbiBJIGhhZCB3YXM6DQo+PiAgICA4ODIg
ICAgICAgIGVycl9yZW1vdmVfYml0bWFwOg0KPj4gICAgODgzICAgICAgICAgICAgICAgIGlmICh2
bWNpX2Rldi0+bm90aWZpY2F0aW9uX2JpdG1hcCkgew0KPj4gICAgODg0ICAgICAgICAgICAgICAg
ICAgICAgICAgdm1jaV93cml0ZV9yZWcodm1jaV9kZXYsIFZNQ0lfQ09OVFJPTF9SRVNFVCwgVk1D
SV9DT05UUk9MX0FERFIpOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xg0KPj4gVGhpcyBkb2Vzbid0IG1pcnJvciBhbnl0aGluZyBpbiB0aGUgYWxsb2NhdGlvbiBjb2Rl
IHNvIHdobyBrbm93cyBpZiBpdHMNCj4+IGRvbmUgaW4gdGhlIGNvcnJlY3QgcGxhY2Uvb3JkZXIu
DQo+IA0KPiBBZ3JlZWQuIEl0IHB1enpsZWQgbWUgYXMgd2VsbC4NCj4gDQo+IHZtY2lfZ3Vlc3Rf
cmVtb3ZlX2RldmljZSgpIGFsc28gaGFzIHRoaXMga2luZCBvZiBjb2RlLCBidXQgaXQgaXMgbm90
IGRvbmUgdGhlIHNhbWUgd2F5IGluIHRoaXMgZnVuY3Rpb24uIEl0IGlzIHVuY29uZGl0aW9uYWwg
YW5kIG5vdCBjbG9zZSB0byB0aGUgZG1hX2ZyZWVfY29oZXJlbnQoKSBjYWxsLg0KPiBPZGQuDQo+
IA0KPiBJIHdvbid0IHRvdWNoIGl0IGJ5IG15c2VsZiA6KQ0KPiANCj4+ICAgIDg4NSAgICAgICAg
ICAgICAgICAgICAgICAgIGRtYV9mcmVlX2NvaGVyZW50KCZwZGV2LT5kZXYsIFBBR0VfU0laRSwN
Cj4+ICAgIDg4NiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZtY2lf
ZGV2LT5ub3RpZmljYXRpb25fYml0bWFwLA0KPj4gICAgODg3ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdm1jaV9kZXYtPm5vdGlmaWNhdGlvbl9iYXNlKTsNCj4+ICAg
IDg4OCAgICAgICAgICAgICAgICB9DQo+PiByZWdhcmRzLA0KPj4gZGFuIGNhcnBlbnRlcg0KPiAN
Cj4gQWxsIHlvdXIgY29tbWVudHMgYXJlIHVucmVsYXRlZCB0byBteSBwYXRjaCBhbmQgbG9va3Mg
bGlrZSBhZGRpdGlvbmFsIGZpeGVzLg0KPiANCj4gVW50aWwgcmVjZW50bHksIHRoaXMgZmlsZSB3
YXMgbW9zdGx5IHVudG91Y2hlZC4NCj4gU28sIGxldCBzZWUgaWYgYSBtYWludGFpbmVyIGxvb2tz
IGludGVyZXN0ZWQgaW4gdGhlc2UgcGF0Y2hlcyBhbmQgaWYgaGUgcHJlZmVycyBhIHBhdGNoIHRo
YXQgZml4ZXMgZXZlcnl0aGluZyBvciBzZXZlcmFsIHBhdGNoZXMsIG1heWJlIGVhc2llciB0byBy
ZXZpZXcuDQo+IA0KPiBPbmNlIGFnYWluLCBiaWcgdGhhbmtzLg0KPiANCj4gQ0oNCg0K
