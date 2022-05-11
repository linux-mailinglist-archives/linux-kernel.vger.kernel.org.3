Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18586523C35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbiEKSFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiEKSE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:04:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91543B36F3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:04:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id bo5so2655968pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5mKxMRQlQWPwu4mRllmx6ShZNHltflA3/hsURvdMH9A=;
        b=JzVH0E99WgNhNFtMfddusYX9t0PPvm7mYKeZDoS8KfHQDtCr1maZaOZ5krlAKZPJj/
         kSW4plzUCRDHuBBSuGeuHXr5pNILn1GReHmBdfnA/5z52hs8xsQzrNoaHGtSV7hNJTQA
         0ENT+HjHkqcKTTG9DCNwsmW7oYcqPsEGF7CgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5mKxMRQlQWPwu4mRllmx6ShZNHltflA3/hsURvdMH9A=;
        b=VRynZTwrFaIGhkHHzhN3A65F9C8OSwnRcg8Pv7/GChxlH9000mRamIFhPyjq5Mqal5
         FleAan45ODH9O8j34k2ABRdtlGZjaGbfN0YwOQ5vaXIfQe6s5CLQXMZmuC6tGwL8cVxn
         5iaqm6ohVXwkLbzFP+f4jeWEay8dTgkEDLkCkG0/2PC+UY10rVRPbO1XSyOq+Eyxp+tP
         Hm1n5o2c9w1luVHKdXeqBQ/V8IL0mcTM0DQE5gGm4/V6mOdN5TVMX8PX/H61yU7AebTg
         RIBTqa+JJIWk7LTLk1CxmUCvfN7Fa3puEQoZZlLo/pvx9OwM3puzdFT4ZiUEdQmH6j5Y
         NPBw==
X-Gm-Message-State: AOAM530ZpODjXlVxAABmRhj5BHEd9a7mI5UXglZcfKOZAe7ykWnQpu9w
        x3RWEezdvZzbmrNaFbEwoAy5O+f2iBvRiw==
X-Google-Smtp-Source: ABdhPJyPos/XQ6ildWdXQ1gBpyfJs9fGclLfzv5zJqzYDzl9/thflZeTxuO7AI0vh5ZVkV1EYH8wuQ==
X-Received: by 2002:a05:6a00:140c:b0:4e1:530c:edc0 with SMTP id l12-20020a056a00140c00b004e1530cedc0mr26275217pfu.18.1652292296092;
        Wed, 11 May 2022 11:04:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b0015e8d4eb296sm2149525plk.224.2022.05.11.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:04:55 -0700 (PDT)
Date:   Wed, 11 May 2022 11:04:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
Message-ID: <202205111104.464A6619@keescook>
References: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:38:53AM -0700, Andy Lutomirski wrote:
> CONFIG_LEGACY_VSYSCALL_EMULATE is, as far as I know, only needed for the
> combined use of exotic and outdated debugging mechanisms with outdated
> binaries.  At this point, no one should be using it.  We would like to
> implement dynamic switching of vsyscalls, but this is much more
> complicated to support in EMULATE mode than XONLY mode.
> 
> So let's force all the distros off of EMULATE mode.  If anyone actually
> needs it, they can set vsyscall=emulate, and we can then get away with
> refusing to support newer security models if that option is set.
> 
> Cc: x86@kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Sounds legit! Can we switch the default to "none" while we're at it?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
