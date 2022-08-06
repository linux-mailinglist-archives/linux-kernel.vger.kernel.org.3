Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35B958B7AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiHFSYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHFSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:24:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C9D2FA
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:24:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so6944380edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1I4G9L6qjgmMFeCXHvnLKF55g/a01yjk4dobXvt+Ffc=;
        b=H02+DAvaDUti5KsAJIggyoGphzpfSWldCLU3XNG4znVdoKes4HJZ6/25Am7Es2ryqF
         JnKWT50+nIlaXjUlm4yk7knvyXzoq2QPM/HismLry64sgWhJbAFU7w9iCmb31aISNfXf
         Ge9c+XFCFIP4P43seP5VcnjyzxbLLQS4kAhRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1I4G9L6qjgmMFeCXHvnLKF55g/a01yjk4dobXvt+Ffc=;
        b=lx5W5qNptSXZNM0Dkg53eZllUjoy1PcNTFpVnlvsOL7lJLc3hcG7t6K+vd1EPCfpYQ
         J875c0xbHmxem65FNwocUKSs4o1MdIsACoqOrTGTvfCHDxyXNy5W///X+OqH3dU9qsqc
         SSeyk1tWPcVn11bYZjWhfTcGa/W2MSyGYPMjiR+HK3CxirTsfYc41cYGJeuTTu9aM57d
         OntRZItzj5bmnvYpI+8xkA3g3UP1vGaZyW7wghjO2sl+D3ICqvLInfkqQgR9g/1KNVD1
         4oyLHAa2IvMz/leFPBE+BClvewmHrO1FWagbJu9vQUW9PNasRhV3DlbWy8VATMUg94n5
         mE4Q==
X-Gm-Message-State: ACgBeo2sJEebw0Il1Wex9kkJv+ugVBE+PdelKL9LB9u+8RXd37m+/F7Z
        Rbb8iZsmuhQh6GM2+oJQsvEJFbWy+no8igf2
X-Google-Smtp-Source: AA6agR66q/75yjLK7CeGlYPImvxd/+X15tIM9ohfyO5NOVEnCM9L4TC+IFGBHeGJ2pIztpN4ePFNaQ==
X-Received: by 2002:a05:6402:5289:b0:43b:69a9:38c8 with SMTP id en9-20020a056402528900b0043b69a938c8mr11779991edb.263.1659810286305;
        Sat, 06 Aug 2022 11:24:46 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b0043a7c24a669sm1790099edq.91.2022.08.06.11.24.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 11:24:45 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 17-20020a05600c241100b003a536b6d536so385535wmp.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 11:24:45 -0700 (PDT)
X-Received: by 2002:a1c:2582:0:b0:3a5:1453:ca55 with SMTP id
 l124-20020a1c2582000000b003a51453ca55mr7530914wml.68.1659810284792; Sat, 06
 Aug 2022 11:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220803104936.7df810fd@gandalf.local.home> <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
 <20220805124701.4b44195d@gandalf.local.home> <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
 <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com> <20220806142203.3c133322@gandalf.local.home>
In-Reply-To: <20220806142203.3c133322@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Aug 2022 11:24:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTRbL22B=-SJ0fwqpiXZnGe2LGPs8DjToUk=ezKsKVjg@mail.gmail.com>
Message-ID: <CAHk-=wiTRbL22B=-SJ0fwqpiXZnGe2LGPs8DjToUk=ezKsKVjg@mail.gmail.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
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

On Sat, Aug 6, 2022 at 11:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> With the below patch, it will show the warnings for both libtraceevent and
> libtracefs if they are not installed:

Remove some of the unnecessary asterisk noise, and I'll be happy.

It's not like that really adds anything.

               Linus
