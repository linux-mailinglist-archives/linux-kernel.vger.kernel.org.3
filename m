Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274C04BC2E2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 00:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiBRX3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 18:29:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiBRX3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB8322BE4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645226927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yfbQU3sjrHOHvaj7Av7kjMpn5nEotlEKwnV4gLXXPNQ=;
        b=XsNkSTL+bgPPYIJJ09mO8GpaMvZUW12SX9M3qdYUxWfh28fc7oDExE/zBegkN/7XXyKCwg
        bvP7dQQT18KNh82WkcZ6+p74tcVuHa5i8/4JrwWWbvcCPpS2XYJcpqxLRAg1aJfu+TfCZO
        9FPJ2OfJtFNidBN6dx51YyOdc2MBhaE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-Sr68xV5JOTmw7sv0Pmi9wg-1; Fri, 18 Feb 2022 18:28:45 -0500
X-MC-Unique: Sr68xV5JOTmw7sv0Pmi9wg-1
Received: by mail-qv1-f70.google.com with SMTP id kd18-20020a056214401200b0042de5c14702so10429941qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfbQU3sjrHOHvaj7Av7kjMpn5nEotlEKwnV4gLXXPNQ=;
        b=B0hcFHbZadbwHwbozGVupQEW2GCQC5IllJ3Dwlnxbgc5gBRgU3IRvKiFNL5oJLi/Ng
         7a3pal5HEcOwz/Neqcuh++VW2WbB8DR2wp++HeYeTxitGBYsSi/mxmGXMLFzlDZ7CT/d
         zOReA9rG47TqR1fneZacdYb9QLEzakGSXgI7CsjT+zgpobe2VNunNIRBBlj5lgeRiJWA
         ARg8zcwfVLES0R28BKdSv4sj6yWJh78o+XwDd8lJde1yPg5cZHbOCkL7ZJ84bUVr0oMw
         xdOhbXBSAIwVWBXhTs3kx1DL8TivGXJ9+1BjcoxD+7ApPChhC+KmPWzMra+rS9UT45zV
         s1xg==
X-Gm-Message-State: AOAM530/chPxh33D9A0P4UwHWsLPGwBQdhW5SxFQ1vJ8knIqwcxvzmo0
        F3dXtwZ8miAf/0k+bR/94FQ8Yqjvr6OjFchw+/+cnsd5nVQqFgmi7WzWUvObUG5CZKncqq43s3d
        haaWx5t+ZukLQsP968OQdY4qL
X-Received: by 2002:a37:62d5:0:b0:47e:1755:2ad8 with SMTP id w204-20020a3762d5000000b0047e17552ad8mr6235184qkb.561.1645226925403;
        Fri, 18 Feb 2022 15:28:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAAJ0AjGRPWf3ZD4jYq3YIosaGJlL7BsYGB0hbKvBAc1HkEzRMP6JX3aIG1quX7kl5rGmAyg==
X-Received: by 2002:a37:62d5:0:b0:47e:1755:2ad8 with SMTP id w204-20020a3762d5000000b0047e17552ad8mr6235172qkb.561.1645226925168;
        Fri, 18 Feb 2022 15:28:45 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id g11sm23480810qko.58.2022.02.18.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 15:28:44 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:28:41 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 02/29] x86/module: Fix the paravirt vs alternative order
Message-ID: <20220218232841.xrufb26tgzou2aty@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.691941184@infradead.org>
 <20220218202820.7tvwxytkyqtngiks@treble>
 <YhAOJg7A8iko6it7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhAOJg7A8iko6it7@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 10:22:46PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 18, 2022 at 12:28:20PM -0800, Josh Poimboeuf wrote:
> > On Fri, Feb 18, 2022 at 05:49:04PM +0100, Peter Zijlstra wrote:
> > > Ever since commit 4e6292114c741 ("x86/paravirt: Add new features for
> > > paravirt patching") there is an ordering dependency between patching
> > > paravirt ops and patching alternatives, the module loader still
> > > violates this.
> > > 
> > > Fixes: 4e6292114c741 ("x86/paravirt: Add new features for paravirt patching")
> > > Cc: Juergen Gross <jgross@suse.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Probably a good idea to put the 'para' and 'alt' clauses next to each
> > other and add a comment that the ordering is necessary.
> 
> Can't, retpolines must be in between, but I'll add a comment to check
> alternative.c for ordering constraints.

Ah, even more justification for a comment then ;-)

-- 
Josh

