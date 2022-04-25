Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF150EC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiDYW5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiDYW5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:57:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9310773B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:54:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id x12so308640pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Q+RJPi5324M1G6R92MlojY1RDxai3y1EeSAyZxabSw=;
        b=mwaY4tFFCUPbFZ9IDIp5vPVzIHchfx6du0rPPb25oDWZ0A9ngIKi75lz+toEJiKH67
         UKsgX8v25kVY6GexOHFAemNMGbyqWLf2E6EkMTPB/Ll9YBUQCLryNor337fzamre81O9
         iZjwAYNILcJ/rKfacKBNMBwi0Gj/JrfR+Qurk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Q+RJPi5324M1G6R92MlojY1RDxai3y1EeSAyZxabSw=;
        b=XIVhbQxoRrfhW6hjOyitBE+RsQ6dqS/NGHq04dWh+SypYR55WGdQfYsu0Q7xcTksSM
         Zj96MRy6lC+I1ua3GafwLsTtNzyXIeaeSOJK2ZkIlmCPVBWj5l0TJsmgCTBlr/z0sQLM
         BqOmnTmCxVI9ddxrkiMRdFz+SNCLqZ9m1fyCy2OmMhJgCR7D48N2vQiZoITNWbc7jmWN
         He87oAwSu69DO2REGizedogP7fGZwHWjv9x5E3ZLcdLycEXUI2rZEGV7RUpgO+D0v+MB
         RfdvebMkBiZWcFMrO9zwmoVNLdEhvnL/9XJdi+RgrP98edmLOO2v0lrRYWLoTSJVh0NZ
         illg==
X-Gm-Message-State: AOAM531nZ9ttFXfbE5AuyHg4Z/jMDOcglwACPcB251h/8817Bi9ubVgv
        J4aFAzqF29jF5Ld/qGQD10S/4A==
X-Google-Smtp-Source: ABdhPJwngwfKHLdu4op5pfvRAi/1xES2NPHwu26aj463LNBFZYSMll1pfv1ZZ2acFGnJ0p/NXO5NNw==
X-Received: by 2002:a05:6a02:105:b0:381:fd01:330f with SMTP id bg5-20020a056a02010500b00381fd01330fmr16697414pgb.483.1650927241923;
        Mon, 25 Apr 2022 15:54:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14-20020a63380e000000b0038253c4d5casm10729293pga.36.2022.04.25.15.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 15:54:01 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:54:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH 0/8] stackleak: fixes and rework
Message-ID: <202204251551.0CFE01DF4@keescook>
References: <20220425115603.781311-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425115603.781311-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:55:55PM +0100, Mark Rutland wrote:
> This series reworks the stackleak code. The first patch fixes some
> latent issues on arm64, and the subsequent patches improve the code to
> improve clarity and permit better code generation.

This looks nice; thanks! I'll put this through build testing and get it
applied shortly...

> While the improvement is small, I think the improvement to clarity and
> code generation is a win regardless.

Agreed. I also want to manually inspect the resulting memory just to
make sure things didn't accidentally regress. There's also an LKDTM test
for basic functionality.

-Kees

-- 
Kees Cook
