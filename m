Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDED4DB5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357474AbiCPQTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357471AbiCPQTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:19:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030076D3BA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:18:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w16so5266378ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HhoL8quUY1FIjbb7RmxlmM5K/jdJ3Woo4L6/mprIUE=;
        b=p+Aa8cRpHOfTbwjkAxVbY0urZU45sfqEQfLLhtafoy5rvILOUdEMS6y9rfs7MCELML
         DB4AIlZrxW83Geb8g3qWcQ9llIp7QdPh9sekp5Orp3K7mUHx/Et4fB2A3GHFV61BSJsv
         EH8TBeLexL296mBDZMR/KRDgvhbzKfUi00BVIQJ0Eax5IuIU1m/iPUm5dJmwFWXOkM3V
         7IklxZS/IT+8+gb9ijPL3RUP9USJwNh4RoTIGIBgQn8bxyM6BxqUlrZXJHucQt/xphED
         RQu8Wn+CJ9Hf8jlxoItdWdZCkGctnjcGF/X+WVT2vjiEZqaYG3QO1GxtbtaZTfe95HBT
         f9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HhoL8quUY1FIjbb7RmxlmM5K/jdJ3Woo4L6/mprIUE=;
        b=y39yc+NRdZALTrs5Wv3WY94U0no7MKUtt7Y05IeLKFT/ywLIxGhYLHeM6+ALkD6+b6
         XtgqBQhGMW2fzSNDkciJUe0TgHIx51Q0+1EWGRqA250gsmKk7zpD1CtfGnjEaVmD1GyL
         my7WjiDTI2v81YhrK4MSIPefzD93M8R0sZFkUSqXjeX7LRzdAATASVJCEPZxFEdAV70l
         Ep6oZVsV25k7K5fGo6N1deu/VbI9C7UfsbrmsMygi4NJ+2APpbV2OCiNc6ADfDEzXjTy
         yA3zwA4qCjt8SDOEqxez7Pz4CYT/qijtI4jNoXeAdUVkN/6CM3efQOn/XfMMU40zTlm8
         cqQg==
X-Gm-Message-State: AOAM531Px6julHMpjGT0ZdJWJ4+SpAHPo5bTf7aRlq8fB3nYAWTDkONj
        es5dZCdvmji7pKaGTIF681XVJqtDpsHgZ7Pp3C0=
X-Google-Smtp-Source: ABdhPJzKQMoIw0sLnRfxnDMBo7qlHDQw8nqkyk1ZtN4Dm7MPAuwp5+oY5yL2HaDo4CHjsFNIm8uQEYOjwHdZk/Ko0Uo=
X-Received: by 2002:a25:8b03:0:b0:628:8cff:ed6c with SMTP id
 i3-20020a258b03000000b006288cffed6cmr624370ybl.513.1647447503528; Wed, 16 Mar
 2022 09:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220315073949.7541-1-jiangshanlai@gmail.com> <20220315073949.7541-5-jiangshanlai@gmail.com>
 <YjH9M3MBn+j/MwPJ@hirez.programming.kicks-ass.net>
In-Reply-To: <YjH9M3MBn+j/MwPJ@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 17 Mar 2022 00:18:12 +0800
Message-ID: <CAJhGHyDDAe1xe1Lh1+xydxo4SCWF9qvwPYbjRWEVVFGTisN7OA@mail.gmail.com>
Subject: Re: [PATCH V3 4/7] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Wed, Mar 16, 2022 at 11:07 PM Peter Zijlstra <peterz@infradead.org> wrote:

>
> So I don't much care about the orc data, that's only used when
> unwinding, a relatively rare occasion, anyway. But the text increase
> does bother me a little, this can blow up I$ misses on syscall heavy
> workloads.

It has nothing to do with the syscall.

It does add a lot in I$.  But it is fortunate that the footprint
is the same (before and after the patch) for a single exception vector.
For example heavy #PF workloads.

Footprint will increase after this patch when two or more exception
vectors happen heavily at the same time, for example when #PF and
timer are occurring heavily.

We can put PUSH_AND_CLEAR_REGS in a single function to reduce the
footprint for heavy multi-exception workloads.  What do you think?
