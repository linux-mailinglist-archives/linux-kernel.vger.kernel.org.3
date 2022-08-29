Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99E65A5745
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiH2WuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH2WuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:50:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69289120B6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:50:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u6so11927459eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BdK6wFzGAjAWXTvHTiu/Q0qZEI64G9YTiM4Y/8WjD6k=;
        b=p69IAoQeGDoqnLVXpl/x2o8SFwhNMcMzOGY9mElkAAfh9Gk/YzswoUnYRIrBVuZENs
         LLpHcnrFhMY9IVuFlsy8oxk6P+WF+PTyaOUZLw5qTwyP8jD97mPttwi7gte3lswgTQ2B
         5OXGdsUxpmDgVnV+9MVy9D6UqUVjQ/nT8fdSUO0iMa25KfNn3k6Of/4tY5CdPxwRnI7t
         eGWZjv6hfhbJX1HeATEluXpJqCE+9MbQMq2kV6TqIzpuyEzq6NBKRiikTyT8yqBFhYeL
         3e3uEbOS9pkHWcLaM6UvVKhrJIwvTR4gLu3lDjatiNR01GVqDuBML7jbvmcBiFI63iPV
         WT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BdK6wFzGAjAWXTvHTiu/Q0qZEI64G9YTiM4Y/8WjD6k=;
        b=n5TiLYIUcBgnat3rRdc0Z2U82lCEyd9Nt1JabJHxKL7j/8zj2SRNeFe5XpLAWtBu3u
         rMKRngGAG7xAFuxlOIzRoHvv8kIwsqxQ1AnNcWxI0HFwseieuC1r/AKPwb354nV/bMqx
         vo34U/DzVThZ2di4LCqwBT6CcqtyTYVUn6Yxe2If5V6dFDzWYyO3tOtpV2PsMaQbR63b
         cEIC6JVB6MgDjrRFqLy4T6GcEsK9YTcnLlw2n99XVJeTkR/rFdTlzjnFDd5ktMgwfDk6
         kyxT4gqYOC4cIH+J/oA5pCRWFfyllNOzm2xGqy+HakGcIiPr9b6Lmimo3+IV6bCe70vW
         zwqQ==
X-Gm-Message-State: ACgBeo2VCHyoNtZunJil3iJtGKRFk7SAQcnnq9uHXTpDEZ0AaehHRqPQ
        7mG269tZaPcZEDS70N+tJfMcBiODi9vQuhjUg2qP8A==
X-Google-Smtp-Source: AA6agR7OG4e5zZDY58ZsZNG6O8PjNDpVwMESbUm6NkLMPzH7GilF7Y3CTKcrJewEMHz/sEsTvHHWM7rVdK39sFUtu5s=
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id
 fj13-20020a0564022b8d00b0043a5410a9fcmr18122157edb.99.1661813402834; Mon, 29
 Aug 2022 15:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220810234056.2494993-1-npache@redhat.com>
In-Reply-To: <20220810234056.2494993-1-npache@redhat.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 29 Aug 2022 15:49:51 -0700
Message-ID: <CAFd5g456Xjk7E9GdO_CXNKitzGha76qOK5R6gKSE9-8+s6-ucA@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix Kconfig for build-in tests USB4 and Nitro Enclaves
To:     Nico Pache <npache@redhat.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, davidgow@google.com,
        skhan@linuxfoundation.org, dlatypov@google.com,
        brendan.higgins@linux.dev, alcioa@amazon.com, lexnv@amazon.com,
        andraprs@amazon.com, YehezkelShB@gmail.com,
        mika.westerberg@linux.intel.com, michael.jamet@intel.com,
        andreas.noever@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Aug 10, 2022 at 4:41 PM Nico Pache <npache@redhat.com> wrote:
>
> Both the USB4 and Nitro Enclaves KUNIT tests are now able to be compiled
> if KUNIT is compiled as a module. This leads to issues if KUNIT is being
> packaged separately from the core kernel and when KUNIT is run baremetal
> without the required driver compiled into the kernel.
>
> Fixes: 635dcd16844b ("thunderbolt: test: Use kunit_test_suite() macro")
> Fixes: fe5be808fa6c ("nitro_enclaves: test: Use kunit_test_suite() macro")
> Signed-off-by: Nico Pache <npache@redhat.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
