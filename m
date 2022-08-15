Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C1B593477
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiHOSEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiHOSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:04:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4862529C86
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:04:52 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a4so6025728qto.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc;
        bh=VzJF6qSAyWf9rymdlhaI5LfjxX1moEAaRt9gerX2rGI=;
        b=FLpeWmbebS7Adq4skhC73mAaHdjLhUXLgMLr54oCGmgio9UJ2thpMFjVWlHX0LGeiF
         rO0KM3p/uo7nkXhyIbjbnd1xgZPGarAoM91eRSf7Eb1P8urtI0Txi1JbOjRT09Up2Jcz
         83iTaYLJe4AXu+0vqetKz4T0pjYix/saY9sGUTugz2n/bxdTh8eABFAhat93DybFyeEU
         0VSNeFK23yU7qM0kP9w6MZLI/UWdrkfTlgdnAwwlamDMHPmQy8QDDwf+GNsrOvr4dXdW
         MclPFn3GqafkVvQPyffoCyYoKI8JJ02zXz8JiXZ0rLW3z5RPTO4YJMTA4WY7SWhl39lE
         Ci1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc;
        bh=VzJF6qSAyWf9rymdlhaI5LfjxX1moEAaRt9gerX2rGI=;
        b=tohmhe+T0I8bfUp4tDeo4BNEgtBCjWSs2186Jxc3BQh6Pddyd9JsRhgPiUjAfcBPPe
         2964iKYdssz3ADkialeFFCLc7xt11INaZ/DgCgKMhgkZUzaHCVpICL9t7CTLmLedLUWx
         MSclGrLPsdyu8wLeCdMAefWW/gbkYE2hkwxK1eWFGgRITAIYfQjeoqXHzKQ9rRG2VSDj
         sCMsf5D0VzVHagGxTTu/61UU78wSFsr3JO2ReB6bAKbnVzEok5Eeie1/uW7APXIgq//P
         xmaiw7BbKPS/j9q532/vFeYlc7w3hPYpXaqsIMrE21rc1un15iHZxqRca7KNHT2Ev6wK
         ocLQ==
X-Gm-Message-State: ACgBeo03lSu+5RTBDtyk2QUWwgpuM9IdVNf5YC15s0s/rQW8LuYBAmSW
        hfnyKrD3VU3Eqx7qpv3IbwM=
X-Google-Smtp-Source: AA6agR6YmuPGdL9sLsrMaudL6leZ3roDFKm1tFhqvUvraFuNqvnWMz7PkL1JKMDcn6LSLrsIb9fgjQ==
X-Received: by 2002:a05:622a:1aa2:b0:344:5ffd:3190 with SMTP id s34-20020a05622a1aa200b003445ffd3190mr4920867qtc.80.1660586691384;
        Mon, 15 Aug 2022 11:04:51 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h5-20020ac846c5000000b003434f45b935sm8655482qto.84.2022.08.15.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:04:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 81F6227C0054;
        Mon, 15 Aug 2022 14:04:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 14:04:50 -0400
X-ME-Sender: <xms:wYr6YgQKxQ0-UQ9056f6iTrbQAd0pQf1Xyz44qelDA8laYS0ZXBJsw>
    <xme:wYr6Ytz3it8y4uaHkqYYlP2xFSXE-4QiTsAkronR2u3zZQZ9ixZf10h_ula2YzKmm
    ghGE075KZGQQUoLjQ>
X-ME-Received: <xmr:wYr6Yt2IC0diKRocU_LR9aJ-WVfEZ1WH2YDASECamHgxioRQJLaHWzZcaru3yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:wYr6YkBAf7Pm_oTSsRwVV2e6Q4xP0L1d-pckKYOt2_Grree8hu6xcA>
    <xmx:wYr6YpifK7hUMR7Ugh4anIVLDAlhgImWBlN92jZ9Quf2CQDYySkWsw>
    <xmx:wYr6Ygog_Awhaln9h9n3nAqDUocOqECtNvRnyIqYeag5Js-8gCS9pA>
    <xmx:wor6YkpJYsdTMMP82hYDtyApZqJACVgswg23mf1Qlh2XF-XDTxDPDg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 14:04:49 -0400 (EDT)
