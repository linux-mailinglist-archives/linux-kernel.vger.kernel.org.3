Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8094DE65D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 06:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbiCSF6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 01:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiCSF6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 01:58:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8B23D5A0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 22:57:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CB8C23200C10;
        Sat, 19 Mar 2022 01:57:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 19 Mar 2022 01:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NJi090B/iJwFRyHkW
        21F4iSKRotQmY7UBQ+B5JO82Hg=; b=iLHUNTjLf3gxaY8SDVFZp64lKD9M0vTI+
        aOUR8C1Q3EBTLKNFNLg57LoPU9RvLe7wUrrNRGOUNyo9yZ9oszEK3CcZSBFvBbzI
        of52s8xFXC11S5WkuiNSaPR1/Hu8quxOWaCNyri7JRgSxVcVlkzGAHgGkPKZU/3j
        7BD/9BnMKcHtvGxxocfz+gZ98s6jhZOZNCeug+EiFwYgZXlb6k+KtN8xQM0x8DiE
        T00OIa2rKRNVkXiPyM1AHdKwE2OQqt0qKJPZRhS4IQnoSBQhkI9n3iqQwbjWytsM
        95PnZD1wCwgwbmYJq+/kJZ3v7WonGM5UGnUf67fyeLYkH4zImEXGA==
X-ME-Sender: <xms:vXA1YuEPgbrzKQVI3YdtYMR6Crb6PHmsKMxO01RcjWQRIsXXJajfSw>
    <xme:vXA1YvUEmmZz69BHh0yxXkbbdwGG8hkqSzo9TkXYATeIZe8l8exByk0phRjw3LtvR
    -JKa-qO9fr_tNQuKlo>
X-ME-Received: <xmr:vXA1YoKSRA8Ne2vMiJKv33Ij_jkiRP4Tiv97g4zGAhT5zmTDzW1M_skq-UhL_bOKlbVutlJ7iQKtLGp7iDOaMPsQ8kgCBw7xnqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:vXA1YoGZjiyLinWcH-f-Cmg8bAUvSqvz_1jEj2DZXOZs89odLLDPHg>
    <xmx:vXA1YkUG0bM81Z8Q0RkORW4E8Jk04A8RNLmzA7IpkpjWOrbhKQf0pQ>
    <xmx:vXA1YrNFJHqO-80AJBrum6-jdnjYko71zncTpz6pOjqc4Zg427vwsw>
    <xmx:vnA1YrSOfmuXY6MFm0MSchBT2z74aCxfrUY8jKPW4y0h_XaGVGuy2Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Mar 2022 01:57:16 -0400 (EDT)
Date:   Sat, 19 Mar 2022 16:57:23 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh/via-pmu: Fix build failure when CONFIG_INPUT
 is disabled
In-Reply-To: <f5cebabc-18f9-7e64-ac34-2c7802104aa1@infradead.org>
Message-ID: <25cb7e6c-5239-e84d-e73d-848a66a214f@linux-m68k.org>
References: <cb1828050f8c9ef801b2bdf79eccd6c52afed26b.1647663509.git.fthain@linux-m68k.org> <f5cebabc-18f9-7e64-ac34-2c7802104aa1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022, Randy Dunlap wrote:

> 
> Hi Finn,
> It builds without those reported errors, but I do see these warnings
> since the robot-supplied .config file has:
> # CONFIG_PROC_FS is not set
> 
> 
>   CC      drivers/macintosh/via-pmu.o
> ../drivers/macintosh/via-pmu.c:897:12: warning: 'pmu_battery_proc_show' defined but not used [-Wunused-function]
>   897 | static int pmu_battery_proc_show(struct seq_file *m, void *v)
>       |            ^~~~~~~~~~~~~~~~~~~~~
> ../drivers/macintosh/via-pmu.c:871:12: warning: 'pmu_irqstats_proc_show' defined but not used [-Wunused-function]
>   871 | static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> ../drivers/macintosh/via-pmu.c:860:12: warning: 'pmu_info_proc_show' defined but not used [-Wunused-function]
>   860 | static int pmu_info_proc_show(struct seq_file *m, void *v)
>       |            ^~~~~~~~~~~~~~~~~~
> 

I see. I'll send a separate patch for this issue.
