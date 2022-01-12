Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD648C828
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355127AbiALQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355176AbiALQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:20:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B8AC061201
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:20:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso13071538pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8P3NbvLtm/sHGFjlL5IbXRJr6Wgq4sdrM5EN9QSrHU8=;
        b=Pot0TKlWSTcrjniZWpHFupf9AZEsXBw/FWT//gwIdi2N2lf5MV+gnpkruPceUkydfp
         rzgLMeerZVjI+nV6hOmobpWmPv79GJIiHdFGSEgYalnCBtUYNAdH/7q5QC6QHxtpyPqi
         SUzvF9LYn3OsPZMewOWX1udBtWFAYZmXuYVCtXyemw+2knX2hjwpeWEamkr7S/o2gxB6
         jw0M2+YWQ8RwuRfg8LYXIJfb7S1rRarS8PSxsmC0dZgHJmiUup6mygyhGRiWbJH6evyl
         tSuPfqDPnXbuK7BzFwCgWfBeNGv3DmKFsaVypklSyaARaMDXTp9aeQbxcUF1ACT08iSa
         1ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8P3NbvLtm/sHGFjlL5IbXRJr6Wgq4sdrM5EN9QSrHU8=;
        b=1F4olJTPEr+udLVvRyz02wMUY75/m1jLbKsTix0NmB9SjKbAA0TQvBvSV22mZuig9N
         YBNfNiC73uvJrEb3wf0JnQ63rm606i8qCZZNq77pWHOR8TEfEWmYrAxx6AaDemne28aM
         O3S+bSz0RY13ElUi/5TNMivtjVchdsxhrsiMmxWY2sOHhcrxquvr25SjKwSghbJEGAHU
         B8OENgwHoTOZ3EBjSU06hogT5slEbSHnEo4wKSR006rcERRs5RAoFspnhHW8NaFj/szY
         YY/lDkEK7UHsnMy66aiataJojwzmspRzUCfvrfLgY/5n/ok4tMavtvr8TiGHFNPq8o9d
         hUQA==
X-Gm-Message-State: AOAM532WZqOFRh1gDubYnWYKkD5+Hmi+CT1q3MMR1mtXJxZzaX9Ak24y
        IqDyh5hYdyJDA90K7ZwKB4h/0w==
X-Google-Smtp-Source: ABdhPJxIMzVSsbcRDTJVXSyYABjcwRSX4/H7Hg85BbmPlqFpOU0lQuAwIQSRysKKI0o2vDK5Z3qdPA==
X-Received: by 2002:a63:2acd:: with SMTP id q196mr391306pgq.370.1642004429118;
        Wed, 12 Jan 2022 08:20:29 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k2sm126788pfc.53.2022.01.12.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 08:20:28 -0800 (PST)
Date:   Wed, 12 Jan 2022 16:20:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Make the module parameter of vPMU more
 common
Message-ID: <Yd7/yUFQr3pbqVCi@google.com>
References: <20220112040116.23937-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112040116.23937-1-likexu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022, Like Xu wrote:
> ---
> v1 -> v2 Changelog:
> - prefer we keep "pmu" for the module param; (Sean)

...
> +/* Enable/disable PMU virtualization */
> +bool __read_mostly pmu = true;
> +EXPORT_SYMBOL_GPL(pmu);
> +module_param(pmu, bool, 0444);

Sorry, I should have been more explicit.  What I meant was this:

  /* Enable/disable PMU virtualization */
  bool __read_mostly enable_pmu = true;
  module_param_named(pmu, enable_pmu, bool, 0444);

That way KVM can use "enable_pmu" for all its checks, but the user only needs to
type "pmu=?" when manipulating the module param.
