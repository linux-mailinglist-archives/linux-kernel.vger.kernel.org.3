Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8B479766
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhLQXBB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 18:01:01 -0500
Received: from mailgate.zerties.org ([144.76.28.47]:50734 "EHLO
        mailgate.zerties.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhLQXBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:01:00 -0500
X-Greylist: delayed 1681 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 18:01:00 EST
Received: from ip5f5ab8e0.dynamic.kabel-deutschland.de ([95.90.184.224] helo=localhost)
        by mailgate.zerties.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <stettberger@dokucode.de>)
        id 1myLmW-0000Nj-Ho; Fri, 17 Dec 2021 22:32:55 +0000
From:   Christian Dietrich <stettberger@dokucode.de>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Yannick Loeck <yannick.loeck@tuhh.de>, kernel@maxfragg.de
Organization: Technische =?utf-8?Q?Universit=C3=A4t?= Hamburg
X-Commit-Hash-org: f01fca33b1535359a4f3d7fe903261c35a059bba
X-Commit-Hash-Maildir: 114fe0b8caac20f124b5529e59e164f0432574dc
Date:   Fri, 17 Dec 2021 23:32:51 +0100
Message-ID: <s7b7dc2ooa4.fsf@dokucode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-SA-Do-Not-Rej: Yes
X-SA-Exim-Connect-IP: 95.90.184.224
X-SA-Exim-Mail-From: stettberger@dokucode.de
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mailgate.zerties.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no
        version=3.4.4
Subject: vm_insert_pages, missing #define pte_index
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone!

I tried to understand the mm/memory.c and the function
`vm_insert_pages', and perhaps I found a CPP-related bug there.

Roughly, the function looks like this:

int vm_insert_pages(...)
{
#ifdef pte_index
        [.....]
        [// insert pages amortizes spinlock acquisitions]
	return insert_pages(vma, addr, pages, num, vma->vm_page_prot);
#else
	for (; idx < pgcount; ++idx) {
                [[ // Takes one lock per PTE ]]
		err = vm_insert_page(vma, addr + (PAGE_SIZE * idx), pages[idx]);
                [....]
	}
#endif  /* ifdef pte_index */
}

So, you surely want to have the upper variant as it performs less
spinlock acquisitions. Assume you would use the lower one, everything
would be fine and you would not notice it right from the start.

With 974b9b2c68f3d35a65e80af9657fe378d2439b60 (Jun 2020), Mike Rapoport
moved all arch-specific pte_index defintions from arch/ to
include/linux/pgtable.h and transformed it to an inline function. Which
is a good thing, but the preprocessor does not know about inline
functions.... They do not define CPP macros.

Therefore, I think, we always use the lower variant. When compiling an
x86 Linux and adding an #error to the upper CPP block, I don't get a
preprocessor error and my source code (I'm looking at next-20211015)
does not contain any define for pte_index.

This is probably not as intented.

chris
-- 
Prof. Dr.-Ing. Christian Dietrich
Operating System Group (E-EXK4)
Technische Universität Hamburg
Am Schwarzenberg-Campus 3 (E), 4.092
21073 Hamburg

eMail:  christian.dietrich@tuhh.de
Tel:    +49 40 42878 2188
WWW:    https://osg.tuhh.de/

