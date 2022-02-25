Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9911F4C3A91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiBYAzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiBYAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:55:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFC41DFDDE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:55:09 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id l9so2954271pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R80GIipw6XPpWW++pfzM0QwwIWCfB4Mxcyp6hhjGsks=;
        b=D5OEQLifQBIIqlZMBWksZ/o/x0PBukWHtoPiKnyHKdQQeb2iHnQiaPHXDuzDGTbSR2
         xngAcDHOWg7h+6pps4BpB9j9QwhABXNbqtHmLXgxiwHYrEhBBZJLPkI6Fba+SgQ38SDy
         HLtvOeWEWTLmZAXKtytkj7+imT1k01h8NBIw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R80GIipw6XPpWW++pfzM0QwwIWCfB4Mxcyp6hhjGsks=;
        b=Bh9vU6zkHZHlhq2VnLscE9zLpnsGxkBbGLSNYTGyQHk2jqEovQ0mu6el6qaFJsNGAV
         f/PlX6sft6MxA2YyLuB8lzS+ZmvZywShWxlvDhSWjEBoEd53jo3F2hCyiEUFOxPt/f8x
         6pzFLQubANs4plXWwTwZaueXJ8KNxd5Q2M6NpkhqT0zz0ymPgoEtag+7dkDpTsthozMB
         gNniDPMqIThjALipb578mdcfOnXg6sNr3dL9K6QH60bhxGDyXFhQ3EDetEdgLE1kjxIq
         Sd+fvVhiEy1u0ouDx1oaoujWk+ZKYN9DMCh9yAUEA5Fsh3BLfTjH65R+rBDYrJrqN48J
         ba4w==
X-Gm-Message-State: AOAM532bay2a8V5fbabtaFNZzu11BeU0ZYJhYpjOW31qQuF42qxx3p4N
        fgjwDe/Ta65oKb1JQzv23G98fA==
X-Google-Smtp-Source: ABdhPJx9TVoWtw1R3F5zg8N6T1XdhYNM7KIQnWy6jSZTRSPSGHFqsmo5+fUs9s7F8VzVCO/jkkUJOg==
X-Received: by 2002:a17:90a:de89:b0:1bc:8441:ffc9 with SMTP id n9-20020a17090ade8900b001bc8441ffc9mr700415pjv.236.1645750509472;
        Thu, 24 Feb 2022 16:55:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a000cc900b004f3581ae086sm763364pfv.16.2022.02.24.16.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:55:09 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:55:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <202202241654.1D43F008@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.714815604@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.714815604@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:50PM +0100, Peter Zijlstra wrote:
> Have ftrace_location() search the symbol for the __fentry__ location
> when it isn't at func+0 and use this for {,un}register_ftrace_direct().
> 
> This avoids a whole bunch of assumptions about __fentry__ being at
> func+0.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Cool. This should help with anything using __fentry__ tricks (i.e.
future CFI...), yes?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
