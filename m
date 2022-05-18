Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0963B52B552
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiERIj6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 May 2022 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiERIjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:39:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1EBFB00
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:39:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-79-NduRNFJ4Pp-5rcXrHSSEXw-1; Wed, 18 May 2022 09:39:46 +0100
X-MC-Unique: NduRNFJ4Pp-5rcXrHSSEXw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 18 May 2022 09:39:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 18 May 2022 09:39:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Thread-Topic: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Thread-Index: AQHYagMRu09I4StjsUmLP0Gmi9Ue260kTo+g
Date:   Wed, 18 May 2022 08:39:45 +0000
Message-ID: <70df6e274d4a40e78f11ef93521edab6@AcuMS.aculab.com>
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill A. Shutemov
> Sent: 17 May 2022 16:30
> 
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
> 
> In TDX guest the second page can be shared page and VMM may configure it
> to trigger #VE.
> 
> Kernel assumes that #VE on a shared page is MMIO access and tries to
> decode instruction to handle it. In case of load_unaligned_zeropad() it
> may result in confusion as it is not MMIO access.
> 
> Check fixup table before trying to handle MMIO.

Is it best to avoid that all happening by avoiding mapping
'normal memory' below anything that isn't normal memory.

Even on a normal system it is potentially possibly that the
second page might be MMIO and reference a target that doesn't
want to see non-word sized reads.
(Or the first location might be a fifo and the read consumes
some data.)

In that case the cpu won't fault the access, but the hardware
access might have rather unexpected side effects.

Now the way MMIO pages are allocated probably makes that
impossible - but load_unaligned_zeropad() relies on
it not happening or not breaking anything.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

