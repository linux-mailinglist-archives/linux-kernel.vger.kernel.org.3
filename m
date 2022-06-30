Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA38561254
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiF3GOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiF3GOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:14:49 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BD817AB4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:14:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s14so21760755ljs.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=jbstzoBmPE/qzRPXYkpjGy3Fre/2Wq0cgzIWxt2EKNo=;
        b=dE0GPDPN7+EkPuTOwPyhVADLMDB1hwzTYV0wuVdAciotIjmHwpHFUiuiyU6iR4BBJK
         TWk6z0ZGyMkTVmqqcw/T8vS0uyeXBk3nS5ecL1R6EU2esl3pS2+q659ZQUgLqBo8gHfF
         9wg1/DbkNQotJYgQqIgxutn4RlP4WMo51sqmgGuCTDb33pE1LAexQ8mKC5ZSQvc9b83L
         yfcB0C0SN1j/tFddJN/FmMJDYrahN7e6rfRymwMpVwtnupQyGeEUvNqJ8/wq74joajmc
         vLp1WFy/in0t25ksRE3AVTqsIPcaDkTe1gyO7DZ45cbfESodowWLApu+MosvtlPAL0Xe
         ZA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=jbstzoBmPE/qzRPXYkpjGy3Fre/2Wq0cgzIWxt2EKNo=;
        b=PaimAop/ogBfTyL65TdmiN0RevPp/hEi7+Wg75dQbU/t6Us3TeHnJVfcxEob0ckNe9
         TRcamg5BaULG0FbkoYKa0Ei8yZUrS/97D4aGM35Vgl0iKElQA/1QXZ041HRH4myQl6GN
         dPx2biHC5itS7owHH0VToBSY/thE9Z3XwLpEbAFKvfdQGe/Gdcqy3UUbm+u03H+eAdr8
         0YCp0tx6k6jE3Z233dyl6QqyRKk/SwCclFRTo0tdrFVaeaGDpDdTEDeUYAt5vSCOOTsP
         h2FnIB96w6aWecc9ssG/sY8rnQFlb1S9XO/+TQjX4v5GCpjw2HXvofT5vbEBcpDIvyJQ
         ORqg==
X-Gm-Message-State: AJIora8iWYJ6lEFmMBiaZO2oHUSJXyB05WjOszTFN0DiHKd9640w9wzE
        synHbhqa7g8KLbZU1vDL5fcXlQ==
X-Google-Smtp-Source: AGRyM1uoKGxeIs1iPZivYLYdzao86KEYPW5LCYHjgLkBLtqQ45hCjY9py/ak/pnADXnQp+wzawYpAA==
X-Received: by 2002:a2e:91c4:0:b0:25a:7256:a7aa with SMTP id u4-20020a2e91c4000000b0025a7256a7aamr3898468ljg.344.1656569686144;
        Wed, 29 Jun 2022 23:14:46 -0700 (PDT)
Received: from [127.0.0.1] ([94.25.229.210])
        by smtp.gmail.com with ESMTPSA id x19-20020a056512079300b0047f785a3bd5sm2918295lfr.298.2022.06.29.23.14.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2022 23:14:45 -0700 (PDT)
Date:   Thu, 30 Jun 2022 09:14:42 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Doug Anderson <dianders@chromium.org>
CC:     Sean Paul <sean@poorly.run>, Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_drm/msm/dp=3A_make_eDP_pa?= =?US-ASCII?Q?nel_as_the_first_connected_connector?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAF6AEGvFYK3x_CmErkKsmYNEv9y8AksE9UB_sfp-Z7RieX=tVg@mail.gmail.com>
References: <1656429606-2765-1-git-send-email-quic_khsieh@quicinc.com> <F35C87BF-46A5-41D3-B8A5-B2AB4A24252D@linaro.org> <CAD=FV=X3cv=Q30pODyi__OyRY+LbFT14RfEELvm_DAeHafF70g@mail.gmail.com> <CAF6AEGvFYK3x_CmErkKsmYNEv9y8AksE9UB_sfp-Z7RieX=tVg@mail.gmail.com>
Message-ID: <E87F561E-22B4-46B6-AD9B-4995E92A8E29@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30 June 2022 04:57:35 GMT+03:00, Rob Clark <robdclark@gmail=2Ecom> wrot=
e:
>On Wed, Jun 29, 2022 at 5:36 PM Doug Anderson <dianders@chromium=2Eorg> w=
rote:
>>
>> Hi,
>>
>> On Tue, Jun 28, 2022 at 1:14 PM Dmitry Baryshkov
>> <dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>> >
>> > On 28 June 2022 18:20:06 GMT+03:00, Kuogee Hsieh <quic_khsieh@quicinc=
=2Ecom> wrote:
>> > >Some userspace presumes that the first connected connector is the ma=
in
>> > >display, where it's supposed to display e=2Eg=2E the login screen=2E=
 For
