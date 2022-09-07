Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02CD5B079C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIGOye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiIGOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:54:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1DB6548
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:53:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i26so7110874lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JA9TuoAtB0Hdj8lp2ESD/D+NAeIyn8GknvA95wIowgc=;
        b=lkyy+Vj9xIxeSsOTcc37N97vHk2IeH5ikX2Dr4G8r2ZOrH7NwWJRHJlmH3pjhlzkwv
         jyNfkprU+TsRKtfHyIAwF1vH+1vtzai/I6nmMfUbxJGlfuFWmx/UeEl5TAr8YRUuWQ7N
         pUfbqDirdVle8VvJHt3VeJtsR51+MRhzRZcjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JA9TuoAtB0Hdj8lp2ESD/D+NAeIyn8GknvA95wIowgc=;
        b=qzPjvF+0TVTbToTq1DReiOEPoLAmglS6OJDPE/Qu1/y1QdKieBwfpedNQkbor6XN67
         cETVUJLfrXX1xBXAdabgabLEgXVRVSko/3bJHy5d/8xIj00yFoNqd5nT9380fGftFa/m
         koBi567B3boj5Ugpoc3jG+eSDUv71KIFEg5mpF7SKmfzfHtticAEgf9AG5rHuhM7+OKm
         u9lbhfI2iZCyQ1359KHqYHWoyo08ubTzfU5T9EtNfAoyGnn4ptoKMmno76yCteenj8QE
         y3NO/+Xq5JBmHgBXYFQOLStjI8QcmQGO3ZaOiJsbwLMiRgoC50nXOWeKP3C0nRTy9DDS
         ikrw==
X-Gm-Message-State: ACgBeo1U7oPrpeFCEeXTWRVf0QBKxYzUGyv9pqFVG759j5mfCmvah85v
        iWx5sjJm5MoNa9pwPb/d8oUTtRzaedeiYA==
X-Google-Smtp-Source: AA6agR6mmjQyzS2Zye5ysxfSOXNl2fN963XBefwTz+OaMyzTVqxfeXg4OwxUNnqABx0r9ZOLynZc0Q==
X-Received: by 2002:a19:ad03:0:b0:492:d9e0:ef42 with SMTP id t3-20020a19ad03000000b00492d9e0ef42mr1263800lfc.327.1662562421724;
        Wed, 07 Sep 2022 07:53:41 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25111000000b004946c3cf53fsm2530642lfb.59.2022.09.07.07.53.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:53:40 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id bq23so22850427lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:53:39 -0700 (PDT)
X-Received: by 2002:a05:6512:c1e:b0:494:7c8c:f5f2 with SMTP id
 z30-20020a0565120c1e00b004947c8cf5f2mr1302375lfu.593.1662562419339; Wed, 07
 Sep 2022 07:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220831172024.1613208-1-svenva@chromium.org> <20220831172024.1613208-2-svenva@chromium.org>
 <Yxg6OayyEFWIax/r@gondor.apana.org.au>
In-Reply-To: <Yxg6OayyEFWIax/r@gondor.apana.org.au>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Wed, 7 Sep 2022 10:53:27 -0400
X-Gmail-Original-Message-ID: <CAM7w-FW_w2h6JmvZpg2qjspESAYR21o-0Pw89JnnV8hFEdaHmw@mail.gmail.com>
Message-ID: <CAM7w-FW_w2h6JmvZpg2qjspESAYR21o-0Pw89JnnV8hFEdaHmw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hwrng: core: fix potential suspend/resume race condition
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Levin <levinale@google.com>,
        Rajat Jain <rajatja@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Wed, Sep 7, 2022 at 2:29 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> The general concept seems to be fine.

Thank you kindly for the fast review. I plan to get a v2 out in the
next few days.
