Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359CE4ACEBC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbiBHCQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345506AbiBHCPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:15:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92215C0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:15:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c3so12629918pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 18:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=91NCb5EYzhKuUKp45uli6bWUtNYygLxTpv0v3uA27sw=;
        b=CU8VEHfQz9jVkk1c6wJRXsKSB2I+vbMObObLLyLNFjd+VjxdrQBj+KZiVNu3q08t3D
         RApgG6wN3M/Upu1lQkKgzCl1+5cut8jj1M23oA0YXQVGlp2iBtVvECFjjzxz6X+l1X3i
         dqAQ0LLi3aXxwjC6+YiwHofT25bh8Jy2rFd+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91NCb5EYzhKuUKp45uli6bWUtNYygLxTpv0v3uA27sw=;
        b=PtMbmtv14KeZpQw59gbDxI9Op/5BJt5AUPjhw2FEZHpHr+ELQfhZp6SrS6Zb0F5zRy
         sNNUgsjHMhA52/6YAXX6uz+QMxGmyD+3bBr+YTINFtOzLzOKOB9mrpVETKzAKypJzjmC
         2v9IHnDnW7AU7BqQomZr9nHGNmWe+2//w+NlIGzuDduaHl9jRbJOgQnCHQ4NicWPVv4i
         A6I+nXS6Oy9cM1Ky16MWjJq69jN+6DcAi9+6CLTRdFE+qLC5fy49QYdB0rZ8r7n++CdS
         gtBsA5c0FXVROwyDhCzG7ZGu9ga9ucgSKZQM75F4CkKwe/7ubO8t86E9ExNsKNGfD4j/
         2u7Q==
X-Gm-Message-State: AOAM532TNYwJzleyO04v3qspfdnYkFaz2iRNmqJh2Pk5+W/Lg1TmCUv8
        qfrjGOepGTP6rQWLqBEq3Tw/u3Yb/1LZnw==
X-Google-Smtp-Source: ABdhPJxhBh2LyplB7VAkibhOk0liXWx3no7Si+rJUmdEQcNClFx57L54r2dMEdxk0TkxMgyHBHUNRQ==
X-Received: by 2002:a17:902:6942:: with SMTP id k2mr2483316plt.133.1644286520072;
        Mon, 07 Feb 2022 18:15:20 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:892d:3c06:3dca:f230])
        by smtp.gmail.com with ESMTPSA id s42sm14215487pfg.146.2022.02.07.18.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:15:19 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:15:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v3 4/4] printk: Drop console_sem during panic
Message-ID: <YgHSM3nc/04X6F7s@google.com>
References: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
 <20220201185802.98345-5-stephen.s.brennan@oracle.com>
 <Yfyl2TSdFmn7HqmV@google.com>
 <87v8xuea4j.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8xuea4j.fsf@stepbren-lnx.us.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/04 10:53), Stephen Brennan wrote:
> Sergey Senozhatsky <senozhatsky@chromium.org> writes:
> > On (22/02/01 10:58), Stephen Brennan wrote:
> >> +/*
> >> + * Return true when this CPU should unlock console_sem without pushing all
> >> + * messages to the console. This reduces the chance that the console is
> >> + * locked when the panic CPU tries to use it.
> >> + */
> >> +static bool abandon_console_lock_in_panic(void)
> >> +{
> >> +	if (!panic_in_progress())
> >> +		return false;
> >> +
> >> +	/*
> >> +	 * We can use raw_smp_processor_id() here because it is impossible for
> >> +	 * the task to be migrated to the panic_cpu, or away from it. If
> >> +	 * panic_cpu has already been set, and we're not currently executing on
> >> +	 * that CPU, then we never will be.
> >> +	 */
> >> +	return atomic_read(&panic_cpu) != raw_smp_processor_id();
> >> +}
> >> +
> >>  /*
> >>   * Can we actually use the console at this time on this cpu?
> >>   *
> >> @@ -2746,6 +2765,10 @@ void console_unlock(void)
> >>  		if (handover)
> >>  			return;
> >>  
> >> +		/* Allow panic_cpu to take over the consoles safely */
> >> +		if (abandon_console_lock_in_panic())
> >> +			break;
> >
> > Sorry, why not just `return` like in handover case?
> 
> We need to drop console_sem before returning, since the whole benefit
> here is to increase the chance that console_sem is unlocked when the
> panic_cpu halts this CPU.

Yes, that makes sense.

> in the handover case, there's another cpu waiting, and we're essentially
> transferring the console_sem ownership to that cpu, so we explicitly
> return and skip the unlocking portion.
> 
> Does this need some comments to clarify it?

No. Everything looks good. Thanks.
