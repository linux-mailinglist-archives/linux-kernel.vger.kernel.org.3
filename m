Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD56525702
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358684AbiELV1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbiELV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:27:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4901AF8C5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:27:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so8994451pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z42I6VdLgJQWCimw9jq3ML6062lMxaAz0l305lNu6lY=;
        b=sf6rGnUno4L6TvnRk2gpBC24KcJtsUZzN6I4vcfDuOiZfZRQ+3UJG2NNvdA53QBRPT
         Y7zMBoxCnnZUBdlUyuRF92JRQJdOBvmaEgu4/AR2JuoEEIDA1RhKdKl5f6iXmvl/kBQh
         +xOva8WNjZAQnXo3BURvlZ6ZywZ1sQHPJnrDAnTaO0dB/x+g64ljQ3VvV4H0Ow0bdzX/
         yQsANAdKTv8L011Wk0C1pDbSCLuFY8LqNjwjlcyAGtjBKNAYN+Xi2s2SPi1g+JEhBFOS
         AjnRs3tpZv9Zri8bo/SARsW0OjnX9ePob5VARvUr1q0PQHDMII641v4VqjmyVxie5rtM
         nPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z42I6VdLgJQWCimw9jq3ML6062lMxaAz0l305lNu6lY=;
        b=6bAC6KrddfQr/pzMr/indTC7Mc3FT4ov2FqALyq8CAwXCh1iJZk/L65uzunOiTn5Bf
         knuae+VaPXlAaomUOxN4C6HShDlQM5/t3fvSOT5ybcEZIIoV/4Au1pTBD4ddQzZZJ/lO
         nMEZf4PQGiMUHCh4k/f2WqC3fUMK4Wl/GcVOire4QK97XDWRj5y1JOvV3Ozmd7YFy/zW
         o6B/tOaRFF8fWfG1Nd2Ry9JffauUFoByy8/9zVLnN4WdFzSuKCxKHs2wXw0gF85njbYV
         q0Ie6FuyWMU0/mIdZ1yqKUJfaE0CyiTOIEgB7gHBdF9Skl2qtJSWf/Wj+6xpiJFnnSCw
         cI3w==
X-Gm-Message-State: AOAM53081LYRojjQMVZDrZ2zwYoYMHeMq5Ak8hLsS9liLFoegzomjz3f
        tS8+FDvq9+4AXfFHBf0Vt/RRKw==
X-Google-Smtp-Source: ABdhPJz9xsKhnwOtZsyp6CbgXOmfSkTHnZIHbC6HPulm4VT8eFiPZMXgDH6mwCOF1OeFg6Na0OCkHw==
X-Received: by 2002:a17:902:e804:b0:15e:a5cf:676 with SMTP id u4-20020a170902e80400b0015ea5cf0676mr1411413plg.144.1652390845912;
        Thu, 12 May 2022 14:27:25 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902c2d800b0015e8d4eb2ebsm304335pla.309.2022.05.12.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 14:27:25 -0700 (PDT)
Date:   Thu, 12 May 2022 21:27:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] KVM: x86: fix a typo in __try_cmpxchg_user that caused
 cmpxchg to be not atomic
Message-ID: <Yn17urxf7vprODed@google.com>
References: <20220202004945.2540433-5-seanjc@google.com>
 <20220512101420.306759-1-mlevitsk@redhat.com>
 <87e16c11-d57b-92cd-c10b-21d855f475ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e16c11-d57b-92cd-c10b-21d855f475ef@redhat.com>
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

On Thu, May 12, 2022, Paolo Bonzini wrote:
> On 5/12/22 12:14, Maxim Levitsky wrote:
> > Yes, this is the root cause of the TDP mmu leak I was doing debug of in the last week.
> > Non working cmpxchg on which TDP mmu relies makes it install two differnt shadow pages
> > under same spte.
> 
> Awesome!  And queued, thanks.

If you haven't done so already, can you add 

  Cc: stable@vger.kernel.org

Also, given that we have concrete proof that not honoring atomic accesses can have
dire consequences for the guest, what about adding a capability to turn the emul_write
path into an emulation error?
