Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78358CF7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbiHHVJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbiHHVJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:09:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E84219C02
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:08:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so18855404ejp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vGL/ZUFLLwrBSAimJhnWItnUczfWEUhMLvlkDlqzesA=;
        b=WtbS0Rx+b+ff8J3MT+9HprLD/QW7F8kIQjHZ4WrB2flwT5Q1mDuIgtvWoo9NFlO4RN
         AxsHCUwrfE4UnYl/kBuOp94cOuMPMcWjNCaIiAHT3QnVicGD7IXHPG+5ZFoqjbBEmTAc
         hubNn5Ayn8UFjfZH7TaBkRfnNdw9hN7drzC2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vGL/ZUFLLwrBSAimJhnWItnUczfWEUhMLvlkDlqzesA=;
        b=cyOrXKi9+kQAs6KUz906L7R15q6pWo/WIE40wnOChbfZfe6Km7qAgTAmaPdtNJaJjK
         NrtcauyfijlOyAe2f0qUG1Fc7QC7pHVDfi06RTlUGjwsOk7Jv6jdfKRKRxiGjxJmLsBw
         tnOGLcSZFs135Ul9n4wfIBHE7WvdImq59mQ2NRiiQ/2Xs7cnY+Od6Zng2Hhu80SivZuX
         h8+YRS+/gWAApmndI0uan4Fy1dQOSbNhA0/68AGqyrulT3qayVf8HM/ucDfBX8+CjTn1
         C5I6Ltbu8mycfq+5A+5CBLEWX1Zao9LLGHnCl2SIv6rlPzX3HxQkKv7AdqNrzTNVcAur
         tYeA==
X-Gm-Message-State: ACgBeo2ANIJ0aLOG5QGu2Kk+K1s2bsApENxVcVIuM3O+6HqSbVrjFYtn
        K9f2v+TzF7YIrx9z92fDFNZL5eTzRW7d5PCj
X-Google-Smtp-Source: AA6agR4Is0cNvtthZ0GBVbIlHsNV2UxLJ5+wiTseqY0ADyiUDz2Rvp22MoBpC8c9uozMrBG6qdEv/Q==
X-Received: by 2002:a17:907:1629:b0:730:7ad7:24f2 with SMTP id hb41-20020a170907162900b007307ad724f2mr15309500ejc.261.1659992937467;
        Mon, 08 Aug 2022 14:08:57 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b00730af3346d6sm262878ejf.212.2022.08.08.14.08.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 14:08:56 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id p10so12199068wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:08:56 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr4249574wrv.97.1659992936121; Mon, 08 Aug
 2022 14:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <Yuo/mq0VrqTH9BS+@samfundet.no> <CAHk-=wj6SoG7iSDLijPKWQXhJkfTknMTQ9ZUUTpz+pY=Sq5ziQ@mail.gmail.com>
 <YvFnL37+33cSIo3g@samfundet.no>
In-Reply-To: <YvFnL37+33cSIo3g@samfundet.no>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Aug 2022 14:08:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6MtKfJCMvcR-O0HMbtGXxZXxrpZ8vUaHO2KFcbRUTOQ@mail.gmail.com>
Message-ID: <CAHk-=wi6MtKfJCMvcR-O0HMbtGXxZXxrpZ8vUaHO2KFcbRUTOQ@mail.gmail.com>
Subject: Re: [GIT PULL] AVR32 change for 6.0 - outstanding cleanups
To:     Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>, hskinnemoen@gmail.com,
        linux-kernel@vger.kernel.org
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

On Mon, Aug 8, 2022 at 12:42 PM Hans-Christian Noren Egtvedt
<egtvedt@samfundet.no> wrote:
>
> Sure, no problem. I will create a signed tag for next round. Almost done
> removing AVR32 leftovers.

Thanks.

            Linus
