Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E40C4A91E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356382AbiBDBOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355032AbiBDBOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:14:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 17:14:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id j2so14029587ejk.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 17:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Rjor0jfBWADQNuiVXdyblMXrjJS5xpbSX0IQ1DxiWE=;
        b=cJCEYOrIPCkXtfM04ithN+EfN3tUV+/iGlKdmcBNa/388gx3roz9zW2nr0BIaELvuV
         0ZtpbQNzgnxW6t3PkLQfmC1bYmqCmasZMsKd+prnYlfjMy5maGVvlB/PK0c/yEtv/i46
         CkO9IV4hPMOsHo8HQgpRHwKsOCz5y3r9jChcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Rjor0jfBWADQNuiVXdyblMXrjJS5xpbSX0IQ1DxiWE=;
        b=VCxB8hOpRyxQn04DziGakjvKJHMEM0iW+1CKBTuz7Q6jHEHtIrNK7eOrJ1say+ebOC
         kQR6BQbptAJKiGLwtcpOFDIZJ0Bz27Hx0lcgyJWMKNgttUN2ncsmjQ8rlxK86ik01uOe
         iNV5BP6Wej0H8E1glYfbBn91dwcivvL3+9UI9KdGg2BlNqwiTiryf3vQdu4HUR0fM9hs
         orWW363q0C2LouDngl+oT4Td8HgIxLgJWYmzZneeZVWRNA8ftHufjv1pR0SIYu8nikWJ
         lnZg5v88xTMeYuc4Jaq8JOq9pkUEjmUt5PXt1pHJY0qNkJvoxVqBpOInL2fkwWRlCRF8
         0GkQ==
X-Gm-Message-State: AOAM532X1ktGMvRitjUy+SXsbBMDwbBFBnWqjz5sSz7tbNG9eqpwea0C
        hreaYnpUC6BfOkSvPEP9gEHalBImAkvLAA2Q
X-Google-Smtp-Source: ABdhPJw7ncps9G7ujbMTLus4/DUwVsHhrSLX8qSOHPdyEkHbnZ30sRIXsO4VZ8cBwQZSX2w1RDAG9Q==
X-Received: by 2002:a17:907:9617:: with SMTP id gb23mr468238ejc.462.1643937268596;
        Thu, 03 Feb 2022 17:14:28 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id by22sm141009ejb.84.2022.02.03.17.14.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 17:14:27 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id w11so8390656wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 17:14:27 -0800 (PST)
X-Received: by 2002:a5d:500c:: with SMTP id e12mr414096wrt.193.1643937267127;
 Thu, 03 Feb 2022 17:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20220203201754.1145358-1-keescook@chromium.org>
In-Reply-To: <20220203201754.1145358-1-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Feb 2022 17:14:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj45HHNEvjKo-vNgFmCNtFW+rnQgmuBqhb9+eJ5pumvnQ@mail.gmail.com>
Message-ID: <CAHk-=wj45HHNEvjKo-vNgFmCNtFW+rnQgmuBqhb9+eJ5pumvnQ@mail.gmail.com>
Subject: Re: [PATCH v2] gcc-plugins/stackleak: Use noinstr in favor of notrace
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 12:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> While the stackleak plugin was already using notrace, objtool is now a
> bit more picky. Update the notrace uses to noinstr. Silences the
> following objtool warnings when building with:

Thanks, applied.

There are still a few objtool warnings about other issues, all look
somehow related to mce:

  mce_start()+0x5c: call to __kasan_check_write() leaves .noinstr.text section
  mce_gather_info()+0x5f: call to v8086_mode.constprop.0() leaves
.noinstr.text section
  mce_read_aux()+0x8a: call to mca_msr_reg() leaves .noinstr.text section
  do_machine_check()+0x197: call to mce_no_way_out() leaves
.noinstr.text section
  mce_severity_amd.constprop.0()+0xca: call to mce_severity_amd_smca()
leaves .noinstr.textp section

and from a quick look at least some of them look like real bugs.

For example, mce_read_aux() is marked 'noinstr', but it calls
mca_msr_reg() which is not. That's iffy.

The others might be compiler-generated (the 'constprop' thing has
caused section issues before so I didn't bother looking closer). Or
related to kasan. But at least one of them seems to be a valid warning
about bad behavior.

              Linus
