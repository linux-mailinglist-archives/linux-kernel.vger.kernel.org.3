Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BC959CE76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiHWCYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239564AbiHWCYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1815B052
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0AB61231
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF725C433D6;
        Tue, 23 Aug 2022 02:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661221447;
        bh=yFFXO19T4zVwa/udjGwX7Hl4bE7/HyBI79/1mVLRykk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gyvmhp0IBzvg5E9IDd31UToV+Pr6XU922okDGjSiHSH3atS3jRfVdoKq7JBvOWiCZ
         yA7PAOUXHWYq2940VmHpdQlQlXBzab8st811etFmj2kLPbwfbOfENtnrdh7i/BP040
         j8a3eabsM81lW/PrqCcu8WCGL6ZQAEZjnr6DA28c=
Date:   Mon, 22 Aug 2022 19:24:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Shigeru Yoshida <syoshida@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2] mm/gup.c: Fix return value for
 __gup_longterm_locked()
Message-Id: <20220822192406.612a596aa5fecd5e6ff67023@linux-foundation.org>
In-Reply-To: <8735dnu53w.fsf@nvdebian.thelocal>
References: <20220822153713.962904-1-syoshida@redhat.com>
        <8735dnu53w.fsf@nvdebian.thelocal>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 11:15:29 +1000 Alistair Popple <apopple@nvidia.com> wrote:

> > Fixes: 61c63c2076d9 (mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes)
> 
> I couldn't find that SHA1, I'm guessing due to rebasing, etc. of
> mm-unstable? 

Yup.  That's why we include the patch title as well as its hash.
