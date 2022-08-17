Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF015596C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbiHQJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHQJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:56:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6456CD30
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:56:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C05701FF53;
        Wed, 17 Aug 2022 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660730180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlaM5jsefyqn6iyOyb/nsZBu5oVJmw5yd4SSQiTvMJE=;
        b=g+9NMjknH7ywUB0BRsk1ndk1pDUg5Xd0Hs2jYpd+AcFVbmeQ07hN2vbGNuQcFZZEwAbkAq
        YXqRht4FpBofL84QcDA1MRScXoqV49rVFsKuSS23KuRsejTIzmwmJSCeJVY9ZxdkF2Rotm
        adu0QZVTJOFJz1wbe7P8xD0SbftMyAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660730180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlaM5jsefyqn6iyOyb/nsZBu5oVJmw5yd4SSQiTvMJE=;
        b=eNv4huf7qWyrGLL+wycFmFtftLFYqeezLk8J+spiU0mUaQUOBQBXJdRqdN1EyMp1iF7ccM
        TuvbY+L/uR8jO4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FEF213428;
        Wed, 17 Aug 2022 09:56:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id znLCHES7/GLPeQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 17 Aug 2022 09:56:20 +0000
Date:   Wed, 17 Aug 2022 11:56:18 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <Yvy7QlQtKcIo7whL@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220729125141.12786-1-pvorel@suse.cz>
 <YuPYWLD7xxcNmuCx@pevik>
 <YuPlUOT1nFyT9Fm7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuPlUOT1nFyT9Fm7@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 29, 2022 at 02:53:44PM +0200, Petr Vorel wrote:
> > Hi all,

> > > Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

> > > This helps people who debug kernel with initramfs with minimal
> > > environment (i.e. without coreutils or even busybox) or allow to open
> > > sysfs file instead of run 'uname -m' in high level languages.

> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---

> > Changes v1->v2:
> > * Add file into /proc/sys/kernel/ (previously it was in
> >   /sys/devices/system/cpu/). There are 

> Looks like this line ended too soon?

> > * Update Documentation/ABI/ (Greg)

> This looks good to me, I'll queue it up after the next -rc1 is out
> unless someone objects.

Hi Greg,

gently ping just to make sure you didn't forget on it. I'm sorry if I overlooked
it (search in next tree and your git trees) or if you remember and are too busy
(fully understand).

Kind regards,
Petr

> greg k-h
