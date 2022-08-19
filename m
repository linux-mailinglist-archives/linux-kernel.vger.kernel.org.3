Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D959A33E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351014AbiHSRSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350924AbiHSRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7C14AECA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660927055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgAv2gfeT+DjVQ0ygCcgGDt5H9pi8jbfYe8g0Dy8ho8=;
        b=EvfPyjCh32aeGJ0+biX6S/1GOih0WopaJ1RDxAXcU6j7oMLa95t3mNl20vS1589Tc0yNWT
        meh76dmbVvST9XeswbNEWluZnQZJEymSLsE7fGwqVx0L7q+480zq6tamUhADMMl/yUAJNH
        pPct+06n0XYOERs/SE3y4GPxp4Xs04s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-PmQJxsWNOui7V2n33l8gOw-1; Fri, 19 Aug 2022 12:37:34 -0400
X-MC-Unique: PmQJxsWNOui7V2n33l8gOw-1
Received: by mail-qt1-f197.google.com with SMTP id h19-20020ac85493000000b00343408bd8e5so3773934qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PgAv2gfeT+DjVQ0ygCcgGDt5H9pi8jbfYe8g0Dy8ho8=;
        b=FR0eQa5Gu0QL4gm6yCxK83nhkV6EFfhaMLZRPHTvkWzyQB5rK4acovrzRMoptJdxy9
         Pf0YYx6AaCB4zScj7AJyWZG1x003s8wdrNEKxjxGH93mgsHevP/2vhPJNqhsRiq4Pny5
         8yh1u3rWyB7yEkaYdpR3Ek1apmm4EqodGOmFgkiosqcTLayWL3GBVwVnlYavyrs2U5K8
         SfPwV/boIGlgA7mXjkEZRHdjjDLSZYLPq2+b7ozKucqEFX7VKvmjhpMppDos7szsKFPC
         KNdzB63eILc62m6orT/Qs9xwMOzurTb6D0nOl+1JnbRdukBtEUn5J/2A3xKDO+bAJPvG
         os0A==
X-Gm-Message-State: ACgBeo1Uw7Lsi7lUqktrugoISfxpBhOYr4EWKRN+P1ZnmSQVnKCyVSuE
        FoBHtC+9wv5mziwBPPLoSwHkaqoPRpV+n07WATho2S1AXfVfcCdL7NQQ9qyXUqA0I0ZLqIbX3Kr
        HCfBScGbr3d1yXUMFb6VbE2s2ADzfauA5c+hU/2Mn
X-Received: by 2002:a05:622a:230e:b0:343:616b:1f88 with SMTP id ck14-20020a05622a230e00b00343616b1f88mr7033620qtb.457.1660927052389;
        Fri, 19 Aug 2022 09:37:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5jDRfWr7ZoGy5GcBr/OoJivAhIrJNf3OBVmCNTmdUUm5Fun3lhCXMpYjgaWh0B1rAidKm/bZIJ68WjdJqiEUE=
X-Received: by 2002:a05:622a:230e:b0:343:616b:1f88 with SMTP id
 ck14-20020a05622a230e00b00343616b1f88mr7033351qtb.457.1660927047299; Fri, 19
 Aug 2022 09:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220819142519.5684-1-mario.limonciello@amd.com>
 <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com> <57cf9b61-82f4-f6d4-7f43-c3f94de7aaf3@amd.com>
In-Reply-To: <57cf9b61-82f4-f6d4-7f43-c3f94de7aaf3@amd.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Aug 2022 18:37:15 +0200
Message-ID: <CACO55tuRZOyoo79sgnewETF50Unzm_uksGtaB24Y93pej+2vgA@mail.gmail.com>
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

On Fri, Aug 19, 2022 at 6:00 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 8/19/2022 10:44, Karol Herbst wrote:
> > On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> 3 _OSI strings were introduced in recent years that were intended
> >> to workaround very specific problems found on specific systems.
> >>
> >> The idea was supposed to be that these quirks were only used on
> >> those systems, but this proved to be a bad assumption.  I've found
> >> at least one system in the wild where the vendor using the _OSI
> >> string doesn't match the _OSI string and the neither does the use.
> >>
> >> So this brings a good time to review keeping those strings in the kernel.
> >> There are 3 strings that were introduced:
> >>
> >> Linux-Dell-Video
> >> -> Intended for systems with NVIDIA cards that didn't support RTD3
> >> Linux-Lenovo-NV-HDMI-Audio
> >> -> Intended for powering on NVIDIA HDMI device
> >> Linux-HPI-Hybrid-Graphics
> >> -> Intended for changing dGPU output
> >>
> >> AFAIK the first string is no longer relevant as nouveau now supports
> >> RTD3.  If that's wrong, this can be changed for the series.
> >>
> >
> > Nouveau always supported RTD3, because that's mainly a kernel feature.
> > When those were introduced we simply had a bug only hit on a few
> > systems. And instead of helping us to debug this, this workaround was
> > added :( We were not even asked about this.
>
> My apologies, I was certainly part of the impetus for this W/A in the
> first place while I was at my previous employer.  Your comment
> re-affirms to me that at least the first patch is correct.
>

Yeah, no worries. I just hope that people in the future will
communicate such things.

Anyway, there are a few issues with the runpm stuff left, and looking
at what nvidia does in their open driver makes me wonder if we might
need a bigger overhaul of runpm. They do apply bridge/host controller
specific workarounds and I suspect some of them are related here as
the workaround I came up with in nouveau can be seen in 434fdb51513bf.

But also having access to documentation/specification from what Nvidia
is doing would be quite helpful. We know that on some really new AMD
systems we run into new issues and this needs some investigation. I
simply don't access to any laptops where this problem can be seen.

> >
> > I am a bit curious about the other two though as I am not even sure
> > they are needed at all as we put other work arounds in place. @Lyude
> > Paul might know more about these.
> >
>
> If the other two really aren't needed anymore, then yeah we should just
> tear all 3 out.  If that's the direction we go, I would appreciate some
> commit IDs to reference in the commit message for tearing them out so
> that if they end up backporting to stable we know how far they should go.
>

