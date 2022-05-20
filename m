Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAB52F3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353257AbiETTcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353236AbiETTcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:32:07 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA70195792;
        Fri, 20 May 2022 12:32:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E1A455C017C;
        Fri, 20 May 2022 15:32:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 20 May 2022 15:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653075125; x=1653161525; bh=cqQSed8XRQ
        7quGXTmZG7RLWpQtZBLF7WVLzBsujlnyM=; b=JqpGUZk+G/Wyj6ALN1hhl1O34f
        eY2tYK22JEuiz2W8GJroTKWb3sqJy9vMYsknrOmG5xk4AIonNKjbs+vGpwiYKM0Q
        QSLkdpk/zp7hXdG69qGeCicfg3DQG1Zi+J3X9crmAZhdw8yj+p+Rho9dJdxMyzd9
        BDDzjDiUQ9EbrOgV8GwJuPNVdJc95MhnKqAC9/erdswx2DPYbzr6YToQk8OLGvxW
        ZZf6OD0F0iRoWGc/zqLwJrC4U7hxnkGddcmT53WhbTsTZChnMt1j1OhjFPDgJk1A
        /Mlq1YeYTnrk6DWfvmx4wu8zy59+HQkUU3jxJDp1CXfi6DrW8G5osVNdaFLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653075125; x=1653161525; bh=cqQSed8XRQ7quGXTmZG7RLWpQtZB
        LF7WVLzBsujlnyM=; b=sExieXHlgyXUBfalogiNEhrWSmHaHLoPpgSbkLE8fkk4
        zrMgxY8NZjNZhSspKwhkstQFeaF2R2sF1R6J4XF9cRK7Q1yHMBUWZzVRg8akIWgE
        IB6qwJG5uuXqm9Zh7AYsQliXPCZk9lUN4MOzyQ1LmnIuIXLLlFYK49AFO0tcsy0Q
        dGH6TwgT20trzfpxPFAsZa0i9Pd8Wuj+clZMpAe+7snOlLzV7eWJyBissBFrkJMM
        OtplYyskmlcbT8FQxQsLBm/N8reHL0LXfNv54jU7AUtcjzCwMjFWefB2CONWnGrZ
        IQzVLmdo/9GORt/IG9qzS9i15FEghGMT+IZJIfxhKA==
X-ME-Sender: <xms:teyHYlWeMVZHQYPdgbNHT68DLg13AJqZPkM0ReYiMb-sbVlMVWzSzw>
    <xme:teyHYlnksjvrHHkIDJzlHxqqaqcDgEF4rCOpk9x-UUqZQSE36n-PgEgmV8gFzpf5K
    1P7QV4U9L-V5w>
X-ME-Received: <xmr:teyHYhaIv8tefRzOlsYDxZOQdWzIoKbmmBbJZNoTMcJ1h6uKe6XrgD7khJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrieefgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:teyHYoUh_KE7MOwh7dcQX7BN18O79NZhIdhDzzvhoYKjLSnBJQ08og>
    <xmx:teyHYvmHV_f1oLdbPpaJu9UlMy6c1XHLmSC1dbkBdkmH-jK0yviKDQ>
    <xmx:teyHYlc34bxJvJeeL1NpKqng4_UmrXMnP76ovzRGdjkhsUbqXHxmUg>
    <xmx:teyHYh6iWFzbR7F2AyPZMyoz91UttD47fr8senPQKbCLFWMWZBeCRw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 May 2022 15:32:04 -0400 (EDT)
Date:   Fri, 20 May 2022 21:21:29 +0200
From:   Greg KH <greg@kroah.com>
To:     Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org
Subject: Re: [PATCH] siphash: add SPDX tags as sole licensing authority
Message-ID: <YofqOfHNKKRoTds5@kroah.com>
References: <20220518132345.40615-1-Jason@zx2c4.com>
 <87v8u0i0vq.ffs@tglx>
 <CAG_66ZSHrHpXu7mJ_-67QgdL2Ubrxg2BAtn3n3YECdHYDHtSDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_66ZSHrHpXu7mJ_-67QgdL2Ubrxg2BAtn3n3YECdHYDHtSDg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:53:50PM -0500, Kate Stewart wrote:
> Thanks for this bit of cleanup Jason!   Much appreciated.
> 
> On Fri, May 20, 2022 at 12:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Wed, May 18 2022 at 15:23, Jason A. Donenfeld wrote:
> > > The text "dual BSD/GPLv2 license" is somewhat ambiguous, and moving this
> > > over to SPDX is overdue. This commit adds SPDX tags to the relevant
> > > files and clarifies that it's GPLv2 only and 3-clause BSD. It also
> > > removes the old text, so that the SPDX tags are the only source of the
> > > information.
> > >
> > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>

Thanks all, I queued this up before the additional review comments, next
time I'll be slower :)

greg k-h
