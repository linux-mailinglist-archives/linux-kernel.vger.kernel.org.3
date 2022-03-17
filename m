Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93EF4DD0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiCQWW2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Mar 2022 18:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiCQWW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:22:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDC8B18DA83
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:21:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-44-hg7KCkJuOi-vtTRWngsi6g-1; Thu, 17 Mar 2022 22:21:04 +0000
X-MC-Unique: hg7KCkJuOi-vtTRWngsi6g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 17 Mar 2022 22:21:03 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 17 Mar 2022 22:21:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Pavel Machek <pavel@denx.de>, "Tony Luck" <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
Thread-Topic: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
Thread-Index: AQHYOinRp0NJ20rcrEGwBVQASAIHFKzEJTxA
Date:   Thu, 17 Mar 2022 22:21:03 +0000
Message-ID: <e2baf93885684512b4c7dc5363620a6f@AcuMS.aculab.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <20220310204854.31752-1-tony.luck@intel.com>
 <20220310204854.31752-2-tony.luck@intel.com> <20220317111305.GB2237@amd>
 <87fsngcv25.ffs@tglx>
In-Reply-To: <87fsngcv25.ffs@tglx>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner
> Sent: 17 March 2022 18:07
> 
> On Thu, Mar 17 2022 at 12:13, Pavel Machek wrote:
> >> In https://lore.kernel.org/all/87y22uujkm.ffs@tglx/ Thomas
> >> said:
> >>
> >>   Its's simply wishful thinking that stuff gets fixed because of a
> >>   WARN_ONCE(). This has never worked. The only thing which works is to
> >>   make stuff fail hard or slow it down in a way which makes it annoying
> >>   enough to users to complain.
> >>
> >> He was talking about WBINVD. But it made me think about how we
> >> use the split lock detection feature in Linux.
> >>
> >> Existing code has three options for applications:
> >> 1) Don't enable split lock detection (allow arbitrary split locks)
> >> 2) Warn once when a process uses split lock, but let the process
> >>    keep running with split lock detection disabled
> >> 3) Kill process that use split locks
> >
> > I'm not sure what split locks are, and if you want applications to
> > stop doing that maybe documentation would help.
> 
> Split locks are lock prefixed operations which cross a cache line
> boundary. The way how they are implemented is taking the bus lock, which
> is the largest serialization hammer.
> 
> Bus locks are also triggered by lock prefixed operations on uncached
> memory and on MMIO.
> 
> > Anyway, you can't really introduce regressions to userspace to "get
> > stuff fixed" in applications.
> 
> Split locks can be triggered by unpriviledged user space and can be used
> to run a local DoS attack. A very effective DoS to be clear.
> 
> We have no indication whether a process is malicious or just doing
> stupid things. The only reason to not kill the offending process
> instantly is that there can be legacy binary only executables which
> trigger that due to stupidity.
> 
> But that opens up DoS at the same time. So the only way to "protect"
> against that is to slow down the freqeuncy of buslocks unconditionally.
> If you don't like that after analysing the situation you can turn split
> lock detection off.
> 
> The only binary I've seen so far triggering this, is some stoneage "value
> add" blob from HP which is also doing totally nuts other things.

They are actually more likely to happen in the kernel
when code casts int[] to long[] and then uses the 'BIT' functions to
set/clear bits - which do locked operations.
Quite often then don't need the locks anyway.
And that cast is surprisingly common and completely broken on BE.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

