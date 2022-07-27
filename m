Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7CD582328
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiG0JcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiG0JcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:32:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813118399
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:32:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m8so20623162edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDxU8UpTzIwC16C1Npz7pNPhe0tD3l3qzIZ1ONOmOR4=;
        b=NeR96LvHqZ4iiknwkBuU1u7f6VpIPcxOlNjDmhTTE13tFIrwW1ooRsTz3eqVihjsyc
         3eAZu96HSAb+QSXpsLzFY/XbevcakwU3HospbNRqWamftyFqJ9rJUq7bokpML3GHzzYI
         J/RgaW3DRCBmVFGpG7D1IlGH0KS4EmS0DsZwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDxU8UpTzIwC16C1Npz7pNPhe0tD3l3qzIZ1ONOmOR4=;
        b=zVWKxQliDveS6E8+mZd3yZlJ3vO4giqi9usA5Jl0stlwM0LOM7aaInA2MsndehQ6ZE
         eJHs1q3ya+dWa8rOdryawLkNWo9lv6wy4bMbVlX7CHcjIb8oVrfznyIzKfkIJ9vMdlC/
         U0wmQTrP7Rh+2v3ZLTxTc+hBVQLxOAMToOpENm+zWBwzV17fWpR3LBIWbCpK3abk9Efb
         XLenKAIDFRMlJ+k9jhUtfsmeBTEPN9BbTzOxG+4ZJFjb17E6rsvoytiBDcPbgoid7jAM
         F76va1z7kdQn60OwST5wh0c9u7F12Lcj8w1ZqEjvGaym6jP6orBHqs3Wf9PSFdqXwOD4
         ODIw==
X-Gm-Message-State: AJIora/U5s+kOWXCTkH1Vn2w95epmQqBUMuIxg+XK63qJvsXH9AK37j/
        uD1x4VhnXUHuWxMXlpEMGq4aZK38BJ0xts9o35/7JQ==
X-Google-Smtp-Source: AGRyM1tJ8HEDSa4exKeP0jeZ8ob6/irEJZGScgGGiNY/DmF9Cae3HXrXiVrDHvSw2pqtwtxp5E9OZ3rP1Mmkszoy/rI=
X-Received: by 2002:a05:6402:e96:b0:43a:f21f:42a0 with SMTP id
 h22-20020a0564020e9600b0043af21f42a0mr22730535eda.382.1658914328760; Wed, 27
 Jul 2022 02:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220727064425.4144478-1-dlunev@chromium.org>
In-Reply-To: <20220727064425.4144478-1-dlunev@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Jul 2022 11:31:57 +0200
Message-ID: <CAJfpegvN8vKVMqqBYX+WyYKSEC5y5avTZ2qCUvJGjBDAHBUUEw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Prevent re-use of FUSE block-device-based
 superblock after force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 at 08:44, Daniil Lunev <dlunev@chromium.org> wrote:
>
> Force unmount of fuse severes the connection between FUSE driver and its
> userspace counterpart. However, open file handles will prevent the
> superblock from being reclaimed. An attempt to remount the filesystem at
> the same endpoint will try re-using the superblock, if still present.
> Since the superblock re-use path doesn't go through the fs-specific
> superblock setup code, its state in FUSE case is already disfunctional,
> and that will prevent the mount from succeeding.

Applied, thanks.

Miklos
