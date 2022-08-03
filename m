Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45FE5891F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiHCR7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiHCR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:59:11 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0761F2C2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659549551; x=1691085551;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=Fl55IXNEpv65yhvgCjI1WxHUFQY3iQz/yFm1z776DlM=;
  b=oamgni7YoTkvx3eFYZ2RX0YHrKv1A7XCsYmo36Qak1vEd3rCsxRZAdPa
   4F8oYPAs7D7g18NY3MgOONxUTEsUV/P1iR/9sHZXV0FQWYXh4OGdt4Ibq
   w9zc/sWYzIGzXtcPhlPoD6AZ6seoLhrAe+lvWEMBuvw2D+6pyDRMoDev+
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,214,1654560000"; 
   d="scan'208";a="1040626427"
Subject: Re: [PATCH 2/2] virt: vmgenid: add support for generation counter
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 17:59:10 +0000
Received: from EX13D37EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id 24C88200020;
        Wed,  3 Aug 2022 17:59:07 +0000 (UTC)
Received: from [192.168.18.61] (10.43.162.134) by EX13D37EUA003.ant.amazon.com
 (10.43.165.7) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Wed, 3 Aug
 2022 17:59:03 +0000
Message-ID: <c342546f-457d-af9b-4db9-c9bd0e1269ac@amazon.es>
Date:   Wed, 3 Aug 2022 19:58:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <tytso@mit.edu>, <Jason@zx2c4.com>,
        <dwmw@amazon.co.uk>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>, <ani@anisinha.ca>,
        <imammedo@redhat.com>
References: <20220803152127.48281-1-bchalios@amazon.es>
 <20220803152127.48281-3-bchalios@amazon.es> <YuqU4wXNBt4pAK+C@kroah.com>
From:   "Chalios, Babis" <bchalios@amazon.es>
In-Reply-To: <YuqU4wXNBt4pAK+C@kroah.com>
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D14UWB004.ant.amazon.com (10.43.161.137) To
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

CgpPbiAzLzgvMjIgMTc6MzEsIEdyZWcgS0ggd3JvdGU6Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBv
cmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5k
ZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4KPgo+Cj4KPiBPbiBXZWQsIEF1ZyAwMywg
MjAyMiBhdCAwNToyMToyN1BNICswMjAwLCBiY2hhbGlvc0BhbWF6b24uZXMgd3JvdGU6Cj4+ICsg
ICAgIC8qIEJhY2t3YXJkcyBjb21wYXRpYmlsaXR5LiBJZiBDVFJBIGlzIG5vdCB0aGVyZSB3ZSBq
dXN0IGRvbid0IGV4cG9zZQo+PiArICAgICAgKiB0aGUgY2hhciBkZXZpY2UKPiBCYWNrd2FyZHMg
Y29tcGF0aWJpbGl0eSB3aXRoIHdoYXQ/CldpdGggaHlwZXJ2aXNvciB2ZXJzaW9ucyB0aGF0IGRv
IG5vdCBzdXBwb3J0IHRoZSBnZW5lcmF0aW9uIGNvdW50ZXIsIGJ1dCAKZG8gc3VwcG9ydAp0aGUg
Vk0gZ2VuZXJhdGlvbiBJRC4gSW4gdGhpcyBjYXNlIHRoZSBoeXBlcnZpc29yIHdvdWxkIGV4cG9z
ZSBBRERSIGJ1dCAKbm90IENUUkEuCj4KPj4gKyAgICAgICovCj4+ICsgICAgIHJldCA9IHBhcnNl
X3ZtZ2VuaWRfYWRkcmVzcyhkZXZpY2UsICJDVFJBIiwgJnN0YXRlLT5nZW5fY250cl9hZGRyKTsK
Pj4gKyAgICAgaWYgKHJldCkKPj4gKyAgICAgICAgICAgICByZXR1cm4gMDsKPj4gKwo+PiArICAg
ICBzdGF0ZS0+bmV4dF9jb3VudGVyID0gZGV2bV9tZW1yZW1hcCgmZGV2aWNlLT5kZXYsIHN0YXRl
LT5nZW5fY250cl9hZGRyLAo+PiArICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHUzMiksIE1F
TVJFTUFQX1dCKTsKPj4gKyAgICAgaWYgKElTX0VSUihzdGF0ZS0+bmV4dF9jb3VudGVyKSkKPj4g
KyAgICAgICAgICAgICByZXR1cm4gMDsKPiBUaGlzIHRvbyBpcyBhbiBlcnJvciwgeW91IGNhbiBu
b3QgcmV0dXJuIHdpdGggImFsbCBpcyBnb29kIiwgcmlnaHQ/Cj4gT25jZSB5b3UgdHJ5IHRvIGNy
ZWF0ZSB0aGlzIGRldmljZSBiZWNhdXNlIHRoZSBhZGRyZXNzIGlzIHByZXNlbnQsIHlvdQo+IGNh
bid0IGp1c3QgZ2l2ZSB1cCBhbmQgc3VjY2VlZCBubyBtYXR0ZXIgd2hhdCB3ZW50IHdyb25nLCB0
aGF0IHNlZW1zCj4gaW5jb3JyZWN0LgpTYW1lIGludGVudGlvbiBhcyBpbiB0aGUgcmVzcG9uc2Ug
aW4geW91ciBvdGhlciBjb21tZW50LiBJIHRob3VnaHQgdGhhdCAKaXQgZG9lc24ndCBtYWtlIHNl
bnNlCnRvIGZhaWwgdGhlIHdob2xlIEFDUEkgZGV2aWNlIGlmIHJlZ2lzdGVyaW5nIHRoZSBtaXNj
IGRldmljZSBmYWlscy4KCkhvd2V2ZXIsIHNlZWluZyB0aGF0IGFnYWluIChldmVuIGlmIG15IHRo
aW5raW5nIGlzIHJpZ2h0KSBpZiB0aGlzIApkZXZtX21lbXJlbWFwIGZhaWxzIHdlIHNob3VsZApw
cm9iYWJseSBmYWlsIGJlY2F1c2UgdGhlcmUgbWlnaHQgYmUgc29tZXRoaW5nIHdyb25nIHdpdGgg
dGhlIGFkZHJlc3MgCnRoZSBkZXZpY2UgZ2F2ZSB1cy4KPgo+IHRoYW5rcywKPgo+IGdyZWcgay1o
CgoKQ2hlZXJzLApCYWJpcwpBbWF6b24gU3BhaW4gU2VydmljZXMgc29jaWVkYWQgbGltaXRhZGEg
dW5pcGVyc29uYWwsIENhbGxlIFJhbWlyZXogZGUgUHJhZG8gNSwgMjgwNDUgTWFkcmlkLiBSZWdp
c3RybyBNZXJjYW50aWwgZGUgTWFkcmlkIC4gVG9tbyAyMjQ1OCAuIEZvbGlvIDEwMiAuIEhvamEg
TS00MDEyMzQgLiBDSUYgQjg0NTcwOTM2Cg==

