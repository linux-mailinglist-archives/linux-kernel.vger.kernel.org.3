Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F950C14E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiDVWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiDVWBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:01:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21D306728
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn33so11009351ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7zvOy4Nu2CZwXC2YGCoJs9vagHX2+J0L34nHsp83yk=;
        b=DfG+M/ORpXZPBdQvWZZK/E9FnBMkrgnax6RCiGFmGYuqE2J2XTjryHKJuwF9GsxnR1
         8TyKRm500f39QvNnoE1Z/T8eT2Y2SHZyDLcpBsXLtb4f0n8UwNW1f33SC/zlmWHx5BNM
         WE42YK0v+aT6a2sp2qnEHIv8xSPVSWn2KhDLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7zvOy4Nu2CZwXC2YGCoJs9vagHX2+J0L34nHsp83yk=;
        b=yQpbU+by0d66TTSyaY8D2CXRZ8YFTw/ZxDaTpDFASYSKggV5oCsz5sJzmEJU+HbSzt
         qJKoPxzDWDhYmnX+1dWhvsVUREICD57TyxKrfKIQKmNiins6+oRsfjzixqE+0yBMhty8
         um0l09rJp//MXw34/tU1M1t0sdC3VmGEzJr45GOoREcbEE6+oBX6QzkyZBPyRalIugwG
         7XfhtfnsiTTXpa0K+0cbTQVuoOxxm4fO0Y7KQO/qzJQ3MlrsKJzLOYUMdDhiDNkg70Yu
         +QQs8oFIBEkXoSNwb/BhBCZLUnSKF115ElEfpdBsgYWoPgjYMCTVXS66bCX/tzezCrR5
         vY5g==
X-Gm-Message-State: AOAM532W4WgS9PoSfQ6x1S0v5Ix1C0O1YvbHLgzzUQbhITvl9Rzhr5Di
        f91Syt0RuFM11eul+NBOJYoVv/Eq2pCGDgXrGJ8=
X-Google-Smtp-Source: ABdhPJwcH0Oi4KDBc32+N8n0DOf/qXGkRGXcNIvOYknvAtckjJ0iXlkQfMe8nwBlSL3KNthIs4wGfg==
X-Received: by 2002:a05:651c:516:b0:24e:efc6:a92d with SMTP id o22-20020a05651c051600b0024eefc6a92dmr3982070ljp.189.1650660310880;
        Fri, 22 Apr 2022 13:45:10 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id d6-20020a056512320600b0047196449b7fsm345627lfe.92.2022.04.22.13.45.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 13:45:07 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id bq30so16288967lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:07 -0700 (PDT)
X-Received: by 2002:a05:6512:1193:b0:471:af88:2d74 with SMTP id
 g19-20020a056512119300b00471af882d74mr4247383lfr.531.1650660306799; Fri, 22
 Apr 2022 13:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
 <cover.1650631347.git.legion@kernel.org>
In-Reply-To: <cover.1650631347.git.legion@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Apr 2022 13:44:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
Message-ID: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ipc: Remove extra1 field abuse to pass ipc namespace
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Containers <containers@lists.linux.dev>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 5:53 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> Yes, Linus, these changes are not the refactoring you were talking
> about, but I plan to try to do such a refactoring in the my next
> patchset.

Heh. Ok, I'm not saying these patches are pretty, and looking up the
namespace thing is a bit subtle, but it's certainly prettier than the
existing odd "create a new ctl_table entry because of field abuse".

So this certainly looks like an improvement from a quick look.

              Linus
