Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ACF56B434
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiGHIIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiGHIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:08:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536037B376;
        Fri,  8 Jul 2022 01:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmTpORAcdhByyRGlL7v0OIeL7/Ej8Nqt2ZhwwSs3W8AYIY9pZ3Rpz0clz1hvKz8gLiPBf8PDAzhlsnyNbsu/PSqvOpmK4SI07Yz0G20lb3e6VNbJP4sqY1QGFr6QuvlxtB+LAe7wetkOVjuH7KwQ6Phu0ZvEg8lgaFJeUP05Z7yVbJ9FffpwNGeyjmPrwaIFVDlcORnDNh8dgA2AWLOQNCs3YTOXftjr2gSzj3LRSFhQH85ZTsOckb38E9GpZxr+gHhC7P9yjwokOy9azo5yAeSMwtvj6hAD2YCG0+/XTRbFiabkeOvqM+VJ/ncT3VSdf2So83aUqclqcLao2r9qwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfUYsUTxoftttrYR86NXfZmaJsdHb/1w1rjvAQfWZvA=;
 b=fMvWmR1iy4qWDx2yIVZjW26ZM+9RzSbnEI0nSu6BLlQbht+2tEoiWt6NSlZnLglkaIHs0MW7xvkJiL2Bw2qpeMTrkkwRSrBk0ROn+zXtiqrJt/CcZv/9R9NYgxDswSRcCfTlZbn9MxuoFgW8qmyBnsijeLQpSiqfAkG6NhIWtFa7JIq/MnbD1rO17DleRbUHQ+irsPYHmdN/Us+1s/+KpKtU4Nnqj1IUZfuI/wPlix37kWRi4KQkoX3vecPM+OilBcNC/OBizt2JS72exZfNlAcS+SnSmDtkSDHCYQZrvquJEe1wmu3qgi1WNPH9JlJe6BjsKEXuz+8RZg5AvPOUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfUYsUTxoftttrYR86NXfZmaJsdHb/1w1rjvAQfWZvA=;
 b=r2KLIT0ZPUXppGhXdcYM5+d/cmx4BPa90fKGJu172p4z6FiHceqU1y1O25a9lPtFWd4B9Va9qR9/83hfAflWgqvG9mK5bE5bdI4+bBK4Djrxwk9Ey5sSMHl8SN+bQDSvMbKRZwPNDYnzBcBJiEUgzo0jwG0UN6CwfZITtbqooPU=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MN2PR05MB6352.namprd05.prod.outlook.com (2603:10b6:208:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.12; Fri, 8 Jul
 2022 08:08:46 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 08:08:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Barry Song <21cnbao@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "guojian@oppo.com" <guojian@oppo.com>,
        "huzhanyuan@oppo.com" <huzhanyuan@oppo.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "v-songbaohua@oppo.com" <v-songbaohua@oppo.com>,
        "will@kernel.org" <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "zhangshiming@oppo.com" <zhangshiming@oppo.com>
Subject: Re: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to defer
 TLB flush
Thread-Topic: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to
 defer TLB flush
Thread-Index: AQHYkgCLdJdNZ9epGk2/QG4z7TdV4610BjCAgAAGeYCAABM5gA==
Date:   Fri, 8 Jul 2022 08:08:45 +0000
Message-ID: <EE0C38ED-A213-4F5C-9F87-FD90E5035C21@vmware.com>
References: <67943544-6DAA-4C8A-A04D-029D2D36C318@vmware.com>
 <20220708065957.3859-1-21cnbao@gmail.com>
In-Reply-To: <20220708065957.3859-1-21cnbao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15d07a4d-9bf1-4873-d7f3-08da60b914a4
x-ms-traffictypediagnostic: MN2PR05MB6352:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xsg/45iZqqlJkPv65obi/tH9WwCQCrijjv2g7LCHobbejZYDBWXG15yzOHpj6u4qzN+gyf3REbgAVvM2UIFKM9Vi8uDSUtu+JYDJAFIO1yd6h/jn+uexwK/upCP7WlHAHS3s4rE7hPAXQg/3hAsu2AG1mLrmJSwEfXpWxYK13faCnKTha9+dyXWgUoAJju158RHPVbbUkaqGjnxPCoAfobqGe8zotK7kHLC4dM7ZhgJwi36qreB7zLVxZYP0Y/+/Ia2qUKU+f4Arc0IpMugAiwbz2WaHS2V6s0tFaSF09uBqAz1thNPJEqPNbMfXzzd95Lr5Ctu0uuA+6nrTOeeHEwNXd9SiFzo+HNMSdOEpFVCULwS5TwLhwvoawekk/wRD24N2keqmWEDgvYBGtFbr2nZztqMGPUZ2z/bJ7LK5lIZ/51+0RKqI+A1Y2rzC0meEUXfKOulmyYWj8Rcx3DytZbdf5TUuWHPygy+M8SJFOuDhbv2S8eZux1rHHgp6CbdJ+N6Dvt0ePDTvRYL58AdKt/QH70FR1PdFiiMDbq6uX05llXV6sZFTpPRlSQCfKEXYtVQNUVD8h6Hn3Y5rwkIlcj5r500OXLr8bwXtxhPl5j0ccrJUD0ScgCd/V+9XhB1mF8t1J12Wr/KjEgOQNkToq/PsJ3b5aOyJcqeHQskZqqlb72Fwg/5TQk8UiCoCry+fwuIqd4R/RZ0puUGQEpSehcrG/1VcVgKMVdCsSegdjf69R6hxcDahwx/cuDL+dffcfiBDdgXQeU8Mzw4pOtnEqwuPqPiCxNZbxZmd00V/FXBAIi9X4juD/Bxd0sSfPAJA3oZFnjWoe/DDHv36XFWA4KwO6ykn1VVsJJlQteJU9sKCwtT6HA0WJ+WU8OqAVssmO0M0pWNO3S9d+a7FBrAEkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(71200400001)(41300700001)(8936002)(2616005)(38100700002)(86362001)(6512007)(478600001)(6916009)(316002)(66946007)(5660300002)(64756008)(54906003)(66446008)(66556008)(38070700005)(4326008)(8676002)(66476007)(53546011)(26005)(76116006)(7416002)(33656002)(83380400001)(186003)(122000001)(4744005)(36756003)(2906002)(6486002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elp3VUNFZzFGbFppTlVNOGJYY2JRUmxsbGVZSHk2dGdhd2Y5aEdSUWNUeG05?=
 =?utf-8?B?aFlEWUlSVlJia1RyT2laaVNtTGcvV2FOWVVZL2xEMy9BUDAwWXZVZGJITWt4?=
 =?utf-8?B?SGtTVlJ2cDBNaU0zaEEvQTdWS1VzUnBQN3JhNWxMNHd4ZCtrSFZBS0R5RW5X?=
 =?utf-8?B?ZWRJcDFaTjFUbDRrYU1LOGI4SHhHRUtBU1pnSndDdmM5eWhaZlZocGJNc1R1?=
 =?utf-8?B?QmNFMFpPSG1OU0V5ZWY1S2IwemNseTFHSU1tVEJhMEs3Y1RjVjZKbXJGdWxW?=
 =?utf-8?B?VzBZY3RaRlhPQ0ZVZWU3dm5tVFhtbVdNbTJrWk9reTNLYVNTVXBITGN3YlRQ?=
 =?utf-8?B?R2g0dlpSMlNXWXByREFqa1EvcS9ZZzVVVUoxWjA0ak5keFZaNUowT0FWak1S?=
 =?utf-8?B?eGIxOW1UU25nRzVyNTlSV29BUDNVZTNqbUdxTWNuOXNQTEdxZlRENUdHUS9H?=
 =?utf-8?B?cWdxNTM0b2NwY0swTldDTFhTZnp3Ry82SHhjaXAxUXVqZmlIVkZTTTVjUGFT?=
 =?utf-8?B?bUtkVi9xUC8yL0VIV3pxcVBxSllEUWwvUFg1TVJ1N0UvNU12S0M3d1poQzFZ?=
 =?utf-8?B?RFIrZVhST01zL0szY210dmdibmE4QkdHSmRORDdMYlRiZFd5V0REdnZoeDIr?=
 =?utf-8?B?TzdVY2dvSDFZOXpXYVJ2WHdHam12NmVRWSsxcDVDcHRBY3JYNXdRaktpV1JI?=
 =?utf-8?B?SzV1MW9McU93VExzNSt4WVRFSXI5STl5eFV3di91MXFrUW95SUh1THU0dldR?=
 =?utf-8?B?eTJIOWM1OTQzQ2xvcW5ZdXJPVmExNE5oZmpsNEs4UFBURWxaZUYxbU5DMTJV?=
 =?utf-8?B?a1FOY2pmNGx3cG9NVEdLMzF6bG9qbHpLWXVKMXZFTzJjRUUrZ0UxOGZ1WlJB?=
 =?utf-8?B?OExpb3hyK2ZzZ25ScUxzUytHRTA3MmtCZS82MzVtU1ZHVnBkcjBHdzZhMFFy?=
 =?utf-8?B?OEJxZ1dVckh0SEUyc3dMdWgvNlZrZHd2SmpHd2FIOHNBeXVOV0hsMENXV2pL?=
 =?utf-8?B?L0k0Uzh2VHd6QURSWVFnd0JTL3JpMFF6N1Q3aytyY1dvY0tzNHhpbHJrY0Qr?=
 =?utf-8?B?TncvYWFBMDMzcms4Qi83QUgwRitOT0xmdTl6RWZDNitUcmxUSEN6WVcrcjlN?=
 =?utf-8?B?Lyt1V3ptNFJNOU5CNVFJRU11N1JLMjdvb0RSODhRT3pPdGwrNnU1K3JjeDFK?=
 =?utf-8?B?Q1YycG1XdkJrYlBaMlg0K0JOL0p3WlNlT2wxbGNlbUVpbWphbEJ6SC9DK2xY?=
 =?utf-8?B?cFdibHUrT01lVWFXSjZGYTY3OUt4MVk3OU5DU2ZtdC9GaWJndWtaVm53VW5J?=
 =?utf-8?B?bDN0YlR1WDF0bjd0Y1FEWDBDTGhJQjM3V283UWUrQmg1Y0hvZUdIZDlRUk1P?=
 =?utf-8?B?RHBjcDVvWU1aOGZ3UVRnVStmaVRPb01QcUZ5ajhHdldBUC81MnU4T0NFODcw?=
 =?utf-8?B?cjNXUGVDMEMveFhZeHR3NTM5d3kvWm9nckdEVmZHeUdYVFJjdkZaTjFxSkRh?=
 =?utf-8?B?UFl4NjIxR1VJOWRjblFOYW5nMFBHblNrMjU3STdtNzNzK2laeXJHckJ4ZkU3?=
 =?utf-8?B?Syt2RjVEVWIrQ2Y3Vkt4b0wzV0M1akt5ZTh6TWJnVTRac3ZjTExkb24rc0JI?=
 =?utf-8?B?ZUF5MDFYWWg4NVhZZTlNZzlNbmorZzF4cisySHdqeGxiWmdFUU4zcS81UUtx?=
 =?utf-8?B?bk9BZkVmODRYV2RObUw5aHZ1alI3ZVJXMTA0K00yUVJBK3plQkp2OEgwSE45?=
 =?utf-8?B?Sy9zSjhiUE16MUJEUVBNZncrajlXM0VPTWRJeXJpNXljU2JwVTFWQkxQYlVI?=
 =?utf-8?B?aysxWlpPK01WeFlkT08wNTVRNlFzc3BMT0JOdFZqSnovZ1Q4dSt4QmdTaWs1?=
 =?utf-8?B?TmhRMXI1R0ZKc0pTemR3SWI5ZFB1N084dDV3Y05oMzFYVE5KZVo4NGgvQ0ZS?=
 =?utf-8?B?WjlyaW9ybXBSR2lRcnRGMTV3QVdSZmtDcUdaajFoaTg5bzNwRjlYU05VTldC?=
 =?utf-8?B?QjZZM2Y5bHU0blg0bXZaRHY4Z2JZYUlYSnd3QUppaThobkMwMVNUWklvTXVq?=
 =?utf-8?B?QzN5NVpXVFJTeUo4ZmUwWUluMU9EQU83NDNjS09kRDdrYTluNDNKcytOUmt0?=
 =?utf-8?Q?vjWdxxecWcVKuaiXiFPO5yCGh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B9A716C8780444EA17CE7F601A992FF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d07a4d-9bf1-4873-d7f3-08da60b914a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 08:08:45.7441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CW/D7aLmHn4gs9PlQVOxs5Uep/MuVGBKsNArv1fyIfitJVo21dAuocb64Ti5xI1SbyT8T6zhasIuEK7V9QXbsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6352
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDcsIDIwMjIsIGF0IDExOjU5IFBNLCBCYXJyeSBTb25nIDwyMWNuYmFvQGdtYWlsLmNv
bT4gd3JvdGU6DQoNCj4+IFRoZSBjcHVtYXNrX2VtcHR5KCkgaXMgaW5kZWVkIGp1c3QgYW5vdGhl
ciBtZW1vcnkgYWNjZXNzLCB3aGljaCBpcyBtb3N0DQo+PiBsaWtlbHkgb2suIEJ1dCB3b3VsZG7i
gJl0IGFkZGluZyBzb21ldGhpbmcgbGlrZSBDT05GSUdfQVJDSF9IQVNfTU1fQ1BVTUFTSw0KPj4g
bWFrZSB0aGUgY29kZSBzaW1wbGVyIGFuZCAoc2xpZ2h0bHksIGNlcnRhaW5seSBzbGlnaHRseSkg
bW9yZSBwZXJmb3JtYW50Pw0KPiANCj4gWWVwLiBnb29kIHN1Z2dlc3Rpb24sIE5hZGF2LiBTbyB0
aGUgY29kZSB3aWxsIGJlIGFzIGJlbG93LCByaWdodD8NCg0KSG1tbeKApiBBbHRob3VnaCBpdCBp
cyBsaWtlbHkgdG8gd29yayAoYmVjYXVzZSBvbmx5IHg4NiBhbmQgYXJtIHdvdWxkIHVzZSB0aGlz
DQpiYXRjaCBmbHVzaGluZyksIEkgdGhpbmsgdGhhdCBmb3IgY29uc2lzdGVuY3kgQVJDSF9IQVNf
TU1fQ1BVTUFTSyBzaG91bGQgYmUNCmNvcnJlY3QgZm9yIGFsbCBhcmNoaXRlY3R1cmVzLg0KDQpJ
cyBpdCByZWFsbHkgb25seSB4ODYgdGhhdCBoYXMgbW1fY3B1bWFzaygpPw0KDQo=
