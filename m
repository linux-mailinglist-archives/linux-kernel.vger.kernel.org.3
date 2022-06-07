Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1153F324
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiFGA5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiFGA5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:57:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3251B39F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:57:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s124so3861287oia.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 17:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRiFsLC9SeH0FFFGEjlYZ7IOB4E8/s+Bg3paFj+vMwA=;
        b=ClVS6XkDBPjed3XagEC9qLf9ritssqvXY2SQwxGZ9/rhwjNCT620eBGwTyHfDlxvlf
         zRWD+/+BMGgBY8M69TylBpaoaQombhL97qlbPl64nrwS7QqyqONPHqQHUnfvlefI0C7l
         0BFaoOU0dhTKAqqr77uZd3+mtySGARPaCdu6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRiFsLC9SeH0FFFGEjlYZ7IOB4E8/s+Bg3paFj+vMwA=;
        b=Bm28/Uo3AWRhdL6SwMXbSFBWhnzJNXxZHc0Ii/XVUhWnBsqoKmPjgxYNqtYwn/FbiZ
         FGq7MsTt0hzx09hzIM6xXxAHOuzqYpyELBVyP82bok7nNbZlFWebRD0qvMyL4EJDTkE4
         9q5DJuQrQWgt+HBzvppcQ1NtCwpBRYZUpOrZC+yptR/Nd04LxceH9KMNXlTPnCHtFUa/
         2mZqZAz/hhE5MdOqII5rvBvQauiWF3nSxiBUmP6AipwA4Bf+q8G2IZK2Ym3qFRuGMbmv
         TFXxvocCxFAM7QJ5WMEvczI/zmWOliQN/j7cKJHJFEUOkR+whp43Iqo3AWW/T8TEZWgZ
         nUSQ==
X-Gm-Message-State: AOAM531L2ha6HT4HFgMmTCzIAPK7mg/lOMb0npn72CjGvF1MFHjSOEmP
        YTBJTFFTvgc69t2um6KpEc6TAEgutPeh7w==
X-Google-Smtp-Source: ABdhPJwNPtbWFtVZUGFUlL3xoC5F49uoxsf6lyIquDG4ILWsiwuaD2DBZkhZ5N0RxG/XU/wj8njPZQ==
X-Received: by 2002:a05:6808:1281:b0:32e:b7fc:814d with SMTP id a1-20020a056808128100b0032eb7fc814dmr324215oiw.290.1654563429308;
        Mon, 06 Jun 2022 17:57:09 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id w4-20020a4ae084000000b0035eb4e5a6bfsm6766212oos.21.2022.06.06.17.57.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 17:57:07 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id r206so21976930oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 17:57:06 -0700 (PDT)
X-Received: by 2002:a05:6808:10d1:b0:32b:a63b:fdda with SMTP id
 s17-20020a05680810d100b0032ba63bfddamr31727326ois.257.1654563426487; Mon, 06
 Jun 2022 17:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220228202532.869740-1-briannorris@chromium.org>
 <CA+ASDXNSThy7usMKkN22VBq2iyej7sCJ8CAmgnNvxDgZiMbukA@mail.gmail.com>
 <CA+ASDXMW14GqJUAogQ0=dVdamhTTGDzcMRv-8Cx-TaXShHxj+A@mail.gmail.com>
 <CAOw6vb+myB0gB1kPvwuL+T1Ka10gDN5rGS2hW+UG+-+K2NGz_w@mail.gmail.com>
 <CAD=FV=X1F61nDcoQz4w1pJX_=Zzt6sLH8bcsGrxxTpGs6=yZ4w@mail.gmail.com> <CAD=FV=URUUEtLfJprO72s307Op4Y9CQw0Uk3TUPBq8XAokhCsg@mail.gmail.com>
In-Reply-To: <CAD=FV=URUUEtLfJprO72s307Op4Y9CQw0Uk3TUPBq8XAokhCsg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 6 Jun 2022 17:56:54 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNmSwk_d7Nc_b=2s8LxE8KBeiwic_0w1sOynMfZg8w2wg@mail.gmail.com>
Message-ID: <CA+ASDXNmSwk_d7Nc_b=2s8LxE8KBeiwic_0w1sOynMfZg8w2wg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: analogix_dp: Self-refresh state
 machine fixes
To:     Doug Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liu Ying <victor.liu@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 1:30 PM Doug Anderson <dianders@chromium.org> wrote:
> On Fri, Jun 3, 2022 at 8:17 AM Doug Anderson <dianders@chromium.org> wrote:
> > On Fri, Jun 3, 2022 at 8:11 AM Sean Paul <seanpaul@chromium.org> wrote:
> > > Apologies for the delay. Please in future ping on irc/chat if you're
> > > waiting for review from me, my inbox is often neglected.

OK, I'll try to keep that in mind. I can't help myself with the
semi-relevant XKCD though ;)
https://xkcd.com/1254/

> > > The set still looks good to me,
> > >
> > > Reviewed-by: Sean Paul <seanpaul@chromium.org>

Thanks!

> > Unless someone yells, I'll plan to apply both patches to
> > drm-misc-fixes early next week, possibly Monday. Seems like if someone
> > was going to object to these they've had plenty of time up until now.
>
> As promised, I pushed these to drm-misc-fixes:
>
> e54a4424925a drm/atomic: Force bridge self-refresh-exit on CRTC switch
> ca871659ec16 drm/bridge: analogix_dp: Support PSR-exit to disable transition

And thanks, Doug.

Brian
