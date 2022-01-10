Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376EF48A197
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbiAJVMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiAJVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:12:07 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D91C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:12:07 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso16506750oti.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rD37BGhxE/h/9iakwyK07+eP2ppGsw/losnXy72cDnk=;
        b=iwgpaEwtCdh1+x9A4dKQXgihivGuP+fkfHLDs6NjkrYPkgRGg1/R9RYjigrNokqpYm
         SDSpgnDugkDVdkcdkLvyXrMfXbs3iBfz/OH/DgWH76OUbjuuOAVa5ruOUnNf1bxFqrep
         yHC8PyzzNdHVXnNuWLdreUtm/qazFCGgvmUP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rD37BGhxE/h/9iakwyK07+eP2ppGsw/losnXy72cDnk=;
        b=yzg4eTwkgQuBRdNSULY7Q6IIQXsLF/6jmauiK01JxVs1oES7vMmfAlMdw1/Z6j8G4s
         pG71GM5iOKr3Ne3wYI/qe/+qGsVbHQrcjCTKvCHgd59ieKF+47sjHYF2v/7jMxx4N0pO
         HSD4FLOTsOutxCc93ifAJgC8a5Zm+at/JnV9Ssj4pyh7fzkLSfWiZ810mqcOG9CO4FRX
         L89amJbhF9WbrzjiRIhDqo2KS/gLCf9TxdlcF9zDcbknA6wqizifvux8I+T9fBr902wV
         sPHUliWlbMI03TmPriVZN8mECkvkYoLu8LVqJ4/jwWT0bKpTz3dmlkjjAE6eiKADqdXL
         96Ig==
X-Gm-Message-State: AOAM530PR9xl2ZB5KpuwwNWSyGXI0TDS9g3CjAulGcIFVjN8MxjSkV/2
        prbLEdrF+gf/2febrb4wXIVQokCs0ZwU5OgmB1xbQg==
X-Google-Smtp-Source: ABdhPJwTRc7q/BTpmMGUgZbRDE3CRCrvinB10XmkRE5r0q9f1a4XG9GoAPkTBBo+kTqzC5yxnGGzp3MoDVNBCuWfU7U=
X-Received: by 2002:a9d:1a6:: with SMTP id e35mr1225422ote.77.1641849126549;
 Mon, 10 Jan 2022 13:12:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Jan 2022 13:12:06 -0800
MIME-Version: 1.0
In-Reply-To: <20220108095931.21527-1-linmq006@gmail.com>
References: <20220108095931.21527-1-linmq006@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 10 Jan 2022 13:12:06 -0800
Message-ID: <CAE-0n52qa+8-epzVaQLYf3n+-zOpmAT_gOBd8UUrzvxWQJH5Nw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: aoss: Fix missing put_device call in qmp_get
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-01-08 01:59:31)
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling paths.
>
> Fixes: 8c75d585b931 ("soc: qcom: aoss: Expose send for generic usecase")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
