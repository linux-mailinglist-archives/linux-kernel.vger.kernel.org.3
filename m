Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A67A537B42
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiE3NUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiE3NU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:20:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C4854FAF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:20:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so2319801wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v416vfIifwCIkTDjpsP/VkocnsSk01+ZXlHbFCcg8UI=;
        b=I68VBnJI5ybjZ67rLn0fDjZ8jmyjcfuY1RwvZjyuRyDzEl8aQqhBV63MakhInRYYjX
         jxaKDtq6S8c6/SjpGlgKtuJe1rzg6GjICARIHSPxmxXv+Hm4c5vehkLMWsdv82cq60nt
         bcBo9K3oh6l2L4MHJU7kG9Xe4XqbLyuXjEHpGBSU/heEVf1COSTF6vbD4svxbi+GKSDX
         +SsZI7MfT9C/RRAJCH2m8zbQLDsLeMUt02U9dXFXEIbw9Nn+Nb2Lhd/7peRaBXDEchIW
         Qkp0ZYq+zPxLfInkfWJyzqiX+W14qvUHY5qUtt/cRqtXHTQ0gFdxaUf+U87LQtZkR0sI
         DMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v416vfIifwCIkTDjpsP/VkocnsSk01+ZXlHbFCcg8UI=;
        b=Iaj4IrlX3nIog+jni77rB8Rg7iAU2CcF44rPTIw0M6VWr9w02nNoJ69HYq7BkZsSWW
         t38cOAw2Cl2/LB0gyFhGemaCkHb+2dePUbIM7q2nJ840mCqomg+C1/VRhuqdMVK4T63m
         is5xwWRIqGYUv1+5M26HBaoLvA3QaVm6rlVUfLIZ53+g4dMTpQykejLgzO1vNXZ9uH2j
         QlEbMu+ru6c8r3/dSsQ8L4TPok52HOS0omod6En6ej7PiuuCxup7CFn8PnqM4VuxMkLV
         bkJI6cxY2FBx2TijDZLjpHiHokIGEkFFyAOmQoWnYFjhkYG37qzmP6FtwEEL1mbX1XPL
         u3bQ==
X-Gm-Message-State: AOAM533rsvtn2HAboYwtvFNiMNmw7CjR4A2MUM0q0b4N6ZsVR+aKqbI6
        iQgNR8WNNJsKx5c16kVHwni86Q==
X-Google-Smtp-Source: ABdhPJzMxqUdyKXfmzJXrbLtF7q+umwNnlBLC/hMkmUNk62cZLVIjqQ86gwmvFIoTlYigSMa+caYoQ==
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id m17-20020a7bcb91000000b0039732250244mr19111386wmi.68.1653916822737;
        Mon, 30 May 2022 06:20:22 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:c918:d0ea:5b07:e1c3])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b0039736892653sm10350141wmr.27.2022.05.30.06.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:20:22 -0700 (PDT)
Date:   Mon, 30 May 2022 15:20:15 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        mark.rutland@arm.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 5/7] jump_label,noinstr: Avoid instrumentation for
 JUMP_LABEL=n builds
Message-ID: <YpTEj3U8631cUJ1o@elver.google.com>
References: <20220526105252.440440893@infradead.org>
 <20220526105958.007232892@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526105958.007232892@infradead.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
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

On Thu, May 26, 2022 at 12:52PM +0200, Peter Zijlstra wrote:
> When building x86_64 with JUMP_LABEL=n it's possible for
> instrumentation to sneak into noinstr:
> 
> vmlinux.o: warning: objtool: exit_to_user_mode+0x14: call to static_key_count.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x2d: call to static_key_count.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section
> 
> Switch to arch_ prefixed atomic to avoid the explicit instrumentation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Marco Elver <elver@google.com>

> ---
>  include/linux/jump_label.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -256,9 +256,9 @@ extern void static_key_disable_cpuslocke
>  #include <linux/atomic.h>
>  #include <linux/bug.h>
>  
> -static inline int static_key_count(struct static_key *key)
> +static __always_inline int static_key_count(struct static_key *key)
>  {
> -	return atomic_read(&key->enabled);
> +	return arch_atomic_read(&key->enabled);
>  }
>  
>  static __always_inline void jump_label_init(void)
> 
> 
