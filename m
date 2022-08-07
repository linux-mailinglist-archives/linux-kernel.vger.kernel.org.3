Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0D58BC20
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiHGRz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 13:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHGRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 13:55:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75779D9F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 10:55:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b16so8914901edd.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tH9P5Ev6KfldpgA7IyGsP6cuudklMvx95MGD8TKUKT4=;
        b=C4CL1iu+qx5rdNpY/Qdx3Op6dbE/9zKXo4LCAeV+cbmx/rvLCK+FcObJUilhM226pd
         qtTxjZWV0gQfDYjqPT/IttAiEKQ6zFvDllkAQkGzhczUFYexBZVFtNxH/hwngF0cEm0M
         jFXxpFIfpzmNNaiVAKGaWiV4JLbHqQY4j7Qg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tH9P5Ev6KfldpgA7IyGsP6cuudklMvx95MGD8TKUKT4=;
        b=4KaR104PK9WBGrJEQ1HJvVejP3KqeEU0E4u4w44R3wRIkfd2gTFX/hX9RnFsLoG5Hq
         CT+OLWdEmC84CjefS8fZoYAg2EozaBUpoefQ4sMiwDgyRNPbf7ZaPREUmRmhiCW87EzK
         eqLwvExXziO3bxzdW6TfLNfb8QF5XM7SZNNoWoYsmpin7LOSi+hhRhe+qCtVAemQtU+x
         PpPMgolsI0TLoZJVrM/SX4PFcO/yw0bvcBPNacTYpbg5912tGpeS0aP/u36yL5f69pa6
         vaylQlLL+iw2Y/sdgCPNS3zn1sr66n/2671hJgeapg+WfRoy4eE//3fTPmzjLEovZhgm
         HFwA==
X-Gm-Message-State: ACgBeo0WkDAQVDSfWHZe5k+6tROtfElsjGeXAUo/fNimevHEZNlTwuru
        ySPdY9WDzOI89g61+ZRwYYiyQ0Zvuyf/3fIg
X-Google-Smtp-Source: AA6agR7zn/HOwUtp6neV7WNPBpb64FANwh/ujVrQKpG2ZqdRGM7NaBk2b3eoV26pjuM+aGjx3cSDKQ==
X-Received: by 2002:a05:6402:194d:b0:43d:8001:984b with SMTP id f13-20020a056402194d00b0043d8001984bmr15029924edz.327.1659894922540;
        Sun, 07 Aug 2022 10:55:22 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id jw16-20020a170906e95000b00726298147b1sm3966246ejb.161.2022.08.07.10.55.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 10:55:21 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso3466923wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 10:55:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr10178442wms.8.1659894920750; Sun, 07
 Aug 2022 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <YuwRyQYPCb1FD+mr@debian> <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
 <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com>
 <YuwvfsztWaHvquwC@dev-arch.thelio-3990X> <9fb73284-7572-5703-93d3-f83a43535baf@amd.com>
 <CAK8P3a3Fv=_+GV9r=k4jP72zZOjJowL-GOue-51EhyVDBaEfEw@mail.gmail.com>
 <Yu1bMqL5tsbq1ojj@dev-arch.thelio-3990X> <CAK8P3a3PAxkctN6AXOsoTBTFgwHhk7_OSYwJ4Rgk7Dbs+bc0Qw@mail.gmail.com>
 <cb3ea155c4e149eca30ca870e3f2546d@AcuMS.aculab.com>
In-Reply-To: <cb3ea155c4e149eca30ca870e3f2546d@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Aug 2022 10:55:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghheK1pKhpu9SuQkjzUvu25-vTu8nyxozooarhAmaXhw@mail.gmail.com>
Message-ID: <CAHk-=wghheK1pKhpu9SuQkjzUvu25-vTu8nyxozooarhAmaXhw@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 allmodconfig with clang
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
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

On Sun, Aug 7, 2022 at 10:36 AM David Laight <David.Laight@aculab.com> wrote:
>
> Or just shoot the software engineer who thinks 100 arguments
> is sane. :-)

I suspect the issue is that it's not primarily a software engineer who
wrote that code.

Hardware people writing code are about as scary as software engineers
with a soldering iron.

               Linus
