Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAE94AEA32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiBIGTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:19:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiBIGSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:18:46 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE452E019272
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 22:18:49 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id fh9so1075575qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 22:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=exMN9hAxxiEMO/FaVJ75eo6ul4DNqSXK6//YgwXm8Cg=;
        b=Y8EwLL3ReHFFxYhkjKqf4k1GMObv3YS1AIi7mcPmn1aeZWILKvQihJZSxiw8+kMsT7
         NZLhgQWAhAu77XF+6vKVLxMPNtShJ10yHD1zrDtEJf3adtEU0uFPHxtXj1M7LTTwySx9
         lLYZmdBMURpuQ7lR0E2RDkJk2gCP9qYsT+IiBKiD19irs/yZcri9Evk4F+j3Iu6YSNkW
         jPjhBA+yldYWTVv1eg0iAwCBCL+bvtBbl+Q4MXD8wEknDE5uKBxMX6VjUBRo9lh0PlCt
         LufTfHwzGPx4u+UM6QF05J8WoxLrnzsXGlgHAIKJ/QV8ThDJA+elDArDnwxTF4dOsuRO
         93/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=exMN9hAxxiEMO/FaVJ75eo6ul4DNqSXK6//YgwXm8Cg=;
        b=3yvypb1LqczrZeoxz/y8OAkSFhAn20ZQ0K50Mz1stHk0xKsE9/vgLBAHLf6vV6pI/b
         rZZ24+xWuXwl2bN7xLGjvLeeauS6Gz4vPd+HRrBR82QhyIr/YpLX9LAcoDvsSnEvLikZ
         s2GdzcBvo9tGQPAOWhC4a/BkBF33CnqtUDXhVEJIwZ3F4I4j2ce8fUrjtXe9KA+7VXBJ
         Xxqe44H23mZfEJF4UbKNyylJEW4xFLfqhbgJVW7fWuPg2eAABSGpT5HtU7yKeSauwzfl
         hd/PhrZSFos8Ny0Mx+0mxGnem+KHP7Oeuw3/ulqFl+G40+u7xM3krCIzmgYh5o6dmh9R
         GILA==
X-Gm-Message-State: AOAM5317ozQvFGls+hUoT2m3ZU/WbG81eA2wHHCZegHvRZvUfTeoy8bN
        tndvhrUpjotFs4AuVZ9O5Zzcbc7Ar0xQqg==
X-Google-Smtp-Source: ABdhPJwyqQQ6p2MsIgY2z1xP9Am295gOZq/0gFQqRfcChOUsog8I9H/6d0YUrgjQyeLH7dGfSlFCQg==
X-Received: by 2002:a05:6214:20ca:: with SMTP id 10mr519601qve.96.1644387511409;
        Tue, 08 Feb 2022 22:18:31 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n19sm8339013qkp.52.2022.02.08.22.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:18:30 -0800 (PST)
Date:   Tue, 8 Feb 2022 22:18:28 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Borislav Petkov <bp@alien8.de>
cc:     Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: should clear_user() have alternatives?
In-Reply-To: <YgJnhB+bAxoNsiSB@zn.tnic>
Message-ID: <9d3b36e9-f752-22bd-4ea3-cf169fa26e9b@google.com>
References: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com> <YgJnhB+bAxoNsiSB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022, Borislav Petkov wrote:
> Hi Hugh,
> 
> On Mon, Feb 07, 2022 at 09:45:36PM -0800, Hugh Dickins wrote:
> > I realize that dd'ing from /dev/zero to /dev/null, and sparse files on
> > tmpfs, are not prime candidates for optimization; and I've no idea how
> > much clear_user() normally gets used for long clears.
> 
> Right, we usually don't take such "optimizations" because the folks who
> send them always come up with either microbenchmarks or only test on a
> single machine.
> 
> > If I were capable of compiler asm, with alternatives, and knew at what
> > length ERMS becomes advantageous when clearing, I would be sending you
> > a proper patch.  As it is, I'm hoping to tempt someone else to do the
> > work!  Or reject it as too niche to bother with.
> 
> Yap, looking at arch/x86/lib/clear_page_64.S - that's straight-forward
> asm without special-cases noodles like __copy_user_nocache, for example,
> so I wouldn't be opposed to someone
> 
>  - remodelling it so that you can have clear_user* variants there too,
>  with the length supplied so that you can call a common function with
>  arbitrary length and clear_page* can call it too. And then call them in
>  a clear_user() version just like the clear_page() one which selects the
>  proper target based on CPU feature flags.
> 
>  - testing this on bunch of modern machines with, say, a kernel build or
>  some sensible benchmark so that we at least have some coverage
> 
> If the numbers are worth it - and judging by your quick testing above
> they should be - then I don't mind taking that at all.
> 
> If only someone would have the time and diligence to do it properly...

Thanks a lot for setting out what's needed.  Remodelling so there can be
commonality, that's attractive and intriguing.  But I'm disqualified in
several ways (if we tactfully leave out questions of my competence, I'm
still lacking time, and wide machine pool, and expertise with latter):
so I'm responding mainly to make it clear that I shall not be pursuing
this, but hope somebody can eventually.

Thanks,
Hugh

> 
> :-)
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
