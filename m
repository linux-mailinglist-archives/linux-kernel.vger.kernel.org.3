Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28F57F71D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 22:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiGXUyy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 Jul 2022 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiGXUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:54:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B1F3BC18
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:54:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-Zzvs9auwOwqgh4jFtUlVZA-1; Sun, 24 Jul 2022 21:54:33 +0100
X-MC-Unique: Zzvs9auwOwqgh4jFtUlVZA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Sun, 24 Jul 2022 21:54:25 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Sun, 24 Jul 2022 21:54:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yi Sun' <yi.sun@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "heng.su@intel.com" <heng.su@intel.com>
Subject: RE: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Thread-Topic: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Thread-Index: AQHYnm+ODXPdzib5uU6pj7yBjiIw9q2OAAFw
Date:   Sun, 24 Jul 2022 20:54:25 +0000
Message-ID: <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
References: <20220723083800.824442-1-yi.sun@intel.com>
 <20220723083800.824442-2-yi.sun@intel.com>
In-Reply-To: <20220723083800.824442-2-yi.sun@intel.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Sun
> Sent: 23 July 2022 09:38
> 
> Calculate the latency of instructions xsave and xrstor with new trace
> points x86_fpu_latency_xsave and x86_fpu_latency_xrstor.
> 
> The delta TSC can be calculated within a single trace event. Another
> option considered was to have 2 separated trace events marking the
> start and finish of the xsave/xrstor instructions. The delta TSC was
> calculated from the 2 trace points in user space, but there was
> significant overhead added by the trace function itself.
> 
> In internal testing, the single trace point option which is
> implemented here proved to be more accurate.
...

I've done some experiments that measure short instruction latencies.
Basically I found:
1) You need a suitable serialising instruction before and after
   the code being tested - otherwise it can overlap whatever
   you are using for timing.
2) The only reliable counter is the performance monitor clock
   counter - everything else depends on the current cpu frequency.
   On intel cpu the cpu frequency can change all the time.
Allowing for that, and then ignoring complete outliers, I could
get clock-count accurate values for iterations of the IP csum loop.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

