Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1A25780BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiGRL3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiGRL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:29:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90132719
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:29:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b11so20583046eju.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=OelQSa0F2MTSzddnDczmkNebNTWu1WtqRyCYV6pgOyQG7LWa5wOLoHFjkFInQbg1WD
         Hj8/oZGT1ta19lHEiPFdBRAmZjCLGSKxsNHmBo9umdNCyrI/oztZorQYSeeJ4zIAB0tH
         w+WBv83iazCuwAjZe+CHhxBX0TTj/f6yEqJnPnjKCZ3J5XldBqEd/wexmsxtfzToCE0P
         tYzDlk405EcP5fRq/XTR1+IAdgoN+eXF5VkIEBTnXUzzBgEJnYXSS46uhYRX4qQ4kF3n
         zdfjXPeH8otforWCBaCJ6lH8AIWW59zCIKk4JdhBaDhbB0txxKK+qLGKPPTxmGvvGuV5
         HN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=EwvLjTsvu2UFC3AdPTnre+3kwS8Vx9fqNop+niEMMFATk377A1EAcJ+JNRwGxEXPFX
         ivWJU5EFbvMZ2AyRn7xPty2Q01eOYDsURrxYAjLJeI7exfGZ2rSGvxZHMzWDi+egSD+6
         jVYwVJHFPJXIPyGsQbegEaoDh26efDkFplBoEz2qLWEFjlgTi5Fe8nThtTqdMmUj9vCn
         Onp2/CBWUF39GXQAHOnj6Vd21ZXwztEvT504PUo6u6IPVN+dj06yn8tl0EfU7oE+tN6N
         ot99bgvxPNWCZ40RHfyCyibrGRLWl6gEzwy+UOq2AK/PNJaQF19nmLzMT4ZCDl0ICRoT
         awpw==
X-Gm-Message-State: AJIora/3fx3smNV6IP7/lN9fRd4qTK/9eIGPqa+fKrx5gGmXy+emZw9Y
        CXw0ikhFTXiz4OJDExKL//sDrcQqPLPUc5Yb6BPNIw==
X-Google-Smtp-Source: AGRyM1uno6W1ACvmavzWpWq+peD6TF0boSaIdBtVvtVS3OlkIZAj/zd4UcJi6WzaB7dm8k8w2zW50rBNH5hS99lLbDw=
X-Received: by 2002:a17:907:3e11:b0:72b:49d1:2054 with SMTP id
 hp17-20020a1709073e1100b0072b49d12054mr25785727ejc.78.1658143748439; Mon, 18
 Jul 2022 04:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220714173715.v2.1.I85af54e9ceda74ec69f661852825845f983fc343@changeid>
 <a7c9c0b2a35e45f89cb7d6d7646396f2@ite.com.tw>
In-Reply-To: <a7c9c0b2a35e45f89cb7d6d7646396f2@ite.com.tw>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 18 Jul 2022 13:28:57 +0200
Message-ID: <CAG3jFyu3pBcde1p_sThTB4i6QPOPHvNEGbEGiwRBOBdtTB-7eA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: it6505: Power on downstream device in .atomic_enable
To:     allen.chen@ite.com.tw
Cc:     treapking@chromium.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kenneth.Hung@ite.com.tw, Jau-Chih.Tseng@ite.com.tw,
        Hermes.Wu@ite.com.tw
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next
