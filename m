Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FEE54FF94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiFQV6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbiFQV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:58:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 962A1313A6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:58:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-126-6cpkLsUGM_CHX1Zq4-ZYMw-1; Fri, 17 Jun 2022 22:58:36 +0100
X-MC-Unique: 6cpkLsUGM_CHX1Zq4-ZYMw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 17 Jun 2022 22:58:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 17 Jun 2022 22:58:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Eric Dumazet' <edumazet@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        "Roman Penyaev" <rpenyaev@suse.de>
Subject: RE: [PATCH] locking/rwlocks: do not starve writers
Thread-Topic: [PATCH] locking/rwlocks: do not starve writers
Thread-Index: AQHYgoH9H7wjwRelWEixrawjXyXmm61UJB2A
Date:   Fri, 17 Jun 2022 21:58:35 +0000
Message-ID: <5b0e13f57d77408aad59b0e8f232da36@AcuMS.aculab.com>
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net>
 <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com>
 <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com>
 <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net>
 <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
 <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
 <CANn89i+wBM+ewcP9u+ZWDqv3zQeK7ovKB+YJf9S6Om5QkqhLHA@mail.gmail.com>
 <CAHk-=wi9ut1VkB=Ja_gYtH67DZ7cc5QBG-uJCPkOpU=MZDJSUw@mail.gmail.com>
 <CANn89iJXeUJRV2+8reUdaeARxYPPbCoG+9atmRFfy4kv0XX00A@mail.gmail.com>
In-Reply-To: <CANn89iJXeUJRV2+8reUdaeARxYPPbCoG+9atmRFfy4kv0XX00A@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDE3IEp1bmUgMjAyMiAyMDozOQ0KLi4uDQo+IEkg
YW0gY29udmVydGluZyBSQVcgc29ja2V0cyB0byBSQ1UuDQoNCkkgcHJlc3VtZSB0aGF0IGlzIGJl
Y2F1c2UgeW91IGFyZSBzaG92aW5nIGEgbG90IG9mIHBhY2tldHMNCnRocm91Z2ggdGhlbT8NCg0K
V2lsbCB0aGF0IHJlbW92ZSB0aGUgaG9ycmlkIGRlbGF5ZWQgZnJlZSBvZiB0aGUgcm91dGluZw0K
dGFibGUgZW50cnkgdGhhdCBnZXRzIGNyZWF0ZWQgZm9yIElQdjQgd2l0aCAnaGRyaW5jJw0KYmVj
YXVzZSB0aGUgYWRkcmVzcyBpbiB0aGUgcGFja2V0IG1pZ2h0IG5vdCBtYXRjaCB0aGF0DQppbiB0
aGUgYWRkcmVzcyBidWZmZXI/DQoNCkkndmUgc2VlbiB0aGUgc29mdGludCBjb2RlIHNwZW5kIGFn
ZXMgZG9pbmcgdGhlIGZpbmFsIGZyZWVzLg0KDQpXZSBoYXZlIGdvb2QgcmVhc29ucyBmb3IgdXNp
bmcgcmF3IHNvY2tldHMgdG8gc2VuZCBhIGxvdCBvZiBVRFAuDQpCdXQgJ2hkcmluYycgaGFzIHRv
IGJlIHVzZWQgdG8gZ2V0IHRoZSBVRFAgY2hlY2tzdW0gcmlnaHQuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

