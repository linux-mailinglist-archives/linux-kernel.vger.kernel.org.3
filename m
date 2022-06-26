Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD055B3FD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiFZUGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiFZUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:06:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7275FA1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:06:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k20so5707438qkj.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZgLetThySYV51Aytz6mh0N038I4xXTGk9aBFCM9zRec=;
        b=a2Yt5gzzM3yzj5vSUuIuvXaPNDCciwPVd7rzWq4cowkgBqcx+0pxMCgMZCVbN+25eN
         Ony8G9mj9cbyeEOSU5Me4xp2a17SHxR5i1r5/mmdtI6HyBXGax89T3xQf7UNNHdJRpfc
         J6YqrilbDb8wGPvT7Hb6VNr0P0ByVQgFF+OLRvsF4c2C/c6TEnY2IAPnFPnrPH5ly5fN
         MuXffAihwZOCAxMzFwCNm1snokHyBLhzOoGZCJABPNud0Cju1PpHaHNMXEe2iCiiIDgA
         pjh2RNHChebcQ6ZmAF+5zNHcKVVkpYI9/dVr7PnKms80UqujZdm0vmBr03b9x1qVLnKA
         nnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZgLetThySYV51Aytz6mh0N038I4xXTGk9aBFCM9zRec=;
        b=xyU/Ar1fIVu394MJWgaqUk8cpmSMhbygLTyUfbfArmDYwxN9bUHignZDztWSoDebX0
         b0L763ZbleaOGA4MluJXOGu3UOPFuFFmn1Ilu+/n/o8jnmJRGORrg1ond6GATzVOMnvg
         ndhMyhLggZfu4DuEXypZC9FMA9m67MX/zidkvAg5JAuOPLI4H04Qy5GbPIKh4Rp4VhOT
         d8SZTxNO4lslQHuoso/F0y5WAArttQrIc3ZlFcsWtkRsfwxfzFdztvERgoFfT99EiCQy
         mFGCSxdEy+S80CIyzlMI5t8Q6ULmF1dKH1iQ07/Z/F3WOSi8wV/DCYGiS7/wWgGSVmRn
         bgvg==
X-Gm-Message-State: AJIora+Ut6zZZl0iAbhVaD/hK6kDO01V6UTsp6DJwBsnVceOgC6W8fck
        ATiaIvV/9151ux4gSGdk+w==
X-Google-Smtp-Source: AGRyM1sAJAR5/R/iEM96/kcnjIvfe6WWzgqnDoiUADllWujM4vzLfnQXAoshQW44CQdMxAIiWW0sxA==
X-Received: by 2002:a05:620a:12f8:b0:6af:25af:f169 with SMTP id f24-20020a05620a12f800b006af25aff169mr1733612qkl.541.1656273980907;
        Sun, 26 Jun 2022 13:06:20 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a280100b006a71c420460sm7540956qkp.22.2022.06.26.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 13:06:19 -0700 (PDT)
Date:   Sun, 26 Jun 2022 16:06:18 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC[ Alloc in vsprintf
Message-ID: <20220626200618.jhxu5lg4w7o2irhr@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
 <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
 <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
 <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
 <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
 <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 12:53:26PM -0700, Joe Perches wrote:
> In a reply to the printbufs thread, I wrote a proposal to use an
> alloc to reduce stack in vsprintf when CONFIG_KALLSYMS is enabled.
> 
> No one has replied to this but I think it's somewhat sensible.
> 
> Thoughts?

As functions get converted to printbufs the separate stack allocated buffers
become unnecessary, because printbufs have helpers that do bounds checking and
make outputting to the vsprintf buffer painless. So it's not necessary - I
haven't fully converted symbol_string() yet but I'll do so by the time I mail
out the next round of patches.
