Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102D85372B6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 23:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiE2VcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2VcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 17:32:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B255C64A;
        Sun, 29 May 2022 14:32:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 129-20020a1c0287000000b003974edd7c56so4023987wmc.2;
        Sun, 29 May 2022 14:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=oJ572TpBm9RagWIq56C/Rz68Y52rsZa/Rz1BRlAz3Z4=;
        b=V6/vHNi0LJfRJiFJkxiZv/UN66K34iqJ4xTitJlV79aMJFj41HBsaPBbAOenoYALkz
         tkTDI/vK2IF4tVrJfgjAaxky0DBzu5mmrrvXHToi+nkLxIX3I0jNRenQJoHuJQ662FGS
         auFaJ3sJZxmJx+jXD/TOkTvjnksLnzIMSq2/ub/HniJdbYRbSaMXqjo9jnhwflUn4oNK
         SNznilQSkcMexQZZIYMGOGgAdGxKrW2S0f8gJkQZAWG+0p9Sjl39XEpqtYlpxoNabRN/
         JRAVEO2bN30HMPD+EMAzy+5jM6f3jYWMOHfdna0DOEWfGwXAUTI5NXtY9WadNV+QS9wg
         HxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=oJ572TpBm9RagWIq56C/Rz68Y52rsZa/Rz1BRlAz3Z4=;
        b=Q4nVB7uoR0HH0whBeH0Z1pDrY9kNgLDg/zNqbOXwioTiJ0R56LGtpHIC3AC9jg9Dde
         QlyJMTFTZ/XXGljyc59qunFCPQOASBI8HophB5Cjsu3nl2QQMkBLai4IZ7K5P6esjmBX
         YJ1CsWX+80tygnOafKJ1MXSTRrcKSYWSFR6vRIowK5HaI1u/JMakgtu5HeC9Tv9/Cxj5
         3Tck727+5kfoH//vEVnzcnH0yeO6Af64jnrd1id+krGAp0eJu1XJ9FVw4RWMEcggm1PM
         mX8YXPG0h4bD7CwN6iuF18Pd+VW7KSTTLXE6GMarAeV+UfZYwK9hKCN/Of+bIl9Kg6Rq
         pIpg==
X-Gm-Message-State: AOAM530ldEHh9/d86kRmbkr3O/KFYvTXVdQJThA8jcjaGCNVsey7IuRv
        tja56tqnyVtUAPX8BKPLM5A=
X-Google-Smtp-Source: ABdhPJzwOEjcLGispLy8yFMaSA1SFN4YyPfdYdp2ytg6WLndjv3z8CX/jVk/4sFM4jZjXCztpMud1Q==
X-Received: by 2002:a05:600c:26c5:b0:397:49d9:e038 with SMTP id 5-20020a05600c26c500b0039749d9e038mr16434873wmv.25.1653859924102;
        Sun, 29 May 2022 14:32:04 -0700 (PDT)
Received: from [127.0.0.1] (lfbn-idf2-1-238-156.w83-202.abo.wanadoo.fr. [83.202.82.156])
        by smtp.gmail.com with ESMTPSA id t4-20020adfdc04000000b0021024f82e01sm4547816wri.16.2022.05.29.14.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 14:32:03 -0700 (PDT)
Date:   Sun, 29 May 2022 23:32:00 +0200
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Claire Jensen <cjense@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Eric Lin <eric.lin@sifive.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        anicolas@hupstream.com
Subject: Re: [GIT PULL] perf tools changes for v5.19: 2nd batch
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wj1+W6VXeRG7XXO7zSsTe3mACdrPY4PccMNPhC3seLELg@mail.gmail.com>
References: <20220529154535.371758-1-acme@kernel.org> <CAHk-=wj1+W6VXeRG7XXO7zSsTe3mACdrPY4PccMNPhC3seLELg@mail.gmail.com>
Message-ID: <32B2C52F-F697-45D5-9192-BDA70D838F96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 29, 2022 7:28:26 PM GMT+02:00, Linus Torvalds <torvalds@linux-found=
ation=2Eorg> wrote:
>On Sun, May 29, 2022 at 8:45 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> - Add BPF based off-CPU profiling=2E
>
>I suspect this could have come with a bit more explanation of what
>"off-CPU profiling" means=2E

Sorry about that, I was in a hurry, traveling to Paris for Kernel Recipes[=
1], afraid to miss the merge window=2E

>It seems to be "account time when process was scheduled away to
>caller", but I had to go look at the commits to figure that out=2E

Thanks for merging!

>Partly unrelated side note: I've occasionally looked for "useful perf
>recipes"=2E Not from kernel developers, but from people who solved real
>performance problems using perf, giving useful examples=2E

Yeah, collecting such experiences somewhere and trying to reduce boilerpla=
te to achieve the results sometimes ends up creating new tools or making th=
e existing ones now actionable=2E

When people ask me about such recipes I usually point them to:

https://www=2Ebrendangregg=2Ecom/perf=2Ehtml

Lots of features in perf came from trying to address comments, complaints =
from you, Ingo, Peter, Thomas, Milian Wolff, Brendan, Stephane and lots of =
others, thanks!

Back to this off-CPU thing, I'm talking with Namhyung on how to streamline=
 it, this one and the growing number of BPF based perf tools,

- Arnaldo

[1] https://kernel-recipes=2Eorg/en/2022/
