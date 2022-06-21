Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8200F55373B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353308AbiFUQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352817AbiFUQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:05:28 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B52D211
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:05:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o4so2871331ilm.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVa9EIh+i5Q6XRan1FynNxbsWTmgds0/W/AATBRzizk=;
        b=hsfOBPueNuYUDJ4ySSjM5CFNwSHVz1OsdRwtih7AsUeN9l0hqX9tPC8OKcaaW+LFgz
         A80pod35uNbA0Zzg1htq2cfLvyFPl2Ku5Y/UfWuoAPgwaz5FO6m4F9UuSpmz43XASrmK
         GEAng3UvqAmTqgzGWPsKKcbpLlYI185+xCFNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVa9EIh+i5Q6XRan1FynNxbsWTmgds0/W/AATBRzizk=;
        b=FMrYiu5B4jToNCRZ60n0+7T5nmLTPp00sTeCGI/WFz4KUIrbMw/Lz9PVcIEirZc/PV
         fv15HZQ5JLJePPizg761uhtYY8L3wcvZCH3IQbPAxnj4Zn9io9AVsmDgFyJkSGMkzs9Q
         iSl29nPeQA29vPqg3l8Wd7jin56T9nivg2IpVODbgFtS0gbhZ4HMXsOAONqs0rsxJ2D1
         obSpA+EnjBbawuNTnjTakIQuMRyRFoAnyZXIC4dA0yu0T4+oxuFaaN4Ebx1/G4hVkCrT
         BxFbrWD3FfAaQHSn1i9AbJbyHhZXJ6u1UzoHmyFFTJF7/Zghx6s1b7HjUjB7LrBbXIgN
         dpxA==
X-Gm-Message-State: AJIora+RGmFruQoNHJdrdQofvWJ++aCclwzfL3Fd7L9pKcqSMaM/JO8V
        RLeZxwABdbCT9rsZdlQgp8rF/TWBO7jBSQ==
X-Google-Smtp-Source: AGRyM1vlQ/r82wuWrVa4gIQZX/T6rE+IXvSr7Nns7bUnS6twM5xo9l94GdV5zYqZzGVYDLxK7Qo1DQ==
X-Received: by 2002:a05:6e02:1c42:b0:2d1:aaac:ecc2 with SMTP id d2-20020a056e021c4200b002d1aaacecc2mr16125367ilg.128.1655827525808;
        Tue, 21 Jun 2022 09:05:25 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id y12-20020a92d80c000000b002d9243911d5sm1538847ilm.78.2022.06.21.09.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 09:05:25 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id r5so14729789iod.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:05:25 -0700 (PDT)
X-Received: by 2002:a05:6e02:1e0b:b0:2d1:b5e8:38a0 with SMTP id
 g11-20020a056e021e0b00b002d1b5e838a0mr17149386ila.296.1655827099263; Tue, 21
 Jun 2022 08:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220609072722.3488207-1-hsinyi@chromium.org> <CAJMQK-hg5kLUV=ZgVN5=qX=bRiBWx3O-4X9wPF6CwxpQVSuinA@mail.gmail.com>
 <CAD=FV=XMjSu9pJHj+2L7vrVocDkn4+VcPQ07tNKZMfj4qUYgYA@mail.gmail.com>
In-Reply-To: <CAD=FV=XMjSu9pJHj+2L7vrVocDkn4+VcPQ07tNKZMfj4qUYgYA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jun 2022 08:58:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UYnOq_qDqTTw7HYjPk4XDZaSpgDPJ_T_6BGV9OftuE_w@mail.gmail.com>
Message-ID: <CAD=FV=UYnOq_qDqTTw7HYjPk4XDZaSpgDPJ_T_6BGV9OftuE_w@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add a panel API to set orientation properly
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 15, 2022 at 6:36 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jun 14, 2022 at 10:50 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > On Thu, Jun 9, 2022 at 3:27 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > Panels usually call drm_connector_set_panel_orientation(), which is
> > > later than drm/kms driver calling drm_dev_register(). This leads to a
> > > WARN()[1].
> > >
> > > The orientation property is known earlier. For example, some panels
> > > parse the property through device tree during probe.
> > >
> > > The series add a panel API drm_connector_set_orientation_from_panel()
> > > for drm/kms drivers. The drivers can call the API to set panel's
> > > orientation before drm_dev_register().
> > >
> > > Panel needs to implement .get_orientation callback to return the property.
> > >
> > > [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/
> > >
> > > Hsin-Yi Wang (8):
> > >   drm/panel: Add an API to allow drm to set orientation from panel
> > >   drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
> > >   drm/panel: panel-edp: Implement .get_orientation callback
> > >   drm/panel: lvds: Implement .get_orientation callback
> > >   drm/panel: panel-simple: Implement .get_orientation callback
> > >   drm/panel: ili9881c: Implement .get_orientation callback
> > >   drm/panel: elida-kd35t133: Implement .get_orientation callback
> > >   drm: Config orientation property if panel provides it
> > >
> > hi Maintainers,
> >
> > All the patches are reviewed. If there's no other comments, will this
> > series be picked? Thanks.
>
> Unless someone beat me to it or yells, my plan was to land them to
> drm-misc-next next week. Since it touches core code I wanted to give a
> little extra time. Also at the moment patch #8 is all Chromium (all
> author and reviewers are chromium.org) at the moment so that's another
> reason to make sure it has sufficient time on the lists.

As promised, I've pushed to drm-misc-next. Note: I had to fix
whitespace problems in almost every patch. Please run checkpatch on
your patches.

15b9ca1641f0 drm: Config orientation property if panel provides it
a64af136771a drm/panel: elida-kd35t133: Implement .get_orientation callback
db9b4ffbfa82 drm/panel: ili9881c: Implement .get_orientation callback
a960e35ac011 drm/panel: panel-simple: Implement .get_orientation callback
c0398df2a195 drm/panel: lvds: Implement .get_orientation callback
47bef230225b drm/panel: panel-edp: Implement .get_orientation callback
3fa214eea43a drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
5e41b01a7808 drm/panel: Add an API to allow drm to set orientation from panel

-Doug
