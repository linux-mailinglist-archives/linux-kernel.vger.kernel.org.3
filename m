Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21859D082
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiHWFd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiHWFdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:33:50 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90058.outbound.protection.outlook.com [40.107.9.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB07165B5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bglYURL7FQNZFpebWtIkTurIzQICv9UW4pMy1pWN0wmdO/EDh5Ozve8EJc+V7g5U15qnzWzt2/TXw3xkhZ2ZA//1fpZH3eWpGGSV5Z3S7IT3+Z1n4w30lgtUk62jYObTu7fZkB8Hg28VQRESWdswQ0lSdj1kNK/KNK80zNXcoV65BaAEBaFTnB0NeTNiN5pknHdCwWmWiOiCEURY9DRqnoq2jWQ0VCZaQ9hbcbCIF36wOEfw9BMuJ9ATtpoy42eS9Hgmw12sBqGnGP5RAgrODxxKGAbJTXBG+JWD3U5twJAQYEQYd8Nev/X7+FoOw/2BzgVJ9lWK4ISxBQphOBPqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DjvQNPQIDLhhEbbdUs6WZtrYf4oK22FFhTUtMecEYQ=;
 b=kJGWbDGSMdew+l9CM30hDjF7fOEpunQDamQZPR2OnWZW+IK+LZLOD7liY46bTK3ayM005MV4iQB8BZ+HzYCZYPpxFhNzeRw0IClSnYcEKALf3+dyBx3X+p+5cjgGvZHI65aUmUf5t8XLH6Mced5fK1AqRfZrzhWjcmMj40fbnPKycRfYo8mHoBC2Aoosa2/6n39QXIEWAJjl8zwFZDe90yUcq70QVi4bRzimV3bgqJiTxER7taiAqq+BztIHRrS6zXJ33R1NvdJVEpOrX2Ymj+qRffM6ofgRlxmZ4Aa6hL7QpPGRi/XI9MUflm+92szz0qjs38gjKG5wNqGxL/n2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DjvQNPQIDLhhEbbdUs6WZtrYf4oK22FFhTUtMecEYQ=;
 b=W5FcOoiaUUTVWngIhbDx8o1G9oRPM9c4E3OrM2DXotnmncDHNDOJ1fTuW2ty6SjS8kG/7XAUzjrfkj3ouqBj33cOZuCH4iwkHXS1DMSd7wRzcn3LCRLRDdH1dyj4lLMO2npdIASQ90E0SjCSuTWNHif6VSjWFcxeD05lt8mNZYFzvz0n3xfePtU/3xIf0MxgMSUuMri0GK4KamnsQ2Dg1RuCH9nSC0xDHaeuNz1E1LJMMpVIfHMGvNmjXQ7ftMSJ+/8tST9NdBD8bhprYiSKZ3iqQXWWu2z8tdkS43eYTnm+/TeIEvUL4T51py3MYfVrLyY12XXbZSlnFpIcvodQqg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:16::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 05:33:45 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 05:33:45 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and page
 prot
Thread-Topic: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Thread-Index: AQHYtCx+rO/zUftR00aLhjCOF9ttT626eSKAgAE7M4CAAEcjAA==
Date:   Tue, 23 Aug 2022 05:33:45 +0000
Message-ID: <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
 <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
In-Reply-To: <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47ed41a4-87be-4de3-b8eb-08da84c90c74
x-ms-traffictypediagnostic: MRZP264MB2006:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qAZIlbxLWxPPehPLPtsZiGEIX6BbvVwvIqq1AIOfCgGWZ3AoYMhYgpwdbtiHPzk6iAozcOXUInqg795Elogcl5u+lM9e8mbU3JGxHOVnZoh8kHZbYxnhOiGkLpDjHRTJwmRV9/ScELgvButyxoJDCh3TwYvxS+YaujKo3Dsynw7516WmM1TALb8Fk5CZYg8+hV2HMfl96MnFvWiM2/3JIbUebTCuf4iTkdqOa0jZh4KmkoCsszNNw/BRBgtBlMw0qFR4iNyESIB5HrrgPnnsCmfZwpM6GoUCoXF1wlte/eBhNQuWigLXUXajQVoBKRpTO1pMeIAz3/ggVJNNxauwVrX4el2YpS04U7EjFABLW8O5MhuQCS+nhFRp16Re3muAFouznyPM1exIl8dXC5GZzEopyqqF/uKvVWXjBycIWqqP3nqRmzjPGcx7RX0FuodP4Et4wZsEAIqSNPi6ymjdMp4nMNwjhxB7wUZbWuesvhyeJv4kq62LQNsmU1mi2aACZEFd7xt1/4B4WByjttEMt66FohACWxZN5/gqjUaOglRSbPDOERSjflcgDj86NBK24h2W/0HIQ9TBD08+2qpEg9kTef84ndjQvm6SSzIGJfINLW71sH0akjNFa/tiXwKM1iCr0wXLGm7kquDLSwWNmwPcWd8M5PkcxRDqZ0wklNvC7H115osv6sK/qpDYR2XvPVSX4mAdmsNupFrN3EomGIHHqR7CClBlpOCsdvXqFDPas/GxWxUkC9GVcICPFB6cVcPL7W+0p0r9/bRsekEdhi8nmNbPjepUsjSoJY27inaPFxk50lj8wHMbiCAMF8SUJre08s09GhWFQoa+P2aarEywDRaVD7+rUoXX4sm2fnHN+WZLA8QgfgZKO8y89/Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39850400004)(376002)(346002)(366004)(8676002)(66556008)(66946007)(91956017)(76116006)(66476007)(71200400001)(64756008)(31686004)(44832011)(8936002)(316002)(5660300002)(36756003)(6486002)(54906003)(6916009)(66446008)(4326008)(6506007)(2906002)(26005)(41300700001)(6512007)(186003)(478600001)(66574015)(2616005)(38070700005)(31696002)(86362001)(122000001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZVa1lSTWwyb1JuSUF3QW1ncThDaUtQNkx2cElLWThEdzRKck16VVlJQkk2?=
 =?utf-8?B?VmNhVjliQmp0SWZBa1FHczdGb0FSRkZaWGpwVVYvM2p4NE1NQ2FqS0VIckha?=
 =?utf-8?B?VXRKWWFmWUFyNTdqZEdoMmo3K2J5T2tqQlFGL2RUdmRmMFpNcU83cGZqTmlk?=
 =?utf-8?B?WFNRNWhscEh2em82ZFo3aTZ1TnVrWTZNYUJPZVgwWVRydGRUc1orc0l4YTU5?=
 =?utf-8?B?Q1VUbksxS2ZrbE81Y3VzTlNpSWFVMzdwQnpOS1d4aS9QNTJJN3VRY25mLzli?=
 =?utf-8?B?QkFQejJXdUpvMVpjc0NOWDRIYk5SZzE1VnllRFNrVTVZMGhxL1RMdlUvaXBv?=
 =?utf-8?B?SXFOeGhWVDlVekJVa2gwMFRvNDBxekxmeXJKclNnSXhHanJwejd4WCtQczdu?=
 =?utf-8?B?dHJUejkzTDRTL2ZQUUgyZk80Nm1MS1FicFhVelU1SUZKTVlaNUhjZ3ZpMS9y?=
 =?utf-8?B?U3I4RkczN2dvRHZ1Vm1sakV2d2llelZDLzZCQWJoNWpUMVIvQjdXajNvWW9a?=
 =?utf-8?B?NnJpTnhxc2FxOTFOWDgybVNDWVZBajliNS9iSVBmTWlkZ21nNnRkT2ZJWVFu?=
 =?utf-8?B?dkJMWnk5empvelRQVkY5M2g4UjhZM1FDY2hkT0xuSVFFdFFRMDE2Q1h1N2RZ?=
 =?utf-8?B?YVZaOG9vbldUQVE3TFRtNFh0VklGaTQxNUdkU2NGUVNJSGpMSDkrMlk0c3NB?=
 =?utf-8?B?Um44REk4ajJ3TE50dkF6bTVWN0JXd2ZudUttaVJObFc4eDV6ODBMV3NxbWM0?=
 =?utf-8?B?QkY4dkllOElrdWk3WG83cllUZ2xwTEFkTkdJaVJCL2VtR1IyTFk0RVZxTkM1?=
 =?utf-8?B?VkhPSHhDdDlmNnpIMCtrMXhPNjVmTWhxQXJVbG5GNjhOMTdDRFVMMkEvWkQx?=
 =?utf-8?B?a3FhdGZtMjBHOEtZNzZic3MyZFJBdzVMdCtzSXRaZFFvR3BHMVRRVXBRQXBz?=
 =?utf-8?B?UWZtaE1MNFRCaElzTzFtMHRqaWNTbG95OG41RkNyNjVqVmtmRDIvbUJxSGpy?=
 =?utf-8?B?N1lOQWQzQm90eDMxNEFrN041OEhTY01SeTRER0JveG1BOGQ2cnFXRnoyaTlQ?=
 =?utf-8?B?cU9tK3FOTTZUb2V3aEJzSUk0QXVwRXdmY3JaZUxIaEhTTEJoQ08wNFd4OEY1?=
 =?utf-8?B?Q25jNkNyano1bFRPcmZEbGxqOTJxTjFxQ3RMWXFVVUgwNXcvSmE2LzdHbXFz?=
 =?utf-8?B?bExqeHROQnBDS1poYi9BOUQyZ0lWNVNLOFRtVGlLMUE3TlNKODFXK0plMXhY?=
 =?utf-8?B?S2RqU3JMeFEvUUVmajhvbnlFaUxKNnBzbmVxeXhDdlhlODZzUVJSdENPQW1Y?=
 =?utf-8?B?cTV5MXFXZWpqZlI4UlUxR3ZFYlFWTTVJazdzemtYZnhYbm42eWJwUWFXcis5?=
 =?utf-8?B?Q1k3eklybmZYS21ZRzBQd0h6aEhLdFhjN3E2NkdTMHlVTU1NeWllSnBtd3NM?=
 =?utf-8?B?N2c1UkN0aUU0TmdHVmFSUUhtVGpIckJIWVpJY2hvSDBqQU0rWHFCOXhuWVVa?=
 =?utf-8?B?NVpEcFJZajduWTVHYzY1aW9STFBiZk5mZ09tdk1SQ2w0NTZqZGJRbVEwSVh4?=
 =?utf-8?B?cjFxdERZdnBTZ1Rzb1VwakhzSUVuZ0Y4c0ZsQmE3TlpSdklXL1hpNDNZaVBu?=
 =?utf-8?B?VSt2QSt5ZU54V0FmMUpnWWJESlJVcUZIc3dNUTduUTd2SzJEM2p2WnUvcXFk?=
 =?utf-8?B?Um5rWkRhYVNrcUliMEhBQWExSU1GRlNCbjFwYk1KcmtraWkwTGxYUWJ4QnBY?=
 =?utf-8?B?OTA5NlZNWG1mMWEvK1plTTB2STRSelFYeGRIcG1KQzhXQkg2VTNwV3JaQjdD?=
 =?utf-8?B?c0MxQWxrMmdpQXh5QVc5YzJYUDVoM1lZM2pLSlJ0T2UzVFpoSEUwNHFKTFJO?=
 =?utf-8?B?TVh1a3VoSGVkK0NGYnQ3QjNIWWNjWSs1bFZoN2NQWXFtZlFHSnoxcXIyVjBu?=
 =?utf-8?B?ZkdBcUVCTzMrNHpZNmtLWWI2RFdwYUFJd0hScXphdnlGWHBXKzd3d2RobDYx?=
 =?utf-8?B?bCtLT2pscGlieFkyVFFDdGJpZ2s3ZlFNSTI3UE9EUlUzb0J1K0dqQ0NNRkY5?=
 =?utf-8?B?bERoTTNoSi9kNkJxVkY3anFCVCtyVXc2SEdqZCs0Qnl3MW1EYWdHeHh4QUVN?=
 =?utf-8?B?Q0VQOVJCM3hGd2EzdXkwdmd0U1NiNE5PdEszNy92UEFJdENlL2tKc0l2SzZa?=
 =?utf-8?Q?xrinAeDmCWG55x4Qrak7lAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D4E0E28EA842C438F09BE49B944EFE3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ed41a4-87be-4de3-b8eb-08da84c90c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 05:33:45.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIt2TYhSvdSIqXXTHJUIGYiAUj6qMWoe5i7kwvlgcw17nB6zCGMdFm2LpWkBkiVvjADRK6srRqqJhvgvYwc/kuit4I7VOqqJW8+0wDUR4LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA4LzIwMjIgw6AgMDM6MTksIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gT24g
MDgvMjIvMjIgYXQgMDY6MzBhbSwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+DQo+Pg0KPj4g
TGUgMjAvMDgvMjAyMiDDoCAwMjozMSwgQmFvcXVhbiBIZSBhIMOpY3JpdMKgOg0KPj4+IE9uIHNv
bWUgYXJjaGl0ZWN0dXJlcywgdGhlIHBoeXNpY2FsIGFkZHJlc3MgbmVlZCBiZSBmaXhlZCB1cCBi
ZWZvcmUNCj4+PiBkb2luZyBtYXBwaW5nLCBlLmcsIHBhcmlzYy4gQW5kIG9uIGFyY2hpdGVjdHVy
ZXMsIGUuZyBhcmMsIHRoZQ0KPj4+IHBhcmFtZXRlciAncHJvdCcgcGFzc2VkIGludG8gaW9yZW1h
cF9wcm90KCkgbmVlZCBiZSBhZGp1c3RlZCB0b28uDQo+Pj4NCj4+PiBJbiBvZGVyIHRvIGNvbnZl
cnQgdGhlbSB0byB0YWtlIEdFTkVSSUNfSU9SRU1BUCBtZXRob2QsIHdlIG5lZWQgd3JhcA0KPj4+
IHRoZSBhZGRyZXNzIGZpeGluZyB1cCBjb2RlIGFuZCBwYWdlIHByb3QgYWRqdXN0aW5nIGNvZGUg
aW50byBhcmNoX2lvcmVtYXAoKQ0KPj4+IGFuZCBwYXNzIHRoZSBuZXcgYWRkcmVzcyBhbmQgJ3By
b3QnIG91dCBmb3IgaW9yZW1hcF9wcm90KCkgaGFuZGxpbmcuDQo+Pg0KPj4gSXMgaXQgcmVhbGx5
IHRoZSBiZXN0IGFwcHJvYWNoID8gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGhhdmUgaGVscGVy
cw0KPj4gdG8gZG8gdGhhdCwgdGhvc2UgaGVscGVycyBiZWluZyBjYWxsZWQgYnkgdGhlIGlvcmVt
YXBfcHJvdCgpLCBpbnN0ZWFkIG9mDQo+PiBkb2luZyBpdCBpbnNpZGUgdGhlIGFyY2hfaW9yZW1h
cCgpIGZ1bmN0aW9uID8NCj4gDQo+IFRoaXMgaXMgc3VnZ2VzdGVkIHRvbyBieSBBbGV4YW5kZXIg
ZHVyaW5nIGhpcyB2MSByZXZpZXdpbmcuIEkgdHJpZWQsIGJ1dA0KPiBmZWVsIHRoZSBjdXJyZW50
IHdheSB0YWtlbiBpbiB0aGlzIHBhdGNoc2V0IGlzIGJldHRlci4gQmVjYXVzZSBub3QgYWxsDQo+
IGFyY2hpdGVjdXRyZXMgbmVlZCB0aGUgYWRkcmVzcyBmaXggdXAsIG9ubHkgcGFyaXNjLCBhbmQg
b25seSBmZXcgbmVlZA0KPiBhZGp1c3QgdGhlICdwcm90Jy4gSW50cm9kdWNpbmcgb3RoZXIgaGVs
cGVycyBzZWVtcyB0b28gbXVjaCwgdGhhdCBvbmx5DQo+IGluY3JlYXNlcyB0aGUgY29tcGxleGl0
eSBvZiBvZiBpb3JlbWFwKCkgYW5kIHRoZSBnZW5lcmljIEdFTkVSSUNfSU9SRU1BUA0KPiBtZXRo
b2QgZm9yIHBlb3BsZSB0byB1bmRlcnN0YW5kIGFuZCB0YWtlLg0KDQpJIGNhbid0IHVuZGVyc3Rh
bmQuIFdoeSBpcyBpdCBkaWZmaWN1bHQgdG8gZG8gc29tZXRoaW5nIGxpa2U6DQoNCiNpZm5kZWYg
aW9yZW1hcF9hZGp1c3RfcHJvdA0Kc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGlvcmVtYXBf
YWRqdXN0X3Byb3QodW5zaWduZWQgbG9uZyBmbGFncykNCnsNCglyZXR1cm4gZmxhZ3M7DQp9DQoj
ZW5kaWYNCg0KVGhlbiBmb3IgYXJjIHlvdSBkbw0KDQpzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxv
bmcgaW9yZW1hcF9hZGp1c3RfcHJvdCh1bnNpZ25lZCBsb25nIGZsYWdzKQ0Kew0KCXJldHVybiBw
Z3Byb3RfdmFsKHBncHJvdF9ub25jYWNoZWQoX19wZ3Byb3QoZmxhZ3MpKSk7DQp9DQojZGVmaW5l
IGlvcmVtYXBfYWRqdXN0X3Byb3QgaW9yZW1hcF9hZGp1c3RfcHJvdA0KDQoNCkJ5IHRoZSB3YXks
IGNvdWxkIGJlIGEgZ29vZCBvcHBvcnR1bml0eSB0byBjaGFuZ2UgaW9yZW1hcF9wcm90KCkgZmxh
Z3MgDQp0eXBlIGZyb20gdW5zaWduZWQgbG9uZyB0byBwZ3Byb3RfdA0KDQo+IA0KPj4NCj4+Pg0K
Pj4+IFRoaXMgaXMgYSBwcmVwYXJhdGlvbiBwYXRjaCwgbm8gZnVuY3Rpb25hbGl0eSBjaGFuZ2Uu
DQo+Pg0KPj4gQ291bGQgdGhpcyBiZSBzcXVhc2hlZCBpbnRvIHByZXZpb3VzIHBhdGNoID8NCj4g
DQo+IFllcCwgd2lsbCBkby4gVGhhbmtzLg0KPiA=
