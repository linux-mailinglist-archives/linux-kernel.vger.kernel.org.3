Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AAA527439
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiENVmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiENVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:42:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3D918393
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:42:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 31so10661572pgp.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=23xyQlazTAPWzzday3S3EoO5Wm7fZvGvsyQkqyX645Y=;
        b=TMkRhl/wkoxlOPIUjWFpDEdYryjRLo1aur2RO+svl712U8by/JGzX+5ItuVlWn03tA
         KgpiOLWAc0epLFPuSyHy+n6EnTesI6a5Crv6i50DYOfevDec6pWiGr/qo7ei40Il/CZF
         9DlqRR/GnjNe/MZg9aFcb3rMM559MvTBwPk+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23xyQlazTAPWzzday3S3EoO5Wm7fZvGvsyQkqyX645Y=;
        b=Jrq5sOHi5f/JACQdbAPOY0oY7yzApihX6a/xQGDC2Xi425hm3XcpkzCidzGtXibx+p
         I8HEnJp7xTVSDIgRE+aHyVeRcUBMVghBE14WbSfItEZM1ixSV8xtMBymlFyoCkgdcmnU
         dmCw8Y7eiZVbV9j1+EmA6QNKSbFaOjfqR8vysYn/o2bxw2y2M85C26B5k9v+KBFeY3Ax
         hyOnzJBZb6ZFmhej6Lb5smb0FTA2nZyegP86K91M+LtQ8VYcURmnJGpoI8dCkFg7t8jJ
         PuEJvITzdJ/lcP6KbS3ycV9Lh5k5Kvlz+mbQN1Sl1gWQYxxghuOPal7/XMvSFgVsNkE/
         WpVg==
X-Gm-Message-State: AOAM5319141tKfCD7NpT88uqkxeq/0b2UHJY+F/Mgn/v9vO5SUA9zhbb
        qTpgqftxSlo0wRIYJpdsdtoTKA==
X-Google-Smtp-Source: ABdhPJzM6sSqhlRvKZoHaTHCB67LhQRuHcOSpewjHrxQxN3l5+JJ6IuUuizN+MmH7IWYXI6gsxrCog==
X-Received: by 2002:a05:6a00:c91:b0:510:73d6:a890 with SMTP id a17-20020a056a000c9100b0051073d6a890mr10685973pfv.42.1652564560673;
        Sat, 14 May 2022 14:42:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b0050dc76281a5sm4083831pfo.127.2022.05.14.14.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:42:40 -0700 (PDT)
Date:   Sat, 14 May 2022 14:42:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 02/21] arm64/vdso: Filter out CC_FLAGS_CFI
Message-ID: <202205141442.9DBF84F15C@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-3-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:40PM -0700, Sami Tolvanen wrote:
> Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
> removed from CC_FLAGS_LTO.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
