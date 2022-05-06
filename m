Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7051D107
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389345AbiEFGIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353072AbiEFGIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:08:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FFD6542C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:04:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g20so7514313edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 23:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJu1QBrUmYKsWkPpzJPRKOLKMujPLz1avDzlkqqe+L8=;
        b=p1ZrXpxb63uHbrml1c8HgR6R8n6VXAQv2DV7PGrsCqaaPDcdt1d1FoueVXGEIgbvVt
         /nB25xLd28nAcVcUSeYEa4vWHl6llvjLvil9Een/4ZnLF9kVHt9t5zfLWhlce17PsUc1
         5YerJuRVq1snCMLlEXqVQECmcSvr6FY1zky4lP/wlA0KX5jXrZsBgZww9okQvwCnctlW
         GJFDQScmIJx9DAAODntgndBf7j17ZqVq5C2eY0A3WDQIPLkEYnq2PMkyDUnKfyCaeaes
         lbnZDhxIDt6tIueEHR4/fKt3QiOlvkpIjNZe7STkNFKWxKbQmiloKbPCwmuN+8UR1agB
         JgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJu1QBrUmYKsWkPpzJPRKOLKMujPLz1avDzlkqqe+L8=;
        b=4oj62+3MZb9yVBpAHGXVTy1q7HbNLX+Q4N5pIDXsVVVmlPXLRiM4qyedVsFgJEOars
         if9u+KW65B/G4mHDRD99HvWxKKTbzNLDowh4WUGFAVcl9/gbPabS9If4kBzHH079VLfL
         m+Hw/dCeeLxpv0c0dhShWk2Lt8kcYG2PtVOzX8CTWofSzW3A0TLH3tt6E+O6bGR98+k3
         NCtjDi1DRJG7wJUJPAhzH9vhTzp0qTFZWQqfTL/3NNCXofL73wLXWTxDP2NXQfLtecJD
         KrmVbSUybe7b8JK6aQ5Om4IZKgCfjjHQLQ28niuZjWOb3qafLziQZeE0oycocPUTSl13
         SzNw==
X-Gm-Message-State: AOAM5325xOuFOAHUEaTV1xAzUrDZBN3EA6sUN39j3YGRNcUbAgjqXrrH
        LfCxMIlEV7XTXY3nIpTzud62hAAaDLiOu6xd+eWgM1SSNdOd/Q==
X-Google-Smtp-Source: ABdhPJyjR3VqHnhQ0+9jqGgrEcJO6faNzUSay9sDENcyjsNJy757tlJm02YozgF9LzP0YO10j+v6BI9XIiNNotBGl1k=
X-Received: by 2002:a05:6402:268e:b0:427:c402:d6f3 with SMTP id
 w14-20020a056402268e00b00427c402d6f3mr1836865edd.358.1651817056757; Thu, 05
 May 2022 23:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <2fb2bc4e857848c83cfa96483e4b25b23d46be49.1651516951.git.jpoimboe@redhat.com>
In-Reply-To: <2fb2bc4e857848c83cfa96483e4b25b23d46be49.1651516951.git.jpoimboe@redhat.com>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Fri, 6 May 2022 11:34:00 +0530
Message-ID: <CAPDLWs_aOi-f801SAhA1X2YH4XE_r5P3AfPV1uhQWA10bKKffg@mail.gmail.com>
Subject: Re: [PATCH] scripts/faddr2line: Only use text symbols to calculate
 function size
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Josh,

Unfortunately, it didn't work with my test case (as before):
$ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x124
bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
$

What _did_ work was the earlier (much longer) patch you'd sent (your
email dt 20 Jan 2022),
Could you pl recheck...
(As before, i have the test case module here:
https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2
)

Regards,
Kaiwan.


On Tue, May 3, 2022 at 12:14 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> With the following commit
>
>   efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
>
> it was discovered that faddr2line can't just read a function's ELF
> size, because that wouldn't match the kallsyms function size which is
> printed in the stack trace.  The kallsyms size includes any padding
> after the function, whereas the ELF size does not.
>
> So faddr2line has to manually calculate the size of a function similar
> to how kallsyms does.  It does so by starting with a sorted list of
> symbols and subtracting the function address from the subsequent
> symbol's address.
>
> That calculation is broken in the case where the function is the last
> (or only) symbol in the .text section, which can occur quite commonly in
> a kernel module or a .o file.  In that case, the next symbol in the
> sorted list might actually be a data symbol, which breaks the function
> size detection:
>
>   $ scripts/faddr2line sound/soundcore.ko sound_devnode+0x5/0x35
>   bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
>
> Fix it by only including text symbols in the symbol list.
>
> Fixes: efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
> Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  scripts/faddr2line | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 6c6439f69a72..2a130134f1e6 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -189,7 +189,7 @@ __faddr2line() {
>
>                 DONE=1
>
> -       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> +       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$2 !~ /[Tt]/ {next} $3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
>  }
>
>  [[ $# -lt 2 ]] && usage
> --
> 2.34.1
>