>> > >laptops, this should be the main panel=2E
>> > >
>> > >This patch call drm_helper_move_panel_connectors_to_head() after
>> > >drm_bridge_connector_init() to make sure eDP stay at head of
>> > >connected connector list=2E This fixes unexpected corruption happen
>> > >at eDP panel if eDP is not placed at head of connected connector
>> > >list=2E
>> >
>> > The change itself is a good fix anyway=2E (And I'd ack it=2E) However=
 I would like to understand why does it fix the corruption issue=2E What is=
 we have eDP and DSI, with DSI ending up before the eDP? Would we see the i=
ssue?
>> > Also could you please describe the mind of corruption you are observi=
ng?
>>
>> I've spent a whole bunch of time poking at this and in the end my
>> conclusion is this:
>>
>> 1=2E The glitchyness seems to be a result of the Chrome OS userspace
>> somehow telling the kernel to do something wrong=2E
>>
>> 2=2E I believe (though I have no proof other than Kuogee's patch fixing
>> things) that the Chrome OS userspace is simply confused by the eDP
>> connector being second=2E This would imply that Kuogee's patch is
>> actually the right one=2E
>>
>> 3=2E It would be ideal if the Chrome OS userspace were fixed to handle
>> this, but it's an area of code that I've never looked at=2E It also
>> seems terribly low priority to fix since apparently other OSes have
>> similar problems (seems like this code was originally added by
>> RedHat?)
>>
>>
>> Specifically, I tested with a similar but "persistent" glitch that I
>> reproduced=2E The glitch Kuogee was digging into was a transitory glitc=
h
>> on the eDP (internal) display when you plugged in a DP (external)
>> display=2E It would show up for a frame or two and then be fixed=2E I c=
an
>> get a similar-looking glitch (vertical black and white bars) that
>> persists by doing these steps on a Chrome OS device (and Chrome OS
>> kernel):
>>
>> a) Observe screen looks good=2E
>> b) Observe DP not connected=2E
>> c) Plug in DP
>> d) See transitory glitch on screen, then it all looks fine=2E
>> e) set_power_policy --ac_screen_dim_delay=3D5 --ac_screen_off_delay=3D1=
0
>> f) Wait for screen to turn off
>> g) Unplug DP
>> h) Hit key on keyboard to wake device=2E
>> i) See glitchy=2E
>> j) Within 5 seconds: set_power_policy --ac_screen_dim_delay=3D5000
>> --ac_screen_off_delay=3D10000
>>
>> Once I'm in the persistent glitch:
>>
>> * The "screenshot" command in Chrome OS shows corruption=2E Not exactly
>> black and white bars, but the image produced has distinct bands of
>> garbage=2E
>>
>> * I can actually toggle between VT2 and the main screen (VT1)=2E Note
>> that VT1/VT2 are not quite the normal Linux managed solution--I
>> believe they're handled by frecon=2E In any case, when I switch to VT2
>> it looks normal (I can see the login prompt)=2E Then back to VT1 and th=
e
>> vertical bars glitch=2E Back to VT2 and it's normal=2E Back to VT1 and =
the
>> glitch again=2E This implies (especially with the extra evidence of
>> screenshot) that the display controller hardware is all fine and that
>> it's the underlying data that's somehow messed up=2E
>
>fwiw, from looking at this a bit w/ Doug, I think the "glitch" is
>simply just an un-renderered buffer being interpreted by the display
>controller as UBWC (because userspace tells it to)

Thanks for the description=2E I think the userspace code should be fixed t=
oo, but this patch can go in on its own=2E

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>


>
>BR,
>-R
>
>> When I pick Kuogee's patch then this "persistent" glitch goes away
>> just like the transitory one does=2E
>>
>> I'm going to go ahead and do:
>>
>> Reviewed-by: Douglas Anderson <dianders@chromium=2Eorg>
>> Tested-by: Douglas Anderson <dianders@chromium=2Eorg>

--=20
With best wishes
Dmitry
