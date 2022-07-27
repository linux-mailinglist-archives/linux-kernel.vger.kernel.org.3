Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AD58341A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 22:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiG0UcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiG0UcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 16:32:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8F54AC9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:32:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so123557pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kjP70k9t0KxDR7jt1AysqjuIaIYJ8FiZnNeTsn+rTAg=;
        b=Z7JaTh2SQlfgpSPA/Q0kUcjq/MQmhJcgBlhsTFZiT2WqUSA+YdovEK4ZLpv2i1+Jzi
         +BL96aly3eCJnRv6rw/T0POK2FweB9Po/Z4mJymG8ie8nNw5r+L5vNX7+B3lu4nraq1E
         +5hEevqPSvjzXY7kVIBaHPWFGApqnY8Yg/T84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kjP70k9t0KxDR7jt1AysqjuIaIYJ8FiZnNeTsn+rTAg=;
        b=6SowMzKdxlcj0/btjeJ9EI0rb9gNA6JWbdrmq72Ra+3MXsX47Tut04FZuD/3qOBxp5
         peNpGeeF6+fQsDA2laI/QbpYW6WdDDczYNk8KcXHqrQDOwr3GUHOPTWwW4n7APxjG+7c
         mj6HPWBC5oJdecRVRPJgJP7jG+PKxqRWcA0RQearmxS0BZdGQWgPdDFfqLBEPy3iCH5S
         OZsL3jVAAnGpgAl+HyakW5KTlDjfxB6xTH/ibgpOmiFker5IbDBLH9avT57zr4ptVvyg
         LKezjAoUgDGsBDOxP2kM66jzzsaxQ8Erad0/tcQKhUns04cx8+8314ahGdmXlxtnxUQQ
         tjng==
X-Gm-Message-State: AJIora9Rg2DQVS0WN3YXsmYflLNDkuA+bENuXND08bfknH9LsxiCACGl
        95DPOxczvFZUTjd4RC5UStBYnA==
X-Google-Smtp-Source: AGRyM1tL3ybzMjXRYP58mGjg0YjcwPF5GkdKSrAUy9bCPWExiEBUk+yEn/bOnOESs02lr8ZGX2hB8A==
X-Received: by 2002:a17:903:11cc:b0:168:eae:da4a with SMTP id q12-20020a17090311cc00b001680eaeda4amr23356939plh.21.1658953931435;
        Wed, 27 Jul 2022 13:32:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13-20020a65684d000000b00419cde333eesm12401728pgt.64.2022.07.27.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 13:32:10 -0700 (PDT)
Date:   Wed, 27 Jul 2022 13:32:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next v3 2/2] powerpc: add support for syscall stack
 randomization
Message-ID: <202207271331.B227002C@keescook>
References: <20220701082435.126596-1-xiujianfeng@huawei.com>
 <20220701082435.126596-3-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701082435.126596-3-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 04:24:35PM +0800, Xiu Jianfeng wrote:
> Add support for adding a random offset to the stack while handling
> syscalls. This patch uses mftb() instead of get_random_int() for better
> performance.
> 
> In order to avoid unconditional stack canaries on syscall entry (due to
> the use of alloca()), also disable stack protector to avoid triggering
> needless checks and slowing down the entry path. As there is no general
> way to control stack protector coverage with a function attribute, this
> must be disabled at the compilation unit level.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
