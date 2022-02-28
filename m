Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16B04C7124
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiB1QBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiB1QBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:01:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D99583025;
        Mon, 28 Feb 2022 08:01:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so6376687wme.0;
        Mon, 28 Feb 2022 08:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aizF1/4lDI+yEy/WBxd8YVF7MFTOczvWHCG6YamD9nM=;
        b=blm/2RrpCx2TsR/aMRP+1EJLebTjElVVfw8i40QiGlQMN6Wi4MltaOd+UtUI+4NfFD
         OvIwLBmq5XdskxKXmbGsJfayfiwvCeecqgTkJnMpwimuFXPulAUNE5iV9YhTJHFU95qd
         n8Ndhugd5pEd90a++PIz8mlF56J1Vx6yIEFPX+C6J9mqn75oWffmgBOskCPhEa/qDNwj
         ZlMyqEqVWCIDC3l31oKWlahqUm6m8aW6WF/ezxGwyoiXUJpvyrkNusfWFeucWTq4hyqF
         NmcFd8Opv10P0TT05CAnQEmiN4DKlzGYCa/ykxZRnKFOiNgFKfuA0gi+i9kuNYXp58M1
         1Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aizF1/4lDI+yEy/WBxd8YVF7MFTOczvWHCG6YamD9nM=;
        b=3wx3XNEpRoy60uY4W1IF0U460VzpM55GDoDJwk5C9fehh4caGZVozBRB0sX0gGogtS
         regZ7gaS7Pkcl3QLqEKFLhc4rAlgM+H3/CNbc7lVpktekbmn7QjRbW58se/RxpiRgbQm
         T/J9lzFpBCpvwPhIycPSRb//p90lVPoXFQEJYRF4iHZVJ7iBdk0zK/ar4ECEDQ6Ng5L9
         Ykp6l7Xcs9zN2/VICElSPVx/BZHfDpij99A+nBu35DnygpCXoc4DYPjHcb0tRtDfQejr
         D6YKmd1Et4c5x7MTWdEjhpmV26rg54DXyORTFUhOgREKEwyIjoa6yqQU082PiDaFf12C
         tlnA==
X-Gm-Message-State: AOAM533SsiBOPlre66kGxjc/QTAA04aRqinWVJGpNJHrxyRJwsk989VK
        9v8Ixibh5825e1eJNLinmFlbz5LJh4wsceZznos=
X-Google-Smtp-Source: ABdhPJzF+Eh23FRqoZaEV8ax1NSHQUu83RaAE2w3foKNDynSteZKOLsVwgh4y2QhxxN5kXgYFvHjBSOQuJyfTdpPugo=
X-Received: by 2002:a05:600c:25cd:b0:381:4f09:a4b6 with SMTP id
 13-20020a05600c25cd00b003814f09a4b6mr8198514wml.44.1646064063544; Mon, 28 Feb
 2022 08:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20220225202614.225197-1-robdclark@gmail.com> <20220225202614.225197-3-robdclark@gmail.com>
 <CAF6AEGvXs9etrtBUP5fAx7z6pLMV76a-FEXrdk2gY8npDHrFnA@mail.gmail.com> <f460b115-6ff6-7f69-8b0d-174c4defc771@linux.intel.com>
In-Reply-To: <f460b115-6ff6-7f69-8b0d-174c4defc771@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 28 Feb 2022 08:01:34 -0800
Message-ID: <CAF6AEGsNHkODt4oOgAhLdrik1Jt-cfcyjk+nGzDhSMNfFMEWsA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm: Expose client engine utilization via fdinfo
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 6:33 AM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 25/02/2022 22:14, Rob Clark wrote:
> > On Fri, Feb 25, 2022 at 12:25 PM Rob Clark <robdclark@gmail.com> wrote:
> >>
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> Similar to AMD commit
> >> 874442541133 ("drm/amdgpu: Add show_fdinfo() interface"), using the
> >> infrastructure added in previous patches, we add basic client info
> >> and GPU engine utilisation for msm.
> >>
> >> Example output:
> >>
> >>          # cat /proc/`pgrep glmark2`/fdinfo/6
> >>          pos:    0
> >>          flags:  02400002
> >>          mnt_id: 21
> >>          ino:    162
> >>          drm-driver:     msm
> >>          drm-client-id:  7
> >>          drm-engine-gpu: 1734371319 ns
> >>          drm-cycles-gpu: 1153645024
>
> Nice, so my vendor agnostic actually worked (with that single fixup of
> accounting for the fact pdev tag is optional)?
>
> > Note that it might be useful to have a standardized way to report # of
> > cycles and max freq, so userspace tool can derive %utilization in
> > addition to just %busy
>
> How do you define %utilisation vs %busy - I don't exactly follow since I
> see the two as same?

so, say you are running at 50% of max clk, and gpu is busy 70% of the
time.  The utilization is only 35% because the gpu could scale up the
clk to get more work done.

> Looking at your patch I guess I don't understand the difference between
> 'elapsed' and 'cycles' inside your retire_submit(). Both are scoped to a
> single context and are not global? If 'elapsed' is time context has
> spent on the GPU, cycles isn't the same just in a different unit?

Correct, we capture (from GPU cmdstream) two counters both before and
after a submit (aka execbuf) runs, one is a fixed-rate counter, which
gives us elapsed time.  The second is a counter that increments every
clk cycle, which gives us the # of cycles.  With the two values, we
can calculate GPU frequency.

BR,
-R

> Regards,
>
> Tvrtko
>
