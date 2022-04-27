Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DE51158E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiD0LGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiD0LFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:05:52 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEE08D17EB;
        Wed, 27 Apr 2022 03:57:36 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E291E92009C; Wed, 27 Apr 2022 12:57:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id DE67292009B;
        Wed, 27 Apr 2022 11:57:35 +0100 (BST)
Date:   Wed, 27 Apr 2022 11:57:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Stephen Zhang <starzhangzsd@gmail.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        liam.howlett@oracle.com, ebiederm@xmission.com, dbueso@suse.de,
        alobakin@pm.me, f.fainelli@gmail.com,
        zhangshida <zhangshida@kylinos.cn>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] arch/mips/kernel/traps: add CONFIG_MIPS_FP_SUPPORT when
 using handle_fpe
In-Reply-To: <CANubcdWwHXqC4gUztNseoConYHp+G4nUSYFaO-Te3jFVqT=1sw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204271156190.9383@angie.orcam.me.uk>
References: <20220426083259.526685-1-starzhangzsd@gmail.com> <alpine.DEB.2.21.2204270130210.9383@angie.orcam.me.uk> <CANubcdWwHXqC4gUztNseoConYHp+G4nUSYFaO-Te3jFVqT=1sw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022, Stephen Zhang wrote:

> Thanks for your comment. Do you mean  the following code:
> 
>  if (0 && !0)
>     set_except_vector(15, handle_fpe);
> 
> will be optimised away if !CONFIG_MIPS_FP_SUPPORT?

 Yes.  Or more specifically the LHS of the conditional expression will be
0 then, as shown above, and the whole statement will be gone.

> But we did get “undefined reference to `handle_fpe”  error when compiled with
> !CONFIG_MIPS_FP_SUPPORT.

 Please send me .config causing it and tell me what compiler and version
you have seen this error with.  We rely on things being optimised away
heavily throughout the Linux kernel, so this is certainly something to
investigate.  I have built such a config just fine, but maybe there's a
bug somewhere my setup does not trigger.

  Maciej
