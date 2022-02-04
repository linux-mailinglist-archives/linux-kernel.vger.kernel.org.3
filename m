Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE24AA2ED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiBDWPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346901AbiBDWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:15:15 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF7C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:15:13 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id c188so9126084iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 14:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc9tivpfIRMekzY3db3T+X+KpuiUHIxykgYorNMpzAY=;
        b=L+fT4PDH2+t16RxVDgAHTAQsmZACpVKJh73Hna2PF28G5x+rSbX9tupHTM+jUmD+yC
         GgVyrkhP3t0MBbegTuFzfEFfefBpKMy0D2vpVAXNOVP54a6I3tsvehHf/NaKKIBZ/Tdd
         JB/B6W40iergpQA67eMzBPNMjRJNLxjwvIYY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc9tivpfIRMekzY3db3T+X+KpuiUHIxykgYorNMpzAY=;
        b=CAW9dBCFtZgQ3AUrUqIDJB93HwZIR2CdzIDDeamyebgMGmgGOdbZuv2+nPUyl/92m+
         9OShLNlLU8KQqSMZpcHay6iFBFjzP1zSXPJDhIo6XQROsNWuzcl/PNG0ocj0HuxEBQNo
         BnumgksATDTaxV42R+UAXW8LEVtiEA4jul8IwVA53C541zWer3AumCLUF3+40gVp7ihx
         pnqk/e+TObHem/w5IKixvvIhOU1dVmnm6opis4/zUSBuRrueFbgSEafTdVK+kmWDbizp
         CeaxTulhLuKMefidy8nqUfITqFlWeKVpe8V1q3od1Hp85isUuCo3hqd1NGuO1BPVAjIH
         mhSA==
X-Gm-Message-State: AOAM531PFXTrhp2X13FZ0vuDMa5bqwxlQdVNqhQZDUl9rzw8AFUXtS6q
        GPOUvoLz4EzEOz3PLYh+PDHlNKGLLdPpTQ==
X-Google-Smtp-Source: ABdhPJwcWoCbOUBPX2mW7GctWSwE7xOxtKymFBpqX2SOEFAU2JcGFAWqK8nRaaMhTmxxGScwCCv72A==
X-Received: by 2002:a05:6602:1507:: with SMTP id g7mr506099iow.7.1644012912307;
        Fri, 04 Feb 2022 14:15:12 -0800 (PST)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id 6sm1548613ilg.66.2022.02.04.14.15.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 14:15:10 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id 9so9183488iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 14:15:09 -0800 (PST)
X-Received: by 2002:a02:cc8a:: with SMTP id s10mr527250jap.263.1644012909511;
 Fri, 04 Feb 2022 14:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20220202212348.1391534-1-dianders@chromium.org>
 <20220202132301.v3.12.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid> <CAD=FV=XXFEM4u78qQZoGrdxpSTjdjWQ_01m+af_Xz1j_TNNDJw@mail.gmail.com>
In-Reply-To: <CAD=FV=XXFEM4u78qQZoGrdxpSTjdjWQ_01m+af_Xz1j_TNNDJw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Feb 2022 14:14:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VDA_=pW0jHPi=OpLf6xhe_Ln_eUPrCAoTzK_qyvb9XSQ@mail.gmail.com>
Message-ID: <CAD=FV=VDA_=pW0jHPi=OpLf6xhe_Ln_eUPrCAoTzK_qyvb9XSQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: sc7280: Add herobrine-r1
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Prasad Malisetty <pmaliset@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 3, 2022 at 3:26 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Feb 2, 2022 at 1:24 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > +&pcie1_clkreq_n {
> > +       bias-disable;
> > +       drive-strength = <2>;
> > +};
>
> As per the discussion [1] then maybe the above should be
> `bias-pull-up` instead of `bias-disable`. I'm happy to spin this, have
> it fixed by the maintainer when applied, or do a follow-up patch to
> fix this. Please let me know.

Breadcrumbs: since most of this series landed but not this patch, I've
sent a new version with the fixup.

https://lore.kernel.org/r/20220204140550.v4.1.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid/
