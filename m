Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20D1589F92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiHDQ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiHDQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:56:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D56140A3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 09:56:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so423098edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9RAxd8vXCg6ebH7MqJTjtNEjn+NCrIjJbPyy/864Rdw=;
        b=SgnT3/z7wOSRxmSgBsg2dLV8AI+Yk7NQTu0NY5LahlFhImWUqUw5E7Z7WnrfRXd/XG
         j9QLj2tmr3MqrmL3EboqUn2ci+T4jLGjO3rmcP7CJ+ZmIg+gYe38yJHxcI2K9hZ42XuW
         QHerwQ3wkF0tG2HuvqyFd7YawhKRJIMyLkJFjKZEqdwDTG7Br2VV6ZEhWT9ueGQjOgpp
         O9PEcaDo3atSqwuw+u7N5ztcTrzocGJP+tL/MvNcsovqbZ6cWA0Zw6ZjqaohYCxnexvd
         sKh2Sv8bi8FEv0LujC74uY8lfptluR76fuy+hYbM9+igE89s8b6fVN4Y2z86G0/uFmca
         dd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9RAxd8vXCg6ebH7MqJTjtNEjn+NCrIjJbPyy/864Rdw=;
        b=jisDsEf+4IAKB4NTXCw831Tt7fjsGjP41U78VfdiFP75UKIyVP3SjYKO4NO7N3a5s7
         fHnABwaSSSF0vnPCTY1i8JHcTQVZpNh5dukezTojZPFI2+8N0EHeOnQGxtLSwNabi+xA
         khY06r22795neHwOsy5XDH2pu+2mUCNsK7PfLrEuX22QBlxlniQiWhvAWbZ+nRcuTidd
         KV5q1bv+jKvqgNpoljI+jPBOQ01jcHw/LLVHCeMVmW5AoGreGSy0E3VWER4y8Otb66y4
         tjr+a5s8pzO58kusOnj7y1zs2eCbLsyPOJp33OSHPwhk0Fslq+w8y/YTN7tTm4AbBwY6
         xASw==
X-Gm-Message-State: ACgBeo3SfQiBHGmwVXP2n372LYUepxpX1xdGH+N+lHWmUIQpzjG/2w0l
        yyu0zVJ9NI/IsTDFWu0/Xfs8vA==
X-Google-Smtp-Source: AA6agR4vqzFgi3ZOFoI9pHyekMbM4zYfttqGHcixJ/EQsRgF4Gxfs6K/naNbKjK6+z7G/bzY5AzqjA==
X-Received: by 2002:a05:6402:888:b0:43c:fce0:2f0e with SMTP id e8-20020a056402088800b0043cfce02f0emr2907897edy.247.1659632172064;
        Thu, 04 Aug 2022 09:56:12 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bq7-20020a170906d0c700b0072f1d8e7301sm532588ejb.66.2022.08.04.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:56:11 -0700 (PDT)
Date:   Thu, 4 Aug 2022 19:56:09 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] clk: qcom: common: Detach the power domain at the end of
 probe
Message-ID: <20220804165609.hbrcylpayu4ypsbt@linaro.org>
References: <20220804103456.3176943-1-abel.vesa@linaro.org>
 <CAA8EJpoYrXNBeZfDTAmjhsHaMqO+jeUVt4BtQkKy=T7Q0EuH8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoYrXNBeZfDTAmjhsHaMqO+jeUVt4BtQkKy=T7Q0EuH8A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-04 17:37:48, Dmitry Baryshkov wrote:
> On Thu, 4 Aug 2022 at 13:35, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > None of the CCs actually need the PD attached to their device,
> > but rather some GDSCs registered by those CCs need that PD as a parent
> > in order to propagate power gating and the performance state.
> >
> > So lets detach the PD from the CC right at the end of probe, after
> > everything has been successfully set up.
>
> Would it still be possible to read the clock registers if we detach
> the device from the domain?
> I think it was the original issue behind putting the dispcc/videocc
> into the MMCX domain: to be able to poke into the clock registers,
> which are gated by the MMCX.

+Rajendra

OK, so I might be wrong here, so I'll need to double check. But, AFAICT,
today, most of the CCs devicetree nodes do not have a power-domain property.
So I assuming the PD is never really needed for register access by the CC
itself, but its only use is to be set as parent to those GDSCs that do
not have specified a different parent.

Again, I need to double check.

>
>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>
>
> --
> With best wishes
> Dmitry
