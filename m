Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD25176FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386985AbiEBTAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiEBS7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:59:55 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B6F6467;
        Mon,  2 May 2022 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651517787; x=1683053787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMiyoG0ljnS/EC6Y22bluwsxc6Ze9Gq2jEIDZbxhJDU=;
  b=nCN1RDH8E9s5AHXTaUhuWNHdpQChqDztxRvuOEpwrPs5F7pY+A7CUeI1
   8Qp/SRE5BuOUdXYofijPhfQdol4Mw/ZfvTMzVtlG3mNwdQVUIwZ6a/U2M
   0ehANNJoS9SHHhRjM2IsApRttYbXGnlSP5aT54SuTKpI3pW3luARciNkx
   0=;
X-IronPort-AV: E=Sophos;i="5.91,193,1647302400"; 
   d="scan'208";a="84712483"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 02 May 2022 18:56:12 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com (Postfix) with ESMTPS id 3475341C84;
        Mon,  2 May 2022 18:56:11 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 2 May 2022 18:56:10 +0000
Received: from [0.0.0.0] (10.43.160.83) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 2 May
 2022 18:56:08 +0000
Message-ID: <cef2694f-d6cc-70e0-1d31-0c9dbd038ce2@amazon.com>
Date:   Mon, 2 May 2022 20:56:05 +0200
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
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <YnAnCgxmPBrMdKt5@zx2c4.com>
X-Originating-IP: [10.43.160.83]
X-ClientProxiedBy: EX13D20UWC003.ant.amazon.com (10.43.162.18) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDAyLjA1LjIyIDIwOjQ2LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4gT24gTW9uLCBN
YXkgMDIsIDIwMjIgYXQgMDg6MzQ6MzhQTSArMDIwMCwgQWxleGFuZGVyIEdyYWYgd3JvdGU6Cj4+
IE1pY2hhZWwsIHNpbmNlIHdlIGFscmVhZHkgY2hhbmdlZCB0aGUgQ0lEIGluIHRoZSBzcGVjLCBj
YW4gd2UgYWRkIGEKPj4gcHJvcGVydHkgdG8gdGhlIGRldmljZSB0aGF0IGluZGljYXRlcyB0aGUg
Zmlyc3QgNCBieXRlcyBvZiB0aGUgVVVJRCB3aWxsCj4+IGFsd2F5cyBiZSBkaWZmZXJlbnQgYmV0
d2VlbiBwYXJlbnQgYW5kIGNoaWxkPwo+Pgo+PiBUaGF0IHNob3VsZCBnaXZlIHVzIHRoZSBhYmls
aXR5IHRvIG1tYXAgdGhlIHZtZ2VuaWQgZGlyZWN0bHkgdG8gdXNlcgo+PiBzcGFjZSBhbmQgYWN0
IGJhc2VkIG9uIGEgc2ltcGxlIHUzMiBjb21wYXJlIGZvciBjbG9uZSBub3RpZmljYXRpb24sIG5v
Pwo+IFRoYXQgaXMgbm90IGEgZ29vZCBpZGVhLiBXZSB3YW50IGFuIF9hZGRpdGlvbmFsXyA0IGJ5
dGVzLCBzbyB0aGF0IHdlIGNhbgo+IGtlZXAgdGhlIGZpcnN0IDE2IGJ5dGVzICgxMjggYml0cykg
YXMgYSBrZXJuZWwgc3BhY2Ugc2VjcmV0LgoKCkFuIGFkZGl0aW9uYWwgNCBieXRlcyB3b3VsZCBi
ZSBhbiBhZGRpdGlvbmFsIDRrYiAob3IgNjRrYiBvbiBBUk0pIHBhZ2UuIApEbyB3ZSByZWFsbHkg
cmVseSBvbiB0aGVzZSAxNiBieXRlcyB0byByZXNlZWQgYWZ0ZXIgY2xvbmU/IElmIHNvLCB3ZSdk
IApuZWVkIHRvIGJpdGUgdGhlIGJ1bGxldCBhbmQgcHJvdmlkZSBhbiBhZGRpdGlvbmFsIHBhZ2Us
IHllcy4KCgpBbGV4CgoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgK
S3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFu
IFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hh
cmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4
OSAyMzcgODc5CgoK

