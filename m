Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19E459CFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiHWDsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiHWDsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:48:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB15E316
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:48:05 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9271B40AFC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661226483;
        bh=mtCEp4uiimBkFVG2jUbW2sWT9JVevWVVixkZgdiNhJM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dw4hpkhE2BJCkYhMn+LbB7DHX8L0z13awZPmTm54TBCwjAoC7v+PZV+eTLkgI5CXE
         TcxbJpfna3jfQZ/LTIKxj66qbdj1zNpIxJuHH/Vp5yjRC0uAsDfOQQ+RgzYSC3zAbB
         AqZXpo1/UqF+WqlxrbyeiFdmHiaSjLmQ8dGP90243c8dq+myQWNoTSo432MzhbOdNt
         NDHEM2NHLTEVWP4xnN8hMwbH+0yX2+9RMsMyjco6Jt0x8W0hPal6wyK2F2tPBDCjci
         nwBRdJrWGR/r0yLxDafePJxWs1uDOAn7E8hjVCT6B4YdQ2/xMTKIMhnDeF6T6dADf4
         ndE7nDox5kkeQ==
Received: by mail-oi1-f197.google.com with SMTP id u10-20020a54438a000000b003451c5e52b2so4182061oiv.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mtCEp4uiimBkFVG2jUbW2sWT9JVevWVVixkZgdiNhJM=;
        b=dp3ucHfKTbS+onKDHpKnubi1ksXAuMVPPOZjSQD8YiWK1mT7Q3OCRYk3yk+N8GYEue
         fVCpWzKj+8v2JsY1OAEqlApAat2fgcBAPQTWtKG1VIM5y1SiTDjdhk6blMrj5CHxI1NK
         rlB2Q0nRh36ornFyfA6m6+wm+eilXH8wYBNemtq+Anj1lxliudbxggm7IDoCabXtAEnd
         cCjJBnHPk3fsYCV59sI3H7Ky7ug9T9xMktC8CQEQnNBcr6IxiZpj+OrDr3+8mDXj52bW
         kRh6DOkfW5Hop4mf0nzDPePNEEL3dTX79YlhQA0U8/gsqKLNn9YIOSZerjPn3BMDYoUL
         EjQQ==
X-Gm-Message-State: ACgBeo1uzu0IGTJApmBCsBdquH8aLDGEx16bQebTg3Lc2nU/8f/s4i8y
        vBsivDaW10t1EThCTEdjlpw8dFan0ajWJLrxpVV9JW/06sVXgs4K3d8PD2bqO84ZR1q1KL7ckA6
        Zm9aOrJfCAtWaENxzU6U49GTTwQt8vAVf8RxBjjKJj4jXBALtOGUgJp8ATQ==
X-Received: by 2002:a05:6870:8901:b0:11d:416d:2ccb with SMTP id i1-20020a056870890100b0011d416d2ccbmr583919oao.176.1661226482273;
        Mon, 22 Aug 2022 20:48:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77AfvgDfhYP1L6DVx/ZciIkJeu4mOvATNwD6si5fK0mh4kUfNdNgxn9Ve0xFqoMjMmYykDpSvmC3EGNMm+dUY=
X-Received: by 2002:a05:6870:8901:b0:11d:416d:2ccb with SMTP id
 i1-20020a056870890100b0011d416d2ccbmr583907oao.176.1661226481986; Mon, 22 Aug
 2022 20:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220819142519.5684-1-mario.limonciello@amd.com>
 <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com> <c10b243a7be185ba119bdfce9a46e609db3bdd3b.camel@redhat.com>
In-Reply-To: <c10b243a7be185ba119bdfce9a46e609db3bdd3b.camel@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 23 Aug 2022 11:47:50 +0800
Message-ID: <CAAd53p6dTdWzkiyH6Sz=YubhdibvGa4hZ+EPN7mZA4aYSPd_6g@mail.gmail.com>
Subject: Re: [RFC 0/2] Stop the abuse of Linux-* _OSI strings
To:     Lyude Paul <lyude@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, Len Brown <lenb@kernel.org>,
        nouveau@lists.freedesktop.org, hdegoede@redhat.com,
        ddadap@nvidia.com, Dell.Client.Kernel@dell.com,
        Aaron Ma <aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Aaron]

On Tue, Aug 23, 2022 at 5:18 AM Lyude Paul <lyude@redhat.com> wrote:
>
> On Fri, 2022-08-19 at 17:44 +0200, Karol Herbst wrote:
> > On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > 3 _OSI strings were introduced in recent years that were intended
> > > to workaround very specific problems found on specific systems.
> > >
> > > The idea was supposed to be that these quirks were only used on
> > > those systems, but this proved to be a bad assumption.  I've found
> > > at least one system in the wild where the vendor using the _OSI
> > > string doesn't match the _OSI string and the neither does the use.
> > >
> > > So this brings a good time to review keeping those strings in the kernel.
> > > There are 3 strings that were introduced:
> > >
> > > Linux-Dell-Video
> > > -> Intended for systems with NVIDIA cards that didn't support RTD3
> > > Linux-Lenovo-NV-HDMI-Audio
> > > -> Intended for powering on NVIDIA HDMI device
> > > Linux-HPI-Hybrid-Graphics
> > > -> Intended for changing dGPU output
> > >
> > > AFAIK the first string is no longer relevant as nouveau now supports
> > > RTD3.  If that's wrong, this can be changed for the series.
> > >
> >
> > Nouveau always supported RTD3, because that's mainly a kernel feature.
> > When those were introduced we simply had a bug only hit on a few
> > systems. And instead of helping us to debug this, this workaround was
> > added :( We were not even asked about this.
> >
> > I am a bit curious about the other two though as I am not even sure
> > they are needed at all as we put other work arounds in place. @Lyude
> > Paul might know more about these.
>
> Some of the _OSI strings are totally fine. From my recollection:
>
> [    0.242993] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> ^ this one is needed to do a couple of ACPI tricks at startup to get the PCIe
> device for audio on nvidia's GPU to be detected properly

This should be fixed by commit b516ea586d71 ("PCI: Enable NVIDIA HDA
controllers").
Aaron worked on more Lenovo systems than me, so he may be more sure of it.

>
> [    0.242993] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
>
> I don't actually know how necessary this is, but I'm hesistant to call this
> one bad as it may be related to the funny mux configurations that I'm learning
> may exist on HP machines.

Should be fixed by commit 8e55f99c510f ("drm/i915: Invoke another _DSM
to enable MUX on HP Workstation laptops").

And for "Linux-Dell-Video", it should be fixed by 5775b843a619 ("PCI:
Restore config space on runtime resume despite being unbound").

So actually I am in favor of removing them all.

Kai-Heng

>
> >
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>
