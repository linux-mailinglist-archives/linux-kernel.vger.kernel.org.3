Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A3568C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiGFPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiGFPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:08:13 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B4026577
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:08:11 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id h19so18606358qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ScRkAz/VqtB+AtxqVIwVUVdF/rIZB4AANK+myVEOT60=;
        b=RZd1uUQWWOfKsB5NGXNWrmvivp9BXmQYL902gLAeWF5eMHStYWG7C+mf6ZDkpQzSOw
         kM+vStTET5iiT+9teA2/7oSCSTLr3npBPeMHDn7yXjwvW0MwaTZlPK1TgwsQy6deISCs
         19wI2UTw1pmz6eKIbn0C5mbdiafNDbH7xKzrIdGky0M3U8e95jw7DO2PwCxcxMibVWpS
         rtXLgEnCWf3sjlSDVPLUvfmnj4602Gpj/iRuDsuu03NSToasfYuQ1q1t9nJVAXcK8y8h
         Oe12CV5CpHx/xH7v4d+eADMV1DB893n/eR37bYkfb2PYpAQEIrRFXfm/EGNVVkC/6U6U
         FYDQ==
X-Gm-Message-State: AJIora9HvzOz4gbwJaJKA+ynNpyBaC7RACRX0NjErEHOaFkZwFG2SyvV
        M2ebeZxvRmHf+apr5Jv2xjxc
X-Google-Smtp-Source: AGRyM1vURiVQNneit1uIOq0gI+2o4Q1iXAOnL3S780GQ4xr/mr7+VNJ3IiJ/UQzyRS8zDfx/h2ANCg==
X-Received: by 2002:a05:622a:196:b0:319:83f5:7a2c with SMTP id s22-20020a05622a019600b0031983f57a2cmr33294199qtw.0.1657120090010;
        Wed, 06 Jul 2022 08:08:10 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l26-20020ac848da000000b003177969a48fsm24329478qtr.21.2022.07.06.08.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:08:09 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:08:08 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v7 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <YsWlWIbzJtUQUaWy@redhat.com>
References: <20220627153526.3750341-1-mka@chromium.org>
 <20220627083512.v7.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627083512.v7.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
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

> Extend LoadPin to allow loading of kernel files from trusted dm-verity [1]
> devices.
> 
> This change adds the concept of trusted verity devices to LoadPin. LoadPin
> maintains a list of root digests of verity devices it considers trusted.
> Userspace can populate this list through an ioctl on the new LoadPin
> securityfs entry 'dm-verity'. The ioctl receives a file descriptor of
> a file with verity digests as parameter. Verity reads the digests from
> this file after confirming that the file is located on the pinned root.
> The digest file must contain one digest per line. The list of trusted
> digests can only be set up once, which is typically done at boot time.
> 
> When a kernel file is read LoadPin first checks (as usual) whether the file
> is located on the pinned root, if so the file can be loaded. Otherwise, if
> the verity extension is enabled, LoadPin determines whether the file is
> located on a verity backed device and whether the root digest of that
> device is in the list of trusted digests. The file can be loaded if the
> verity device has a trusted root digest.
> 
> Background:
> 
> As of now LoadPin restricts loading of kernel files to a single pinned
> filesystem, typically the rootfs. This works for many systems, however it
> can result in a bloated rootfs (and OTA updates) on platforms where
> multiple boards with different hardware configurations use the same rootfs
> image. Especially when 'optional' files are large it may be preferable to
> download/install them only when they are actually needed by a given board.
> Chrome OS uses Downloadable Content (DLC) [2] to deploy certain 'packages'
> at runtime. As an example a DLC package could contain firmware for a
> peripheral that is not present on all boards. DLCs use dm-verity to verify
> the integrity of the DLC content.
> 
> [1] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html
> [2] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Kees Cook <keescook@chromium.org>

Acked-by: Mike Snitzer <snitzer@kernel.org>
