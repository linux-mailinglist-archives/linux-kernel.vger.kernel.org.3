Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E334D06C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiCGSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiCGSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C8C5E75E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646678712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZqX6DybrLxhMSThzgJlQJxqEmTvZwmh5MmGL6Skfc4=;
        b=iWmBjiqbmgmcc9hOLfMHjKmw9gVNPjbtyoEPxhNjGsbrQxQW6icHfVd2rt7CXzTHjU6Xhv
        n93mVQkeFS0q7GnW7zZTmetD9ezos3kejiTKHlrTuZVjCdUd6xb9mIXYz/p5qVIDFOxZke
        CvNkEgrbFyuXolouvt0mpd0Qa30pL+k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-bS8KYQ17NbSZvwGKzlF66A-1; Mon, 07 Mar 2022 13:45:11 -0500
X-MC-Unique: bS8KYQ17NbSZvwGKzlF66A-1
Received: by mail-qv1-f69.google.com with SMTP id o7-20020a0cfa87000000b004352258d2d1so13213610qvn.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vZqX6DybrLxhMSThzgJlQJxqEmTvZwmh5MmGL6Skfc4=;
        b=NeyenfHDJb/e6fyT9zDoDwF4p9f9/wZN/5G57T4yE4dcq6HszxI7lv/x+sX7R8yr4b
         0i6hE/Jb3REQtyHjYoC01gEsuiWEYV16qWW6Nl80jnPu4Gr/G0xIBpeoPjCXYVnHJEtW
         1osZz75e9POSknxLCjN7lWPWXRXpTXZNCverC3gowffkxlE4WO4ghUzXejJ/c2N/OFXC
         UcVQqyPKWB4gGMMXj8i8gZ4lLvR28hCYRZ+VaiVYCV/pnUvBNuFAJCoHf1Lsi/tyDEPk
         845lcp7Nc0wwYDH7n6JBnX8jPIORXzVsicEuRq3Ao9QuCFglfOHs5jIwclFr6tteYNir
         YqFQ==
X-Gm-Message-State: AOAM532/BPfsi1ORYnLZQvvXICs7rhEYwch2RWumc7IBGHQBE0bfirj0
        JJsLGLxfdk1f5Y95dv7njDsEESJuj8HZlKbgsC74LU4PSavg9UV8nqIKZTXn4MK9MyUinsgQdGj
        RO2UgGBOxTvy4BxSB19WZOnk2
X-Received: by 2002:a37:a281:0:b0:67b:3c17:ffdb with SMTP id l123-20020a37a281000000b0067b3c17ffdbmr2176796qke.105.1646678710966;
        Mon, 07 Mar 2022 10:45:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr+onuOzJkv86pztnLwhpwxB4uZhsCLFG9fnvE+XZZ5Enkeqvf0FUIwK5cM7bu7bVmFfObww==
X-Received: by 2002:a37:a281:0:b0:67b:3c17:ffdb with SMTP id l123-20020a37a281000000b0067b3c17ffdbmr2176770qke.105.1646678710658;
        Mon, 07 Mar 2022 10:45:10 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002d7847160c0sm8852117qta.82.2022.03.07.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:45:10 -0800 (PST)
Date:   Mon, 7 Mar 2022 10:45:05 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alex Thorlton <alex.thorlton@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/paravirt: Apply paravirt instructions in consistent
 order during boot/module load
Message-ID: <20220307184505.pvwzjujlqoyrpk44@treble>
References: <20220307180338.7608-1-alex.thorlton@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220307180338.7608-1-alex.thorlton@oracle.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 12:03:38PM -0600, Alex Thorlton wrote:
> Commit 4e6292114c74 ("x86/paravirt: Add new features for paravirt
> patching") changed the order in which altinstructions and paravirt
> instructions are patched at boot time.  However, no analogous change was
> made in module_finalize, where we apply altinstructions and
> parainstructions during module load.
> 
> As a result, any code that generates "stacked up" altinstructions and
> parainstructions (i.e. local_irq_save/restore) will produce different
> results when used in built-in kernel code vs. kernel modules.  This also
> makes it possible to inadvertently replace altinstructions in the booted
> kernel with their parainstruction counterparts when using
> livepatch/kpatch.
> 
> To fix this, re-order the processing in module_finalize, so that we do
> things in this order:
> 
>  1. apply_paravirt
>  2. apply_retpolines
>  3. apply_alternatives
>  4. alternatives_smp_module_add
> 
> This is the same ordering that is used at boot time in
> alternative_instructions.
> 
> Fixes: 4e6292114c74 ("x86/paravirt: Add new features for paravirt patching")
> Signed-off-by: Alex Thorlton <alex.thorlton@oracle.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Peter previously posted a fix, buried in his IBT series:

  https://lkml.kernel.org/r/20220303112825.068773913@infradead.org

It should probably go ahead and be merged now...

-- 
Josh

