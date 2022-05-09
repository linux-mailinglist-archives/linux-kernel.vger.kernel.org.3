Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0123351F5A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiEIHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiEIHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:33:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2085.outbound.protection.outlook.com [40.107.113.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC3185769
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAs5pQBJ9KGkxgoKCnMBAW1PQQpyqkSZ2DTsoN89jQJTvjnr25NxsOX3OjPFhn1RJ89UadQeSPS+5iaNfuJeJh6nFRWZZpScttYBv9xEpnp7WnuHRPFBJe6eVs1oHAnJdgrJbn6Khxsc5M9ePKjZeHAGhsezANyiNmasXMZG61npNXBLAM9vNLLdPGP9Wt3wYVuRhM+qSmLer4Do3LWMP3WpzT9gMsd5lBSE5c7Zc1d30lN0/3ho3O/0/A9pyLcWKd5yzb2fx/dveVeSGP5MFJy3kVdqF45EKVDl6CuRlf6ObtloG9TgOqIxK5MGcRNSnGhYUqlsRJ8aocZmPvTL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ejrxlFVDYWXs+kxO5IUZklG2WCjj/QQTRzf6kE3TyY=;
 b=fpGeT7KhIzvOKGEgmi62SjgyT4EP8UkCG3aT7kdk/V0LUbwcnMb5ZB323avxeGREyS+Fer0uNRt17q3gweF4QqlfMM/yYHos6/rhxBjlhPBl36JtQj743HPp/+jY3uYzp8rmpFGn97mZqc5c03OFPuh1obTl1Xex8SuWU5wP2y/8fXdTqm1KgANnZaFl+75LjcE6AFszHN1TSYsPktM54bzPC0nQxZMT/Jc/JHChEyGuTnXzi5w7tKlP26vUFGAW9cwNaPicF5CGlSLYKdfVsMnfy1Ou98U4U1nl8uy2EhsghoZhyEnZdG5nHpoMWCZMHG0aZCpEBD5gsn4vkdiz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ejrxlFVDYWXs+kxO5IUZklG2WCjj/QQTRzf6kE3TyY=;
 b=XQG+yh1wna00iUJ+8UBNTW25ieA8W4QSgJhmf8YzbN+qMvPYok/ccqNUux8HxAgyDFews0AKAcA3Lwu7cqqAMl1sjthz9Y77uSp20rXsl3n/O+SM1I7Da9gT8hHtxnVh/Jwwc6kSDUwbhWAFORacU58zABR/V04FCRo6dd7ZrtA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB9674.jpnprd01.prod.outlook.com (2603:1096:604:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 07:29:02 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 07:29:02 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Thread-Topic: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Thread-Index: AQHYWe9WIfS7YLZ5REqhyMUPm2f3sK0DlLoAgAAZ3ICAAVXTgIARNKEA
Date:   Mon, 9 May 2022 07:29:02 +0000
Message-ID: <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
In-Reply-To: <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 034255ad-a6f8-4843-ea4d-08da318d9752
x-ms-traffictypediagnostic: OS3PR01MB9674:EE_
x-microsoft-antispam-prvs: <OS3PR01MB9674444E2A39505BB4C1D4D5E7C69@OS3PR01MB9674.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 322G1P7Xfrjny1cMkfLDK8TLLn8r77zJUUMsIPz26pEqvip/XRCrzX7Q7+YWL01ZDGhIdddTsDsGu257H6whVe0hMEGb+Hxq9kPByKFvUj20umJ2Lp3JOba6ZRIEt0SLAA/8CaO2xQYohQRYwvrkIM3acywoGV3e/HK48vvrpdmv95nknPXcnWsRxjKq3Xo2xceOphVec670FDjA87oit/bepjw/9GaSOukAeKkq4SfpUFo8c9hriwf+ZYYJRX92+cDun0hbBGW2T+6AbzXKi6fZVD/Ml9f9jrtWuUajc3EkaGr90qSRd2RcYdfQaRe83m4YZXZignvpPuNVnmQVguHvabeeOWjhX70A3Oy0RwuupoliAVKHOcWt8ijm1qYf55ER5sHLX3qqdRD57/cWVr2StmJCzRmJv3kCOHggHUHvlj7iEDn3gSKtF2a8ZuoDJAjdHoL4zXAYWdyzIfy/GCrtUZV4Lfe1hFsns4Br2x3LDKcFZvriVoh/U7WXSqqG7j08nTT/RjucBSBVFS01m/1Vp3+oonWf+F3Z2mlNQEZ5jt7Op7hmYuNuQJUW3dlVrT7gQ7KAYxGMUHa8rpjaahWkfEc+3Hmigr7Qi1Pk7VZ3Z6AOO1EpQRZws8JlkGF0J8eQz75Fd/3gGqjlCCr6/PgPR0NjMnY0wpOq8z5cYCyb7GHO2ED3ru+eXhts/GQRBWWNkxnkCFUmMl88LxBPkgtiYrqCTVxnliUKFjynUiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(9686003)(6512007)(1076003)(55236004)(6506007)(26005)(2906002)(38100700002)(82960400001)(66556008)(64756008)(66946007)(4326008)(54906003)(8676002)(66446008)(66476007)(76116006)(85182001)(186003)(316002)(6916009)(6486002)(86362001)(71200400001)(38070700005)(83380400001)(33656002)(5660300002)(8936002)(7416002)(508600001)(25903002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1JGbnZ3RTB3a3lsaFlONDhTNkt2cStwNy9mNVMzOGZPV1dXRUdxUTlnQVdF?=
 =?utf-8?B?eWQrUzByT25SaFVML1k0R05wNi8rc2o3cjRObXEwRVp4bGdndEE1TVpGUXNz?=
 =?utf-8?B?ZXZFUFhGVEg4UDgrSmdjNmhIRVZ2S0wvZmVqUlBEQ00yRGdKVmNOYjhlbGFl?=
 =?utf-8?B?NUtucTd0dkY1UkliL2ZvUk8wNCtZd3ppYTlBNlVEM21tQ0l6SEQ3U2pPRXMy?=
 =?utf-8?B?ZjZzTEpQYzdJRUF1YTZXbHNMcWg0S2kza253c1BENGVPQ3BUTGRUM0FHSWhV?=
 =?utf-8?B?ak81akFHVU8yQldFM1ZWSzcxdElaTk1kN2tjdXhIbk1BNlJzeUJUSmlaSEND?=
 =?utf-8?B?Ym5PY1Q5b2g2bnZ0cHBFT25KdVhVY3hmbjlPZkJhNVErTmh4YzFyenBZS0o2?=
 =?utf-8?B?andrZzkySkh5R2cyeWI3Wjd6K3FQSjZFNGVjbkR0Mm83SXFJb3IxMHFzOC9S?=
 =?utf-8?B?cE1YYTZvL3VyVithR0FMZE1acHk2V284S213S0VKREJBZEFEMGVqZXVXb0c4?=
 =?utf-8?B?V2U0b0NOZzNhcjNxdTBXbWs2WU5hTVVGdWt4YTlVSWVMRjBTWFhVazZLY3lY?=
 =?utf-8?B?QWFRSHFzaHdlMUJucDFDWVVreDZaREJEMkFpbklUcmJaWmRVZGVIOUxQV2RS?=
 =?utf-8?B?SGRlMlNWa2owcFJrVGp4bkxacklRWjZmVmVSeFU3UzJJRUVkU1YvZEZudXZX?=
 =?utf-8?B?dVh1Ry9ITktOSG5qcENsbXVFVzFiWHJ4NXp0cnFFcGtIOXMzNDh5VnpsMzhz?=
 =?utf-8?B?T29ueUFwZldvaDlvMnlsNUczVDE2Ri8vL0h5YXFraWVMS3ZOS3AySTNZaXZ5?=
 =?utf-8?B?eWdqTzRQKzluak83UDNHNlpqdkIvVTZNV1lYZFZrRy9BTitQS0RCVDlsZHI5?=
 =?utf-8?B?YXk5SktMdk1HWVFHTDEraFBwZ0Z4SHloQ25HVko4N2s4RXoyVU9wY0dpZnVl?=
 =?utf-8?B?MktIRkpoN1lkdzgxUFI4R0pndXFQbGYvTng5N2d6K0FvRWh3ZXp3eHJoRjFD?=
 =?utf-8?B?N3lpTm1Xb2FKSXhvMTNFenRpaXZZQSs5WnJxVFpPVFNyaWZyd0NCZURzc3lO?=
 =?utf-8?B?cEg3TVJtODZMT1haWlpmM3h5aG94WElxWVAvdlNISXZaZGZuRnVNaklRZ2xi?=
 =?utf-8?B?NVRVSEFMUmNSekRHSnNwN1l2aTdpWXg2SHM3U3g0TzVNbHBtWFc4d0gydTBi?=
 =?utf-8?B?NkNmNWJzMDJVOGxIN0VmNHhnamNQVktUU2pQKzQ3WTJHZmFnckE0aS9jWlNu?=
 =?utf-8?B?Wk52eVFyU0lCeGF4UGFzVjRVaUlDYnVtaW1OQ2dUZ1A1dGNCb0R4aisxMHhQ?=
 =?utf-8?B?ZTc3SE5iTWRDdDBhMVBRb3g4cU92K0hrbkd2dVpOOVdIQVNsVzZYY3JDZ3Zm?=
 =?utf-8?B?SVV6VEJWajJSM2drdktTdDBFVkhKTlc1aGZCaURoK0ZGT2srVmVQUytBM3Ax?=
 =?utf-8?B?ZnhmSHErc2xBdUNoQkFXZkx5V1J1VDdjTElEbWExY2paTThNUXFSSXloektN?=
 =?utf-8?B?NEo0UEFDajZwNjFGYkJWajUzM21VczdEV1RxcjBPaGwzbGJOWGNFNDlWMkZq?=
 =?utf-8?B?VStZbTZYeWRhVlNoSW9yT09qZzNYTUNaaVZhdXRHM3JlM2RwVmtpQldyNS9U?=
 =?utf-8?B?ZElGMGRDK3psaTNQbWZPUUpsR3hRNFlhSUNHdHArWDY0S1lYa0libXlWa3ZP?=
 =?utf-8?B?ek1RZzFGaVk0cjBTRVUxSVZVNXl5eHkyaW43RDFLZ3BxR2dpWVlxL2ZDUHh6?=
 =?utf-8?B?Q2QzSWhmRDV5YmpBZHRVaS9LZTh5UXFreE50Rm1XdUJqTXFjOURnaEdDd1ZN?=
 =?utf-8?B?bUlYQkdsNkRUeW9HRTlFQnJ1bjNaeHN4eHNuSkdOcEFuZzIzM051QTNBRFZX?=
 =?utf-8?B?OG53VHBWWWRxOWtGVi9KakVDcDBQQUNuNHJSazFuT1NTSHNUVVE2UmVHMURo?=
 =?utf-8?B?UlBBYnJ4emdXU3JjV014Ny9BaDRxVXBtK05IczFUSE5RVDFlUmxLU3hwMURG?=
 =?utf-8?B?c2lWakJPQjZjVmt1Tk85VkdyVEtpSlZjeXhKUGhITWE0TytkY1RiKzl3K3Ey?=
 =?utf-8?B?VlBlQW1SNzBvdm4xNzhCTjNCNFVUZU0vVDZUMlJ4c0lFVzkwWmVHTnczNFYx?=
 =?utf-8?B?YmR1NklWRVlQNmJCL2xBVC9aYlJIbVg0bTRLUEFXcmkxcGdObm5EM045YWlR?=
 =?utf-8?B?TndSNlRsdDZHMEJBNmpZUFh1N1dpWG9CNEd0dFpGNzYvd2tsVWNnay9Zek12?=
 =?utf-8?B?NFRYZGRqa2dmdmdjMC9PS0gvb0NSVkhsK3pNMGYvc0Z3U1R6SDR3T01YTWFn?=
 =?utf-8?B?VnBKTnJrZWVYRkhOR0Zab01MVkNlZ09rd1FvZXJKY0FSRmtTNnMrR1owYVlY?=
 =?utf-8?Q?ZdNxYNx1EUQrwbKk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AAB4F0CB686E041A0FDA6C2A7488FBB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034255ad-a6f8-4843-ea4d-08da318d9752
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 07:29:02.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBLdS1HlEPBvt0vWrGZbi/D1CsC+ymlWgmNBq0jHykPyMSF3+gSXw//+/Sg8x2RJxijs9muv+XhgUjivrS3y9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9674
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMTA6NDQ6MTVBTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+ID4+IDIpIEl0IGhhcHBlbnMgcmFyZWx5IChldmVyPyksIHNvIGRvIHdlIGV2
ZW4gY2FyZT8NCj4gPiANCj4gPiBJJ20gbm90IGNlcnRhaW4gb2YgdGhlIHJhcml0eS4gIFNvbWUg
Y2xvdWQgc2VydmljZSBwcm92aWRlcnMgd2hvIG1haW50YWluDQo+ID4gbG90cyBvZiBzZXJ2ZXJz
IG1heSBjYXJlPw0KPiANCj4gQWJvdXQgcmVwbGFjaW5nIGJyb2tlbiBESU1Ncz8gSSdtIG5vdCBz
byBzdXJlLCBlc3BlY2lhbGx5IGJlY2F1c2UgaXQNCj4gcmVxdWlyZXMgYSBzcGVjaWFsIHNldHVw
IHdpdGggWk9ORV9NT1ZBQkxFIChpLmUuLCBtb3ZhYmxlY29yZSkgdG8gYmUNCj4gc29tZXdoYXQg
cmVsaWFibGUgYW5kIGluZGl2aWR1YWwgRElNTXMgY2FuIHVzdWFsbHkgbm90IGdldCByZXBsYWNl
ZCBhdCBhbGwuDQo+IA0KPiA+IA0KPiA+PiAzKSBPbmNlIHRoZSBtZW1vcnkgaXMgb2ZmbGluZSwg
d2UgY2FuIHJlLW9ubGluZSBpdCBhbmQgbG9zdCBIV1BvaXNvbi4NCj4gPj4gICAgVGhlIG1lbW9y
eSBjYW4gYmUgaGFwcGlseSB1c2VkLg0KPiA+Pg0KPiA+PiAzKSBjYW4gaGFwcGVuIGVhc2lseSBp
ZiBvdXIgRElNTSBjb25zaXN0cyBvZiBtdWx0aXBsZSBtZW1vcnkgYmxvY2tzIGFuZA0KPiA+PiBv
ZmZsaW5pbmcgb2Ygc29tZSBtZW1vcnkgYmxvY2sgZmFpbHMgLT4gd2UnbGwgcmUtb25saW5lIGFs
bCBhbHJlYWR5DQo+ID4+IG9mZmxpbmVkIG9uZXMuIFdlJ2xsIGhhcHBpbHkgcmV1c2UgcHJldmlv
dXNseSBIV1BvaXNvbmVkIHBhZ2VzLCB3aGljaA0KPiA+PiBmZWVscyBtb3JlIGRhbmdlcm91cyB0
byBtZSB0aGVuIGp1c3QgbGVhdmluZyB0aGUgRElNTSBhcm91bmQgKGFuZA0KPiA+PiBldmVudHVh
bGx5IGh3cG9pc29uaW5nIGFsbCBwYWdlcyBvbiBpdCBzdWNoIHRoYXQgaXQgd29uJ3QgZ2V0IHVz
ZWQNCj4gPj4gYW55bW9yZT8pLg0KPiA+IA0KPiA+IEkgc2VlLiBUaGlzIHNjZW5hcmlvIGNhbiBv
ZnRlbiBoYXBwZW4uDQo+ID4gDQo+ID4+DQo+ID4+IFNvIG1heWJlIHdlIHNob3VsZCBqdXN0IGZh
aWwgb2ZmbGluaW5nIG9uY2Ugd2Ugc3R1bWJsZSBvdmVyIGEgaHdwb2lzb25lZA0KPiA+PiBwYWdl
Pw0KPiA+IA0KPiA+IFRoYXQgY291bGQgYmUgb25lIGNob2ljZS4NCj4gPiANCj4gPiBNYXliZSBh
bm90aGVyIGlzIGxpa2UgdGhpczogb2ZmbGluaW5nIGNhbiBzdWNjZWVkIGJ1dCBIV1BvaXNvbiBm
bGFncyBhcmUNCj4gPiBrZXB0IG92ZXIgb2ZmbGluZS1yZW9ubGluZSBvcGVyYXRpb25zLiAgSWYg
dGhlIHN5c3RlbSBub3RpY2VkIHRoYXQgdGhlDQo+ID4gcmUtb25saW5lZCBibG9ja3MgYXJlIGJh
Y2tlZCBieSB0aGUgb3JpZ2luYWwgRElNTXMgb3IgTlVNQSBub2RlcywgdGhlbiB0aGUNCj4gPiBz
YXZlZCBIV1BvaXNvbiBmbGFncyBhcmUgc3RpbGwgZWZmZWN0aXZlLCBzbyBrZWVwIHVzaW5nIHRo
ZW0uICBJZiB0aGUNCj4gPiByZS1vbmxpbmVkIGJsb2NrcyBhcmUgYmFja2VkIGJ5IHJlcGxhY2Vk
IERJTU1zL05VTUEgbm9kZXMsIHRoZW4gd2UgY2FuIGNsZWFyDQo+ID4gYWxsIEhXUG9pc29uIGZs
YWdzIGFzc29jaWF0ZWQgd2l0aCByZXBsYWNlZCBwaHlzaWNhbCBhZGRyZXNzIHJhbmdlLiAgVGhp
cw0KPiA+IGNhbiBiZSBkb25lIGF1dG9tYXRpY2FsbHkgaW4gcmUtb25saW5pbmcgaWYgdGhlcmUn
cyBhIHdheSBmb3Iga2VybmVsIHRvIGtub3cNCj4gPiB3aGV0aGVyIERJTU0vTlVNQSBub2RlcyBh
cmUgcmVwbGFjZWQgd2l0aCBuZXcgb25lcy4gIEJ1dCBpZiB0aGVyZSBpc24ndCwNCj4gPiBzeXN0
ZW0gYXBwbGljYXRpb25zIGhhdmUgdG8gY2hlY2sgdGhlIEhXIGFuZCBleHBsaWNpdGx5IHJlc2V0
IHRoZSBIV1BvaXNvbg0KPiA+IGZsYWdzLg0KPiANCj4gT2ZmbGluZSBtZW1vcnkgc2VjdGlvbnMg
aGF2ZSBhIHN0YWxlIG1lbW1hcCwgc28gdGhlcmUgaXMgbm8gdHJ1c3Rpbmcgb24NCj4gdGhhdC4g
QW5kIHRyeWluZyB0byB3b3JrIGFyb3VuZCB0aGF0IG9yIGFkanVzdGluZyBtZW1vcnkgb25saW5p
bmcgY29kZQ0KPiBvdmVyY29tcGxpY2F0ZXMgc29tZXRoaW5nIHdlIHJlYWxseSBkb24ndCBjYXJl
IGFib3V0IHN1cHBvcnRpbmcuDQoNCk9LLCBzbyBJJ2xsIGdvIGZvcndhcmQgdG8gcmVkdWNlIGNv
bXBsZXhpdHkgaW4gaHdwb2lzb24gc3BlY2lmaWMgY29kZSBpbg0KbWVtb3J5IG9mZmxpbmluZyBj
b2RlLg0KDQo+IA0KPiBTbyBpZiB3ZSBjb250aW51ZSBhbGxvd2luZyBvZmZsaW5pbmcgbWVtb3J5
IGJsb2NrcyB3aXRoIHBvaXNvbmVkIHBhZ2VzLA0KPiB3ZSBjb3VsZCBzaW1wbHkgcmVtZW1iZXIg
dGhhdCB0aGF0IG1lbW9yeSBibG9jayBoYWQgYW55IHBvc2lvbmVkIHBhZ2UNCj4gKGVpdGhlciBm
b3IgdGhlIG1lbW9yeSBzZWN0aW9uIG9yIG1heWJlIGJldHRlciBmb3IgdGhlIHdob2xlIG1lbW9y
eQ0KPiBibG9jaykuIFdlIGNhbiB0aGVuIHNpbXBseSByZWplY3QvZmFpbCBtZW1vcnkgb25saW5p
bmcgb2YgdGhlc2UgbWVtb3J5DQo+IGJsb2Nrcy4NCg0KSXQgc2VlbXMgdG8gYmUgaGVscGZ1bCBh
bHNvIGZvciBvdGhlciBjb25leHQgKGxpa2UgaHVnZXRsYikgdG8ga25vdyB3aGV0aGVyDQp0aGVy
ZSdzIGFueSBod3BvaXNvbmVkIHBhZ2UgaW4gYSBnaXZlbiByYW5nZSBvZiBwaHlzaWNhbCBhZGRy
ZXNzLCBzbyBJJ2xsDQp0aGluayBvZiB0aGlzIGFwcHJvYWNoLg0KDQo+IA0KPiBTbyB0aGF0IGxl
YXZlcyB1cyB3aXRoIGVpdGhlcg0KPiANCj4gMSkgRmFpbCBvZmZsaW5pbmcgLT4gbm8gbmVlZCB0
byBjYXJlIGFib3V0IHJlb25saW5pbmcNCj4gMikgU3VjY2VlZCBvZmZsaW5pbmcgYnV0IGZhaWwg
cmUtb25saW5pbmcNCg0KUmVwaHJhc2luZyBpbiBjYXNlIEkgbWlzcmVhZCwgbWVtb3J5IG9mZmxp
bmluZyBjb2RlIHNob3VsZCBuZXZlciBjaGVjaw0KaHdwb2lzb25lZCBwYWdlcyBmaW5hbGx5LCBh
bmQgbWVtb3J5IG9ubGluaW5nIGNvZGUgd291bGQgZG8ga2luZCBvZiByYW5nZQ0KcXVlcnkgdG8g
ZmluZCBod3BvaXNvbmVkIHBhZ2VzICh3aXRob3V0IGRlcGVuZGluZyBvbiBQYWdlSFdQb2lzb24g
ZmxhZykuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
