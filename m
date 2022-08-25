Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB75A1744
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbiHYQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240457AbiHYQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:54:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A510065C4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:54:50 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z187so20336635pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jHgwBSTrgHiAxU/RBFDNDKDT4K8SAUGPADCn+HMLpgY=;
        b=grqnPr5zpxtEiKzmpYZQPsPET5ih0x3IXAG0a0+eM/e/YfLuwnGDJSTi84CKByCSYf
         OAO53pUhk+idWp5siVWe583eET6qAjFfmSbw7fFZM71z3O6AeJ+T9B2oPK8y/cyE3LmM
         3BdTne6iZH0FzEWhEWGwrZow7kbWHXT9dTtCVtKpnqNwNQjwFi8b3tQ7G05x+p1S6ztL
         WJf8HUxI6GZuqvqE93CAeRdxO+JXTnGLyMU5QMEsJMU0cy9Bu+AC1TjWB5krCaCIZ/1f
         RxzJ9Aeddgk44LSr1n8T3H2Od1PA04ePFIskSOW4ORc/n4R2vC3NREgTRRcFSPwWJyn0
         mJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jHgwBSTrgHiAxU/RBFDNDKDT4K8SAUGPADCn+HMLpgY=;
        b=vNEjQDE68JjA+ccLg7w02qp8+BgtbdKUGJ7KVx9lQa09UCZG41wRsNsIJEvWR2P9hG
         Tus6zGTYM1ClVjM336Nqls+Y5RqH06BGM9IKbbvuPnue5KpneDaxGa2KQik8mBZhKhz/
         /37SGlGeTms0PVKBQbe6KELMu67p8jJiu4eH+poReSzisZpX4MJAr/F9NznwKZe/XjR8
         R6cT/Fd1/zK5ja5G9hFJwDI4hhFrggvD1x2uBQUf7b58IRH0nvaCQ8V7GG0DN39k6t6L
         /lSp1XCA+zdvYhw4K9cmXv+AjQuplvUOwCpmQp3wnQU3cEemel55h3aBn6eJwKx0D98w
         qhwg==
X-Gm-Message-State: ACgBeo2nRjN6Lu6mSqrAiiGjpKraQswDhcJ1V9DxpfWbP7LyCGAD3ryK
        XCmYpMfop6qFZCP9M06BOd1UJw==
X-Google-Smtp-Source: AA6agR7hess7Xrx2ct1ACh0tL94szQxmcRkXu10I5OiNl/7yixN+gPNvVAysdUaFdDoY85mn3SEfUA==
X-Received: by 2002:a05:6a00:27a0:b0:52f:8766:82ec with SMTP id bd32-20020a056a0027a000b0052f876682ecmr5297pfb.17.1661446490145;
        Thu, 25 Aug 2022 09:54:50 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a0b9000b001f326ead012sm3836956pjr.37.2022.08.25.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:54:49 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:54:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] coresight: Simplify sysfs accessors by using
 csdev_access abstraction
Message-ID: <20220825165447.GA1910926@p14s>
References: <20220725145221.517776-1-james.clark@arm.com>
 <20220725145221.517776-3-james.clark@arm.com>
 <20220822173735.GC1583519@p14s>
 <f6623ca8-227f-9f92-5b7b-5dbb151b0fb1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6623ca8-227f-9f92-5b7b-5dbb151b0fb1@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >>  
> >>  static struct attribute *coresight_tmc_mgmt_attrs[] = {
> >>  	&dev_attr_rsz.attr,
> >> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> >> index 9f445f09fcfe..c1bb93c7c1de 100644
> >> --- a/include/linux/coresight.h
> >> +++ b/include/linux/coresight.h
> >> @@ -372,6 +372,24 @@ static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
> >>  	return csa->read(offset, true, false);
> >>  }
> >>  
> >> +static inline u64 csdev_access_relaxed_read_pair(struct csdev_access *csa,
> >> +						 u32 lo_offset, u32 hi_offset)
> > 
> > Parameters lo_offset and hi_offset are s32 in coresight_read_reg_pair()...
> 
> Hi Mathieu,
> 
> I probably should have mentioned this in the commit message. You're
> right that the previous version used signed values, but the csdev
> accessors in include/linux/coresight.h all use u32 and I had to add a
> new one in there for 'csdev_access_relaxed_read_pair()' which would have
> looked very out of place if it was the only one to used signed values.
> 
> Because of this I also changed the 'not set' test for hi_offset from '<
> -1' to '== -1' which would also work with unsigned values. So although
> it looks different, it is still working the same way as before.
> 
> I can think of some possible options to make it better:
> 
>   * Have csdev_access_relaxed_read_pair() be the only csdev_access_
>     function to take signed values

That part is not a big deal for me.

> 
>   * Keep the unsigned type but change the unset value of -1 to be
>     UINT_MAX

I find this counterintuitive and error prone.  And sparse will likely yell
at you profusely.  

> 
>   * Split the accessors into ones that are 64 bit pairs, and ones that
>     are a single read. It's always known when it's defined whether it's
>     a 'pair' or not, so technically this if statement with the 'not set'
>     value isn't actually needed, you just use a different accessor type
> 

That would work.

> I was tempted to do the 3rd one during the refactor, but I wanted to
> keep it more like the original than not. I'm not a fan of the first
> option, I think that would be confusing to read the code and would look
> like a mistake. So I'm more in favour of 2 or 3. What are your thoughts?

Let's meet in the middle and go with option 3.

Thanks,
Mathieu

> 
> > 
> >> +{
> >> +	u64 val;
> >> +
> >> +	if (likely(csa->io_mem)) {
> >> +		val = readl_relaxed(csa->base + lo_offset);
> >> +		val |= (hi_offset == -1) ? 0 :
> >> +		       (u64)readl_relaxed(csa->base + hi_offset) << 32;
> >> +		return val;
> >> +	}
> >> +
> >> +	val = csa->read(lo_offset, true, false);
> >> +	val |= (hi_offset == -1) ? 0 :
> > 
> > ... and hi_offset can't take on a negative value.
> 
> This is just shorthand for UINT_MAX. I could change it to be more
> explicit (option 2 above)?
> 
> > 
> >> +	       (u64)csa->read(hi_offset, true, false) << 32;
> >> +	return val;
> >> +}
> >> +
> >>  static inline u32 csdev_access_read32(struct csdev_access *csa, u32 offset)
> >>  {
> >>  	if (likely(csa->io_mem))
> >> -- 
> >> 2.28.0
> >>
