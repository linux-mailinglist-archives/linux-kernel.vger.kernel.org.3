Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1E4C9A11
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiCBAsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 19:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbiCBAsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 19:48:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A310FE7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:47:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so355722pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x9QK2yVKnHXX9jQ390KTQ2jtnuQQLQpf+Jo2tSG+1rU=;
        b=K0w3rmENKCFKu/kVw1y4oxTkcApN/P/9sr5+yrue16Serc2l/M80n7D1Ab67znYt03
         evBC76oc18NVyOSdwcqBLbwG8MIcA49FhAkY1cr5vkoyIc/7/XaVuMu3KzGBBEoYUeb+
         ujGaHlK3mH3whXfpwJK0gpohpnNNHsZi0afT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x9QK2yVKnHXX9jQ390KTQ2jtnuQQLQpf+Jo2tSG+1rU=;
        b=vms/S9L48K+qZ0qRo608AScMlR7+fE5wchFXv+QKvWiLQamZ//mjNjyWcOX++Jtrej
         bpx+SmJQPj0qASuCl6Gbg/F4Co0xWTECBmftdlN0PujQmun6bD0b+AB/1w9uw+pc8ZbS
         yp1ddFfgl5IsdcLxAQgSXVuBBV07QHwlk9MNEKVDSK8++Vvnktq0qsuLiMmoZOTk4wXn
         0ofGEz+CD/FN6DM3BWW+jnoZ0+6/YOZnZ2Z0PGYwofiF+oMyTxotIPDXmyJqoBB5Jufb
         eVKlHHbPAqcirr4K/WHy6n2/b66UUx7/IQ8BiwA6JMd5OqD8V4c85iQpQjX8F1BJjI0s
         /FYQ==
X-Gm-Message-State: AOAM533bPu2cmNdMnfhXbjf8L3I7b3XQOjf9jl2gJSeyXyPJH14h6+l1
        unKhx0IjCOKL5oqH4oNvpvgPqQ==
X-Google-Smtp-Source: ABdhPJxN9OybXwbR6J2xnYQbzU8Z7LLJ9f6kivzrXjabM59c+Pu/2v40Zu70D1kM9yKuB6f+pyWVPQ==
X-Received: by 2002:a17:903:1c1:b0:14f:dad3:e7dd with SMTP id e1-20020a17090301c100b0014fdad3e7ddmr27754507plh.130.1646182057252;
        Tue, 01 Mar 2022 16:47:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h12-20020a056a00218c00b004c3a2450acasm19634414pfi.147.2022.03.01.16.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:47:36 -0800 (PST)
Date:   Tue, 1 Mar 2022 16:47:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 01/39] kbuild: Fix clang build
Message-ID: <202203011636.40D2F83@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.072632223@infradead.org>
 <CAKwvOdkD2WY=hEHy8_0zs70AGx6LRQwxL5mEZyB30uqpruYJyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkD2WY=hEHy8_0zs70AGx6LRQwxL5mEZyB30uqpruYJyA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 01:16:04PM -0800, Nick Desaulniers wrote:
> Also, Kees mentions this is an issue for testing multiple different
> versions of gcc, too.  There perhaps is a way to simplify the builds
> for BOTH toolchains; i.e. a yet-to-be-created shared variable denoting
> the suffix for binaries?  The primary pain point seems to be Debian's
> suffixing scheme; it will suffix GCC, clang, and lld, but not GNU
> binutils IIUC.

Right. Though I think auto-detection still makes sense.

If I do:

	make CC=clang-12 LLVM=1

it'd be nice if it also used ld.lld-12.

> [...]
> Just curious, what prefixes have you observed in the wild?

For me, where ever I built clang, and "/usr/bin"

-- 
Kees Cook
