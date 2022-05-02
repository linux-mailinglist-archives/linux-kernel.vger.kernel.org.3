Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FE6517634
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbiEBSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbiEBSDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:03:01 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93031DE6;
        Mon,  2 May 2022 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651514371; x=1683050371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BpwN3TuUnFlkb1NUi6jq+Wt+R7qWcNiFb7SWT/wlYIg=;
  b=kfQQEtsjPiDXxmqihjpfQ7EDbqBMzCjiOGBr61epK4o7kCGZcSWw0/o/
   +2kGeB4OcBbFbhI8n8bHZ1KeBimhDlSfZRfjWCwhJTNgNWzBdSERrlkDp
   S8OrS+H7qVy2QCGrrHtpw7ZQOx6p4AdiILe0RXhAdG2aYyfuPDYc0gZR7
   4=;
X-IronPort-AV: E=Sophos;i="5.91,192,1647302400"; 
   d="scan'208";a="1012250087"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-6a4112b2.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 02 May 2022 17:59:14 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-6a4112b2.us-west-2.amazon.com (Postfix) with ESMTPS id 7F3E84C8CF0;
        Mon,  2 May 2022 17:59:14 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 2 May 2022 17:59:14 +0000
Received: from [0.0.0.0] (10.43.161.217) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 2 May
 2022 17:59:11 +0000
Message-ID: <7a1cfd1c-9f0e-f134-e544-83ee6d3cd9c9@amazon.com>
Date:   Mon, 2 May 2022 19:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
To:     Lennart Poettering <mzxreary@0pointer.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Colm MacCarthaigh" <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com> <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com> <YnAMBzhcJhGR5XOK@gardel-login>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <YnAMBzhcJhGR5XOK@gardel-login>
X-Originating-IP: [10.43.161.217]
X-ClientProxiedBy: EX13D05UWC001.ant.amazon.com (10.43.162.82) To
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

