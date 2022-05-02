Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13A2517787
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387157AbiEBTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiEBTpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:45:50 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA765CF;
        Mon,  2 May 2022 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651520540; x=1683056540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7FJBCYXxEPq3Mo4GK9ln8o36ilxGPdXqqt9EWLzX8GA=;
  b=qk4LpZ7OX6GFFwyXICeMARmucZGSj/gPtXB8MoNAZWCcCAqR9+KvwGau
   5voyGD6Ud8SMvGOlo5BzSHkHWqny2Zpb5t1cNZ9rAXt2pmIRHz7UL3Pkv
   O14koN5hHESYXFRWo6cuXZFMuNW95OdIMxsOxq3Y+rCeHJ6vSDyIVNWSw
   M=;
X-IronPort-AV: E=Sophos;i="5.91,193,1647302400"; 
   d="scan'208";a="1012276635"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 02 May 2022 19:42:04 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com (Postfix) with ESMTPS id B25A4811C3;
        Mon,  2 May 2022 19:42:02 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 2 May 2022 19:42:02 +0000
Received: from [0.0.0.0] (10.43.161.217) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 2 May
 2022 19:41:59 +0000
Message-ID: <97665117-922f-8872-7b7f-a53499db6e15@amazon.com>
Date:   Mon, 2 May 2022 21:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Lennart Poettering <mzxreary@0pointer.de>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
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
 <480469e6-0eb0-8d76-0b8d-111579e73701@amazon.com>
 <YnAnCgxmPBrMdKt5@zx2c4.com>
 <cef2694f-d6cc-70e0-1d31-0c9dbd038ce2@amazon.com>
 <YnAwiZv8n6Rzc5+O@zx2c4.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <YnAwiZv8n6Rzc5+O@zx2c4.com>
X-Originating-IP: [10.43.161.217]
X-ClientProxiedBy: EX13D04UWA004.ant.amazon.com (10.43.160.234) To
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

Ck9uIDAyLjA1LjIyIDIxOjI3LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4gT24gTW9uLCBN
YXkgMDIsIDIwMjIgYXQgMDg6NTY6MDVQTSArMDIwMCwgQWxleGFuZGVyIEdyYWYgd3JvdGU6Cj4+
IE9uIDAyLjA1LjIyIDIwOjQ2LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4+PiBPbiBNb24s
IE1heSAwMiwgMjAyMiBhdCAwODozNDozOFBNICswMjAwLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToK
Pj4+PiBNaWNoYWVsLCBzaW5jZSB3ZSBhbHJlYWR5IGNoYW5nZWQgdGhlIENJRCBpbiB0aGUgc3Bl
YywgY2FuIHdlIGFkZCBhCj4+Pj4gcHJvcGVydHkgdG8gdGhlIGRldmljZSB0aGF0IGluZGljYXRl
cyB0aGUgZmlyc3QgNCBieXRlcyBvZiB0aGUgVVVJRCB3aWxsCj4+Pj4gYWx3YXlzIGJlIGRpZmZl
cmVudCBiZXR3ZWVuIHBhcmVudCBhbmQgY2hpbGQ/Cj4+Pj4KPj4+PiBUaGF0IHNob3VsZCBnaXZl
IHVzIHRoZSBhYmlsaXR5IHRvIG1tYXAgdGhlIHZtZ2VuaWQgZGlyZWN0bHkgdG8gdXNlcgo+Pj4+
IHNwYWNlIGFuZCBhY3QgYmFzZWQgb24gYSBzaW1wbGUgdTMyIGNvbXBhcmUgZm9yIGNsb25lIG5v
dGlmaWNhdGlvbiwgbm8/Cj4+PiBUaGF0IGlzIG5vdCBhIGdvb2QgaWRlYS4gV2Ugd2FudCBhbiBf
YWRkaXRpb25hbF8gNCBieXRlcywgc28gdGhhdCB3ZSBjYW4KPj4+IGtlZXAgdGhlIGZpcnN0IDE2
IGJ5dGVzICgxMjggYml0cykgYXMgYSBrZXJuZWwgc3BhY2Ugc2VjcmV0Lgo+Pgo+PiBBbiBhZGRp
dGlvbmFsIDQgYnl0ZXMgd291bGQgYmUgYW4gYWRkaXRpb25hbCA0a2IgKG9yIDY0a2Igb24gQVJN
KSBwYWdlLgo+PiBEbyB3ZSByZWFsbHkgcmVseSBvbiB0aGVzZSAxNiBieXRlcyB0byByZXNlZWQg
YWZ0ZXIgY2xvbmU/IElmIHNvLCB3ZSdkCj4+IG5lZWQgdG8gYml0ZSB0aGUgYnVsbGV0IGFuZCBw
cm92aWRlIGFuIGFkZGl0aW9uYWwgcGFnZSwgeWVzLgo+IFVnaCwgeW91J3JlIHJpZ2h0OyBtZW1v
cnkgbWFwcGluZyBpcyBwYWdlcy4gVGhlIG90aGVyIG9wdGlvbiB3b3VsZCBiZQo+IHJlbHlpbmcg
b24gUkRSQU5EIChib3RoIGV4aXN0aW5nIGFuZCBiZWluZyB0cnVzdGVkIGJ5IHRoZSB1c2VyIGV0
YyksIGJ1dAo+IGdlbmVyYWxseSBwZW9wbGUgYXJlbid0IHRvbyBqYXp6ZWQgYWJvdXQgdGhhdC4g
V2UgcHJldHR5IG11Y2ggaGF2ZSB0bwo+IGFzc3VtZSB0aGF0IHRoZSBleGlzdGluZyBwb29sIGlz
IGNvbXByb21pc2VkLCBzaW5jZSBwZW9wbGUgc2hhcmUgY2xvbmVkCj4gVk1zIGNhc3VhbGx5LiBU
aGUgMTI4LWJpdCB2bWdlbmlkIGlzIGEgbmljZSBpbnB1dCB0byBoYXZlLgoKCkkgY2FuIHNlZSB0
aGUgbWVyaXQuIFNvIHllcywgd2UnZCB3YW50IGEgc2Vjb25kIGZ1bmN0aW9uIHRvIHRoZSAKVk1f
R0VOX0NPVU5URVIgZGV2aWNlIGluIGFkZGl0aW9uIHRvICJBRERSIiB0aGF0IC0gaW4gYSBmdWxs
eSB1c2VyIHNwYWNlIAptYXBwYWJsZSBzZXBhcmF0ZSBwYWdlIC0gZ2l2ZXMgdXMgYSAzMi1iaXQg
dm1nZW5pZCB0aGF0IGlzIGd1YXJhbnRlZWQgdG8gCmJlIGRpZmZlcmVudCBmcm9tIHRoZSBwcmV2
aW91cyBvbmUuCgoKQWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdt
YkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0
aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQg
Q2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERF
IDI4OSAyMzcgODc5CgoK

