Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B48B563BDA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiGAVlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGAVk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:40:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F5742EF0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3V0/ZHeDnwpkrNjAz9hZP6JxPOkXktskzD7IxMyAcKk=; b=RLFm8noq7YFbdJKokSNBcxO/kY
        TH9omDc7Hvbc1D1NXGmbgnsXskL9fmEe4OsLvbYsyHlGMaHa2oFQSplmBVj5vR1sKQqztfoUkUg0R
        OdkqBO6ViL9NdSQZivXNzpuLjIPo9/yDilCvBXSyHm1ay7Lnt1G+Az8OTLqM/CBFZbGWC9DOdpMl3
        rvGqH28jwHKug2m6KHoB422uZbIm85NOeuKTdXzGryNhp7W6lfJXznw3ivHF4DDg/54R0PxpmvXuZ
        j3z8A0J7b4eWe8Yp4rdXwGVSccyFu16MD5AXoKwi6v23UWbDRgXMEU6v9/n+WQX5aoT2Auz3r7evJ
        IKXrNGfQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7ONd-0072zi-Fk; Fri, 01 Jul 2022 21:40:49 +0000
Date:   Fri, 1 Jul 2022 14:40:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules: Fix corruption of /proc/kallsyms
Message-ID: <Yr9p4YOOfJp5evCq@bombadil.infradead.org>
References: <20220701094403.3044-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701094403.3044-1-adrian.hunter@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 12:44:03PM +0300, Adrian Hunter wrote:
> The commit 91fb02f31505 ("module: Move kallsyms support into a separate
> file") changed from using strlcpy() to using strscpy() which created a
> buffer overflow. That happened because:
>  1) an incorrect value was passed as the buffer length
>  2) strscpy() (unlike strlcpy()) may copy beyond the length of the
>     input string when copying word-by-word.
> The assumption was that because it was already known that the strings
> being copied would fit in the space available, it was not necessary
> to correctly set the buffer length.  strscpy() breaks that assumption
> because although it will not touch bytes beyond the given buffer length
> it may write bytes beyond the input string length when writing
> word-by-word.
> 
> The result of the buffer overflow is to corrupt the symbol type
> information that follows. e.g.
> 
>  $ sudo cat -v /proc/kallsyms | grep '\^' | head
>  ffffffffc0615000 ^@ rfcomm_session_get  [rfcomm]
>  ffffffffc061c060 ^@ session_list        [rfcomm]
>  ffffffffc06150d0 ^@ rfcomm_send_frame   [rfcomm]
>  ffffffffc0615130 ^@ rfcomm_make_uih     [rfcomm]
>  ffffffffc07ed58d ^@ bnep_exit   [bnep]
>  ffffffffc07ec000 ^@ bnep_rx_control     [bnep]
>  ffffffffc07ec1a0 ^@ bnep_session        [bnep]
>  ffffffffc07e7000 ^@ input_leds_event    [input_leds]
>  ffffffffc07e9000 ^@ input_leds_handler  [input_leds]
>  ffffffffc07e7010 ^@ input_leds_disconnect       [input_leds]
> 
> Notably, the null bytes (represented above by ^@) can confuse tools.
> 
> Fix by correcting the buffer length.
> 
> Fixes: 91fb02f31505 ("module: Move kallsyms support into a separate file")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Queued up thanks!

  Luis
