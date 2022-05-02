Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BD516B53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383573AbiEBHik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242657AbiEBHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:38:37 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA88114D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:35:08 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 82A3E5C00A8;
        Mon,  2 May 2022 03:35:06 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Mon, 02 May 2022 03:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1651476906; x=1651563306; bh=S2
        nsONwhQYHk2WKWDIyib55Mao5pVha1rrbz562lqmw=; b=oMUJjZC9VFI4Y9ZrrS
        AVqmJhpnsCyVFrdsVUne/zN81T2i++nCMRrEdDARwqM9CFe0yVq584k+kigJxcSA
        doxh2Cof4hoy/Sqt8N3Y6RV5w2t9vruwZfzOJl5fhWmvuMk1P0MdDJtcb54PkZDX
        TIpSP4ErmPBXCUIZAY2ZmH6b295yA90xKb3blwSnz+1cLlWv97hcAcOwD45J54GV
        lqU+nSYhbu8dNcuCSMsOZbNSryy/nQODry8iZ2anLLxOgOFoq9GC7dzAWxLIBXij
        KlUx96XizjSrNjQFCmyD2D6ncEKZm/dcUa2cx3oe53A1ZJSk5g+MlMcAZLpF+1t8
        eVBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651476906; x=
        1651563306; bh=S2nsONwhQYHk2WKWDIyib55Mao5pVha1rrbz562lqmw=; b=S
        M1YGUSmmWpAzX4pJNIGyY14o6WVvnzwZAVEN2FaJiem0WxT6XhivjkMH/h7fHeRs
        l67xjIEGkeSQoNgyvlWQ7Se2My33LVFH7gX0J9U6hYLH05lTEJoAtKwBHBhZC/Su
        1brsjbwOgmMEj+OJmYqeXg68Yne8mT5hNSHhGdyb/U4E1TuCBQprjGya6ZcgJgDv
        bKptHPgcWZ0xcWwBWuuHPnPwbMJlFqzCbpvCK2XgpcQH71OEXIQ2ix5aMtmqW4v8
        zC063gswEadAIcX5gYgUpoPsS/DZzh6Y/kTbTSyHnJ7z4WzARStHnO6HXYUACC6h
        v63YcRIAi7AhvwkKY6Jew==
X-ME-Sender: <xms:qYlvYkNI3FpX87qJEzYVswQN7KzEjnqtZzsrpD26KTTNRP3x71xw1A>
    <xme:qYlvYq8ScZiZVrt5p6MWp-vynjoWpa9dpTa5WjLh_PBrAq-KQYNtt62-M5Sr7QOBp
    PLUGYbUn2-_3kileO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeggdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:qYlvYrSGonH9NsOeZBPC23NXzV_0opuzLRw2AGCkgSKiSTA4Y0N-uw>
    <xmx:qYlvYst-DPIYZsJNrFqYjI21Q6RhtqhhA_4-kanAFTX38ea9_GUoqw>
    <xmx:qYlvYscipHKO3907Ai6w-NmOgH49dT7FS-QWF3Vzzt47xd8dclIEFA>
    <xmx:qolvYk5Pf2GWGcdDAF7M-UsGCZbwuKoiEScXOvpq5ALVfUMFxof8Pg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1C0E0A60063; Mon,  2 May 2022 03:35:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <5291f623-6f0d-4cc0-8358-6aea4e8aa667@www.fastmail.com>
In-Reply-To: <CAK8P3a2Cq5oa8e7SAQ-mOGnytEjnOa4esr1gsfsS3ceH+A2f2g@mail.gmail.com>
References: <202205020811.kEEGO8QC-lkp@intel.com>
 <CAK8P3a2Cq5oa8e7SAQ-mOGnytEjnOa4esr1gsfsS3ceH+A2f2g@mail.gmail.com>
Date:   Mon, 02 May 2022 09:34:44 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>,
        "kernel test robot" <lkp@intel.com>
Cc:     clang-built-linux <llvm@lists.linux.dev>, kbuild-all@lists.01.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Hector Martin" <marcan@marcan.st>
Subject: Re: [asahilinux:asahi-soc/rtkit-sart-nvme 4/6] drivers/soc/apple/sart.c:284:4:
 warning: format specifies type 'unsigned long long' but the argument has type
 'phys_addr_t' (aka 'unsigned int')
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, May 2, 2022, at 08:39, Arnd Bergmann wrote:
> On Mon, May 2, 2022 at 2:21 AM kernel test robot <lkp@intel.com> wrote:
>
>>    277
>>    278                  clear_bit(i, &sart->used_entries);
>>    279                  dev_dbg(sart->dev, "cleared entry %d\n", i);
>>    280                  return 0;
>>    281          }
>>    282
>>    283          dev_warn(sart->dev, "entry [paddr: 0x%llx, size: 0x%zx] not found\n",
>>  > 284                   paddr, size);
>>    285
>
> Hi Sven,
>
> to print a phys_addr_t, you should pass the address by reference and use
> the special "%pap" format string modifier. I'm not entirely sure if it should
> actually be a dma_addr_t instead of a phys_addr_t. If the type gets changed,
> the format string would become "%pad".

I've been using %pa for all other prints in this file since v1 and just
missed this one for some reason. I'm a bit confused why the bots found this last
one only now but I'll fix it as well.


Thanks,

Sven
