Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872D854419D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiFICs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFICs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:48:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB48DDDA;
        Wed,  8 Jun 2022 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+1xJAFxrAQpdyFEBOBVg3nYgcbnbFBfxBPaYH1o92/Y=; b=nfe19vEVxrOgRQW2gYcyrPUoBF
        kwHbDGgnkElQiVJu3sfNxKPGq7Y4pi1IsDKY3/QGS/m5WXab64Sn+xbv5GkpUaVTcIusrUz7n89YF
        +ShbX2VjgfPCUwdBOXDmB77iBmjgLY36+64JXdvQC48pVnLwnGQZPkdwkz1VMgtYeEopbO6RnbPT0
        uXgss4TtN3rmn83tPcD9QtYNHXKYEmSIG918rbhuN1MsFt3a0zhGuo6JHjk/loYwtBOsycdNfonwC
        ztKZqbuiqjVElU1/GpmL5Hak2xfYSIgezfgz6yb7C3Ue7xsPG9ub/ZG2c/VfBOY29Z9O/WhIZAoxr
        LpQ6X4Dg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz8E3-00DBvk-N4; Thu, 09 Jun 2022 02:48:48 +0000
Message-ID: <6d6d252d-79e9-4b4c-4a62-aa4018a6254c@infradead.org>
Date:   Wed, 8 Jun 2022 19:48:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] kconfig: Add findconf script and helper program
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608095456.27479-1-zev@bewilderbeest.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220608095456.27479-1-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/8/22 02:54, Zev Weiss wrote:
> scripts/findconf provides menuconfig's search functionality as a
> standalone, non-interactive command, somewhat in the spirit of
> scripts/config.  It is meant to be useful for tasks like getting a
> quick overview of symbol dependencies or determining which Kconfig
> file to edit for a given symbol, without having to fire up one of the
> interactive config programs.
> 
> It accepts a single command-line flag, '-v', which causes it to also
> print the help text of each matching result.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---

I can see how this could be useful.
It's a little easier to use than what I currently do:

$ findconfig  DRM_HISI_HIBMC
./drivers/gpu/drm/hisilicon/hibmc/Kconfig:2:config DRM_HISI_HIBMC

then $EDITOR that_Kconfig_file


In testing, I am seeing this:

#
# using defaults found in /boot/config-5.3.18-150300.59.63-default
#
.config:421:warning: symbol value 'm' invalid for I8K
.config:2335:warning: symbol value 'm' invalid for MTD_NAND_ECC_SW_HAMMING
.config:2484:warning: symbol value 'm' invalid for PVPANIC
.config:8671:warning: symbol value 'm' invalid for INTERCONNECT
.config:9369:warning: symbol value 'm' invalid for CRYPTO_ARCH_HAVE_LIB_BLAKE2S
.config:9370:warning: symbol value 'm' invalid for CRYPTO_LIB_BLAKE2S_GENERIC
.config:9653:warning: symbol value '1' invalid for KASAN_STACK

How do I specify/choose a .config file to be used?

Oh, use KCONFIG_CONFIG=filename


Please update (add) usage/help text in scripts/kconfig/Makefile.

> 
> This works a bit differently from [gmnq]conf in that it accepts (and
> requires) arguments, but I couldn't see an easy/obvious way of passing
> command-line args through the makefile infrastructure that invokes
> those, so the wrapper script passes things to it via environment
> variables instead.  Suggestions welcome if there's a nicer way of
> achieving that.
> 
>  scripts/findconf           | 22 ++++++++++++
>  scripts/kconfig/.gitignore |  1 +
>  scripts/kconfig/Makefile   |  7 +++-
>  scripts/kconfig/findconf.c | 74 ++++++++++++++++++++++++++++++++++++++
>  scripts/kconfig/lkc.h      |  1 +
>  scripts/kconfig/menu.c     |  2 +-
>  6 files changed, 105 insertions(+), 2 deletions(-)
>  create mode 100755 scripts/findconf
>  create mode 100644 scripts/kconfig/findconf.c
> 

thanks.
-- 
~Randy
