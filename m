Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A285F55A55A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiFYAN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiFYANi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:13:38 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2852ED42
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:13:36 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cu16so6876129qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFVKp+DIpzgb4hUKHdKfLQTpwjibehhe/edtSOh7+n8=;
        b=zaRjLUy3jhfIOSxy6FZPbYqI+7Xgb6YLibXNuwYQ5A8bs8atdxDU88en2htNoOlEIz
         gRqyMO2J2Na5Gnlxg3Xwi93BBLh6OrvxUfvf2GLLkwJ6KQvjHxZ2vYKGefI41L5Tqw0y
         paLSbUXLHWvIXOyhFa6sbfqdQNYBSd5qsTZLJAMe+pg65U5hcaMiY9WS/VRDdicTEg81
         KJhnBaRNPkGoFN4KomnvytXOTVUPtwez+AoFbf3fywep+MntFmQyPnveLKIVZKXHVyWU
         Qxe0ykMA6rLm6e0m3CM2bvT4GXbe2KujuaCFHRyyrWNDFn229olscomTDsArRwNxaKnP
         SSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFVKp+DIpzgb4hUKHdKfLQTpwjibehhe/edtSOh7+n8=;
        b=z/oEopGU61pkzX0dooA67PXmuoHY1x8bTxzf17XrIhdgmCxg7D0+1ykkIMFlOYSYf5
         q7QFQqhfnlnJXAhfGhpjY21BHf4rBwxJJ6pe/rGxCjuQW0W61ywyxkysLxBQf1webBDj
         61nLCwLMRE98QVGaOskYl5gTgWqeskgbuz8yaql/d/o61mR5c7atJWXrbrReiG57m6bI
         +lTlvKkEMsKz+AekY+VvQXzI99eulaidxG0fruJmRgHGCoEQeX3wGst3j8pGoPLdy/Tb
         gIi5EdAgwJJqaxst+eOD+KkOs9D2L7kkVT1yQoyt6IR2RvfzYhEtKa4yTk9rJjXv85T4
         cpKQ==
X-Gm-Message-State: AJIora/mQOvKrN33QP7rUXwkZyb/hO5y/YCvEb8zlc3pRhQ0keJBay2Y
        QAeKpWUWpbtGS1ElEMGmZpeGrbllC7+wwBeMDbzwrQ==
X-Google-Smtp-Source: AGRyM1uJYAGMPzovKAZ1R22Ezl34Pn7ac31FoRY4+69xihwkidiDi9wThNin4zqhrvUnvGbwnDRcrnPV2023K7t8ayU=
X-Received: by 2002:a05:6214:d66:b0:470:4528:bbd5 with SMTP id
 6-20020a0562140d6600b004704528bbd5mr1383493qvs.73.1656116016045; Fri, 24 Jun
 2022 17:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220624010703.541191-1-sunliming@kylinos.cn>
In-Reply-To: <20220624010703.541191-1-sunliming@kylinos.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 03:13:25 +0300
Message-ID: <CAA8EJprfCV259z_MWUN1yYRkAaPOJcpoZDcKiwKHwTdWaPeyww@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/msm/dpu: Fix variable dereferenced before check
To:     sunliming <sunliming@kylinos.cn>
Cc:     quic_abhinavk@quicinc.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        kelulanainsley@gmail.com, dan.carpenter@oracle.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 at 04:07, sunliming <sunliming@kylinos.cn> wrote:
>
> Fixes the following smatch warning:
>
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:261
> dpu_encoder_phys_wb_atomic_check() warn: variable dereferenced before check 'conn_state'
>
> Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
