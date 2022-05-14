Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89938527441
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiENVq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiENVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:46:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BBB63AF
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:46:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w17-20020a17090a529100b001db302efed6so10850837pjh.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e29OYJF0Cr34NWXtjSnWsGpG9iO/e7RRuuLzidaM53E=;
        b=iLL3cfRMy+bNRF6yJMjDw3XvgwGT5nul36IUUc3BfjbVqT/89mvtX0Y9OzZeN0R4Gu
         W178b+kjzr8Lf53lXiq7GHB/hfPD1hgiN4QTbUs3bRLflRujC0OJjNTHm2LZ3xS18mLX
         NRFhidoGxgqGZWfBgeQ3q0MvXRxhcwrfDkb+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e29OYJF0Cr34NWXtjSnWsGpG9iO/e7RRuuLzidaM53E=;
        b=THx+puAPk7gouqCO85bCeV+eAMr9lo0Q/yjopnzbDhRrNsFvt9lEeFkG8HagS94Gg+
         irJUmUtG+5TsDdodcIsa+RYLQHl0jfDC21Gcpx3h003Q94bHlF88pqJs87pcBXeeGK82
         Cf/2hpCLBV1hrXpFvqh0KfeetJBlhOML7CnNGJENn/b1lDcZL/D8RBxCvP9Zn5kxMUOn
         SKE0L4XnCiyg32moeLSOLQQuvgFvrGSXX3tWNfdgyr79/1kL+kHeyFHjgyq92jGT6N3Y
         Ak189PXFO1nuAOPy4chIY7RNZ5kzTAX5cGWeyMT3VzUpjcFsH/p4+ctsLJD8evkoFAhT
         eCWA==
X-Gm-Message-State: AOAM531pfVv/6gKEuczsw5gkB0wfZoD6gbyKpF4Yw4PuSzW8B3D82qsh
        uSDIlcymLZHyABYDpEZcZUEDHw==
X-Google-Smtp-Source: ABdhPJwsCXmSC41w6NBmUyzu0g9wSnZn8nG1i4Pdwc6BWgonq72IR1wz8hyIaB0bEBdZVZ1mnem53A==
X-Received: by 2002:a17:903:189:b0:15e:9584:fbe7 with SMTP id z9-20020a170903018900b0015e9584fbe7mr10635100plg.65.1652564811104;
        Sat, 14 May 2022 14:46:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j11-20020a056a00174b00b0050dc76281bfsm4049680pfc.153.2022.05.14.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:46:50 -0700 (PDT)
Date:   Sat, 14 May 2022 14:46:50 -0700
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
Subject: Re: [RFC PATCH v2 06/21] cfi: Switch to -fsanitize=kcfi
Message-ID: <202205141444.9F32C94D9@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-7-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:44PM -0700, Sami Tolvanen wrote:
> Switch from Clang's original forward-edge control-flow integrity
> implementation to -fsanitize=kcfi, which is better suited for the
> kernel, as it doesn't require LTO, doesn't use a jump table that
> requires altering function references, and won't break cross-module
> function address equality.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Yes please. And just to note it somewhere: landing the KCFI
implementation on Clang depends on this series being accepted (i.e. if
the arm64 and x86 maintainers are happy with this series, then that'll
unblock landing it in Clang (no reason to land something that won't get
used.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
