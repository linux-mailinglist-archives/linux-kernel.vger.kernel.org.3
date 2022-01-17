Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095EC490F52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiAQRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:21:41 -0500
Received: from m1546.mail.126.com ([220.181.15.46]:59395 "EHLO
        m1546.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbiAQRU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:20:59 -0500
X-Greylist: delayed 3718 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 12:20:58 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=NN4og
        rSs0gJJBrXm9dRmZV++JTd7BimcLUvJToctfco=; b=pDBoBptPjEdnlZRT6pUVa
        rlKSoCB6yPf81/X9xcvcyMMJ2QKMkffxxb9ERLkLNOx3XTkH0e5Sn8m0Va6oGs0n
        pj2XKTY9gsuj3PTZRIUg6425wqFwhj6QGJYgPTrYFovtP0ZQGkJAcC3gQWB+vjuk
        ulFornaTdwB7/j5n2f8708=
Received: from jameshongleiwang$126.com ( [222.131.120.224] ) by
 ajax-webmail-wmsvr46 (Coremail) ; Mon, 17 Jan 2022 23:45:47 +0800 (CST)
X-Originating-IP: [222.131.120.224]
Date:   Mon, 17 Jan 2022 23:45:47 +0800 (CST)
From:   "Honglei Wang" <jameshongleiwang@126.com>
To:     "Honglei Wang" <wanghonglei@didichuxing.com>
Cc:     "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, wanghonglei@didichuxing.com
Subject: Re:[PATCH] sched/numa: initialize numa statistics when forking new
 task
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220113133920.49900-1-wanghonglei@didichuxing.com>
References: <20220113133920.49900-1-wanghonglei@didichuxing.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <56de780f.71f0.17e68b742c3.Coremail.jameshongleiwang@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LsqowAAnYYssj+VhQeUYAA--.5139W
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiYBKHrVpEF7CfdwADsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sIGZyaWVuZGx5IHBpbmcuLi4gYW55IGNvbW1lbnRzIGFib3V0IHRoaXM/CgpBdCAyMDIy
LTAxLTEzIDIxOjM5OjIwLCAiSG9uZ2xlaSBXYW5nIiA8d2FuZ2hvbmdsZWlAZGlkaWNodXhpbmcu
Y29tPiB3cm90ZToKPlRoZSBjaGlsZCBwcm9jZXNzZXMgd2lsbCBpbmhlcml0IG51bWFfcGFnZXNf
bWlncmF0ZWQgYW5kCj50b3RhbF9udW1hX2ZhdWx0cyBmcm9tIHRoZSBwYXJlbnQuIEl0IG1lYW5z
IGV2ZW4gaWYgdGhlcmUgaXMgbm8gbnVtYQo+ZmF1bHQgaGFwcGVuIG9uIHRoZSBjaGlsZCwgdGhl
IHN0YXRpc3RpY3MgaW4gL3Byb2MvJHBpZCBvZiB0aGUgY2hpbGQKPnByb2Nlc3MgbWlnaHQgc2hv
dyBodWdlIGFtb3VudC4gVGhpcyBpcyBhIGJpdCB3ZWlyZC4gTGV0J3MgaW5pdGlhbGl6ZQo+dGhl
bSB3aGVuIGRvIGZvcmsuCj4KPlNpZ25lZC1vZmYtYnk6IEhvbmdsZWkgV2FuZyA8d2FuZ2hvbmds
ZWlAZGlkaWNodXhpbmcuY29tPgo+LS0tCj4ga2VybmVsL3NjaGVkL2ZhaXIuYyB8IDIgKysKPiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPmRpZmYgLS1naXQgYS9rZXJuZWwvc2No
ZWQvZmFpci5jIGIva2VybmVsL3NjaGVkL2ZhaXIuYwo+aW5kZXggNmU0NzZmNmQ5NDM1Li4xYWEw
ZWMxMjNhNGIgMTAwNjQ0Cj4tLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jCj4rKysgYi9rZXJuZWwv
c2NoZWQvZmFpci5jCj5AQCAtMjgyNiw2ICsyODI2LDggQEAgdm9pZCBpbml0X251bWFfYmFsYW5j
aW5nKHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3MsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkKPiAJ
LyogUHJvdGVjdCBhZ2FpbnN0IGRvdWJsZSBhZGQsIHNlZSB0YXNrX3RpY2tfbnVtYSBhbmQgdGFz
a19udW1hX3dvcmsgKi8KPiAJcC0+bnVtYV93b3JrLm5leHQJCT0gJnAtPm51bWFfd29yazsKPiAJ
cC0+bnVtYV9mYXVsdHMJCQk9IE5VTEw7Cj4rCXAtPm51bWFfcGFnZXNfbWlncmF0ZWQJCT0gMDsK
PisJcC0+dG90YWxfbnVtYV9mYXVsdHMJCT0gMDsKPiAJUkNVX0lOSVRfUE9JTlRFUihwLT5udW1h
X2dyb3VwLCBOVUxMKTsKPiAJcC0+bGFzdF90YXNrX251bWFfcGxhY2VtZW50CT0gMDsKPiAJcC0+
bGFzdF9zdW1fZXhlY19ydW50aW1lCT0gMDsKPi0tIAo+Mi4xNC4xCg==
