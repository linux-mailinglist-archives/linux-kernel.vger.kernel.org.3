Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5644EBCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244401AbiC3Ing (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC3Ine (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:43:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A32E023
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:41:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so5504459pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rwRSBUSEXA3FU34gTo5hg2hs3IWB6XODlZLxIewn3eE=;
        b=ecMHkjGuiBbhyGV8JLkyQK2ociRxD/0kaM5ciztGvXYXwWhhSRmWrSzdij4XKcmh+k
         0dzxl9xeLie6Q72LgQBVQTawH70WWM6keTZ99EhtHFxXFU1sQLIx/v4Ki8K28DffuLHC
         lh3ooGHsfo3FiPPYx9BMku7xMdRuuGc3hUL/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rwRSBUSEXA3FU34gTo5hg2hs3IWB6XODlZLxIewn3eE=;
        b=sXz5PEzA8d12AatKz13BbBqZ6ms5DZwcbvckti1fi9KJuGIUzff2tz9Tv13c4lZ8W8
         s5SyH7M1RXixJCcxDTjyVll1KS2s0wtDu1B9lm3OwQR1MzI0OXIndGf1jhtIxmrKgpPI
         r4+bKZNyCWqtd37qFuVq6WK+0qDuBur/h2F0WBBN5mtRP/hOxyB0y3eanG7d0aJ2LLZ1
         ckxuiESPyY4UfplVxk+cejWK4xa9GDrVnloYxFt5BNc1qlzNlnanlIv0XQ6soHyTaEnk
         IkHQA3ZnB/aQlAwtxarz1ZSw9LkM/3Qofv2+K7apvbQuV/7B8h0g7w5g7Ym+pANWwvNz
         j8YQ==
X-Gm-Message-State: AOAM530Wh0IJSQYu9asFHsJaZT4ZkTUTJv6JCzryRxM2LaD6aJIka9NX
        lM68b6RapUl3FEk6umVBcR7kJA==
X-Google-Smtp-Source: ABdhPJxIp3XBSt2ygSCHL+Tg+EAz9v3I25lJmzsOMUSgz7ZKDrdINXYOsnUvVEkgWDq/yB3LCz/lPA==
X-Received: by 2002:a17:90a:930b:b0:1bf:ac1f:6585 with SMTP id p11-20020a17090a930b00b001bfac1f6585mr3763996pjo.88.1648629709315;
        Wed, 30 Mar 2022 01:41:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1719:a115:46dd:6b80])
        by smtp.gmail.com with ESMTPSA id pj9-20020a17090b4f4900b001c744034e7csm5979133pjb.2.2022.03.30.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 01:41:48 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:41:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, s.suk@samsung.com,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH] zram_drv: add __GFP_NOWARN flag on call to zs_malloc
Message-ID: <YkQXx+pLr6FxY1XZ@google.com>
References: <CGME20220330052214epcas1p250cff6b3168a1c9c253e1fe70e68ca8b@epcas1p2.samsung.com>
 <20220330052502.26072-1-jaewon31.kim@samsung.com>
 <YkQPefdRc+hxIXEV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkQPefdRc+hxIXEV@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/03/30 10:06), Michal Hocko wrote:
> On Wed 30-03-22 14:25:02, Jaewon Kim wrote:
> > The page allocation with GFP_NOIO may fail. And zram can handle this
> > allocation failure. We do not need to print log for this.
> 
> GFP_NOIO doesn't have any special meaning wrt to failures. zram
> allocates from the memory reclaim context which is a bad design IMHO.

Agreed.

> Is the memory allocation failure gracefully recoverable?

No, it's not. I agree that we want to see that allocation warning
in the logs.
