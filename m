Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC550A648
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382861AbiDUQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiDUQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:56:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37A49930;
        Thu, 21 Apr 2022 09:53:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a15so5512726pfv.11;
        Thu, 21 Apr 2022 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PlsYbqQmf2Zsys0Fm1nEB5XbzF76fQveH/UoQhbEwwk=;
        b=gmeYuuM+qQf6VJ+nLapBtr0AmigVa0jZQHl0e/FBjYitnsCfTmGPdMvldE7qtaY5w2
         maPVqqD4saMVXYO0WiwShFnlnv4imjxiUfdPBY8pxTZzlrjQzTCx8rMHHRA+Q5JhQuTV
         TJsDfXKm0MK4pQO//phfN+UXs0Ea3ENoyQLt0BSFyMEC1YF8DS6K8Ln2edhmFetOlOBf
         h3zQR3HfitsoQLhcZJMzypNfatL+8CsXcaOBDQoeE4JvqZhQUTpEwzkROv8gaS+tNPhB
         FaA487P6t3ozSOZZ98u45EhArSf0dF3HI54oWZ897QbZz9FAfL/1VtmxlXOKCbTNZVXN
         cgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PlsYbqQmf2Zsys0Fm1nEB5XbzF76fQveH/UoQhbEwwk=;
        b=cbfwNk+KxXBsKtRyggkkeeVnjRWrQoyXlovfmRXK/ipQ5mt6rMkw/r2hmejQNIOGiZ
         t1PXCEc6UzKgp1fud1FvPkwmfUSssLjIZR5JDn+uQBn8w8pS6VJ0ENbH2m+B17owYmVk
         HHPqMi/tl9KDxSPiiSQZUhwRcEE9ZrKaJ+hmYxtaltu9dqoxEZncxaxF4Y+bq8gvZwcZ
         bx8KGBqpVT/Z3ViK9pWncAOSPyBLgEriA7sfCUAweF/W4DNo8IzWbxmHogUq9+X7l06x
         Jx1zj7J9qz1M0/wfjXn6SvigmAQG6PBSvKMl5sBgim/SGBBZMFhs1Lubht0obYXEK7aC
         mbjA==
X-Gm-Message-State: AOAM531t6DTrHaxKHsTHgKvI9MbdXtzYOkLB9+mejn4JCgexsoLgYGKf
        p3mbZs0w2Lf0GnF1SOyAIek=
X-Google-Smtp-Source: ABdhPJwOWadoG5Yuz0OW3JOA91GG7ddvLLPxagS1bTXiU32a7NvWAsv9jA+IPFlspkEI24sq/aOA/Q==
X-Received: by 2002:a65:6216:0:b0:39d:5e6c:7578 with SMTP id d22-20020a656216000000b0039d5e6c7578mr328653pgv.114.1650560017228;
        Thu, 21 Apr 2022 09:53:37 -0700 (PDT)
Received: from localhost (c-107-3-154-88.hsd1.ca.comcast.net. [107.3.154.88])
        by smtp.gmail.com with ESMTPSA id p1-20020a056a000a0100b0050ac9c31b7esm7974515pfh.180.2022.04.21.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:53:36 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:53:31 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
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
Message-ID: <20220421165331.GA1451512@private.email.ne.jp>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b209ee09b74394ab7aed85e0244e2191ee3d4171.camel@intel.com>
 <e0e2e399-2cac-cf75-2a64-9d017e6d7189@linux.intel.com>
 <420a4d689f73f9f7dc1ef71c61da75b7c9777a3f.camel@intel.com>
 <1e184b44-8024-b8ae-98a8-cf2b6f78df61@linux.intel.com>
 <20220421065707.GA1423762@private.email.ne.jp>
 <a2c2b7f5-0af0-18a3-062b-c6c9f78daaad@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c2b7f5-0af0-18a3-062b-c6c9f78daaad@linux.intel.com>
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

On Thu, Apr 21, 2022 at 07:53:39AM -0700,
Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> On 4/20/22 11:57 PM, Isaku Yamahata wrote:
> > On Wed, Apr 20, 2022 at 07:42:06PM -0700,
> > Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > 
> >    TDG.VP.VMCALL<GetQuote> API allows one TD to issue multiple requests. It's
> >    implementation specific that how many concurrent requests are allowed. The TD
> >    should be able to handle TDG.VP.VMCALL_RETRY if it chooses to issue multiple
> >    requests simultaneously
> 
> Do you know why we should handle VMCALL_RETRY case? IIUC, as per
> above spec, if each request we send uses different GPA buffer, then we
> should not even worry about checking for IN_FLIGHT status. right?

Not correct.  User space  VMM, e.g. qemu, may return RETRY error for various
reasons even if different GPAs are used or even if only single request is issued
at the same time.  Other user space VMM (there are severals alternatives to qemu)
would support TDX in future. They would choose different way to implement.


Attestation driver should check IN_FLIGHT always before processing shared GPA.
Interrupt notifies only that it needs attention from attestation driver.  It
doesn't guarantee that IN_FLIGHT is cleared. Interrupt indicates only that the
state may be changed.  It may not be changed.  VMM inject the iterrupt
spuriously.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
