Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B490350ED93
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbiDZA30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbiDZA3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:29:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CE3E5F6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:26:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d6so15325458ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2mI9B0DfTP2uJaUf7MfHZkBOtDU6w3Evg/FiCjtECs=;
        b=ZAo4i9aIizuB1KnSDalJWjACTpGuilueJpEkV0piPBXdQXeBiA4F/vMOJi3P0NvVT2
         M6ypuMb7IJ+ouM9JOTEwFx8F6OtikCUItbjWpL0JCM9ai2o7AIs7vbEJLvGF5VRD1VBE
         JSxTwSQXqnzwvHp1eKR/VGQ2tF9bVT89+LQ5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2mI9B0DfTP2uJaUf7MfHZkBOtDU6w3Evg/FiCjtECs=;
        b=y/QqOEm4UE0jk5L0ZXLgFPmSy9xfcW97FCsWD4HhfD7gEsQR8jEjBywN7v8ellykcc
         Z7Ic3Ed5nshg0UmJFuE3AF/42OduR6jpKhYPnQvjt07IOWmcow+YsSqTr3rJ2jookh3G
         LY8agJ+fPs5OHbOn47OZw/c3X0UXNpxbMVEfG/tNL1Z+ke4Rgkbuqu55RSiy4LiNDN8I
         nmEi8+fWLsfQPoFrcEEU2av9ZG7cLg7M9CQ6HmzFEyk2d7TcjtPwcaoKgmg+X79qdUW6
         DahwiQdTt7fgagfgJ+MCNL5xJK1i5djwuDzYB7emT4G53CxUni49hlhJtmXhV/CkaFAB
         /A2Q==
X-Gm-Message-State: AOAM533LiefCWX1X778kdDk030sNbmg+CSwEaGr8qy1JWXDH4CSeX5zQ
        PBPjATRauQE++KIAUjxko7QqrqmVtgC2wFvf
X-Google-Smtp-Source: ABdhPJyTH03Sim4BYOHtV7oglUdhOjQbuQxKmlOqfnxgwoQnzkrRkzYb79+Sovn57AmXCUhCe8lnhQ==
X-Received: by 2002:a05:6402:458:b0:418:78a4:ac3f with SMTP id p24-20020a056402045800b0041878a4ac3fmr21662826edw.196.1650932776341;
        Mon, 25 Apr 2022 17:26:16 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id d26-20020a170906305a00b006f3a7ffbb0esm579857ejd.70.2022.04.25.17.26.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 17:26:14 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id r187-20020a1c44c4000000b0038ccb70e239so525305wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:26:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id
 l8-20020a05600c4f0800b00391fe3c40e6mr27927924wmq.34.1650932773356; Mon, 25
 Apr 2022 17:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com>
 <3b9588d2-d9f6-c96f-b316-953b56b59bfe@linaro.org> <73e2a37e-23db-d614-5f5c-8120f1869158@quicinc.com>
 <CAA8EJprjuzUrfwXodgKmbWxgK6t+bY601E_nS7CHNH_+4Tfn5Q@mail.gmail.com> <9b331b16-8d1b-4e74-8fee-d74c4041f8d7@quicinc.com>
