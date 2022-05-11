Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85399522A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbiEKDPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbiEKDPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:15:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CB312621
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:15:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so3682787pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NqBhJncEVUk2Pf1eI7/8nYp94z8rVRASEDNRY/5rLM=;
        b=EL8jSIB4rrhW5MGwrl6kRzt6+DCrDQMJQn3wbDoSslBIhLXLMTRdCiUE/wf6D6RKui
         q6ETmlR97XQQj8+PGMEsY5P7lD6Jdhmnw/PaJXcRrD3mYNJfGVhf6nCHegcj1GcgmQ9w
         ZofttmOGg9O/2Iifq7pxjnJ84G8UsoIDtSHJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NqBhJncEVUk2Pf1eI7/8nYp94z8rVRASEDNRY/5rLM=;
        b=3zHldpejmkUOb4t+enKuVgRvYYw0y8jZxofO+Pl7hSHuwIlUpHl7MQ6C/xIbfRG4jq
         b+FtOZUBXhjCV+sMQpw/yWBaM2OHICBVpEuPLHS68zhbPq6rxinp3Lc01pjWnHmZ7Nji
         zxP3HUmXyjlVr2eva7740uvMsq3A2s55Lpl0nibHwmFaczJO976iIbWHG4zoIQQdat5Z
         GZrYdbSoSkb8kcfj5owoAk+qNW4KBvkgYQKfgmxPwXYYZm31IUS7ac0F6CgqFMAloY1y
         YcI/CqFCRR4ZrK733CJT74r5jBGwCj+WQYYbZd4ME3+LSQ++LmqzAGRfYC5h7CBb8R+m
         HRtQ==
X-Gm-Message-State: AOAM533DWX/oml8+p8shAdbFXzzFdWSOov8w7FXaqX0NgrrANwdSJDwN
        3prUdrOVhSYzQDM7vMvjC3ir4w==
X-Google-Smtp-Source: ABdhPJyd1dEIvJa9UluCWVd8wprzlfzW7U7Y7P5K4Bg/8vGrg1CSsd9HHwgnpnEfcVwwjxYOlZuFbw==
X-Received: by 2002:a17:902:d2ce:b0:15e:c024:6635 with SMTP id n14-20020a170902d2ce00b0015ec0246635mr24185444plc.28.1652238946411;
        Tue, 10 May 2022 20:15:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090a788800b001dbe11be891sm2567976pjk.44.2022.05.10.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:15:46 -0700 (PDT)
Date:   Tue, 10 May 2022 20:15:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Message-ID: <202205102008.88C15972@keescook>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-15-ira.weiny@intel.com>
 <202205091304.434A9B45@keescook>
 <YnraD8URWxWtaltF@iweiny-desk3>
 <202205101504.5B5C693F7C@keescook>
 <76ee55622592d531c82cb42b96d4bb27deb26287.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ee55622592d531c82cb42b96d4bb27deb26287.camel@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:26:43PM +0000, Edgecombe, Rick P wrote:
> v2: 
> https://lore.kernel.org/lkml/20210830235927.6443-1-rick.p.edgecombe@intel.com/#r
> 
> Mostly it fit together pretty easily, but there was memory overhead
> required to protect the page tables that map the direct map fully
> (unless a better solution can be found).

Oh my, I totally missed this. Yay for Too Much Email Every Day. ;)

I'll give this a read; thanks for working on it!

Also, can you speak to the schedule of availability for PKS?

-- 
Kees Cook
