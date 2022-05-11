Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6809952340A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbiEKNUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243519AbiEKNTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:19:49 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9B223E34E;
        Wed, 11 May 2022 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1652275187; x=1683811187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lh9K+giOiNlFyLkTxJKFiRE8lg/TsLPmFcvhvKDzV48=;
  b=b1U6k2ALXMJqc8zPzbkMpmiif5nJLrVBOui/QRDjBGnLaCvh30ycxzDK
   BhinQBH3jRtQMWgFi78WXGXWI262wLcHJm9RjBHis+St7FeV7dqQ9jk5I
   V7FYg5DI6NDhgPbkOzLHQ/ABuKu5dm1idNCNSnnCauAoXHglX7foT7abD
   Y=;
X-IronPort-AV: E=Sophos;i="5.91,217,1647302400"; 
   d="scan'208";a="87352345"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 11 May 2022 13:19:27 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com (Postfix) with ESMTPS id B3A1814373C;
        Wed, 11 May 2022 13:19:24 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 11 May 2022 13:19:24 +0000
Received: from [0.0.0.0] (10.43.160.178) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 13:19:21 +0000
Message-ID: <4537666b-a09d-2727-f797-a730ce8b76e6@amazon.com>
Date:   Wed, 11 May 2022 15:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
To:     Simo Sorce <simo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Colm MacCarthaigh" <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <8f305036248cae1d158c4e567191a957a1965ad1.camel@redhat.com>
 <YnsO1JGQm5FEkbJt@zx2c4.com>
 <f6a4a5ccb126053534bebe4b070fc1384839e919.camel@redhat.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <f6a4a5ccb126053534bebe4b070fc1384839e919.camel@redhat.com>
