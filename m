Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3436A5714A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiGLIcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiGLIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94CF7A5E55
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657614729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQxIBj6PcKC66/v1neohOf1D/KG+opt9mK5QyhmwE5w=;
        b=Z6cwDODOb4PxM9FKaLNotLpBIjTfuxVxCwKqpW/jrVTZO7y531yK+TO1XZHgKPsb+w4JIo
        8uFc6Nf4cDwlErMbJHVnCch1yjm5G/o/XUfTabyZQiYWepxqZIMfOZG+tNJBZLJ4gqpAjy
        ksILufxKoJKqeQ0Qq5LGAM1loU3xDZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-97XA7a_IMQmseuEGgQzkuw-1; Tue, 12 Jul 2022 04:32:00 -0400
X-MC-Unique: 97XA7a_IMQmseuEGgQzkuw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 087E1185A7B2;
        Tue, 12 Jul 2022 08:32:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C06E8492C3B;
        Tue, 12 Jul 2022 08:31:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EF3FC18000A9; Tue, 12 Jul 2022 10:31:57 +0200 (CEST)
Date:   Tue, 12 Jul 2022 10:31:57 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        David Airlie <airlied@linux.ie>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
Message-ID: <20220712083157.wtujadjcyboerxcl@sirius.home.kraxel.org>
References: <cover.1657300532.git.geert@linux-m68k.org>
 <0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org>
 <96a87833-d878-dde9-e335-9ea51a4ba406@mailbox.org>
 <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
 <20220712074715.kopstlvz4q6npaye@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712074715.kopstlvz4q6npaye@sirius.home.kraxel.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> So adding support for bigendian formats to the driver shouldn't be
> much of a problem.  The vram will continue to run in little endian
> RGB565, the shadow will be big endian RGB565, and the driver must
> byteswap when copying.

For completeness: The other obvious option (for fbcon) would be to
handle the byteswapping in the generic drm fbdev emulation, which
would have the advantage that it would be more generic and would
not depend on the drm driver supporting the bigendian rgb565
formats ...

take care,
  Gerd

