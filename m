Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152D4B428D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbiBNHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:08:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiBNHIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:08:48 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F93757B3D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:08:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 10so9842528plj.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VRsrjLJJwkV+1G8dUcK8QMCphluC37yJVoC3bjiX4u4=;
        b=TSXgYem9rsDI+/sOsl6rf/IZrkuhDPCQ0v/G8QWp2E2q35aTi7UqzbfAGlykhejZqB
         8/1pG1QdbB65J1vfBzBWzayBfR22xYGgTIbYZ7IIMviZ0kp903UfNvoHbnLk14HoK9XI
         XDvgXyvOV2YHLGvWoRjHfssDFFTNZnUsummpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VRsrjLJJwkV+1G8dUcK8QMCphluC37yJVoC3bjiX4u4=;
        b=ALqeLAnKLfBYzt0Yjdfoz5HBgjfixFArHhbch8nPdxEpzxEmNG+tcp/Zjt3fShpmpM
         g7W/sGHLRXLA89nfY6mV0ViIBbMD0+IaAW7lBs7jsMbKf61gNBEOtGnbyUVDufkDSEWW
         c3ZDXD5sauB7m+bxDc7yE9v6EbKlVo3aWxy/C5pJqnTVhdLhW2IVkyUo1Tdnzu+OFcrj
         zEA6XFonzN5OHpDOokgUBT3uq741Ums1fGPzWXNy1pU4zNZw3kHQZfxkq4v1lwj8PeSs
         XGhMPCppcE5jPAAOe38nD4xNQYiEGrHTDVTRO23CpvgHwQAP89uagbsn+avak5Ehs+hy
         smBw==
X-Gm-Message-State: AOAM533t7/agYWJtzVWRah6EIzXXqbrZrG37a2Q/ngSjsPb0iEEL+/fH
        cJ0BkvFIWvWqufstRbdyEaAMgCYIfcVK4A==
X-Google-Smtp-Source: ABdhPJzlnqNkMpfB3fQ7XS+bVL2JHeWKM4eyRb0dMkmxQcMZvnlv34tG6kXlyBXqSqtYqokbz9Y/Ow==
X-Received: by 2002:a17:90a:142:: with SMTP id z2mr4020369pje.160.1644822520052;
        Sun, 13 Feb 2022 23:08:40 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3a3d:6c6e:58a7:8903])
        by smtp.gmail.com with ESMTPSA id a14sm9774083pgw.27.2022.02.13.23.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:08:39 -0800 (PST)
Date:   Mon, 14 Feb 2022 16:08:35 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
Message-ID: <Ygn/8yNrHnZEomJy@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <YgaJZtY+EH9JIGyo@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgaJZtY+EH9JIGyo@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/11 17:05), Petr Mladek wrote:
> I dug more into the history to be more confident about the change.
> I am not sure that it is safe.
> 
> CON_ANYTIME really seems to be related to per-CPU variables and early
> boot, see the commit 76a8ad293912cd2f01eca ("[PATCH] Make printk work
> for really early debugging").

Hmm... This looks a bit tricky. It seems that the commit in question
is concerned with per-CPU variables access indeed; not printk() per-CPU
access though but per-CPU access from con->write(). I guess console_unlock()
did not use to access per-CPU variables before, it does now, so that
can_use_console() in fact protects both printk (which certainly happens)
and con->write() (do we even have it?) per-CPU access

	console_unlock()
	{
		if (!can_use_console())
			return;

		for (;;) {
			printk_safe_enter_irqsave() -> __this_cpu()

			printk_safe_exit_irqrestore() -> __this_cpu()
		}
	}
