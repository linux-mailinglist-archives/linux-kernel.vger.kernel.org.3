Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9429F52C060
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbiERQPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiERQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:15:19 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC421E15D0;
        Wed, 18 May 2022 09:15:16 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2fedd26615cso29892517b3.7;
        Wed, 18 May 2022 09:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sLPjtLKM+w66TgU+5tbLygmukIL12gj1V2vL7d+pjQ=;
        b=lyrG1meUZ1+i0egDUomc463vPzyFwtUrX8G0Rbxl/r7SXg77vYF0Eh9z9phLC79lkf
         KHyrx0O18RfDel4JVVXX8ldwcgjNMeUeDB/Pr9M3Tzlx090LTIlYbSnPAEeSeSp9Ze9S
         TByPz//ocGGxcgH1N6mo9tq/oecylfR8ibqmP15tvzMyQuvat7nNO3gWXfhClbjrhbLi
         x4Psel/yZR8sTrTVrcKvoszs8fEApkoLPhw9u3Z5wqk9pg6xqTdF7rnaMQMXg4IYawV0
         IPUjTbFSMFcNqGEszyCFRLNxBWENnmURSQGx3KnLmq6jK6L0xXck3f7Db3OcV8TyI1FH
         cEfw==
X-Gm-Message-State: AOAM5320LgLl8IoNzxHcZ9l1uxnkil8iN7fSTKGZ0qqdK6TrSEp56tpa
        J2BKEWxRIu/6cz3FFvKpseT0t50CPsO7Fu7Z1Wk=
X-Google-Smtp-Source: ABdhPJz0aeWOuS+lv+DkhnzdtwnLkPUMU/co7zL+PuGJoK33yIPpIoCN+eypEXA95MzKmENxwAkxjLaCHc5NEsiCf38=
X-Received: by 2002:a81:3d43:0:b0:2f9:7d:f320 with SMTP id k64-20020a813d43000000b002f9007df320mr128935ywa.191.1652890515810;
 Wed, 18 May 2022 09:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220518070517.q53bjzo6lbnq3f2i@pengutronix.de>
 <20220518114357.55452-1-mailhol.vincent@wanadoo.fr> <YoUZLHIbxPu15/lN@dev-arch.thelio-3990X>
In-Reply-To: <YoUZLHIbxPu15/lN@dev-arch.thelio-3990X>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 19 May 2022 01:15:04 +0900
Message-ID: <CAMZ6RqL2eKd-uqP-2vnt99_0RRE-8x7hxwYy6x1b0Oqes-HGgA@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251xfd: silence clang's -Wunaligned-access warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 19 May 2022 at 01:08, Nathan Chancellor <nathan@kernel.org> wrote:
> Hi Vincent,
>
> On Wed, May 18, 2022 at 08:43:57PM +0900, Vincent Mailhol wrote:
> > clang emits a -Wunaligned-access warning on union
> > mcp251xfd_tx_ojb_load_buf.
> >
> > The reason is that field hw_tx_obj (not declared as packed) is being
> > packed right after a 16 bits field inside a packed struct:
> >
> > | union mcp251xfd_tx_obj_load_buf {
> > |     struct __packed {
> > |             struct mcp251xfd_buf_cmd cmd;
> > |               /* ^ 16 bits fields */
> > |             struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
> > |               /* ^ not declared as packed */
> > |     } nocrc;
> > |     struct __packed {
> > |             struct mcp251xfd_buf_cmd_crc cmd;
> > |             struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
> > |             __be16 crc;
> > |     } crc;
> > | } ____cacheline_aligned;
> >
> > Starting from LLVM 14, having an unpacked struct nested in a packed
> > struct triggers a warning. c.f. [1].
> >
> > This is a false positive because the field is always being accessed
> > with the relevant put_unaligned_*() function. Adding __packed to the
> > structure declaration silences the warning.
> >
> > [1] https://github.com/llvm/llvm-project/issues/55520
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > Actually, I do not have llvm 14 installed so I am not able to test
> > (this check was introduced in v14). But as explained in [1], adding
> > __packed should fix the warning.
>
> Thanks for the patch! This does resolve the warning (verified with LLVM
> 15).

Great, thanks for the check! Does this mean we can add you Tested-by
(I assume yes, c.f. below, if not the case, please raise your voice).

> > Because this is a false positive, I did not add a Fixes tag, nor a
> > Reported-by: kernel test robot.
>
> I think that the Reported-by tag should always be included but I agree
> that a Fixes tag is not necessary for this warning, as we currently have
> it under W=1, so it should not be visible under normal circumstances.

ACK.
Marc, can you directly add below tags to the patch:

Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>

Or do you want me to send a v2?


Yours sincerely,
Vincent Mailhol
