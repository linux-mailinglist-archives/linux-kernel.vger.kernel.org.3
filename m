Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17847483F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiADJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:57:09 -0500
Received: from mail.credativ.com ([93.94.130.90]:46912 "EHLO mail.credativ.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbiADJ5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:57:06 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 04:57:06 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.credativ.com (Postfix) with ESMTP id EC9E620067;
        Tue,  4 Jan 2022 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=credativ.de; s=email;
        t=1641289751; bh=M863bQvqJkCKLP3ueXjx9CKwToA3VdBDLVbhOgoGmtE=;
        h=Date:From:To:Cc:Subject:From;
        b=okhF2KvDjIXXrw8kVQgwNxwr32ztAf9yLLoO2ZlrAB5ObZZVrpUZdItj1D1mOX9S0
         6igaHeNL9slwllUH6Ju3+pt52ecJSauzxIyjENFduc7WWaU9cAZ8KEgPkAvHw/W14f
         yO1jjL5t+ZHM0ri112uy/o85XFvU3919kFyKYHkjOMq/JEUmCyidfmCH0GcyjlYCGv
         nywZEjt0G7/sR63rRXiXkqgs5u5hQmQMCnyLixOb8OChULn9Mdaw1C2wNIAm7V2TOo
         wr+39Bm9lbuLdbgx8YwkPtqjohB4eVmahb62sBoK2kUWiF78KR1YCfUVQnHNHCtNE8
         Z3kzpCLuacpjw==
Received: from mail.credativ.com ([127.0.0.1])
        by localhost (mail.credativ.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HKT81m1ar6Dc; Tue,  4 Jan 2022 09:49:04 +0000 (UTC)
Received: from softhammer.credativ.de (b2b-130-180-33-30.unitymedia.biz [130.180.33.30])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbl)
        by mail.credativ.com (Postfix) with ESMTPSA id A8FA320028;
        Tue,  4 Jan 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=credativ.de; s=email;
        t=1641289744; bh=M863bQvqJkCKLP3ueXjx9CKwToA3VdBDLVbhOgoGmtE=;
        h=Date:From:To:Cc:Subject:From;
        b=hAEf6fqoduyzmiqAIkDHzsgIAplPP9emAkgPWY8xpvLZHkImQWC7HgDaOLWLs1uCJ
         /0DS3u1juQyG4hu33odMDxTsqQDg8ghL+qYjnWSO/NBCF4o2fAiJfgm8omguWR/o6c
         SCiHUxAmP2OEdkRzBUzptHr5TP3ZFv7gisAcrelEZuJy13B91tyq8o2CrXHWH14Kuj
         qqydqU4dpU15gHD1NTSqqI6d+KVdG5FlsPyyapRp6OgAQIyXZkyJY6JpdwKboQClwl
         sEgX6tLKhQhRNKoc6R+ZukpNCtJ7O538iF/ecbxZvkBzd4xtiqsx920Yxte1mGMpFW
         Mdx/1P42dGskA==
Received: by softhammer.credativ.de (Postfix, from userid 1000)
        id 4JSnrJ1Gz6z9stv; Tue,  4 Jan 2022 10:49:04 +0100 (CET)
Date:   Tue, 4 Jan 2022 10:49:04 +0100
From:   Bastian Blank <bastian.blank@credativ.de>
To:     Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: SLAB use-after-free with ceph(fs)
Message-ID: <YdQYEF9WCTWTAzOp@softhammer.credativ.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moin

A customer reported panics inside memory management.  Before all
occurances there are reports about SLAB missmatch in the log.  The
"crash" tool shows freelist corruption in the memory dump.  This makes
this problem a use-after-free somewhere inside the ceph module.

The crashs happen during high load situations, while copying data
between two cephfs.

| [152791.777454] ceph:  dropping dirty+flushing - state for 00000000c039d4cc 1099526092092
| [152791.777457] ------------[ cut here ]------------
| [152791.777458] cache_from_obj: Wrong slab cache. jbd2_journal_handle but object is from kmalloc-256
| [152791.777473] WARNING: CPU: 76 PID: 2676615 at mm/slab.h:521 kmem_cache_free+0x260/0x2b0
[…]
| [152791.777530] CPU: 76 PID: 2676615 Comm: kworker/76:2 Kdump: loaded Not tainted 5.4.0-81-generic #91-Ubuntu
| [152791.777531] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/28/2021
| [152791.777540] Workqueue: ceph-msgr ceph_con_workfn [libceph]
| [152791.777542] RIP: 0010:kmem_cache_free+0x260/0x2b0
[…]
| [152791.777550] Call Trace:
| [152791.777562]  ceph_free_cap_flush+0x1d/0x20 [ceph]
| [152791.777568]  remove_session_caps_cb+0xcf/0x4b0 [ceph]
| [152791.777573]  ceph_iterate_session_caps+0xc8/0x2a0 [ceph]
| [152791.777578]  ? wake_up_session_cb+0xe0/0xe0 [ceph]
| [152791.777583]  remove_session_caps+0x55/0x190 [ceph]
| [152791.777587]  ? cleanup_session_requests+0x104/0x130 [ceph]
| [152791.777592]  handle_session+0x4c7/0x5e0 [ceph]
| [152791.777597]  dispatch+0x279/0x610 [ceph]
| [152791.777602]  try_read+0x566/0x8c0 [libceph]

They reported the same in all tested kernels since 5.4, up to 5.15.5 or
so.  Sadly I have no tests with newer builds available.

Any ideas how I can debug this further?

Regards,
Bastian

-- 
Bastian Blank
Berater
Telefon: +49 2166 9901-194
E-Mail: bastian.blank@credativ.de
credativ GmbH, HRB Mönchengladbach 12080, USt-ID-Nummer: DE204566209
Trompeterallee 108, 41189 Mönchengladbach
Geschäftsführung: Dr. Michael Meskes, Geoff Richardson, Peter Lilley
Unser Umgang mit personenbezogenen Daten unterliegt
folgenden Bestimmungen: https://www.credativ.de/datenschutz
