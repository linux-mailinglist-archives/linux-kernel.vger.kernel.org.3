Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E347B3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhLTTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhLTTpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:45:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:45:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso901041pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9utNYtF7nbB+ny8Zz1Q0qxMiDuM46joQzQmvzzrN56I=;
        b=MKzIkQMyFLCHcVjCyhCE9CFcyp/GFZNhZKLrRFLpauudskVD6/M4E35pj8N/k6PFWq
         dxzXbCQNLTbgHOaUo9lyEe52DhZrMqSOpSbWSiC3rmhawnW3Vhcd2ofHg460QmU1S3+6
         Juc6MueHrzIezVNQDFi0ziywbIuQMp2GUfwUM2IDndVk4h12Ttlu0y1YuL+IIAAcClpH
         pcO8b38Rxyzdn0ExdcWur3WTwjX7Xj4O2VV6xFK0tTaLgKrNfzqA6KUAKKatpBvJalGh
         h3U2EwBSR65pEIIFRkNWtLWYO7wI53W6Sn9vUZ+8PVeJS+fOejo7KJmGMt0hzTumzmS5
         JlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9utNYtF7nbB+ny8Zz1Q0qxMiDuM46joQzQmvzzrN56I=;
        b=C8yAPHTV2gt3MqW8Jy9ECtbG7aYEcEK31tAhrjPsVKk9yew8u4Mdi1JHZII5XYFnIT
         LUpAQIA/lETFZnekVNKvz5OVlosq+VAuKmXGnyArqkcSTACenH6SwZHN3VV7oGyzukU+
         FkyhrdieFUyIAi4QgEIw44g9X0SA+xwGomvoPG3fxN/C4lnAxDp8FpO8PcbjJyTV8AFa
         VagZt9xKkKHnV7Siao8vJ7uMngTTcIk3t3Mcb34emK7Nop0r7b5dxKNeUyjVY8qOGp0m
         X8AfKeKHQirPF0bJNqh/xa/XbEb7DdTyKek/W2kPNVLqUNH1VXvjCEOflAp3hlMePpMC
         CFjg==
X-Gm-Message-State: AOAM530BpZpelTpytOMZkEmdxJ3576d9Qr7X3mnQF1mx3sATkfobPQ1x
        R5N9admTeNriIqqFoOGVmBCW0Q==
X-Google-Smtp-Source: ABdhPJz9fxZPk5z4s+GXQitXrpsy8xcsqun69MNxnSpmZ5tOYABVgyfGrAXKFYzahDOFlitumpiksw==
X-Received: by 2002:a17:90a:a083:: with SMTP id r3mr601594pjp.55.1640029505867;
        Mon, 20 Dec 2021 11:45:05 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t8sm19386929pfj.26.2021.12.20.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 11:45:05 -0800 (PST)
Date:   Mon, 20 Dec 2021 19:45:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] KVM: selftests: Add EXTRA_CFLAGS in top-level
 Makefile
Message-ID: <YcDdPUn9bAVnxb/2@google.com>
References: <20211129075451.418122-1-anup.patel@wdc.com>
 <20211129075451.418122-4-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129075451.418122-4-anup.patel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021, Anup Patel wrote:
> We add EXTRA_CFLAGS to the common CFLAGS of top-level Makefile

Nit, wrap closer to 75 chars.

> which will allow users to pass additional compile-time flags such
> as "-static".

In case there's any hesitation in applying this (Paolo asked if this was just for
debugging in v1), being able to pass "-static" is helpful for our environment as
our test systems have a funky and minimal configuration (no gcc, and the interpreter
is in a weird location).  Running selftests either requires building them with
-static or creating a symbolic link for /lib64/ld-linux-x86-64.so.2.  It's generally
easier to just tell people to compile with -static.

> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---

Reviewed-and-tested-by: Sean Christopherson <seanjc@google.com>
