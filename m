Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284255891D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiHCRy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiHCRyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:54:24 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437152473
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659549263; x=1691085263;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=GL+dF9KFJisyAzA1sIBj6riKCUrDbge5lJzcDwW1M18=;
  b=kKeiqwtN58Q0mMi6Eo2ABfRF25F9VcN06amBFRnPF5hxByDOCJEWfn3j
   fYZHpZwEJE/rGY9CuhDQGxgrn9zaoPbpn8BKdMkws3lXbbWkvBuOzofxu
   Q+hqlbGoD8llj3E9hVAHXeYZ5VbFgYO8Tvo0V1T5shEoHqvjjcD2/UBdh
   g=;
X-IronPort-AV: E=Sophos;i="5.93,214,1654560000"; 
   d="scan'208";a="1040624458"
Subject: Re: [PATCH 2/2] virt: vmgenid: add support for generation counter
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 17:54:06 +0000
Received: from EX13D37EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id 1B879201075;
        Wed,  3 Aug 2022 17:54:04 +0000 (UTC)
Received: from [192.168.18.61] (10.43.162.134) by EX13D37EUA003.ant.amazon.com
 (10.43.165.7) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Wed, 3 Aug
 2022 17:53:59 +0000
Message-ID: <88126336-191f-8e19-a32a-6ee653d28db0@amazon.es>
Date:   Wed, 3 Aug 2022 19:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <tytso@mit.edu>, <Jason@zx2c4.com>,
        <dwmw@amazon.co.uk>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>, <ani@anisinha.ca>,
        <imammedo@redhat.com>, <bchalios@amazon.es>
References: <20220803152127.48281-1-bchalios@amazon.es>
 <20220803152127.48281-3-bchalios@amazon.es> <YuqUjUBxq6X738t/@kroah.com>
From:   "Chalios, Babis" <bchalios@amazon.es>
In-Reply-To: <YuqUjUBxq6X738t/@kroah.com>
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D47UWA002.ant.amazon.com (10.43.163.30) To
 EX13D37EUA003.ant.amazon.com (10.43.165.7)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAzLzgvMjIgMTc6MzAsIEdyZWcgS0ggd3JvdGU6Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBv
cmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5k
ZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4KPgo+Cj4KPiBPbiBXZWQsIEF1ZyAwMywg
MjAyMiBhdCAwNToyMToyN1BNICswMjAwLCBiY2hhbGlvc0BhbWF6b24uZXMgd3JvdGU6Cj4+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBmb3BzID0gewo+PiArICAgICAub3du
ZXIgPSBUSElTX01PRFVMRSwKPj4gKyAgICAgLm9wZW4gPSB2bWdlbmlkX29wZW4sCj4+ICsgICAg
IC5yZWFkID0gdm1nZW5pZF9yZWFkLAo+PiArICAgICAubW1hcCA9IHZtZ2VuaWRfbW1hcCwKPj4g
KyAgICAgLmxsc2VlayA9IG5vb3BfbGxzZWVrLAo+IFdoZXJlIGlzIHRoaXMgbmV3IHVzZXIva2Vy
bmVsIGFwaSBiZWluZyBkb2N1bWVudGVkPwo+Cj4gU2VlLCBwdXQgaXQgaW4gdGhlIGNvZGUgcGxl
YXNlLCBubyBvbmUga25vd3MgdG8gbG9vayBpbiBhIHJhbmRvbSBmaWxlIGluCj4gRG9jdW1lbnRh
dGlvbi8KQWdyZWVkISBXaWxsIG1vdmUgaXQgaW4gdGhlIGNvZGUuCj4KPgo+PiArfTsKPj4gKwo+
PiArc3RhdGljIHN0cnVjdCBtaXNjZGV2aWNlIHZtZ2VuaWRfbWlzYyA9IHsKPj4gKyAgICAgLm1p
bm9yID0gTUlTQ19EWU5BTUlDX01JTk9SLAo+PiArICAgICAubmFtZSA9ICJ2bWdlbmlkIiwKPj4g
KyAgICAgLmZvcHMgPSAmZm9wcywKPj4gICB9Owo+Pgo+PiAgIHN0YXRpYyBpbnQgcGFyc2Vfdm1n
ZW5pZF9hZGRyZXNzKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlLCBhY3BpX3N0cmluZyBvYmpl
Y3RfbmFtZSwKPj4gQEAgLTU3LDcgKzEyNCw3IEBAIHN0YXRpYyBpbnQgdm1nZW5pZF9hZGQoc3Ry
dWN0IGFjcGlfZGV2aWNlICpkZXZpY2UpCj4+ICAgICAgICBwaHlzX2FkZHJfdCBwaHlzX2FkZHI7
Cj4+ICAgICAgICBpbnQgcmV0Owo+Pgo+PiAtICAgICBzdGF0ZSA9IGRldm1fa21hbGxvYygmZGV2
aWNlLT5kZXYsIHNpemVvZigqc3RhdGUpLCBHRlBfS0VSTkVMKTsKPj4gKyAgICAgc3RhdGUgPSBk
ZXZtX2t6YWxsb2MoJmRldmljZS0+ZGV2LCBzaXplb2YoKnN0YXRlKSwgR0ZQX0tFUk5FTCk7Cj4+
ICAgICAgICBpZiAoIXN0YXRlKQo+PiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPj4K
Pj4gQEAgLTc0LDYgKzE0MSwyNyBAQCBzdGF0aWMgaW50IHZtZ2VuaWRfYWRkKHN0cnVjdCBhY3Bp
X2RldmljZSAqZGV2aWNlKQo+Pgo+PiAgICAgICAgZGV2aWNlLT5kcml2ZXJfZGF0YSA9IHN0YXRl
Owo+Pgo+PiArICAgICAvKiBCYWNrd2FyZHMgY29tcGF0aWJpbGl0eS4gSWYgQ1RSQSBpcyBub3Qg
dGhlcmUgd2UganVzdCBkb24ndCBleHBvc2UKPj4gKyAgICAgICogdGhlIGNoYXIgZGV2aWNlCj4+
ICsgICAgICAqLwo+PiArICAgICByZXQgPSBwYXJzZV92bWdlbmlkX2FkZHJlc3MoZGV2aWNlLCAi
Q1RSQSIsICZzdGF0ZS0+Z2VuX2NudHJfYWRkcik7Cj4+ICsgICAgIGlmIChyZXQpCj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIDA7Cj4+ICsKPj4gKyAgICAgc3RhdGUtPm5leHRfY291bnRlciA9IGRl
dm1fbWVtcmVtYXAoJmRldmljZS0+ZGV2LCBzdGF0ZS0+Z2VuX2NudHJfYWRkciwKPj4gKyAgICAg
ICAgICAgICAgICAgICAgIHNpemVvZih1MzIpLCBNRU1SRU1BUF9XQik7Cj4+ICsgICAgIGlmIChJ
U19FUlIoc3RhdGUtPm5leHRfY291bnRlcikpCj4+ICsgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+
ICsKPj4gKyAgICAgbWVtY3B5KCZzdGF0ZS0+bWlzYywgJnZtZ2VuaWRfbWlzYywgc2l6ZW9mKHN0
YXRlLT5taXNjKSk7Cj4+ICsgICAgIHJldCA9IG1pc2NfcmVnaXN0ZXIoJnN0YXRlLT5taXNjKTsK
Pj4gKyAgICAgaWYgKHJldCkgewo+PiArICAgICAgICAgICAgIGRldm1fbWVtdW5tYXAoJmRldmlj
ZS0+ZGV2LCBzdGF0ZS0+bmV4dF9jb3VudGVyKTsKPj4gKyAgICAgICAgICAgICByZXR1cm4gMDsK
PiBXaHkgYXJlIHlvdSBub3QgcmV0dXJuaW5nIGFuIGVycm9yPyAgV2h5IGlzIHRoaXMgb2s/Cj4K
PiBBbmQgd2h5IGNhbGwgZGV2bV9tZW11bm1hcCgpIGRpcmVjdGx5PyAgVGhhdCBraW5kIG9mIGRl
ZmVhdHMgdGhlIHB1cnBvc2UKPiBvZiB1c2luZyBkZXZtX21lbXJlbWFwKCksIHJpZ2h0PwpUaGUg
aW50ZW50aW9uIGhlcmUgd2FzIHRvIG5vdCBmYWlsIHRoZSB3aG9sZSBBQ1BJIGRldmljZSBpZiBy
ZWdpc3RlcmluZyAKdGhlIG1pc2MgZGV2aWNlIGZhaWxzLiBNeSByYXRpb25hbGUKd2FzIHRoYXQg
dGhlIEFDUEkgZGV2aWNlIGlzIHVzZWQgZm9yIG90aGVyIHRoaW5ncyBhcyB3ZWxsIChyZS1zZWVk
aW5nIFJORykuCgo+Cj4gdGhhbmtzLAo+Cj4gZ3JlZyBrLWgKCkNoZWVycywKQmFiaXMKQW1hem9u
IFNwYWluIFNlcnZpY2VzIHNvY2llZGFkIGxpbWl0YWRhIHVuaXBlcnNvbmFsLCBDYWxsZSBSYW1p
cmV6IGRlIFByYWRvIDUsIDI4MDQ1IE1hZHJpZC4gUmVnaXN0cm8gTWVyY2FudGlsIGRlIE1hZHJp
ZCAuIFRvbW8gMjI0NTggLiBGb2xpbyAxMDIgLiBIb2phIE0tNDAxMjM0IC4gQ0lGIEI4NDU3MDkz
Ngo=

