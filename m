Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B505AA17A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiIAVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiIAVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:25:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5F54CAB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:25:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4849520637;
        Thu,  1 Sep 2022 21:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662067535;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZhfAFK+s57FlhVBfKpeOWjhLLLthHzN52MYfn6xqLk=;
        b=hyHEuDtxqCUmvLWH9bHlEQtMZr3aEIni/K4gw3pEvssN3Z5v7a8JTBOXDZDdknJ7yCPOvu
        PwszOH0+lEPJAbGO7l4CDTx9nrr2zZV7uUhynNvndjZbsh8iNt6gp4B84i1+gXob4auSre
        4XqSosvVsyAlEOIhT008VYfr22Volww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662067535;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZhfAFK+s57FlhVBfKpeOWjhLLLthHzN52MYfn6xqLk=;
        b=s+vRjkaB15YkOffb3Z+SAkL9WPfMsPUGpFuIka6FCVApd41JrMqy5xPpVB5ImpOESv0u50
        L6LVF7ilEtqjT/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E882A13A79;
        Thu,  1 Sep 2022 21:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jKu7NU4jEWPwBwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 21:25:34 +0000
Date:   Thu, 1 Sep 2022 23:25:32 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 1/1] kernel/utsname_sysctl.c: Print kernel arch
Message-ID: <YxEjTK7zFfe4cxhS@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220901194403.3819-1-pvorel@suse.cz>
 <20220901131539.1bfacab0f60b5116e492a46c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901131539.1bfacab0f60b5116e492a46c@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu,  1 Sep 2022 21:44:03 +0200 Petr Vorel <pvorel@suse.cz> wrote:

> > Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

> > This helps people who debug kernel with initramfs with minimal
> > environment (i.e. without coreutils or even busybox) or allow to open
> > sysfs file instead of run 'uname -m' in high level languages.

> If they're this constrained, why not run sys_uname() directly?

Hi Andrew,

of course you're right that in C is the most straightforward way to use uname(2).
I was more concerned about userspace, but I have to admit uname is probably
everywhere, therefore this is probably useless.

The background of this was my colleague while writing software running LTP tests
with qemu (using whole systems on qcow image or minimal dracut initramfs) or over SSH
got all info about running kernel from proc / sysfs, just architecture was
missing.

/proc/cpuinfo and /sys/devices/system/cpu/ are full of details about CPU, but
surprisingly no info about the architecture. Understand, this info is in struct
utsname and there is uname binary, OTOH there are
/proc/sys/kernel/{osrelease,ostype,version}, which are also in struct utsname.

Kind regards,
Petr

