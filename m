Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA14656A919
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiGGRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGGRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:08:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A218D10F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:08:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bf13so6591460pgb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aDwhAz56getKu/7dUfZtUNg+bMQnNfCv/r3Lo81Gt4c=;
        b=OKld0gkkD90FJcYLX8kyBvnUJUDj9BzEcNLpEOkQeEoIWLEfJ2D+KLUYi5d/Q8PoU7
         fjQxBXgI1cNDJZYaFxlz5v1fdwQCKeXJkZtFR5RoS/IDTRWL4cuMqkcJ9PjDItMp5wWX
         cQfcJhh+YhR/nZj1cqhKJ2CtyJIUuzgZP9DjYym+UVyxAz73eOTRQV8nS5lt21HahXSD
         ECMRqQ+Wtp5dAO9uMSd2eec76gtUdPShhuNbCQQpwn+GeFn/m/DVh17yUhgN6YfG/Awq
         ASzsGt9WU4hHjobp076NKKcyYMpGP+arYWU6ObtfpOJF/se0lT+3Q5og9NgLxhiDiJft
         Vr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aDwhAz56getKu/7dUfZtUNg+bMQnNfCv/r3Lo81Gt4c=;
        b=kdKth/gDD4WJWbU6WsSGGKHRv0m5xXAMG+7rt9MfR7NXd+vhFW94GIt9gZFxIqJCg3
         DB3gCnq786DdYAr2lfU/drziT4gZKvbKT7Luf/pERRzHaB3QbOsnCJocgAeHVGXaxHH0
         tdfnPjDH1HpCuTCWzam0WocDTtrPkutg5lmQVVn5X3L1EjoV2FjvbTjWCQaUV1TARfO5
         9oow8+NWphjA4885CKyACs51DWKzZZ/XjJzFgHlyWffxzJ2SVPeaae12OdTa28JzBKc/
         zuItwMTiXl9bbYjg6mSuGiBlBqC2LyW8400lKdoQptKMs/WQVKRjd3mc6sLLR9kjy2Gy
         4VXw==
X-Gm-Message-State: AJIora/dBwpHH1mfIjNNiuoMcuICwzKBqEgHuCZIlyGXMf8miwUR2TVd
        1Vb8GF/ggEz+50YNdDLQ6rvquw==
X-Google-Smtp-Source: AGRyM1ufPqH2WbJJzRXHiO3zNWh9EqE5AA0H0qB0Szi3BpKm2CLKdbn8dZanOb84ZZc4TKI1GbfHAQ==
X-Received: by 2002:a17:903:25d6:b0:16b:f5cd:2cc3 with SMTP id jc22-20020a17090325d600b0016bf5cd2cc3mr14214425plb.74.1657213719848;
        Thu, 07 Jul 2022 10:08:39 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902be1400b0016b68cf6ae5sm23565302pls.226.2022.07.07.10.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:08:39 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:08:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, shijie@amperemail.onmicrosoft.com,
        kvmarm@lists.cs.columbia.edu, Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH v7 00/22] Support SDEI Virtualization
Message-ID: <YscTE/dPQIeiobT1@google.com>
References: <20220527080253.1562538-1-gshan@redhat.com>
 <6bdb9280-3530-dc1f-d33e-5bc1c5ac927b@redhat.com>
 <87iloq2oke.wl-maz@kernel.org>
 <f719c5fb-3e41-38ac-1b16-fcb603e4911f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f719c5fb-3e41-38ac-1b16-fcb603e4911f@redhat.com>
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

On Tue, Jul 05, 2022, Paolo Bonzini wrote:
> That said: Peter, Sean, Google uses or used postcopy extensively on GCE
> (https://dl.acm.org/doi/pdf/10.1145/3296975.3186415).  If it doesn't use it
> on x86, do you have any insights on why?

We still use postcopy, but we don't use async #PF.  Async #PF is disabled (mostly?)
because the x86 implementation was such a mess prior to switching to IRQ-based
delivery and AFAIK we haven't re-evaluated it since that update.
