Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771B05865EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiHAH4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiHAH4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:56:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4063C3
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 00:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FF18B80EB6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339F0C433C1;
        Mon,  1 Aug 2022 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659340562;
        bh=x3Fg/Rbx8Ng7EwGIUGb7gYjJKq38W2VLLAiBUTzBwUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHyqkREMjXZIALfQgy1Cu/GsXenY3wYf/Xd1OB/ULWO1vihVUAOjYJFOaB/WF1FgR
         RRwKpChPwxguNRW8WaqI3SZt1oIfWI11BOkBb//PHn30D3i81qpyB9fjst8p42BNcG
         cHSZ3bKZ/+QmRE3ZeXIZqkGPZAnAcb7zSRJIeFCVou519sO+IVI6xxk78aBLErFUba
         8rmz4SG8igePx24OQgcQe7YSXMF9PDZUg+q5MhuMkIRqIZh/fVSGbR393/shz85pTM
         2d/rtw7iXNLlA09em4VH46l2yWlPxXmjRDwcx30bldkSm7A2D8NzZ7HYf+PPPv/NQm
         In9HFGRtVt2RQ==
Received: by pali.im (Postfix)
        id 14C3D75F; Mon,  1 Aug 2022 09:55:59 +0200 (CEST)
Date:   Mon, 1 Aug 2022 09:55:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/85xx: P2020: Add law_trgt_if property to PCIe DT
 nodes
Message-ID: <20220801075558.jdkaegjjzexhe7kl@pali>
References: <20220504180822.29782-1-pali@kernel.org>
 <165909977761.253830.2305727219055135050.b4-ty@ellerman.id.au>
 <CAL_JsqJZ6s4qU+Yt4CCj3q-Fk_MKEddx5aLKu15NLnTbgMyRGA@mail.gmail.com>
 <87k07sbpl3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k07sbpl3.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 August 2022 13:38:32 Michael Ellerman wrote:
> Rob Herring <robh+dt@kernel.org> writes:
> > On Fri, Jul 29, 2022 at 7:17 AM Michael Ellerman
> > <patch-notifications@ellerman.id.au> wrote:
> >>
> >> On Wed, 4 May 2022 20:08:22 +0200, Pali Rohár wrote:
> >> > DT law_trgt_if property defines Local Access Window Target Interface.
> >> >
> >> > Local Access Window Target Interface is used for identifying individual
> >> > peripheral and mapping its memory to CPU. Interface id is defined by
> >> > hardware itself.
> >> >
> >> > U-Boot uses law_trgt_if DT property in PCIe nodes for configuring memory
> >> > mapping of individual PCIe controllers.
> >> >
> >> > [...]
> >>
> >> Applied to powerpc/next.
> >>
> >> [1/1] powerpc/85xx: P2020: Add law_trgt_if property to PCIe DT nodes
> >>       https://git.kernel.org/powerpc/c/1f00b5ab992c122c51bc37662b3b4df5963462f3
> >
> > Why? Minimally, it needs a vendor prefix and s/_/-/ as I commented.
> 
> OK. I misread your "maybe that's fine" as approval.
> 
> Pali can you send a fixup patch please?
> 
> cheers

No I cannot. This is how this property is used by bootloaders for at
least 10 years. There are underlines (not hyphens) and there is no
vendor prefix.
