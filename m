Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9B511F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiD0Pyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbiD0Pyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:54:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91D55234
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:51:17 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7gfa-1nxXST1xT8-014kRE; Wed, 27 Apr 2022 17:51:15 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7c57ee6feso23870207b3.2;
        Wed, 27 Apr 2022 08:51:15 -0700 (PDT)
X-Gm-Message-State: AOAM533rrCUH6IJcp5DF3XdAVfDG6sQ8oZ1gHSZ3ZNCoVzgNijJjmiTM
        ye9MCteio7kbdvJu7BPPYKNc+N7D0ev57bhMp6A=
X-Google-Smtp-Source: ABdhPJwBNg6CpYFtUIKnpc/Rw8f1CBuXpCeXNKFcU4p5clk+M9zAP7ztHnapftV8iB5Ue4CUulJ/G3F9UTFN2azYVGk=
X-Received: by 2002:a81:2305:0:b0:2f7:dadb:2162 with SMTP id
 j5-20020a812305000000b002f7dadb2162mr16669826ywj.42.1651074674179; Wed, 27
 Apr 2022 08:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644824638.git.quic_saipraka@quicinc.com>
 <20220408111707.2488-1-quic_saipraka@quicinc.com> <bb99b615-cc76-9591-a610-fb4841d41d62@quicinc.com>
In-Reply-To: <bb99b615-cc76-9591-a610-fb4841d41d62@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 17:50:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1b0K4hJC9esuznqDdcBoX6+QqD74nVh91-iYbkZxiqbQ@mail.gmail.com>
Message-ID: <CAK8P3a1b0K4hJC9esuznqDdcBoX6+QqD74nVh91-iYbkZxiqbQ@mail.gmail.com>
Subject: Re: [PATCHv10 0/6] lib/rwmmio/arm64: Add support to trace register reads/writes
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, quic_psodagud@quicinc.com,
        quic_tsoni@quicinc.com, Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pncfSqlqmkLGmXVT6iOeX9Q1Y5SrTfn+p6zxB0RcOvbHs6h4IJU
 e/TgQwSwn14JJi3z+ibkbDWNEe1SPl2Xq87Ingxlw63795fkBjpPgxQpvVoTFe1sGJWQDaL
 r8s1lprZyJUoMFxIb2Z2qQ5UbLgpk22TH3aWz4Et6BV+eRcwiUtaiOupnINB9nkEUEFg2hC
 kwudHN4G6BlH2NXA7GmOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tw7R17oJm/o=:LgYM77CSfmBXtIdveIe9eJ
 27nQS5nq6x1fKaqazsr35qsZd8XBeKmPnDwu0S43DGUtt+UgHSI+J/FNVAQosZzYR+arEMlXu
 AcQPh6OQ9lirXYkGMkSWUiW7qla65AI74agTzNi8Uok9GXMEf4H56cenHrdJk+ssfcHYKLRx+
 KCF7TXUnjW+EhXIPLrZqd/Za1jBVxucdxv/RvSA1zB1O88FNnVHu2MRM6VQXLqKrLNihFT1Sw
 5owwe3HaIyy1M/mgl6qTBdGTX13Jq/lHgO9jlW6uhqVhbohBV91cmrQvEAzZqMjgWda1veZ4M
 9AXDhmrz7c2cqL3lJ+MW/i3kFCRrQnkVS8sAODFsFPq98FxFCU/cTBR7Jimo/TVK5HSFrb1bR
 0JR8AJNL67Vs9A2db3F2V8ZDBFCmzOrzH23P5UtxB2oVrO5qSGBCtG2kNKVgvt4Snl446+ioL
 7MUY3kxv/AzHi+HVvMK/TP2CDHuaQdnrmCw/p7a8KDFIcryC74VtvyGXbn9/e26Npuhk8aYK/
 qiL2mvik0RvBd0QRe/y0RiZ+XHIXActXQmvkVo5JJgWHesDS6JL7/lxEMwqawtXlhbeZRvLp4
 +sSzkdJmI9Q+m6aW0D2pJhe+11pZdtrRzWc4gSEwBC1k2NFqjVfhkcJ/YziWR7X7pf3WQi5aI
 rKOipwopqGVD7ywQI57AcJlDfhABvNY58F0Q80UA2XAPiIfyaQfyRec/wpY3YxlNe8vYrfUgy
 BIDyvgJfok+98jW6CJXJIHGlI3l6MmUywYwYrn9Jpndyk431xk/o8OFka8+Wg8czck5r4HHi1
 k/u02kXKxCG1IdmAb9pzz496eaANfxhem+/rrvk3PXhP7NNE7Y=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 4:00 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
> On 4/8/2022 4:47 PM, Sai Prakash Ranjan wrote:

> > Gentle ping, could you please take a look at this, would appreciate your reviews.
> >
>
> Gentle Ping !!
>

Sorry for dropping the ball on this. I'll go through the patches again
now. From a new
look, this all seems fine, but I'll need to take a little extra time
to understand why we
are getting the warnings that you are fixing, and how one will use the
tracepoints
in the end.

       Arnd
