Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A428C4C0338
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiBVUhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiBVUgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:36:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9F1405CA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:35:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i11so38086505eda.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7z+2gBVssBTwkTFXRrU+BRzNhXOykt+QfnboI/H0jI=;
        b=Nx4Ebu1Qa73CdYd5vi87qARsrD0v/VpwZMXfHgesrmKuCWb9W3U4528JazIOYaiVyn
         2VEovr0WBDKVp51vKrn7Ug0ljNa2PdcWMBEjHzr0Bgteigjs0cPTG+1hkwiEs62z4bhT
         WT3SopWeJZIBLHGxHSdnc7r+h9BKJQXkQGi7UDb8yL8iXx5FHgeu/4iZvrEHEeLS748B
         f60tjNlc9XgrCs5J6wQPEGZJJcqNXWledRb22U7avPjyWU/VVq/haVwxY81sNfYRcNPD
         x4aBo04jpJ0PINIfmFeRgGXlJ7pfe1f+T7WYiYAAlOqwBskKIJX/mMQV5VvQUPuqoAkE
         Lc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7z+2gBVssBTwkTFXRrU+BRzNhXOykt+QfnboI/H0jI=;
        b=09v8n6EdXYrNEXylBXigAWY2VRGu1am6T03uBT7+MGV0A2E4FgbB/WT79MoJhgSO3i
         PC3SxfXVqffkRJ43SC7p6AxM5UAUAGy3Qu4vyd0/Uc3VOOhJkNVUMnObSBvyVs3prBfQ
         HlXZrngAYPNdXY44IGNfvtFSs6R2xYkXmoRA0Csz6Q3BJ8OZ7P/tryX7dj4XW+S9yO1v
         A9tH3bCZ08QRP1KeVEfQY9kblq73sv89msNuRW/2p+eQlxWQ0I79ejR26k+9YIXbECYz
         oI+WIsDD2AxZJTi7DRQmrGNlZjX3kqXhehoYW09TpdsENH8667+hYLeE7sqRzZJOZXso
         smgw==
X-Gm-Message-State: AOAM532cI53SX6HSZJMJKYY0mfyQZKeY9acqDJ7ZfTP59wCoH/CXD1+h
        kHzu+INA0rwkbe02/HtxLUe7okQMjW1qwnrMoHyO6vglj/c=
X-Google-Smtp-Source: ABdhPJxlv7Aw10zN8xQzuLGYlYSw80uywRepza8MNhd5IsDpmmj58AVIlRbtUyHYQmY8fGDgmgQIrA0TXC+15SlWS5g=
X-Received: by 2002:a05:6402:5113:b0:413:963:4eae with SMTP id
 m19-20020a056402511300b0041309634eaemr10761037edd.197.1645562152589; Tue, 22
 Feb 2022 12:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20220219170301.545432-1-robdclark@gmail.com>
In-Reply-To: <20220219170301.545432-1-robdclark@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Tue, 22 Feb 2022 12:35:41 -0800
Message-ID: <CAPaKu7Q3CAcoyEgvo1KZnJCx6-EO+CPcARCtzwE9Ddbb_OZA_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Remove restriction of non-zero blob_flags
To:     Rob Clark <robdclark@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 9:02 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> With native userspace drivers in guest, a lot of GEM objects need to be
> neither shared nor mappable.  And in fact making everything mappable
> and/or sharable results in unreasonably high fd usage in host VMM.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
