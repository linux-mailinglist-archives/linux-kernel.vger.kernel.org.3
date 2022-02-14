Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5934B416D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiBNFfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:35:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiBNFfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:35:14 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDAA4E3B9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:35:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x3so9685212pll.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jzn4hsJRFYNyzoaX1p9S126I6OSQ6YvVGSFjQc0tWxY=;
        b=fPH3qI2AO/ATHvgsolaFXu4roV8bEOFyQTjcIjZdgb0JeHbAjktvPHvqrbZ00O9yC2
         3xqKn1qA8YCApR8ydxNQi783aWwW2T/KMg+3zmsxUEAfUgT6w9ohceTKxU4EnindtkyA
         9k5cLu+dCOMthX9tOtD/ohsiKw21E73IwpP1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jzn4hsJRFYNyzoaX1p9S126I6OSQ6YvVGSFjQc0tWxY=;
        b=qx8Qrk+kwxb3xvmZ12s83Uij/UDAqFWxH0GzJoWb6X40cJ1W+vJ9Lh7Jv7gMGbD5nf
         ZqJyTmkuCxZe0TU54Rod9382i9u0hXmuNYb9INiY36QVZwVkzDr82CiLRjy0vmOkLsvK
         Tk5qqJLxwcuJ2ikZ+l/AgkhNfBfNy/f3Onpqx6dCOaNlq1IdIQef4cNzeLCKDDnIwNcc
         pF/5VQ8rIv4ZRcqiv9aQ5VlPReQ64qCDL6gs2WO0RqYOUyN2nsj3sK2CSCGLxgp4EnsX
         4YKVPeLkmNua26YSPoUXToWTtOYQSnpN7QQcv37HVA0ZSSgiJsQ8mikbJcucEgVb6r9N
         kdxw==
X-Gm-Message-State: AOAM5318WXNEQw+htLG1gHE5uF7dc64VaCS1DjPlYiXQ+A7R9qZ2NZeV
        9jYFhnLUIHZEQT6tama7re77xw==
X-Google-Smtp-Source: ABdhPJwet6jh+A4G6kRcJV4naRJgFHYU6623YLor5nGqlqeZgT4l/wEogyRS6QrttiFnjdstd56aoA==
X-Received: by 2002:a17:902:eb45:: with SMTP id i5mr12926696pli.75.1644816907106;
        Sun, 13 Feb 2022 21:35:07 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b736:df7d:23c5:206e])
        by smtp.gmail.com with ESMTPSA id t1sm35733523pfj.115.2022.02.13.21.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 21:35:06 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:35:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] printk: defer_console_output: use atomic update
Message-ID: <YgnqBgzEhgZZskun@google.com>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
 <YfzP50vDiJiaRVCr@google.com>
 <87bkzj3t77.fsf@jogness.linutronix.de>
 <YgUzm5POctivsjUg@alley>
 <87leyhd4wc.fsf@jogness.linutronix.de>
 <YgnphtfTRBenHgfp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgnphtfTRBenHgfp@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/14 14:32), Sergey Senozhatsky wrote:
> On (22/02/11 12:28), John Ogness wrote:
> > Hi Petr,
> > 
> > On 2022-02-10, Petr Mladek <pmladek@suse.com> wrote:
> > > The patch has been committed into printk/linux.git, branch for-5.18.
> > 
> > Sebastian also pointed out that the use of __this_cpu_xchg() is the same
> > problem with the same variable for the same reason. We should fold that
> > change into the patch as well. The patch will followup this message.
> 
> But that __this_cpu_xchg() (that this lol) can only be performed form the
> IRQ context. Can you please elaborate what is the problem with it?

Oh, it can race with NMI, yeah.
