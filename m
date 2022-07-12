Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A915714D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGLIjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiGLIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E61DB87F75
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657615157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QOqJ4kUVcMhzsvBi2zHV3cNg0o5rdwS2uhN70OOikU=;
        b=CvCQJM9GWmXkTB4valhK7TKbLcHFrvjyp8cyPCs21s3H6rAMgEemqgkXnsRMhOcZfekhRT
        nHGgWMc34SwymupZLvCN1A3CK6iFQtNKmVLoAOJaV5B3Nq4DK6ycKGeZLCmnXu6EcErrLb
        yXlZGuZBEodTOGkg1jG7s0vH5ZWAMRI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-33YfUhjRPQ6V85DPpVdaIA-1; Tue, 12 Jul 2022 04:39:10 -0400
X-MC-Unique: 33YfUhjRPQ6V85DPpVdaIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5694801755;
        Tue, 12 Jul 2022 08:39:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B18A5C15D58;
        Tue, 12 Jul 2022 08:39:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E9CD018000A9; Tue, 12 Jul 2022 10:39:07 +0200 (CEST)
Date:   Tue, 12 Jul 2022 10:39:07 +0200
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
Message-ID: <20220712083907.3ic7bltstaskz72n@sirius.home.kraxel.org>
References: <cover.1657300532.git.geert@linux-m68k.org>
 <0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org>
 <96a87833-d878-dde9-e335-9ea51a4ba406@mailbox.org>
 <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
 <20220712074715.kopstlvz4q6npaye@sirius.home.kraxel.org>
 <CAMuHMdVrf7fgzumcSnZJ3OMGqA34YExXcF3O15YXYpA1ykgKyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVrf7fgzumcSnZJ3OMGqA34YExXcF3O15YXYpA1ykgKyQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:01:15AM +0200, Geert Uytterhoeven wrote:
> Hi Gerd,
> 
> > It IMHO is not applicable to any physical hardware.  It's used by
> > virtio-gpu where the supported format depends on the byte order
> > (it is argb8888 in native byte order).  Only virtual hardware can
> > have that kind of behavior.
> >
> > And we can probably drop the DRM_FORMAT_HOST_* variants for 1555 and
> > 565, they are not used anywhere.
> 
> Atari DRM supports (big-endian) RGB565, so it uses
> DRM_FORMAT_HOST_RGB565.

Fixed big endian should use 'DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN'.

As described above DRM_FORMAT_HOST_RGB565 means bigendian on bigendian
hosts and little endian on little endian hosts.  Which is not correct
when your hardware does big endian no matter what.

take care,
  Gerd

