Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EBA59A339
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351869AbiHSRoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352333AbiHSRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151C36F54D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660928641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrwhfTQqr6P4JRBEzwUmYbwPttj1236XlsUYmPjdNQ8=;
        b=X6IC3JuDRqRQ+Oq5dVQ/GFntT275TtJopc1sakNIF7XtIdpUbwJ3/Q6URvNeltblO9rdB8
        Fq2jpa5VVIbYEn58ud9RtOBjSLkVgeAnlPIRR+M408Y0sz7q/XMm+Zrcx32h1c+HlLTXG/
        UQ372IXdwIH2GIQb0/cPVBOtvnvRFGw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-kIcTb5BiNkGFDlg5JMxZmA-1; Fri, 19 Aug 2022 12:47:23 -0400
X-MC-Unique: kIcTb5BiNkGFDlg5JMxZmA-1
Received: by mail-qk1-f200.google.com with SMTP id j19-20020a05620a289300b006b949aff6ddso4176046qkp.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VrwhfTQqr6P4JRBEzwUmYbwPttj1236XlsUYmPjdNQ8=;
        b=RGx72Ob3Hrc2lsKI6AykYwA1vYmDt5ubpHGnzaGmuEkSAc24i3ur4IKoX50D/c/6fb
         rhA6643gwPxyA+C2Skk8zDrS6nJ0yj4/kXF6kT/xQCyvYO8gcfNeuhdeuypHdFMEF1wq
         tRfEQgML2LuhIB4r9jjqo/FhH8o1POJw2CQooNMcKp+RRlP+E1xNJvpf9FslGr2Hj/WF
         texp3PZpfrNQoo1bwZ7mKl/Kn4/PBp0ksIjXSBtysVUyBhwu1uytFHyaftEA6tFl2hHo
         ZctVYuROGX2lEclAbcNCW/XgrLapbpDbBE53NKR6vsN4qRlqIWSITyh7ms7p2x9EExew
         tt5g==
X-Gm-Message-State: ACgBeo1hm7OyB6MzEfqyuAhD8WgJzJi8ZH827hH3abTSHm65OziQnPYf
        xfGWVg5k4u7NssLE6amvs7OcV3yLmoh2nLPJCymtOmqfI3NbNs/ETEH/Zs0CUFbuXz2N/L1N6fH
        0cL6eKlNfEzpl2zlmxA868kHK+LrM+MwhfxMwcsYk
X-Received: by 2002:a05:622a:230e:b0:343:616b:1f88 with SMTP id ck14-20020a05622a230e00b00343616b1f88mr7063169qtb.457.1660927643001;
        Fri, 19 Aug 2022 09:47:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7qut1LrrQWGjcPDsYvVH+1BCUDPF0pO9Zy0QOF4jCXEP/wH5wJ1NEUdNovM81WFHd4qek7A2XGFUg8OaLf1gc=
X-Received: by 2002:a05:622a:230e:b0:343:616b:1f88 with SMTP id
 ck14-20020a05622a230e00b00343616b1f88mr7063158qtb.457.1660927642800; Fri, 19
 Aug 2022 09:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220819142519.5684-1-mario.limonciello@amd.com>
 <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
 <57cf9b61-82f4-f6d4-7f43-c3f94de7aaf3@amd.com> <CACO55tuRZOyoo79sgnewETF50Unzm_uksGtaB24Y93pej+2vgA@mail.gmail.com>
 <40d13998-f6e2-27a3-c83a-cd977e45f02a@amd.com>
In-Reply-To: <40d13998-f6e2-27a3-c83a-cd977e45f02a@amd.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Aug 2022 18:47:11 +0200
Message-ID: <CACO55ts3SjBjdF-fDNsg3NwCFZAsZSiTpPAF3PX2bM6wGxZ8eg@mail.gmail.com>
Subject: Re: [RFC 0/2] Stop the abuse of Linux-* _OSI strings
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        Len Brown <lenb@kernel.org>, nouveau@lists.freedesktop.org,
        hdegoede@redhat.com, ddadap@nvidia.com,
        kai.heng.feng@canonical.com, Dell.Client.Kernel@dell.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 6:43 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 8/19/2022 11:37, Karol Herbst wrote:
