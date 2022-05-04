Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE32B51B197
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358593AbiEDWIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbiEDWIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:08:15 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D550E1A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:04:38 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2f863469afbso31085447b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqlpLuQfBXsLF0pGTV7F8Lqm0D+MDLdu0OmDcVtwIY4=;
        b=uOk/SO4PYBMT+8q1dA1TD5ptS5xd/kbbzQLYE6iespzhwRZycMKu5S3Qhyiz6F+i+1
         3cOJMgPCVoECy5RD3/Qtqqi0Dgd8cNVtxDpH7cyysA9bWJtaBzWNzqAT35Kh8PpgeUp0
         LEwxjERbI/QnoiGBnKxyEE3BpPH5Cdrf+zKObdobq0SKBeWIaWkut6AZ2IU6fQ/sYQ6c
         nTwHHjF0AO+2SNGg7wY3qPOsZREgDpQwjEuQq+eL8Uzo9fApS54erILmrbEOxlBVyUSs
         NovjMz5MjUjUdq+1l8a+JM44tWm5RCCtn/vOHA36VSTza1cRyofX77vYLvS1C7rEPbK8
         lHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqlpLuQfBXsLF0pGTV7F8Lqm0D+MDLdu0OmDcVtwIY4=;
        b=JJ3O3GpZm8P2R2FeOOud/MGRkQDGi4fO4ckJprD+J9Ips01MzwL0VMwX9F88huVqmc
         v1MUoImeOfj1py3ChN2UPJQ4Lh/4o3GNOwufQGqsoNZk01gB0JIbOA8fliub05+4MWVb
         JkLu7b6yqVvwg+wmhjaxbIM9moxhbbveN9hrbD7ICEv3AmClJxR25UAHiu6eiTw74AKV
         2kfwH5U8t648FUGCEyWop75pv/8NN1Qa5MJ0WVKg4v0wT4ZPHPcN1Iv1wLLzs+GGKp+m
         zhLnjUUl9vwv3D3qewGxj3uY6HYzPdFL6CgjxGX/wlprzEaOTOXs94JC9rYjK3TP5qqv
         OVfw==
X-Gm-Message-State: AOAM530Dqltox/k6wmoWSWC7nATxtXuXZWsOVvhjkbBK4ZqAKDuNIi2f
        +2XFS23hoZXiSVikyTvDcJ2Qv0SQeMIayrJ9eMsTSA==
X-Google-Smtp-Source: ABdhPJwa3Zp+INs9eIYA3vmkO66opZgtx8fKINwCtGXZ3pcba1YTMqSjlpx5Z4gASQOH6KsNIBd0fjydcV+hsZ93qI4=
X-Received: by 2002:a0d:ddc6:0:b0:2f8:a506:a5c0 with SMTP id
 g189-20020a0dddc6000000b002f8a506a5c0mr22606554ywe.140.1651701877405; Wed, 04
 May 2022 15:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220502153114.283618-1-fabien.dessenne@foss.st.com>
In-Reply-To: <20220502153114.283618-1-fabien.dessenne@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 00:04:26 +0200
Message-ID: <CACRpkdZNS4N9q5whUT3fHh6M1xzuWYWGfr_EvRuDePpNP4QPzg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: prevent the use of the secure protected pins
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 5:31 PM Fabien Dessenne
<fabien.dessenne@foss.st.com> wrote:

> The hardware denies any access from the Linux non-secure world to the
> secure-protected pins. Hence, prevent any driver to request such a pin.
>
> Mark the secure-protected GPIO lines as invalid (.init_valid_mask) and
> prevent the pinmux request / pinconf setting operations.
> Identify the secure pins with "NO ACCESS" in the pinconf sysfs.
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

Patch applied!

Yours,
Linus Walleij
