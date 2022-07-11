Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3920856FFB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiGKLLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiGKLKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:10:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FEF936A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:17:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fz10so4447571pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Chy1P2SvC5Z2Tef2FVwPTN5WdxCYsYsM+6qA20ohb8o=;
        b=egpubQ+Bo6jwgROuXgJcw08zCcn86rMzcOAq+KyGqPl/39GqB+YiD5G6tHzuD2rqtB
         A2wCJW4v8znoHP6mC+0TdGVbDMKK1T7oOQnO9JTpVtwcfoFqWZSsYrIM2XNAK6IxkrH1
         5uYyR07+uDN96y/lvr8oOmJ8fYtW9aOgg4hvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Chy1P2SvC5Z2Tef2FVwPTN5WdxCYsYsM+6qA20ohb8o=;
        b=dNgW6Se3sD091d4QtbRVNpHfgwN/R1cZcNCJXP8HTfkbnf7CtumuOiVwa07ort4dlM
         ILzSlw1W7gctg6XMJ8g2MGTNca0tr5ok56FLS5lQuvkszIQm7XbuJx4ITyNr32gpBghk
         ouJDV1eiIMA8N7RPxwyKWhX5qH9O7ZdYHCNVKemyscvKKs9BJLxDhe69pnlEMJgtmxpT
         8tZWAZ9UZOC2tutL+YpOwl7xKWObuiROrjVto6kS40NddQq3w6XmNmti41TWgRiX3VTd
         m2m96Vohzo4yLOS7fUiT2dOSyh6NpQMZzvaVdkDBL430DJlNif2XIU4N/pWjoJSBLcvD
         JS5Q==
X-Gm-Message-State: AJIora9Wh1qnWS1s9VpoQxo+2lgAT72UciC6ml5tIhvnbS9Nvbs/2QQn
        831G1KstMe2w4LQVIBnoPZqqRg==
X-Google-Smtp-Source: AGRyM1sDRAnprYdJux/GSOSJS1Ld0eGbxfHWT6AELkF9OSQhvIZud965RJ/o8INzZYeKX2CxX9ch7Q==
X-Received: by 2002:a17:90b:4b09:b0:1f0:1caa:9f05 with SMTP id lx9-20020a17090b4b0900b001f01caa9f05mr12017812pjb.12.1657534652932;
        Mon, 11 Jul 2022 03:17:32 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:ef9b:8bda:6cfb:9c5a])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00169c54f6d01sm4334045plx.221.2022.07.11.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:17:32 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:17:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: design: was: Re: [RFC PATCH v2] printk: console: Allow each
 console to have its own loglevel
Message-ID: <Ysv4t6ofeq6tL7Oj@google.com>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
 <87o7xz5su4.fsf@jogness.linutronix.de>
 <YsvgDRQICB3nEc1l@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsvgDRQICB3nEc1l@alley>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/07/11 10:32), Petr Mladek wrote:
> On Fri 2022-07-08 21:10:35, John Ogness wrote:
> > On 2022-07-08, Petr Mladek <pmladek@suse.com> wrote:
> > > The console-specific loglevel might be set by:
> > >
> > >   + "console=device,options/loglevel" kernel parameter at boot time
> > 
> > I ask if we avoid the use of "/loglevel" and instead use a generic
> > scheme of:
> > 
> > console=device,option,option,option
> > 
> > Of course, it would mean that the type of option would need to be
> > specified. Something like:
> > 
> > console=ttyS0,115200n8,loglevel=3
> 
> I like this. It is longer but it makes the meaning very obvious.

Looks beautiful.
