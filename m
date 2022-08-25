Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0DC5A11A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbiHYNM5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Aug 2022 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiHYNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:12:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A63FAF4A2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:12:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-55-HXv8MwvfNtijA9b15ilGWA-1; Thu, 25 Aug 2022 14:12:44 +0100
X-MC-Unique: HXv8MwvfNtijA9b15ilGWA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Thu, 25 Aug 2022 14:12:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Thu, 25 Aug 2022 14:12:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
CC:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>
Subject: RE: [PATCH] x86/sev: Mark snp_abort() noreturn
Thread-Topic: [PATCH] x86/sev: Mark snp_abort() noreturn
Thread-Index: AQHYuE2/3wA7Q5vXrk6DdQVA60XyvK2/lqOw
Date:   Thu, 25 Aug 2022 13:12:42 +0000
Message-ID: <ce56926842dc49ecb08ddb9d828590af@AcuMS.aculab.com>
References: <20220824152420.20547-1-bp@alien8.de>
 <20220824172929.GA25951@gate.crashing.org>
 <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net>
 <20220824224144.GC25951@gate.crashing.org>
 <YwcZjxVkO/lspvmv@worktop.programming.kicks-ass.net>
In-Reply-To: <YwcZjxVkO/lspvmv@worktop.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> Objtool follows control flow. As you said above, noreturn functions
> behave differently and code-gen after a call to a noreturn function
> stops.

Thinks....

How near is objtool to outputting a list of functions and the
stack offset at which they call something else?

With the 'magic numbers' to track indirect jumps that is very
nearly enough information to do full static stack depth checking.

Recursive calls are a problem - but they ought to be banned
in kernel anyway.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

