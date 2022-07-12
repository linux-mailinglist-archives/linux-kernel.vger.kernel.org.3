Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273D1571365
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiGLHra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A4699C264
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657612043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwKfKFbx4WwviqtMMacQ0C+SYHYAOQOV85TH5GU4PBI=;
        b=HXZ5cqUdnOYg+KkchxmmV0VMLNPePmWMIcLxoXNp9NuRSFQ+WZZtc7sWJak3ZKL6YJA9bE
        Mge+r0GuEm9zyZZ2DWl08MVnr68ef4t6NUIF6mNjPTT3ZGnol6UlmkjoI3ZAX64mZSdG0t
        7RuQKIsbGydTkzm8w+500VYrwZ4Clt0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-lWqTc9k-NwOQ2KkLNRlK6g-1; Tue, 12 Jul 2022 03:47:18 -0400
X-MC-Unique: lWqTc9k-NwOQ2KkLNRlK6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 736ED8037AA;
        Tue, 12 Jul 2022 07:47:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08618C15D58;
        Tue, 12 Jul 2022 07:47:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A946318000A9; Tue, 12 Jul 2022 09:47:15 +0200 (CEST)
Date:   Tue, 12 Jul 2022 09:47:15 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
Message-ID: <20220712074715.kopstlvz4q6npaye@sirius.home.kraxel.org>
References: <cover.1657300532.git.geert@linux-m68k.org>
 <0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org>
 <96a87833-d878-dde9-e335-9ea51a4ba406@mailbox.org>
 <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:30:30PM +0200, Geert Uytterhoeven wrote:
> Hi Michel,
> 
> > > Cirrus is the only driver setting quirk_addfb_prefer_host_byte_order
> > > and supporting RGB565 or XRGB1555, but no one tried that on big-endian?
> > > Cirrus does not support DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN
> > > in cirrus_fb_create, so you cannot get a graphical text console.
> > >
> > > Do we need these definitions on little-endian platforms, too?
> > > Would it be better to use "DRM_FORMAT_{XRGB1555,RGB565} |
> > > DRM_FORMAT_BIG_ENDIAN" instead of "DRM_FORMAT_HOST_{XRGB1555,RGB565}" in
> > > formats[]?
> >
> > The intention of DRM_FORMAT_HOST_* is that they are macros in
> > include/drm/drm_fourcc.h which just map to little endian formats
> > defined in drivers/gpu/drm/drm_fourcc.c. Since this is not possible
> > for big endian hosts for XRGB1555 or RGB565 (or any other format
> > with non-8-bit components), this isn't applicable here.

It IMHO is not applicable to any physical hardware.  It's used by
virtio-gpu where the supported format depends on the byte order
(it is argb8888 in native byte order).  Only virtual hardware can
have that kind of behavior.

And we can probably drop the DRM_FORMAT_HOST_* variants for 1555 and
565, they are not used anywhere.

> I read that as that you prefer to write "DRM_FORMAT_{XRGB1555,RGB565}
> | DRM_FORMAT_BIG_ENDIAN" in formats[]?

Agree.

> > It's also doubtful that Cirrus hardware would access these formats
> > as big endian (drivers/gpu/drm/tiny/cirrus.c has no endianness
> > references at all, and the hardware was surely designed for x86
> > first and foremost).

Yes.  qemu mimics physical cirrus hardware which uses little endian.

> > Instead, fbcon (and user space) needs to convert to little endian
> > when using DRM_FORMAT_HOST_{XRGB1555,RGB565} with the cirrus driver
> > on big endian hosts.

Well, the cirrus driver uses shadow framebuffers anyway (the only
workable approach given it has 4M vram only), and it also supports
converting formats on-the-fly when copying from shadow to vram.

So adding support for bigendian formats to the driver shouldn't be
much of a problem.  The vram will continue to run in little endian
RGB565, the shadow will be big endian RGB565, and the driver must
byteswap when copying.

> Yeah, probably the cirrus driver can use some fixes...

I'd call it improvements.  It's not like the cirrus driver is broken.

take care,
  Gerd

