Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E903151E17F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355418AbiEFWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiEFWBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:01:20 -0400
X-Greylist: delayed 2159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 14:57:35 PDT
Received: from smtp-1.orcon.net.nz (smtp-1.orcon.net.nz [60.234.4.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1F24BD8;
        Fri,  6 May 2022 14:57:35 -0700 (PDT)
Received: from [121.99.247.178] (port=6746 helo=creeky)
        by smtp-1.orcon.net.nz with esmtpa (Exim 4.90_1)
        (envelope-from <mcree@orcon.net.nz>)
        id 1nn5OE-0004Rh-Me; Sat, 07 May 2022 09:21:31 +1200
Date:   Sat, 7 May 2022 09:21:25 +1200
From:   Michael Cree <mcree@orcon.net.nz>
To:     linux-alpha@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Alpha: rare random memory corruption/segfault in user space bisected
Message-ID: <YnWRVd5slCy5H0fC@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha kernel has been exhibiting rare and random memory
corruptions/segaults in user space since the 5.9.y kernel.  First seen
on the Debian Ports build daemon when running 5.10.y kernel resulting
in the occasional (one or two a day) build failures with gcc ICEs either
due to self detected corrupt memory structures or segfaults.  Have been
running 5.8.y kernel without such problems for over six months.

Tried bisecting last year but went off track with incorrect good/bad
determinations due to rare nature of bug.  After trying a 5.16.y kernel
early this year and seen the bug is still present retried the bisection
and have got to:

aae466b0052e1888edd1d7f473d4310d64936196 is the first bad commit
commit aae466b0052e1888edd1d7f473d4310d64936196
Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date:   Tue Aug 11 18:30:50 2020 -0700

    mm/swap: implement workingset detection for anonymous LRU


Pretty confident this is the bad commit as the kernel built to the parent
commit (3852f6768ede54...) has not failed in four days running. Always have
seen the failure within one day of running in past.

Cheers,
Michael.
