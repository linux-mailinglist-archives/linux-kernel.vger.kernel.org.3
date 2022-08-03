Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146945888D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiHCIs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiHCIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:48:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7E11D31F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:48:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r67-20020a1c4446000000b003a34ac64bdfso204223wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 01:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qKqo0h9Lva8dP5VOOSo7i61+QrtY8gPr4MgxUM+NaXM=;
        b=K1+QwMMF0ygQFYNEgKo0BPINIfeDi/62w29AVXiJ+sIPO5wYV7vOKSvv4nkNCLXUYd
         mpBPtDtwoH1NBnjlBqlWtVec1LV7ZWeJ0TeRNSVIJi7+YntM4Z0tf34zRJMcc0WoYzmN
         PdEVxwu1atJIytuGyf3tF6oDOybJYk/8SWK+kd8v6fvxu5fqODnJFPI5KtXERKSbDljv
         XPwFvWejnp8S3o12ZlA9tKbpn57sEnkWliG64dOnXEqKtf5FJ/2meiXN+MyDT40B0iNJ
         8Xe8/wEgxquFW3z0BRp7MYS4I0OhVqrTJ6ATOFcuzBRdKRoFXkho5Kf+YkpO9y6kLhDe
         JF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qKqo0h9Lva8dP5VOOSo7i61+QrtY8gPr4MgxUM+NaXM=;
        b=CgmyAHobSc/R2hr9vuD1pETpJcPyIv2I2vfPyJ7w/HwsaK4EnqS9UPbF4QoFy4DWNB
         FultomXE4QDSQxKC4qGi6LFCba9CZlUXg+vUqB8yXtXk25b+qW6VLC4nTKdNVqVbx9QH
         YdJD7Jgpkq5YBLstbAfMWL/l798zvSiPMbvHX9v64ZyT1FDCNPmc8LKN/nF/JQEWxube
         WoNktBDA0ljhOJS+40O6621bplLwAxE27sazjzdQccb6cjO237LQLXMYUzHWUEIt/G4Y
         igpndSfHbnMr+mlOZNqcwzdaYGbZwPws1POsYBw4JtMu4ymNf8NYntgBfUFEq5RjMc6u
         f+7w==
X-Gm-Message-State: ACgBeo0n1YqLHWPPT9yi/5w/2tYwHcBy0OmBHspRFFmQ4ibKmcRnwp/4
        1jsLHliXB/BdOnqt0leD8AE=
X-Google-Smtp-Source: AA6agR78xbQ3KK5qK5KyQWJM4Kybr6qyH51YeUilppnNGY+xV1TAQkEXrPe1nRJuq8Z/s0lxwWTh8g==
X-Received: by 2002:a1c:2981:0:b0:3a2:ffe9:945c with SMTP id p123-20020a1c2981000000b003a2ffe9945cmr2090453wmp.38.1659516501272;
        Wed, 03 Aug 2022 01:48:21 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d67d2000000b0020fff0ea0a3sm17319128wrw.116.2022.08.03.01.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 01:48:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 10:48:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     x86 <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] x86/numa: Use cpumask_available instead of hardcoded
 NULL check
Message-ID: <Yuo2UkkyaYtZ3rMZ@gmail.com>
References: <20220731160913.632092-1-code@siddh.me>
 <YukFgFTaq4Aw+uht@gmail.com>
 <1825f63b142.8968bde3116633.1242410031840350968@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1825f63b142.8968bde3116633.1242410031840350968@siddh.me>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddh Raman Pant <code@siddh.me> wrote:

> On Tue, 02 Aug 2022 16:37:44 +0530  Ingo Molnar <mingo@kernel.org> wrote:
> > Your fix makes sense I suppose, but I'm wondering how testing didn't 
> > trigger this warning.
> > 
> > Off-stack isn't a rare config option:
> > 
> >   kepler:~/tip> make allmodconfig
> >   #
> >   # No change to .config
> >   #
> >   kepler:~/tip> grep CPUMASK_OFFSTACK .config
> >   CONFIG_CPUMASK_OFFSTACK=y
> >   kepler:~/tip> 
> > 
> > What am I missing?
> 
> Maybe this triggers on certain config options set, or maybe due to new
> gcc version? (I'm using gcc-12, I also likely saw while on gcc-11.)
> It nevertheless is a helpful warning.
> 
> I just now tried `make defconfig` (default configuration based on
> 'x86_64_defconfig') and compiling with `make -j13 all`, and gcc doesn't
> give any warning. (CONFIG_CPUMASK_OFFSTACK isn't even listed in the
> .config file produced, grep fails.)

Does 'allmodconfig' reproduce the warning for you:

  $ make allmodconfig
  $ make arch/x86/mm/numa.o

?

If yes, then this could be due to gcc-12, as it doesn't reproduce with 
gcc-11 for me:

   gcc version 11.2.0 (Ubuntu 11.2.0-19ubuntu1) 

Thanks,

	Ingo
