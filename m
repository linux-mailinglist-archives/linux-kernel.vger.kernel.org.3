Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311204B7E94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbiBPDTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:19:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiBPDTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:19:06 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAB6DCE07
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:18:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso5279751pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T5VNuyeSBthWMMLrNlFRHhrr7dl6RspIVBd0F2a1wPs=;
        b=DRcZrWArLaIOVuy/RL+jlJYVyHT4j1w1j/V6auaYiLk9gEJs7ZIpJ7bxQ5t5rtlGDy
         0cWA3XtZdDclCAMIYmnnPKRfBK9nwnLAGWPHxm4EczL4C0lp4T+L5Gjhctk2vAEXDJA5
         2bX+khNp9Tk7Vanbryguhto5Do8rnsUeup1Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T5VNuyeSBthWMMLrNlFRHhrr7dl6RspIVBd0F2a1wPs=;
        b=K+w+BIwvHP1hUHBjl4IoICGNNOqBI67SkJSK8BeGx4RvKiKEdFRN4CkNmGSKuhR4Qw
         Y/EqIdT5kGxm7kCr3ISsaIEwH/4Euw0o2KBL3mS0mMFkpQHr18uf3Hxjrz9AZKO992yc
         Do+ChUw7HOjW8M+E+ytJ+eW0T21U1Ogxusi5a0RpeYdHteh1L9XrI3sMo7doqDccXIax
         ARx8DtiK7Jdwh+x/qfZGP/vE3BF5kr4EnRJwTfru46QT0vKyYqgkFQoP/fNvc5/0BHMo
         gPP+rmNlGEKJuH6z3PARCjNhVT3IxUBJkdSYgkQSheyEOsa1rJN1BUmdxItQ2dk3jMPH
         k+cg==
X-Gm-Message-State: AOAM533mvxFdV0czdCidsqh0iNGeX2IkzHrvbI4KPZqM5XA8MK0Ct7u2
        A1qY1FipdVWvc1vKCQrGp7qiyQ==
X-Google-Smtp-Source: ABdhPJzPhR9H7IutAqc5ylWLqwT7bFMtATl9yNO7twEnU8NADSd8JeSm55jOJcvuu/bd30PVcdJkSw==
X-Received: by 2002:a17:902:c201:b0:14d:26d2:3da8 with SMTP id 1-20020a170902c20100b0014d26d23da8mr700308pll.56.1644981533664;
        Tue, 15 Feb 2022 19:18:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c926:4ee:add9:bf67])
        by smtp.gmail.com with ESMTPSA id t3sm44439269pfg.28.2022.02.15.19.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:18:53 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:18:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andre Kalb <andre.kalb@sma.de>, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        senozhatsky@chromium.org
Subject: Re: [PATCH v2] printk: Set console_set_on_cmdline=1 when
 __add_preferred_console() is called with user_specified == true
Message-ID: <YgxtGWh0b9NXTyu8@google.com>
References: <YgKSbe9d3haHKMid@alley>
 <YgpXWQqjfJBISG1v@pc6682>
 <YgvsqldT1sjfF5lf@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgvsqldT1sjfF5lf@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/15 19:10), Petr Mladek wrote:
[..]
> We should add a comment explaining the less obvious behavior as
> discussed in the thread. Something like:
> 
> > +static void set_user_specified(struct console_cmdline *c, bool user_specified)
> > +{
> > +	if (!user_specified)
> > +		return;
> > +
> 	/*
> 	 * @c console was defined by the user on the command line.
> 	 * Do not clear when added twice also by SPCR or the device tree.
> 	 */
> > +	c->user_specified = true;
> 	/* At least one console defined by the user on the command line. */
> > +	console_set_on_cmdline = 1;
> > +}
> > +
> >  static int __add_preferred_console(char *name, int idx, char *options,
> >  				   char *brl_options, bool user_specified)
> >  {
> 
> With the above comments:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Sergey, is it enough from your POV, please?

Yes, Petr. Thank you.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