In-Reply-To: <9b331b16-8d1b-4e74-8fee-d74c4041f8d7@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Apr 2022 17:26:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VxEnbBypNYSq=iTUTwZUs_v620juSA6gsMW4h2_3HyBQ@mail.gmail.com>
Message-ID: <CAD=FV=VxEnbBypNYSq=iTUTwZUs_v620juSA6gsMW4h2_3HyBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: move add fail safe mode to dp_connector_get_mode()
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 23, 2022 at 8:34 AM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> On 4/22/2022 11:25 PM, Dmitry Baryshkov wrote:
> > On Sat, 23 Apr 2022 at 03:12, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 4/22/2022 5:07 PM, Dmitry Baryshkov wrote:
> >>> On 23/04/2022 02:45, Kuogee Hsieh wrote:
> >>>> Current DP driver implementation has adding safe mode done at
> >>>> dp_hpd_plug_handle() which is expected to be executed under event
> >>>> thread context.
> >>>>
> >>>> However there is possible circular locking happen (see blow stack trace)
> >>>> after edp driver call dp_hpd_plug_handle() from dp_bridge_enable() which
> >>>> is executed under drm_thread context.
> >>>>
> >>>> To break this circular locking, this patch have safe mode added at
> >>>> dp_connector_get_mode() which is executed under drm thread context.
> >>>> Therefore no lock acquired required for &dev->mode_config.mutex while
> >>>> adding fail safe mode since it has been hold by drm thread already.
> >>>>
> >>>> ======================================================
> >>>>    WARNING: possible circular locking dependency detected
> >>>>    5.15.35-lockdep #6 Tainted: G        W
> >>>>    ------------------------------------------------------
> >>>>    frecon/429 is trying to acquire lock:
> >>>>    ffffff808dc3c4e8 (&dev->mode_config.mutex){+.+.}-{3:3}, at:
> >>>> dp_panel_add_fail_safe_mode+0x4c/0xa0
> >>>>
> >>>>    but task is already holding lock:
> >>>>    ffffff808dc441e0 (&kms->commit_lock[i]){+.+.}-{3:3}, at:
> >>>> lock_crtcs+0xb4/0x124
> >>>>
> >>>>    which lock already depends on the new lock.
> >>>>
> >>>>    the existing dependency chain (in reverse order) is:
> >>>>
> >>>>    -> #3 (&kms->commit_lock[i]){+.+.}-{3:3}:
> >>>>           __mutex_lock_common+0x174/0x1a64
> >>>>           mutex_lock_nested+0x98/0xac
> >>>>           lock_crtcs+0xb4/0x124
> >>>>           msm_atomic_commit_tail+0x330/0x748
> >>>>           commit_tail+0x19c/0x278
> >>>>           drm_atomic_helper_commit+0x1dc/0x1f0
> >>>>           drm_atomic_commit+0xc0/0xd8
> >>>>           drm_atomic_helper_set_config+0xb4/0x134
> >>>>           drm_mode_setcrtc+0x688/0x1248
> >>>>           drm_ioctl_kernel+0x1e4/0x338
> >>>>           drm_ioctl+0x3a4/0x684
> >>>>           __arm64_sys_ioctl+0x118/0x154
> >>>>           invoke_syscall+0x78/0x224
> >>>>           el0_svc_common+0x178/0x200
> >>>>           do_el0_svc+0x94/0x13c
> >>>>           el0_svc+0x5c/0xec
> >>>>           el0t_64_sync_handler+0x78/0x108
> >>>>           el0t_64_sync+0x1a4/0x1a8
> >>>>
> >>>>    -> #2 (crtc_ww_class_mutex){+.+.}-{3:3}:
> >>>>           __mutex_lock_common+0x174/0x1a64
> >>>>           ww_mutex_lock+0xb8/0x278
> >>>>           modeset_lock+0x304/0x4ac
> >>>>           drm_modeset_lock+0x4c/0x7c
> >>>>           drmm_mode_config_init+0x4a8/0xc50
> >>>>           msm_drm_init+0x274/0xac0
> >>>>           msm_drm_bind+0x20/0x2c
> >>>>           try_to_bring_up_master+0x3dc/0x470
> >>>>           __component_add+0x18c/0x3c0
> >>>>           component_add+0x1c/0x28
> >>>>           dp_display_probe+0x954/0xa98
> >>>>           platform_probe+0x124/0x15c
> >>>>           really_probe+0x1b0/0x5f8
> >>>>           __driver_probe_device+0x174/0x20c
> >>>>           driver_probe_device+0x70/0x134
> >>>>           __device_attach_driver+0x130/0x1d0
> >>>>           bus_for_each_drv+0xfc/0x14c
> >>>>           __device_attach+0x1bc/0x2bc
> >>>>           device_initial_probe+0x1c/0x28
> >>>>           bus_probe_device+0x94/0x178
> >>>>           deferred_probe_work_func+0x1a4/0x1f0
> >>>>           process_one_work+0x5d4/0x9dc
> >>>>           worker_thread+0x898/0xccc
> >>>>           kthread+0x2d4/0x3d4
> >>>>           ret_from_fork+0x10/0x20
> >>>>
> >>>>    -> #1 (crtc_ww_class_acquire){+.+.}-{0:0}:
> >>>>           ww_acquire_init+0x1c4/0x2c8
> >>>>           drm_modeset_acquire_init+0x44/0xc8
> >>>>           drm_helper_probe_single_connector_modes+0xb0/0x12dc
> >>>>           drm_mode_getconnector+0x5dc/0xfe8
> >>>>           drm_ioctl_kernel+0x1e4/0x338
> >>>>           drm_ioctl+0x3a4/0x684
> >>>>           __arm64_sys_ioctl+0x118/0x154
> >>>>           invoke_syscall+0x78/0x224
> >>>>           el0_svc_common+0x178/0x200
> >>>>           do_el0_svc+0x94/0x13c
> >>>>           el0_svc+0x5c/0xec
> >>>>           el0t_64_sync_handler+0x78/0x108
> >>>>           el0t_64_sync+0x1a4/0x1a8
> >>>>
> >>>>    -> #0 (&dev->mode_config.mutex){+.+.}-{3:3}:
> >>>>           __lock_acquire+0x2650/0x672c
> >>>>           lock_acquire+0x1b4/0x4ac
> >>>>           __mutex_lock_common+0x174/0x1a64
> >>>>           mutex_lock_nested+0x98/0xac
> >>>>           dp_panel_add_fail_safe_mode+0x4c/0xa0
> >>>>           dp_hpd_plug_handle+0x1f0/0x280
> >>>>           dp_bridge_enable+0x94/0x2b8
> >>>>           drm_atomic_bridge_chain_enable+0x11c/0x168
> >>>>           drm_atomic_helper_commit_modeset_enables+0x500/0x740
> >>>>           msm_atomic_commit_tail+0x3e4/0x748
> >>>>           commit_tail+0x19c/0x278
> >>>>           drm_atomic_helper_commit+0x1dc/0x1f0
> >>>>           drm_atomic_commit+0xc0/0xd8
> >>>>           drm_atomic_helper_set_config+0xb4/0x134
> >>>>           drm_mode_setcrtc+0x688/0x1248
> >>>>           drm_ioctl_kernel+0x1e4/0x338
> >>>>           drm_ioctl+0x3a4/0x684
> >>>>           __arm64_sys_ioctl+0x118/0x154
> >>>>           invoke_syscall+0x78/0x224
> >>>>           el0_svc_common+0x178/0x200
> >>>>           do_el0_svc+0x94/0x13c
> >>>>           el0_svc+0x5c/0xec
> >>>>           el0t_64_sync_handler+0x78/0x108
> >>>>           el0t_64_sync+0x1a4/0x1a8
> >>>>
> >>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>>> ---
> >>>>    drivers/gpu/drm/msm/dp/dp_display.c |  6 ------
> >>>>    drivers/gpu/drm/msm/dp/dp_panel.c   | 23 +++++++++++++----------
> >>>>    2 files changed, 13 insertions(+), 16 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> index 92cd50f..01453db 100644
> >>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> @@ -555,12 +555,6 @@ static int dp_hpd_plug_handle(struct
> >>>> dp_display_private *dp, u32 data)
> >>>>        mutex_unlock(&dp->event_mutex);
> >>>> -    /*
> >>>> -     * add fail safe mode outside event_mutex scope
> >>>> -     * to avoid potiential circular lock with drm thread
> >>>> -     */
> >>>> -    dp_panel_add_fail_safe_mode(dp->dp_display.connector);
> >>>> -
> >>>>        /* uevent will complete connection part */
> >>>>        return 0;
> >>>>    };
> >>>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c
> >>>> b/drivers/gpu/drm/msm/dp/dp_panel.c
> >>>> index 1aa9aa8c..23fee42 100644
> >>>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> >>>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> >>>> @@ -151,15 +151,6 @@ static int dp_panel_update_modes(struct
> >>>> drm_connector *connector,
> >>>>        return rc;
> >>>>    }
> >>>> -void dp_panel_add_fail_safe_mode(struct drm_connector *connector)
> >>>> -{
> >>>> -    /* fail safe edid */
> >>>> -    mutex_lock(&connector->dev->mode_config.mutex);
> >>>> -    if (drm_add_modes_noedid(connector, 640, 480))
> >>>> -        drm_set_preferred_mode(connector, 640, 480);
> >>>> -    mutex_unlock(&connector->dev->mode_config.mutex);
> >>>> -}
> >>>> -
> >>>>    int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
> >>>>        struct drm_connector *connector)
> >>>>    {
> >>>> @@ -216,7 +207,11 @@ int dp_panel_read_sink_caps(struct dp_panel
> >>>> *dp_panel,
> >>>>                goto end;
> >>>>            }
> >>>> -        dp_panel_add_fail_safe_mode(connector);
> >>>> +        /* fail safe edid */
> >>>> +        mutex_lock(&connector->dev->mode_config.mutex);
> >>>> +        if (drm_add_modes_noedid(connector, 640, 480))
> >>>> +            drm_set_preferred_mode(connector, 640, 480);
> >>>> +        mutex_unlock(&connector->dev->mode_config.mutex);
> >>>>        }
> >>>>        if (panel->aux_cfg_update_done) {
> >>>> @@ -266,6 +261,14 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
> >>>>            return -EINVAL;
> >>>>        }
> >>>> +    /*
> >>>> +     * add fail safe mode (640x480) here
> >>>> +     * since we are executed in drm_thread context,
> >>>> +     * no mode_config.mutex acquired required
> >>>> +     */
> >>>> +    if (drm_add_modes_noedid(connector, 640, 480))
> >>>> +        drm_set_preferred_mode(connector, 640, 480);
> >>>> +
> >>>>        if (dp_panel->edid)
> >>>>            return dp_panel_update_modes(connector, dp_panel->edid);
> >>> Also, wouldn't calling get_modes() several times make cause adding more
> >>> and more 640x480 modes to the modes list?
> >>>
> >>
> >> Shouldnt DRM be blocking that here? Call should trickle down here only
> >> if count_modes was 0
> >>
> >>      if (out_resp->count_modes == 0) {
> >>           if (is_current_master)
> >>               connector->funcs->fill_modes(connector,
> >>                                dev->mode_config.max_width,
> >>                                dev->mode_config.max_height);
> >>           else
> >>               drm_dbg_kms(dev, "User-space requested a forced probe on
> >> [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe",
> >>                       connector->base.id, connector->name);
> >>       }
> >>
> >
> > count_modes is set by userspace:
> >          /*
> >           * This ioctl is called twice, once to determine how much space is
> >           * needed, and the 2nd time to fill it.
> >           */
> >
> > So, nothing prevents userspace from passing zero count_mode more than once.
> Ack, some non-optimized usermodes can do this.
> >
> > However drm_helper_probe_single_connector_modes() will set old modes
> > to MODE_STALE and then will call get_modes().
> > Then drm_mode_prune_invalid() will prune stale modes. So, this should be fine.
> >
> Got it.
> > A more generic question is why do we need to add the mode in two places?
> >
> Answering behalf of kuogee but the two places are for different purposes:
>
> 1) When there is no EDID read
>
> if (!dp_panel->edid) {
>
> That case we should add the fail-safe mode as otherwise display will be
> blank for cases where there was nothing wrong with the monitor as such
> but the EDID read from aux failed for some reason. Even DRM does this
> but just not 640x480 here:
>
> 518     if (count == 0 && (connector->status == connector_status_connected ||
> 519                        connector->status == connector_status_unknown))
> 520             count = drm_add_modes_noedid(connector, 1024, 768);

But drm_add_modes_noedid() _will_ add the 640x480 modes, won't it? It
will add all "failsafe" modes that are less than or equal to 1024x768
and 60Hz or less. See the table "drm_dmt_modes". I don't understand
why the DRM core's call doesn't solve the problem for you in the first
place?


> 2) When there was a valid EDID but no 640x480 mode
>
> This is the equipment specific case and the one even I was a bit
> surprised. There is a DP compliance equipment we have in-house and while
> validation, it was found that in its list of modes , it did not have any
> modes which chromebook supported ( due to 2 lanes ). But my
> understanding was that, all sinks should have atleast 640x480 but
> apparently this one did not have that. So to handle this DP compliance
> equipment behavior, we had to do this.

