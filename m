Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0B4FBCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbiDKNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiDKNQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:16:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2051.outbound.protection.outlook.com [40.107.114.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8B9377EA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2S0uROtJke0sDSwbQj+64WblwlvDJjdObsT57JSwbLOedpdoWUzHel81BYbbMdqfKBFcAkZokHVXwY1nAgw1jCxLOWiRDwvHH1cB2EBbJHnlZVHo4EP/73dUundu8AUDEwZwLFTbL6gWXHivEE7syG9LEA/mRDMcISYUHH6MQrTGS9U9t2imRMhJMDFO3SZePUIjEVzm+nGg3yFS5L39dPqN/LK7mDFVV5K8q1HQP5AVEupspDN0qdosnfUQzqyQwae5SDefAZRGyHV/NoDub+nb4Zvkyo8wBn4Jzu5kK9uNqVKuqGNgx+QamnKByGDBaDKEvMg7J65zYilFnFWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxVU6CkMdqrhN1cUFF5mmb6DSZLVLttqN3pS21puBIw=;
 b=CzhSib/8Cmryz+wfVs7b+1VFxMfvwp3nrglBX/4TA7NcwXK5g6t3skz/z/5foXr9GI2soUUwGdXRPC0fEMurHRheMlejdpSmJr97jJ9IPN9xsjD3Y2svbOLEJ30JscsCL6DlnvCXNf7CnDn5wGpHgYrv2BF/g4oZjK7yPoi69jOyQOGc0nvZHUUd9HILXQKodxCAQ5OcGzLLHjzbqoa0g0QuwQJ00JuMSEhqHnbgwmYCPEjntmcjOuC2MiX3KyozVe4YgRyO84Q2zOxjBwwEkQcZJuNmlq+kIa5dX7pnjHlzd7pTHZVxgecd6FetnQCr55gvmOPXMETWs9d6zINJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxVU6CkMdqrhN1cUFF5mmb6DSZLVLttqN3pS21puBIw=;
 b=bC+7Tu6VHfVL7OLSF6WfxOYVkwiKwDEOJe01/GUq2SwAsu2dJ4v8bcKtnL78qFYK0yMwihX6nli+pXU8uzpTwIj5ew+GPAiErvOdUOkR7WRS7O+LXVXWu1uO82Rf98i2wfr9RTO+7RKsU5aB+AYLHvrIeWAk0aOZcuEjvVaOTPw=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3846.jpnprd01.prod.outlook.com (2603:1096:604:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:13:45 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5144.028; Mon, 11 Apr 2022
 13:13:45 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm/memory-failure.c: dissolve truncated hugetlb page
Thread-Topic: [PATCH 3/3] mm/memory-failure.c: dissolve truncated hugetlb page
Thread-Index: AQHYSn/keBQQihCxBEyue1wskLydZazqtvEA
Date:   Mon, 11 Apr 2022 13:13:45 +0000
Message-ID: <20220411131344.GA3188122@hori.linux.bs1.fc.nec.co.jp>
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-4-linmiaohe@huawei.com>
In-Reply-To: <20220407130352.15618-4-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1c6d00f-27d4-4cb1-c88a-08da1bbd1bcf
x-ms-traffictypediagnostic: OSBPR01MB3846:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3846B073503BDE8764EAAE3BE7EA9@OSBPR01MB3846.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlFR1pDh+10z1hiHYyiXsNCbTVuN97pmGnBH7hnCRGjH0voAXzr+yy5bE/tkPha+Ixf8nyvbFtqtsnVbQi5TEu2NjuRXN9h77mKkcohNx4F0c72sWtNvYbx2q1n51u3FiWUe5SZJVbKGH7UqvBlo1TD92W4JCQD3aiOkQpRaHwwhO1eloJ3ZINsHzwTb440fyrtGcKbtz6UdLukeFcEp3750QEbHIqgqKCR4m6RZx1GQMlv/aLu7gryoJRvm2E7k7Rg7UzVMZSjWy5eAgQxyvwydAkBt9pLjGoj64pk6YQwIBtmmaEMi9t3jwyxacrStr3u/KR7wZ8LWHsdQqZuJQDW5UhL5zymKBpgQQP9MLg7bGxNkchsr7+nd7Sj7L7COakBW8s7RyL2CimFzomO+SuisFimuuzMeWCHYhFQ4U67lyeegjgVneUTex5CYZyrzkfHv59WYU151y7xPsNaZFoH4mP5qEovChYQwiisOyET1xC9+tUTT73VvUXbvQJgzL7yqd2pJ6GLqZrNqRj22UP2Yt+plTZmKy9oXEPL/B+EdRGp+KF3SFpky3nX/N/K41ji29xTAKorjiC0wqWJmWTDlE8tJfu/owawIwo5QOzC7syFmnDwmjbSCGiAzRRydwbG+Eh6zfNCJUYhHCRKITo/RLqlHQjYMRYKvXEFEAO8JI63uRTIVrR54uecpl9mguPFHzRLRNhp8YQ594+mMvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(38070700005)(6486002)(316002)(33656002)(54906003)(76116006)(82960400001)(6916009)(38100700002)(5660300002)(8936002)(508600001)(186003)(26005)(9686003)(122000001)(66446008)(6512007)(64756008)(1076003)(85182001)(66476007)(66556008)(66946007)(86362001)(71200400001)(8676002)(55236004)(4326008)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elhxR25HdVVoQTltTy8xWW8ySDRxTDJWKzFxV3hoa21pK0Z6em04SWVGeHM3?=
 =?utf-8?B?TDMzM2IrNnIwK3gvbk9CU0t4NEZEMGhSVWRVSUhUWnB1N1h0ZU5OWlZjWDJ3?=
 =?utf-8?B?TERCa09qSUY5NUJlaEcydXdkTHd0UmVVZVVmdWZyMzFQdFNuanlZMFBwTzFi?=
 =?utf-8?B?dnFQclpUZ3l5KzA4SU1kSmNBeTRFM1dyTXV6a3FJUEt6L2F6YlJ1VThkbWNV?=
 =?utf-8?B?UG43ZHVDTmxhaXNpY0lHQjhoVjBvZjF1VWZaN05FdHQ5akdDUytxRjZMZjhi?=
 =?utf-8?B?bkZtalJoQU9IWldTNGFVUHQ5emQ5MC9xQm9vRGp1LzlocmR2bVMxdVZZdGY4?=
 =?utf-8?B?dVQrNUo2THlSc1ZySVlCNlpiYmVnais5NFk2QVNuMTFRUmV3aEpwM1RpbVJ6?=
 =?utf-8?B?MEVPcWQxL25UZ0ZmNktaU0Y0NjI3ZGZVVXNOZHQwaGNLMWxNNjlTZzZpRmhM?=
 =?utf-8?B?QytCdnhOR3p3YTJCdGx6MEdJcy96UVV4UXh0V015cXRHNThHeFlYVk5RaTBM?=
 =?utf-8?B?V080VWRjYmdxRGtQUlh6MStVQS9lemhGSjJDdkwycStsNXBXbjVCMTBVUm4z?=
 =?utf-8?B?TTFJL0wxY3hJemE3aGRzNHhiWHMwbExhL3FOeUZZR1JPTmw0Y0RCc3FmUmsr?=
 =?utf-8?B?RVQ3cEdPdUFBN2M3aTQ5dUZSMlNadDVaTnNwNmRiclB6d0JsR3dYbzBNQ1Nr?=
 =?utf-8?B?VVNPSWwrWmNsRDhoN1ZDSHNYRmhwMUpCMjFSY0l5c2RIMVRjSEdZNVh0UVl5?=
 =?utf-8?B?b1lVUjlTTUtISVF6eURNVWZZL2dWSlU1dlh0eUh3TWd1dWF1Um9hMmJXZ0Zs?=
 =?utf-8?B?L0J0cVJzMklCbVN2c2swdUJ6THJvV2NIUXk5Z05SOHlINVVZT3E4RjJXT0p5?=
 =?utf-8?B?Z05IaHo0bUNSVkpHM09BeCtxSGlyL3UzZUJ2TWQ3d3k1N1g2RktnbDlEemo1?=
 =?utf-8?B?MkFSQ3pRSzQrMHAwdFN1UUE0RTFiREtrR2NvYUk4dnFJNGZIUUlucXZQOWNN?=
 =?utf-8?B?dzJveHJVL2Z2dXVjaWVNd3NUc1VpTHdRZGRRV1dHaWVCZGxHU3FOSldFdmdB?=
 =?utf-8?B?QldGclNVQTNlQVpORnF3NHFiR29lbGUvTGlGcXg2RUFOZmlBbVVyTUxiTWhC?=
 =?utf-8?B?aGozWDNnRWk1N3VOYlZwSnhGVHJTYVJLZEltSmhKMUNmWDkrcElZQ1YwQWZV?=
 =?utf-8?B?czdRTE1nSTEwRm5TSCtJVWpuem1IYllnWHY5R1FydXo3NjZlUFYxZlI5Rmsv?=
 =?utf-8?B?WjZzNGRTNjlMdmhHRVlQRCtWQitzMFp3czRWOGxCKzVVQ3k4cDBaUDVXRnlD?=
 =?utf-8?B?ekRPN20xdktWcng4UUx1K0VIREdxeWRBTGNyWjlMaE5jeUtQQSttV21PZmtF?=
 =?utf-8?B?SWd2QUJvMlN1dXdOVDVLRFE3QmMwZ2lreHBXSU1TZDNkM1V4eGVxWjgxeURU?=
 =?utf-8?B?ZHBmbElpaHVyVUJ3cTUraGlob2JyaVJFeHpoR0Y5ZkpyMjBva2loZDRVYktp?=
 =?utf-8?B?dDFFemhYaGVXa2Q2ZzVmVzhpTm1jUTRqUUN6WjZndDBidXRSaU9VOURJRG1S?=
 =?utf-8?B?Z3ZMclFDQksySVBDNml3Q0J4cGdOTTBraXYvQ3ZWbXZENHZ0VFJmb3djcTdD?=
 =?utf-8?B?b09jUHNGUVlkcUFSQXJWTGw3QXVtamgxQnhVWFlwbzFveWFBaFN4SHVwNzBv?=
 =?utf-8?B?SXRNZ2tYZVRRRXEzMGUzL2I5VFl4djVlTVppZmpMWkd0WjBwUGorV2VuTWdl?=
 =?utf-8?B?MndQcTZFdVBoQm9Jcndnei9OeFg3MEFkODQ3WFdtWkFHQ3VXQU9mZGppV1BL?=
 =?utf-8?B?Z20zMU9BeGM1LzNmZkg5bTdDczBsc1RaeXl6S0puZmk4YlJLTGtvdUc2UjZl?=
 =?utf-8?B?enBkcCs3OUx4OGc2c2lrcy9QK2Y3eTNqQXZrc0tHaVFkbVVCaXdCMkVhUExH?=
 =?utf-8?B?TnJBRVJ4N1VVVUVnakJnOXl5OVN2aDFoaWxPSFFXWjM4aUdiZUJqWWFGZ2l4?=
 =?utf-8?B?OG5rbEJib1pqbU12b3FCbkhuNGR1VVMvRzZNMzEvVk1qaDBzNUJ2dXYxUXRB?=
 =?utf-8?B?azBYMU1JTEhyM1dtdXdJdTV0NEwxNUEvYWJMS25KcmZDaUxjRFNoTzJTQkJM?=
 =?utf-8?B?VkxHMG91NG85UHZhSzVSeGdKWEFIR244VjJZQ3o1azg1YUYzV2ZBRkRNWE9H?=
 =?utf-8?B?MjBvbzVYdVRRWkJKblRseVByRldvalVJY1pPZjRXb2lHMVRsUEwrWWIxSGJG?=
 =?utf-8?B?WWd5Q2tjTjkyRkV6N1FNVklvMWoxaDdLYzBYZGRLc0g0dDBhNE9HZm9YRXZo?=
 =?utf-8?B?WThVV0thdTN3bjkyWHpwcEtsZUw0b05KNTUvRG9tMmY3K0dwZEhnUmZUMjly?=
 =?utf-8?Q?7tpOBGqezsf52AZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14573979F92176438E54DA3C686D8940@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c6d00f-27d4-4cb1-c88a-08da1bbd1bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 13:13:45.4779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1e5mP21NHySlcxjgWKdKhM6J5aK32Z6hqzMEGZ/PT2xxjz4I83HDxab1+eugRrLxIvUnKSvwIBcW/bX97FPHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlhb2hlLA0KDQpPbiBUaHUsIEFwciAwNywgMjAyMiBhdCAwOTowMzo1MlBNICswODAwLCBN
aWFvaGUgTGluIHdyb3RlOg0KPiBJZiBtZV9odWdlX3BhZ2UgbWVldHMgYSB0cnVuY2F0ZWQgaHVn
ZSBwYWdlLCBocGFnZSB3b24ndCBiZSBkaXNzb2x2ZWQNCg0KSSBtaWdodCBub3QgdW5kZXJzdGFu
ZCBjb3JyZWN0bHkgd2hhdCAidHJ1bmNhdGVkIGh1Z2UgcGFnZSIgbWVhbnMuICBJZiBpdA0KbWVh
bnMgdGhlIHBhZ2UgcGFzc2VkIHRvIG1lX2h1Z2VfcGFnZSgpIGFuZCB0cnVuY2F0ZV9lcnJvcl9w
YWdlKCkgaXMgY2FsbGVkDQpvbiBpdCwgdGhlIGVsc2UgYnJhbmNoIHlvdSdyZSB0cnlpbmcgdG8g
dXBkYXRlIGlzIG5vdCBjaG9zZW4sIHNvIG1heWJlIGl0DQpzb3VuZHMgaXJyZWxldmFudCB0byBt
ZT8gIENvdWxkIHlvdSBlbGFib3JhdGUgaXQgb3Igc2hhcmUgdGhlIHByb2NlZHVyZSB0bw0KcmVw
cm9kdWNlIHRoZSBjYXNlIHlvdSBjYXJlIGFib3V0Pw0KDQo+IGV2ZW4gaWYgd2UgaG9sZCB0aGUg
bGFzdCByZWZjbnQuIEl0J3MgYmVjYXVzZSB0aGUgdHJ1bmNhdGVkIGh1Z2UgcGFnZQ0KPiBoYXMg
TlVMTCBwYWdlX21hcHBpbmcgd2hpbGUgaXQncyBub3QgYW5vbnltb3VzIHBhZ2UgdG9vLiBUaHVz
IHdlIGxvc2UNCj4gdGhlIGxhc3QgY2hhbmNlIHRvIGRpc3NvbHZlIGl0IGludG8gYnVkZHkgdG8g
c2F2ZSBoZWFsdGh5IHN1YnBhZ2VzLg0KPiBSZW1vdmUgUGFnZUFub24gY2hlY2sgdG8gaGFuZGxl
IHRoZXNlIGh1Z2UgcGFnZXMgdG9vLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlhb2hlIExpbiA8
bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgbW0vbWVtb3J5LWZhaWx1cmUuYyB8IDMg
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJl
LmMNCj4gaW5kZXggYmQ1NjNmNDc2MzBjLi4zZjA1NGRiYjE2OWQgMTAwNjQ0DQo+IC0tLSBhL21t
L21lbW9yeS1mYWlsdXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAtMTA0
Niw4ICsxMDQ2LDcgQEAgc3RhdGljIGludCBtZV9odWdlX3BhZ2Uoc3RydWN0IHBhZ2Vfc3RhdGUg
KnBzLCBzdHJ1Y3QgcGFnZSAqcCkNCj4gIAkJICogaHVnZXBhZ2UsIHNvIHdlIGNhbiBmcmVlIGFu
ZCBkaXNzb2x2ZSBpdCBpbnRvIGJ1ZGR5IHRvDQo+ICAJCSAqIHNhdmUgaGVhbHRoeSBzdWJwYWdl
cy4NCj4gIAkJICovDQo+IC0JCWlmIChQYWdlQW5vbihocGFnZSkpDQo+IC0JCQlwdXRfcGFnZSho
cGFnZSk7DQoNCkkgdGhpbmsgdGhhdCB0aGUgcmVhc29uIG9mIHRoaXMgImlmIChQYWdlQW5vbiho
cGFnZSkpIiBpcyB0byBub3QgcmVtb3ZlDQpodWdlcGFnZXMgZm9yIGh1Z2V0bGJmcyBmaWxlcy4g
IFVubGlrZSBhbm9ueW1vdXMgaHVnZXBhZ2UsIGl0IGNhbiBiZQ0KYWNjZXNzZWQgZnJvbSBmaWxl
IGFmdGVyIGVycm9yIGhhbmRsaW5nLCBzbyB3ZSBjYW4ndCBzaW1wbHkgZGlzc29sdmUgaXQNCmJl
Y2F1c2Ugb3RoZXJ3aXNlIGFub3RoZXIgcHJvY2VzcyByZWFkaW5nIHRoZSBodWdlcGFnZSBzZWVz
IHplcm9lZCBvbmUNCndpdGhvdXQga25vd2luZyB0aGUgbWVtb3J5IGVycm9yLg0KDQpUaGFua3Ms
DQpOYW95YSBIb3JpZ3VjaGkNCg0KPiArCQlwdXRfcGFnZShocGFnZSk7DQo+ICAJCWlmIChfX3Bh
Z2VfaGFuZGxlX3BvaXNvbihwKSkgew0KPiAgCQkJcGFnZV9yZWZfaW5jKHApOw0KPiAgCQkJcmVz
ID0gTUZfUkVDT1ZFUkVEOw0KPiAtLSANCj4gMi4yMy4w
