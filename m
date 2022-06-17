Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28D354F644
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380446AbiFQLFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380066AbiFQLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:05:37 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120051.outbound.protection.outlook.com [40.107.12.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE16C540;
        Fri, 17 Jun 2022 04:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS2iJsShMAFfAvTfIRDTZa1WUlZqbAnVe/wu/sMpVTfIS/8IZbidYPeTuBI0+ctTvMaae2AvNc7XTJK2gIOz0jZKXJsg3sgSo3OCbkf8D/wo6kmM4aUKLsfDFBNexJAX4y9Pm4ZTP2yb6aQP5ioh582W3IaazB/513MVkFJ2mTcPtIpzp9y0/RRYoUQOi8vO6se7nY/j2BjSnsLwwyPdCpz6dlakj3Sc+5bQX9lKgZC+R/9LJaOqPdsyBytmAs3XNux9m9SZ3kmZw7mopQ538gX4xXtN8ubNnIerPEBCdt1ospc9innDgdUZAFSVh4vx4JNzI5ntgDypo+b4csCLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/SkJ599AQEHvQlLJG9YzlrxxoS0f84POSSZW8Lzoo0=;
 b=oDZKbtdmO8XkMVMHTjzPnkD+LJmMBMbe6FHBdG3xa/MuElUnSJYA5kPJJvJ6yYMOQJzlEz4FcUAiK2EXhaG+2JmbIfSAatA6gj8yow05R2s2sGq/jp4GhjETp8CVGCzQQEeB5Wm7m7U+/ARTx/mkoA+QAnFz399wLCRNSkkXoAvC+z/BgCnZdR4z/Q5pJJKBepJL4IiDawdRVEADq82zj4Vel1GmHH6/gLsM/hbqXZVXQhEEjuC2Yh/a8b/tLaDdaZpZaG+UHLH+CJ40nUf72FqQ+LXfB0refrDeP3EF/CFNxv2imh9UlUgJf+/y3pnRn8KwwMCH4ju09hsGbqovzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/SkJ599AQEHvQlLJG9YzlrxxoS0f84POSSZW8Lzoo0=;
 b=0zPOGWoNqCLweLcAAzSJe6ZgeGQayDfn/rigMIJvG/Vt2WZRRDroRbudnPPOa5BBhA1Dpp3bogNFxto6zLBN2UkyQeOk/cFzCOdL9V5Dk2orSTD1FRQqgjrxJhSF+zfpdiL8xiSkQu4SuTxrfmd5wZ2Yscw/EG7oThLtHJ0yDQxzGrNe2Xhmn3LJPgC+HQUxsRnr4L0fCGcWMi6gwOws3ziyP2LwhnGXX2Z16+VnuDHHGQ5s6CHO/ReF+vpWXZ6zHUNBLkifApHY1ip1WTGfpJi/5tCL+Xdu8ihcSu5hhgLd5gdS7guLkKbwV9wOZNB8+OOB19VJaJd/mo0wqVSl8Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3786.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 11:05:33 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 11:05:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
Thread-Topic: [PATCH] usercopy: use unsigned long instead of uintptr_t
Thread-Index: AQHYgY56XB5uBmp1zEOymlHEC/X3ka1SGkAAgAADqACAAAiSAIAACqGAgAAMdQCAAANVgIAAJpIAgADVkYCAADQtAA==
Date:   Fri, 17 Jun 2022 11:05:32 +0000
Message-ID: <ec7f0c59-f67e-1d7e-c0b3-b0a409623e98@csgroup.eu>
References: <20220616143617.449094-1-Jason@zx2c4.com>
 <YqtAShjjo1zC6EgO@casper.infradead.org> <YqtDXPWdFQ/fqgDo@zx2c4.com>
 <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
 <Yqtd6hTS52mbb9+q@casper.infradead.org>
 <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
 <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
 <CAMuHMdXxAwbCQPn4jg8X=_p5cYkpvNE4bXfQHWk2vz2Y6hL2-w@mail.gmail.com>
In-Reply-To: <CAMuHMdXxAwbCQPn4jg8X=_p5cYkpvNE4bXfQHWk2vz2Y6hL2-w@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c48a4ef-9203-424f-8c70-08da50514c56
x-ms-traffictypediagnostic: PR0P264MB3786:EE_
x-microsoft-antispam-prvs: <PR0P264MB37865C6CA62EB43593A8FF6DEDAF9@PR0P264MB3786.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4/hHpoHO3siG/HfuXZEey2TtOtK/hyJ14OgEl01nfX7Ujy+aR7+kzc3RW92qeOKouesa94n7/Q80qoeBGdgZryhnNdNiFmWjYJ9whfJWBeld/G54DCbzK9XLOE2ucYmukEyFqmNRVzcGIlzSBQDfQNZ/a5P9U9ymnwZ8KoUx2M8Cv8tMePbcN7IDakG/O5kmqZAY86t+KYBqCpQ/3cqjOwH0yA114aEDNsBnj07raPThwVArQ7ydl7LyN4PVtq1JF9iQd6Ps4wxXI5Fa+J31ereN9kQHYqOwm1OhJFpNSssv7oTUDe7nJN7uRGK570CamcBayJBoxBqwLd18ASBr0mmwXhgwyj40NY0BpHa6ngJaCXn+Nx6m5q0Zj5mpzP9GSwTUh9gLTPJ2kF4V7rKSSiY5n2rzwBjlRUJQwYo62lLAaR+g2px7tnv7MHsUYiUF++Z53bwIk1sjhKi+IqfrxuGBYTZRVlEXTHlse2DJ9HTMH0nkfplgksy7l7ikhZ8FhzxT7q3EQveeFUMdt+ve30duvoyHMjNEzCcJTHh6C0LZxg6Q25gLB95lKhgDgG0nc1PozR/5QMqqx1T+Jg4Id52PI9gkXRT1fzuKWFjBdrf2Jki3aoQReeloib/74jEzz2yGShCPlnKqqopezIh4iz7/Q9SmO8+RPBok1bODYHRgtp499IPquqWrwibySlHeJ/68NE8tzNA5g04DOlEIacM1EiwCqS4jwwJLHMKvI7iUSeCfz4U2QhpbHwwITlwgCw7UR8SXUNt5PMwHIdrug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(122000001)(110136005)(54906003)(31696002)(6506007)(26005)(66556008)(86362001)(66946007)(6512007)(2616005)(38070700005)(6486002)(66476007)(5660300002)(38100700002)(186003)(4744005)(7416002)(316002)(498600001)(36756003)(8936002)(76116006)(91956017)(2906002)(64756008)(66446008)(44832011)(8676002)(4326008)(31686004)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akZ5NFFUdjVORkhwQzlnNHVlZzJvRGhkRWlSbDhFTDhBNWlpeFQ2WHk2UnpF?=
 =?utf-8?B?a3hrTXdMZ3pjS2Z6ZnRNbXFyWm1TZDAwZkJ6MmRQdGhFOWx2MDBVVHVuVEk5?=
 =?utf-8?B?NWhuVDcvZGNzSXpWbE5UYkVncDEzVXZ1MVE2L1pmeEVCbS91cG5leVcrS1Vn?=
 =?utf-8?B?SlpQMGR4Z1NLbUY2a05Va1lhZzgzWG5WV0x1UExCcmV2aXNzQWYwUVZWa3lD?=
 =?utf-8?B?VDkyTHBsYVdnQjVhaWwwSHh5QzBDNGl2UUQvQlhkazAwZHJnWEo5VFduMEZs?=
 =?utf-8?B?YlNpSGlxY3Jqbk9ISzYvZ21MU1NwNGRrb1RkeEFWNXZoNlJlWXZCTEhrMUNa?=
 =?utf-8?B?TEpEV0d2NXhsZUV5OTlVZG9IdVR1UmJndGo3b0F1c1lMaU1HV2RET2xFUCtR?=
 =?utf-8?B?U1h5NXBBNmVlRHEyVFVTamdGVUptK2RlbVI3RzUwQ1JwRjc2K2FkMVlUbEdW?=
 =?utf-8?B?OTh2bFFta0xsNFBJTUp3Nm1ZQmNVNzAxaVFmOTJsTERDajRjSk1TYWRvOTlh?=
 =?utf-8?B?bVc0dzM2Zi9zS2V1dmhCekdtdjc2dnZEK2tiVWsweG1IYk02NHNpblRpb2lY?=
 =?utf-8?B?dE4yN002TVU5U2YvazljN1pJRUhyVzg1U3B0SlZsR01rTnYxZFUzTUk1ZjVh?=
 =?utf-8?B?bkxtRnNZWHpvQXVxRER0NWRXeFlCNnpiMkV3UE1VR2kyNTBiNldDVXdjMldQ?=
 =?utf-8?B?UU5QWXhBRmwzVmpSOXlaT2VEWUNLbjlzTEdhTWxuZk8rS0VubnRCRUlDY0xD?=
 =?utf-8?B?aXI4ZkVZbzNXVCtldEs4YjFQM0FZNS8wNk1LTFRnbHV6aEppQjdCWGNVTUtn?=
 =?utf-8?B?aWttM3pLUzBkSHVqcFNCQVdiTDh1SCt4U0ZZMk81MHhEMXhZYkIzMXNTOFc3?=
 =?utf-8?B?OW5ubXBUZXdVT0ZoRVgrWHpKTGY4M0JFT3ZwMUxlOTVPU2J2SFh3VEg0YlVO?=
 =?utf-8?B?U1ZpVDZkSU5UMFdMY0c2UEdzWEREa2RidnlmU1NtcTJ0bTdFMUpPOEZ4ZnVP?=
 =?utf-8?B?eG02T2orS1kwaDFvOUxGYWxMQmNvbUgyc2o3WGh3VzBpcXZxTUJQNFhTQmYr?=
 =?utf-8?B?UytCdkZOWVQzbGxtQWdQdUE3TmpnQzBEOGpTYjVNenc1Qko5aE50SGRRQmhm?=
 =?utf-8?B?N041MlZNWml3SVZHMHVFQVlteUFnY21hdGhhSnJRSUY1NjNXUGZ5bmhzQlBB?=
 =?utf-8?B?R25YaVBxQ2dndVEyNldHZU0vMmFmemxXNWJhZzlXU29USWh3RDNkWTE4T0FL?=
 =?utf-8?B?UkxNK3c5blBtWHgycC91Z0dTQ3pGZzBWWWx0aGNURlg0SFI3cmZRaW01UGRB?=
 =?utf-8?B?SUNhV3YxQnFmdnMyOThrZG1uUUZDT0VUZTZNRW56SjB2bDJzV0RLa0Jjd3Az?=
 =?utf-8?B?bkJxd2VpZXBTQS9BS3ZzWXBld2NRSm41M3pqaWJjcWFBSlZZZUpra25IL3Bw?=
 =?utf-8?B?d2JsZnlodmtoSVdZeFFmdDNnSFd6WlVDUkVnUVdpck12RDFoRDIySU1tS05w?=
 =?utf-8?B?Z3RVcE5FZThzc1hNUC9TMWpQbkdUQk9ZMC9IME9ZNlZqTkVLMWVBU0hoUStJ?=
 =?utf-8?B?TFpsMUEvZEpyMXJva0o0cmM0a1NyUmlXU1FHYmtyM3NoRVhONk16Wld3dlZt?=
 =?utf-8?B?ZkVPN1FXSnhyYXZoZi9pUUJMUXl5N1ZqSElrNG45UThDZnpaNW91T0xHMVFJ?=
 =?utf-8?B?NTQ2ZkVkck05UTEzNHNwbnFtVjdlbzN6ZWNaWmQxRTRwN3ljbmI4blVzSXlw?=
 =?utf-8?B?NWtuUU9hZFVENWZzQS9FSjhIRmcrMFk5Q3I1U3E3WVdoUjZsblM2ZGZmdGJv?=
 =?utf-8?B?cHllNXFXR2tWVmxRSjloTldSUjBGektVSjBSTVlVZmJza2dMb3hEaG5xSnBw?=
 =?utf-8?B?YmRZdldHNnZjR09JMWlxK0p3Y1JMUDRkYk1Ja0ZXWWpiWTdaMDBEbjZ6QXlS?=
 =?utf-8?B?Mk01aE1YV1ZXN0JYRUxjWjhFRkNxV2NET1hZUEV2aXg2QUZQZmNuRXd6UHdM?=
 =?utf-8?B?TVpzdElaT2k0Y211dWRFRHV2N2JrNUNCRFlEZURBcGo1RW51WWcvN1VzSXg4?=
 =?utf-8?B?UkZnendodmljczJaSktmbGlRc012bUVscGJaUytDRnFFYldHSlNxYzYwejFa?=
 =?utf-8?B?SHdJZWUrdFlqSDdWTzJGdXIzUitCZ3lxcEw4NVBrczFuMHFBZEwwVDBkN3I5?=
 =?utf-8?B?TytVa05Nb2xhVmJVZG40RVRudmxxalkyanNzVjVJcjRVOUhUTllPK3hxSWtm?=
 =?utf-8?B?V3hzdVQyaEFjLzBEZDN4UkIzak9nS2RXYzdXZkpTU3h3Nk1ldlJYdzJnSmpG?=
 =?utf-8?B?QWpCeEtjamJ3Vnljdi82YnFmMlkwV0M4dlhvMlVseUFqaXJjT2pmN0RGdklB?=
 =?utf-8?Q?h/2/Atd5dy2ylmoBlHZoxYC2tm6VuvhsRB7Fp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4B5B5E775053B46B136A46F7D38608B@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c48a4ef-9203-424f-8c70-08da50514c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 11:05:32.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJudpVy3aRNZ8ePh9XymzMbNM3qm8ILn0kKb8Ta9xNS+fcOegxIGo5o+vqvn/AWUXD3/LA+6CbEvgxYDY7JYVOML6GO8qH/56L8xmKYStLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3786
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE3LzA2LzIwMjIgw6AgMDk6NTgsIEdlZXJ0IFV5dHRlcmhvZXZlbiBhIMOpY3JpdMKg
Og0KPj4gQnV0IGl0IHRoZW4gY2F1c2VzIHBvaW50bGVzcyBwcm9ibGVtcyB3aGVuIHBlb3BsZSBj
YW4ndCByZWFsbHkgcmVseSBvbg0KPj4gbW9yZSB0aGFuIDMyIGJpdHMgZm9yIGF0b21pYyBiaXQg
b3BlcmF0aW9ucywgYW5kIG9uIDY0LWJpdA0KPj4gYXJjaGl0ZWN0dXJlcyB3ZSB1bm5lY2Vzc2Fy
aWx5IHVzZSAibG9uZyIgYW5kIHdhc3RlIHRoZSB1cHBlciBiaXRzLg0KPiANCj4gV2VsbCwgYXRv
bWljIHdvcmtzIHVwIHRvIG5hdGl2ZSB3b3JkIHNpemUsIGkuZS4gbG9uZy4NCj4gDQoNCnBvd2Vy
cGM2NCBoYXMgYSBwYWlyIG9mIGluc3RydWN0aW9ucyB0byBwZXJmb3JtIDEyOGJpdHMgYXRvbWlj
IA0Kb3BlcmF0aW9ucyA6IGxxYXJ4IC8gc3RxY3gu
