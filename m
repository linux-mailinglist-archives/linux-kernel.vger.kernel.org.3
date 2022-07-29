Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B28585031
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 14:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiG2Mxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiG2Mxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 08:53:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE113ED75
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 05:53:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA19F3490A;
        Fri, 29 Jul 2022 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659099226;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1l3gCb2ITnVsJmSIV6t3KClLKLUa/VNdqTVHaVw67TY=;
        b=pobXxGoeMxvPX4wrp4BpHBToMhQCL+Itxo+AsTqbUw+Bndf+xKyJhgHqB2VaelDpWwy6/j
        AwgmjEJBMGvFfvHDklOe9Fn3XR5jyj61W6N/ga+Ac79QF5NbWukaNU+4xiX+f1IQX6uEGs
        UxCzCLfyi9nMUQLwfXkmnF/6rcI/AaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659099226;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1l3gCb2ITnVsJmSIV6t3KClLKLUa/VNdqTVHaVw67TY=;
        b=91Sn7KlNa84Cn+U0DGODc4uEh/4gjDTWGxspFHY0OXVd8+xeaqdZpjPIVAK1GHNYvnoub8
        thfiQ1+F52aAc8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AD9D13A8E;
        Fri, 29 Jul 2022 12:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D26uHlrY42LIPQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 29 Jul 2022 12:53:46 +0000
Date:   Fri, 29 Jul 2022 14:53:44 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YuPYWLD7xxcNmuCx@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220729125141.12786-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729125141.12786-1-pvorel@suse.cz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

> This helps people who debug kernel with initramfs with minimal
> environment (i.e. without coreutils or even busybox) or allow to open
> sysfs file instead of run 'uname -m' in high level languages.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

Changes v1->v2:
* Add file into /proc/sys/kernel/ (previously it was in
  /sys/devices/system/cpu/). There are 
* Update Documentation/ABI/ (Greg)

Kind regards,
Petr

>  Documentation/admin-guide/sysctl/kernel.rst | 5 +++++ kernel/utsname_sysctl.c
>  | 7 +++++++ 2 files changed, 12 insertions(+)

> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index ddccd1077462..70a0acf07101 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -65,6 +65,11 @@ combining the following values:
>  4 s3_beep
>  = =======

> +arch
> +====
> +
> +The machine hardware name, the same output as ``uname -m``
> +(e.g. ``x86_64`` or ``aarch64``).

>  auto_msgmni
>  ===========
> diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
> index 4ca61d49885b..7ffdd2cd5ff9 100644
> --- a/kernel/utsname_sysctl.c
> +++ b/kernel/utsname_sysctl.c
> @@ -73,6 +73,13 @@ static DEFINE_CTL_TABLE_POLL(hostname_poll);
>  static DEFINE_CTL_TABLE_POLL(domainname_poll);

>  static struct ctl_table uts_kern_table[] = {
> +	{
> +		.procname	= "arch",
> +		.data		= init_uts_ns.name.machine,
> +		.maxlen		= sizeof(init_uts_ns.name.machine),
> +		.mode		= 0444,
> +		.proc_handler	= proc_do_uts_string,
> +	},
>  	{
>  		.procname	= "ostype",
>  		.data		= init_uts_ns.name.sysname,
