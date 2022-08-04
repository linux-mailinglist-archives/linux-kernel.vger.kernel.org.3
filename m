Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0890C589DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbiHDOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiHDOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:38:11 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC35A4C627
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:38:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w29so14982250qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7+IHbVKhZDeIBaRjLawIcx6LVul+QTItAJZIivf7gqY=;
        b=ufg49NFoFDlcynz7pWTVmRZhy3xSI5kCn759tZ9vmnuuILMCnEORQp/wBS20nhayS0
         0V/i9wvAy3/uIPea3V1Dc3KE6RFzKLuc6hvXJCqHND9c6lE2XyrjkibgMVbhDeCn1v2R
         gyUSdh5efbQF1Kfqv/rldgMScFGi1Zexm0JHNJFrnmsrmNTcqvJkS+57bkDuzgzP49qa
         9fpV2hKosk1g95G4qPSblTffq9M3wpMi/Fp/BVJkOYDM++1irp2TinOWITa9Hh41mj1e
         Md8QcHg4Gk2QOv3qB75ic5zv5DgccD9sqiLfEBzzfZ6NHDB5JxQX5smDIAnM9m40i0vL
         VmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7+IHbVKhZDeIBaRjLawIcx6LVul+QTItAJZIivf7gqY=;
        b=3hf0fCxTC8Wxd5IEZht6wO52ONUxXsGSwFEj2jPIp4BHR4s6YLGE8G32V9WjuUKiel
         jzzfYZJPweSFsZqXt85C/+M5HdCYZXjS4qoTFV8Ko/E350cpiTM+aoTz4hYOcCTQVMXb
         X+C+ZNxEPLVcQfKBiDjcWFYa8lgFboFl1gz5ntXQLvmrg+qCtjLhriUXO3dDwC/t+HYl
         ZDBC9OKv5kSOYG7T1DepnddbrMnomuYBs5EKv1YsYdSqx2re0+Thd2AiD4Qty8dI/Kts
         GP+ScGVGyqXLgsyrXxMqBqHBN72vNbqa/Gnjtu3XeuzuRE90qsPSS7Tzmj3ly/LEi13Z
         lzLQ==
X-Gm-Message-State: ACgBeo0FAxojMHzIKVw+m4wnUGHyboJH6vrU8gKqNX377g2ZfDevKgXg
        /Fu6BagFDkv9C5d5hZbdnw0gH1+m65qoxORn7l3HMg==
X-Google-Smtp-Source: AA6agR4WNXQ2KgIruLMHS5Z92OaFYRF1mhbz0dJnN3rCVTFktyanCvf1eGyY73ch+e2FzcsIKbVSG1MHLbE2q7LsGcE=
X-Received: by 2002:ac8:5942:0:b0:31f:39f6:aba7 with SMTP id
 2-20020ac85942000000b0031f39f6aba7mr1755983qtz.295.1659623879819; Thu, 04 Aug
 2022 07:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220804103456.3176943-1-abel.vesa@linaro.org>
In-Reply-To: <20220804103456.3176943-1-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 4 Aug 2022 17:37:48 +0300
Message-ID: <CAA8EJpoYrXNBeZfDTAmjhsHaMqO+jeUVt4BtQkKy=T7Q0EuH8A@mail.gmail.com>
Subject: Re: [RFC] clk: qcom: common: Detach the power domain at the end of probe
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 at 13:35, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> None of the CCs actually need the PD attached to their device,
> but rather some GDSCs registered by those CCs need that PD as a parent
> in order to propagate power gating and the performance state.
>
> So lets detach the PD from the CC right at the end of probe, after
> everything has been successfully set up.

Would it still be possible to read the clock registers if we detach
the device from the domain?
I think it was the original issue behind putting the dispcc/videocc
into the MMCX domain: to be able to poke into the clock registers,
which are gated by the MMCX.


> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


-- 
With best wishes
Dmitry