Ck9uIDAyLjA1LjIyIDE4OjUxLCBMZW5uYXJ0IFBvZXR0ZXJpbmcgd3JvdGU6Cj4gT24gTW8sIDAy
LjA1LjIyIDE4OjEyLCBKYXNvbiBBLiBEb25lbmZlbGQgKEphc29uQHp4MmM0LmNvbSkgd3JvdGU6
Cj4KPj4+PiBJbiBvcmRlciB0byBpbmZvcm0gdXNlcnNwYWNlIG9mIHZpcnR1YWwgbWFjaGluZSBm
b3JrcywgdGhpcyBjb21taXQgYWRkcwo+Pj4+IGEgImZvcmtfZXZlbnQiIHN5c2N0bCwgd2hpY2gg
ZG9lcyBub3QgcmV0dXJuIGFueSBkYXRhLCBidXQgYWxsb3dzCj4+Pj4gdXNlcnNwYWNlIHByb2Nl
c3NlcyB0byBwb2xsKCkgb24gaXQgZm9yIG5vdGlmaWNhdGlvbiBvZiBWTSBmb3Jrcy4KPj4+Pgo+
Pj4+IEl0IGF2b2lkcyBleHBvc2luZyB0aGUgYWN0dWFsIHZtZ2VuaWQgZnJvbSB0aGUgaHlwZXJ2
aXNvciB0byB1c2Vyc3BhY2UsCj4+Pj4gaW4gY2FzZSB0aGVyZSBpcyBhbnkgcmFuZG9tbmVzcyB2
YWx1ZSBpbiBrZWVwaW5nIGl0IHNlY3JldC4gUmF0aGVyLAo+Pj4+IHVzZXJzcGFjZSBpcyBleHBl
Y3RlZCB0byBzaW1wbHkgdXNlIGdldHJhbmRvbSgpIGlmIGl0IHdhbnRzIGEgZnJlc2gKPj4+PiB2
YWx1ZS4KPj4+IFdvdWxkbid0IGl0IG1ha2Ugc2Vuc2UgdG8gZXhwb3NlIGEgbW9ub3RvbmljIDY0
Yml0IGNvdW50ZXIgb2YgZGV0ZWN0ZWQKPj4+IFZNIGZvcmtzIHNpbmNlIGJvb3QgdGhyb3VnaCBy
ZWFkKCk/IEl0IG1pZ2h0IGJlIGludGVyZXN0aW5nIHRvIGtub3cKPj4+IGZvciB1c2Vyc3BhY2Ug
aG93IG1hbnkgZm9ya3MgaXQgbWlzc2VkIHRoZSBmb3JrIGV2ZW50cyBmb3IuIE1vcmVvdmVyIGl0
Cj4+PiBtaWdodCBiZSBpbnRlcmVzdGluZyB0byB1c2Vyc3BhY2UgdG8ga25vdyBpZiBhbnkgZm9y
ayBoYXBwZW5lZCBzbyBmYXIKPj4+ICphdCogKmFsbCosIGJ5IGNoZWNraW5nIGlmIHRoZSBjb3Vu
dGVyIGlzIG5vbi16ZXJvLgo+PiAiTWlnaHQgYmUgaW50ZXJlc3RpbmciIGlzIGRpZmZlcmVudCBm
cm9tICJkZWZpbml0ZWx5IHVzZWZ1bCIuIEknbSBub3QKPj4gZ29pbmcgdG8gYWRkIHRoaXMgd2l0
aG91dCBhIGNsZWFyIHVzZSBjYXNlLiBUaGlzIGZlYXR1cmUgaXMgcHJldHR5Cj4+IG5hcnJvd2x5
IHNjb3BlZCBpbiBpdHMgb2JqZWN0aXZlcyByaWdodCBub3csIGFuZCBJIGludGVuZCB0byBrZWVw
IGl0Cj4+IHRoYXQgd2F5IGlmIHBvc3NpYmxlLgo+IFN1cmUsIHdoYXRldmVyLiBJIG1lYW4sIGlm
IHlvdSB0aGluayBpdCdzIHByZWZlcmFibGUgdG8gaGF2ZSAzIEFQSQo+IGFic3RyYWN0aW9ucyBm
b3IgdGhlIHNhbWUgY29uY2VwdCBlYWNoIGZvciBpdCdzIHNwZWNpYWwgdXNlY2FzZSwgdGhlbgo+
IHRoYXQncyBjZXJ0YWlubHkgb25lIHdheSB0byBkbyB0aGluZ3MuIEkgcGVyc29uYWxseSB3b3Vs
ZCB0cnkgdG8KPiBmaWd1cmUgb3V0IGEgbW9kaWN1bSBvZiBnZW5lcmFsaXphdGlvbiBmb3IgdGhp
bmdzIGxpa2UgdGhpcy4gQnV0IG1heWJlCj4gdGhhdCcganVzdCBtZeKApgo+Cj4gSSBjYW4ganVz
dCB0ZWxsIHlvdSwgdGhhdCBpbiBzeXN0ZW1kIHdlJ2QgaGF2ZSBhIHVzZWNhc2UgZm9yIGNvbnN1
bWluZwo+IHN1Y2ggYSBnZW5lcmF0aW9uIGNvdW50ZXI6IHdlIHRyeSB0byBwcm92aWRlIHN0YWJs
ZSBNQUMgYWRkcmVzc2VzIGZvcgo+IHN5bnRoZXRpYyBuZXR3b3JrIGludGVyZmFjZXMgbWFuYWdl
ZCBieSBuZXR3b3JrZCwgc28gd2UgaGFzaCB0aGVtIGZyb20KPiAvZXRjL21hY2hpbmUtaWQsIGJ1
dCBvdG9oIHBlb3BsZSBhbHNvIHdhbnQgdGhlbSB0byBjaGFuZ2Ugd2hlbiB0aGV5Cj4gY2xvbmUg
dGhlaXIgVk1zLiBXZSBjb3VsZCB2ZXJ5IG5pY2VseSBzb2x2ZSB0aGlzIGlmIHdlIGhhZCBhCj4g
Z2VuZXJhdGlvbiBjb3VudGVyIGVhc2lseSBhY2Nlc3NpYmxlIGZyb20gdXNlcnNwYWNlLCB0aGF0
IHN0YXJ0cyBhdCAwCj4gaW5pdGlhbGx5LiBCZWNhdXNlIHRoZW4gd2UgY2FuIGhhc2ggYXMgd2Ug
YWx3YXlzIGRpZCB3aGVuIHRoZSBjb3VudGVyCj4gaXMgemVybywgYnV0IG90aGVyd2lzZSB1c2Ug
c29tZXRoaW5nIGVsc2UsIHBvc3NpYmx5IGhhc2hlZCBmcm9tIHRoZQo+IGdlbmVyYXRpb24gY291
bnRlci4KPgo+IEJ1dCBhbnl3YXksIEkgdW5kZXJzdGFuZCB5b3UgYXJlIG5vdCBpbnRlcmVzdGVk
IGluCj4gZ2VuZXJhbGl6YXRpb24vb3RoZXIgdXNlY2FzZXMsIHNvIEknbGwgc2h1dCB1cC4KCgpM
ZXQncyBub3QgdHVybiB0aGlzIGludG8gYSBwaXQgZmlnaHQgcGxlYXNlIDopLiBJIHRoaW5rIGl0
J3MgYSBnb29kIGlkZWEgCnRvIGNvbGxlY3QgdGhlIHVzZSBjYXNlcyB3ZSBhbGwgaGF2ZSBhbmQg
ZXZhbHVhdGUgd2hldGhlciB0aGlzIHBhdGNoIGlzIAphIGdvb2Qgc3RlcHBpbmcgc3RvbmUgdG93
YXJkcyB0aGUgZmluYWwgc29sdXRpb24uCgpBdCB0aGUgZW5kIG9mIHRoZSByb2FkLCB3aGF0IEkg
d291bGQgbGlrZSB0byBzZWUgaXMKCjEpIEEgd2F5IGZvciBsaWJyYXJpZXMgc3VjaCBhcyBzMm4g
dG8gaWRlbnRpZnkgdGhhdCBhIGNsb25lIG9jY3VycmVkLiAKQmVjYXVzZSBpdCdzIGEgZGVlcC1k
b3duIGxpYnJhcnkgd2l0aCBubyBhY2Nlc3MgdG8gaXRzIG93biB0aHJlYWQgb3IgdGhlIAptYWlu
IGxvb3AsIGl0IGNhbiBub3QgcmVseSBvbiBwb2xsL3NlbGVjdC4gTW1hcCBvZiBhIGZpbGUgaG93
ZXZlciB3b3VsZCAKd29yayBncmVhdCwgYXMgeW91IGNhbiBjcmVhdGUgdHJhbnNhY3Rpb25zIG9u
IHRvcCBvZiBhIDY0Yml0IG1tYXAnZWQgCnZhbHVlIGZvciBleGFtcGxlLgoKV2UgY2FuIGhhdmUg
c3lzdGVtZCBnZW5lcmF0ZSBhbmQgdGhlbiBwcm92aWRlIHN1Y2ggYSBmaWxlIGFzIGxvbmcgYXMg
d2UgCmhhdmUgYW4gZXZlbnQgYmFzZWQgbm90aWZpY2F0aW9uIG1lY2hhbmlzbS4KCjIpIEEgd2F5
IHRvIG5vdGlmeSBsYXJnZXIgYXBwbGljYXRpb25zICh0aGluayBKYXZhIGhlcmUpIHRoYXQgYSBz
eXN0ZW0gCmlzIGdvaW5nIHRvIGJlIHN1c3BlbmRlZCBzb29uIHNvIGl0IGNhbiB3aXBlIFBJSSBi
ZWZvcmUgaXQgZ2V0cyBjbG9uZWQgCmZvciBleGFtcGxlLgoKMykgTm90aWZpY2F0aW9ucyBhZnRl
ciBjbG9uZSBzbyBhcHBsaWNhdGlvbnMga25vdyB0aGV5IGNhbiByZWdlbmVyYXRlIFZNIAp1bmlx
dWUgZGF0YSBiYXNlZCBvbiByYW5kb21uZXNzLgoKRm9yIDIgYW5kIDMsIGFwcGxpY2F0aW9ucyBz
aG91bGQgaGF2ZSBuYXRpdmUgc3VwcG9ydCBmb3IgdGhlc2UgZXZlbnRzIAoodGhpbmsgb2YgcG9s
bCgpIG9uIHRoZSBmb3JrIGZpbGUpIGFzIHdlbGwgYXMgZXh0ZXJuYWwgc2NyaXB0IGJhc2VkIApz
dXBwb3J0ICh0aGluayAiaW52b2tlIHN5c3RlbWN0bCByZXN0YXJ0IHNtYmQuc2VydmljZSBvbiBj
bG9uZSIpLgoKCgpMZW5uYXJ0LCBsb29raW5nIGF0IHRoZSBjdXJyZW50IHN5c2N0bCBwcm9wb3Nh
bCwgc3lzdGVtZCBjb3VsZCBwb2xsKCkgb24gCnRoZSBmb3JrIGZpbGUuIEl0IHdvdWxkIHRoZW4g
YmUgYWJsZSB0byBnZW5lcmF0ZSBhIC9ydW4vZm9yay1pZCBmaWxlIAp3aGljaCBpdCBjYW4gdXNl
IGZvciB0aGUgZmxvdyBhYm92ZSwgcmlnaHQ/CgpUaGUgc3lzY3RsIHByb3Bvc2FsIGFsc28gZ2l2
ZXMgdXMgMywgaWYgd2UgaW1wbGVtZW50IHRoZSBpbmhpYml0b3IgCnByb3Bvc2FsIFsxXSBpbiBz
eXN0ZW1kLgoKVGhhdCBsZWF2ZXMgMiwgd2hpY2ggd2UgZG9uJ3QgaGF2ZSBhIGhhcmR3YXJlIGlu
dGVyZmFjZSBmb3IgeWV0LiBXZSBjYW4gCnN0aWxsIGdldCB0byBhdCBsZWFzdCBzY3JpcHQgbGV2
ZWwgYXV0b21hdGlvbiB3aXRoIGluaGliaXRvcnMgYW5kIAptYW51YWxseSB0cmlnZ2VyaW5nIGEg
ImhleSwgeW91J2xsIGJlIHN1c3BlbmRlZCBzb29uIiBldmVudCB2aWEgc3lzdGVtZC4KCk92ZXJh
bGwsIGl0IHNvdW5kcyB0byBtZSBsaWtlIHRoZSBzeXNjdGwgcG9sbCBiYXNlZCBrZXJuZWwgaW50
ZXJmYWNlIGluIAp0aGlzIHBhdGNoIGluIGNvbWJpbmF0aW9uIHdpdGggc3lzdGVtZCBpbmhpYml0
b3JzIGdpdmVzIHVzIGFuIGFuc3dlciB0byAKbW9zdCBvZiB0aGUgZmxvd3MgYWJvdmUuCgpJIGNh
biBzZWUgYXR0cmFjdGl2ZW5lc3MgaW4gcHJvdmlkaW5nIHRoZSAvcnVuL2ZvcmstaWQgZGlyZWN0
bHkgZnJvbSB0aGUgCmtlcm5lbCB0aG91Z2gsIHRvIHJlbW92ZSB0aGUgZGVwZW5kZW5jeSBvbiBz
eXN0ZW1kIGZvciBwb2xsLWxlc3MgCm5vdGlmaWNhdGlvbiBvZiBsaWJyYXJpZXMuCgpKYXNvbiwg
aG93IG11Y2ggY29tcGxleGl0eSB3b3VsZCBpdCBhZGQgdG8gcHJvdmlkZSBhbiBtbWFwKCkgYW5k
IHJlYWQoKSAKaW50ZXJmYWNlIHRvIGEgZm9yayBjb3VudGVyIHZhbHVlIHRvIHRoZSBzeXNjdGw/
IFJlYWQgc291bmRzIGxpa2UgYSAKdHJpdmlhbCBjaGFuZ2Ugb24gdG9wIG9mIHdoYXQgeW91IGhh
dmUgYWxyZWFkeSwgbW1hcCBhIGJpdCBtb3JlIGhlYXZ5IApsaWZ0LiBJZiB3ZSBoYWQgYm90aCwg
aXQgd291bGQgYWxsb3cgdXMgdG8gaW1wbGVtZW50IGEgTGludXggc3RhbmRhcmQgCmZvcmsgZGV0
ZWN0IHBhdGggaW4gbGlicmFyaWVzIHRoYXQgZG9lcyBub3QgcmVseSBvbiBzeXN0ZW1kLgoKCgpB
bGV4CgoKWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9zeXN0ZW1kL3N5c3RlbWQvaXNzdWVzLzIwMjIy
CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAz
OAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBK
b25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1
bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

