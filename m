Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959FB4C4E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiBYTHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiBYTH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:07:29 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E001F9825;
        Fri, 25 Feb 2022 11:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645816018; x=1677352018;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0pdcYTBpWu4B8LEQgqpWgPSfSuvuJAm1Gf5oxdVgDRI=;
  b=KOpJJhjQfdupW2jsd85vyDKNNACTLZKXg8GTKUYVeR8j0UZ8A8mddBeC
   8fX4z79EmoWYB2ZCEZeVc592iHSQmDaDZf8xbpYhaRcseJgpJ2ScwV8oQ
   qMeuumoFqXAdrc3Y0QA5BUh/1ngK+bLZWRoBV/If6OpgpsnnlSZQ5B63u
   8=;
X-IronPort-AV: E=Sophos;i="5.90,137,1643673600"; 
   d="scan'208";a="179943799"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-28a78e3f.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 25 Feb 2022 19:06:46 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-28a78e3f.us-west-2.amazon.com (Postfix) with ESMTPS id DF538A0D30;
        Fri, 25 Feb 2022 19:06:43 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 25 Feb 2022 19:06:43 +0000
Received: from [0.0.0.0] (10.43.160.203) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.28; Fri, 25 Feb
 2022 19:06:41 +0000
Message-ID: <a71a855f-9f3b-c99d-d4f9-c1ceb13c690d@amazon.com>
Date:   Fri, 25 Feb 2022 20:06:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
References: <20220225155552.30636-1-graf@amazon.com>
 <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
 <YhkQKfE8ErtFBmSB@zx2c4.com>
 <CAMj1kXEtUUod8Hp6VhS6k7iDKYkFj_t_J=qS2XF1p2X_SFdTvg@mail.gmail.com>
 <CAHmME9oJpL_y4bDaLwrZZZ54p5_C0YF9=vW7Zz1iUhpBHx2TvA@mail.gmail.com>
 <YhkaAUQ/5ChlKlXt@zx2c4.com>
 <CAHmME9rzS5rAKoAfv7+N_R71pWduV=a=gJJoKPoLtYx7m7CFEg@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <CAHmME9rzS5rAKoAfv7+N_R71pWduV=a=gJJoKPoLtYx7m7CFEg@mail.gmail.com>
X-Originating-IP: [10.43.160.203]
X-ClientProxiedBy: EX13D10UWB002.ant.amazon.com (10.43.161.130) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDI1LjAyLjIyIDE5OjM5LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4gT2theSwgdGhl
IGZpbmFsIHBpZWNlLCB1c2Vyc3BhY2U6Cj4KPiAvc3lzL2J1cy9hY3BpL2RldmljZXMvUUVNVVZH
SUQ6MDAvbW9kYWxpYXMgZ2l2ZXM6Cj4gICAgICBhY3BpOlFFTVVWR0lEOlZNX0dFTl9DT1VOVEVS
Ogo+Cj4gbW9kaW5mbyAtRiBhbGlhcyB2bWdlbmlkLmtvIGdpdmVzOgo+ICAgICAgYWNwaSo6Vk1f
R0VOX0NPVU5URVI6Kgo+Cj4gdWRldiBzcmMgdXNlcyBmbm1hdGNoLgo+Cj4gQmFzaCBjb25maXJt
cyBhIG1hdGNoOgo+Cj4gJCBbWyAiYWNwaTpRRU1VVkdJRDpWTV9HRU5fQ09VTlRFUjoiID09IGFj
cGkqOlZNX0dFTl9DT1VOVEVSOiogXV0gJiYKPiBlY2hvIG1hdGNoZXMKPiBtYXRjaGVzCj4KPiBT
byBJIHRoaW5rIHdpdGggQUNQSV9JRF9MRU4gLS0+IDE2IHdlIGFyZSBnb29kIHRvIGdvLgoKCklz
IHRoZSBzaXplIGluY3JlYXNlIChtb3N0bHkgcm9kYXRhIEkgc3VwcG9zZT8gQW55d2hlcmUgZWxz
ZT8pIG1lYXN1cmFibGU/CgoKQWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzog
Q2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dl
cmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3Qt
SUQ6IERFIDI4OSAyMzcgODc5CgoK

