Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518CF523429
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiEKNWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbiEKNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:21:58 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094D256212;
        Wed, 11 May 2022 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1652275267; x=1683811267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3jHRwtWUihggnpz3rDI3WciJRbfNX+tFdwfkwhJM9SE=;
  b=HPlkq/4VqBzr4ajXAOaJ8RFS8xY4d+Fhy0AWUYlht+zmHz2Ibtdil8hy
   PdQbenjsRlLEGkUuy7Ho7aJW/UB58Ywis49QyJW99C7ELk+LFIkZ2/euK
   xd4k72C1CRzAcZCqvFVR9isAEyfIptWSyvu3teTmAhWW8OCofDuCz3QfZ
   o=;
X-IronPort-AV: E=Sophos;i="5.91,217,1647302400"; 
   d="scan'208";a="201940142"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 11 May 2022 13:20:56 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com (Postfix) with ESMTPS id 6B0ABC0A3F;
        Wed, 11 May 2022 13:20:54 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 11 May 2022 13:20:51 +0000
Received: from [0.0.0.0] (10.43.162.96) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 13:20:48 +0000
Message-ID: <1bdef9a5-d0a9-6dcb-2fdf-19351c68da7a@amazon.com>
Date:   Wed, 11 May 2022 15:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simo Sorce <simo@redhat.com>
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
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <YnsO1JGQm5FEkbJt@zx2c4.com>
X-Originating-IP: [10.43.162.96]
X-ClientProxiedBy: EX13D36UWB004.ant.amazon.com (10.43.161.49) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDExLjA1LjIyIDAzOjE4LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4gSGkgU2ltbywK
Pgo+IE9uIFR1ZSwgTWF5IDEwLCAyMDIyIGF0IDA4OjQwOjQ4UE0gLTA0MDAsIFNpbW8gU29yY2Ug
d3JvdGU6Cj4+IEF0IHlvdXIgcmVxdWVzdCB0ZWxlcG9ydGluZyBoZXJlIHRoZSBhbnN3ZXIgSSBn
YXZlIG9uIGEgZGlmZmVyZW50Cj4+IHRocmVhZCwgcmVpbmZvcmNlZCBieSBzb21lIHRoaW5raW5n
Lgo+Pgo+PiBBcyBhIHVzZXIgc3BhY2UgY3J5cHRvIGxpYnJhcnkgcGVyc29uIEkgdGhpbmsgdGhl
IG9ubHkgcmVhc29uYWJsZQo+PiBpbnRlcmZhY2UgaXMgc29tZXRoaW5nIGxpa2UgYSB2RFNPLgo+
Pgo+PiBQb2xsKCkgaW50ZXJmYWNlcyBhcmUgbmljZSBhbmQgYWxsIGZvciBzeXN0ZW0gcHJvZ3Jh
bXMgdGhhdCBoYXZlIGZ1bGwKPj4gY29udHJvbCBvZiB0aGVpciBldmVudCBsb29wIGFuZCBkbyBu
b3QgaGF2ZSB0byByZWFjdCBpbW1lZGlhdGVseSB0bwo+PiB0aGlzIGV2ZW50LCBob3dldmVyIGNy
eXB0byBsaWJyYXJpZXMgZG8gbm90IGhhdmUgdGhlIGx1eHVyeSBvZgo+PiBjb250cm9sbGluZyB0
aGUgbWFpbiBsb29wIG9mIHRoZSBhcHBsaWNhdGlvbi4KPj4KPj4gQWRkaXRpb25hbGx5IGNyeXB0
byBsaWJyYXJpZXMgcmVhbGx5IG5lZWQgdG8gZW5zdXJlIHRoZSB2YWx1ZSB0aGV5Cj4+IHJldHVy
biBmcm9tIHRoZWlyIFBSTkcgaXMgZmluZSwgd2hpY2ggbWVhbnMgdGhleSBkbyBub3QgcmV0dXJu
IGEgdmFsdWUKPj4gaWYgdGhlIHZtZ2VuaWQgaGFzIGNoYW5nZWQgYmVmb3JlIHRoZXkgY2FuIHJl
c2VlZCwgb3IgdGhlcmUgY291bGQgYmUKPj4gY2F0YXN0cm9waGljIGR1cGxpY2F0aW9uIG9mICJy
YW5kb20iIHZhbHVlcyB1c2VkIGluIElWcyBvciBFQ0RTQQo+PiBTaWduYXR1cmVzIG9yIGlkcy9j
b29raWVzIG9yIHdoYXRldmVyLgo+Pgo+PiBGb3IgY3J5cHRvIGxpYnJhcmllcyBpdCBpcyBtdWNo
IHNpbXBsZXIgdG8gcG9sbCBmb3IgdGhpcyBpbmZvcm1hdGlvbgo+PiB0aGFuIHVzaW5nIG5vdGlm
aWNhdGlvbnMgb2YgYW55IGtpbmQgZ2l2ZW4gbGlicmFyaWVzIGFyZQo+PiBnZW5lcmFsbHkgbm90
IGluIGZ1bGwgY29udHJvbCBvZiB3aGF0IHRoZSBwcm9jZXNzIGRvZXMuCj4+Cj4+IFRoaXMgbmVl
ZHMgdG8gYmUgcG9sbGVkIGZhc3QgYXMgd2VsbCwgYmVjYXVzZSB0aGUgd2hvbGUgcG9pbnQgb2YK
Pj4gaW5pdGlhbGl6aW5nIGEgUFJORyBpbiB0aGUgbGlicmFyeSBpcyB0aGF0IGFza2luZyAvZGV2
L3VyYW5kb20gYWxsIHRoZQo+PiB0aW1lIGlzIHRvbyBzbG93IChkdWUgdG8gY29udGV4dCBzd2l0
Y2hlcyBhbmQgc3lzY2FsbCBvdmVyaGVhZCksIHNvCj4+IGFueXRoaW5nIHRoYXQgd291bGQgcmVx
dWlyZSBhIGNvbnRleHQgc3dpdGNoIGluIG9yZGVyIHRvIHB1bGwgZGF0YSBmcm9tCj4+IHRoZSBQ
Uk5HIHdvdWxkIG5vdCByZWFsbHkgZmx5Lgo+Pgo+PiBBIHZEU08gb3Igc2ltaWxhciB3b3VsZCBh
bGxvdyB0byBwdWxsIHRoZSB2bWdlbmlkIG9yIHdoYXRldmVyIGVwb2NoCj4+IHZhbHVlIGluIGJl
Zm9yZSBnZW5lcmF0aW5nIHRoZSByYW5kb20gbnVtYmVycyBhbmQgdGhlbiBiYXJyaWVyLXN0eWxl
Cj4+IGNoZWNrIHRoYXQgdGhlIHZhbHVlIGlzIHN0aWxsIHVuY2hhbmdlZCBiZWZvcmUgcmV0dXJu
aW5nIHRoZSByYW5kb20KPj4gZGF0YSB0byB0aGUgY2FsbGVyLiBUaGlzIHdpbGwgcmVkdWNlIHRo
ZSByYWNlIGNvbmRpdGlvbiAod2hpY2ggc2ltcGx5Cj4+IGNhbm5vdCBiZSBjb21wbGV0ZWx5IGF2
b2lkZWQpIHRvIGEgdmVyeSB1bmxpa2VseSBldmVudC4KPiBJdCBzb3VuZHMgbGlrZSB5b3VyIGxp
YnJhcnkgaXNzdWUgaXMgc29tZXdoYXQgc2ltaWxhciB0byB3aGF0IEFsZXggd2FzCj4gdGFsa2lu
ZyBhYm91dCB3aXRoIHJlZ2FyZHMgdG8gaGF2aW5nIGEgaGFyZCB0aW1lIHVzaW5nIHBvbGwgaW4g
czJuLiBJJ20KPiBzdGlsbCB3YWl0aW5nIHRvIGhlYXIgaWYgQW1hem9uIGZpZ3VyZWQgb3V0IHNv
bWUgd2F5IHRoYXQgdGhpcyBpcwo+IHBvc3NpYmxlICh3aXRoLCBlLmcuLCBhIHRocmVhZCkuIEJ1
dCBhbnl3YXksIGl0IHNlZW1zIGxpa2UgdGhpcyBpcwoKClNvdW5kcyBsaWtlIEkgZGlkbid0IHJl
cGx5IHdpdGggbXkgZmluZGluZ3MgLSBzb3JyeSBhYm91dCB0aGF0LiBPdXIgczJuIApwZW9wbGUg
KmNvdWxkKiBidWlsZCBzb21ldGhpbmcgYmFzZWQgb24gYSB0aHJlYWQsIGJ1dCBhcmUgYWZyYWlk
IHRoYXQgCml0J3MgcmFjeSBhbmQgd291bGQgaW50cm9kdWNlIGNyZWF0aW5nIGEgdGhyZWFkIHdo
aWNoIHRoZSBsaWJyYXJ5IGRvZXMgCm5vdCBkbyB0b2RheS4KClNvIGluIGEgbnV0c2hlbGwsIHBv
c3NpYmxlIHllcywgZGVzaXJhYmxlIG5vLgoKSSB0aGluayB3ZSdyZSBtYXliZSBhIGJpdCB0b28g
c2NhcmVkIG9mIGJ1aWxkaW5nIHNvbWV0aGluZyBmcm9tIHNjcmF0Y2ggCmhlcmUuIFdoYXQgd291
bGQgdGhlIGJlc3QgY2FzZSBzaXR1YXRpb24gYmU/IExldCdzIHJvbGwgYmFja3dhcmRzIGZyb20g
CnRoYXQgdGhlbi4KCiBGcm9tIHdoYXQgSSByZWFkLCB3ZSB3YW50IGEgIlZNR2VuSUQgdjIiIGRl
dmljZSB0aGF0IGdpdmVzIHVzIHRoZSAKYWJpbGl0eSB0bwoKIMKgICogR2V0IGFuIElSUSBvbiBW
TSBjbG9uZQogwqAgKiBTdG9yZSBhbmQgdXBkYXRlIGFuIFJORyBzZWVkIHZhbHVlICgxMjhiaXQ/
IENvbmZpZ3VyYWJsZSBsZW4/KSBhdCBhIApwaHlzaWNhbCBhZGRyZXNzIG9yIHN0YW5kIGFsb25l
IHBhZ2Ugb24gY2xvbmUKIMKgICogU3RvcmUgYW5kIHVwZGF0ZSBhIHVuaXF1ZS10by10aGlzLVZN
IHJvbGxpbmcgMzJiaXQgaWRlbnRpZmllciBhdCBhIApwaHlzaWNhbCBhZGRyZXNzIG9yIHN0YW5k
IGFsb25lIHBhZ2Ugb24gY2xvbmUKCldlIGNhbiBlaXRoZXIgbWFrZSB0aGUgZGV2aWNlIGV4cG9z
ZSB0aGVzZSB2YWx1ZXMgYXMgaW5kaXZpZHVhbCBwYWdlcyAKKGxpa2UgVk1HZW5JRCBkb2VzIHRv
ZGF5KSBvciBhcyBndWVzdCBwaHlzaWNhbCBhZGRyZXNzZXMgdGhhdCBpdCBuZWVkcyAKdG8gc3Rv
cmUgaW50byAobGlrZSB2aXJ0aW8tcm5nKS4gVGhlIGxhdHRlciBtYWtlcyBwcm90ZWN0aW9uIGZy
b20gRE1BIAphdHRhY2tzIG9mIHRoZSBoeXBlcnZpc29yIGFuZCBrZXhlYyBzbGlnaHRseSBtb3Jl
IGNvbXBsaWNhdGVkLCBidXQgaXQgCndvdWxkIGJlIGRvYWJsZS4KClZNR2VuSUQgaGFzIDIgb3V0
IG9mIDMgZmVhdHVyZXMgYWJvdmUuIFNvIHdoeSBkb24ndCB3ZSBqdXN0IGdvIHRoZSBlYXN5IApy
b3V0ZSwgYWRkIGEgc2Vjb25kIHByb3BlcnR5IHRvIFZNR2VuSUQgdGhhdCBnaXZlcyB1cyBhbm90
aGVyIHBhZ2Ugd2l0aCAKdGhhdCAzMmJpdCB2YWx1ZSBhbmQgdGhlbiBwcm92aWRlIGEgL2Rldi92
bWdlbmlkIGRldmljZSBub2RlIHlvdSBjYW4gCm9wZW4gYW5kIG1tYXAoKSB0aGF0IDMyYml0IHZh
bHVlIHBhZ2UgZnJvbT8KClVzZXIgc3BhY2UgbGlicmFyaWVzIGNhbiB0aGVuIHRyeSB0byBvcGVu
IG9uIGluaXQgYW5kIGRldGVybWluZSB0aGVpciBlcG9jaC4KRm9yIHRoZSBhc3luYyBldmVudCwg
d2UgYWRkIHRoZSBwb2xsKCkgbG9naWMgYWdhaW4gdG8gL2Rldi92bWdlbmlkIGFuZCAKbWFrZSBu
ZXR3b3JrZCBmb3IgZXhhbXBsZSB1c2UgdGhhdC4KCgpBbGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1l
bnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hh
ZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRy
YWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0
ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

