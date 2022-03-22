Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852C24E48AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiCVVz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiCVVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:55:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E940E7E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:53:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so4151042wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NFZgSZlsMJ92K4ZsfQkNqEehB4rKg2VsDcu/AaRN3q0=;
        b=kFcRmFoukS3hfat2xkguRcRqtzGASe1LE8sm1SP3/dtxwuk7sO63/bJIgCxoO18vSA
         y9JgKTWcB/bof/nn2Ggc718WQXVkUY+8GVA1GKlBMTRcq02lbMX1iZPlE1/KyXKtVbT/
         d/pTr/zuOiiBrz4J2BOeiq8QjBCrKjTDAUD8kxD9tzDo7oU+jsmFoLzJovq7LJr0qyhP
         /aQdBwDrBiLQG8mUTxAFpQtvGOxGwSPyevvUhxoy5rBNP+mNytPadUIxL6BD/gDjCUzx
         TIFSPBkVBaJ7OXN05TgsyrcHU7pBXMm5kJvFMCn1oQiVQOm+oJ11E9WIn9hlUZN+Gt3b
         Trjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NFZgSZlsMJ92K4ZsfQkNqEehB4rKg2VsDcu/AaRN3q0=;
        b=Yk0CS99EDMr+jJtu5ndvV/Rm4soNQB3efGveLIaovwR3QiiMD1qWUpTcFLfHLId2Am
         wPpMEHw6UsOXsWskD/tswlhHKyTimfvAv5j5PItgYKjrhVTf+qlBz4Oat1/006aeE42T
         AyneUXLxHjzDmFGKAYrnqj0qcP80DJ6FL/UDR/fhvp0Fbr51nSWq2giOlkCI6htb0x72
         nehf85Ymt1g6m81wJ+TvBx+SKTcfLSMnvOlOoEYRHUj3kGzd0hmdfV5WxBr6RZqsiQsx
         pLjmPXp8NkyAD3+bsaV4DY7pLKzxjKFCwgLdwKYAHKq8sZN3I6z5jXy393ySRag29r5e
         WuVw==
X-Gm-Message-State: AOAM531lFvQwuC6IGvKDHSd2fOZiYF7gDk2RMYxr6JGsAu4RNFXb5pza
        JLoxCSEdqI2vUuXrvC+5SXd5tklqa9QaiQ==
X-Google-Smtp-Source: ABdhPJz9ag7to1Ba2g9ltxrje4ed9WpcWwoG6ffWynoEYXnKEX4v04WmfxAg7wCDdqEw8O8Q6c3wQQ==
X-Received: by 2002:a05:600c:22c4:b0:38c:70f5:25a9 with SMTP id 4-20020a05600c22c400b0038c70f525a9mr5865344wmg.119.1647986036658;
        Tue, 22 Mar 2022 14:53:56 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id g1-20020a1c4e01000000b003899c8053e1sm3725917wmh.41.2022.03.22.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:53:55 -0700 (PDT)
Date:   Tue, 22 Mar 2022 22:53:52 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf intel-pt: Synthesize cycle events
Message-ID: <YjpFcLiCTjHZWzzA@google.com>
References: <20220322082452.1429091-1-sesse@google.com>
 <YjpAYjdgHWwkid5N@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjpAYjdgHWwkid5N@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 06:32:18PM -0300, Arnaldo Carvalho de Melo wrote:
> I saw there was some issue, should I proceed and apply this v3 patch or
> wait for some v4?

There are two issues in play:

 1. PT event synth doesn't support reading inline information from DWARF
    yet, and my patch to add it runs into some problems. This is not
    relevant for this patch at all.
 2. The results from v3 don't quite match the ones from v1, and neither
    of us are entirely sure why. My personal feeling is that the one
    from v1 are the wrong ones, but it's up to Adrian to say whether we
    want to try to investigate deeply here.

/* Steinar */
