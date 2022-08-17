Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3482D5976BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiHQThe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHQThc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:37:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6D71158
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:37:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB74634C50;
        Wed, 17 Aug 2022 19:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660765048;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzInlafGughYx/WhZTuSPcjBNmWIquvmAe69BRN1WGI=;
        b=iOh4TMIkr49LYf4j5BJFwklypFIpJMg2PWgWngKx/W/78Nh4pMNoqc++mLoVsAi2mt7iRP
        T9R9YBxCivOcgkrfg/SSVFbjb9STUqI2TJSLrSnkI3XVSAxULz2VvLtLsIJ3AzIGB9dfQu
        mx2ZXsbmPZRm75yEHJ5HhLP+BavPOkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660765048;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzInlafGughYx/WhZTuSPcjBNmWIquvmAe69BRN1WGI=;
        b=RchA+RR9PPjJPelTucozm75vnXf6vYogUswf9x8tT08aqaZVv7VWHC6grxQiHSaOoAbuQb
        HqeYDHeHEHuog5BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7353A13428;
        Wed, 17 Aug 2022 19:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QjB6GnhD/WKIagAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 17 Aug 2022 19:37:28 +0000
Date:   Wed, 17 Aug 2022 21:37:26 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <Yv1DdvUglNYJHhO7@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220729125141.12786-1-pvorel@suse.cz>
 <YuPYWLD7xxcNmuCx@pevik>
 <YuPlUOT1nFyT9Fm7@kroah.com>
 <Yvy7QlQtKcIo7whL@pevik>
 <YvzOJOPUwQ3T4nV0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvzOJOPUwQ3T4nV0@kroah.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 17, 2022 at 11:56:18AM +0200, Petr Vorel wrote:
> > > On Fri, Jul 29, 2022 at 02:53:44PM +0200, Petr Vorel wrote:
> > > > Hi all,

> > > > > Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

> > > > > This helps people who debug kernel with initramfs with minimal
> > > > > environment (i.e. without coreutils or even busybox) or allow to open
> > > > > sysfs file instead of run 'uname -m' in high level languages.

> > > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > > ---

> > > > Changes v1->v2:
> > > > * Add file into /proc/sys/kernel/ (previously it was in
> > > >   /sys/devices/system/cpu/). There are 

> > > Looks like this line ended too soon?

> > > > * Update Documentation/ABI/ (Greg)

> > > This looks good to me, I'll queue it up after the next -rc1 is out
> > > unless someone objects.

> > Hi Greg,

> > gently ping just to make sure you didn't forget on it. I'm sorry if I overlooked
> > it (search in next tree and your git trees) or if you remember and are too busy
> > (fully understand).

> It's only been 2 days since -rc1 is out, and here's my todo queue right
> now:
> 	❯ mdfrm -c ~/mail/todo/
> 	1733 messages in /home/gregkh/mail/todo/

> It's in good company :)

Lol, thanks for info, I'm very sorry I was impatient.

Petr

> thanks,

> greg k-h
