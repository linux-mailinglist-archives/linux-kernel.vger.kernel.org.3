Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519184D4E42
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbiCJQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbiCJQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:14:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB29DE1B59
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:13:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so5654606pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lEOkrVgcJZdOpXrqIK9Xwy4NV75c7mrQ1k1DVuFpKnM=;
        b=b7OhXiqUJ2oyKnp9Y21BDXMjY0kk/egOkrjh5HRAzYzuD2yJ9Y5GLXzDNdCVe+41w0
         M+6Ml58nU8iWesUVOP+1aUQb1brA4wcb9XHv0P2ta0jLXsGzuj1YJFQ7H4c2/MZm3dmB
         9YHuxVneWRgHyU1S6GRn4t1fFwfBHHzsUyPdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lEOkrVgcJZdOpXrqIK9Xwy4NV75c7mrQ1k1DVuFpKnM=;
        b=LQysWEu1Xnh7OITPtBoyprmQI7nvaJHdbMmnd0cfKsUZCvu5il0u1nl09K7oOvLq8k
         Nm5R/iBOkHYFcnNnBHAZDa0Y6OXSQHa0DVxPlwgHIQk+fCl7bniE6nZ641SszH1oBe06
         LQB8P4HLa1alO/fnudmkzCbD+N8unEmeAx/DR9wYEgCXP7azGG35E1CWOQx2DzyyMNZ/
         TK+i3VSjEqQHuHUhJQTpbZrHacdIPr85465sxg+AU0o6W6DO1udq6PLUBzi+02fCrEPb
         jzhLZUbGYxeCH/VQH4cBl0I5WqVDwiZTKHycK0CVDwau+SrIDxsstgm9Ogbq/6Oi60mi
         xayQ==
X-Gm-Message-State: AOAM530eNENLjtNL9p6Pk2gvrH2oysbFB+GeqOgPFisfZagTiV88YQyM
        si69Nh9JUlcSQHUHZuq1aoSCt4x39Qt2BQ==
X-Google-Smtp-Source: ABdhPJwjsAQ5MxTwKYyhdw/zQa2nvOjkcVfkmmw8kVfLcawTtqNN7W73CZF8Sm++De1tWvYYY/fvPg==
X-Received: by 2002:a17:90a:168f:b0:1b9:453a:fe79 with SMTP id o15-20020a17090a168f00b001b9453afe79mr17140950pja.107.1646928806494;
        Thu, 10 Mar 2022 08:13:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090aa38600b001bce781ce03sm6348367pjp.18.2022.03.10.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 08:13:26 -0800 (PST)
Date:   Thu, 10 Mar 2022 08:13:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc: add two-steps registration (opt-in)
Message-ID: <202203100811.F2B43DD@keescook>
References: <Yh4fdijvNXE7K88c@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh4fdijvNXE7K88c@localhost>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 02:28:22PM +0100, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Experimenting with new interpreter configurations can lead to annoying
> failures, when the system is left unable to load ELF binaries power
> cycling is the only way to get it back operational.
> 
> This patch tries to mitigate such conditions by adding an opt-in
> two-steps registration.
> 
> A new optional field is added to the configuration string, it's an
> expiration interval for the newly added interpreter. If the user is
> not able to confirm in time, possibly because the system is broken,
> the new interpreter is automatically disabled.

Hi!

As this both changes the userspace API and adds timers, I'd like the
change to be really well justified. Can you explain the conditions you
get into that can't be escaped by just disabling the bad binfmt_misc
entry?

-Kees

-- 
Kees Cook
