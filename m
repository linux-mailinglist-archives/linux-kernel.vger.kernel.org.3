Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2B534612
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiEYVwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiEYVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:52:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628A11A3D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:52:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w21so2010272edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyinZ5fnsRrQlBB9/BEXUkJe52nbvOp0IA1YT1qNZLQ=;
        b=DYNbNTHCGA3+q6Jyj3+tG7U4DthPafd2+ejUYADAkRfzOcAkHUzjIKAcspioJJXPTI
         68yacIqrEwW9LHvc3A9zE7xMxV3ffJlLhmMe4cPgxySxntvd2KdLuqsUuoIvMQGQj2AD
         /ZFSdTaAD7ARVQTbB18QRd9WTMBNqNrE2fVh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyinZ5fnsRrQlBB9/BEXUkJe52nbvOp0IA1YT1qNZLQ=;
        b=AI4YZ55JiqnL0K3knEONVQs5gzFOlTm1Srw/NT1EakFKM2h0y23Vfr2hll748YbwNy
         PzkTXUAJtWLlh48qAFWF8PinKwnpiCaxhyPCaVR4LmYnAmYOtGPY2K8dT0/XWYnMlSpv
         oixTtLPUv5voCFauDvIFiFc8O0eVx9bG0h6CBL0NayaZrBqCEV1EpEhTYzLU2UBNc54U
         ol5XtnhR2AlKHMBVJ4WNaDBXa5SNviRcpjJXzEWCHoe+9dqsFbe0jOZMEX7hO9Zu2KZ2
         /1XmoiW0TR7+2w2SlgbVepqBJ1eNGNpMU5+X7MA9yqb06JEke1+7X3RN+2rURppexwpv
         /Q3Q==
X-Gm-Message-State: AOAM53143NJHy3tBBfwtimrAwnPThmhF1MAam7iQLgguaKzI3Gycl+eT
        WAJI6aa+y5I0tR1YfraKIeWB1mUXBrjiWEC9AbE=
X-Google-Smtp-Source: ABdhPJyq7qvmh0mtI7p3aK7Z3e23JWRYo487+ioNybQ3sZzKlfYs9ui9BMFBquYsNi6Zjklkazw6Gg==
X-Received: by 2002:aa7:cb8f:0:b0:42a:e9bd:3b5f with SMTP id r15-20020aa7cb8f000000b0042ae9bd3b5fmr36460247edt.8.1653515528350;
        Wed, 25 May 2022 14:52:08 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id oq17-20020a170906cc9100b006fec4ee28d0sm4471086ejb.189.2022.05.25.14.52.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 14:52:07 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id e2so20239346wrc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:52:07 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr26364386wrr.442.1653515526783; Wed, 25
 May 2022 14:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220524014938.46153-1-acme@kernel.org>
In-Reply-To: <20220524014938.46153-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 14:51:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3kZ19JRu_sYft5-=JYUa82ZW6BnfyU8FzU2uXmnJtjQ@mail.gmail.com>
Message-ID: <CAHk-=wh3kZ19JRu_sYft5-=JYUa82ZW6BnfyU8FzU2uXmnJtjQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.19: 1st batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Eric Lin <eric.lin@sifive.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 6:49 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>   - debuginfod support improvements.

Does this mean that things don't silently come to a screeching halt
because you don't have some debug info, and it takes half an hour to
download it all, and you spend the next hour trying to figure out why?

I'm not bitter about it. No sirree. I enjoy wondering why something
isn't responding.

                      Linus
