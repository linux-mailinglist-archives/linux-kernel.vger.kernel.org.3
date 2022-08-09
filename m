Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA758DAA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244715AbiHIPBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiHIPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:01:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E152F1A382;
        Tue,  9 Aug 2022 08:01:17 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z145so9759665iof.9;
        Tue, 09 Aug 2022 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7Z8Gt1kvQ2qMgFvYLX9L5Os/pwoMppPUG/zH/675HiM=;
        b=JFvhVPx7UTePPnr+5h1qdd0uExGBu1XIZzljf2CKVBl944uYdakgNuSexevzfQy5xJ
         pNz9YMZnA30DuJFGQEHP/5+VG8/mRg2MVDcqJDNEBT/JvoOQVNQu76BOBQ/+Fc/7eLuk
         Utx62Z/6+5qeo2PG8U9Qhz4jMTyvANXy631UFqQpb7ATf0v2YmMmgJc22Su5HUAiKiac
         2Yf6fIOZlmCqWhBaLDy7QFztAJNpd+QTQPyFDnQMJGUx4UT6YWuobE2sT2V6LqVhblAf
         djdEHwmyc7jf9U560o0FCAEQ81/OxM67CD3iWQaqR8pYoKGjchIAve2CwolU58DMo9hJ
         Hggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7Z8Gt1kvQ2qMgFvYLX9L5Os/pwoMppPUG/zH/675HiM=;
        b=tQ7lBBo20UdnQ5NvqxKq/ntImrfznecSfxhmlAQfqpP607TwTQ1r9wHv3b2uCIGpI9
         VPpixLQCVhuvKCcM8W3e4GSec3VZWQW4HXiydCMWDv5cQwMsr5qbQVjvW+3OEl+fIHPY
         60HMaeIlUz0D8XDEouaaZxH2whfs0MCNZiPbHQP2W7r2x9dvFmSM+0rp6AzD9lVzqE5A
         cJG9BwWhAG97aUr7VmX6dUclGtx+5lKBHjaaASWwm7n/ml31ccpXVfcaw3729v9D2h3n
         zD07KheP7uQNtRtst9h2m7Sr6p8Y6EdcigZ6RVeaG+GzfigEMwh1wBHML+YErwC9g2Vy
         OrCw==
X-Gm-Message-State: ACgBeo2BPs4DCC+FDgOlbM8uDwUpwob7xtLO6jG1T2LWGMA5SbJFoQrJ
        nILPnsMZIV0B8lWx1/mD4oBuVpgzupycQfDN3nw=
X-Google-Smtp-Source: AA6agR4bp8FvYijrSbc8+bax4hs4cQGMD11ArEow4B4n9Lwp7iHI0dQimsqmJe2io4dmXXYOVXju9V2XDuz49nxUEK4=
X-Received: by 2002:a05:6638:1353:b0:342:9bfb:7382 with SMTP id
 u19-20020a056638135300b003429bfb7382mr10587461jad.129.1660057277054; Tue, 09
 Aug 2022 08:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <91ff0bbb-ea3a-2663-3453-dea96ccd6dd8@amd.com>
In-Reply-To: <91ff0bbb-ea3a-2663-3453-dea96ccd6dd8@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 9 Aug 2022 08:01:04 -0700
Message-ID: <CAF6AEGusyJAt88A18hFBz-S6An2pVpNoQP0NDk7e0tKw7inAyg@mail.gmail.com>
Subject: Re: DMA-buf and uncached system memory
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Sharma, Shashank" <Shashank.Sharma@amd.com>
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

On Mon, Feb 15, 2021 at 12:58 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi guys,
>
> we are currently working an Freesync and direct scan out from system
> memory on AMD APUs in A+A laptops.
>
> On problem we stumbled over is that our display hardware needs to scan
> out from uncached system memory and we currently don't have a way to
> communicate that through DMA-buf.
>
> For our specific use case at hand we are going to implement something
> driver specific, but the question is should we have something more
> generic for this?

I'm a bit late to this party (and sorry, I didn't read the entire
thread), but it occurs to me that dmabuf mmap_info[1] would also get
you what you need, ie. display importing dma-buf could check whether
the exporter is mapping cached or not, and reject the import if
needed?

[1] https://patchwork.freedesktop.org/patch/496069/?series=3D106847&rev=3D2

> After all the system memory access pattern is a PCIe extension and as
> such something generic.
>
> Regards,
> Christian.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
