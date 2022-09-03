Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A725ABD33
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiICFMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiICFMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:12:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C834F7D1E7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 22:12:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u22so3690365plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 22:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DWQU4BjAk2RKJXcziV8gz7Em/gw7x1iBMRQeoGw/K1A=;
        b=a0Jq0XZYSQA1ZyBSSQtFq3BQ8vg873jp0dp5wazzJ6inOF195+lnsDAOPUGs6u3Knz
         z1zC7iYuExltCbr1CHrw+kG2wIrjr5zrW75GFzxfyyLEKJZmUAz4MkHYLh2c5VL0y9UD
         aqsiJxsNXtVG4DXUTWfcxZLABqciAZKarEbtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DWQU4BjAk2RKJXcziV8gz7Em/gw7x1iBMRQeoGw/K1A=;
        b=zq2BR6CAHux6IW1it/b6MsHUOwSFGwuW+8bimd2MwK90bU4mQkQXndZzQz0JzhXcyB
         ZKMM78laprCLys9QIR6zElq9+QK508vpTe46ygIrCL+LdhjdR8y+64fi6d9mLm/jGpX1
         152LmugrlJyNV6ni49kPQYJvJcLod/XjCvS9irpN6YY4Okjuc5wGW0x/iwAW4SVAKMdp
         z2jUmQvcw7Iq6bbIb5HHIghIym2r+yWp/9BE1Ia0Ov6taxknLEFFODFpuV1g/X5ZlvdH
         xRZZzR+Vnr2m8vjIBznFfEVOTs0R0az1Agg08ZbideaddJ5OZZm7o++pMw6eRhWvQ8qH
         uqjQ==
X-Gm-Message-State: ACgBeo1MLArlPxD3YLAaMiN4GKqT/ZQaDmwRXsf6QuY0jmn4HqEjyi3/
        XOCMSEVPG4NUr42s1IU+qdqaKw==
X-Google-Smtp-Source: AA6agR79orMmne040IWFGp4YWTLDIAXoo56UMa3pGaPPoHU65ls6cjvq+KJexvX/CPOzSvzjZEMf7g==
X-Received: by 2002:a17:902:8ec6:b0:172:dc2c:306d with SMTP id x6-20020a1709028ec600b00172dc2c306dmr39278791plo.104.1662181947281;
        Fri, 02 Sep 2022 22:12:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a2bcb00b001facb7bc1adsm6140998pje.26.2022.09.02.22.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:12:26 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:12:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ocfs2: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209022212.7F753284@keescook>
References: <YxKY6O2hmdwNh8r8@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxKY6O2hmdwNh8r8@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 12:59:36AM +0100, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declarations in a couple of structures and unions with the new
> DECLARE_FLEX_ARRAY() helper macro.
> 
> This helper allows for a flexible-array member in a union and as
> only member in a structure.
> 
> Also, this addresses multiple warnings reported when building with
> Clang-15 and -Wzero-length-array.
> 
> Lastly, this will also help memcpy (in a coming hardening update)
> execute proper bounds-checking on variable length object i_symlink
> at fs/ocfs2/namei.c:1973:
> 
> fs/ocfs2/namei.c:
> 1973                 memcpy((char *) fe->id2.i_symlink, symname, l);
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/197
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
