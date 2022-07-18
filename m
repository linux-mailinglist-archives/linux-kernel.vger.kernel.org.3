Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB71857895D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiGRSMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGRSMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:12:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B41F2E2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:12:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy29so21649593ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptF8zHni/dtF/nc99e0aS7F9CBaQ1NQmrwLtsXW03QU=;
        b=WLyD2pZm7WFWV0QaL0PhAfQSRcvuRbbKAWfzp1L7fMHys2t+qnoQAujZpKmy7i4Hhv
         OeS9xnhrwrCer82ERIEdi2LUE9/IB8xAlXaEaWaRXVw7iWZ0kNrPKgRDvocxsD8X4Bn7
         dLiwoFzF7lf0mSE7SpIhYQeAsWlCShpDHVRVQNzS2mJwndt/XRktR35mJ3ADGYJqLODd
         GrHLf/NGUToOBm5kJGfyBPjsvp/aR44wz8YCKlzZuWmuZMKm6rHsGuMiXCgp+Vg81d/E
         nt3gkczcL8UN0W8DWf9Aeo43rqMjwJI6l4oJM5ox9KyN2lL0JCrOPKb3ZxOKzkIxGWiX
         yefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptF8zHni/dtF/nc99e0aS7F9CBaQ1NQmrwLtsXW03QU=;
        b=niD4raLBvpSZRVb9eS2fz9GznalTnLlErn/CX1o1UGryaPe+7W1YmvZ/DG9/0rBjLP
         q2Dus+H/zu76fxA01mX2KlIDXFy9vVqOW3M7qB7slcfaoZumTkqC0/sayi3KwojefetF
         YVgbpZ32IrNrM9fQ6qaubQpvmZ5XZm2mRX1vDul6My2XmDFJ3Nz3ozbnvQfemmfAngcp
         dgixQ7q7NpicJIOs3ctNSeQLXCJ8UORQAfZ5gAakDrBRHukhVaS1ZtvNTJSYGaAguqPn
         3VB1l+cFjXzsuk4+WaYw0brY+D63PsmsMY8c0lvIr4VefJZc+JZ4iqmPlybzlK40pm8b
         hEIw==
X-Gm-Message-State: AJIora9ZYbhq0pCZ+Svg5eg7u7jSfjE0gj9kZxvCoYHqxg0Q5IrVeZd9
        WTiiD23D0WsdJtkwkf6uVCKR/TlgkwKIVz9h3lsbbA==
X-Google-Smtp-Source: AGRyM1tIpFXGKwBA7g7NTk2J12W2l8iAubFWg76YY8MRePclnJ0eaSkzPB7GUnwn/AKCeVfwy6FfRlgnPdtXqEaRbAo=
X-Received: by 2002:a17:906:844d:b0:72b:307d:fb52 with SMTP id
 e13-20020a170906844d00b0072b307dfb52mr27243273ejy.182.1658167957169; Mon, 18
 Jul 2022 11:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220608223539.470472-1-justinstitt@google.com> <YqJYrImC3Bk40H1H@dev-arch.thelio-3990X>
In-Reply-To: <YqJYrImC3Bk40H1H@dev-arch.thelio-3990X>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 18 Jul 2022 11:12:25 -0700
Message-ID: <CAFhGd8qTc-=Fjw2LZW4HYJtVyizkLhYRyv-TYLd1ji-9oR9EdA@mail.gmail.com>
Subject: Re: [PATCH v3] include/uapi/linux/swab.h: move explicit cast outside ternary
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Justin Stitt <jstitt007@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance a maintainer could take a look at this patch? I am trying
to get it through this cycle and we are so close to enabling the
-Wformat option for Clang. This patch fixes over 50 warnings and
there's only a handful of patches remaining until we can enable
-Wformat.
