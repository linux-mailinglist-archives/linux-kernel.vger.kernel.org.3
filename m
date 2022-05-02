Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3436351769C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386926AbiEBSjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382231AbiEBSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:38:29 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12976380;
        Mon,  2 May 2022 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651516500; x=1683052500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vy6DRXPL+6ushSOLrBfXP1zxVNQE/eCyBjKmumEMxoY=;
  b=OLYACLmAIdY/ZGPzdQzF38Eyq4elZKoqUQmZir33OyiO0Oactglri+Ti
   a8lBpuGdGjFoi2gIaI7r6s8v2mH9exzjBYr7NvXg+uhoJIPjZ4SttItdM
   zcr0JYWpdh+Ox1ImkgAH2mo/jBvUR5oRw67m2nq5tEr8O5C9YoqNqCRBy
   Y=;
X-IronPort-AV: E=Sophos;i="5.91,192,1647302400"; 
   d="scan'208";a="192259419"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 02 May 2022 18:34:45 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com (Postfix) with ESMTPS id A17084187F;
        Mon,  2 May 2022 18:34:43 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 2 May 2022 18:34:43 +0000
Received: from [0.0.0.0] (10.43.161.15) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 2 May
 2022 18:34:40 +0000
Message-ID: <480469e6-0eb0-8d76-0b8d-111579e73701@amazon.com>
Date:   Mon, 2 May 2022 20:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Lennart Poettering <mzxreary@0pointer.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Colm MacCarthaigh" <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com> <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com> <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <YnAc4hwPyByF4kZ5@zx2c4.com>
X-Originating-IP: [10.43.161.15]
X-ClientProxiedBy: EX13D38UWC002.ant.amazon.com (10.43.162.46) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDAyLjA1LjIyIDIwOjA0LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4gSGV5IExlbm5h
cnQsCj4KPiBPbiBNb24sIE1heSAwMiwgMjAyMiBhdCAwNjo1MToxOVBNICswMjAwLCBMZW5uYXJ0
IFBvZXR0ZXJpbmcgd3JvdGU6Cj4+IE9uIE1vLCAwMi4wNS4yMiAxODoxMiwgSmFzb24gQS4gRG9u
ZW5mZWxkIChKYXNvbkB6eDJjNC5jb20pIHdyb3RlOgo+Pgo+Pj4+PiBJbiBvcmRlciB0byBpbmZv
cm0gdXNlcnNwYWNlIG9mIHZpcnR1YWwgbWFjaGluZSBmb3JrcywgdGhpcyBjb21taXQgYWRkcwo+
Pj4+PiBhICJmb3JrX2V2ZW50IiBzeXNjdGwsIHdoaWNoIGRvZXMgbm90IHJldHVybiBhbnkgZGF0
YSwgYnV0IGFsbG93cwo+Pj4+PiB1c2Vyc3BhY2UgcHJvY2Vzc2VzIHRvIHBvbGwoKSBvbiBpdCBm
b3Igbm90aWZpY2F0aW9uIG9mIFZNIGZvcmtzLgo+Pj4+Pgo+Pj4+PiBJdCBhdm9pZHMgZXhwb3Np
bmcgdGhlIGFjdHVhbCB2bWdlbmlkIGZyb20gdGhlIGh5cGVydmlzb3IgdG8gdXNlcnNwYWNlLAo+
Pj4+PiBpbiBjYXNlIHRoZXJlIGlzIGFueSByYW5kb21uZXNzIHZhbHVlIGluIGtlZXBpbmcgaXQg
c2VjcmV0LiBSYXRoZXIsCj4+Pj4+IHVzZXJzcGFjZSBpcyBleHBlY3RlZCB0byBzaW1wbHkgdXNl
IGdldHJhbmRvbSgpIGlmIGl0IHdhbnRzIGEgZnJlc2gKPj4+Pj4gdmFsdWUuCj4+Pj4gV291bGRu
J3QgaXQgbWFrZSBzZW5zZSB0byBleHBvc2UgYSBtb25vdG9uaWMgNjRiaXQgY291bnRlciBvZiBk
ZXRlY3RlZAo+Pj4+IFZNIGZvcmtzIHNpbmNlIGJvb3QgdGhyb3VnaCByZWFkKCk/IEl0IG1pZ2h0
IGJlIGludGVyZXN0aW5nIHRvIGtub3cKPj4+PiBmb3IgdXNlcnNwYWNlIGhvdyBtYW55IGZvcmtz
IGl0IG1pc3NlZCB0aGUgZm9yayBldmVudHMgZm9yLiBNb3Jlb3ZlciBpdAo+Pj4+IG1pZ2h0IGJl
IGludGVyZXN0aW5nIHRvIHVzZXJzcGFjZSB0byBrbm93IGlmIGFueSBmb3JrIGhhcHBlbmVkIHNv
IGZhcgo+Pj4+ICphdCogKmFsbCosIGJ5IGNoZWNraW5nIGlmIHRoZSBjb3VudGVyIGlzIG5vbi16
ZXJvLgo+Pj4gIk1pZ2h0IGJlIGludGVyZXN0aW5nIiBpcyBkaWZmZXJlbnQgZnJvbSAiZGVmaW5p
dGVseSB1c2VmdWwiLiBJJ20gbm90Cj4+PiBnb2luZyB0byBhZGQgdGhpcyB3aXRob3V0IGEgY2xl
YXIgdXNlIGNhc2UuIFRoaXMgZmVhdHVyZSBpcyBwcmV0dHkKPj4+IG5hcnJvd2x5IHNjb3BlZCBp
biBpdHMgb2JqZWN0aXZlcyByaWdodCBub3csIGFuZCBJIGludGVuZCB0byBrZWVwIGl0Cj4+PiB0
aGF0IHdheSBpZiBwb3NzaWJsZS4KPj4gU3VyZSwgd2hhdGV2ZXIuIEkgbWVhbiwgaWYgeW91IHRo
aW5rIGl0J3MgcHJlZmVyYWJsZSB0byBoYXZlIDMgQVBJCj4+IGFic3RyYWN0aW9ucyBmb3IgdGhl
IHNhbWUgY29uY2VwdCBlYWNoIGZvciBpdCdzIHNwZWNpYWwgdXNlY2FzZSwgdGhlbgo+PiB0aGF0
J3MgY2VydGFpbmx5IG9uZSB3YXkgdG8gZG8gdGhpbmdzLiBJIHBlcnNvbmFsbHkgd291bGQgdHJ5
IHRvCj4+IGZpZ3VyZSBvdXQgYSBtb2RpY3VtIG9mIGdlbmVyYWxpemF0aW9uIGZvciB0aGluZ3Mg
bGlrZSB0aGlzLiBCdXQgbWF5YmUKPj4gdGhhdCcganVzdCBtZeKApgo+Pgo+PiBJIGNhbiBqdXN0
IHRlbGwgeW91LCB0aGF0IGluIHN5c3RlbWQgd2UnZCBoYXZlIGEgdXNlY2FzZSBmb3IgY29uc3Vt
aW5nCj4+IHN1Y2ggYSBnZW5lcmF0aW9uIGNvdW50ZXI6IHdlIHRyeSB0byBwcm92aWRlIHN0YWJs
ZSBNQUMgYWRkcmVzc2VzIGZvcgo+PiBzeW50aGV0aWMgbmV0d29yayBpbnRlcmZhY2VzIG1hbmFn
ZWQgYnkgbmV0d29ya2QsIHNvIHdlIGhhc2ggdGhlbSBmcm9tCj4+IC9ldGMvbWFjaGluZS1pZCwg
YnV0IG90b2ggcGVvcGxlIGFsc28gd2FudCB0aGVtIHRvIGNoYW5nZSB3aGVuIHRoZXkKPj4gY2xv
bmUgdGhlaXIgVk1zLiBXZSBjb3VsZCB2ZXJ5IG5pY2VseSBzb2x2ZSB0aGlzIGlmIHdlIGhhZCBh
Cj4+IGdlbmVyYXRpb24gY291bnRlciBlYXNpbHkgYWNjZXNzaWJsZSBmcm9tIHVzZXJzcGFjZSwg
dGhhdCBzdGFydHMgYXQgMAo+PiBpbml0aWFsbHkuIEJlY2F1c2UgdGhlbiB3ZSBjYW4gaGFzaCBh
cyB3ZSBhbHdheXMgZGlkIHdoZW4gdGhlIGNvdW50ZXIKPj4gaXMgemVybywgYnV0IG90aGVyd2lz
ZSB1c2Ugc29tZXRoaW5nIGVsc2UsIHBvc3NpYmx5IGhhc2hlZCBmcm9tIHRoZQo+PiBnZW5lcmF0
aW9uIGNvdW50ZXIuCj4gVGhpcyBkb2Vzbid0IHdvcmssIGJlY2F1c2UgeW91IGNvdWxkIGhhdmUg
bWVtb3J5LUEgc3BsaXQgaW50byBtZW1vcnktQS4xCj4gYW5kIG1lbW9yeS1BLjIsIGFuZCBib3Ro
IEEuMiBhbmQgQS4xIHdvdWxkICsrY291bnRlciwgYW5kIHdpbmQgdXAgd2l0aAo+IHRoZSBzYW1l
IG5ldyB2YWx1ZSAiMiIuIFRoZSBzb2x1dGlvbiBpcyB0byBpbnN0ZWFkIGhhdmUgdGhlIGh5cGVy
dmlzb3IKPiBwYXNzIGEgdW5pcXVlIHZhbHVlIGFuZCBhIGNvdW50ZXIuIFdlIGN1cnJlbnRseSBo
YXZlIGEgMTYgYnl0ZSB1bmlxdWUKPiB2YWx1ZSBmcm9tIHRoZSBoeXBlcnZpc29yLCB3aGljaCBJ
J20ga2VlcGluZyBhcyBhIGtlcm5lbCBzcGFjZSBzZWNyZXQKPiBmb3IgdGhlIFJORzsgd2UncmUg
d2FpdGluZyBvbiBhIHdvcmQtc2l6ZWQgbW9ub3RvbmljIGNvdW50ZXIgaW50ZXJmYWNlCj4gZnJv
bSBoeXBlcnZpc29ycyBpbiB0aGUgZnV0dXJlLiBXaGVuIHdlIGhhdmUgdGhlIGxhdHRlciwgdGhl
biB3ZSBjYW4KPiBzdGFydCB0YWxraW5nIGFib3V0IG1tYXBhYmxlIHRoaW5ncy4gWW91ciB1c2Ug
Y2FzZSB3b3VsZCBwcm9iYWJseSBiZQo+IHNlcnZlZCBieSBleHBvc2luZyB0aGF0IDE2LWJ5dGUg
dW5pcXVlIHZhbHVlIChoYXNoZWQgd2l0aCBzb21lIGNvbnN0YW50Cj4gZm9yIHNhZmV0eSBJIHN1
cHBvc2UpLCBidXQgSSdtIGhlc2l0YW50IHRvIHN0YXJ0IGdvaW5nIGRvd24gdGhhdCByb3V0ZQo+
IGFsbCBhdCBvbmNlLCBlc3BlY2lhbGx5IGlmIHdlJ3JlIHRvIGhhdmUgYSBtb3JlIHVzZWZ1bCBj
b3VudGVyIGluIHRoZQo+IGZ1dHVyZS4KCgpNaWNoYWVsLCBzaW5jZSB3ZSBhbHJlYWR5IGNoYW5n
ZWQgdGhlIENJRCBpbiB0aGUgc3BlYywgY2FuIHdlIGFkZCBhIApwcm9wZXJ0eSB0byB0aGUgZGV2
aWNlIHRoYXQgaW5kaWNhdGVzIHRoZSBmaXJzdCA0IGJ5dGVzIG9mIHRoZSBVVUlEIHdpbGwgCmFs
d2F5cyBiZSBkaWZmZXJlbnQgYmV0d2VlbiBwYXJlbnQgYW5kIGNoaWxkPwoKVGhhdCBzaG91bGQg
Z2l2ZSB1cyB0aGUgYWJpbGl0eSB0byBtbWFwIHRoZSB2bWdlbmlkIGRpcmVjdGx5IHRvIHVzZXIg
CnNwYWNlIGFuZCBhY3QgYmFzZWQgb24gYSBzaW1wbGUgdTMyIGNvbXBhcmUgZm9yIGNsb25lIG5v
dGlmaWNhdGlvbiwgbm8/CgoKVGhhbmtzOwoKQWxleAoKCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBD
ZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRz
ZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2Vu
IGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBC
ZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

