Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F145148CB04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356248AbiALSbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbiALSbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:31:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49FDC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:31:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so13878981pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hYmCHm4aNV5MWHJ2O9sOJo3oj6e9bMVyslBUiuNSQSY=;
        b=RTVWcU7/7YxaTBvjms3xZXcXKXnRNDO+q+rqpHu0nVgDNdyJGCDkK7TMjWOezse7GR
         QWYAX9fOCh/4hLWo82x6OXCba7GFXqrdQnQVkPpCaMr7GNl/X2qJx9uonr5yyjIigsgL
         BYhET0Pzd5rNskkijaCwfiNThZRzqTZzKktSyCqhMrj+jtkMUZKVd7X/GtwQH4XdknyE
         LiDoY3HZ+nRrQ4KP8y6+pDVef8sx3g4X2XknY1qntpalhGUwLMj4u5ZPVyqBptPyStut
         utgqGxeIcyigEoev+Ooj827LBO21B7SsU4+kSfbdx33uJT6PIYmCDSSiIyOid32XPFJb
         I0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hYmCHm4aNV5MWHJ2O9sOJo3oj6e9bMVyslBUiuNSQSY=;
        b=0rJRnGn0OyXJ6LaJmR8ez6dXORf4bTeC6sMk/TrT5OWDjH10sLObmPDnS7bgnzQNWE
         r68IKj57eTiiVNIUeLDpqfTCrOTY257gHF76SSdOl1mfEkZGxMtEfhkdbMFh6LDmCqVl
         V339XAnIgP6zFtD+zCwByZWpr91/b9JJ/fpnV5CwVssqIglcguhJAc5ELGq1V3nKEPBU
         C1qeV133vj8NXatD5nq8yodB8zbppO6zK1QtD9Jz6jEeUNPdmdAVtRueUMpEdnYNUSyB
         T3Ewe4luDKEcokm1EqBfHrtK5fDRaAqSy6eF5JT5uoUvidsH82uiFtpM0AUtvNJRa2gi
         76yQ==
X-Gm-Message-State: AOAM533qGB7wWDtUpVeRz3EzXoLwcuHlbywB30Lx+NGSsbsnn0FHFpTm
        Jp4BMJe34K91xRzinb0sYTdmeg==
X-Google-Smtp-Source: ABdhPJwnKqqyDplMQ8Wu3iAphZ5zMnNVPszqWhJ0cEFr9eYR/EuOPheLOy/ZOYelMYL4sArC3nG8KQ==
X-Received: by 2002:a05:6a00:22d2:b0:4c1:d0dd:4b with SMTP id f18-20020a056a0022d200b004c1d0dd004bmr535865pfj.59.1642012299180;
        Wed, 12 Jan 2022 10:31:39 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t27sm329995pgm.52.2022.01.12.10.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:31:38 -0800 (PST)
Date:   Wed, 12 Jan 2022 18:31:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v3 01/11] KVM: Capture VM start
Message-ID: <Yd8eh2dAjN49TlQH@google.com>
References: <20220104194918.373612-1-rananta@google.com>
 <20220104194918.373612-2-rananta@google.com>
 <Ydjje8qBOP3zDOZi@google.com>
 <CAJHc60ziKv6P4ZmpLXrv+s4DrrDtOwuQRAc4bKcrbR3aNAK5mQ@mail.gmail.com>
 <Yd3AGRtkBgWSmGf2@google.com>
 <CAJHc60w7vfHkg+9XkPw+38nZBWLLhETJj310ekM1HpQQTL_O0Q@mail.gmail.com>
 <Yd3UymPg++JW98/2@google.com>
 <CAJHc60yPmdyonJESHPHvXJR+ekugZev4XzsZc2YV2mnfBdy-bw@mail.gmail.com>
 <Yd8c3zlTweSGhwtt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd8c3zlTweSGhwtt@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022, Sean Christopherson wrote:
> On Wed, Jan 12, 2022, Raghavendra Rao Ananta wrote:
> > Understood. I'll move it to arm64 and we can refactor it if there's a
> > need for any other arch(s).
> 
> Before you do that, can you answer Jim's question on _why_ arm64 needs this?

Gah, sorry, kvmarm@lists.cs.columbia.edu once again lost the spam battle with Gmail.
