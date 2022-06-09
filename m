Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23416544217
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiFIDqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFIDqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:46:40 -0400
X-Greylist: delayed 64284 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 20:46:39 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136C12E4342;
        Wed,  8 Jun 2022 20:46:38 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-189-245.tukw.qwest.net [174.21.189.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id AB106344;
        Wed,  8 Jun 2022 20:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1654746398;
        bh=P4Tb/8aOs+KwvhOVY6Wu9k5ijZ6jU9WWvWxF6LngbPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/3CWLUCXEEzHl6OzLto+Nh1NH1v28uCaQ5m8nHcIQ2BjUbtlbTE7i6yfOn4vJGXQ
         8LI5HyEXGmv3HkBDTYHcR74M6c/a8r8/UnX43LmVsOXYF3SQi0T8MaLhRNwL2DGA8v
         LtbMUZHyc9ETzNbtnkxY27JeGL+FdttcP5SiA3H0=
Date:   Wed, 8 Jun 2022 20:46:37 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: Add findconf script and helper program
Message-ID: <YqFtHfC59akYP9jB@hatter.bewilderbeest.net>
References: <20220608095456.27479-1-zev@bewilderbeest.net>
 <6d6d252d-79e9-4b4c-4a62-aa4018a6254c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6d6d252d-79e9-4b4c-4a62-aa4018a6254c@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 07:48:44PM PDT, Randy Dunlap wrote:
>Hi--
>
>On 6/8/22 02:54, Zev Weiss wrote:
>> scripts/findconf provides menuconfig's search functionality as a
>> standalone, non-interactive command, somewhat in the spirit of
>> scripts/config.  It is meant to be useful for tasks like getting a
>> quick overview of symbol dependencies or determining which Kconfig
>> file to edit for a given symbol, without having to fire up one of the
>> interactive config programs.
>>
>> It accepts a single command-line flag, '-v', which causes it to also
>> print the help text of each matching result.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>
>I can see how this could be useful.
>It's a little easier to use than what I currently do:
>
>$ findconfig  DRM_HISI_HIBMC
>./drivers/gpu/drm/hisilicon/hibmc/Kconfig:2:config DRM_HISI_HIBMC

I'm guessing 'findconfig' here is some personal shell 
alias/function/script?  (I can't see any references to it in the kernel 
source tree.)

>
>then $EDITOR that_Kconfig_file
>
>
>In testing, I am seeing this:
>
>#
># using defaults found in /boot/config-5.3.18-150300.59.63-default
>#
>.config:421:warning: symbol value 'm' invalid for I8K
>.config:2335:warning: symbol value 'm' invalid for MTD_NAND_ECC_SW_HAMMING
>.config:2484:warning: symbol value 'm' invalid for PVPANIC
>.config:8671:warning: symbol value 'm' invalid for INTERCONNECT
>.config:9369:warning: symbol value 'm' invalid for CRYPTO_ARCH_HAVE_LIB_BLAKE2S
>.config:9370:warning: symbol value 'm' invalid for CRYPTO_LIB_BLAKE2S_GENERIC
>.config:9653:warning: symbol value '1' invalid for KASAN_STACK
>

This I assume is just due to the contents of your .config file relative 
to the current Kconfig definitions and not a problem with anything in 
this patch?

>How do I specify/choose a .config file to be used?
>
>Oh, use KCONFIG_CONFIG=filename
>

Ah, I guess that'd be a nice thing to add a flag for to the wrapper 
script -- I'll include that in v2.

>
>Please update (add) usage/help text in scripts/kconfig/Makefile.
>

Ack, will do.


Thanks for the review!


Zev

