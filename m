Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B9472223
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhLMIJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:09:37 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:26452 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhLMIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1639382977; x=1670918977;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=HEqR7xY/rPRkimxZEj9DB/Dz8QTd6cXAzU4HJhnSYM4=;
  b=AzulLClo0LWLVUu5+jQCNIn6UGjPqMwjNkOEQhxgljdUIWtI/gkfiae9
   ZbfV4Pk9/E8FPkueOsA7PZMLthqxCk9HmK4LWyjQeCLFnpctMcjtBcde+
   rdK4t/QRCI/PbbVZ4UfkwHFb5oXRZPoCFds0xygOHkUWmLMUwVEQj/Uha
   A=;
X-IronPort-AV: E=Sophos;i="5.88,202,1635206400"; 
   d="scan'208";a="161612729"
Subject: Re: [PATCH] rcu: Make rcu_state.n_online_cpus updates atomic
Thread-Topic: [PATCH] rcu: Make rcu_state.n_online_cpus updates atomic
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 13 Dec 2021 08:09:26 +0000
Received: from EX13MTAUEE002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com (Postfix) with ESMTPS id 7101B81657;
        Mon, 13 Dec 2021 08:09:23 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 13 Dec 2021 08:09:23 +0000
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 13 Dec 2021 08:09:23 +0000
Received: from EX13D08UEE001.ant.amazon.com ([10.43.62.126]) by
 EX13D08UEE001.ant.amazon.com ([10.43.62.126]) with mapi id 15.00.1497.026;
 Mon, 13 Dec 2021 08:09:22 +0000
From:   "Woodhouse, David" <dwmw@amazon.co.uk>
To:     "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Thread-Index: AQHX7+9Fj7dj9oU08EGA6BJE2KIvlawwEZiA
Date:   Mon, 13 Dec 2021 08:09:22 +0000
Message-ID: <471d6615f245168d4c6c96c7ac1ccabf56b75945.camel@amazon.co.uk>
References: <20211213070059.6381-1-quic_neeraju@quicinc.com>
In-Reply-To: <20211213070059.6381-1-quic_neeraju@quicinc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.61.68]
Content-Type: text/plain; charset="utf-8"
Content-ID: <643E4E5EC7C22449905E6B939C753E81@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTEzIGF0IDEyOjMwICswNTMwLCBOZWVyYWogVXBhZGh5YXkgd3JvdGU6
DQo+IFRvIHN1cHBvcnQgb25saW5pbmcgbXVsdGlwbGUgQ1BVcyBjb25jdXJyZW50bHksDQo+IGNo
YW5nZSByY3Vfc3RhdGUubl9vbmxpbmVfY3B1cyB1cGRhdGVzIHRvIGJlIGF0b21pYy4NCj4gTm90
ZSwgaXQncyBvayBmb3IgcmN1X2Jsb2NraW5nX2lzX2dwKCkgdG8gZG8gYQ0KPiBhdG9taWNfcmVh
ZCgmcmN1X3N0YXRlLm5fb25saW5lX2NwdXMpLCBhcyB0aGUNCj4gdmFsdWUgb2YgLm5fb25saW5l
X2NwdXMgc3dpdGNoZXMgZnJvbSAxLT4yLCBpbg0KPiByY3V0cmVlX3ByZXBhcmVfY3B1KCksIHdo
aWNoIHJ1bnMgYmVmb3JlIHRoZSBuZXcNCj4gQ1BVIGNvbWVzIG9ubGluZS4gU2ltaWxhcmx5IDIt
PjEgdHJhbnNpdGlvbiBoYXBwZW5zDQo+IGZyb20gcmN1dHJlZV9kZWFkX2NwdSgpLCB3aGljaCBl
eGVjdXRlcyBhZnRlciB0aGUNCj4gQ1BVIGlzIG9mZmxpbmVkLCBhbmQgcnVucyBvbiB0aGUgbGFz
dCBvbmxpbmUgQ1BVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmVlcmFqIFVwYWRoeWF5IDxxdWlj
X25lZXJhanVAcXVpY2luYy5jb20+DQoNCkluIG15IHBhcmFsbGVsLWJyaW5ndXAgc2VyaWVzLCB0
aGUgcHJlcGFyZSBzdGFnZXMgYXJlIHN0aWxsIGJlaW5nDQpleGVjdXRlZCBpbiBzZXJpZXMgb24g
dGhlIEJTUCwgc28gSSBkb24ndCB0aGluayB0aGlzIHBhdGNoIGlzIG5lZWRlZA0KeWV0LiBJJ20g
bm90IHN1cmUgd2UnZCBldmVyIGVuZCB1cCB3aXRoIHRoZSBwcmVwYXJlIHN0YWdlcyBiZWluZyBk
b25lDQppbiBwYXJhbGxlbCDigJQgdGhlIG1vc3QgSSBzZWUgdXMgZG9pbmcgaXMgb25saW5pbmcg
YSBzaW5nbGUgKmJhdGNoKiBvZg0KQ1BVcyBhdCBhIHRpbWUsIG11Y2ggbGlrZSBicmluZ3VwX25v
bmJvb3RfY3B1cygpIGRvZXMuDQoNCkJ1dCB0aGlzIHBhdGNoIGNlcnRhaW5seSBkb2Vzbid0ICpo
dXJ0Ki4NCg0KQWNrZWQtYnk6IERhdmlkIFdvb2Rob3VzZSA8ZHdtd0BhbWF6b24uY28udWs+DQoN
Cg0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRyZSAoTG9uZG9uKSBMdGQuIFJlZ2lzdGVyZWQg
aW4gRW5nbGFuZCBhbmQgV2FsZXMgd2l0aCByZWdpc3RyYXRpb24gbnVtYmVyIDA0NTQzMjMyIHdp
dGggaXRzIHJlZ2lzdGVyZWQgb2ZmaWNlIGF0IDEgUHJpbmNpcGFsIFBsYWNlLCBXb3JzaGlwIFN0
cmVldCwgTG9uZG9uIEVDMkEgMkZBLCBVbml0ZWQgS2luZ2RvbS4KCgo=

