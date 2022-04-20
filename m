Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD950801D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356045AbiDTEcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiDTEcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:32:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA0062DE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:29:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r189so755657ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ca0BuBVr/d8uQqf5viG8UycJ7VWTDMA7hYPu8iqyqE0=;
        b=YzXagblC6H8cB8lRJtSr5Z8G7olqqRNFPijud3sJXVYI/FAakCkj2Dnha1DMQzQ3Q7
         ABbpJZVwpHzpgyEz1f1xZA8SvDMn6ua6TuMzpaLSyxFJmIcmPkhrXfXlAuxL7G6wTKDp
         F7hxEmqTBwtwbqYklooazDESdDTlD2A52eFWKQz+O3H/W2jMIlIqLld5OU/FFKWYa3kh
         7EVkJU974u987fluC+xjR7LmLc2yVUujAa1bmaVjAUEyas4xZm6vlkrzttNloEKdLjJi
         5in88C8szLmc7V7PyrYRhv6gYVOpN3X3ES8+Ny+es2JzmTEGQ/2Tk3cWIfieIrd17DkR
         e8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ca0BuBVr/d8uQqf5viG8UycJ7VWTDMA7hYPu8iqyqE0=;
        b=a6nOJh3/UsONXf/Ne2bwUDTw6KJmsPdQj+bkYIDDJM34uW+R92UjbQG6J3D9yFfJnW
         yz9d8yjx3IDTb75nFM2izXkaYDAvuUiqt2ezsB0FFNO+JPndXpAz+5vdgCaksnnLYf4o
         9PhPAJD8dIppgMKATv11SCHhWAelFHsmR8XQ01pf419KDc93Ppgvi1HbsK33hE/Lm3gM
         kaL4186PcfvGd74F7lnh22LsvFfMRm6KwBz9EV7mBRhqkmvxrSmZvGQm4b0akLfwdUkE
         KZe9a7aHm2yYnj4bjbXPiDpTxI+qLAdeSMnHk3yFFR+C6/EtMKVR/nahsMsZRgtUFOQy
         qcXw==
X-Gm-Message-State: AOAM530IcgOMcRESqCCgFabq2DDkt/PyuNUdmmFNydH240GN/ZqsJNng
        thqYh8ktPGNSwyadILIcB2T51IDcCiY0GA05AuY=
X-Google-Smtp-Source: ABdhPJzwDzIu//iTtmXHlpWB9WaYG7mL/oELc2V02NCn8O0mBo54/rC/FE0UtyzQqj7VRnwcCpVT86WnpzqiI+lDFW0=
X-Received: by 2002:a25:b991:0:b0:610:bf4e:1b33 with SMTP id
 r17-20020a25b991000000b00610bf4e1b33mr19029133ybg.352.1650428993716; Tue, 19
 Apr 2022 21:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220419204109.520779286@infradead.org> <20220419205241.339242797@infradead.org>
In-Reply-To: <20220419205241.339242797@infradead.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 20 Apr 2022 12:29:41 +0800
Message-ID: <CAJhGHyAhoRQWF1eWnUQTnUSVQHtYCudb1Ka2XF5EE9Bb9g7a4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 4:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Since the upper regs don't exist for ia32 code, preserving them
> doesn't hurt and it simplifies the code.

In entry_INT80_compat(), the upper regs need to be preserved on the
stack which makes the code identical to the macro idtentry except the
special prolog.

So reusing idtentry simplifiers more.

I don't ask to remove the change to entry_INT80_compat().

But I don't think the change to entry_INT80_compat()
fit the changelog.

I think it is better to split this patch into two.

The first one contains the change to entry_SYSENTER_compat()
and entry_SYSCALL_compat() with current changelog.

The second one contains the change to entry_INT80_compat()
and PUSH_AND_CLEAR_REGS with changelog saying it simplifies
entry_SYSENTER_compat().

My patchset can do the simplification by using idtentry
and remove save_rdi from PUSH_AND_CLEAR_REGS on top of it.

Thanks
Lai
