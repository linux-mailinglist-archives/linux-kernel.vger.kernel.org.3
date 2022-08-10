Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86C58F419
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiHJWEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiHJWEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:04:10 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6492E8277A;
        Wed, 10 Aug 2022 15:04:07 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o14so9056183ilt.2;
        Wed, 10 Aug 2022 15:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=LVHmCu4K9UsnuouvlrhXtn/06oq9/7k5ucyM1f7Rw3o=;
        b=XQQgJm1UBQXQ7vbWpW5FvKeg56vw8j997xb19oPECATfNsXaTQTfoXR8o50ZVfLHlB
         11XQbz7fph6I+75f2RDOdo6KvZwMSsk8mdbmvFAQ24tnCPWIlIocfTz2f8X+/Nr1kQvT
         C94w5BgMq2xltRQN+5uJLNXJyEUsJQ81SigRxq9euRt+kdSVZNsikS8G0JB6xPDBz0nu
         d6GowoELgNsmySJUpL6m0li5rxrQmtqZ0txluj/GRNrF/ypBF3rWJzO0e04xwQoHa3kv
         /rGj1dpU5X0LAJCvW9dGdRrHAgXA6lsED8XCrB1/uGNCrxto2sGFkgg3jJoqFu/k6eTb
         2Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=LVHmCu4K9UsnuouvlrhXtn/06oq9/7k5ucyM1f7Rw3o=;
        b=bwZ/jyQdHC1Pq92qhCDtQJ3Vm34trLpg9khKqVFiJ5qPhE4l4GTVsV1KhGZCZFV8IY
         BjFBQVmfyBxb6fN1DNSnHSaFEPBuS/MyQqNAl+kn/UF27KE02SNiXm/QsGcKD1d/gKI9
         uxKlXR4sRpoU9f1ofziOQUvte2t2aiahkedfig1MzfmOz5wXaHPUCa+Ti65xp/QgpGMQ
         xGq6kdXolhV8y3iYQjT9Oli2j3KG54CUwlbiQax0W39nYufn5kZ0tlnGFrG9hwJCzQnL
         z95D2L4I5JfdKYh7e9QNqWtDTCW1MwNCWukYrXF8gDulngGCmT63b7CUjeeS8BnjD+Nk
         o9bg==
X-Gm-Message-State: ACgBeo1QAIy7Af+k0nFy3++rJMNAr1phX4brfnYEfVjWslyY9iyH0KAa
        93xKmNDu36/YUop5wPC10Jx1OxCxxKx6cSEeL0SAGQ+j
X-Google-Smtp-Source: AA6agR5IBVRyhpKnR2zLMwE90gqNpEfsaXgxYOLxLujMWj6Uon5RNfqf7xcFnsKA6FfgJ4Di+5Cyp7A/pP3pJkReSK4=
X-Received: by 2002:a92:8747:0:b0:2da:cf0d:b615 with SMTP id
 d7-20020a928747000000b002dacf0db615mr13120670ilm.168.1660169047109; Wed, 10
 Aug 2022 15:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com> <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com> <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com> <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
In-Reply-To: <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 10 Aug 2022 15:03:55 -0700
Message-ID: <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 12:26 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 8/10/22 18:08, Rob Clark wrote:
> > On Wed, Aug 10, 2022 at 4:47 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>
> >> On Wed, Jul 06, 2022 at 10:02:07AM +0300, Dmitry Osipenko wrote:
> >>> On 7/6/22 00:48, Rob Clark wrote:
> >>>> On Tue, Jul 5, 2022 at 4:51 AM Christian K=C3=B6nig <christian.koeni=
g@amd.com> wrote:
> >>>>>
> >>>>> Am 01.07.22 um 11:02 schrieb Dmitry Osipenko:
> >>>>>> Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don=
't
> >>>>>> handle imported dma-bufs properly, which results in mapping of som=
ething
> >>>>>> else than the imported dma-buf. On NVIDIA Tegra we get a hard lock=
up when
> >>>>>> userspace writes to the memory mapping of a dma-buf that was impor=
ted into
> >>>>>> Tegra's DRM GEM.
> >>>>>>
> >>>>>> Majority of DRM drivers prohibit mapping of the imported GEM objec=
ts.
> >>>>>> Mapping of imported GEMs require special care from userspace since=
 it
> >>>>>> should sync dma-buf because mapping coherency of the exporter devi=
ce may
> >>>>>> not match the DRM device. Let's prohibit the mapping for all DRM d=
rivers
> >>>>>> for consistency.
> >>>>>>
> >>>>>> Suggested-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.=
com>
> >>>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>>
> >>>>> I'm pretty sure that this is the right approach, but it's certainly=
 more
> >>>>> than possible that somebody abused this already.
> >>>>
> >>>> I suspect that this is abused if you run deqp cts on android.. ie. a=
ll
> >>>> winsys buffers are dma-buf imports from gralloc.  And then when you
> >>>> hit readpix...
> >>>>
> >>>> You might only hit this in scenarios with separate gpu and display (=
or
> >>>> dGPU+iGPU) because self-imports are handled differently in
> >>>> drm_gem_prime_import_dev().. and maybe not in cases where you end up
> >>>> with a blit from tiled/compressed to linear.. maybe that narrows the
> >>>> scope enough to just fix it in userspace?
> >>>
> >>> Given that that only drivers which use DRM-SHMEM potentially could've
> >>> map imported dma-bufs (Panfrost, Lima) and they already don't allow t=
o
> >>> do that, I think we're good.
> >>
> >> So can I have an ack from Rob here or are there still questions that t=
his
> >> might go boom?
> >>
> >> Dmitry, since you have a bunch of patches merged now I think would als=
o be
> >> good to get commit rights so you can drive this more yourself. I've as=
ked
> >> Daniel Stone to help you out with getting that.
> >
> > I *think* we'd be ok with this on msm, mostly just by dumb luck.
> > Because the dma-buf's we import will be self-import.  I'm less sure
> > about panfrost (src/panfrost/lib/pan_bo.c doesn't seem to have a
> > special path for imported dma-bufs either, and in that case they won't
> > be self-imports.. but I guess no one has tried to run android cts on
> > panfrost).
>
> The last time I tried to mmap dma-buf imported to Panfrost didn't work
> because Panfrost didn't implement something needed for that. I'll need
> to take a look again because can't recall what it was.
>
> > What about something less drastic to start, like (apologies for
> > hand-edited patch):
> >
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 86d670c71286..fc9ec42fa0ab 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1034,6 +1034,10 @@ int drm_gem_mmap_obj(struct drm_gem_object
> > *obj, unsigned long obj_size,
> >  {
> >         int ret;
> >
> > +       WARN_ON_ONCE(obj->import_attach);
>
> This will hang NVIDIA Tegra, which is what this patch fixed initially.
> If neither of upstream DRM drivers need to map imported dma-bufs and
> never needed, then why do we need this?

oh, tegra isn't using shmem helpers?  I assumed it was.  Well my point
was to make a more targeted fail on tegra, and a WARN_ON for everyone
else to make it clear that what they are doing is undefined behavior.
Because so far existing userspace (or well, panfrost and freedreno at
least, those are the two I know or checked) don't make special cases
for mmap'ing against the dmabuf fd against the dmabuf fd instead of
the drm device fd.

I *think* it should work out that we don't hit this path with
freedreno but on android I can't really guarantee or prove it.  So
your patch would potentially break existing working userspace.  Maybe
it is userspace that isn't portable (but OTOH it isn't like you are
going to be using freedreno on tegra).  So why don't you go for a more
targeted fix that only returns an error on hw where this is
problematic?

BR,
-R
