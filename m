Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA65568C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiGFPMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiGFPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:12:02 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0813D4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:12:01 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id ck6so18599285qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u094c1pWAuc2qjFRYuYIiBLyQBzCT6qd8wf4uxXSTSI=;
        b=ACSjlXyddhi5EaW5WOef3D1vif2MeOWYcJ2Qw7Jwge3SWdJVJHQDHgfBOHdwp7bB4r
         E1Vu8pzZckmBVeHJQTopmqxzOf+lZqIYUHIX4SW+1FeA/SL0Gzb+f8y2vKROOZ9MgXEc
         u93WULI24pobdOz5oktNiKp6GJesgLSK3Uai7nBewmpT+B/wI9Cnt2CEuDMLJD+0qcG2
         DI4JPKVORLb5LSnuVec0cQBMZ0+jWGPiwLJDdix4kFVRPdqVWsVDPaq1n1zyc1qbAHLh
         j44w477LZW5QSIDaCutnMR4pC2C1msOe0VTk/s0vSf1/9SJbm0W+gMgfevBkt0hhioeS
         ebGw==
X-Gm-Message-State: AJIora/YsGi3NJoWayyut+5XcoA5hEwPixMgdQP/Nxsav+fj6DWCqvGR
        eo8GRdA0ozQ3BOaIqfKkvF45
X-Google-Smtp-Source: AGRyM1tmmHS3hmEoSfozfOq3OFvufYVLm+WLqowCSt0K1ZgT8OE07PhhFHfBTGi7f9mSyqrGwqz2Lg==
X-Received: by 2002:ac8:5985:0:b0:31d:3ea5:12f4 with SMTP id e5-20020ac85985000000b0031d3ea512f4mr18144555qte.274.1657120320113;
        Wed, 06 Jul 2022 08:12:00 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a410400b006a6278a2b31sm20037145qko.75.2022.07.06.08.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:11:59 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:11:58 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v7 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <YsWmPt7xwTlvTfAf@redhat.com>
References: <20220627153526.3750341-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627153526.3750341-1-mka@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27 2022 at 11:35P -0400,
Matthias Kaehlcke <mka@chromium.org> wrote:

> As of now LoadPin restricts loading of kernel files to a single pinned
> filesystem, typically the rootfs. This works for many systems, however it
> can result in a bloated rootfs (and OTA updates) on platforms where
> multiple boards with different hardware configurations use the same rootfs
> image. Especially when 'optional' files are large it may be preferable to
> download/install them only when they are actually needed by a given board.
> Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
> at runtime. As an example a DLC package could contain firmware for a
> peripheral that is not present on all boards. DLCs use dm-verity [2] to
> verify the integrity of the DLC content.
> 
> This series extends LoadPin to allow loading of kernel files from trusted
> dm-verity devices. LoadPin maintains a list of root digests of verity
> devices it considers trusted. Userspace can populate this list through an
> ioctl on the new LoadPin securityfs entry 'dm-verity'. The ioctl receives
> a file descriptor of a file with verity digests as parameter. Verity reads
> the digests from this file after confirming that the file is located on the
> pinned root. The digest file must contain one digest per line. The list of
> trusted digests can only be set up once, which is typically done at boot
> time.
> 
> When a kernel file is read LoadPin first checks (as usual) whether the file
> is located on the pinned root, if so the file can be loaded. Otherwise, if
> the verity extension is enabled, LoadPin determines whether the file is
> located on a verity backed device and whether the root digest of that
> device is in the list of trusted digests. The file can be loaded if the
> verity device has a trusted root digest.
> 
> [1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
> [2] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html

Hi Kees,

Please pick this series up, thanks.

Mike
