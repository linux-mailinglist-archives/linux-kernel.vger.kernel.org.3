Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2EB55A063
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiFXRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiFXRa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:30:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF83DA4C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:30:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so6413047pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v2GOxsdoVsaZXbVgLmusuJ8AUNrNNpTNLGvKGWBrh8o=;
        b=OJsudXwOMYv/+uIFVCAy9ZHd+hLkuAC8DSDK1yeMkLccT+t9CIPMdgpMgi3dNglErN
         vjrXLXCxn0Isb7JwLx6gtRLjX0ue9nCcYi2HxBQfyTL7gzwOzMUurRZnVPzjGGXytiUX
         8QKEfAbE62kS6eIKHPOs4cbXWEQzFVqou8DJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2GOxsdoVsaZXbVgLmusuJ8AUNrNNpTNLGvKGWBrh8o=;
        b=G0h1w7NOTWK0Osz8fE2Z+6FPlE1lSmjS/Kyu9Am8wZZOsKxBTfW0UUnivQj8q8kra2
         NfVOPbFi3ZRaCMgatfDOlhCI4jJ8bEx7qIpJIRqnvhMyvjVXOvZhrGR+W04E1Hrpi7sp
         ArpR5SMnBVc83DTcbNlpkTog+gihFJQSYaiNAMpMXe0kAPB33fBSlycb980HppiJ9mTu
         vwbh2wXy49kHcBOy4gbyI6V8o8AYjB7VMC5Wfitp4JeT9dGxBwzKLeAe1u5Ta23PWko2
         oVTjuRxDxQBFglMZTQhJo8LG68Ym7tYs/144iqfIsAp7UBZoa92zB3pWq8Igci80wfaN
         Bbhg==
X-Gm-Message-State: AJIora9f2G9ltvvS6IRMJpDnn6DpxjW73hmUg8q57rxlmPXD8pnyv/Ai
        G+0TkxrW4QnirlUeEwqS1ms36Q==
X-Google-Smtp-Source: AGRyM1uZTK3A1CVfTWihEZf+BbMTle53u4bICa5k01rPPWkPoK245E6WQSY+2isNcfDoVNY/wnEPtA==
X-Received: by 2002:a17:90b:1b0e:b0:1ec:e2f6:349e with SMTP id nu14-20020a17090b1b0e00b001ece2f6349emr5218674pjb.14.1656091824621;
        Fri, 24 Jun 2022 10:30:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902e40d00b00167838b82e0sm2059425ple.205.2022.06.24.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:30:24 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:30:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>, Jeremy Kerr <jk@ozlabs.org>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 1/9] pstore: Add priv field to pstore_record for
 backend specific use
Message-ID: <202206241029.9C0891C5B6@keescook>
References: <20220624084925.724516-1-ardb@kernel.org>
 <20220624084925.724516-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624084925.724516-2-ardb@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:49:17AM +0200, Ard Biesheuvel wrote:
> The EFI pstore backend will need to store per-record variable name data
> when we switch away from the efivars layer. Add a priv field to struct
> pstore_record, and document it as holding a backend specific pointer
> that is assumed to be a kmalloc()d buffer, and will be kfree()d when the
> entire record is freed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I'm a fan! This is useful, and I'll likely try to use it for some of the
RAM-specific things too. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
