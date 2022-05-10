Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD2522333
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbiEJSAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348456AbiEJR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:59:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D04B3B2AB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:55:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g8so15549595pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s6/hlByeT2qmMcSxzfXgIlnA/5v0PpA7ktjUjtSdcsI=;
        b=aesSQdGKVCRotEKRLgAN5vZm7PP66O/KRKf1qd1pt0+deUe85RVj6YXR+/nEmJpcEU
         Smj/ah2Wvd0WbyZ44XzXnCT1crYJuZpH66YuvmPn17FtALgRhVRBJqA0BTS8+LhU2eXG
         GXcEiJb5kpq+xx9vE1TaXsAQkaSYyjm3/w1ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s6/hlByeT2qmMcSxzfXgIlnA/5v0PpA7ktjUjtSdcsI=;
        b=cfudO9djLV2v3QwOlziHCNFL6Cg3BpWdA/IVBHYTo+uRuL5U63sH8yWz9VJrLB/iDk
         xPIYJ3VmLos/IAqBxkhiKB83mtdlWVlwxfGtPFaKdXfWSe0GJCVIK7iQ6u7nGG7g3XC+
         vWQuZlSl0kPMb4QiK/KHmLeCIi+ZxQvSV7Tp4Ye86Bk7u73Y0xRoxA2OcqWf94PwilpK
         m/B+cAHm2+PswvGBMNsq3yZFrDETgQTysWqx3rpd7CuWzthJXhGb+223f+vzBScjFg4K
         ctkJQEEaKw0PPuMVq9itmHvldyrMtMub4OhpQqqztjXs9/kA0ll1UDfA2vMx1qyD+K0u
         KfkQ==
X-Gm-Message-State: AOAM533TjOXpeGqAuTCZBfJRV0+oI0Fe3wbneFOG8/bstHXZQfe034Vs
        cFy41Wgi5Qxz4gAzjIppZtmsTQ==
X-Google-Smtp-Source: ABdhPJyim9d8DrEoKjYAbIwvDlhB/YeC8sxVLzUKhX0/QuntXvui94aB188iHyhn73ZvXnr/W/RxaQ==
X-Received: by 2002:a65:6e47:0:b0:3c6:7d47:ddc8 with SMTP id be7-20020a656e47000000b003c67d47ddc8mr13062956pgb.157.1652205358327;
        Tue, 10 May 2022 10:55:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c80-20020a621c53000000b0050dc7628132sm11274436pfc.12.2022.05.10.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:55:58 -0700 (PDT)
Date:   Tue, 10 May 2022 10:55:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bob Peterson <rpeterso@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Bill Wendling <morbo@google.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gfs2: Use container_of() for gfs2_glock(aspace)
Message-ID: <202205101055.171D1A88@keescook>
References: <20220508100630.2642320-1-keescook@chromium.org>
 <YnoQmuPgK9c5V8ZC@infradead.org>
 <CAHc6FU5VfS9yNe0yH_sfOt04rvii6T_NMq7kp+32HZa5XQDtEA@mail.gmail.com>
 <202205100851.663310B@keescook>
 <CAHc6FU4hRBHUJOCF33z=dzOJszYCpiZ=wikdyXZ1u25hGQ00ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4hRBHUJOCF33z=dzOJszYCpiZ=wikdyXZ1u25hGQ00ng@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 06:16:30PM +0200, Andreas Gruenbacher wrote:
> Kees,
> 
> On Tue, May 10, 2022 at 5:51 PM Kees Cook <keescook@chromium.org> wrote:
> > Thanks! So I should leave this with you to arrange, or should I send an
> > updated patch?
> 
> are you happy with this?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=833ab609b94f6
> 

Sure; looks great! You should credit yourself with the code changes,
maybe, with:

Co-developed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks!

-- 
Kees Cook
