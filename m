Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96058AE4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiHEQku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiHEQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:40:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013DFE0CA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:40:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a89so4067929edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CF9ugN+Mf7L3rdh4/Oj8vQg0nb9ub1XMrmT7JuQIXRw=;
        b=P+zjZXYexTLnMrdhIk7AwVUhY+JCrxCiK/E11x8yYxZF7vSG9x4/PDKTBmijVtIAOW
         7ILLNDtF/H3C4hBkB8lCvPwlwRzgm6LcCqI1iOrle/+vobpRPAAXF20WQZadQw5uNdii
         TK4B+TCjonxHYKn58th0Lc6TifD4ccdo57hdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CF9ugN+Mf7L3rdh4/Oj8vQg0nb9ub1XMrmT7JuQIXRw=;
        b=jtJO7TuAQhl3ef3QOFvoafSKyt0fzuJlRfbT3JskdkynZ3vens8KHRlVEtzyfcd9sP
         JVjMx7wYYjYm9m+zge2JTgsVQBqr2J2EeNcAfm8+A3DeRflsIgP4mf81RboElZJT7muC
         ZA/gRygSSK5sTGsCX2t6SGNLTraLpNbeK0psb/VLA7UHEOjcuGKppWF8SUKJ6XzLcmaa
         XAHdJNKVwt/Wr7oKuiQXJ3WHFkys6gMYbO4HLCL9zJp4S8gxednmSkLN1THMsUM1id5S
         3PrxhxA4LpoG2w+CwvFThxoOYszAuofZTP4h7cHIYgDy6hlM6PYHswuwvGQ91ES8ANPx
         X/+g==
X-Gm-Message-State: ACgBeo1vxJclgdychjfJpri3KfbMeBf5/x/AvI0s5YTRY8lgYQPzpvpr
        6TyOO8ttF8gdI8gRAmG10EoNiV/WCgRnWNhZ
X-Google-Smtp-Source: AA6agR6HpXVvb9nmLdvT8RWzwuJQ3k1vGSvYQ+IbuD5TaTDsCXwt/tuohKkE0ykg1xSQYB4hOZv23w==
X-Received: by 2002:a50:d0da:0:b0:43d:5f5f:32c3 with SMTP id g26-20020a50d0da000000b0043d5f5f32c3mr7409875edf.192.1659717642358;
        Fri, 05 Aug 2022 09:40:42 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906305200b00730799724c3sm1739873ejd.149.2022.08.05.09.40.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 09:40:41 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so4209507wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:40:41 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr5134830wms.8.1659717640997; Fri, 05 Aug
 2022 09:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220803104936.7df810fd@gandalf.local.home>
In-Reply-To: <20220803104936.7df810fd@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Aug 2022 09:40:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
Message-ID: <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
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

On Wed, Aug 3, 2022 at 7:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Changes to RTLA:

Btw, I note that the error messages for missing libraries got fixed
(already some time ago, not this pull), but didn't get around to
actually building until now.

It says to do

    e.g., 'dnf install libtraceevent' on Fedora

but it's actually the devel packages that are needed for building, not
the bare libraries.

So it should be libtraceevent-devel, and libtracefs-devel.

             Linus
