Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB00593F61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348649AbiHOVg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbiHOVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:35:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97BA6C51
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:24:54 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y18so6200789qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc;
        bh=7Lq5uY6NcpMHsM7UKQ9h0OJStqfzG9LSnTMaqGwvJLg=;
        b=UNcd4p8niNhaUE93dbrFIADoy/Kbsml1WPNWq3nwJb4mzICVh6rxmV8GA/5NsZaktI
         pKf3zcH2AO/o1xhoyBNoCm4mEwUa0u1WSL+2bO1oyy7xmXCpL9ozdfSLhZ4bNhR6iWza
         A8GHTyqmzlb7NO6KWQxySjCoY+eYFHbLSf/j4cfLi20T4FneLXSi8+2fwz6BSfV4Shzk
         5sz/t6+4eLMEsfyguZzjNQ14Q3K/JQz4Q0tSCKddsd/SK07enoubpe/uYO8D3iYo5FTJ
         kjZdFiPV7bLuoaTm1xvXztpvbTduS8JTS3VMu88gKdi2v7dcaKwUthvURvd8xLNZ/kPL
         xKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc;
        bh=7Lq5uY6NcpMHsM7UKQ9h0OJStqfzG9LSnTMaqGwvJLg=;
        b=02qEthtDpjMNuqWUP3zcfV89ll5WMMEdN+8X5B0pANiVtJydufRqEt6dtrBtb2FMos
         3OQqLovCYvwxRFVYz1gIEMYcIRbhN336uuDojSWU6cgVN3Bg7A74vMhVThTfte7f//gg
         T+i1NKuvf3qU3gaycU1K89U6PZD3HK7W/sXvGqFgALCqFYrATrWiWvtG84UAniynxGza
         ae3nkns8C/GP6aa2k5GpDLYMNf76tW1NWkbz6SdPeinV9f+4ygN/ouPyAijl1uxx29vw
         quI9p1jWxGfvwc5Gog9TsLYyAjBzZNN+HMJ4WUx737omzmG5toIC1b6zYSXtxTHI6JHq
         88XA==
X-Gm-Message-State: ACgBeo3idAiL/Yq4Di1jyPAsJlSFiJPSM4el6JcE6mJBwLlGlvS6a/VA
        Zkky8rDqV0kAzaz9D7yoXj8=
X-Google-Smtp-Source: AA6agR5UW2sc5l5oTuJUVUZm8ScMn++xPnoAFjuNLF7dmLJMJf+uqdhWzeiR9lA7l00dOooMshXUow==
X-Received: by 2002:a05:622a:2c1:b0:343:550e:d7fb with SMTP id a1-20020a05622a02c100b00343550ed7fbmr15263748qtx.286.1660591493643;
        Mon, 15 Aug 2022 12:24:53 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a2a0400b006ba9b2167a2sm8799525qkp.16.2022.08.15.12.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:24:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id B3C6E27C0054;
        Mon, 15 Aug 2022 15:24:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Aug 2022 15:24:52 -0400
X-ME-Sender: <xms:hJ36YvJ3hUVDO8d7k0ZTxWhmM3AMr3GLV_5QeGAQN6OUkjqqB-ORuQ>
    <xme:hJ36YjKapTpj3fUxlAIs5x0AdHDX1JzUbb23_gYokmqVp32H2K8MzNN3HrEUNAIon
    lJhx7QbY6d5-UdbBg>
X-ME-Received: <xmr:hJ36YnvrgzrTb-iZtUPtVYY8jXUo-5t_2EoQtnUPz1Q3qzIEPsEuAyF5YhH0MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:hJ36YoYxA3RzYCgh87PndL1Ls-sP5Wig41-obc-4T4qO7pwhxPWBdA>
    <xmx:hJ36YmY-plsA565e5cMQmG6ZQxOcVCZ48xNgwhT0BErQS_UWK5WmEg>
    <xmx:hJ36YsDRxtwPRPghIYFUFoAfcc1lrLAo8F90xENGQzygyw2riNP-cA>
    <xmx:hJ36YoDUtOUhhG3u62GIzxC2-QVsQGba5Uqgt6Lz91ufbnVKHl0Lyw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 15:24:51 -0400 (EDT)
Date:   Mon, 15 Aug 2022 12:24:39 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Asahi Linux <asahi@lists.linux.dev>,
        Oliver Neukum <oneukum@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Debugging a TTY race condition on M1 (memory ordering dragons)
Message-ID: <Yvqddx6nTRSZ0JYP@boqun-archlinux>
References: <6c089268-4f2c-9fdf-7bcb-107b611fbc21@marcan.st>
 <20220815134711.GA10374@willie-the-truck>
 <63cd54a8-3c48-d1b9-406a-c521bd02ee4a@marcan.st>
 <YvqKtJn5eBsDJXBI@boqun-archlinux>
 <8ccfdd2d-ef77-4586-e50c-985e1d13726a@marcan.st>
 <YvqXbApYbGGEqQl+@boqun-archlinux>
 <f3f84fc1-50be-0a9b-0538-6ea26dd93b16@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f84fc1-50be-0a9b-0538-6ea26dd93b16@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:15:00AM +0900, Hector Martin wrote:
> On 16/08/2022 03.58, Boqun Feng wrote:
> > I agree this is handy, but an unconditional full barrier may be costy to
> > some users, and probably unnecessary if the users periodically queue
> > the work. In that case, some successful enqueue will eventually make all
> > memory accesses observable. Also if workqueue users use their own
> > locking in work function, then the barrier is also unnecessary.
> > 
> > The document part of course needs some help to clear things up. But I'm
> > not sure "strengthen"ing the ordering guarantee of queue_work() is a
> > good idea. Maybe a dedicated API, like:
> > 
> > // More work is needed for the @work, it has the same semantics as
> > // queue_work() if the @work is not pending. If the @work is pending,
> > // this ensures the work function observes all memory access before
> > // this.
> > void queue_more_work(struct work_struct *work)
> > {
> > 	smp_mb();
> > 	queue_work(work);
> > }
> > 
> > Regards,
> > Boqun
> 
> FWIW, I didn't actually use a full barrier in my patch. I just replaced
> the test_and_set_bit() with the underlying atomic op, sans early exit path.
> 
> Personally though, I think it makes more sense to have the default
> function provide the guarantees, and if someone *really* needs the
> performance gain from eliding the implicit barrier, they could use an
> alternate API for that (after they show useful gains). This stuff is too
> subtle to expect every caller to wrap their head around memory ordering,
> and having queue_work() always provide order with prior stores *feels*
> intuitive.
> 

Fair enough. It's just that when you know something about memory
ordering and atomics, you kinda want to play the game to save as many
barrier as you can ;-) It's a curse of knowledge.

> But let's see what the workqueue folks say :)
> 

Looks like they agree with you ;-) Nice work!

Regards,
Boqun

> - Hector
