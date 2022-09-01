Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866BE5A9C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiIAPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiIAPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:47:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40688B983
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:47:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B0D7222AB1;
        Thu,  1 Sep 2022 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662047225;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ujwrYSfOp2/qwdZd5lBvBQNBPuVkcO1ZkFNKwbuxG+8=;
        b=VwzQ6jeLxCeIZ/8CvQ+oxCCiMsfoZnNW/yN50kr3UnxZ//mKb2Ixzz6KThGmyvbnz3dvxN
        UDT412GpeckvImCFgQCb8E582Bs14gdJCBimCFvVT2Ur6cbVB4DgQbReUXxpvQ0bgLXDn8
        +KNfJLcUoTxT1viWxgkHzRV/Ag6cB5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662047225;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ujwrYSfOp2/qwdZd5lBvBQNBPuVkcO1ZkFNKwbuxG+8=;
        b=yIDWnISbJUcngHtLNjfjomGsZNn656bFmEFF9zuC5lb6fYqCUhwKnY0Y+Tfl+F2GqNuUhn
        KFRo6XiCZ6qd6HBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E49713A89;
        Thu,  1 Sep 2022 15:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3a+GGPnTEGOKAgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 15:47:05 +0000
Date:   Thu, 1 Sep 2022 17:47:03 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Eric Biederman <ebiederm@xmision.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YxDT9xxMSFLu3xDI@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220729125141.12786-1-pvorel@suse.cz>
 <YxDBvD5XrbLApWMy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDBvD5XrbLApWMy@kroah.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

[ Cc Eric Biederman as the author of kernel/utsname_sysctl.c ]

> On Fri, Jul 29, 2022 at 02:51:41PM +0200, Petr Vorel wrote:
> > Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

> > This helps people who debug kernel with initramfs with minimal
> > environment (i.e. without coreutils or even busybox) or allow to open
> > sysfs file instead of run 'uname -m' in high level languages.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst | 5 +++++
> >  kernel/utsname_sysctl.c                     | 7 +++++++
> >  2 files changed, 12 insertions(+)

> Wait, why does the subject line say "drivers/base/cpu"?  That's not a
> file being touched in this commit at all, so this isn't for me to take
> :(

Thanks for info. My bad, I forget to update the subject.
I can send v3 with corrected subject, but who is going to take this?

$ ./scripts/get_maintainer.pl kernel/utsname_sysctl.c
linux-kernel@vger.kernel.org (open list)

There is listed Author: Eric Biederman, so is it him to Cc ?

Kind regards,
Petr

> thanks,

> greg k-h
