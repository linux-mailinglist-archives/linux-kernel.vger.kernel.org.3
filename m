Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5105B2195
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiIHPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiIHPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:07:47 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA6E7F83
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:07:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7B535580C03;
        Thu,  8 Sep 2022 11:07:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 11:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662649666; x=1662653266; bh=jBH1raHOU+
        zAoGN37kydJN2v9pqHvn8WmSNpPSnMW4c=; b=rIFVjjReo1OGRqliFHle7QCLpq
        q3wRDEDFtl5QjVGT0sAh87+/OlCz3x4E3i8WBWNFEKOOrxHtfNOgMjifOiMeYLo5
        KSAqrnm30tCJIBVRiKV7LbRS0s2Qjh8+Sxp6U+YxSphy4qGRisM0myGtP7QvNRda
        IPy3OOBX4e52KM0qGyzzUJB9Dlad50VE4rxGc4CBvHh7Nu9R1UMCtJ3X2ZMgz79W
        Vg6UMKDdm7hB4eNM5VLaI08kmj/w6qYcFdQlkW3QkK+6n6u9rokEhjckiy0DDu2T
        7oSYrJUl5YUZUmOHaqERa5E2Pgpa8WqYX8mrJ7orliirKP1uP4FjSehfhO/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662649666; x=1662653266; bh=jBH1raHOU+zAoGN37kydJN2v9pqH
        vn8WmSNpPSnMW4c=; b=FNeGymq0w4fqIhVj7Pbf8C63hXMmN8clA1RmFg0R7jgV
        VAM6KWNnM89cO8XbJg+niB7/1cK7sSay4IB1ikeDAwIVQBcNzHj62qAxb/zjj89Z
        kcKBdHnO8wUh0r6Oxys2UddJhJaNl9HiI98nSL/9od91Muat+kkPETrD13URHdCS
        SDliEP0SLUF4Lfar3UFCuEw9He+/kvgY3NzigPoyPAa3iOjagM535BBCPrPd8rYW
        rCQ8HRSv6C+RDXRtJAjm4SeTiDEfBrjd2NXGXNmnUaWB+cMzCpLltjIOkmvomrc9
        Q+2BcOMN4hENXQQ8xhj9mKemgpjgQrtXHEoR8549WQ==
X-ME-Sender: <xms:QAUaY5xIYDmQWxvzwodUbbYWyn_GcmQdyFFABmpa1NZ9jTTGxzVpGg>
    <xme:QAUaY5QuAW83debL8aZWVKxeADtSEcvq0pcve0NaLNIut77fsV32X4SR-Zx5dkkhP
    d0hW_ToAyzJEQfadYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QQUaYzUlKpOnlayN8LwvKL93CvETYdk4kmficl08fYJbguSRYUfxXA>
    <xmx:QQUaY7jhHg7QR4gyJa-V0UkVs_gV5BtSE_JFE0iL6p5XL361GT5lnA>
    <xmx:QQUaY7Av1aP0O8XjOxRs8A7rTgt3wrDbxMKLGNsqhPb5y_zU-toaVw>
    <xmx:QQUaY90MIWSHe9BRRIJaO-e-Hm41zov9DfZ-aubVDj4RgQEihYno_g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C85ADB60083; Thu,  8 Sep 2022 11:07:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <8afc110f-641e-40f0-9bf9-b7b2ca3df6a1@www.fastmail.com>
In-Reply-To: <87v8pyemmw.fsf@mpe.ellerman.id.au>
References: <20190621085822.1527-1-malat@debian.org>
 <7cb1285a-42e6-2b67-664f-7d206bc9fd80@csgroup.eu>
 <87v8pyemmw.fsf@mpe.ellerman.id.au>
Date:   Thu, 08 Sep 2022 17:07:24 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Mathieu Malaterre" <malat@debian.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, "Paul Mackerras" <paulus@samba.org>,
        linux-kernel@vger.kernel.org, "Joel Stanley" <joel@jms.id.au>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] powerpc/lib/xor_vmx: Relax frame size for clang
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022, at 2:27 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>
> Yeah that would make some sense.
>
> On 64-bit the largest frame in that file is 1424, which is below the
> default 2048 byte limit.
>
> So maybe just increase it for 32-bit && KASAN.
>
> What would be nice is if the FRAME_WARN value could be calculated as a
> percentage of the THREAD_SHIFT, but that's not easily doable with the
> way things are structured in Kconfig.
>

Increasing the warning limit slightly for 32-bit with
CONFIG_KASAN_STACK makes sense, but there are a lot of
related concerns:

- I was hoping to still stay under 1280 bytes for the warning
  limit, so that even with KASAN_STACK enabled, we are able to
  catch warnings in functions that use a stupid amount of
  local variables, without getting too many false positives.

- if the XOR code has its frame size explode like this, it's
  probably an indication of the compiler doing something wrong,
  not the kernel code. The result is likely that the "optimized"
  XOR implementation is slower than the default version as a
  result, and the kernel will pick the other one at boot time.
  This needs to be confirmed of course, but an easier workaround
  for this instance might be to just disable the xor_vmx module
  when KASAN_STACK is set.

- The warning limit on 32-bit is actually 2028 bytes when
  GCC_PLUGIN_LATENT_ENTROPY is set. I think this is a mistake
  and we should lower /that/ limit instead, but a side-effect
  here is that an allmodconfig kernel build with gcc will fail
  to warn about bugs that exist both with gcc and clang, while
  clang complains about it.

      Arnd