X-Originating-IP: [10.43.160.178]
X-ClientProxiedBy: EX13D32UWB001.ant.amazon.com (10.43.161.248) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2ltbywKCk9uIDExLjA1LjIyIDE0OjU5LCBTaW1vIFNvcmNlIHdyb3RlOgo+IEhpIEphc29u
LAo+Cj4gT24gV2VkLCAyMDIyLTA1LTExIGF0IDAzOjE4ICswMjAwLCBKYXNvbiBBLiBEb25lbmZl
bGQgd3JvdGU6Cj4+IE15IHByb3Bvc2FsIGhlcmUgaXMgbWFkZSB3aXRoIG5vbmNlIHJldXNlIGlu
IG1pbmQsIGZvciB0aGluZ3MgbGlrZQo+PiBzZXNzaW9uIGtleXMgdGhhdCB1c2Ugc2VxdWVudGlh
bCBub25jZXMuCj4gQWx0aG91Z2ggdGhpcyBtYWtlcyBzZW5zZSB0aGUgcHJvYmxlbSBpcyB0aGF0
IGNoYW5naW5nIGFwcGxpY2F0aW9ucyB0bwo+IGRvIHRoZSByaWdodCB0aGluZyBiYXNlZCBvbiB3
aGljaCBzaXR1YXRpb24gdGhleSBhcmUgaW4gd2lsbCBuZXZlciBiZQo+IGRvbmUgcmlnaHQgb3Ig
c29vbiBlbm91Z2guIFNvIEkgd291bGQgZm9jdXMgb24gYSBzb2x1dGlvbiB0aGF0IG1ha2VzCj4g
dGhlIENTUFJOR3MgaW4gY3J5cHRvIGxpYnJhcmllcyBzYWZlLgoKCkkgdGhpbmsgd2UgaW50cmlu
c2ljYWxseSBoYXZlIDIgc2V0cyBvZiBhcHBsaWNhdGlvbnM6IE9uZXMgdGhhdCB3YW50IGFuIApl
dmVudCBiYXNlZCBub3RpZmljYXRpb24gYW5kIGRvbid0IGNhcmUgYWJvdXQgdGhlIHJhY3luZXNz
IG9mIGl0IGFuZCAKb25lcyB0aGF0IHdhbnQgYW4gYXRvbWljIHdheSB0byBkZXRlcm1pbmUgdGhl
IGVwb2NoLiBVc2Vyc3BhY2UgUk5HcyBhcmUgCm5hdHVyYWxseSBpbiB0aGUgc2Vjb25kIGNhdGVn
b3J5LgoKCj4KPj4gQSBkaWZmZXJlbnQgaXNzdWUgaXMgcmFuZG9tIG5vbmNlcy4gRm9yIHRoZXNl
LCBpdCBzZWVtcyBsaWtlIGEgY2FsbCB0bwo+PiBnZXRyYW5kb20oKSBmb3IgZWFjaCBub25jZSBp
cyBwcm9iYWJseSB0aGUgYmVzdCBiZXQuIEJ1dCBpdCBzb3VuZHMgbGlrZQo+PiB5b3UncmUgaW50
ZXJlc3RlZCBpbiBhIHVzZXJzcGFjZSBSTkcsIGFraW4gdG8gT3BlbkJTRCdzIGFyYzRyYW5kb20o
MykuIEkKPj4gaG9wZSB5b3Ugc2F3IHRoZXNlIHRocmVhZHM6Cj4+Cj4+IC0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC9ZbkE1Q1VKS3ZxbVhKeGYyQHp4MmM0LmNvbS8KPj4gLSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sL1loNCs5K1VwYW5KV0FJeVpAengyYzQuY29tLwo+PiAtIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FIbU1FOXFIR1NGOHczRG95Q1ArdWRfTjBNQUo1
Xzh6c1VXeD1yeFFCMW1GbkdjdTl3QG1haWwuZ21haWwuY29tLwo+IDRjIGRvZXMgc291bmQgbGlr
ZSBhIGRlY2VudCBzb2x1dGlvbiwgaXQgaXMgc2VtYW50aWNhbGx5IGlkZW50aWNhbCB0bwo+IGFu
IGVwb2NoIHZtZ2VuaWQsIGFsbCB0aGUgbGlicmFyeSBuZWVkcyB0byBkbyBpcyB0byBjcmVhdGUg
c3VjaCBhIG1tYXAKPiByZWdpb24sIHN0aWNrIGEgdmFsdWUgb24gIGl0LCB2ZXJpZnkgaXQgaXMg
bm90IHplcm8gYWZ0ZXIgY29tcHV0aW5nIHRoZQo+IG5leHQgcmFuZG9tIHZhbHVlIGJ1dCBiZWZv
cmUgcmV0dXJuaW5nIGl0IHRvIHRoZSBjYWxsZXIuCj4gVGhpcyByZWR1Y2VzIHRoZSByYWNlIHRv
IGEgdmVyeSBzbWFsbCB3aW5kb3cgd2hlbiB0aGUgbWFjaGluZSBpcyBmcm96ZW4KPiByaWdodCBh
ZnRlciB0aGUgcmFuZG9tIHZhbHVlIGlzIHJldHVybmVkIHRvIHRoZSBjYWxsZXIgYnV0IGJlZm9y
ZSBpdCBpcwo+IHVzZWQsIGJ1dCBob3BlZnVsbHkgdGhpcyBqdXN0IG1lYW5zIHRoYXQgdGhlIHR3
byBtYWNoaW5lcyB3aWxsIGp1c3QKPiBtYWtlIHBhcmFsbGVsIGNvbXB1dGF0aW9ucyB0aGF0IHlp
ZWxkIHRoZSBleGFjdCBzYW1lIHZhbHVlLCBzbyBubwo+IGNhdGFzdHJvcGhpYyBjb25zZXF1ZW5j
ZSB3aWxsIGFyaXNlICh0aGVyZSBpcyB0aGUgb2RkIGNhc2Ugd2hlcmUgdHdvCj4gcmFuZG9tIHZh
bHVlcyBhcmUgc291Z2h0IGFuZCB0aGUgc3BsaXQgaGFwcGVucyBiZXR3ZWVuIHRoZSB0d28gYXJl
Cj4gcmV0cmlldmVkIGFuZCB0aGlzIGhhcyBiYWQgY29uc2VxdWVuY2VzLCBJIHRoaW5rIHdlIGNh
biBpZ25vcmUgdGhhdCkuCgoKVGhlIHByb2JsZW0gd2l0aCB3aXBpbmcgbWVtb3J5IG9uIGNsb25l
IGlzIHRoYXQgaXQgbWVhbnMgeW91IG11c3Qga2VlcCAKdGhlc2Ugc3BlY2lhbCB3aXBlIG9uIGNs
b25lIHBhZ2VzIGFsd2F5cyBwcmVzZW50IGFuZCBwaW5uZWQgaW4gbWVtb3J5IAphbmQgY2FuIG5v
IGxvbmdlciBzd2FwIHRoZW0gb3V0LCBjb21wYWN0IHRoZW0gb3IgbW92ZSB0aGVtIGZvciBtZW1v
cnkgCmhvdHBsdWcuCgpXZSBzdGFydGVkIHRoZSBqb3VybmV5IHdpdGggYSBXSVBFT05TVVNQRU5E
IGZsYWcgYW5kIGV2ZW50dWFsbHkgCmFiYW5kb25lZCBpdCBiZWNhdXNlIGl0IHNlZW1lZCBjbHVu
a3kuIEhhcHB5IHRvIHJlb3BlbiBpdCBpZiB3ZSBiZWxpZXZlIAppdCdzIGEgdmlhYmxlIHBhdGg6
CgogwqAgaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzgyNTIzMC8KCgpBbGV4CgoKCgpBbWF6b24g
RGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJs
aW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlz
cwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5
MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

