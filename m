Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01944F8C78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiDHCJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiDHCJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:09:35 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D988723ACAA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 19:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9CDhaeiFumtUB+S7NhqLelaINgFXv8lDHBDh81UAHWKn8APLlPkpHglQiywAVDmqQb96RLHSnmj50wMlmBImR6h7HoZiFSnUAJ9lF22Py0Xpp/IKyDQMwXArE6v82k2yLymDH0YYjn6xlz66Fr+jUHFHjPTIsHJyWyEvkrmS8bYdSaIu8Mbtc7V4KQT48ii32OLEgkOi3WpuLW3jSCXaSdIO0FO2ZyO6H0rVgZVoERTLcGBPVwWgsa0eGpNWtV7VXcK6Ew+yKwzz7SS0+mD+aoIQ8KHTd8eKhfruZkucnGYqc1/8t4n2L6yRof6Cv9mdiBl9s9wwGL5j/2JUZ27hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAlK5ngxZPrG1iK4pYPx4idLjdYt6L35ygxYzl57WK8=;
 b=Q27VqfIXq7K1v4o7z3BDYTFlBjtXnI4iHGWk+xvT7C6dXxc6Z3sLy9bcgVVevOiizZ4g5TyrBArx6h9CcbUUgRQ8kigLFvQ/CsbP5/toaqSc0Yt/oeSpe4lvFRAn/05dpcE/uZd9pvAtuy9pvFkBCdD/9eS9HfgUSL4Es6cQrsQ9PmdRadOgzq3bnLmB+jmp/JGGHCNYPWgjgGuR1tvfo4/nd4zJ6cqwCXDm/sE8Wg3SJqf1nIMIUCGtDw8l2McpJRfmtgxYYvGdCMJD85Y2hVSKXdhhD0YPnlLtmJncEh4qrIPal+djzad41FVegLUsB0/1Hf59r26JzWn6nNg4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAlK5ngxZPrG1iK4pYPx4idLjdYt6L35ygxYzl57WK8=;
 b=OGmqPORwiKuOV8gVoplk6QhdQqDA5+4iNVtcCedz1UZp6UPu3OPCeOmAHknD8Op5e5jEntg52V81cLH5NQFNsFV25JzDYEA9cAG0IdWXNGkjwSrXe9o9I2VuN7xL1duzZ04DcHSiFVwNYnNcZHPQg3fbCkb+INwKqr/7A9KNqVg=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB4898.apcprd06.prod.outlook.com (2603:1096:4:179::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 02:07:28 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5144.025; Fri, 8 Apr 2022
 02:07:28 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     wangqing <11112896@bbktel.com>
Subject: [PATCH] arch_topology: support parsing cache topology from DT
Thread-Topic: [PATCH] arch_topology: support parsing cache topology from DT
Thread-Index: AQHYSZdCGkQ2mLDvVU6wfMdXkcz1Wqzk3BGAgABfzOc=
Date:   Fri, 8 Apr 2022 02:07:27 +0000
Message-ID: <SL2PR06MB30825F36A5963C6A05A39F9DBDE99@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
 <84bd8d25-979b-42d7-a809-379454537806@arm.com>
In-Reply-To: <84bd8d25-979b-42d7-a809-379454537806@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 633d07e3-549a-4d46-d3a4-08da1904882e
x-ms-traffictypediagnostic: SG2PR06MB4898:EE_
x-microsoft-antispam-prvs: <SG2PR06MB4898C0781F068A1A41F284E2BDE99@SG2PR06MB4898.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNn8MP0Pzw924XfU08TSkyI4wTnyRrU7/+upwRvwQZhZCcP5gKRp8xs+Fk8K5sbyWinDVN+XSqRj4kwyIa3LJlIc/rg7djYTXeRbCSA8WgUVK+9bDdR4G3TqMxPGDN/kX3KeFzYZdQPWREksSEXD287z9S9u13UPh+c3BPs/xHfq2SYPW/3IWfxi5pd1RNF+5niuUf8UD7yM42RljcOhbCMgZVHFAI2FROqbJzLBU3vad7jzWXQvp/hOHsY+2ZyjuHdvBFB5dJjgiDkHM+t48+EaLlXTQ2kJ9///TpS7Nkxmxbdb6xrsY6pkKi/A4FijZZMD8qRw1Zc/cIPXBXeTAMeP/lYpmlfZgbcuZvubHcKLEYqbtHWYHZ1qwyWe2yZm/FZIivqWEpFNN2LLFFI/fLk3N2v45XCxSC/j3F6vhng4KrpQjezXeYtY/ibvOWKVtnYf0HyWNMTNTlaUhj1CNShGU/hZVpkH7iB3uC0y2ZJ/KqVCkXLjtv2fVPR9MWMYE9kE3LS/P898pHxwTQ+DiH0LdZDIEkGE5TTUS5nZCRmLFIY3jR8j3pr2Gk4x8zkm1lZcQSYqk+jLRgsfxQEw2Dr/qZQOUpWt8kswSKj3sZWr200mu1k+ZvUAWbherIp5CRLgHv4DFB7JK0E8DnWRlwyDUwNMCuZsqx7f3wiP84OLlIeJReiP5aGw4Z3bY4Flz9vCCmz0rm6VIU+L+NbG/w2o5EGaLFufmzBA/xWUqopJdC2CF5O465krnohmyHDT/XTFtvuoym4x+JecFlmVal5zxTmqasctwZ7DUkpPfpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(91956017)(76116006)(66476007)(64756008)(66446008)(85182001)(316002)(52536014)(5660300002)(55016003)(26005)(71200400001)(122000001)(6506007)(38100700002)(33656002)(7696005)(9686003)(110136005)(4326008)(8936002)(8676002)(66556008)(83380400001)(2906002)(508600001)(186003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1NHQ1NHT1UxdVZ2RzJ6RXlGU2FpWXFyYmxIbnpCR1g5VklQMGUzbWlhNFg1?=
 =?utf-8?B?RVJLRUxUOVFEbGJ4RjFvMzkzWS94VWxzQXRGRE5xR0E0K3pGbWxTc3YzbTRR?=
 =?utf-8?B?ZmgvdGc1UDVjWkZyZHMvei9JZ2ZBNk40YUU2WEFybVFDdUUxVm51M3p0K3p0?=
 =?utf-8?B?VFNES1hoQndtaXZDQ0h0SzhQWE5mZzBsZTlPdTYxUTBKeEpSSGgwNnQzanRX?=
 =?utf-8?B?azBmVGxsNnZjRmU5ODZWQWF5MlNVTThTUjFWVWFJRExya2g3TkZFL0grVXRL?=
 =?utf-8?B?R0g4bDZKVlkvQWpJZXBtR0ZxNXFtNW10NG11YkpxbVY3dVdiUUxoZ2lrSDBn?=
 =?utf-8?B?YUVuY2FHdDY4ZmtYN0VQZmt6UE1zL002SjZwMjY4dkpTU0pEbCtwWHBMQTJU?=
 =?utf-8?B?aXFsM0MwenRqeUNlMlRJSTBIRk1yNzVnRjFSSVNKMHhSd2pjT2xIMW9JS0lD?=
 =?utf-8?B?OXZhbUNFMVpId0h0dHB0alhqbkdYZE5UMkt0SVZhVitmOXYzR3NIYUQwQy84?=
 =?utf-8?B?ODVFVzBxRm9BYXZLZXV2d2dMRjlVRzM2ODN0c282YU9MUlRBVTJoejBZM3pW?=
 =?utf-8?B?eVp2UHBIeGVMZ2RNQVFCdlJnWmpaMnd2NnJIcDRpMHVMWTQ5SnlnYTUxMEwv?=
 =?utf-8?B?cFEzZWU5UVRVck1jT1RUOFBTb28veHFUMnpaRExKUmVFTWVIUnpweVEyK3dJ?=
 =?utf-8?B?WUZBVklaTUFQaHpCMEZ4Nk9Ldy9NNzczSkJOV0J1ZW9JQWxPaTJHeW0xazFT?=
 =?utf-8?B?amdINWtOY1Rtb0dDSWtGQng0SUgyUWxMVG1wa3JGZGMwdzFicTlUbnpMaGRy?=
 =?utf-8?B?M21wVDVQeFZIcEhUaThhSklhdkRrT3VDWUNoYzAyUGRuUy9HV2JIdkMrdDdL?=
 =?utf-8?B?QU4xTk52bDY0T3phL1VrWDB0V1BESzN1TzhnMzl0Mi9aMmhkOWJXRkxlV2Nv?=
 =?utf-8?B?eXZNVXNhOHk5bENFaFlPVXFBZVluR3QxcWV3MGw2NUJMLzdwNlM2dW9vZXN2?=
 =?utf-8?B?c1BUM3JMSlNUODR4UUd1Skt6eWVoTEthQUJXZkpLdkZLRHBBV2JxaURxZ0RN?=
 =?utf-8?B?YjVtcXJhQm1aMU5DNmtFMXdWN3pGcUFaK3VWV0VaYWZnK2ZjejBtUFAvdFhs?=
 =?utf-8?B?S3YzYjRNRVFaV1ZPcmFFMThRanZkSjJ4TmF1dnQ4Snd1elpML0dTRUhpU1Vt?=
 =?utf-8?B?VTBTdGdNbzZCR1hEekNEaUZBMmkzMzEwSXUxNGt6MUdqNDRCQlZFb2djUHNt?=
 =?utf-8?B?NmhNY1RrMFZGR1dsNXZ0U3Y2cm1hK0xiVmVGdXVZd2ZXQjMvdDhLVUdJQk5m?=
 =?utf-8?B?RHBnZ1VMd0hMcExOMWxuMEI3TUN4U1dObzIwWGNaMDF2RDIySy95V1hjNG5K?=
 =?utf-8?B?WjhkZEZCRlFoY0U4TDV5aXowM1UyR3huSGhVQ3BieElwbFVhdktpSk1Ub1BI?=
 =?utf-8?B?c0xhSmRiNHZPYnRnb0ZITWtUa3d4QTllT1BPQW1jSTRSS1ArWjZWMUFnblFP?=
 =?utf-8?B?YWpUaTZFNjlzWllMYnRHWjhhMnlGQk5iSEhaRlRJWDRvNFBldkZZNjhFRkZP?=
 =?utf-8?B?VzVJOVo3R2RCcjYybjBCWXZtZ1RFdExRc2VOR1BubVFpYlFSR1U5TnB0MFBO?=
 =?utf-8?B?OEVQckxQc005U0hSaWI0ekRuc3pOejZwNG5qNFlUMFNSelBXWmxnOFV3eUxm?=
 =?utf-8?B?cEFaSGExL0Vzd01OVzJqTWROQjU4MUs3b0tVbHlGTnN1bnl2VXZNUTVVNWNs?=
 =?utf-8?B?K0ZNSGdKZVJQUWFYOElZQUJYOVQvRi90b0pOZXR0Q1lhbmwzTWU4bWIvT3B3?=
 =?utf-8?B?WklXWU5Sd1ZFL0JVUmhuSTFsQ3Y2a0tZc2poWmhyQnhPNXIyT1N6OHF6c1RM?=
 =?utf-8?B?TWx5dFVEMm1GbS9zbFc0am5GK3h0RWlSaUxNb0tXSlhlRjlubkJFOE5OVmlW?=
 =?utf-8?B?TThqZDdMczZFTW8wMzBFeVJRcEtScVFieU5LRkpDbzlVYzNCenpxYzhIUFVU?=
 =?utf-8?B?aEFkcVFyZTJGK283MG90MldkYzZLT3BZSGJnMWhwaTJ2QUZDZEFsdHZ0Yktp?=
 =?utf-8?B?SHB1NCt1QWdUbXpQWG5XZXhQTUlRV3dzMjhYT2orRjl2eVFVclJWdXpSckow?=
 =?utf-8?B?RzVaRndLQXIya3J3a0dqYXdNM1c0NzYzU3NXUjQ1cHBZc1NvSHhvaUxmajNl?=
 =?utf-8?B?OUR6ZGVtSkdhNHU2WXNlL24xTHFGd1d4ZHFTM21jZ05lNkYyMERJcUlNK21E?=
 =?utf-8?B?b1hZMklEdXhQWlJTNElYemhlRzBCNUNFM1liWG9PZjIyR1JCcW1ZZmVGOXVT?=
 =?utf-8?Q?WDy2eeOryHuHGyPzfO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633d07e3-549a-4d46-d3a4-08da1904882e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 02:07:27.8399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZ5HSxXy99+6rkH1I9s8iyo7VMVzIk2UBWKvaO9bByABJvMFl6hxz3v+KeFudDnhtnb/Z7Bg52D+EvHKofnJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4898
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4KPlsuLi5dCj4KPj4gK3ZvaWQgaW5pdF9jcHVfY2FjaGVfdG9wb2xvZ3kodm9pZCkKPj4gK3sK
Pj4gK8KgwqDCoMKgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZV9jcHUsICpub2RlX2NhY2hlOwo+
PiArwqDCoMKgwqAgaW50IGNwdTsKPj4gK8KgwqDCoMKgIGludCBsZXZlbCA9IDA7Cj4+ICsKPj4g
K8KgwqDCoMKgIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpIHsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBub2RlX2NwdSA9IG9mX2dldF9jcHVfbm9kZShjcHUsIE5VTEwpOwo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghbm9kZV9jcHUpCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbGV2ZWwgPSAwOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5vZGVf
Y2FjaGUgPSBub2RlX2NwdTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aGlsZSAobGV2
ZWwgPCBNQVhfQ0FDSEVfTEVWRUwpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbm9kZV9jYWNoZSA9IG9mX3BhcnNlX3BoYW5kbGUobm9kZV9jYWNoZSwgIm5l
eHQtbGV2ZWwtY2FjaGUiLCAwKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFub2RlX2NhY2hlKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FjaGVfdG9wb2xvZ3lbY3B1XVtsZXZlbCsr
XSA9IG5vZGVfY2FjaGU7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG9mX25vZGVfcHV0KG5vZGVfY3B1KTsKPj4gK8KgwqDCoMKgIH0K
Pj4gK30KPgo+RnJvbSB3aGVyZSBpcyBpbml0X2NwdV9jYWNoZV90b3BvbG9neSgpIGNhbGxlZD8K
CkFsbCBhcmNoIHdoaWNoIHN1cHBvcnQgR0VORVJJQ19BUkNIX1RPUE9MT0dZIGNhbiBiZSBjYWxs
ZWQsIApJIHdpbGwgdGFrZSBhcm02NCBhcyBhbiBleGFtcGxlIGluIFYyLgoKPgo+PiArYm9vbCBj
cHVfc2hhcmVfbGxjKGludCBjcHUxLCBpbnQgY3B1MikKPj4gK3sKPj4gK8KgwqDCoMKgIGludCBj
YWNoZV9sZXZlbDsKPj4gKwo+PiArwqDCoMKgwqAgZm9yIChjYWNoZV9sZXZlbCA9IE1BWF9DQUNI
RV9MRVZFTCAtIDE7IGNhY2hlX2xldmVsID4gMDsgY2FjaGVfbGV2ZWwtLSkgewo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICghY2FjaGVfdG9wb2xvZ3lbY3B1MV1bY2FjaGVfbGV2ZWxd
KQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsK
Pj4gKwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChjYWNoZV90b3BvbG9neVtjcHUx
XVtjYWNoZV9sZXZlbF0gPT0gY2FjaGVfdG9wb2xvZ3lbY3B1Ml1bY2FjaGVfbGV2ZWxdKQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsKPj4g
Kwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPj4gK8KgwqDCoMKg
IH0KPj4gKwo+PiArwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+PiArfQo+Cj5MaWtlIEkgbWVudGlv
bmVkIGluOgo+Cj5odHRwczovL2xrbWwua2VybmVsLm9yZy9yLzczYjQ5MWZlLWI1ZTgtZWJjYS0w
ODFlLWZhMzM5Y2M5MDNlMUBhcm0uY29tCj4KPnRoZSBjb3JyZWN0IHNldHRpbmcgaW4gRFQncyBj
cHUtbWFwIG5vZGUgKG9ubHkgY29yZSBub2RlcyBpbiB5b3VyIGNhc2UKPihPbmUgRHluYW1JUSBj
bHVzdGVyKSB3aWxsIGdpdmUgeW91IHRoZSBjb3JyZWN0IExMQyAoaGlnaGVzdAo+U0RfU0hBUkVf
UEtHX1JFU09VUkNFUykgc2V0dGluZy4KClRoYW5rcywgSSBoYXZlIHNlZW4geW91ciByZXBseSwg
YnV0IG5vdCAxMDAlIGFncmVlLgoKMS5BIGNsdXN0ZXIgbm90IG9ubHkgY29uc2lkZXJzIHRoZSBj
YWNoZSwgYnV0IGFsc28gYSBzZXQgb2YgdGhlIHNhbWUgYXJjaCxjYXBhYmlsaXR5LAphbmQgcG9s
aWN5LiBTbyB3ZSBjYW4ndCBzaW1wbHkgY2hhbmdlIGl0cyBjbHVzdGVyKGxpdHRsZSwgbWVkaXVt
LCBiaWcpIGV2ZW4gaWYgRFNVLgoyLlRoZSBjcHUtbWFwIG5vZGUgY2FuJ3QgZ2l2ZSB0aGUgY29y
cmVjdCBMTEMsIGl0IGp1c3QgZ2l2ZSB0aGUgY29ycmVjdCBjbHVzdGVyL2NvcmUgZ3JvdXAKCj4K
Pmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vdG9wb2xvZ3kudHh0Cj4KPj4gKwo+PiArYm9vbCBjcHVfc2hhcmVfbDJjKGludCBj
cHUxLCBpbnQgY3B1MikKPj4gK3sKPj4gK8KgwqDCoMKgIGlmICghY2FjaGVfdG9wb2xvZ3lbY3B1
MV1bMF0pCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+PiArCj4+
ICvCoMKgwqDCoCBpZiAoY2FjaGVfdG9wb2xvZ3lbY3B1MV1bMF0gPT0gY2FjaGVfdG9wb2xvZ3lb
Y3B1Ml1bMF0pCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4+ICsK
Pj4gK8KgwqDCoMKgIHJldHVybiBmYWxzZTsKPj4gK30KPj4gKwo+PsKgIC8qCj4+wqDCoCAqIGNw
dSB0b3BvbG9neSB0YWJsZQo+PsKgwqAgKi8KPj4gQEAgLTY2Miw3ICs3MjAsNyBAQCBjb25zdCBz
dHJ1Y3QgY3B1bWFzayAqY3B1X2NvcmVncm91cF9tYXNrKGludCBjcHUpCj4+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIG5vdCBudW1hIGluIHBhY2thZ2UsIGxldHMgdXNlIHRoZSBw
YWNrYWdlIHNpYmxpbmdzICovCj4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvcmVf
bWFzayA9ICZjcHVfdG9wb2xvZ3lbY3B1XS5jb3JlX3NpYmxpbmc7Cj4+wqDCoMKgwqDCoMKgwqAg
fQo+PiAtwqDCoMKgwqAgaWYgKGNwdV90b3BvbG9neVtjcHVdLmxsY19pZCAhPSAtMSkgewo+PiAr
wqDCoMKgwqAgaWYgKGNwdV90b3BvbG9neVtjcHVdLmxsY19pZCAhPSAtMSB8fCBjYWNoZV90b3Bv
bG9neVtjcHVdWzBdKSB7Cj4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChjcHVt
YXNrX3N1YnNldCgmY3B1X3RvcG9sb2d5W2NwdV0ubGxjX3NpYmxpbmcsIGNvcmVfbWFzaykpCj4+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3JlX21hc2sg
PSAmY3B1X3RvcG9sb2d5W2NwdV0ubGxjX3NpYmxpbmc7Cj4+wqDCoMKgwqDCoMKgwqAgfQo+PiBA
QCAtNjg0LDcgKzc0Miw4IEBAIHZvaWQgdXBkYXRlX3NpYmxpbmdzX21hc2tzKHVuc2lnbmVkIGlu
dCBjcHVpZCkKPj7CoMKgwqDCoMKgwqDCoCBmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgewo+PsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVfdG9wbyA9ICZjcHVfdG9wb2xvZ3lbY3B1
XTsKPj7CoCAKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3B1aWRfdG9wby0+bGxj
X2lkID09IGNwdV90b3BvLT5sbGNfaWQpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoKGNwdWlkX3RvcG8tPmxsY19pZCAhPSAtMSAmJiBjcHVpZF90b3BvLT5sbGNfaWQgPT0gY3B1
X3RvcG8tPmxsY19pZCkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfHwgKGNwdWlkX3RvcG8tPmxsY19pZCA9PSAtMSAmJiBjcHVfc2hhcmVfbGxjKGNwdSwgY3B1
aWQpKSkgewo+Cj5Bc3N1bWluZyBhOgo+Cj7CoMKgwqDCoMKgIC4tLS0tLS0tLS0tLS0tLS0uCj5D
UFXCoMKgIHwwIDEgMiAzIDQgNSA2IDd8Cj7CoMKgwqDCoMKgICstLS0tLS0tLS0tLS0tLS0rCj51
YXJjaCB8bCBsIGwgbCBtIG0gbSBifCAoc28gY2FsbGVkIHRyaS1nZWFyOiBsaXR0bGUsIG1lZGl1
bSwgYmlnKQo+wqDCoMKgwqDCoCArLS0tLS0tLS0tLS0tLS0tKwo+wqAgTDLCoCB8wqDCoCB8wqDC
oCB8IHwgfCB8IHwKV2Ugb25seSBkaXNjdXNzIHRoZSA0LWNvcmUgc3lzdGVtIGhlcmUsIGJ1dCBp
dCBzaG91bGQgYmU6CiDCoCBMMsKgIHwgIHwgIHwgfCB8IHwgfCB8Cj7CoMKgwqDCoMKgICstLS0t
LS0tLS0tLS0tLS0rCj7CoCBMM8KgIHw8LS3CoMKgwqDCoMKgwqDCoMKgIC0tPnwKPsKgwqDCoMKg
wqAgKy0tLS0tLS0tLS0tLS0tLSsKPsKgwqDCoMKgwqAgfDwtLSBjbHVzdGVyIC0tPnwKPsKgwqDC
oMKgwqAgKy0tLS0tLS0tLS0tLS0tLSsKPsKgwqDCoMKgwqAgfDwtLcKgwqAgRFNVwqDCoCAtLT58
Cj7CoMKgwqDCoMKgICctLS0tLS0tLS0tLS0tLS0nCj4KPnN5c3RlbSwgSSBndWVzcyB5b3Ugd291
bGQgZ2V0ICh3LyBQaGFudG9tIFNEIGFuZCBMMi9MMyBjYWNoZSBpbmZvIGluIERUKToKPgo+Q1BV
MCAuLiAzOgo+Cj5NQ8KgwqDCoMKgwqDCoMKgwqAgU0RfU0hBUkVfUEtHX1JFU09VUkNFUwo+RElF
wqDCoMKgwqAgbm8gU0RfU0hBUkVfUEtHX1JFU09VUkNFUwo+Cj5DUFUgNC4uLjc6Cj4KPkRJRcKg
wqDCoMKgIG5vIFNEX1NIQVJFX1BLR19SRVNPVVJDRVMKPgo+SSBjYW4ndCBzZWUgaG93IHRoaXMg
d291bGQgbWFrZSBhbnkgc2Vuc2UgLi4uCj4KPlJlYXNvbiBpcyBjcHVfc2hhcmVfbGxjKCkuIFlv
dSBkb24ndCBjaGVjayBjYWNoZV9sZXZlbD0wIGFuZCB3Lwo+Cj5DUFUwIC4uIDM6Cj5jYWNoZV90
b3BvbG9neVtDUFVYXVswXSA9PSBMMgo+Y2FjaGVfdG9wb2xvZ3lbQ1BVWF1bMV0gPT0gTDMKPgo+
Q1BVNC4uLjc6Cj5jYWNoZV90b3BvbG9neVtDUFVYXVswXSA9PSBMMwoKTm8sIEkgZGlkbid0IGRl
c2NyaWJlIHRoZSBjYWNoZSB0b3BvbG9neSBvZiBjcHVbNCw3XSBpbiB0aGUgY29tbWl0IGxvZywK
Y2F1c2UgdGhhdCdzIG5vdCB0aGUgcG9pbnQsIEkgdXNlIDQgY29yZXMoMyBsZXZlbCBjYWNoZSkg
YXMgYW4gZXhhbXBsZS4KCkNQVTQuLi43IGlmIG5lZWRlZDoKY2FjaGVfdG9wb2xvZ3lbQ1BVWF1b
MF0gPT0gTDIKY2FjaGVfdG9wb2xvZ3lbQ1BVWF1bMV0gPT0gTDMKCmNhY2hlX3RvcG9sb2d5W0NQ
VVhdW2xldmVsXSwgbGV2ZWwgaXMgc3RyaWN0bHkgY29ycmVzcG9uZGluZyB0byB0aGUgY2FjaGUg
bGV2ZWwKCj4KPnRoZXJlIGlzLCBleGNlcHQgZm9yIENQVTAtMSBhbmQgQ1BVMi0zLCBubyBMTEMg
bWF0Y2guCgpBbGwgNCBDUFVzIG1hdGNoIHRoZSBMTEMgaW4gdGhpcyBjYXNlLgoKVGhhbmtzLApX
YW5nCj4KPlsuLi5d
