Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C05498F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiFMPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbiFMPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:53:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1218AD9A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:37:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v14so7192540wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGj+H+fpRO/LlJr3MV24WDf1h9Fmi9x6UfIbBDjSN90=;
        b=XgUlqfja5ZWiDngd5yxO9/A1rS+TiHjFwM3lWMNUhKXVo7oN0cM2pEcuNzjygpwG0N
         zC2JLXdgQdEii9jwUAeOyRgUxAqj62g3h7raBCksbi3LPGkqSX3vzlsasioqRRgXm9i5
         CFYZ0By5rNs1B/MPFZqefiDSoLn1v+a8pYIfqXanwBk+9f0Ff4eXO017wO3U1t1P/+eH
         7geD1a34tzn5fR5kOJQZyiA8ksdj0S3W49L5lZtaqswzgIOb7gFVpFF6TIlmHDZuSSlY
         Av0b7yZDsFI1rdOo3sREPKsWUya6vCf32OX0VG6wAk6fEKVLdNEeBJJPYW2ede+t/aOD
         eKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGj+H+fpRO/LlJr3MV24WDf1h9Fmi9x6UfIbBDjSN90=;
        b=WM9qM5ru8bNC+6rX7wApp0bansc86PxbkOCRhj5P9/+KCxlLBR9afaH9eWg6lpVnjp
         IQuL19xAzs53z/cXNDxJyLysEJoaFYBlf0nSEbQliZFGdTJQXE8Hj/4veOIO4F15qgPh
         /W39HSWt03nWj1qOq9k/Z65stL/mmXNiFbjI5+D4b7Fdnkxx3bNpW7/FokSQqYMsVx+P
         OFhl+DNNPR6avbZ0AQfba+XQPHWgMBffO/GtdAgRIcOO00YULlKc9Qv5rpNTL+ZmGl8J
         m19Gr9GVfuMUNPX5bGFZr3bsaL9U+E7LQ3j0pjElqEISjeGlE12C8RmhA24IJDfNxWbR
         CmKQ==
X-Gm-Message-State: AOAM532Xu7xA94tLtM4vrFmvFkVvK1AacwZN4CsFCG7nqe70BH1YOogi
        BUJ8JMAY25CJyDOPviLwK2WBhQ==
X-Google-Smtp-Source: ABdhPJxfsxvmar0ZLVRQAyA6Vm11jGskO+L1U7Ei7cvzrtTdVvlRU7aetpFzUu8VNL7M/6NFe1vTTw==
X-Received: by 2002:adf:9cca:0:b0:210:2f76:93fe with SMTP id h10-20020adf9cca000000b002102f7693femr55711451wre.12.1655127472493;
        Mon, 13 Jun 2022 06:37:52 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id ay4-20020a5d6f04000000b00219b391c2d2sm10529791wrb.36.2022.06.13.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:37:52 -0700 (PDT)
Date:   Mon, 13 Jun 2022 14:37:48 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, kernel-team@android.com,
        Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Message-ID: <Yqc9rOIlYhywk3HT@google.com>
References: <20220523160536.2889162-1-vdonnefort@google.com>
 <87mteg3flp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mteg3flp.ffs@tglx>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:36:18PM +0200, Thomas Gleixner wrote:
> Vincent,
> 
> On Mon, May 23 2022 at 17:05, Vincent Donnefort wrote:
> > +static int _cpuhp_invoke_callback_range(bool bringup,
> > +					unsigned int cpu,
> > +					struct cpuhp_cpu_state *st,
> > +					enum cpuhp_state target,
> > +					bool nofail)
> >  {
> >  	enum cpuhp_state state;
> > -	int err = 0;
> > +	int ret = 0;
> >  
> >  	while (cpuhp_next_state(bringup, &state, st, target)) {
> > +		int err;
> > +
> >  		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
> > -		if (err)
> > +		if (!err)
> > +			continue;
> > +
> > +		if (nofail) {
> > +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
> > +				cpu, bringup ? "UP" : "DOWN",
> > +				cpuhp_get_step(st->state)->name,
> > +				st->state, err);
> > +			ret = -1;
> 
> I have a hard time to map this to the changelog:
> 
> > those sections. In that case, there's nothing the hotplug machinery can do,
> > so let's just proceed and log the failures.
> 
> That's still returning an error code at the end. Confused.

It is, but after returning from this function, only a warning will be raised
(cpuhp_invoke_callback_range_nofail()) instead of stopping the HP machinery
(cpuhp_invoke_callback_range()). How about this changelog?

  The DYING/STARTING callbacks are not expected to fail. However, as reported by
  Derek, drivers such as tboot are still free to return errors within those
  sections, which halts the hot(un)plug and leaves the CPU in an unrecoverable
  state.
  
  No rollback being possible there, let's only log the failures and proceed
  with the following steps. This restores the hotplug behaviour prior to
  453e41085183 (cpu/hotplug: Add cpuhp_invoke_callback_range())

> 
> Thanks,
> 
>         tglx
