Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FF05281F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiEPKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242802AbiEPKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:25:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFFBDEF5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:25:02 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f4so15373841iov.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTo0qY4qQgxJkitwVcq8KgHfBlJlWID4iFoIHlxueiw=;
        b=Dru+4XMrLKy46CAqyjByKC4XWPFK0jI7p3XA5l6APRqrSdI96JioqoD0fQvTtDjqzJ
         Mom8RxPWUtGPP3N2x9FxhMXrKHLEGo8ZWpBxpJ6+WJYvspSkcZih8QXM362BZqBRwC+g
         NMINHuHxAR8LOm3RNBCtJ41enhyyORWyIqPAIEtywX1rCjC2JTaJlXY3NCJgCyxDfa9n
         f1J8ENAxM5i3H2V+YTS0MGpSiOlKnDUVNq3QKBx4o+vekhrE+nT1cg9LdnuA+7uYBEDp
         GRhHsaEqOuI5MwsFJuzFPDbEGympXbYEplB95NtWdooQT1TJag7QL4W9E3O+KkaLCQrk
         DnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTo0qY4qQgxJkitwVcq8KgHfBlJlWID4iFoIHlxueiw=;
        b=VkVWJnu7+S+khNJQQDF1X4jeB6U3Up4FbzSPKlBsKzYLrXLD9uy8ZwlBH21Dpodazw
         pbLzhBt8FI23om9bedVPUqf/k9ZB1FKTyQhrLtp95iiXhhju46NRa+mt99BkI3NdVE4g
         zZ7jvNhbElk2e1TPa28lHMOdVKMwSbRmp/iY0GKcTmo9zkpgPokkcDlLaRHVGjttH8BD
         D/lBDGAlw98TtilatFZFEPAIl2Ep1LzJPTXTcmBR+k42oWubH/3hs8AVoPCmUvgDOR2M
         xoxU1rxjLKWc/n7gNBqS9r5x8khbbuRCP4vtyLZ77F1t0Ox1qXH7XCvFn/RA3QfBRtbU
         3IYA==
X-Gm-Message-State: AOAM532gA2unBeAHfISdddfL+75nlw4KU7Bq/7RQ/ykz1rDbvyDW9za2
        K4r0mZ7hVCaBcpwMlJM974Y7rytlFwKGKZB44rLd6w==
X-Google-Smtp-Source: ABdhPJxiwg+0C7eGGBCGUJ2Uvvu9Z4mJHyrzmaFOQeqpjtSlh1vTjwGP84gHeqkbo/KAnQd30xfguEZ8O0e+03cYWEE=
X-Received: by 2002:a05:6602:1591:b0:60f:6acc:6979 with SMTP id
 e17-20020a056602159100b0060f6acc6979mr7772505iow.173.1652696702110; Mon, 16
 May 2022 03:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220516030251.42323-1-schspa@gmail.com>
In-Reply-To: <20220516030251.42323-1-schspa@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 16 May 2022 11:24:50 +0100
Message-ID: <CAKohpo==gvvyd2HxL3sLTqXS-VbFeprkgAdSAjU3mnbq4Qn-Jg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] cpufreq: Abort show/store for half initialized policy
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 at 04:03, Schspa Shi <schspa@gmail.com> wrote:
>
> If policy initialization fails after the sysfs files are created,
> there is a possibility that we may end up running show()/store()
> callbacks for half initialized policies, which may have unpredictable
> outcomes.
>
> Abort show/store in such a case by making sure the policy is active.
> Also inactivate the policy on such failures.
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
