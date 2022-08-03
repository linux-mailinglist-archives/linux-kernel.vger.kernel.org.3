Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C57D58898F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiHCJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHCJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:42:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93842183AD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:42:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk11so11002497wrb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k+YF9ia8v3GYpHFcptb/moFiQCtuPoH/DYSRMFgwu2w=;
        b=iFpHgcYuaui81Z2pL5x0xH1qahjQL2ILwyh7okH/70a+mEaNwwvhOW93blQ3dwZq5o
         aWKTNwaOZsnV7xp5JzFqinqouT+IfLyQ5p7HaCORNkuwgv6FugCCQjoX7iVfO5/8b6pS
         I+NfQw3SAQZ95Nwnz7b8FzR6SGIVQsgnyEUFDKUvYyHk16QvEKlgVfaNtsGpBM76rlml
         vIwpbNrLJUr2/Oc658BYdPn+H5DXBSS8GEoMKME7In0JG9Zj6scWNzZ1e91HlkNxc26f
         xu5iPUB+SFalQqqX6ZHaGqjhUEGq82L1nFWYUaIDLmSo1xeHbWh1dRpqtykesSJve/2D
         LX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=k+YF9ia8v3GYpHFcptb/moFiQCtuPoH/DYSRMFgwu2w=;
        b=Gg8hpbL3b9UjYSc2tLvHMrEvKrpYwxz5LOvbiC2qcZM39lhEacLn8DKWC59a/HhaH+
         HBbFEKmbBv4xvJjCYImLKuJkKOdz5q9riWnCHsFrigM93ZoR60SR5o1oJ3/NYl5Z96xH
         zy6Ixp24azoW6nFDS5exmlrzi2v3Dq9zvA6gIfPi7mI9tltHK60Fw7Y0NbFIeT1I/V5j
         zw1sP/7y1Hvxpz/1f9Qs/VsXT03RWDx+BsiEF+JtHTlflQaFB4WlFyaGzFrhcIn8ryWg
         lmUCSa3LKz0LuhxQkcAQ77BgVV2MXR8qEWkgeaz1f9LPkNJchZd6gn8++tUJ+bmUyjg8
         /cQw==
X-Gm-Message-State: ACgBeo0kMs7rrqLB8rhTCEGC8wkKBHGlnttdb/sWBjD9jxUaRlGMs6MR
        UIIyktM37X3X145tP0pasweVX5Hn/t4=
X-Google-Smtp-Source: AA6agR7UXPlJxQzoQRa0okevqRiQ+qQIkJKzCz8pKCkuyTpMHdsNpwW+AXCBNEc/ltnqgYfO19Nufw==
X-Received: by 2002:a5d:6642:0:b0:21e:f918:b093 with SMTP id f2-20020a5d6642000000b0021ef918b093mr15467912wrw.173.1659519734169;
        Wed, 03 Aug 2022 02:42:14 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d4b82000000b0021e5bec14basm17936099wrt.5.2022.08.03.02.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 02:42:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 11:42:11 +0200
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
Message-ID: <YupC88xuQ4rcyLVR@gmail.com>
References: <20220731160913.632092-1-code@siddh.me>
 <YukFgFTaq4Aw+uht@gmail.com>
 <1825f63b142.8968bde3116633.1242410031840350968@siddh.me>
 <Yuo2UkkyaYtZ3rMZ@gmail.com>
 <18262ed2459.44b0d74d434377.3690496800292832933@siddh.me>
 <Yuo7A0KYoNnbgwWT@gmail.com>
 <18263030220.8a990e82436929.3216192040531777412@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18263030220.8a990e82436929.3216192040531777412@siddh.me>
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

> On Wed, 03 Aug 2022 14:38:19 +0530  Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > * Siddh Raman Pant <code@siddh.me> wrote:
> > > There is no reason why allmodconfig would trigger the warning, [...]
> > 
> > Well, unless I'm misreading your changelog, all the warning needs to 
> > trigger is CONFIG_CPUMASK_OFFSTACK=y.
> > 
> > > as it has CONFIG_CPUMASK_OFFSTACK=y, but the warning is because of the 
> > > other case.
> > 
> > What 'other case'? I've re-read the discussion and don't see it, but maybe 
> > I'm a bit daft this morning ...
>  
> No, the warning is happening because CONFIG_CPUMASK_OFFSTACK is not set.

Oh. So I was daft, as suspected. ;-)

And I can confirm that while gcc-11 doesn't trigger the warning, gcc-12 
does:

  $ make ARCH=x86_64 CC=gcc-11 arch/x86/mm/numa.o
    CC      arch/x86/mm/numa.o
  $

  $ rm -f arch/x86/mm/numa.o
  $
  $ make ARCH=x86_64 CC=gcc-12 arch/x86/mm/numa.o

    CC      arch/x86/mm/numa.o
  arch/x86/mm/numa.c: In function ‘cpumask_of_node’:
  arch/x86/mm/numa.c:916:39: error: the comparison will always evaluate as ‘false’ for the address of ‘node_to_cpumask_map’ will never be NULL [-Werror=address]
    916 |         if (node_to_cpumask_map[node] == NULL) {


> [...] This is because in that case cpumask_var_t type is not a pointer, 
> and thus the var can never be NULL, which leads gcc to warn us when 
> comparing with NULL.
> 
> The chain of events are like:
> 
>         #ifdef CONFIG_CPUMASK_OFFSTACK
>                 typedef struct cpumask *cpumask_var_t;
>         #else
>                 typedef struct cpumask cpumask_var_t[1];
>         endif
> 
>         cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
>         ...
>         if (node_to_cpumask_map[node] == NULL) {
> 
> 
> The fix works because:
> 
>         #ifdef CONFIG_CPUMASK_OFFSTACK
>                 static inline bool cpumask_available(cpumask_var_t mask)
>                 {
>                         return mask != NULL;
>                 }
>         #else
>                 static inline bool cpumask_available(cpumask_var_t mask)
>                 {
>                         return true;
>                 }
>         endif
> 
> 
> The conditional definitions, as pointed out earlier, can be seen from line 700
> of include/linux/cpumask.h file.

Yeah - and I agree with your fix - will apply it.

Thanks for your patience :-)

	Ingo
