Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7053C52E518
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345886AbiETGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiETGei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:34:38 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2042.outbound.protection.outlook.com [40.107.113.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F2A14CA0C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtkQgkF0sPsm0E1tpeRGQ5vXnHSnrLax4YtJq/BDHNAj9rSeTFxOuB+c4ATsUdiFI2oKFyCplDqGESzZYLJG0CON5d93wsZaeOMYzfwPPcyMvA8mauXoKpxSuZq8lACKLx+Me0xdQYEo9Y3J7s9QguR6KViKf0xtmMLRNv1J4/BSSc7bMWIGQEHgHn5hQST7IiZGLv9w1tRkfAhyi6GKXNTSypNl0zcIgDseNrhd5rSzL0B/ctnC1O5at9Gms9A2SLPi6MCfEJvr9egvzgZVvki+n6iFUPk46ZgYX8DL44pB34vnCcklu3+SJaROZ356unXP/rkv8UsiqQTlwQe6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jm7m/TabcXwplh76K02GChgwCzfihRaLidWhUNhaWc=;
 b=dghNXukC61UhFepjgp4M9SYaCKihKtbIxdJTd/b+zRU0FE7occnL+tQ8aDyr77wbfwktisEkZ1cufbG/6vxuvdLMsmmGifTh1dpZQsawY5UH/urknHVHpas96pbhX3neCghu4tkb5lBVuZUQZdteTY8qmWqOzH+g5WL84PvMrYV0MEWbjZflNT/A0dcGk08N79b8coev/tXhdY6+stJgR3t4svT0puu7fb0PZqQvXDoG1ip9FrzHtNjogfqb3eYGtT+5pzQ8RlvcY7VeGanazqMfVD5+lq3cP70p42AZO0DidDI4xd3XivjqBJqnRVTQJ89NszhzYximY1cdrk0kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jm7m/TabcXwplh76K02GChgwCzfihRaLidWhUNhaWc=;
 b=Qy0hof6SyevVTy3XYYruDCHvYiyHC1zx9le3a/mlAo2KP1A9AIvekNHV3karStubB+O/QEzznQUyrqrdN3SElITeVxC0Gp4oWdcuT0qIX6NCuCXA+w0aPYO/Nge7Ax4UNTxsA9iQnLbKlb4o20YHoT3SQKLO3qUliYQ9TFoLjR0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB8114.jpnprd01.prod.outlook.com (2603:1096:604:170::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 06:34:34 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 06:34:34 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Thread-Topic: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Thread-Index: AQHYa38Hnv+yD7ocokSyVBX8dxzd660nUFeA
Date:   Fri, 20 May 2022 06:34:34 +0000
Message-ID: <20220520063433.GA584983@hori.linux.bs1.fc.nec.co.jp>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
 <20220519125030.21486-5-linmiaohe@huawei.com>
In-Reply-To: <20220519125030.21486-5-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8ee5b50-61db-4b94-1793-08da3a2acdf5
x-ms-traffictypediagnostic: OS3PR01MB8114:EE_
x-microsoft-antispam-prvs: <OS3PR01MB8114676546680F6727767231E7D39@OS3PR01MB8114.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1kqK361MrbQMJTSctgKWARN73JUsRn+9T5oSqZ8Cl642VUyribRpAtBJ4EEsnPcQovjwu+qS4oePsjkS0OxwEpUeCKGqTLD8qqdXXuH3mVD7wCZ4m+PiM9z+34QIp3WJ4oQfheqd8DlPeQPaKAyox3upuN1igc7OZPVxe3Q/G1I6vHAtwT2yocRs4zFMCxwfapb9ZyrhihjojjEvspHNSPGhcXIYy89B0RCgp3qL/sTtL7h51fctfl5l6Wd5FitEfCeI3dNwml3n7tTIWKlDm58HUlAw87dKRA/jxw2CefsYXeOR5I0M+hkxoTcQJY2AUZTt/LbW9rHfGuZk43rIXclA6IaFeGAy1yDR02PSPMHwPIJCs2EU2hTPdrIigiO6qL80DVKTDPUtF0s7skgjjCbrv/+GhWV4+1/Fn3V0pCwDzAsGFm+NzycJu1uh9BrzmldG2obkjUH3lBxtgsi3AtdNEoFj0zSwCto0mTtXIaC1VQLO0zaAY+JSkMLRWzJ0pgQy/BcMyG4n3YI4a2KVwE9xAIKkYEkx3ZFPPr9TX9W75sKsA/A/UTH8igbQc4HErCTc45toR3+WSPi80enA1uBzWXeHoxMkP2GwjTOjWDEIcSH+uxxaosLIJU7Wyvk/m8+DCCIbyqBn/DpEqlJqB1shJMPcom5+rX+tehxHzZ3MBsWhmXmFQ5bG1CwWUclqohjVv6uJaX+A0cy9UEYqqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(6512007)(26005)(6486002)(508600001)(9686003)(6506007)(186003)(1076003)(83380400001)(85182001)(71200400001)(66476007)(33656002)(66946007)(5660300002)(38070700005)(38100700002)(6916009)(122000001)(54906003)(66556008)(316002)(8676002)(2906002)(7416002)(4326008)(64756008)(66446008)(76116006)(82960400001)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3AzcGpsM29INWtaQ1QxcnplVitaK2ptVUdqMm1hOFFFblV0UGJsbXBIRFZx?=
 =?utf-8?B?SmdUTnB6bHdRYXV3UUVic1dkNFYzS0tWZ0NaQmpka0RTdUUraFdGaExIWVIx?=
 =?utf-8?B?N28ycEdnSFF0MG8wdW9iWEpSNjliMnBSbXdvTzk5WmkrendxMm1STDJZZ3hl?=
 =?utf-8?B?cVhXdVd1Q2dsZmdXb1V4ajJ0U25uNE1zaEsxRXV3RUlGM284aUJmR3JMMHUv?=
 =?utf-8?B?NDJpZ0R4cGRHV0tsR0wvZE9ZbmQ4L2NVRTN5ZU04ckFNRDNzNHhCVWw0c0cr?=
 =?utf-8?B?YklZVkN3aUZ3d2gxVFVuYThzeWxwanZFbjlzYW1RMEg3ZFZIanVEVTUxVmtO?=
 =?utf-8?B?N1VzOTNWcThXNXpydHEvL21Tc3V4dTRCcmJhUFZTY1pqR1NTMTEyNVZlbHZC?=
 =?utf-8?B?Y2puT3U5bjlyd1VDeTRSekQxMDBZR25FaWVPTStaSVZzMGYrRjJKMjVOcER5?=
 =?utf-8?B?WlRLWjB2bGFUL2JnUkcxRExMcXhLNThBYmp1OThZcWR3dXlNdXZ5YmhpQ1Fn?=
 =?utf-8?B?QmFPUTBTbHNpYzhZcGJWdFpCRjZtcTdCbnNKQUUrNDNqK2U0N1Y1d0hWbmxL?=
 =?utf-8?B?QUpqaVBadjBHSlFQTzJyQjRVR01JOXAwcVJuZjNxdUZjbmI2bm5tbStYTUpi?=
 =?utf-8?B?cGdvNHh4UzBGa1F3NTl5VXlEODVwbkJmdUM3NnhaeU5IZzgyK1ZGbW8xRnkx?=
 =?utf-8?B?Vng0a3c0WmN1MXpqcDBBdjZ3Znd6amlGMm5wcUZCdEFxd0ZRcGdFRERjYWRs?=
 =?utf-8?B?b0pyT1R0aGkwQ3F3Tm1ZSjlXbzBCZlBhOVVjRHlKQnByOFkwWEZPMEFRZGtx?=
 =?utf-8?B?emVuemhqS1ZNb0d4bkZBdEVFOU4rSy9HZlgzZkJOQ2FmanVjWjI1RGRuNFhm?=
 =?utf-8?B?SXl3ZGtFbDA1SENHWmpOM3RVTHVxdVppZmdua0NXRm92TC9FRzRNMUw2aERO?=
 =?utf-8?B?dHErVzRHVXRRUnhLNTRGTHpad21wVjZqckp5c3JaVXlrOGx5OHlEcmF2aUhx?=
 =?utf-8?B?SEF6eUNNeXNkUTZQcFJzNWdpNnEzSGZGOHY5R04wWUV4TVI4WllJaWs3eVEy?=
 =?utf-8?B?ejBGdmpLek9kYlI0SXZDWVFkNG9VRWVpSFdnVVI3dVlUdWtPWUJlM0syTUxQ?=
 =?utf-8?B?cGwzOG9MeFYxWHIvZldQWUY2cE42dmlaV3o1bU5nWnBJN1QvSGdueWtjYzV2?=
 =?utf-8?B?aGQ3V05QUzZXdEJSc2E4eFRRaVpFQk9GSTNsbG9tTWJMMnZHRGVGMkVtbzk3?=
 =?utf-8?B?V1UzR1ArT3hYM3BQVE84ZVZ6MzlsWXFYK0R6NDBOeEp2UFhhVFRQYTZSK1pD?=
 =?utf-8?B?ZnZTeXk3SjNEWWljbVZMTHRybkExdHJXZ1NPLytsaTBnbDZoaUxsNXZGMU15?=
 =?utf-8?B?SFdYNjJpaFVSSjAvZzBPOUptSStCUlVxdThBbjRDTkpTa3VJZndyaVFVSFJz?=
 =?utf-8?B?VTBvV0haVkEyS2wwRThxNDZsaDdsYUxGdEFMTzZJMXJpcDF2N0hLUlpTUHJ4?=
 =?utf-8?B?RmNERjVWYnZ4eHc0azJLWml6NDdVMzJrNkpkcnFrUjRRY0hOSVp6TkhBSnZE?=
 =?utf-8?B?UzZhSk9ZZk9XSGNUeHFWU21qb3JxNytEUk9vNHNkZnpyNWZCaXNlMGRiakxv?=
 =?utf-8?B?bmZpT1lmUWNWMUdXS21aemlrdnZtbjN4RU1hdFJzUGl2VFNkY2M4bWlGSUcy?=
 =?utf-8?B?YjU4ZnFuWHdwTzhVYWZLTEF6N2VhUnZvZmJsd2tya3RNZ0R1eEtKbG1kaCtZ?=
 =?utf-8?B?clBJMEE3STNPUXBDSVpKSkpIcTFadWkvVWc0anlLdW5FekZJSmVxNHE5VzIw?=
 =?utf-8?B?YlVMYnoxYjcrallIUS9vQit0MWhqRkFhbStxTG5HVHhwaG1YeXBkWWd3dUI1?=
 =?utf-8?B?Rld2UzlqSHU2bm9zN1lmdVFBdFhJUVd5eE1PaG1PZzJObFhRdDB3RUdnb0J4?=
 =?utf-8?B?YXRKd0U1SjFJVEhCaWZtMm0xQ0hubkV2eGI5bHYzRUhhQVVKYVFkZUNZM1My?=
 =?utf-8?B?RlRIbEM4b09TQjZ1RUFqaU5wSU1lVmhZaSs1cnpsOHZrSS9CN0loOVl1V2Ev?=
 =?utf-8?B?RFRUd0FZNHdRVGlNZ2xhMXdxaHc4eUpQdFl0OGpBN1o1M2M0VGZGTkhUQ1R5?=
 =?utf-8?B?YzJGY1F6K3pPQVlXdVdmeXJpTlcrL1JXSWttVHUyZzQ2cW8ySTMzempmWEFU?=
 =?utf-8?B?WVF6T0c2cHNDNnljV1hWbnd0aUxRL2dLOUhzNEIycnJPRVpIWnMwR3p0WUhP?=
 =?utf-8?B?aGhFbklOaWJJMmdSUDJFQTFZL2QvSWZzWTBNWENFOUlRMHF5Z1dnNE0wVW4v?=
 =?utf-8?B?NmFmN0FSSnFqa0J4SXFBRnNFSnFLQWRwOVhFeDlkbGFQVitkZ29ZVkdUTHVW?=
 =?utf-8?Q?RLz16zUF1Gm7kEyY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <331B6EB2265D804F81EB65DE45878A9C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ee5b50-61db-4b94-1793-08da3a2acdf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 06:34:34.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpUTnXZfyx+P5oz2aNTWnO+E01HimRNwXw6iScp5GGBz/BDM3LDUymDclhrae8IA6xWbWeFzEamVTS5OhO8Etg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMTksIDIwMjIgYXQgMDg6NTA6MjlQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gV2hlbiBzd2FwIGluIHNobWVtIGVycm9yIGF0IHN3YXBvZmYgdGltZSwgdGhlcmUgd291
bGQgYmUgYSBpbmZpbml0ZSBsb29wDQo+IGluIHRoZSB3aGlsZSBsb29wIGluIHNobWVtX3VudXNl
X2lub2RlKCkuIEl0J3MgYmVjYXVzZSBzd2FwaW4gZXJyb3IgaXMNCj4gZGVsaWJlcmF0ZWx5IGln
bm9yZWQgbm93IGFuZCB0aHVzIGluZm8tPnN3YXBwZWQgd2lsbCBuZXZlciByZWFjaCAwLiBTbw0K
PiB3ZSBjYW4ndCBlc2NhcGUgdGhlIGxvb3AgaW4gc2htZW1fdW51c2UoKS4NCj4gDQo+IEluIG9y
ZGVyIHRvIGZpeCB0aGUgaXNzdWUsIHN3YXBpbl9lcnJvciBlbnRyeSBpcyBzdG9yZWQgaW4gdGhl
IG1hcHBpbmcNCj4gd2hlbiBzd2FwaW4gZXJyb3Igb2NjdXJzLiBTbyB0aGUgc3dhcGNhY2hlIHBh
Z2UgY2FuIGJlIGZyZWVkIGFuZCB0aGUNCj4gdXNlciB3b24ndCBlbmQgdXAgd2l0aCBhIHBlcm1h
bmVudGx5IG1vdW50ZWQgc3dhcCBiZWNhdXNlIGEgc2VjdG9yIGlzDQo+IGJhZC4gSWYgdGhlIHBh
Z2UgaXMgYWNjZXNzZWQgbGF0ZXIsIHRoZSB1c2VyIHByb2Nlc3Mgd2lsbCBiZSBraWxsZWQNCj4g
c28gdGhhdCBjb3JydXB0ZWQgZGF0YSBpcyBuZXZlciBjb25zdW1lZC4gT24gdGhlIG90aGVyIGhh
bmQsIGlmIHRoZQ0KPiBwYWdlIGlzIG5ldmVyIGFjY2Vzc2VkLCB0aGUgdXNlciB3b24ndCBldmVu
IG5vdGljZSBpdC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhv
cmlndWNoaUBuZWMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVA
aHVhd2VpLmNvbT4NCg0KSGkgTWlhb2hlLA0KDQpUaGFuayB5b3UgZm9yIHRoZSB1cGRhdGUuICBJ
IG1pZ2h0IG1pc3Mgc29tZXRoaW5nLCBidXQgSSBzdGlsbCBzZWUgdGhlIHNhbWUNCnByb2JsZW0g
KEkgY2hlY2tlZCBpdCBvbiBtbS1ldmVyeXRoaW5nLTIwMjItMDUtMTktMDAtMDMgKyB0aGlzIHBh
dGNoc2V0KS4NCg0KVGhpcyBwYXRjaCBoYXMgdGhlIGVmZmVjdCB0byBjaGFuZ2UgdGhlIHJldHVy
biB2YWx1ZSBvZiBzaG1lbV9zd2FwaW5fZm9saW8oKSwNCi1FSU8gKHdpdGhvdXQgdGhpcyBwYXRj
aCkgdG8gLUVFWElTVCAod2l0aCB0aGlzIHBhdGNoKS4NCkJ1dCBzaG1lbV91bnVzZV9zd2FwX2Vu
dHJpZXMoKSBjaGVja3MgbmVpdGhlciwgc28gbm8gY2hhbmdlIGZyb20gY2FsbGVyJ3MgdmlldyBw
b2ludC4NCk1heWJlIGJyZWFraW5nIGluIGVycm9ycyAocmF0aGVyIHRoYW4gRU5PTUVNKSBpbiBm
b3IgbG9vcCBpbiBzaG1lbV91bnVzZV9zd2FwX2VudHJpZXMoKQ0Kc29sdmVzIHRoZSBpc3N1ZT8g
IEkgYnJpZWZseSBjaGVja2VkIHdpdGggdGhlIGJlbG93IGNoYW5nZSwgdGhlbiBzd2Fwb2ZmIGNh
biByZXR1cm4NCndpdGggZmFpbHVyZS4NCg0KQEAgLTEyMjIsNyArMTIyMiw3IEBAIHN0YXRpYyBp
bnQgc2htZW1fdW51c2Vfc3dhcF9lbnRyaWVzKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQogICAgICAg
ICAgICAgICAgICAgICAgICBmb2xpb19wdXQoZm9saW8pOw0KICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0Kys7DQogICAgICAgICAgICAgICAgfQ0KLSAgICAgICAgICAgICAgIGlmIChlcnJvciA9
PSAtRU5PTUVNKQ0KKyAgICAgICAgICAgICAgIGlmIChlcnJvciA8IDApDQogICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCiAgICAgICAgICAgICAgICBlcnJvciA9IDA7DQogICAgICAgIH0N
Cg0KPiAtLS0NCj4gIG1tL3NobWVtLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbW0vc2htZW0uYyBiL21tL3NobWVtLmMNCj4gaW5kZXggZDNjNzk3MGUwMTc5
Li5kNTVkZDk3MjAyM2EgMTAwNjQ0DQo+IC0tLSBhL21tL3NobWVtLmMNCj4gKysrIGIvbW0vc2ht
ZW0uYw0KPiBAQCAtMTE3NSw2ICsxMTc1LDEwIEBAIHN0YXRpYyBpbnQgc2htZW1fZmluZF9zd2Fw
X2VudHJpZXMoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+ICAJCQljb250aW51ZTsN
Cj4gIA0KPiAgCQllbnRyeSA9IHJhZGl4X3RvX3N3cF9lbnRyeShmb2xpbyk7DQo+ICsJCS8qDQo+
ICsJCSAqIHN3YXBpbiBlcnJvciBlbnRyaWVzIGNhbiBiZSBmb3VuZCBpbiB0aGUgbWFwcGluZy4g
QnV0IHRoZXkncmUNCj4gKwkJICogZGVsaWJlcmF0ZWx5IGlnbm9yZWQgaGVyZSBhcyB3ZSd2ZSBk
b25lIGV2ZXJ5dGhpbmcgd2UgY2FuIGRvLg0KPiArCQkgKi8NCj4gIAkJaWYgKHN3cF90eXBlKGVu
dHJ5KSAhPSB0eXBlKQ0KPiAgCQkJY29udGludWU7DQo+ICANCj4gQEAgLTE2NzIsNiArMTY3Niwz
NiBAQCBzdGF0aWMgaW50IHNobWVtX3JlcGxhY2VfcGFnZShzdHJ1Y3QgcGFnZSAqKnBhZ2VwLCBn
ZnBfdCBnZnAsDQo+ICAJcmV0dXJuIGVycm9yOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBz
aG1lbV9zZXRfZm9saW9fc3dhcGluX2Vycm9yKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHBnb2ZmX3Qg
aW5kZXgsDQo+ICsJCQkJCSBzdHJ1Y3QgZm9saW8gKmZvbGlvLCBzd3BfZW50cnlfdCBzd2FwKQ0K
PiArew0KPiArCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gaW5vZGUtPmlfbWFwcGlu
ZzsNCj4gKwlzdHJ1Y3Qgc2htZW1faW5vZGVfaW5mbyAqaW5mbyA9IFNITUVNX0koaW5vZGUpOw0K
PiArCXN3cF9lbnRyeV90IHN3YXBpbl9lcnJvcjsNCj4gKwl2b2lkICpvbGQ7DQo+ICsNCj4gKwlz
d2FwaW5fZXJyb3IgPSBtYWtlX3N3YXBpbl9lcnJvcl9lbnRyeSgmZm9saW8tPnBhZ2UpOw0KPiAr
CW9sZCA9IHhhX2NtcHhjaGdfaXJxKCZtYXBwaW5nLT5pX3BhZ2VzLCBpbmRleCwNCj4gKwkJCSAg
ICAgc3dwX3RvX3JhZGl4X2VudHJ5KHN3YXApLA0KPiArCQkJICAgICBzd3BfdG9fcmFkaXhfZW50
cnkoc3dhcGluX2Vycm9yKSwgMCk7DQo+ICsJaWYgKG9sZCAhPSBzd3BfdG9fcmFkaXhfZW50cnko
c3dhcCkpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWZvbGlvX3dhaXRfd3JpdGViYWNrKGZvbGlv
KTsNCj4gKwlkZWxldGVfZnJvbV9zd2FwX2NhY2hlKCZmb2xpby0+cGFnZSk7DQo+ICsJc3Bpbl9s
b2NrX2lycSgmaW5mby0+bG9jayk7DQo+ICsJLyoNCj4gKwkgKiBEb24ndCB0cmVhdCBzd2FwaW4g
ZXJyb3IgZm9saW8gYXMgYWxsb2NlZC4gT3RoZXJ3aXNlIGlub2RlLT5pX2Jsb2NrcyB3b24ndA0K
PiArCSAqIGJlIDAgd2hlbiBpbm9kZSBpcyByZWxlYXNlZCBhbmQgdGh1cyB0cmlnZ2VyIFdBUk5f
T04oaW5vZGUtPmlfYmxvY2tzKSBpbg0KPiArCSAqIHNobWVtX2V2aWN0X2lub2RlLg0KPiArCSAq
Lw0KPiArCWluZm8tPmFsbG9jZWQtLTsNCj4gKwlpbmZvLT5zd2FwcGVkLS07DQo+ICsJc2htZW1f
cmVjYWxjX2lub2RlKGlub2RlKTsNCj4gKwlzcGluX3VubG9ja19pcnEoJmluZm8tPmxvY2spOw0K
PiArCXN3YXBfZnJlZShzd2FwKTsNCj4gK30NCj4gKw0KPiAgLyoNCj4gICAqIFN3YXAgaW4gdGhl
IHBhZ2UgcG9pbnRlZCB0byBieSAqcGFnZXAuDQo+ICAgKiBDYWxsZXIgaGFzIHRvIG1ha2Ugc3Vy
ZSB0aGF0ICpwYWdlcCBjb250YWlucyBhIHZhbGlkIHN3YXBwZWQgcGFnZS4NCg0KKG9mZi10b3Bp
YyBhIGxpdHRsZSkgQlRXLCB0aGUgY29tbWVudCBvbiBzaG1lbV9zd2FwaW5fZm9saW8oKSBzdGls
bCBtZW50aW9ucw0KKnBhZ2VwLCBidXQgbWF5YmUgaXQgY2FuIGJlIHVwZGF0ZWQgdG8gKmZvbGlv
cC4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hpDQoNCj4gQEAgLTE2OTUsNiArMTcyOSw5IEBA
IHN0YXRpYyBpbnQgc2htZW1fc3dhcGluX2ZvbGlvKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHBnb2Zm
X3QgaW5kZXgsDQo+ICAJc3dhcCA9IHJhZGl4X3RvX3N3cF9lbnRyeSgqZm9saW9wKTsNCj4gIAkq
Zm9saW9wID0gTlVMTDsNCj4gIA0KPiArCWlmIChpc19zd2FwaW5fZXJyb3JfZW50cnkoc3dhcCkp
DQo+ICsJCXJldHVybiAtRUlPOw0KPiArDQo+ICAJLyogTG9vayBpdCB1cCBhbmQgcmVhZCBpdCBp
bi4uICovDQo+ICAJcGFnZSA9IGxvb2t1cF9zd2FwX2NhY2hlKHN3YXAsIE5VTEwsIDApOw0KPiAg
CWlmICghcGFnZSkgew0KPiBAQCAtMTc2Miw2ICsxNzk5LDggQEAgc3RhdGljIGludCBzaG1lbV9z
d2FwaW5fZm9saW8oc3RydWN0IGlub2RlICppbm9kZSwgcGdvZmZfdCBpbmRleCwNCj4gIGZhaWxl
ZDoNCj4gIAlpZiAoIXNobWVtX2NvbmZpcm1fc3dhcChtYXBwaW5nLCBpbmRleCwgc3dhcCkpDQo+
ICAJCWVycm9yID0gLUVFWElTVDsNCj4gKwlpZiAoZXJyb3IgPT0gLUVJTykNCj4gKwkJc2htZW1f
c2V0X2ZvbGlvX3N3YXBpbl9lcnJvcihpbm9kZSwgaW5kZXgsIGZvbGlvLCBzd2FwKTs=
