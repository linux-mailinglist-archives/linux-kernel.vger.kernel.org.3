Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3504EA7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiC2GGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiC2GGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91D340EE;
        Mon, 28 Mar 2022 23:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62FB5614D5;
        Tue, 29 Mar 2022 06:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C6EC2BBE4;
        Tue, 29 Mar 2022 06:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648533877;
        bh=Zw3Xh8fbjP2zftckUoT1RTXypyNAxf9E8jIl4L/E890=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bR6w+YPdci2xa0YLOpiFgipiMjVXbqn86z1XDK+vDffw4Hal1PzNq8Crl5CWMc9P5
         cfuXBE5d/njExkuFrM5ghQLI7abxOc73yf00Wrd/759k67OsjxwTYKIryWTTXIfYuC
         TRpkw/2UDUqFQ2wOSZznKTavOR8OqHDyarD/uq8A=
Date:   Tue, 29 Mar 2022 08:04:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] kbuild: forbid exported headers from including
 <stdint.h>, <stdbool.h>
Message-ID: <YkKhc2BbkmdVwKex@kroah.com>
References: <20220328172130.197319-1-masahiroy@kernel.org>
 <20220328172130.197319-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328172130.197319-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 02:21:30AM +0900, Masahiro Yamada wrote:
> Some UAPI headers included <stdlib.h>, like this:
> 
>   #ifndef __KERNEL__
>   #include <stdlib.h>
>   #endif
> 
> As it turned out, they just included it for no good reason.
> 
> After some fixes, now I can compile-test UAPI headers
> (CONFIG_UAPI_HEADER_TEST=y) without <stdlib.h> included.
> 
> To avoid somebody getting it back again, this commit adds the dummy
> header, usr/dummy-include/stdlib.h
> 
> I added $(srctree)/usr/dummy-include to the header search paths.
> Because it is searched before the system directories, if someone
> tries to include <stdlib.h>, they will see the error message.
> 
> While I am here, I also replaced $(objtree)/usr/include with $(obj), but
> it is just a small refactoring.
> 
> If we achieve the situation where none of system headers is included
> from exported kernel headers (i.e. kernel headers become self-contained),
> we might be able to add -nostdinc, but that is much far from where we
> stand now. (see many no-header-test lines in usr/include/Makefile)
> 
> As a realistic solution, you can forbid header inclusion individually by
> putting a dummy header into usr/dummy-include/.
> 
> Currently, no header include <stdbool.h>. I put it as well before somebody
> attempts to use it.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Nice work!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
