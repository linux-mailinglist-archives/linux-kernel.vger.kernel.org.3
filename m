Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63824BC348
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiBSAYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:24:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiBSAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D34386E34B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645230223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K35v6i7AXpk/D6ZiQB0RgrNtWKES2M6VUlrWvgj1/Nw=;
        b=JTUBTdMbbBUqyYSzj/qwzIO0Q22f4zvuFKnc1kgOhjHx+IzLpydMPgddXXe1PHPw4r8FgW
        /gW/KMu4i/b++cG9usVDL9NsmB2R+WSJmfoACuDj9TRUpmCVg7CTPznDJrWk+zyoaBRe6S
        GITX9AMbFzC1UWWg7xpgpJBtVL2G7GQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-OJ8hnxq-OhiRBvS5U4E8kA-1; Fri, 18 Feb 2022 19:23:42 -0500
X-MC-Unique: OJ8hnxq-OhiRBvS5U4E8kA-1
Received: by mail-qk1-f198.google.com with SMTP id 2-20020a370a02000000b0060df1ac78baso4815245qkk.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K35v6i7AXpk/D6ZiQB0RgrNtWKES2M6VUlrWvgj1/Nw=;
        b=WU4C8WY9UQx4iz1p/vWFcbHR1jejuiyhXIOsW/RARdCTYQ7+lrBXobpY8yGk3riNWY
         sjKN7tvU9k7jFJD7cDGHM5GnKE5Ypb1a53du4obzHWfDcrtAtFrOMvLsoAWARtD+5Cko
         0Omov6tThdL/kSsdZHp3bOhAQhcJpUY7Pk4YoQgM+jWrf9Nl3yk29sG+0eSXotWeREpF
         HnMYNUmY/cHYuQEQ2gHej84q0nBAlbxi75xxXyA/wVYI+X2/lKbFgK7+UZwjFUZz8tBJ
         IyeFyu0/CxYYZFNAjyS4yPqe2htnxiVoRpoCo7jRgH0yGs8Vd+Rh4tvtGbAA6bJhoj6j
         gNKg==
X-Gm-Message-State: AOAM531vbEdU6w6JfORkAp3hVpCBCBw9Le8yv9WBsLo4gWEhUUHYSxlD
        0rJrJMZcaDfaCxcDqJRQ1VEhHnukBIoDFAHBz2EjqXYU0S4w5is+ao3biOGNPHjU1WOds47U7XQ
        Fo98a431KyhgBFAJwI2YPhA1V
X-Received: by 2002:a05:620a:31a6:b0:646:d4d6:793a with SMTP id bi38-20020a05620a31a600b00646d4d6793amr1777661qkb.718.1645230222375;
        Fri, 18 Feb 2022 16:23:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlPo6afeTyzMMVRVT0mkOJR6sYFAcCeEgVm0QaaoNXywTYs0kSxbRxaEoQHqjU46O3dA3XTw==
X-Received: by 2002:a05:620a:31a6:b0:646:d4d6:793a with SMTP id bi38-20020a05620a31a600b00646d4d6793amr1777648qkb.718.1645230222164;
        Fri, 18 Feb 2022 16:23:42 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id d23sm5416974qka.50.2022.02.18.16.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:23:41 -0800 (PST)
Date:   Fri, 18 Feb 2022 16:23:38 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 07/29] x86/entry: Sprinkle ENDBR dust
Message-ID: <20220219002338.khiqptqukabfdvy2@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.984834165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171408.984834165@infradead.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:09PM +0100, Peter Zijlstra wrote:
> Kernel entry points should be having ENDBR on for IBT configs.
> 
> The SYSCALL entry points are found through taking their respective
> address in order to program them in the MSRs, while the exception
> entry points are found through UNWIND_HINT_IRET_REGS.
> 
> *Except* that latter hint is also used on exit code to denote when
> we're down to an IRET frame. As such add an additional 'entry'
> argument to the macro and have it default to '1' such that objtool
> will assume it's an entry and WARN about it.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

So we now have two unwind types which are identical, except one requires
ENDBR after it.

It's not ideal.  The code has to make sure to get the annotations right
for objtool to do its job.  Setting the macro's default to 'entry=1'
does help with that, but still... it's clunky.

Also, calling them "entry" and "exit" is confusing.  Not all the exits
are exits.  Their common attribute is really that they're not "entry".

How important is it for objtool to validate these anyway?  Seems like
such bugs would be few and far between, and would be discovered in a
jiffy after bricking the system.

Another possibly better and less intrusive way of doing this would be
for objtool to realize that any UNWIND_HINT_IRET_REGS at the beginning
of a SYM_CODE_START (global non-function code symbol) needs ENDBR.

-- 
Josh

