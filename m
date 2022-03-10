Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5934D4C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiCJOzp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 09:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbiCJOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:39:42 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 313A2D4447
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:32:51 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-110-jc5_mpacNNeGF6-wP0QCGQ-1; Thu, 10 Mar 2022 14:32:48 +0000
X-MC-Unique: jc5_mpacNNeGF6-wP0QCGQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Mar 2022 14:32:46 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Mar 2022 14:32:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bharata B Rao' <bharata@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
Subject: RE: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Thread-Topic: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Thread-Index: AQHYNHBEWuVw0etF4EmWwhK6DFJ++Ky4rWmQ
Date:   Thu, 10 Mar 2022 14:32:46 +0000
Message-ID: <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
References: <20220310111545.10852-1-bharata@amd.com>
In-Reply-To: <20220310111545.10852-1-bharata@amd.com>
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

From: Bharata B Rao <bharata@amd.com>
> Sent: 10 March 2022 11:16
> 
> This patchset makes use of Upper Address Ignore (UAI) feature available
> on upcoming AMD processors to provide user address tagging support for x86/AMD.
> 
> UAI allows software to store a tag in the upper 7 bits of a logical
> address [63:57]. When enabled, the processor will suppress the
> traditional canonical address checks on the addresses. More information
> about UAI can be found in section 5.10 of 'AMD64 Architecture
> Programmer's Manual, Vol 2: System Programming' which is available from
> 
> https://bugzilla.kernel.org/attachment.cgi?id=300549

Is that really allowing bit 63 to be used?
That is normally the user-kernel bit.
I can't help feeling that will just badly break things.

Otherwise the best thing is just to change access_ok()
to only reject addresses with the top bit set.
Then you shouldn't need any extra tests in the fast-path
of access_ok().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