That doesn't seem right. If there's a valid EDID and the valid EDID
doesn't contain 640x480, are you _sure_ you're supposed to be adding
640x480? That doesn't sound right to me. I've got a tiny display in
front of me for testing that only has one mode:

  #0 800x480 65.68 800 840 888 928 480 493 496 525 32000

It wouldn't be correct to add a 640x480 mode to this panel... ...and,
in fact, after applying ${SUBJECT} patch I see that DRM (incorrectly)
thinks that my display supports 640x480. I see:

  #0 800x480 65.68 800 840 888 928 480 493 496 525 32000
  #1 640x480 59.94 640 656 752 800 480 490 492 525 25175

So IMO we _shouldn't_ land ${SUBJECT} patch.

Just for testing, I also tried a hack to make EDID reading fail
(return -EIO in the MSM dp_aux_transfer() function if msg->request <
8). Before ${SUBJECT} patch I'd see these modes:

  #0 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000
  #1 800x600 60.32 800 840 968 1056 600 601 605 628 40000
  #2 800x600 56.25 800 824 896 1024 600 601 603 625 36000
  #3 848x480 60.00 848 864 976 1088 480 486 494 517 33750
  #4 640x480 59.94 640 656 752 800 480 490 492 525 25175

...and after ${SUBJECT} patch I'd see:

  #0 640x480 59.94 640 656 752 800 480 490 492 525 25175
  #1 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000
  #2 800x600 60.32 800 840 968 1056 600 601 605 628 40000
  #3 800x600 56.25 800 824 896 1024 600 601 603 625 36000
  #4 848x480 60.00 848 864 976 1088 480 486 494 517 33750

...so your patch causes 640x480 to be prioritized. That also doesn't
seem ideal. If it was ideal, the DRM core should have listed 640x480
first.

I'll repeat my refrain that I'm not a DRM expert, but if I were doing
things, I'd rather revert commit 8b2c181e3dcf ("drm/msm/dp: add fail
safe mode outside of event_mutex context") and commit d4aca422539c
("drm/msm/dp: always add fail-safe mode into connector mode list") and
then go back and look more carefully about what the problem was in the
first place. Why didn't the failsafe modes added by the DRM core solve
the problem for you in the first place?

-Doug
