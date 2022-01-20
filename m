Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83232495705
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348114AbiATXeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiATXeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:34:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF5C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:34:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u11so6762591plh.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W8u4xvb9YGTbkR+XB2tficjJLp06bXV9VHY3GrFF5AU=;
        b=kjnvRURd0d5x4xaHgLsQrLQFFTt+6yuhoqo3w1AgYdyRqMIxqjqTk1Abi+NnFy1KoR
         2S/bTBbPiE9z6gFVosCCBEaPqyADyS2hQbiyxp7FMquiOAB+5EulTVKKnC8kTYEy/OuS
         8YIa2ev/7/gxr61vJa9wq41lGpWwuDmLHruro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W8u4xvb9YGTbkR+XB2tficjJLp06bXV9VHY3GrFF5AU=;
        b=qhwTefzpxHNty+iDpClyP0sbxrh5omt1f173VcZ4ZdYEbfVPAvFdK4+Y48VnQ+99XP
         l7cvOYqKj3iB06+jrC5CKCRjCAO4yApBTa96XLtyI/nVfIrktpgj2oMIHM5ogy68CPdz
         6fctWjxhROkF5rMQM4GofdNCxI2o8e+jplqrBcEvQgd5GINbTa8UUgrOmTnMnMK2C7jM
         RphROjvzteaqaS/Fnzr2yesRjLMxuGP1S745I00ryyQ5gZPEFndD0cDRNcqw0oLvwuta
         zyZ9j9tBoYPPlPc5GGHbm0Vp1wunzsEyZY2JVftqKxYrtft4Z2LdB5myc1qjU/yKjwkC
         TlvA==
X-Gm-Message-State: AOAM533VzVvLJov8O0WzVR12tVDBQe7atfCwPYL4ATT3LH65GqfKdWUe
        PjzLwjWslc2KtlLioo35b3fFdA==
X-Google-Smtp-Source: ABdhPJwU4q/RhAzX8q32y3IhhvwpRjOdIOJmRH0cShdwRxJhGaw2bCqB3Cy8q1CLWCJ0I+0xU8z7EA==
X-Received: by 2002:a17:90a:4305:: with SMTP id q5mr13751808pjg.222.1642721643308;
        Thu, 20 Jan 2022 15:34:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm3168035pgb.85.2022.01.20.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:34:03 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:34:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] NTB/msi: Use struct_size() helper in devm_kzalloc()
Message-ID: <202201201533.975AD386E@keescook>
References: <20220120230247.GA40182@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120230247.GA40182@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 05:02:47PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/ntb/msi.c:46:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Heh, the variable was even named struct_size. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
