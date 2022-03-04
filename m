Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980A14CD7BE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiCDP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCDP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:29:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4558A5D5F0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646407694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g42Xqz/xFjdfHKKctZX2n0O2xenLqOF9Td0jlr5ge1E=;
        b=KCkJIkZaPuWhZgeSQpV7/MzcSBmtKrVglox/mKxkjl3qKgl030ioXeTUkxRCOaU1ZrLXnY
        GbG2iaDQ2Q5MOipmAxaFro3oG245B4ZuI7+9o04EbyWyGg4tjxdHaPcj/YOVyPxgHrvVGu
        iZT9AG4VYWwTse77udKgoGkoxhDd/MM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-bG2cGgz9MgW04LjEmes3ew-1; Fri, 04 Mar 2022 10:28:13 -0500
X-MC-Unique: bG2cGgz9MgW04LjEmes3ew-1
Received: by mail-wm1-f71.google.com with SMTP id f189-20020a1c38c6000000b0037d1bee4847so4239485wma.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 07:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=g42Xqz/xFjdfHKKctZX2n0O2xenLqOF9Td0jlr5ge1E=;
        b=PraRT/H9w06Woxgugx8ekvuYcQrTjIUftCqO/5tkaU4TJfEMB7Hgdd54VWApvUPGEG
         Y8lBX5nifwoxuL+NLgkAQ1dL1J1E0DfdtzTEaQpZqwpmpBIFzgQPUuOiUzNK8VF5drwU
         Ytdnggebx4WTLuf6+YC9ls3Z+7sH/o+to93EN38H2qFgP4FAOeA2QvzkXvULAgOjo66a
         eLCQ8EjwcCZOMeR9RqkLmpA6eMrhek3qkupaRNkF/tItXaeMftQ4fUvUt1kFImdc9q1O
         B3b5e9f8ID047XRFaxvPc905En9+COc33ImRSetzLw/LgJVvPoI/0smERtrfV/ttNXME
         aR8A==
X-Gm-Message-State: AOAM5317YZYnw2SR5j4NguCOGHdJ74nBTP9gdiZxkbS1Y7MzrBKoO1Yd
        rqfnw6y0H97qhDIGa7nZAXpmgQCueYhbPUClthPbXA60/ay9dBeKpAqX1O1jbLuYUV5NthD/Wqy
        ejTyIK3NZq9QCiCYPXoK2eIvV
X-Received: by 2002:a05:600c:2056:b0:389:736a:5631 with SMTP id p22-20020a05600c205600b00389736a5631mr4720019wmg.120.1646407691890;
        Fri, 04 Mar 2022 07:28:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaYJwwz0uhJI5sa9O0jVgucPyHxAZEk/U+E5pSIXGXG5hl28xfZA2tDnmw93kWXnDHBP+YLQ==
X-Received: by 2002:a05:600c:2056:b0:389:736a:5631 with SMTP id p22-20020a05600c205600b00389736a5631mr4720006wmg.120.1646407691680;
        Fri, 04 Mar 2022 07:28:11 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm4846550wrv.79.2022.03.04.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:28:11 -0800 (PST)
Message-ID: <2b47679c6248a0d113b556ed6118e8ed72c74b29.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
        Juri Lelli <juri.lelli@redhat.com>
Date:   Fri, 04 Mar 2022 16:28:10 +0100
In-Reply-To: <abb789c3-0d1a-28e9-3b8d-e4a68e3f57f5@kernel.org>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
         <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
         <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
         <abb789c3-0d1a-28e9-3b8d-e4a68e3f57f5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, 2022-03-04 at 15:51 +0100, Daniel Bristot de Oliveira wrote:
> > > Hey Nicolas,
> > > 
> > > While testing this patch with rtla osnoise on the 5.17.0-rc6-rt10+, when I hit
> > > ^c on osnoise top, the system freezes :-/.
> > > 
> > > Could you try that on your system?
> > Yes of course, I'll get a build going.
> 
> 
> also, could you try this? 

Yes, of course.

> it is an RFC I was thinking to send, as I mentioned before (and on IRC).
> 
> It works fine, I see nohz_full and rcu behaving like if osnoise was a
> user-space tool. It is more invasive on osnoise, but the behavior does not
> change - like, run cyclictest on top of osnoise and you will see that
> the system is still preemptive with low latency even with osnoise with
> "preempt_disabled."
>
> do you mind having a look to see if it behaves as expected in your scenario?
> 
> [ note, there are things to cleanup in this patch, like adding a static key ]
> [ in is_osnoise_cur(), it was a real RFC. 				    ]
> 
> -- Daniel
> 
> tracing/osnoise: Pretend to be in user-space for RCU
> 
> To simulate an user-space workload, osnoise informs RCU that it
> is going to user-space by calling rcu_user_enter(). However,
> osnoise never actually goes to user-space. It keeps running
> in an intermediate stage.
> 
> This stage runs with preemption disabled, like the idle thread
> does. Likewise idle, osnoise will continuously check for need
> resched, allowing its preemption, simulating a fully preemptive
> mode.
> 
> Anytime a kernel function needs to be called, the rcu_user_enter()
> needs to be called.
> 
> Any change on rcu_user_enter/exit needs to be tested with
> CONFIG_RCU_EQS_DEBUG=y.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---

Some comments:
 - You're not exiting/entering EQS on IRQ/NMI entry/exit. See
   irqentry_{enter,exit}() and irqentry_nmi_{enter,exit}().

 - See this series[1], if we ever pursue this approach, it's important we got
   through context tracking, instead of poking at RCU directly.

[1] https://lore.kernel.org/lkml/20220302154810.42308-1-frederic@kernel.org/T/#t

Regards,

-- 
Nicolás Sáenz

