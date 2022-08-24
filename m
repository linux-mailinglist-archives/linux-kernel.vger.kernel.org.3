Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2421B5A0043
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiHXRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbiHXRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:20:20 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97DC76461
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:20:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j5so20138369oih.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=DVN+kvFqLv3mGTVIxFamxzUyeVLq+KBt3jBa97DqaoU=;
        b=nnDk31vCn++BAX0ACZQufoWbrcwPKEk+tndItNgTkMek12/3f2xauugQZ0Awk4pZWR
         +fxX0bmMzr4/HLuAejtjNsLcELQl7IUh6QZ/Lxfk2T+K3vx2vdHcIAyB3TnHrSZcMmT5
         eXMPeRw6UlXCoRJT5O9S+lTtPoXegs8dNzjqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=DVN+kvFqLv3mGTVIxFamxzUyeVLq+KBt3jBa97DqaoU=;
        b=AstDGKq7PqtcH/O540tcNdBcJHgySorVVyADdGhDSLYIVBcyGoGlCYP2LmlQey0xMz
         91+D+mqutqRJBD94iG6izqRfv+UViwfT5Q8gVecuhJT229cp+ls8CER54kEaF5cXwV6d
         dbsOyTVF42skVxKuez5bszVhoXOIyuJBwxVLvwOOPKFhxWC4qoeAEFO32LrP20Au/5oy
         sRmg9fLZQlSBXYIhFhDZM0PZCP7NrHMS5tbT/KCjsp54hGjExCyH6tfYQMxb70ldCMOj
         hJ0sNu5cM7M4AUOI3uxidJQbxCMF9089/gwoeJedJNeQZMtrhNTbOI227atmQuncX9Pp
         nciA==
X-Gm-Message-State: ACgBeo0w7SbA4xFI8yvqCVkzWNEUiaHX7fxkKeWUnQc1Dc8E1SXg3aGR
        1k2z/oo7aVBFNlDmWhsBWsAWKmVyfx5GkXevKTfuTg==
X-Google-Smtp-Source: AA6agR5PnC3mwI2SVPrcxba73qqYafzKnOOisZpg3cDUuE7oPrzR8QObFqc8sFV6WGYMv+qZDebB4x6n2Hc6qexU8Nc=
X-Received: by 2002:a05:6808:1142:b0:343:86a0:dedc with SMTP id
 u2-20020a056808114200b0034386a0dedcmr96050oiu.44.1661361618193; Wed, 24 Aug
 2022 10:20:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Aug 2022 12:20:17 -0500
MIME-Version: 1.0
In-Reply-To: <3d052733-3600-b6eb-baf3-d8806a150af3@quicinc.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
 <CAE-0n500y-n+ZjasYQRAa3JgamQG1c+Aqn0YiX-i0L-w6C4dbQ@mail.gmail.com> <3d052733-3600-b6eb-baf3-d8806a150af3@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 24 Aug 2022 12:20:17 -0500
Message-ID: <CAE-0n53oMnnn7rOPEiibc=XM52z9THDc9jYhe3x3C_AsLtmARQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] PCI: qcom: Restrict pci transactions after pci suspend
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        dmitry.baryshkov@linaro.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
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

Quoting Krishna Chaitanya Chundru (2022-08-23 20:37:59)
>
> On 8/9/2022 12:42 AM, Stephen Boyd wrote:
> > Quoting Krishna chaitanya chundru (2022-08-03 04:28:53)
> >> If the endpoint device state is D0 and irq's are not freed, then
> >> kernel try to mask interrupts in system suspend path by writing
> >> in to the vector table (for MSIX interrupts) and config space (for MSI's).
> >>
> >> These transactions are initiated in the pm suspend after pcie clocks got
> >> disabled as part of platform driver pm  suspend call. Due to it, these
> >> transactions are resulting in un-clocked access and eventually to crashes.
> > Why are the platform driver pm suspend calls disabling clks that early?
> > Can they disable clks in noirq phase, or even later, so that we don't
> > have to check if the device is clocking in the irq poking functions?
> > It's best to keep irq operations fast, so that irq control is fast given
> > that these functions are called from irq flow handlers.
>
> We are registering the pcie pm suspend ops as noirq ops only. And this
> msix and config
>
> access is coming at the later point of time that is reason we added that
> check.
>

What is accessing msix and config? Can you dump_stack() after noirq ops
are called and figure out what is trying to access the bus when it is
powered down?
