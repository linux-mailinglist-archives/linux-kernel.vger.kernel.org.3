Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AA4EA5B5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiC2DIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiC2DIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:08:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030923D580
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:06:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id pv16so32425368ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=majIMrAQJV71YPzSlBnjkczvH04u3JpSgRpru/mKNwI=;
        b=OE/8XdZO0U1XwOdwZvKOmB9ArHGGxYHjLRGdSkCxg/SYfVDAtoQCtWsh4SAe/8PX/d
         GQz2Vd4fGWPxakJKTFWNrjJuZ6p5SkdYnAEUHFQ/biR3bCF1tmGqUPNt44Jd/0/2HycX
         WsXE7vUKg1jjEUbRbgStj58DRxWSyf7hHwJYgONyrLjmQkGOR2Lj4RlJPx+DWnaACI+H
         2BbvFtlucYyFuNW5aSSa2r6RBogTJ57QVCtPVyRwm/xlvzhZZJOtes7XiIkU7um6hq3+
         bAK7nLgvTslXo2vIupN1jI+CxSwrxNLVKm6SOSBQMopSotjY/b3+t6cxB4WhPsVIEQlx
         Xf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=majIMrAQJV71YPzSlBnjkczvH04u3JpSgRpru/mKNwI=;
        b=e3YrcgMP+brhlVgmqVlbKhH4q52MxpeM6bfMkyg/kO9IQKW0Y3g3sLAGzELDiV87TH
         20o66DgphI8ILMOWBm9QerpzwA2hmDa/bgIKnAy6deZObDqbsk+uZrCEcafPLX+EdsYs
         9le5Mug6eaQMwHNTFWqU890ZZvot3iawuy03sTnRMZF1oZDzCQrCDGa1QG/ThU0gF18o
         nlKLoL1c2xvbSewi2SEwN8+ift3dXZzjkHbLzvCA1rhh1FBbdkpOsqJ5CCcW130wKnNL
         P2UmasTmaKFfPXZRKmvtfWGEqstTyAsanSWrObVA0nvAaW8biPXN6xF9MNWDtfhhAbWA
         IIdQ==
X-Gm-Message-State: AOAM530PYCQKydv4UGEXptZbfGYPlaaH6BvVq1i/LpiEkn6egQiwCzwQ
        k7rtYmb8af7hA7AfbkeAFWfS0gpLGeZv4G0cIIfmotMMJQ==
X-Google-Smtp-Source: ABdhPJwxvKXjuRQLM5CXz8zQ/1TTqz+2aEfCtwrrfzLfU6uyWbEAJ1kHAmQY140LuR+JY9XFlHXnUw9EA4TFucXN2Kk=
X-Received: by 2002:a17:907:7fab:b0:6e0:6f26:123e with SMTP id
 qk43-20020a1709077fab00b006e06f26123emr31459725ejc.29.1648523183789; Mon, 28
 Mar 2022 20:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com> <62426553.1c69fb81.bb808.345c@mx.google.com>
In-Reply-To: <62426553.1c69fb81.bb808.345c@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Mar 2022 23:06:12 -0400
Message-ID: <CAHC9VhRNuoPH6AySUbe6h2D6kghhezyVQtTAvm-t-fTpXH6XwQ@mail.gmail.com>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
To:     CGEL <cgel.zte@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        eparis@redhat.com, linux-audit@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 9:48 PM CGEL <cgel.zte@gmail.com> wrote:
> Sorry could anybody give a hand to solve this? It works well on x86_64 and arm64.
> I have no alpha environment and not familiar to this arch, much thanks!

Regardless of if this is fixed, I'm not convinced this is something we
want to merge.  After all, a process executed a syscall and we should
process it like any other; just because it happens to be an
unrecognized syscall on a particular kernel build doesn't mean it
isn't security relevant (probing for specific syscall numbers may be a
useful attack fingerprint).

-- 
paul-moore.com
