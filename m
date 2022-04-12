Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC464FCE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbiDLEuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiDLEuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:50:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE5B2E9C6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:47:50 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r8so17907576oib.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=YYQEo5j2Ii2p8H5ZS23pXYIYx499iXk6axIZJFS2N9g=;
        b=XMxVGa8AckEYdPLkkCRkFLuRVmw86/dj5NmmRDa1LrlJAmpn2bPhnrXLqyi9ChrDlB
         UdUuyxhKHjNRmPSZFzJtTxTH5ep14tjJzZIpkJfcht7E9C70t3K1j3ACnHmF5GyXIfr4
         IaxkhWdpJTFKYmTTuZyfyIl78+vPVYyDqBSeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=YYQEo5j2Ii2p8H5ZS23pXYIYx499iXk6axIZJFS2N9g=;
        b=FB+7Aytind6qrsAKJaqcueFWVuLlrWLOpWPmnU99NufYxk6BesIA3Nbet/t9QM/Gtv
         a66uzCnSGjwrimy9kx2H7aAbjFQ9U8nIgUxT31H1rLURWxvm82VMT19D4PqtktnpOvM4
         AnocAtUGVFkXMKzlHQ6mA59jjURZ3XmiWTWIvcjWNYXZP880/FTZ+TWyb3fERjlyCoSR
         844vHVYbwUXRZxXrasIOuArHnLNN0gNbdh8FyIUeUL11C0NwBxtEqAbQujxJvdox5p4e
         gT7brevOnnYf83o/YDnQiPM2uMuiN61sX6RTsMuO5lo8OSRKytkZctJe/e8MZts3QhtB
         Iuow==
X-Gm-Message-State: AOAM533f0KrWIFBAXklNtjfHs1A8DE9/YI+ySasncdEi1VoJ6QfN8QeO
        CT/s+6YPrcQBehK6tDnWus5mh1vnjvfvCjtkkItQcQ==
X-Google-Smtp-Source: ABdhPJy3ENRm1IsCajLk61o+xCdj4yulCsVNsBguR1dqMjmKhpW3tu/Z+AUrgZ0reqgxkhlEO75blvagp+uFa41xz3I=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr946369oie.193.1649738869745; Mon, 11
 Apr 2022 21:47:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Apr 2022 00:47:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAE-0n51ho9Aia5eUjsvkG3e7rjxjdVMD7CS4XEhYKNUKbQam+w@mail.gmail.com>
References: <20211125174751.25317-1-djakov@kernel.org> <CAE-0n51xeigKFS9Zek44HZGD9cdc4Em91aQ5HHzuy7P1FBmfFg@mail.gmail.com>
 <a96a010d-9bd7-f760-3c03-d842feef41aa@linaro.org> <CAE-0n51-hpG_5O11FbGrHaMr_mN0ZAky8CVzZNmDj29aK8wGog@mail.gmail.com>
 <CAE-0n51ho9Aia5eUjsvkG3e7rjxjdVMD7CS4XEhYKNUKbQam+w@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 12 Apr 2022 00:47:49 -0400
Message-ID: <CAE-0n51eRP0tsAR9qm_OSZAjv=EceOaG3OaA1UQYLk=7nbSrqg@mail.gmail.com>
Subject: Re: [PATCH v3] interconnect: qcom: icc-rpmh: Add BCMs to commit list
 in pre_aggregate
To:     Alex Elder <elder@linaro.org>, djakov@kernel.org,
        quic_mdtipton@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-04-11 13:20:27)
>
> I think it's some IPA unclocked access because it's an SError async
> abort. I looked some at the IPA clk implementation and it is a little
> concerning. I see two problems. The first problem is that clk-rpmh is
> only voting on the active state for the IPA clk. Maybe RPMh will move
> the sleep/wake state over from the active state automatically as long as
> we never make a request in either of those states? I don't know, but it
> looks concerning and either needs to be fixed or a big comment
> indicating that the copy happens. This patch makes it set a frequency in
> each state bucket.
>

This patch doesn't seem to matter. I think that's because RPMh copies
over active state settings to sleep and wake state automatically if
those states are never changed by that processor. Someone at qcom needs
to confirm this theory. I'll send the patch and see if that spurs
someone at qcom to respond.

>
> The second problem I see is that the IPA clk resource is "IP0" but it is
> still defined in the interconnect/qcom/sc7180.c file.
>
> $ git grep \"IP0\" -- drivers/{interconnect,clk}/
> drivers/clk/qcom/clk-rpmh.c:DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
> drivers/clk/qcom/clk-rpmh.c:DEFINE_CLK_RPMH_BCM(sdx55, ipa, "IP0");
> drivers/interconnect/qcom/sc7180.c:DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
> drivers/interconnect/qcom/sc8180x.c:DEFINE_QBCM(bcm_ip0, "IP0", false, &slv_ipa_core_slave);
> drivers/interconnect/qcom/sdx55.c:DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
> drivers/interconnect/qcom/sm8150.c:DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
> drivers/interconnect/qcom/sm8250.c:DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
>
> That sounds pretty bad because it means both interconnect and clk frameworks
> are trying to control the same RPMh resource, trampling over each other.
> Combine that with unused clks and sync_state support and I don't know
> what the state of the IP0 resource really is anymore.

Alright, some more debugging has confirmed this. I put a print in the
rpmh driver to figure out when the IP0 resource, according to cmd-db, is
being modified. Luckily, the interconnect driver uses the rpmh batch API
while the clk driver uses the direct write API. I put a dump_stack()
when the batch API is called on the IP0 address and that sometimes gets
zeroed out (i.e. IPA clk is turned off) after the rpmh clk driver turned
it ON. The rpmh driver in the kernel doesn't do any aggregation between
kernel clients, so the problem is this sequence:

	IPA driver probes
	runtime PM get()
	IPA clk enabled -> IP0 resource is ON
	interconnect zeroes out the IP0 resource -> IP0 resource is off
	IPA driver tries to access a register and blows up
	
The interconnect framework is zeroing it out now because there's a
sync_state callback once all drivers have probed. This is why I saw it
more easily when the IPA driver is builtin vs. a module. The IPA driver
is much more likely to have turned on the resource before sync_state is
called, but the use of autosuspend made it variable. If the IPA driver
autosuspend callback is delayed just enough, then IPA will turn on the
IP0 resource via the clk API, sync state will turn it off from the
interconnect framework, and then the pm_runtime_get_sync() in the IPA
driver will skip powering the clk on again because it never turned it
off. The runtime PM state of the device is correct, but the clk is off.
Oops!

I think changing the IPA_AUTOSUSPEND_DELAY define to be multiple seconds
makes it even more likely, because then the IPA device definitely won't
be suspended by the time interconnect sync state happens. Anyway, this
also explains why the IPA runtime PM patch made things better. Sometimes
the IPA device will be runtime suspended, and thus it will power on the
IP0 resource on runtime resume even after interconnect sync state
happened. This is the situation on v5.10.y, where runtime PM isn't
happening at all, but sync state is once commit b95b668eaaa2
("interconnect: qcom: icc-rpmh: Add BCMs to commit list in
pre_aggregate") is included. The IP0 resource is guaranteed to be turned
off after sync state drops the request.

So the fix is simple, completely remove IP0 from the interconnect driver
so that sync state doesn't turn it off. Then the IPA driver without
runtime PM will work because the clk resource is turned on and kept on
until system suspend. When the runtime PM patch in IPA is applied, it
will also work because runtime PM will power things on correctly, or
keep them powered on because autosuspend is delayed.

I'll send this patch to the list shortly. And split it up for the other
drivers too.
