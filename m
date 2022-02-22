Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11B94BF5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiBVK2d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Feb 2022 05:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiBVK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:28:26 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB2C415AF2D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:27:53 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-150-6O66LGR1NAi-rhPf72s5BA-1; Tue, 22 Feb 2022 10:27:50 +0000
X-MC-Unique: 6O66LGR1NAi-rhPf72s5BA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 10:27:50 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 22 Feb 2022 10:27:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'kernel test robot' <lkp@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: RE: arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast
 removes address space '__user' of expression
Thread-Topic: arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast
 removes address space '__user' of expression
Thread-Index: AQHYJ4VSx2ykeBsAVUeqHfHkmiRxuayfXTDw
Date:   Tue, 22 Feb 2022 10:27:49 +0000
Message-ID: <3b28b453484648209007d9ac098a424c@AcuMS.aculab.com>
References: <202202220814.BN1x9yF4-lkp@intel.com>
In-Reply-To: <202202220814.BN1x9yF4-lkp@intel.com>
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

From: kernel test robot
> Sent: 22 February 2022 00:43
...
> vim +/__user +295 arch/x86/kernel/cpu/sgx/virt.c
> 
>    260
>    261	/**
>    262	 * sgx_virt_ecreate() - Run ECREATE on behalf of guest
>    263	 * @pageinfo:	Pointer to PAGEINFO structure
>    264	 * @secs:	Userspace pointer to SECS page
>    265	 * @trapnr:	trap number injected to guest in case of ECREATE error
>    266	 *
>    267	 * Run ECREATE on behalf of guest after KVM traps ECREATE for the purpose
>    268	 * of enforcing policies of guest's enclaves, and return the trap number
>    269	 * which should be injected to guest in case of any ECREATE error.
>    270	 *
>    271	 * Return:
>    272	 * -  0:	ECREATE was successful.
>    273	 * - <0:	on error.
>    274	 */
>    275	int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo, void __user *secs,
>    276			     int *trapnr)
>    277	{
>    278		int ret;
>    279
>    280		/*
>    281		 * @secs is an untrusted, userspace-provided address.  It comes from
>    282		 * KVM and is assumed to be a valid pointer which points somewhere in
>    283		 * userspace.  This can fault and call SGX or other fault handlers when
>    284		 * userspace mapping @secs doesn't exist.
>    285		 *
>    286		 * Add a WARN() to make sure @secs is already valid userspace pointer
>    287		 * from caller (KVM), who should already have handled invalid pointer
>    288		 * case (for instance, made by malicious guest).  All other checks,
>    289		 * such as alignment of @secs, are deferred to ENCLS itself.
>    290		 */
>    291		if (WARN_ON_ONCE(!access_ok(secs, PAGE_SIZE)))
>    292			return -EINVAL;
>    293
>    294		__uaccess_begin();
>  > 295		ret = __ecreate(pageinfo, (void *)secs);
>    296		__uaccess_end();

How on earth is that expected to work - or am I missing something.

If accessing 'secs' page faults then doesn't the address on the
instruction that faults need to be in the exception table (or
whatever it is called) in order for the kernel not to panic?

Isn't that even true if pagefault_disable() is called to stop
the page being loaded?

The only way the above can work is if the relevant user pages
are 'locked' so they can't possibly fault.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

