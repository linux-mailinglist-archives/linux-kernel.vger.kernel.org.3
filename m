Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A086E54CE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355270AbiFOQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349308AbiFOQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:22:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D276F5BE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2078B82041
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5632AC341C6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655310139;
        bh=x5bYjHYongCPN5AkxGevT43qqAhNw13qjohDvYSEt6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z3pbGo2dHwljZEDOHRG8WK81qcZ1mnMtijE8EiHKzgY2JiK+cIbocxwhWAURBzMiH
         2twYFDz5AvmLcGwJqoB/YtFy7osgDxeiwqCmGi5WqcQX85UgtG52qhfntwO+loIh8B
         xw+wSiizBnER6A55/FguhTi9SqSFd6r/aC1ITuL+XDIVM2pQs93Y4Y772PmUdmRgAB
         PkviaJ3glM/5dQ4ln2gYWSpSHinFUEE9iP47x2UWrmAF5R0nnXULx58vmMbeWKI5A2
         fLpcSPkHBWSMVPGR5tr9D8Y5yt6pzYcV3GusLkDWucuU1brYK74CiJcTh38tW9y5b5
         YVzddt3rFbN2g==
Received: by mail-vk1-f170.google.com with SMTP id x190so5618986vkc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:22:19 -0700 (PDT)
X-Gm-Message-State: AJIora9U7dGSf+EcTZlhQC59qS4L8GFSs1S2Vn5N7H5RhLt4HoCXgoUB
        7GVw0fcg3/x9UWkewJk6n7JyCgDYdFLYHgqljw==
X-Google-Smtp-Source: AGRyM1tvBszql/pKKLxkHsx1E9OjWr2NqUZxeyT4my9ToD0O0iOKD1Vexb6cgqCJUXZ26DU9PLA3+dlWw6nHn6aasRw=
X-Received: by 2002:a1f:73c1:0:b0:35c:cb95:832 with SMTP id
 o184-20020a1f73c1000000b0035ccb950832mr479289vkc.15.1655310138197; Wed, 15
 Jun 2022 09:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220615150325.3969911-1-windhl@126.com> <c69f2023-f518-72cd-9991-c672b40d3767@intel.com>
In-Reply-To: <c69f2023-f518-72cd-9991-c672b40d3767@intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Jun 2022 10:22:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-aJSzd6H5JdVZrTK2PHNbqAam_At8CuJ2NaxBhMns-A@mail.gmail.com>
Message-ID: <CAL_Jsq+-aJSzd6H5JdVZrTK2PHNbqAam_At8CuJ2NaxBhMns-A@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: kernel: Add missing of_node_put() in devicetree.c
To:     Dave Hansen <dave.hansen@intel.com>, Liang He <windhl@126.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 9:33 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/15/22 08:03, Liang He wrote:
> > In dtb_setup_hpet(), of_find_compatible_node() will return a node
> > pointer with refcount incremented. We should use of_node_put() when it
> > is not used anymore.
> >
> > Signed-off-by: Liang He <windhl@126.com>
>
> Seems like:
>
> Fixes: ffb9fc68dff3 ("x86: dtb: Add device tree support for HPET")
>
> and would be appropriate, right?
>
> Also, how was this found, and what is the impact from not fixing it?

No impact if the node is not dynamically removed. That's almost all
cases except IBM pSeries cpu, memory, and pci. Overlays could change
that, but their support in the kernel is limited.

If it really mattered, we'd probably come up with a different way to
do the refcounting as it is hard to get right. In fact, this fix is
not right. Will reply with the right context.

> Was it causing horrible problems in production, or was it just something
> that was found by inspection that's not causing any real problems in
> practice?
