Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F574C3AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiBYBAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiBYBAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:00:02 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E801EC981
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:59:31 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i21so3312592pfd.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LbSHiSeUw7go8rTxfdIuv25wU5vlqRuXD57hwdTkS+M=;
        b=DYwWDb5lEy1t2j1EHWsIi/PoUDUEdT2mVFWuYorV1pMdSFuMMiwdXfc6fOdugjgFS3
         NBKsSHU/TScxrOxJKP05q7x7xO77qE3qVGtMHknrj+q2HAE8QSmz5xxEu1y57T3ksiIP
         +88LbTFb7PNIaqgEduQ1Y4/zXmJzXx7KRErI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LbSHiSeUw7go8rTxfdIuv25wU5vlqRuXD57hwdTkS+M=;
        b=LuqPnlUCiaAIF/RsYvxsf+Met3A6ckGrT6bbRtoXb+LbHeGDybSYMqpxz4d2oaOBT0
         dtbSVXWwpsomWz0YtFkQbskcDt8Pts97cS/dCLIAyfjFTFiWKghZ0m9cFvyX7okDOtzN
         grLqLPO+6ilXoTzF5Trv0sFjJjM+rAVuHv/vELkMrTFjbtM0X8MyJYv5JTykBlI5QXMR
         FmaD38pbUWWWMHd9ICFZfyhE5NziWFyytfNLbKrgiZY3CpfFB0lH9GGlsv9pdagRY7Kq
         FmLAOOdzL6R4E59sOXIdfuNR8L8rKvgAI1JsL4uZULsUaEF30FkL8t21lRGrHneArrss
         2w4g==
X-Gm-Message-State: AOAM532zhZpkfnYGyP9bImphfWUzga5hcbko5cCFzQhtJG5kUD7KDcJ/
        G28J3UD4wdcyIhaIJNT/vGAxjA==
X-Google-Smtp-Source: ABdhPJzaU8iAOgmiDC5kZEeVCZVeX5BwHMV3ql/lsjaRS6BmUqebqZKBjUyHn6OjcSzWxHZPvlSk2A==
X-Received: by 2002:a63:5d5b:0:b0:375:983d:7c9d with SMTP id o27-20020a635d5b000000b00375983d7c9dmr2944739pgm.595.1645750771005;
        Thu, 24 Feb 2022 16:59:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5-20020a056a00080500b004e174acd876sm681455pfk.216.2022.02.24.16.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:59:30 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:59:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 16/39] x86/bpf: Add ENDBR instructions to prologue and
 trampoline
Message-ID: <202202241658.49BC109@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.950111925@infradead.org>
 <20220224233731.7hdwbszv5c6fgx4y@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224233731.7hdwbszv5c6fgx4y@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:37:31PM -0800, Josh Poimboeuf wrote:
> All the "4*HAS_KERNEL_IBT" everywhere is cute, but you might as well
> just have IBT_ENDBR_SIZE (here and in other patches).

Oops, I should have read ahead. Yeah, I like folding the multiplication
into the macro...

-- 
Kees Cook
