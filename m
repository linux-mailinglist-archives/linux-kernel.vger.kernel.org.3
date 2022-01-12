Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B1A48CAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356195AbiALSZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356218AbiALSYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:24:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3688C06175A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:24:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id hv15so6647079pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZmWNRIqHpgfFlpkzNid2AC/wsgEhhdjKgSthxqzupr0=;
        b=Hu0l1zFFoYveGm/teMMMLzjdYZZ9zlHgOwE5BiAa/3z6diZCXc1oZ+E0g3Wm2YT3T4
         zMZkwh6IK/rLwGDBUppTCSQwiB69w1v1Cv8Zr47GFjUlpUkHTF3/rvPZNi4YJH2B8TEZ
         Lyv7xmvISTTPRvYjZtNac+DUiLid4AEGwCa5xnmYyRz/c/jylydiABnVDFOnS7fNFFtD
         FOeyhg327siqhBuHgRQ9qcTdfQg76s8e3XPQUwRWNYi1FBbiPP3WL11PfBg6cJEkL1S6
         KkxJxDKOa/ryCIPaNWK/05qGqzmQdrQ6FQiyNHCRRx3A8OR3nVgXU4hU7ZlR7ZJu9jJJ
         hZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZmWNRIqHpgfFlpkzNid2AC/wsgEhhdjKgSthxqzupr0=;
        b=FWs5RdoC0luqMQqJuNkr+JaQWYKidDXyUPT4mrkxCtYYPPrjK6xkNveb7yzHGvs7q1
         qjs5nhWAD1brCp1B6tM4i3dMr06MMDnqMk7+scmtc8Q+KAFlSNFVWLl/AZ18JONnVfjg
         1kWdo7NNPEk+0cxLdM9o3XDDPXIaLCtx5Gpyr7xjM200qblxQn10q2pxvzxUEdHVonc1
         Wk+6Hf1gVuuI4dwCHFZnx5Ec83bSxy2hFsNwCipa6xDvJlSUFFor135njUFGLIvYbLWW
         V13PFNV2+4WhFB5PHvDhW5ok+XSWJUseOTJAeaVyqyUh7QK5TItFvrnoI59t8iYjHLbd
         Dr9w==
X-Gm-Message-State: AOAM533r/6f388jea6EcNelfaKM1QMyDJ+17vuJEIlBUPrE3Qc21Zi7m
        zAjZ9Eas0GHgT3F2/zIqkwrkdw==
X-Google-Smtp-Source: ABdhPJxC3Spy6jAzawZZkjc8A2flGmd3z5F+VR5mfljb/8geqt6+8TviA+FPYekZyzWdSxeA0zZurA==
X-Received: by 2002:a17:902:8346:b0:149:d1c7:fdc0 with SMTP id z6-20020a170902834600b00149d1c7fdc0mr689096pln.166.1642011875155;
        Wed, 12 Jan 2022 10:24:35 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n15sm6311862pjj.12.2022.01.12.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:24:34 -0800 (PST)
Date:   Wed, 12 Jan 2022 18:24:31 +0000
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
Message-ID: <Yd8c3zlTweSGhwtt@google.com>
References: <20220104194918.373612-1-rananta@google.com>
 <20220104194918.373612-2-rananta@google.com>
 <Ydjje8qBOP3zDOZi@google.com>
 <CAJHc60ziKv6P4ZmpLXrv+s4DrrDtOwuQRAc4bKcrbR3aNAK5mQ@mail.gmail.com>
 <Yd3AGRtkBgWSmGf2@google.com>
 <CAJHc60w7vfHkg+9XkPw+38nZBWLLhETJj310ekM1HpQQTL_O0Q@mail.gmail.com>
 <Yd3UymPg++JW98/2@google.com>
 <CAJHc60yPmdyonJESHPHvXJR+ekugZev4XzsZc2YV2mnfBdy-bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHc60yPmdyonJESHPHvXJR+ekugZev4XzsZc2YV2mnfBdy-bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022, Raghavendra Rao Ananta wrote:
> Understood. I'll move it to arm64 and we can refactor it if there's a
> need for any other arch(s).

Before you do that, can you answer Jim's question on _why_ arm64 needs this?
