Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60F64B2DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352985AbiBKTrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:47:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348914AbiBKTrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:47:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92FBA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:47:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jg20so97769ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyW2RvUVThJw06bUbJiNTwFzC14YMAiwBkIxJA9HVqA=;
        b=fk4MlPgfufFkzden53r8tdrtiY2olSabM+JYGLwFwqF/cOkePLqyEE4j1602ziq77p
         UWKcvm7srqe3JFw6+5XcPPI2wrNsxphLMMKunbl8I0xoWDHrSMKeCxUraO1QS/42fw8l
         e6q68Q/M4XyooiwX5MeN93NjjlynuqBqyNmZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyW2RvUVThJw06bUbJiNTwFzC14YMAiwBkIxJA9HVqA=;
        b=hW2TQ3vxvIXfD6FbdMc894T+5pR9OMutbM+MQbHZ9nDnDrVX++p4qTn274qXsb9Np7
         VchnIaz/0ffS/udgwKDm3BOnu9OgaxszzZYce7cnhNBeahRJ7NL+2MOhx6Vm7vMlmUlf
         WgdS5+Xl+UXWGwTTclkpSSkh8teOLHtqdo2H3tCxBmLuVkRxOBwMtFH5Ifa8Gfwt3mtI
         tZeF10oBBZ+Cgw6lBgd7xiZDxPecDLx+O28DS/AHgj0j7iMqUBLh04PEyusOl4o6pnF9
         Nv36rFWU0Dc0kQ/ZnNKH9ehD0r1xPLku7DmUlDZZ4kY/MfIMcMUD3FftgxtunK4a5du9
         nw8A==
X-Gm-Message-State: AOAM533qnIkskOdIH2xflzd3tOeB9bRPrXX8zFHkxh81HNSea+BDoq10
        OM4joq4Y3YiZVKAR+ZyMrNPUBLYdoWWL2K4OtQc=
X-Google-Smtp-Source: ABdhPJxIv8xbwB81dSuhofo7HkVUX1ra+9ymF/bKzlcR9z9HoB2r6SpCyb66uKhAyB+YnCsk8KWoEg==
X-Received: by 2002:a17:906:7a48:: with SMTP id i8mr988689ejo.278.1644608860787;
        Fri, 11 Feb 2022 11:47:40 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id i36sm7180649eda.52.2022.02.11.11.47.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 11:47:39 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id q7so16860646wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:47:39 -0800 (PST)
X-Received: by 2002:a5d:590d:: with SMTP id v13mr2505912wrd.274.1644608859573;
 Fri, 11 Feb 2022 11:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20220211170522.348999-1-agruenba@redhat.com>
In-Reply-To: <20220211170522.348999-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Feb 2022 11:47:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgURPnzwmWtgT-WSrpfFX9_wx_ZsY1XWp1MehrUuBuNiQ@mail.gmail.com>
Message-ID: <CAHk-=wgURPnzwmWtgT-WSrpfFX9_wx_ZsY1XWp1MehrUuBuNiQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Feb 11, 2022 at 9:05 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> * Revert debug commit that causes unexpected data corruption.

Well, apparently not just unexpected, but unexplained too.

That's a bit worrisome. It sounds like the corruption cause is still
there, just hidden by the lack of __cond_resched()?

                Linus
