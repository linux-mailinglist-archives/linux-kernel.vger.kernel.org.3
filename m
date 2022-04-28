Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83560513AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiD1RMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiD1RMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:12:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B7D5EBE3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:09:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so4481610pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zAaIEbwPamypkTPPw9fvYDfeYISE2JHP1U6M9ZYpWS4=;
        b=AJjXNowARSEkx2jJDk8SuGP51D/AHwAgr8y01TzHn4fMbcil8Pk8LVcjkgOqQmxd7e
         VwtD3eB9k74BnjLhkr5X1xGFvZcAOnQ1rjnnohYaQko9uvStcEBCb11SK/xkI+SIIQyV
         3G1aUOHl5525pCxsHhUDLU3xdfvbB1K0cpoq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zAaIEbwPamypkTPPw9fvYDfeYISE2JHP1U6M9ZYpWS4=;
        b=tL6uqLxL+e1MvtLdVSLsX2tCnSl86g3piiWvoucR7H4vXAupW8q8nvI73Ml6MIdpYv
         4qB2QabGA4uHmejbX9Zn4tEfoZ97pYpXFTbIwtfnarCkRiYtwddFdP0ZfUBaTDfjw0zY
         p4hHCNF+9TSHwHxF0HRv1mXAUTEaC43vP2rmvbBHKOsMYrIfaeKaVTT6Y3gE7ilj3u4q
         neTjI5uc2GkEBn/JGvGzyenr2NpM9UNHXckmabvVXhOoOyQseJHYMwZGCz7IxbGWOCJG
         heWw3IhPnjifPB4reuBt/HEU1eh64B22VNpPf2qljOcJBOx0GG0G0gFSqb8SdsiH1SRL
         +Jjw==
X-Gm-Message-State: AOAM530kZub2mYUF+MbhFYFfsyR0GlB7O1/ZMM0WoGRLiPrnCLFkj+pU
        TbD+fFNo3Di2/rIDHktDAnBPtQ==
X-Google-Smtp-Source: ABdhPJzYCTkPb/uB5mvHB8Vok2sDusM/OE4zDxiqLzhXiYZyQjZXFkxX8EJQmTdBlmjp/KspQTmSCQ==
X-Received: by 2002:a63:8749:0:b0:3ab:2603:c80d with SMTP id i70-20020a638749000000b003ab2603c80dmr19023340pge.412.1651165745673;
        Thu, 28 Apr 2022 10:09:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j5-20020a654d45000000b003c14af50621sm3248047pgt.57.2022.04.28.10.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:09:05 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:09:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Luis Machado <luis.machado@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Subject: Re: [PATCH] elf: Fix the arm64 MTE ELF segment name and value
Message-ID: <202204281009.57198AEC9@keescook>
References: <20220425151833.2603830-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425151833.2603830-1-catalin.marinas@arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:18:33PM +0100, Catalin Marinas wrote:
> Unfortunately, the name/value choice for the MTE ELF segment type
> (PT_ARM_MEMTAG_MTE) was pretty poor: LOPROC+1 is already in use by
> PT_AARCH64_UNWIND, as defined in the AArch64 ELF ABI
> (https://github.com/ARM-software/abi-aa/blob/main/aaelf64/aaelf64.rst).
> 
> Update the ELF segment type value to LOPROC+2 and also change the define
> to PT_AARCH64_MEMTAG_MTE to match the AArch64 ELF ABI namespace. The
> AArch64 ELF ABI document is updating accordingly (segment type not
> previously mentioned in the document).
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
