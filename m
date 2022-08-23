Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9215359D06E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiHWFYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHWFYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:24:21 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120087.outbound.protection.outlook.com [40.107.12.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167DB5C977
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8ihUL6DCUUKh+N1OEkp8fcPnZg+HfZph2t4ZzcYtZHc+rmA2MJOzFQZQQT3m4RhAFn6jvx10A+C6Fm1ZPNKtr4WclmiUzkPTpZiwklFwpRZthnmvG58pMvY0qLteN8VIJWtgqYVIh/BVm3Cg8JyNXYPODEoMrr2jekWbcdyNzHUXdMwML7iW+H9q4Sz7FdVLeXxU2OI7D97mSYNzAazUgX7FJq++OV3TLCKk0o7TCiZ3d91s5KKgBcQNWUoQf3hQ1wOJucQEsiPH5ecBgufP1RlVxwcIyNpsOIniuPu8aZi3wtmqIgEPndbg15A4C7rTUkHmmIKjHb1dZLx1Hy9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZSKUUGc0047HsYG64zP81otPpYpCP2QWoGuX21dBWU=;
 b=XOAtGr6L5LlbkXsv6VTNCC0ddDQWzR2EOn35J4pEEWIDjWMb/2WDrU52j07As2wqxzKJRAjSF3GHmZYqUbfdjs4kJkQ8264w7a8jQ26x1CHmzoYXrPhc4vfUFNySnp1QoXvB9FuFeGlBnPfCwIv07Nyk1P8mvX2PhJC6hKr9nIeCtZCtmQ+m1as6nTEvKX7iuSbYdfN51aRWmFldeeEktOvdnxVsSRBqNIWGOnlgJZWKRsULAii3A8/yWKNZZqr9XXu87wbEGu9dfgn6O7G4JVqVMjLV8WRPKYR14SlG5UGrW35/XOdsFOaEuCvODUM2ZW9RYBnU+VpZ6vlHkmRHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZSKUUGc0047HsYG64zP81otPpYpCP2QWoGuX21dBWU=;
 b=th7QPG2Xoh+dPs9SWaDYbCBEO2LJw4xkD4yzlG+Ui1CdF4fUghcbcnp3wG+okCvvcoS7uxeq2Xb9pGoEEs4z8vEuM9x1W3AUwj+OVclKFBzAf4xfzw23GNxrYZYXO14drKjIij7psk8lHjVvnCTWTSz2OTonWeMHZs3QeE8zgw+d+8aUKyS3Vzt/WWY7yKz2keFTl0RRnWGaBIbqXYpBScNikxiuwyIHIE/6f2hJv92QFTi811nUrkxMtciXW9/+Pd/uuE9Vo8afJm9OVyG3a+xUx23iY/ee6zeFTkvozqZDAJxvb95QRVM7DrhzzIqwdCSploygkOxq8+xEVIkCLw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB4163.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:25::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 05:24:14 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 05:24:14 +0000
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
Subject: Re: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Thread-Topic: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Thread-Index: AQHYtCxluEXLt15y9kSkQpSsai/RVK26d60AgAEsPgCAAFTlgA==
Date:   Tue, 23 Aug 2022 05:24:14 +0000
Message-ID: <a4a9ba6f-9891-cc4c-e512-d221141d998f@csgroup.eu>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
 <d5272f42-f3e3-b2a8-428e-bd7815cf7518@csgroup.eu>
 <YwQdRg/IS0+3tbNu@MiWiFi-R3L-srv>
In-Reply-To: <YwQdRg/IS0+3tbNu@MiWiFi-R3L-srv>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a756073-6912-4e1e-b1db-08da84c7b826
x-ms-traffictypediagnostic: MR1P264MB4163:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJXdA98c92gHcWJQFTxroxClNRpWtCX/gdPlx9kGjVnb+PPXEwP/CkxlzzbhlmZTKFRvdlCb1GHdXspeBMT7qmOW7KxmYn1i5pr0mB9a3YL5fjvw/jFNMqhZAXpwie1ys16e5LLzDoWWo4ajKnSIEyMMGCZthT8vzU0EKkzjscEXxAs6YMkyL9xXVWKjkV9t0p/jGy7rDI+qSJIJby9x+eJ5Mt+E0tWcdWoHzf6ieVFCxQF6who2PQxbuEqkgWCq0sG/ClvqvU/byHb8L+rDLBwoFEepe1/3POzAn16iSVJ2SMgBgsrIhRNfGG6NdKMr+7owl3hAXHItAQ9jfgQ4fGH28oQdp8jxgB859QvvuT/O49532nZ/tCPwZPckDEaj+OMaDbtlPAJyF0WC+0530b5hdJM7RI31t8VnPrEHQLfERpTeF2JyIIp9zNh/kkLRVq9Erj2ZfXH/psiMo25w/NN2azLizkaUHOQxNJP/GtBHLx+aBv5LtpvIZ7sQzoq1XEzuEWPSXn9KyznzIkbnnW521CCwE2yV4KDIrgKSN87qT163Tu+957lFpyOK7MKimWRfyizUJCR7rlTs++bedQicBS7LOtz3GmqhC5etVd+fanfjl6+6e7UrOvO9yn0XHk2EBPR8Cdld79EuaobwdGTvHEDfqFFeB6erUY46OnRMULxmkTsci4YXQ1CCH86lBvQg7bQ0m8vo5K1YkIxi0DtBJ2GvtFgZZnxDnZkg5A9EZl3yqxQ8DqcGi0dI8dw6UiKb2D1IbOFkCbBU0zSriye2qMfItLD+vI7DIDnQQmoOy6kWT0Kej8VtBAFTSxUW73/TE9CwGE7ikiTyTxQ905Wf0GtLgtxKxAFPf2ez5qA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(83380400001)(38070700005)(5660300002)(54906003)(2616005)(66574015)(186003)(4326008)(6916009)(66476007)(66446008)(316002)(66556008)(8676002)(66946007)(8936002)(76116006)(91956017)(36756003)(64756008)(44832011)(31686004)(41300700001)(26005)(6506007)(478600001)(71200400001)(31696002)(6486002)(966005)(2906002)(86362001)(38100700002)(6512007)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUFyZC96dVRQYTUrTXZaSXh3U1QzYnA5YW4wYXBlMDNYdm9nS0w0R3k4bTND?=
 =?utf-8?B?UnFvOERjWU9MRDFVUXpqdUxWcThTaUUxNFppbUlTUnNhNWFxYjkzZGNSb1g2?=
 =?utf-8?B?NlJ2dExtWDNwQ1hPUm14a2pzalVZZFNaYmZiWTZoR05CbGRQUi9zK2E0WERJ?=
 =?utf-8?B?YnpkUW9WR09mWFpsY05jakZvNnhtZlYwWXZmLy9jd1BnQUlCV1czMGtERm85?=
 =?utf-8?B?enRtRXJaUTZGVDRMU2JJamlzQ2FOZU5KVXpFWk0ycDFHTmI0dTVyM09VQ1hE?=
 =?utf-8?B?MDFLUkNvQkVZMll3VVdqY1NidHVaMXMyUWxkblZ2Zyt1N0wvamlyTGRkVEYz?=
 =?utf-8?B?V1ZNQkt4YWtDNUdrVWdqNWIzNHd6NXJxMjlzYi9HSFhXckVDZDI2TE9ncnVq?=
 =?utf-8?B?Nm9LRUw1WUR0Q2ljL1hlYVUvOFVwbTg0UDMvYWJobCtteXYrdm9jOXh5NjNR?=
 =?utf-8?B?dEJtZC9DbEYyZHdWcklNc2wvNGs3U09BUWlPZE1BT3MwQmpqK0ZUNXdOejJz?=
 =?utf-8?B?NWtsSU5xbTNLVHlYTW9lL0Y1RTZxRTVJVXltQWZ6cmF1UlhkZmVIRkw0a0Jz?=
 =?utf-8?B?eVgrYmFad0ZvVDVzSjNBak5WWDRGWGtvMzREWFJZODJFUnJJWGg3b1EvNitn?=
 =?utf-8?B?NmJycjd3dzIwSzJzcFVnaWNDeE9KZXNQQU1RVm9tZXQvamJ2UVlxSmlzaEdN?=
 =?utf-8?B?aHhjQVpvZmY1YUQvTHFBWGhHaDlHOU1KWVpSeTFjak5tcXNRdjN0SzY3WWUx?=
 =?utf-8?B?RkJ2NnNqNE0xclRGVW5kT3hXUkk5YnRFSGdwSWliaFkza0I5OVNlNWx5YTFQ?=
 =?utf-8?B?NG14bVJnYVMwc2pxdk11aUFxd2RMUnBOV2dudFlZWjRMQVpGVy9Nc3JnbndV?=
 =?utf-8?B?b3Q4aVpLZmpPWXA4YkVmSkpCQ0hucDdZbmk0NEZVaUhvVXJXVG5PQXQzVmlp?=
 =?utf-8?B?djBob2ZjanFjdjVxYTRlZzl6RE9UdTIycStQSG5nRGR5TWNwNEdybm0vSERr?=
 =?utf-8?B?NWUycldFa0gvbXhlU2RuWXF3T2c5bG83QjBKQkg0cDZHUHNCQmhWYXBjVXFv?=
 =?utf-8?B?bXM3ajlVSTk3TlVNeTdxcGFudWhWS0RrYStSUjdnN1dLQzFjRENQd0hoWTdZ?=
 =?utf-8?B?YXk0WS9CMVRiUUVDNy8xVFZwUjNlWWJ6WUZGekFQQXlIZk4xbnBQR3Q2ZjZ5?=
 =?utf-8?B?Y3BEUTg2cEY1TklXVFJ6Z0xlS3FrZHN4cndyaW5kbHkvZWxmN3FyMWJ0N0Ja?=
 =?utf-8?B?OFdZdEh0QXRJamRkNmlpazYyK28zbHlURWpIZWo0cWRaRG5EdVRVZ2VtWmpt?=
 =?utf-8?B?UmpQck83cjlDZ3BMSWJSd1hPeDNjRmdKRnhKSlo2bmxRU05jaEZmWGpQSWxT?=
 =?utf-8?B?aTJiMGJjTWFwQzZ4dWt6dW1EK3dkalFNNWVrekFiNDFDNHM4bmpFTTlyalJ2?=
 =?utf-8?B?WFpsaWZoWWpQT1hPKzRWMnZYT2JINi9tRlhZQWVUTVR4WXpXUytQcVhXTEZX?=
 =?utf-8?B?ZnpxejE4aStqOGs2aXdHWkhhK3JoekhXZVExRG5VQk5MbHk0QVJHZExoOFU5?=
 =?utf-8?B?b091N0VlMmdQdFpoS3BXNSs3VXdQQ1VnaE5SOWpldStjZGV6bW9lZlB1UHJ6?=
 =?utf-8?B?VHlQSTc5VkVCVEQxZlVZTklSRE9DY1F3ZWtuZ1ExRlRuNlQzVkVSOXdjWity?=
 =?utf-8?B?YzFxYitMWFRUL09MY2FFRGxQOURhT0VyVngwd01Pd2pIMC9YNWZXTW1XWHlP?=
 =?utf-8?B?RGQ4a1l1V0pYbVIyYW11SmhQZTM4MzZ6Rkd5bzVLRllwdFhRc0FkN0hSMnhJ?=
 =?utf-8?B?cVB1U3VLbGZMVDUrOU5pMVNta2ZzRE5RclU1bmMzQ3RVL0pJeTE0NitIUlI2?=
 =?utf-8?B?VTBmaTY0SWdVbndWVURValdrVzNoMEVTc1FtbHZLTHZ2SHRDQmZ2OENxZGRI?=
 =?utf-8?B?cFNDU2pvdUR3M1pnZjEvTnU1Z0lmcExJWGVnbXR5WUhGclVFNUkyZXYvUlN5?=
 =?utf-8?B?emQyZEhxbUFybmJZdXdmUnJmZjRYd1k1dk01V1JBVCtlRHpMcmY4eW9hdVRP?=
 =?utf-8?B?Ny9zeFU5eVFZdElhUHdNbUR4K214REZrN21waDZXNkdTTGl1OThSVkNyZVMv?=
 =?utf-8?B?Z0xEcEVObDFzUHFpekFHZmJmMkFPN3ZJTzd1UTRMOG94YUgvNGxIdE9peW1U?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FB29EECF5978E44AB3EFE98C56B1314@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a756073-6912-4e1e-b1db-08da84c7b826
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 05:24:14.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jX7WS2Md1nGpS+MJ5ZFCxci1Uu5WCGPw+kR59A4+7ONlkMh1LRWGbOxkZ/vwKXqbLDZ0mw3z+uqkK+hjK2VeBWio6WYGAbBh1Vx6E8ib6wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB4163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA4LzIwMjIgw6AgMDI6MjAsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gT24g
MDgvMjIvMjIgYXQgMDY6MjVhbSwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+DQo+Pg0KPj4g
TGUgMjAvMDgvMjAyMiDDoCAwMjozMSwgQmFvcXVhbiBIZSBhIMOpY3JpdMKgOg0KPj4+IEluIHNv
bWUgYXJjaGl0ZWN0dXJlcywgdGhlcmUgYXJlIEFSQ0ggc3BlY2lmaWNpIGlvIGFkZHJlc3MgbWFw
cGluZw0KPj4+IGhhbmRsaW5nIHdoZW4gY2FsbGluZyBpb3JlbWFwKCkgb3IgaW9yZW1hcF9wcm90
KCksIGUuZywgYXJjLCBpYTY0LA0KPj4+IG9wZW5yaXNjLCBzMzkwLCBzaC4NCj4+Pg0KPj4+IElu
IG9kZXIgdG8gY29udmVydCB0aGVtIHRvIHRha2UgR0VORVJJQ19JT1JFTUFQIG1ldGhvZCwgd2Ug
bmVlZCBjaGFuZ2UNCj4+PiB0aGUgcmV0dXJuIHZhbHVlIG9mIGhvb2sgaW9yZW1hcF9hbGxvd2Vk
KCkgYW5kIGlvdW5tYXBfYWxsb3dlZCgpLg0KPj4+IE1lYW53aGlsZSwgcmVuYW1lIHRoZW0gdG8g
YXJjaF9pb3JlbWFwKCkgYW5kIGFyY2hfaW91bm1hcCgpIHRvIHJlZmxlY3QNCj4+PiB0aGVpciBj
dXJyZW50IGJlaGF2aW91ci4NCj4gDQo+IFRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KPiANCj4+DQo+
PiBQbGVhc2UgZG9uJ3QganVzdCBzYXkgeW91IG5lZWQgdG8gY2hhbmdlIHRoZSByZXR1cm4gdmFs
dWUuIEV4cGxhaW4gd2h5Lg0KPiANCj4gVGhlIDFzdCBwYXJhZ3JhcGggYW5kIHRoZSBzZW50ZW5j
ZSAnSW4gb2RlciB0byBjb252ZXJ0IHRoZW0gdG8gdGFrZQ0KPiBHRU5FUklDX0lPUkVNQVAgbWV0
aG9kJyB0ZWxsIHRoZSByZWFzb24sIG5vPw0KDQpXaGF0IEkgd291bGQgbGlrZSB0byByZWFkIGlz
IF93aHlfIHlvdSBuZWVkIHRvIGNoYW5nZSB0aGUgcmV0dXJuIHZhbHVlIA0KaW4gb3JkZXIgdG8g
Y29udmVydCB0byBHRU5FUklDX0lPUkVNQVANCg0KPiANCj4gDQo+Pg0KPj4gQW5kIHdoeSBkb2Vz
IGl0IG5lZWQgYSBuYW1lIGNoYW5nZSA/IFRoZSBuZXcgbmFtZSBzdWdnZXN0cyB0aGF0IHdoYXQg
d2FzDQo+PiBzaW1wbHkgYSBjaGVjayBmdW5jdGlvbiBiZWNvbWVzIG5vdyBhIGZ1bmN0aW9uIGRv
aW5nIHRoZSBqb2IuIElzIHRoYXQNCj4+IHRoZSBpbnRlbnRpb24gPw0KPiANCj4gWWVzLCBpdCdz
IG5vdCBhIHNpbXBsZSBjaGVja2luZyBhbnkgbW9yZS4gSXQgY291bGQgZG8gaW8gYWRkcmVzcyBt
YXBwaW5nDQo+IGluc2lkZSBhcmNoX2lvcmVtYXAoKSwgYW5kIGNvdWxkIG1vZGlmeSB0aGUgcGFz
c2VkIGluICdwaHlzX2FkZHInIGFuZA0KPiAncHJvdCcgaW4gcGF0Y2ggMi4gVGhlIGlvcmVtYXBf
YWxsb3dlZCgpIGlzbid0IGFwcHJvcHJpYXRlIHRvIHJlZmxlY3QNCj4gdGhvc2UuDQoNCkZhaXIg
ZW5vdWdoLCB0aGVuIGFsbCB0aGlzIG5lZWRzIHRvIGJlIGV4cGxhaW5lZCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UuDQoNCj4gDQo+Pg0KPj4NCj4+Pg0KPj4+ID09PQ0KPj4+ICAgIGFyY2hfaW9yZW1h
cCgpIHJldHVybiBhIGJvb2wsDQo+Pg0KPj4gSXQgaXMgbm90IGEgYm9vbC4gQSBib29sIGlzIGVp
dGhlciB0cnVlIG9yIGZhbHNlLg0KPiANCj4gVGhhbmtzLCBJIGZvcmdvdCB0byB1cGRhdGUgdGhp
cyBhY2NvcmRpbmdseS4NCj4gDQo+Pg0KPj4+ICAgICAgLSBJU19FUlIgbWVhbnMgcmV0dXJuIGFu
IGVycm9yDQo+Pj4gICAgICAtIE5VTEwgbWVhbnMgY29udGludWUgdG8gcmVtYXANCj4+PiAgICAg
IC0gYSBub24tTlVMTCwgbm9uLUlTX0VSUiBwb2ludGVyIGlzIHJldHVybmVkIGRpcmVjdGx5DQo+
Pj4gICAgYXJjaF9pb3VubWFwKCkgcmV0dXJuIGEgYm9vbCwNCj4+DQo+PiBTYW1lIGhlcmUsIG5v
dCBhIGJvb2wgZWl0aGVyLg0KPiANCj4gQW5kIHRoaXMgcGxhY2UuDQo+Pg0KPj4+ICAgICAgLSAw
IG1lYW5zIGNvbnRpbnVlIHRvIHZ1bm1hcA0KPj4+ICAgICAgLSBlcnJvciBjb2RlIG1lYW5zIHNr
aXAgdnVubWFwIGFuZCByZXR1cm4gZGlyZWN0bHkNCj4+Pg0KPj4+IFRoaXMgaXMgdGFrZW4gZnJv
bSBLZWZlbmcncyBiZWxvdyBvbGQgcGF0Y2guIENocmlzdG9waCBzdWdnZXN0ZWQgdGhlDQo+Pj4g
cmV0dXJuIHZhbHVlIGJlY2F1c2UgaGUgZm9yZXNhdyB0aGUgZG9hYmxpdHkgb2YgY29udmVydGlu
ZyB0byB0YWtlDQo+Pj4gR0VORVJJQ19JT1JFTUFQIG9uIG1vcmUgYXJjaGl0ZWN0dXJlcy4NCj4+
PiAgICAtIFtQQVRDSCB2MyA0LzZdIG1tOiBpb3JlbWFwOiBBZGQgYXJjaF9pb3JlbWFwL2lvdW5t
YXAoKQ0KPj4+ICAgIC0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNTE5MDgyNTUy
LjExNzczNi01LXdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tL1QvI3UNCj4+Pg0KPj4+IFdoaWxl
IGF0IGl0LCB0aGUgaW52b2NhdGlvbiBvZiBhcmNoX2lvcmVtYXAoKSBuZWVkIGJlIG1vdmVkIHRv
IHRoZQ0KPj4+IGJlZ2lubmluZyBvZiBpb3JlbWFwX3Byb3QoKSBiZWNhdXNlIGFyY2hpdGVjdHVy
ZXMgbGlrZSBzaCwgb3BlbnJpc2MsDQo+Pj4gaWE2NCwgbmVlZCBkbyB0aGUgQVJDSCBzcGVjaWZp
YyBpbyBhZGRyZXNzIG1hcHBpbmcgb24gdGhlIG9yaWdpbmFsDQo+Pj4gcGh5c2ljYWwgYWRkcmVz
cy4gQW5kIGluIHRoZSBsYXRlciBwYXRjaCwgdGhlIGFkZHJlc3MgZml4IHVwIGNvZGUNCj4+PiBp
biBhcmNoX2lvcmVtYXAoKSBhbHNvIG5lZWQgYmUgZG9uZSBvbiB0aGUgb3JpZ2luYWwgYWRkcmUg
b24gc29tZQ0KPj4+IGFyY2hpdGVjdHVyZXMuDQo+Pj4NCj4+PiBUaGlzIGlzIHByZXBhcmF0aW9u
IGZvciBsYXRlciBwYXRjaCwgbm8gZnVuY3Rpb25hbGl0eSBjaGFuZ2UuDQo+Pg0KPj4gTm8gZnVu
Y3Rpb25uYWwgY2hhbmdlLCByZWFsbHkgPw0KPiANCj4gWW91IG1lYW4gdGhlIG5ldyBhcmNoX2lv
cmVtYXAoKSBvd25pbmcgZGlmZmVyZW50IGRlZmluaXRpb24gb3IgdGhlDQo+IGludm9jYXRpb24g
b2YgYXJjaF9pb3JlbWFwKCkgbW92ZWQgdXAgaXMgZnVuY3Rpb25hbCBjaGFuZ2U/IE5vdyBJIGFt
DQo+IG5vdCBzdXJlIGFib3V0IHRoZSBsYXR0ZXIgb25lLCBtYXkgbmVlZCB1cGRhdGUgbXkga25v
d2xlZGdlIGJhc2UuDQoNCkJvdGggaW5kZWVkLiBJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIGZpcnN0
IHN0ZXAgaXMgbm90IGNoYW5naW5nIG11Y2ggdG8gDQp0aGUgbG9naWMsIGJ1dCBJIHRoaW5rIHRo
ZSBzaW1wbGUgZmFjdCB0byBjaGFuZ2UgdGhlIGFyZ3VtZW50cyBhbmQgbmFtZSANCmFyZSBzb21l
IGhvdyBhIGZ1bmN0aW9ubmFsIGNoYW5nZS4NCg0KPiANCj4gVGhhbmtzDQo+IEJhb3F1YW4NCj4g
