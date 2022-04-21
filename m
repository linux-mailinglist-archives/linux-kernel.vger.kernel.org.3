Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42703509882
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385546AbiDUHHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385571AbiDUHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:07:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE4D15704;
        Thu, 21 Apr 2022 00:04:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso4336968pjj.2;
        Thu, 21 Apr 2022 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ckZb8HQa6B+H6t9pofeOOWMFEAGtcGaN614SCDhVQYA=;
        b=SHDfVa3FMmxgIMWcn+Q/V5BXKCMqc6gupBa491JtUf1YiJXt+jMBITI1+IndLPAiIv
         qD3FcIJbcu4Z7orWyaJDi7S/qhIErBQTYGkWKwxUlUJ2vMf+DsGzkb0kk9s3xYo/3k0Q
         q/9kDDn1jaPKUZneasma7uFV0PCTz3gm6cl0XD7cUOAbhJilfDoai2do+GjxN34nx897
         W2ff5yPbIFfPf8l1ovxQlBqjo0jBNRi8Lu65nc+tYdDHkL6ab8PVF4pkwqLl8bIoBbkB
         6l5CxHzI/LentyJLL/pPGx8po3avHC9IScIBKDV/A1u12xhU8rFhiCHPGCJf/meaz7yd
         7d9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ckZb8HQa6B+H6t9pofeOOWMFEAGtcGaN614SCDhVQYA=;
        b=kF99Lb+uWG+J7oEnYZsZypTaFKqDUvQxFnd0OAKW6DIzpMvzYLIK4srMVyh2Z58BbL
         mCG76lBDu5RqQ13HRLTnSeL4xfkibx0MmYHXD5nahIhBmFIlp5+hZEXW8vI/PSzRKowt
         s8ysI+Z8bhIqY/IqR23bNsvxyKUSNTieirl0dDjD0EU09CfZH8rFKQYmZfyGGHRoY8jO
         VggFSlQd7ke1xvhZ7xTOvG8l/4bp6XewY2l/n6xUPs9RhaWMwYWrmnwIcElj4AsXfRDe
         fuwjbUokzzWbkoF6dDKw0myd3fOpogZZpZO+2M0NeXpCBSEfl42lPxauPNYYpVUlAeFF
         QGBA==
X-Gm-Message-State: AOAM531XkUBWZQOjVRGTLsthYme3InjsrnPIQHJZ7B9VHaIDDXSUQCon
        VBE5VrpghFpTAvq6A6LgWX8=
X-Google-Smtp-Source: ABdhPJwvc2lunSrpC+kueBLFryH5B7Be+qQXCmSIgefygKENy10PWbdlNKjZ/L9Cw3ZyArJ2KKboJg==
X-Received: by 2002:a17:902:8f81:b0:154:be2d:1948 with SMTP id z1-20020a1709028f8100b00154be2d1948mr24109757plo.110.1650524687783;
        Thu, 21 Apr 2022 00:04:47 -0700 (PDT)
Received: from localhost (c-107-3-154-88.hsd1.ca.comcast.net. [107.3.154.88])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm22961885pfx.81.2022.04.21.00.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 00:04:47 -0700 (PDT)
Date:   Thu, 21 Apr 2022 00:04:44 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Message-ID: <20220421070444.GB1423762@private.email.ne.jp>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220420012032.GA2224031@ls.amr.corp.intel.com>
 <dd4a2b16-397e-8866-0fd5-b5c5dfd453ab@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4a2b16-397e-8866-0fd5-b5c5dfd453ab@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 06:26:43PM -0700,
Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> On 4/19/22 6:20 PM, Isaku Yamahata wrote:
> > If timeout occurs, the state of adev->tdquote_buf is unknown.  It's not safe
> > to continue to using adev->tdquote_buf.  VMM would continue to processing
> > getquote request with this buffer.  What if TDX_CMD_GEN_QUOTE is issued again,
> > and tdquote_buf is re-used?
> 
> This part is not clearly discussed in the specification. May be spec
> should define some reasonable timeout and teardown details.
> 
> Regarding not using this buffer again, what happens if we de-allocate
> it on timeout and the host still updates it?

Until GET_QUOTE_IN_FLIGHT is cleared, the shared page is owned by VMM, TD
attestation driver shouldn't reuse/free the pages.

In the case of this driver, I think of two options
- don't timeout. wait for interrupt to arrive and check the shared GPA state.
- allow timeout. When the next request comes, check the shared GPA state.
  If it's still GET_QUOTE_IN_FLIGHT, return EBUSY.

It's possible for VMM to keep the shared GPA forever maliciously(DoS) or
unintentionally due to bug.  TD can't do much about it.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
