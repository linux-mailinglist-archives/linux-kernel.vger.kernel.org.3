Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9998659A19F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348395AbiHSPqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350257AbiHSPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776E102F2C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660923902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5fwWxYPKfIyLb1AtYH/Z3aEi33LuJRO9uvJrZeR5HOo=;
        b=XFMouuas7xa589P/4TLr8rF6rEduy0o9TiAUuhSBr1PtxA7HSalgZMKdHGJQOKcdLmVHTH
        F/9GmAA2EeQfHEkvYp9hQeNiYl3+TOF8C2OckGAETiSpfXX53kU9TVl1HxEe4dYUltPF8A
        3xpXG8yow8L7US9VtnKZDfZjmAAGOj0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-S62A88LmOtyYCoOovI4-Xw-1; Fri, 19 Aug 2022 11:44:59 -0400
X-MC-Unique: S62A88LmOtyYCoOovI4-Xw-1
Received: by mail-qt1-f200.google.com with SMTP id fy12-20020a05622a5a0c00b00344569022f7so3677389qtb.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5fwWxYPKfIyLb1AtYH/Z3aEi33LuJRO9uvJrZeR5HOo=;
        b=DKwHiaw1XerE4xPJkTC+IcTBNYjxI4H+jwQ20QWw0N6tGwz9/jDgfibpL9K0mGhxwL
         DmrSp/fjYhPWr49KLgvbUl5pqMHSVmAPoK5LqUgB8jWr5Wa2hemWWpK5CVpNyY+66mqQ
         Vr5X6VxUv1wy129wZ3Dkz5IhvTFrjl6MQOhrzFee/rtK+8NX5WU6ENANAyITtyI04YhE
         hjtZbhY6JgumVN7P5EFggMWGhZoMe+RVKPRWY7/iW09ga4lcNK82OCXJiWLU2fEzOxH+
         XtEHQiRU50Dk499sIq/7YN/FSExUVnUy33PSgxyKHRkWxuLOMPBtOlttrut7gMVotWTH
         uAiw==
X-Gm-Message-State: ACgBeo3pOlvlXOHx1Zqg4UvGvPdg4N8rAQYsHcyLG35efzDfEiNnS0li
        Ip6I+ikScLIzbRT79Fxt0xL93xXJdLPyZgzWC+qy2y6QxLW6S5KxQqjQSGITCyX/hQelI7ypfnY
        DnQn9d9LMZe9d+44NxnXv9taYQzVfKpi+yYcY/1S0
X-Received: by 2002:a0c:b309:0:b0:496:6277:953e with SMTP id s9-20020a0cb309000000b004966277953emr6978205qve.77.1660923899232;
        Fri, 19 Aug 2022 08:44:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Hc2ZOCME0gpn+lc9a9OvgTyIXKsg/yLvVyJ8pQTmNOIEsbnWTS8GP9R4XmCi9QIDfpVs6VLTm+SlaDkSJT4M=
X-Received: by 2002:a0c:b309:0:b0:496:6277:953e with SMTP id
 s9-20020a0cb309000000b004966277953emr6978190qve.77.1660923899005; Fri, 19 Aug
 2022 08:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220819142519.5684-1-mario.limonciello@amd.com>
In-Reply-To: <20220819142519.5684-1-mario.limonciello@amd.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Aug 2022 17:44:48 +0200
Message-ID: <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
Subject: Re: [RFC 0/2] Stop the abuse of Linux-* _OSI strings
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, Len Brown <lenb@kernel.org>,
        nouveau@lists.freedesktop.org, hdegoede@redhat.com,
        ddadap@nvidia.com, kai.heng.feng@canonical.com,
        Dell.Client.Kernel@dell.com
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

On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> 3 _OSI strings were introduced in recent years that were intended
> to workaround very specific problems found on specific systems.
>
> The idea was supposed to be that these quirks were only used on
> those systems, but this proved to be a bad assumption.  I've found
> at least one system in the wild where the vendor using the _OSI
> string doesn't match the _OSI string and the neither does the use.
>
> So this brings a good time to review keeping those strings in the kernel.
> There are 3 strings that were introduced:
>
> Linux-Dell-Video
> -> Intended for systems with NVIDIA cards that didn't support RTD3
> Linux-Lenovo-NV-HDMI-Audio
> -> Intended for powering on NVIDIA HDMI device
> Linux-HPI-Hybrid-Graphics
> -> Intended for changing dGPU output
>
> AFAIK the first string is no longer relevant as nouveau now supports
> RTD3.  If that's wrong, this can be changed for the series.
>

Nouveau always supported RTD3, because that's mainly a kernel feature.
When those were introduced we simply had a bug only hit on a few
systems. And instead of helping us to debug this, this workaround was
added :( We were not even asked about this.

I am a bit curious about the other two though as I am not even sure
they are needed at all as we put other work arounds in place. @Lyude
Paul might know more about these.