> > On Fri, Aug 19, 2022 at 6:00 PM Limonciello, Mario
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 8/19/2022 10:44, Karol Herbst wrote:
> >>> On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> 3 _OSI strings were introduced in recent years that were intended
> >>>> to workaround very specific problems found on specific systems.
> >>>>
> >>>> The idea was supposed to be that these quirks were only used on
> >>>> those systems, but this proved to be a bad assumption.  I've found
> >>>> at least one system in the wild where the vendor using the _OSI
> >>>> string doesn't match the _OSI string and the neither does the use.
> >>>>
> >>>> So this brings a good time to review keeping those strings in the kernel.
> >>>> There are 3 strings that were introduced:
> >>>>
> >>>> Linux-Dell-Video
> >>>> -> Intended for systems with NVIDIA cards that didn't support RTD3
> >>>> Linux-Lenovo-NV-HDMI-Audio
> >>>> -> Intended for powering on NVIDIA HDMI device
> >>>> Linux-HPI-Hybrid-Graphics
> >>>> -> Intended for changing dGPU output
> >>>>
> >>>> AFAIK the first string is no longer relevant as nouveau now supports
> >>>> RTD3.  If that's wrong, this can be changed for the series.
> >>>>
> >>>
> >>> Nouveau always supported RTD3, because that's mainly a kernel feature.
> >>> When those were introduced we simply had a bug only hit on a few
> >>> systems. And instead of helping us to debug this, this workaround was
> >>> added :( We were not even asked about this.
> >>
> >> My apologies, I was certainly part of the impetus for this W/A in the
> >> first place while I was at my previous employer.  Your comment
> >> re-affirms to me that at least the first patch is correct.
> >>
> >
> > Yeah, no worries. I just hope that people in the future will
> > communicate such things.
> >
> > Anyway, there are a few issues with the runpm stuff left, and looking
> > at what nvidia does in their open driver makes me wonder if we might
> > need a bigger overhaul of runpm. They do apply bridge/host controller
> > specific workarounds and I suspect some of them are related here as
> > the workaround I came up with in nouveau can be seen in 434fdb51513bf.
>
> But this overhaul shouldn't gate removing this _OSI string, or you think
> it should?
>

Hard to tell. If there are affected systems but have those _OSI
strings in place so it's hidden, this would be annoying, but then we
might have more pointers on what's actually broken. Anyway, we don't
need those workarounds and rather a real fix for all those issues. And
I suspect the real fix is to apply specific workarounds for specific
systems.

> >
> > But also having access to documentation/specification from what Nvidia
> > is doing would be quite helpful. We know that on some really new AMD
> > systems we run into new issues and this needs some investigation. I
> > simply don't access to any laptops where this problem can be seen.
> >
>
> Do you mean there are specifically remaining issues on AMD APU + NVIDIA
> dGPU systems?  Any public bugs by chance?
>
> Depending on what these are I'm happy to try to help with at least
> access.  If we have them maybe we can try to make the right connections
> to get some hardware to you, or at least remotely access it.
>

https://gitlab.freedesktop.org/drm/nouveau/-/issues/108

there might be more though, but this should be a good start.

> >>>
> >>> I am a bit curious about the other two though as I am not even sure
> >>> they are needed at all as we put other work arounds in place. @Lyude
> >>> Paul might know more about these.
> >>>
> >>
> >> If the other two really aren't needed anymore, then yeah we should just
> >> tear all 3 out.  If that's the direction we go, I would appreciate some
> >> commit IDs to reference in the commit message for tearing them out so
> >> that if they end up backporting to stable we know how far they should go.
> >>
> >
>

