Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1AC4E9DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbiC1RlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbiC1RlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:41:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2259136313;
        Mon, 28 Mar 2022 10:39:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bx5so14862802pjb.3;
        Mon, 28 Mar 2022 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kqHiuoHywsuyhvMhsQ3JRIWwYjdiUZitcBz1mGi8Kbs=;
        b=kvllLJWJ27fAkznbiPNkwEzkxSSAy4K+jjy7J6fYw9SdyjSqOaXYsDmnpgzSHe75Fy
         KaLSSDiVyOzwiAs92TDRouJc8uq8mXRUHQXoRxzU2I4pemrWpdm0nykMPWlDd0G7tdUd
         zAP3mfd7O9PQhTOqWKIsaSscZrDCS88j3Y6Vc/ovPWV5yzH3gNt5TFe0HmwkfOqElui/
         H5wiavr+CPjN3MFGC/c6Q4nmtfpstxVFEAOuNdJpPG72+u6A7tlG9v94CBjrTOpt8sEP
         e/z7ksLqqvJs4N27aXSp9bn3OrlSTznpAKC0jVoBgKwzPlQsHqkGkBXZUlqCEm6kDjtP
         ib4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kqHiuoHywsuyhvMhsQ3JRIWwYjdiUZitcBz1mGi8Kbs=;
        b=2bpXDwkCfRkDv/AkvssqLSfYyDaZON8qPX6j2iugPWREtU0330pfhsIDP5f/fYIC3f
         807G2WFSRmyThwoQcIzYEWaItTtdQdi/0cOkc4gZyiJgQR3ZOIbBvQ5tTfuaADNXO7nw
         s1zdcyIiwYLm63Xd2vZtnwM6vGgg61lDIW/V67OKcgDheO9q1gnr/5ei9AGKHGECCZTX
         d8IEW9M7RvKOpP2ZSiSA3nug/gkjkODCbs3Sc/aGod0IxnipLW9F5RYdcoYxzo1DEMQm
         fKrEjz+nQtaGs9+1N/IRyOOQtH8G0LMynZmW/h2h7mzRQJQsfs6bntaCbrggP31DFHQm
         EcVw==
X-Gm-Message-State: AOAM532n3pBYBdvAN7Ew5VVorqx3goQNWZc404bD2CiWl0Jh4UCmFVS5
        +oPVFKpyMXk13GZ1TP83Q8g=
X-Google-Smtp-Source: ABdhPJz5bfufFF/WNY87Wreel+U6APHskPQBN1aTt0JKA3aqZh0ZOH7w62yT+XAy5Zj+z+kMU6/jbw==
X-Received: by 2002:a17:90b:4a4a:b0:1c7:82e9:1014 with SMTP id lb10-20020a17090b4a4a00b001c782e91014mr309126pjb.0.1648489167501;
        Mon, 28 Mar 2022 10:39:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3b11])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090a3d4500b001c97528521asm134001pjf.6.2022.03.28.10.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 10:39:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Mar 2022 07:39:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Hurley <peter@hurleysoftware.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Esben Haabendal <esben@geanix.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?iso-8859-1?Q?Andr=E9?= Pribil <a.pribil@beck-ipc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Message-ID: <YkHyzcfiyjLfIVOo@slm.duckdns.org>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
 <YkGIhYKJG+w4L7ge@linutronix.de>
 <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 28, 2022 at 12:09:27PM +0200, Marc Kleine-Budde wrote:
> > Having a kthread per "low-latency" tty instance is something I would
> > prefer. The kwork corner is an anonymous worker instance and probably
> > does more harm than good. Especially if it is a knob for everyone which
> > is used for the wrong reasons and manages to be harmful in the end.
> > With a special kthread for a particular tty, the thread can be assigned
> > with the desired priority within the system and ttyS1 can be
> > distinguished from ttyS0 (and so on). This turned out to be useful in a
> > few setups over the years.
> 
> +1
> 
> The networking subsystem has gone the same/similar way with NAPI. NAPI
> handling can be switched from the softirq to kernel thread on a per
> interface basis.

I wonder whether it'd be useful to provide a set of wrappers which can make
switching between workqueue and kworker easy. Semantics-wise, they're
already mostly aligned and it shouldn't be too difficult to e.g. make an
unbounded workqueue be backed by a dedicated kthread_worker instead of
shared pool depending on a flag, or even allow switching dynamically.

Thanks.

-- 
tejun
