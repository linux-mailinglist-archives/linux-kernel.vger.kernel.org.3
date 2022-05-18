Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FDE52C06F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiERQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiERQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:18:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13DF1E012E;
        Wed, 18 May 2022 09:18:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B3E261601;
        Wed, 18 May 2022 16:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE79C385A5;
        Wed, 18 May 2022 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652890701;
        bh=RgRhuYRHhC4Q30XicZretiBGKHcP4GLPcS0/38yDF4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgM0jXwMbLaK4x+YPbr0pbj5EojPWi1+S2LlU/vfvUuik/zWaJBLGYA1+b2oELSi1
         jzB39mz9eo7kAjeEbUvLw/VTPbUbSmlHcx0TmNWDYP2wpGC5Ubram57aDFCTsZ9J7y
         3oizkHq4Borhvtz258e04Wwum4eRwR5hKCjFKEhvIGYemLqYAaYwb0hfCmX1aOR6FV
         iGNQ9ESQ24vl/UkjP7V6ML7UjQAMra5+/EZuMBSTyY8l52d5on3ZvNC7R4r2PBues4
         8KpmoohBgpRSmhNAGH3CcAS95UqDOycF4PQVQHLN7/vWzIBUCUJ2UxHc/MEq9EB+F6
         gJFqa1atrjUiw==
Date:   Wed, 18 May 2022 09:18:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: silence clang's -Wunaligned-access
 warning
Message-ID: <YoUcS2WMkyJYMHfG@dev-arch.thelio-3990X>
References: <20220518070517.q53bjzo6lbnq3f2i@pengutronix.de>
 <20220518114357.55452-1-mailhol.vincent@wanadoo.fr>
 <YoUZLHIbxPu15/lN@dev-arch.thelio-3990X>
 <CAMZ6RqL2eKd-uqP-2vnt99_0RRE-8x7hxwYy6x1b0Oqes-HGgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqL2eKd-uqP-2vnt99_0RRE-8x7hxwYy6x1b0Oqes-HGgA@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:15:04AM +0900, Vincent MAILHOL wrote:
> On Tue. 19 May 2022 at 01:08, Nathan Chancellor <nathan@kernel.org> wrote:
> > Hi Vincent,
> >
> > On Wed, May 18, 2022 at 08:43:57PM +0900, Vincent Mailhol wrote:
> > > clang emits a -Wunaligned-access warning on union
> > > mcp251xfd_tx_ojb_load_buf.
> > >
> > > The reason is that field hw_tx_obj (not declared as packed) is being
> > > packed right after a 16 bits field inside a packed struct:
> > >
> > > | union mcp251xfd_tx_obj_load_buf {
> > > |     struct __packed {
> > > |             struct mcp251xfd_buf_cmd cmd;
> > > |               /* ^ 16 bits fields */
> > > |             struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
> > > |               /* ^ not declared as packed */
> > > |     } nocrc;
> > > |     struct __packed {
> > > |             struct mcp251xfd_buf_cmd_crc cmd;
> > > |             struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
> > > |             __be16 crc;
> > > |     } crc;
> > > | } ____cacheline_aligned;
> > >
> > > Starting from LLVM 14, having an unpacked struct nested in a packed
> > > struct triggers a warning. c.f. [1].
> > >
> > > This is a false positive because the field is always being accessed
> > > with the relevant put_unaligned_*() function. Adding __packed to the
> > > structure declaration silences the warning.
> > >
> > > [1] https://github.com/llvm/llvm-project/issues/55520
> > >
> > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > ---
> > > Actually, I do not have llvm 14 installed so I am not able to test
> > > (this check was introduced in v14). But as explained in [1], adding
> > > __packed should fix the warning.
> >
> > Thanks for the patch! This does resolve the warning (verified with LLVM
> > 15).
> 
> Great, thanks for the check! Does this mean we can add you Tested-by
> (I assume yes, c.f. below, if not the case, please raise your voice).

Sure, see below.

> > > Because this is a false positive, I did not add a Fixes tag, nor a
> > > Reported-by: kernel test robot.
> >
> > I think that the Reported-by tag should always be included but I agree
> > that a Fixes tag is not necessary for this warning, as we currently have
> > it under W=1, so it should not be visible under normal circumstances.
> 
> ACK.
> Marc, can you directly add below tags to the patch:
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Please use:

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

To make it clear that I didn't perform anything more than a build test
to see that the warning is fixed.

Cheers,
Nathan
