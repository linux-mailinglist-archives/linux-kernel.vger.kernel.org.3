Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27D580625
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiGYVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiGYVGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:06:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB811FCD6;
        Mon, 25 Jul 2022 14:06:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z22so15540211edd.6;
        Mon, 25 Jul 2022 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGBbKknERGaQR66mfFe62XOVnr8XdLDPSXcuJYtRG8s=;
        b=YeQ32C0CB7mfUuZjqJHigX92cDaPLNsvkiX/YXHX/jW5BJoCjfdEgvOfhscT0R0u+I
         80GgEtBuZSO+bPHnC56Qw1unzThVTq9vcT8AKcltRcifr/q7YpXpI54oMYKSLabFbtAy
         q0dDZrJlpM2bVhLDgl/+JCJgqYRh1rkVSJXymLjBJuH1kcSAYt5pEFlh5YdH7/B3g0TS
         afkCcK/ptmqyEsBLUFRfA3YWCDfWYxGSrcAQX+cMj2BENbmoa4ox+z259h/IWt0iXqTO
         MyQLcHqSdK/1P8V8sPJ2WS34p57Kn9Xjl7bGW8+4ErkC3LqkNJx5r3asbb5crQivu160
         ZExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGBbKknERGaQR66mfFe62XOVnr8XdLDPSXcuJYtRG8s=;
        b=JEjVmC0MWhowD8ysm/UnXchOEiymJXt/9o+Tb/WYyh2nSq3rQ+CDLJjHpkToDjyAO0
         5rEFXh8x4DD+iC/v63IcrROewuPU2ijFuBTLRFrWGaNQ1oQtigH6S0ugZXvMPr14sW6B
         thLSkoVS5hFSfBM2fdUO/HpMwSpwCxAYBjY4A6sMCRxAjNpB41cwvwitfPm65Am4Pu2b
         rz4JUHJDCIKdl3hCWESNLGS6G1DVAQo6Wmag8g+sg8sZs7kO8Wrw6+YX3cNFkHUmMw1H
         sveFzi2YFbz3yF+rRo/sVqKRxucfQstqUYO9NJVR+WD1vBc4G1sb6WrwNnXYO3FQbaPc
         7dVQ==
X-Gm-Message-State: AJIora+w1N209Er3pBAxGqo6ZhKGpGaqlL3LLGni/vEy7iq1LsmxkkGO
        7uQcRu/c8ZbUPoOkxGAtg0D7BOppjGmg0SlFnZM=
X-Google-Smtp-Source: AGRyM1uw9Yfebn4NMaULNQGCHyMi5O8GRiBqMpMTBi0J4XuchcaXKVoV2G4tRXUWUuTi/8JKyxy5cOS4iUEApXZlSZ8=
X-Received: by 2002:a05:6402:50c9:b0:43c:163a:4d5f with SMTP id
 h9-20020a05640250c900b0043c163a4d5fmr4943645edb.386.1658783159031; Mon, 25
 Jul 2022 14:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658597501.git.ang.iglesiasg@gmail.com> <44a301d5605bcf5b30ae60b21d0b312717b938bc.1658597501.git.ang.iglesiasg@gmail.com>
In-Reply-To: <44a301d5605bcf5b30ae60b21d0b312717b938bc.1658597501.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:05:22 +0200
Message-ID: <CAHp75Vf-TZrfesq4P7jGq9Aj_+_Fh5Mot9TU5A3v2JbfCpWSww@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] iio: pressure: bmp280: simplify driver
 initialization logic
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 7:40 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Simplified common initialization logic of different sensor types
> unifying calibration and initial configuration recovery.
>
> Default config param values of each sensor type are stored inside
> chip_info structure and used to initialize sensor data struct instance.
>
> The auxiliar functions for read each sensor type calibration are converted
> to a callback available on the chip_info struct.

...

> +       .oversampling_temp_default = ilog2(2),
> +       .oversampling_press_default = ilog2(16),
> +       .oversampling_humid_default = ilog2(16),
> +       .oversampling_temp_default = ilog2(1),
> +       .oversampling_press_default = ilog2(8),

It's a very interesting way of writing BIT(x)...

-- 
With Best Regards,
Andy Shevchenko
