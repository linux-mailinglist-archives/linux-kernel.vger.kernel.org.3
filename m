Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC95ABB98
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiICAOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiICAOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:14:19 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE30E97D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:14:18 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11f11d932a8so8694008fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 17:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4d2rjgmYFonsZIA/vvWlVIIe1M0YYIwhseZs1soQQhU=;
        b=X6fuqudWdKK576+9fZ1LMvr6MKGhSMQ7P8t38PQeydMAIkjFxL6d6KpDtMQSlRSNcE
         gslGV3xdU1EjHMzKf4X0PyM3jLVDbz4M9rSacF3yPZW/Rw0g+zKjHIozDmmidjPayJNZ
         692bUcYIe8or9YFy1zjkeMN0R/CmGm40MQ/mEdda+P4r3F5QYdJTornNgSJvmE7MIShG
         xGx/KydQ7OsEWlgWEYoSoE0j/3Sw2NC/hzqWy7GCKxj2BdtgGH/MYTgUJduaREVSBIPo
         XLmNdKUwjW1UjaJnHcrRTQar0+vHZecd49P8EZhCL48MFRZRrJ1Yf3615Ugn2r9gmJYc
         csPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4d2rjgmYFonsZIA/vvWlVIIe1M0YYIwhseZs1soQQhU=;
        b=I9LF0uV66DLFRz2BPZCtWkpOeXvYIRXaIvls8HLvTCTuWofS5skQJFCCNjiBNEq4Zb
         3R0G9kwDVjjkjMiyuFCMNBc9c+8AjcSHz80QKpBBeo5VgCET3ooJOpnWDdjCcdncSTc/
         8VOMxUw68B9Sv/bESAwgGNdzRuSszDyzjzzGyHfde42qz6eHBrWUYhvB717FGtyyjAvn
         gOx0bmDfeRc+eOMSq9TUsWhIFoF0yLQfpTsJeXDSRs8KXbIddq+FFUF27AzVDKFhGF02
         uKFpbSt5ah8bEtkLiNyEL2h61fB0rJzlhPQcmXB6EY7RdYImlbW4x92aC4TbBTFM1lpk
         Joyg==
X-Gm-Message-State: ACgBeo2F9N2xpHoh7R6Ecj5BGQ3+rusVTEYnG20dSuyV2AJ2+FkSIfqE
        j6U2RhDjagd9A9OGfjPVVTk=
X-Google-Smtp-Source: AA6agR5yzCyl+ldHRkOlYlrxdHyGOqyU/T6yWlUrygocyhFanVRRbTKlN9JuALVh7qAheBJq2L6j1Q==
X-Received: by 2002:a05:6870:41c3:b0:11c:3697:6632 with SMTP id z3-20020a05687041c300b0011c36976632mr27800oac.1.1662164056576;
        Fri, 02 Sep 2022 17:14:16 -0700 (PDT)
Received: from localhost ([104.183.150.195])
        by smtp.gmail.com with UTF8SMTPSA id c7-20020a9d6847000000b006393ea22c1csm1656795oto.16.2022.09.02.17.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 17:14:16 -0700 (PDT)
From:   Fangfei Yang <yangff1@gmail.com>
To:     dave.hansen@intel.com
Cc:     dave.hansen@linux.intel.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        sroettger@google.com, x86@kernel.org
Subject: Re: PKU usage improvements for threads
Date:   Fri,  2 Sep 2022 19:14:12 -0500
Message-Id: <20220903001412.17015-1-yangff1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
References: <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I guess the question here is whether the code to call sigaltstack and signal handler is considered part of the security code (sigreturn obviously has to be, since the kernel has to restore the PKRU based on the saved fpu).
I think to a large extent this is necessary, at least for the signal handler to be able to access the relevant registers at the time of the interrupt, which may contain data that the handler should not have access to. Even specifying a PKRU at the time of signal registration would make the system functionally sound and safe since the relevant calls must be protected.

It's just that the design here should be such as to minimize the ways in which the interface can be abused (e.g., accidental override access) as well as to simplify the difficulty of writing secure code. It might be reasonable, then, to save the PKRU when the `sigaltstack` is called.

The main purpose is to simplify the design of the handler entry point without adding new system calls, while not accidentally gaining privileges that do not belong to the current PKRU because of the system call, whether immediately, or later in signal delivery.

This is because this part of the design can be largely made easier if additional source checking and PKRU switching by the handler at the entry point can be avoided.

As `WRPKRU` can be abused, if the handler uses this instruction, additional SP as well as PKRU checks must be performed to prevent malicious programs from forging signals, and the check must get multiplex among all threads. However, for the kernel, it takes very little code to avoid these checks by giving the handler the PKRU it wants.

If only one PKEY is specified, then it is likely that `WRPKRU` is still needed, since the TCB itself may occupy multiple PKEYs, or, the handler need to access the memory of other PKEYs (e.g., complex multi-domain signal designs).

And, logically, it makes sense for a signal context (sigaltstack) to have the same PKRU when it is registered, and when it is used in the future. Thus, a special flag in `ss_flags & SS_SAVEPKRU` to ask the kernel to save the current PKRU would be sufficient.

From the security side, if the current PKRU does not have access to the signal stack, then a future signal occurring when the kernel uses this PKRU to write will also result in an segfault, thus avoiding unwanted access through sigaltstack.
This is also more accurate than checking the PKEY of the page when registering the signal stack (if we restricted the PKRU when registering the sigaltstack). Consider a possible error: a page is accidentally unmaped after being registered as a signal stack, and then another page that should not have been accessed by this PKRU is mapped to the same location, thus causing an override during signal delivery.

> I also bet we could do this with minimal new ABI.  There's already a
> ->ss_flags field.  We could assign a flag to mean that stack_t doesn't
> end at '->ss_size' and that there's a pkey value *after* ss_size.  I do
> think having a single pkey that is made accessible before signal entry
> is a more flexible ABI than taking an explicit PKRU value.

Agreed, the most flexible way should be allow setting the PKRU to any subset of the current PKRU. So we can check `(~new_pkru) & current_pkru == 0` when calling sigaltstack. 

However, no matter how it is done, one of the more disgusting thing is that code like this appears in the program that handles the signal.
```
old_pkru = read_pkru();
write_pkru(stack_pkru);
do_xsave(); 
*(fpu_saved + pkru_offset()) = old_pkru; // this may be an argument of fpu function call
```
And when restoring, you also need
```
old_pkru = *(fpu_saved + pkru_offset());
*(fpu_saved + pkru_offset()) = stack_pkru;
do_xstor();
write_pkru(old_pkru);
```
These plus the testing of the current runtime environment (MPK) are truly disgusting. It's just structually ugly.
