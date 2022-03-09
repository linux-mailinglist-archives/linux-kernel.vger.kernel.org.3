Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045E4D3CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiCIWUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiCIWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:20:45 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A8119437
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:19:45 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a5so3488579pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pNaApBBmAFna2/gfVjkwHKrzxYYV5pSIb0D8KRcGP6M=;
        b=Edra+o4fL92NfRATPL5v6vF/V0TkcwKYIgnnYHma8YwOS4i0WsmjFsrFMMfhlppSd4
         nBD/E9cQX4j5Te7eXfotTR7k+uf3HptxEptVcil9oAuPkaT1tpM7kCg60eaEtLwb0RQh
         7UZbkYKhYKUKgfjmm76gLhvwbQrG3LSZeWtQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pNaApBBmAFna2/gfVjkwHKrzxYYV5pSIb0D8KRcGP6M=;
        b=zYvbiIyOC6ADE8DDylhTh13+zWxl/ZTIa4gQaUvaFKpUO391WlnzkKPf0aIgjvOu9u
         81WF27G8PBGFkQawA9fT03v7nKT41RgygE6UTe9IBJWCXiiTMGYDjDKM1LCK8TiJEoez
         WddOQC5ERFCYkIThsaRVEnrEIRJmDMaVVOz8pzgRCTDQctk2d9vw8MDDnkJqlmIBqv6J
         TN+3JTP2AawAGDOy4HBshxEBteqe4H0s7QIXpYl7a0+YyCwujtNgms1EC0GyII/osbR0
         aTArdYo+q1nRwRBo+ekxzsQimJG+xu/NXAAedoCwwh6WYRTp5beCo5q7gFgX81NKKOQZ
         FjNg==
X-Gm-Message-State: AOAM532JG81+dO6rlWclMGWeGW8i7QGhDMeXZtw7vNpEXYq2VVNdGWc0
        x75WWjNI94LLeziiyvlTnTVajA==
X-Google-Smtp-Source: ABdhPJyL33S0mtDwPGQPlFLt227S4brMuc0pI9vpu7L1NEEL4qNMHCoBzfSVcCs+1kD+ijZwHGjGBQ==
X-Received: by 2002:a05:6a00:228d:b0:4f6:d4a8:7f47 with SMTP id f13-20020a056a00228d00b004f6d4a87f47mr1855971pfe.66.1646864385140;
        Wed, 09 Mar 2022 14:19:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm4255105pfx.34.2022.03.09.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:19:44 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:19:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 01/13] ptrace: Move ptrace_report_syscall into ptrace.h
Message-ID: <202203091419.D24EC994F@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-1-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:42AM -0600, Eric W. Biederman wrote:
> Move ptrace_report_syscall from tracehook.h into ptrace.h where it
> belongs.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yes, as others have said, fixing the naming confusion alone is reason
enough. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
