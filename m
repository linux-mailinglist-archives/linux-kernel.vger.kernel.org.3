Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD47D4A913A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiBCXfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344366AbiBCXfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:35:00 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F736C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 15:35:00 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y84so5430846iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 15:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ne0ZORFuDwUgC8aqjM4wX7CGP1Jo0bJOP46NZX2Toec=;
        b=leTpdfQNd4Zn0saReF9TO/gg+VcdQoP4DjI+kekHOxiXWyfA/GeCtp0hAXnHnMUTA6
         Looo4GggkZqHbndOQYLS2Va/7moL6leCED9FQ8FGDQjgnCCSnH5ttAfSTRNgYzHKYRfP
         hSVz7icboF/YLN4P0DwkKx5c1SF7Bb8ts6YM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ne0ZORFuDwUgC8aqjM4wX7CGP1Jo0bJOP46NZX2Toec=;
        b=GgioQNAKx8kXUcYy5APlW5PiDXVC/W0Ijw8jiAHG/2iay8Ia0J7ovWrJwbkSWRW0Vg
         KUtOGad8Sziwna+vmikEyH+JL5sjFLTZCKsGcTLdw9s0IkCpxVwMItvJGPDDv7b5M4dx
         1qyC4HQ04L4zh6P1qNdNc/F6SEW39rfH8+ecolf6FoRxK6PLHkMacAGMTVVzH/tnBuuw
         F0zBnDhImVtxWmnv/NxCmPtks0Mz/UuxRfwMpo6eigYf23rpyllraTNbMPYQLhFFtgLA
         HsfApgIDtHi3b6RA/k6wZp1lAd1p78yPMkm0EZ2N2/NYX47tqTHpUs1rOq/GQ3eDJqaM
         GBlA==
X-Gm-Message-State: AOAM5313CzNn/fIOGiXVIpOpPr9sIIUezdFCcMzEQfKfCeST2QSl5vpW
        Yks19hnmLEKB7kww3l5MBOe0K5gArcGHBw==
X-Google-Smtp-Source: ABdhPJzIeZNqv4KBAMEGHoihiYJL6cpAiGpD5KaDoPRBH4ZYPf77CpO97T6Bj9nvcKDGY5p5pWz3Xw==
X-Received: by 2002:a02:7f02:: with SMTP id r2mr154443jac.148.1643931299444;
        Thu, 03 Feb 2022 15:34:59 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id q9sm103650iop.30.2022.02.03.15.34.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 15:34:59 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id z199so5324116iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 15:34:59 -0800 (PST)
X-Received: by 2002:a05:6638:168d:: with SMTP id f13mr140596jat.44.1643930826719;
 Thu, 03 Feb 2022 15:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20220202212348.1391534-1-dianders@chromium.org> <20220202132301.v3.12.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
In-Reply-To: <20220202132301.v3.12.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Feb 2022 15:26:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XXFEM4u78qQZoGrdxpSTjdjWQ_01m+af_Xz1j_TNNDJw@mail.gmail.com>
Message-ID: <CAD=FV=XXFEM4u78qQZoGrdxpSTjdjWQ_01m+af_Xz1j_TNNDJw@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 2, 2022 at 1:24 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> +&pcie1_clkreq_n {
> +       bias-disable;
> +       drive-strength = <2>;
> +};

As per the discussion [1] then maybe the above should be
`bias-pull-up` instead of `bias-disable`. I'm happy to spin this, have
it fixed by the maintainer when applied, or do a follow-up patch to
fix this. Please let me know.

-Doug

[1] https://lore.kernel.org/r/CAD=FV=UKKZaHHz3-idahLg-ey3xmSZWKeTVVipzpZNQAkUVKmQ@mail.gmail.com
