Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E723552EFC8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351202AbiETPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351181AbiETPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FF6179C03
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 369AA61DFE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2DCC385A9;
        Fri, 20 May 2022 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653062142;
        bh=y9dpjav6sCxityEiLHu4znk3I6mt/w3EcVr5TOkLl4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUn13IFYqIQZrsqcfmmrUty0l1WNYH4LdMIbm8VHBOAAP7OuvyO+zQy0aWwOCi9lZ
         QhMgN8xDdIcFz21cNVhLqZST1w78QABA6BCuNN/OcAmrURLaLuqEnOSAmVrU55DMS/
         164DvQ99TmKoHz6uZD9qzUXfsWOXp6Lig4pPAbZEO4s2DUFbnquhy1ZxryFV6rjjHG
         K4zW8T/91v6Iyy06oCHdTyaBkA6JwA4FbLas2tUIY6q36fewjMvu9l8SRyVsK7TQVd
         Y87DdaM4wsUs3Y+kI83G/dspOWaZ9rPhT1yVsVs5W00xt4Fqc+pV03K4cspUj9edyH
         LfEl6agC/I7tA==
Date:   Fri, 20 May 2022 08:55:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Richard Weinberger <richard@nod.at>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eduard-Gabriel Munteanu <maxdamage@aladin.ro>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
Message-ID: <Yoe5/HwL9DXhaw7Z@dev-arch.thelio-3990X>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
 <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
 <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
 <YlRp9KR1mp3/4Txo@thelio-3990X>
 <1287561645.244713.1649702724736.JavaMail.zimbra@nod.at>
 <e9597cbc-cabb-facf-deb6-662d40cf16a3@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9597cbc-cabb-facf-deb6-662d40cf16a3@leemhuis.info>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 08:08:01AM +0200, Thorsten Leemhuis wrote:
> On 11.04.22 20:45, Richard Weinberger wrote:
> > ----- Ursprüngliche Mail -----
> >> Von: "Nathan Chancellor" <nathan@kernel.org>
> >> I attempted to print out the error code but it seems like there is no
> >> output in the console after "reboot: System halted". If I add an
> >> unconditional print right before the call to os_set_fd_block(), I see it
> >> during start up but I do not see it during shutdown. Is there some way
> >> to see that console output during shutdown?
> > 
> > I think in this case the easiest way is attaching gdb with a breakpoint.
> 
> I noticed this in my list of open regressions. It seems there wasn't any
> progress to get this regression fixed (please let me know in case I
> missed something), but I guess nobody considered it urgent which is
> likely not that much of a problem in this case.

Yes, sorry, I tried to get gdb to reveal something but I couldn't get it
to work then I had to move onto other work. We have worked around this
for the time being but it would still be nice to figure out what is
going on here; I am just not sure when I am going to have time to
participate in that process.

Cheers,
Nathan
