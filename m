Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5B44F9D51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiDHSyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiDHSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:54:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E252E0F1C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:52:13 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id z8so9751240oix.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=EoW9bkJ8VflSJXuIwQtp2KcTvjQOPmURL+x9V0VjqHg=;
        b=GSW8ckhPkiFVaRul+WfqeLsrbmLaMGNalavL8cvzX8O0aUgBBn1slSYEk0HF0y9vgS
         EmteYEybQozNwEed+Wt6E9tD/JRuL9g08gjmSdaC+Cxwt+CeVQI+vpIZFCs7bTuJmnB7
         JBUCQ/EGca0MLMAbZETu6fK4jorOPF8lwpIsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=EoW9bkJ8VflSJXuIwQtp2KcTvjQOPmURL+x9V0VjqHg=;
        b=gOIdWVfg5Y83hUzBqvzhWAgFiRVXXrrCfb+sGRm9H3ZosM0RLp0cKeS2xp6ed0zSHR
         T/QWAuMHdWfRw/ZJDPQMunG0uxgl7llmRrMT0Vuiei1HxbcDxKBIxYUtwXSetQzgS6rg
         NcEV2CIyXdtM17CSyQxH0Tcn+LL85rmNhnynXrlmUn6yf063/7Ptrasxe07RkNXFsNY8
         n95ZVBko9MXdFRaoCcg++JCkEOFTQPKkygTi5a2B1G/BN8SRAebmnsZ7rRieJOKIsNGy
         HnqaZ+q4DCCAJM6brIaFXCW+mRXgVaTUmu5odGpJ9/TVLCwQc7N8Qhul9k78qUlWXvyC
         jVUQ==
X-Gm-Message-State: AOAM5326HAEz1+lRVRpEf/0eWK6elY0IXcCA6pK+UCpAV+YGdgoBmPaa
        XRXYUXUBrYyvuOfffXvQQQ8Zv1JJfz+/0YuuyQCxiQ==
X-Google-Smtp-Source: ABdhPJz7pgTBza0Mz4Z5wC7O8xeXx5dmzt15mxveNuTH+LjbdzzlMTUO0LWujntIxqApxVG6BGbkxsW+xZZGDVMt9YY=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr534515oie.193.1649443933201; Fri, 08
 Apr 2022 11:52:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Apr 2022 11:52:12 -0700
MIME-Version: 1.0
In-Reply-To: <CAE-0n52xQ+SbwpDfzuW-tMLJP17Z2qog2s_pS=XBTULLNpUkLg@mail.gmail.com>
References: <20211125174751.25317-1-djakov@kernel.org> <CAE-0n51xeigKFS9Zek44HZGD9cdc4Em91aQ5HHzuy7P1FBmfFg@mail.gmail.com>
 <CAE-0n52xQ+SbwpDfzuW-tMLJP17Z2qog2s_pS=XBTULLNpUkLg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 8 Apr 2022 11:52:12 -0700
Message-ID: <CAE-0n53b3_mjXDP=W6XHQ9_5NEh7ee1GV6jQUSxtgE864A1ONw@mail.gmail.com>
Subject: Re: [PATCH v3] interconnect: qcom: icc-rpmh: Add BCMs to commit list
 in pre_aggregate
To:     Alex Elder <elder@linaro.org>, djakov@kernel.org,
        quic_mdtipton@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-04-05 21:47:07)
> Quoting Stephen Boyd (2022-04-05 16:00:55)
> >
> > It would be good to pick this back to stable kernels so we have a
> > working suspend/resume on LTS kernels. I tried picking it back to
> > 5.10.109 (latest 5.10 LTS) and booting it on my Lazor w/ LTE device but
> > it crashes at boot pretty reliably in the IPA driver. Interestingly I
> > can't get it to crash on 5.15.32 when I pick it back, so maybe something
> > has changed between 5.10 and 5.15 for IPA? I'll try to bisect it.
>
> Bisecting pointed to commit 1aac309d3207 ("net: ipa: use autosuspend")
> as fixing it. I think before that commit we weren't enabling some
> interconnect, but now we're booting, runtime suspending, and then
> runtime resuming again. With the sync state patch I suspect the
> interconnect bandwidth is dropped and IPA needs to use runtime PM to
> actually turn resources back on because it assumed that resources are on
> when it probes.

I also found that when I make CONFIG_QCOM_IPA=y (and subsequently
CONFIG_QCOM_Q6V5_MSS=y) I can reproduce a different crash in IPA on
5.15.32 and 5.17.1 LTS kernels. I suppose there is some missing
interconnect bandwidth request somewhere and the runtime PM patch half
fixed it, except for when the modem and IPA drivers are builtin. When
the two drivers are builtin they drop bandwidth requests earlier because
they probe earlier. My guess is that the IPA driver is missing a
runtime_pm_get_sync() call somewhere and accessing a register that isn't
clocked. More digging...
