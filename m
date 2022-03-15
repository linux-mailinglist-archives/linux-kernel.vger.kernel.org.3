Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F4E4D9200
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbiCOBIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiCOBIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:08:04 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0836946174
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:06:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id j2so34474188ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68AiRfsO4vl3jPEj4ARSz3aMQloGHLeMAB5ikDwtcp8=;
        b=gY/nIDO8W6R0JGe/0dFeq5ulaYzwIdQqnDXMkVUFK9zJ5mOkoO+xhG6g7PlTr8+0tm
         ci6G2VtUNBFIsotFB3McefA/jBbzYFT4MSMB/66RtDT0Y45jM94XtWFiWQVBRatzq0MA
         bRXNAGp9NzdOJJJzSj0/6qVRqL0glSoVGafcTmH4cz/iwz6TB+x9WBq5VjnCXCKyXsQx
         6Qf1hMeJnb47mt1FDHQIloY+hmAsjfTPHPveBzxjZzVLXKUJTTOw2pwMBNYRF0Uzn+ct
         G7k4kODV0lmUJOMyVrIE1fS423/ufNpVlPL+91tIDH4HKKMHQQa7j+uUehc0voSjjBZU
         sefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68AiRfsO4vl3jPEj4ARSz3aMQloGHLeMAB5ikDwtcp8=;
        b=MTnw1+xbmsyVkXlQrTuXe3Y8ajsl7qzqV0kqV1xy/UukrVSvoGxKCsxaJw8sbMLrbX
         O7XxPWCXzp+xXQbUzhzhq28WgZPP94v5wymPXtOUrXd5Ngbfz0y3TIVShJcKvp8JTWO6
         T3vaP51x8OtGCP+mSNQe+wx+7xxqAXzj9pdpFzljsehlgIlJbUF6/y5HdjbOEto4e94a
         XmW6kSLuWRGdZ5ZmGlsyMb85vN0yw/UZ3xB+Ti8G6raNpWt53Ov2e+T4ND9GmXrgycOk
         p/HtuiyKz/TlHf+8AqBrL6GhE2HaliWPDCDKvUUGkUcmRsfEjGRKBt14beOTSHysCknl
         9JxQ==
X-Gm-Message-State: AOAM531/Xj4H4JUhzuFcZSwTufRSF2LcZ27O4Q5vKDwqExb7egEI8qQM
        mOg6eWlZFQMc9k5vG6xex26ypyDuTeSC2TE8erNVQQ==
X-Google-Smtp-Source: ABdhPJyDdTxQUhhIgyClbKLFbCWNNHZp5CyAZJ22ZfIYz0QChC1jnlRteEIRBXNoqIZbzPvrojs6DMqBp7rzsw4ZkQY=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr19987184ybr.295.1647306413129; Mon, 14
 Mar 2022 18:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 02:06:42 +0100
Message-ID: <CACRpkdZF8=YByshF1VZa_eBm+hMtT=EJF3juPx2d_NeQhGuaBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add support for PDC interrupt controller for sm8150
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        robh+dt@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
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

On Sat, Feb 26, 2022 at 7:40 PM Bhupesh Sharma
<bhupesh.sharma@linaro.org> wrote:

> Changes since v1:
> -----------------
> - v1 can be found here: https://lore.kernel.org/linux-arm-msm/20220119203133.467264-1-bhupesh.sharma@linaro.org/
> - Collect ACK from Rob on PATCH 1/4.
> - Address review comments from Maulik.

Looks good to me, but I need Bjorns ACK before merging this.

Yours,
Linus Walleij
