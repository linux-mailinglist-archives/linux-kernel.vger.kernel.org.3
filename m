Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BE8515547
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380565AbiD2UQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380566AbiD2UQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E51256FB9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651263174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFq3FS22EtZGeQS1oNCaYOBGWZnQDFBvgQIs9pjL7WE=;
        b=D9nU/HBYSTX7frAtfLJIywl0vP9vmHxuOVp926xoQK7ZISD/VQP3m5nJlGe3/EDp7N0H8c
        vzArSzoU8ACVoCS2BKmoCcR4Ei6ktrqX1CmHa52NRaQA4IbWXXOTQQ2YPoJyOUO3TOMVwD
        VNZ9GZswMSYiyaKFnceznVyDMs2TLnQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-yyWaouqwPX-SUWhK5M3Btw-1; Fri, 29 Apr 2022 16:12:53 -0400
X-MC-Unique: yyWaouqwPX-SUWhK5M3Btw-1
Received: by mail-qv1-f69.google.com with SMTP id p3-20020a05621421e300b004562c4a6b08so6762109qvj.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VFq3FS22EtZGeQS1oNCaYOBGWZnQDFBvgQIs9pjL7WE=;
        b=D2ZzcXmvO2DKJPeGt8C9C1dBbaif/2YDmBBNg9cRJVxGwHdHlre06xIebi/fF/PqRv
         LFbnrPnhO7FENXJ9g6PjXmu6JKFueINhSRgl9a7WEOLRCOmB8Cbg5r7ELsO2kN/SAjYF
         uhCek/N1A7I7JTYtEkmHaeKow9AkZbt5MWJSHBqh2NXq7QRgqWiFcgCsQMwXKd/HoQel
         yysGX3U2imhcrXrjsM7Cj6e3VtzQVqsO+0nN8mE5im73A04ebojtApCpPTDpLv+2TERZ
         W4rUTdcuEe4+VG4GAzAb3a0IDK648AfA3Z8Ob9EcjZLrOFJqoilxdTltmjfeTVqIoCiJ
         cxjw==
X-Gm-Message-State: AOAM532jv+NpOutSGBSQpYfThZ8Bu1SoA25bq4lHZpMjyEFuYeiSFdCn
        BVuBLQD9yW377LuLfJLdnegXu1geTqNdIxksMHX9Jr6X3h6z5w2xssBdbah1EK0Qnz/Os340PZ/
        U7fo1pZTgzTICUBs3drvcCX9I
X-Received: by 2002:a05:622a:5:b0:2f3:7dd0:3d13 with SMTP id x5-20020a05622a000500b002f37dd03d13mr1036009qtw.362.1651263172761;
        Fri, 29 Apr 2022 13:12:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWwL5xKqhCNor6yaHrMCbJD5xi0aZ8jf94JlgbQ9LACtypq6Go9z5qVCLrD1q7s7iJ8ycSVg==
X-Received: by 2002:a05:622a:5:b0:2f3:7dd0:3d13 with SMTP id x5-20020a05622a000500b002f37dd03d13mr1035998qtw.362.1651263172562;
        Fri, 29 Apr 2022 13:12:52 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id x1-20020ac87a81000000b002f39b99f6a7sm94599qtr.65.2022.04.29.13.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:12:52 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:12:49 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] linkage: Fix issue with missing symbol size
Message-ID: <20220429201249.5hjcutds4wmkhemr@treble>
References: <20220429091859.GS2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429091859.GS2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:18:59AM +0200, Peter Zijlstra wrote:
> 
> Occasionally, typically when a function doesn't end with 'ret', an
> alias on that function will have 0 size.
> 
> The difference between what GCC generates and our linkage magic, is
> that GCC doesn't appear to provide .size for the alias'ed symbol at
> all. And indeed, removing this directive cures the issue.
> 
> Additionally, GCC also doesn't emit .type for alias symbols either, so
> also omit that.
> 
> Fixes: e0891269a8c2 ("linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()")
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

