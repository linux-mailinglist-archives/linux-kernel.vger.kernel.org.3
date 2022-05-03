Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065DE5180AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiECJMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiECJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:12:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6C3630A;
        Tue,  3 May 2022 02:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B68CB81AEC;
        Tue,  3 May 2022 09:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB87C385A4;
        Tue,  3 May 2022 09:09:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e6u3+++1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651568941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ue0I8PUx1rbJUB/KOG3KInep7V9GfkJzwoaHuOs78ZA=;
        b=e6u3+++1dicGbC4FMUGxXv1sAJ5Dx51pF4bRcroG8Ol/m76xse1KpyACM45AXrxe7NCnbe
        ElPY+LRNOcPNm2/kAcadaPbjuBbHPbWgVMmuutqTmpSK7a3rCIGeqlFoxbWg7eISkB376s
        fkhAFMOg9eWkoXevaW3S8liCdVITnCc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1d3dfc93 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 3 May 2022 09:09:01 +0000 (UTC)
Date:   Tue, 3 May 2022 11:08:59 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnDxK/O2E6LUhP/2@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
 <YnDc8A+oTxsQs/hq@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnDc8A+oTxsQs/hq@gardel-login>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lennart,

On Tue, May 03, 2022 at 09:42:40AM +0200, Lennart Poettering wrote:
> For this MAC address usecase it's entirely sufficient to be able to
> distinguish if the system was closed at all, i.e. if the counter is
> zero or is non-zero. Because that would already be great for a policy
> of "hash it in a stable way from /etc/machine-id, if counter == 0" +
> "use random MAC once counter > 0".

Hm, are you sure that's actually what you want? It turns out this
vmgenid notification from the hypervisor might not be sufficiently
granular for this use case:

- vmgenid changes when you fork a new snapshot, so now you have two VMs
- vmgenid also changes when you rewind to 2 minutes ago

The first is what I assume you care about for this networkd business.
The second is probably not what any networkd user expects.

[Aside: I hope there are few networkd users; having seen what Yu did
with wireguard and how fast and recklessly that went, I can't recommend
that part of systemd to anyone.]

From the perspective of randomness, both of these events imply the same
thing. The situation is BAD; reseed immediately. From the perspective of
MAC addresses, though, these events would imply different behavior,
right? So it seems like vmgenid might need an additional field for this
use case. Relatedly, VMware has that prompt where you select about your
VM whether, "I moved it" or "I copied it." Presumably something like
that would play a part in what is decided as part of this hypothetical
second field.

Let me know if this seems right to you, or if actually you had in mind
changing MAC addresses in both cases instead.

Jason
