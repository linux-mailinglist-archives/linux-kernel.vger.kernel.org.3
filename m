Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA8F5175A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386624AbiEBRVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386639AbiEBRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:21:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10658B1EE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:17:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a1so17366759edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1z2xMYMcF+/vzx55XisKKTVU2oHyYL+qwW8wjgY4MBM=;
        b=h7ETZog5UHxteO1Z4h2PQhLAnYd04U27aV7xua2b9cSc5JO0KVa2cLDc2aULBEc47h
         +7xyK8zFhDozHC0NcaeSq+yPdzfKw4I8tQVfSymv2wxIgRPY9qzGbN+uEr/z0UuA/uBu
         l+56NhBePzsTzScSOKtKGJ1236TPfg9G/Bhqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1z2xMYMcF+/vzx55XisKKTVU2oHyYL+qwW8wjgY4MBM=;
        b=mjh/tPdSPFHYqNeu8Otq5qb9fo9Lapc799jO0ErhWdOXNcKAPcVo4l1bT7VVjXi3O1
         rS+izoq4JgVSeY45S/9EMU+1K2dAplllm9wUKAByOLGVxNyofIGMsE7Al1I58xLy0tAi
         YJWci7+MrV9FbCIDL7Fj1qecN+bgo8i8tDpjPeq8kOK7st3YB89KPqBXcYSIJC1QUg68
         gSYJHCJqB3zxCJBvDzZqWyzKGknB9vVm2EzXfKQqQ1sKBNWJVkmsnNUSN0qY30euQb5a
         R9Ity0cPgLp+WurkUACOx5EbJxYPUOR9WRrsC8mfEo6cbrnXa0emX+BmXU1VcKoZKZMQ
         DaKw==
X-Gm-Message-State: AOAM530HwaACZMH7i1p4gkVM+8sIuCIxjkHx/s2NLN9bPoJWJGvkuXmF
        HQ6Hge4TZ9FaRCARHY/LGqPe6wWh0Ao3DD/f
X-Google-Smtp-Source: ABdhPJzuZ+AMLElaf/1BDqFHD1jzysFdb6EKZLo/tXd14iKtGVvhbJx8mqaY9WArCSSHW8KgLifnwA==
X-Received: by 2002:a50:cd08:0:b0:426:1d9b:4b13 with SMTP id z8-20020a50cd08000000b004261d9b4b13mr14179895edi.360.1651511872344;
        Mon, 02 May 2022 10:17:52 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id u21-20020aa7d0d5000000b0042617ba63aasm6925885edo.52.2022.05.02.10.17.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:17:51 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id q23so20389130wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:17:51 -0700 (PDT)
X-Received: by 2002:a05:6000:2c1:b0:20c:5e37:3ed1 with SMTP id
 o1-20020a05600002c100b0020c5e373ed1mr5787424wry.342.1651511870901; Mon, 02
 May 2022 10:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
 <20220430011402.5.I93d9a95aa7299f48ec081845ed29a1128f2ebe32@changeid>
In-Reply-To: <20220430011402.5.I93d9a95aa7299f48ec081845ed29a1128f2ebe32@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 May 2022 10:17:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VF5KJ1wc2V-MxgtJz+DVb7BFCieWoNaYVES-wbq6QwMQ@mail.gmail.com>
Message-ID: <CAD=FV=VF5KJ1wc2V-MxgtJz+DVb7BFCieWoNaYVES-wbq6QwMQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc7180: Add kingoftown dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 30, 2022 at 1:19 AM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Kingoftown is a trogdor-based board. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.

Actually for kingoftown no downstream bits were removed.


> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  44 ++++
>  .../dts/qcom/sc7180-trogdor-kingoftown-r1.dts |  17 ++
>  .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   | 223 ++++++++++++++++++
>  4 files changed, 286 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
