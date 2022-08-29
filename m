Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6AC5A4DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiH2NTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiH2NR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:17:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B182874
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:17:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so15637307ejy.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vVQxBaqAvfBUo0jF6nOEtYokrrVyilYpVxh0Js2+9fs=;
        b=kIp78QeZFdDc8fYDYCfMel6sFbSqiMSu9beQEWHduoxLtumSsNHaYaVLFjRly192kl
         C3gLP+taR6PMhjL5tnETj8QzgrYB1JAb/DL/b72j8LZVI0zgE65WwSe82aEy9bwRJRua
         tMnQ0iz6KmFZjCDK/ocPWS57rBqSm4KsVjXG/GY0RdRTmh3JidyTyUqMHzt92uM0AAqh
         mrwN9ccxyMdmzHmN1SkpFtdcrKRUJadz4uXiR74Sc4aok8ULU+CYDeAuYHE5aMQVjfhB
         Gg32Mv0qmOgHaqihnEOdZOY0OO4kP8sd1thP+a22GZZ/szUzD5wSg8+bq0kmteAM6ie4
         yiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vVQxBaqAvfBUo0jF6nOEtYokrrVyilYpVxh0Js2+9fs=;
        b=GMoBfAvQXSJz+5ZjLryLM7xzgJ3UHdhvMQqmzVeZoxFu+ibE5duR4I8po7y4PYabpV
         MPWZ5vtawHz45TDt5MOeUm6ce9sqiKsWl0YOxtnpKklvQWayKqxp9H/ZMJ9X31bM2DPv
         Hhc8Q4J3DrVk1S3bNqu3E7xpGEOt7t5dgoxLmw5p5dFlSQHHqIg7smuvePgtTW7Or7ho
         VyaiPsmQJIIaTeqyWJHbaB0Mq0YvvE9bNa1hEei1i4pr84AwhwJ8Z3UB/FmDa3te6RW4
         8aw0aYUgjFr7I7Pqfp+48aqqAs1MMGcc1BUCrqj5Oj8iBKeQS6aQchD58r416bXqZUCl
         Eo9w==
X-Gm-Message-State: ACgBeo0XUo7TRU+4PJJiX6ZnaSRJat2M3AqzwQ3mL1SMslvmBmxSd2EO
        TgStOv0IYzTspitsyHQI2Emt/lcJkBAWmcojOoWYDw==
X-Google-Smtp-Source: AA6agR4Bd3dRcihqGaqU6XKuYDw5NSctB/SiD1k8COWJyZJLXcTsNztWKAP4rGk/zDsw3itA5PRoFRIl+Dz7CM450WY=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr6624584ejb.500.1661778974724; Mon, 29
 Aug 2022 06:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220519212943.778610-1-linus.walleij@linaro.org>
In-Reply-To: <20220519212943.778610-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Aug 2022 15:16:03 +0200
Message-ID: <CACRpkdamFTCuCTYX-Y_-HHM_WBQgwDbiud1pA_Xn3V2zm2zj_w@mail.gmail.com>
Subject: Re: [PATCH] HSI: cmt_speech: Pass a pointer to virt_to_page()
To:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Pavel Machek <pavel@ucw.cz>
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

On Thu, May 19, 2022 at 11:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> A pointer into virtual memory is represented by a (void *)
> not an u32, so the compiler warns:
>
> drivers/hsi/clients/cmt_speech.c:1092:35: warning: passing argument
>   1 of 'virt_to_pfn' makes pointer from integer without a cast
>   [-Wint-conversion]
>
> Fix this with an explicit cast.
>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Sebastian can you apply this patch to the HSI tree please?

Yours,
Linus Walleij
