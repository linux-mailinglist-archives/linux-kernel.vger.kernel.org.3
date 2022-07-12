Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DBE570F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiGLBiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiGLBh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:37:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92B48EB6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:37:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso6514621pjj.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WviUjYGm+rN9XZgfwTaOdA+cnHAG88Jjo15LstAimgU=;
        b=INQAY47xH5htGVWI6UXlhorRrnL8Jd67/7TotuHr9Sj9U8E/eQW+SGdq7tonkWTVAn
         FOJxZvWR8Uf2UbHQQPBPYoUi5ZmRce3XsWUoQl4uYlVB0nMWiANPqeH5Nx2nU3f+5RX8
         GMFItyEoZeta9dQdpR6EyUjK4xP8StQ8Ia4ituvuhIXuU9MenDzRkpZejumsSUkKtwIY
         JL1En2I86PftH9nJW4fPB5UBTucIgB4o37q1itOTnRHEEPkZQw8/upHLL9a7fwuQzmCF
         6eNu90XjgrueTFDv7yFudUAyGR3ctQRuqexZj3PRPTI6tC1Q8czyidWls5WU8IlTN1zp
         FrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WviUjYGm+rN9XZgfwTaOdA+cnHAG88Jjo15LstAimgU=;
        b=UIQdM/0Md8XLZDSQo4qWv6l5XZBi6SArodJlUxVA/kKYQlPDbwzNKUjLcQ3lGZu6uG
         IaqUvQmjAhNLyYbCGpKC/045m1HWzqrdQCFJRhsr9JkCMHumAHWOBMhLv9i64XPHDgjD
         xhxftQ97tG7ixgcchBwaNfh/ACuiZM9OoRsWI0C6/4NT40oXyBu9YizcwBy48dIiBx26
         EPHBluKRpYBTJXsmRgQrw5UIycCqlt5NVOUKv+QGn0SzGvfa5crirVLC5ZETIgWZreqO
         5AOBNj/bP7OwJGxfRRzOs3I25E1OFtI31n7/mQce3A1dqA03wzzAUDdnH7Sz7EBsyZwz
         GGDw==
X-Gm-Message-State: AJIora9stuMLlDyMtSi4mFxZ4cFEeXOAO+o9LWOKwBqg0thQImr31EOP
        fhlfoM89cz/dqutLi/dkygFPJg==
X-Google-Smtp-Source: AGRyM1tiApB8857nuLuRMh9R8W73BEsT4Ar4OmhPOWBlXNDA6ziygmeb27ZfsxASqtW3V9Ck1dc4vg==
X-Received: by 2002:a17:902:8508:b0:16c:46ff:53cb with SMTP id bj8-20020a170902850800b0016c46ff53cbmr8702022plb.168.1657589876315;
        Mon, 11 Jul 2022 18:37:56 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id i9-20020a655b89000000b004148cbdd4e5sm4856317pgr.57.2022.07.11.18.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:37:55 -0700 (PDT)
Date:   Tue, 12 Jul 2022 01:37:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v2 0/9] KVM: x86/MMU: Optimize disabling dirty logging
Message-ID: <YszQcBy1RwGmkkht@google.com>
References: <20220321224358.1305530-1-bgardon@google.com>
 <dba0ecc8-90ae-975f-7a27-3049d6951ba0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba0ecc8-90ae-975f-7a27-3049d6951ba0@redhat.com>
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

On Fri, Mar 25, 2022, Paolo Bonzini wrote:
> On 3/21/22 23:43, Ben Gardon wrote:
> > Currently disabling dirty logging with the TDP MMU is extremely slow.
> > On a 96 vCPU / 96G VM it takes ~256 seconds to disable dirty logging
> > with the TDP MMU, as opposed to ~4 seconds with the legacy MMU. This
> > series optimizes TLB flushes and introduces in-place large page
> > promotion, to bring the disable dirty log time down to ~3 seconds.
> > 
> > Testing:
> > Ran KVM selftests and kvm-unit-tests on an Intel Haswell. This
> > series introduced no new failures.
> 
> Thanks, looks good.  The one change I'd make is to just place the outcome of
> build_tdp_shadow_zero_bits_mask() in a global (say tdp_shadow_zero_check) at
> kvm_configure_mmu() time.  The tdp_max_root_level works as a conservative
> choice for the second argument of build_tdp_shadow_zero_bits_mask().
> 
> No need to do anything though, I'll handle this later in 5.19 time (and
> first merge my changes that factor out the constant part of
> vcpu->arch.root_mmu initialization, since this is part of the same ideas).

This fell through the cracks.  Ben is on a long vacation, I'll find my copy of
the Necronomicon and do a bit of resurrection, and address the feedback from v2
along the way.