Date:   Mon, 15 Aug 2022 11:04:36 -0700
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
Message-ID: <YvqKtJn5eBsDJXBI@boqun-archlinux>
References: <6c089268-4f2c-9fdf-7bcb-107b611fbc21@marcan.st>
 <20220815134711.GA10374@willie-the-truck>
 <63cd54a8-3c48-d1b9-406a-c521bd02ee4a@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cd54a8-3c48-d1b9-406a-c521bd02ee4a@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:01:17AM +0900, Hector Martin wrote:
> (Resend, because I still can't use mail clients properly it seems...)
> 
> On 15/08/2022 22.47, Will Deacon wrote:
> > As I mentioned in the thread you linked to, the architecture was undergoing
> > review in this area. I should've followed back up, but in the end it was
> > tightened retrospectively to provide the behaviour you wanted. This was
> > achieved by augmenting the barrier-ordered-before relation with:
> > 
> >   * RW1 is a memory write effect W1 and is generated by an atomic instruction
> >     with both Acquire and Release semantics.
> > 
> > You can see this in the latest Arm ARM.
> > 
> > However, test_and_set_bit() is unordered on failure (i.e. when the bit is
> > unchanged) and uses READ_ONCE() as a quick check before the RmW. See the
> > "ORDERING" section of Documentation/atomic_bitops.txt.
> 
> Argh, I'd completely missed that early exit (and had stumbled on an
> unofficial doc that said it was always ordered, which confused me).
> Indeed, getting rid of the early exit it fixes the problem.
> 
> > I think you're missing the "shortcut" in test_and_set_bit():
> > 
> >         if (READ_ONCE(*p) & mask)
> >                 return 1;
> > 
> >         old = arch_atomic_long_fetch_or(mask, (atomic_long_t *)p);
> > 
> > so if the bit is already set (which I think is the 'ret == false' case)
> > then you've only got a control dependency here and we elide writing to
> > B.
> 
> Completely missed it. Ouch.
> 
> > 
> >>
> >> CPU#2:
> >>   DMB ISHST
> >>   STR B
> > 
> > Missing DMB ISH here from the smp_mb()?
> 
> Yup, my apologies, that was a brain fart while writing the email. I did
> have it in the litmus tests (and they indeed completely fail without it).
> 
> > If that non-atomic store is hitting the same variable, then it cannot land
> > in the middle of the atomic RmW. The architecture says:
> > 
> >  | The atomic instructions perform atomic read and write operations on a memory
> >  | location such that the architecture guarantees that no modification of that
> >  | memory location by another observer can occur between the read and the write
> >  | defined by that instruction.
> > 
> > and the .cat file used by herd has a separate constraint for this (see the
> > "empty rmw & (fre; coe) as atomic" line).
> 
> Ha, I was using G.a from Jan 2021 (back when I started working on this
> M1 stuff), and it looks like that wording was added as an issue after
> that (D17572) :-)
> 
> > There's never anything obvious when you're working with this sort of stuff,
> > but my suggestion is that we work towards a litmus tests that we both agree
> > represents the code and then take it from there. At the moment there's an
> > awful lof of information, but you can see from my comments that I'm not
> > up to speed with you yet!
> 
> I think you nailed it with the early exit, I'd completely missed that. I
> think I can fairly confidently say that's the issue now. As for the
> litmus test, indeed with the revised definitions of the memory model /
> ARM my concerns no longer apply, hence why I couldn't reproduce them
> (and the hardware, thankfully, seems to agree here).
> 
> Workqueues are broken. Yay! I'll send a patch.
> 

Hmm.. but doesn't your (and Will's) finding actually show why
queue_work() only guarantee ordering if queuing succeeds? In other
words, if you want extra ordering, use smp_mb() before queue_work()
like:

	smp_mb();	// pairs with smp_mb() in set_work_pool_and_clear_pending()
	queue_work();	// if queue_work() return false, it means the work
			// is pending, and someone will eventually clear
		      	// the pending bit, with the smp_mb() above it's
			// guaranteed that work function will see the
			// memory accesses above.

Of course, I shall defer this to workqueue folks. Just saying that it
may not be broken. We have a few similar guarantees, for example,
wake_up_process() only provides ordering if it really wakes up a
process.

Regards,
Boqun

> - Hector
