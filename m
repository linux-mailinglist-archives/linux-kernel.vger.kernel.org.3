Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22F1522D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbiEKHhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243045AbiEKHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:36:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0356C18
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:36:49 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g28so2315548ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ye0GeoFlH0Q5xQn/Exi4I46k1+mTgeZ6ainsE7f2pPw=;
        b=mvVvcnzCo/y23SA18SaXjXk0Omw4MackwuHVWKPq8e1TXTCOGgfj8MuNY/3cRGCg6r
         lgK318RmKvj0bklEoFCIX+kf0Z58pQtq6BcChCOVP0mPTcuzVJmfVo03h7xAHY5jIvgC
         eUpbBCO1VNuneayutgr0JkXTI5W5Llhid1Whk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye0GeoFlH0Q5xQn/Exi4I46k1+mTgeZ6ainsE7f2pPw=;
        b=iskVUjv+d+j/PK3NCSZ0tCzu0y9cIp9maUoHg1DFEltj2SmhLlrYSlDVR9XkB3NX1A
         0Z4/xgGFTYMQliOVpquyDaWEiEhxNjlNwf0eAZuCZEE8zwkJu6o8OuHqZo7oFfuf4kPJ
         CPjmS/Vnx0Fyh4GyRrIi/7nS45+OOS723HqsXhojRdesrLGm9bNnoNHO7V5fjRMPiEfs
         qKuXHUnv+iEZx7weC7Rk//iXTIBPQoVVmoJ5VYMkVVBLsse4A6B/bDAjeHkQI1O6L0sw
         FqN3vNZ9tRPVL3cKW0bb3fBKoY3XZYXoITwEtepS5q4DLyTWASomsdC9Hy4KopKyWSmG
         kiYQ==
X-Gm-Message-State: AOAM530u7fx0dxQMDqKYNXzZJrSd29IEACvucyAmIJ26Ka+kn1kVoKmA
        IJm4hDQbSxZo6twJYh6kc5VKWsd+nNHEuu0QV98dRPpNXo7YVA==
X-Google-Smtp-Source: ABdhPJzH752naca/2nfIKHi0Us0BMTyPVVIH6KS0gNXC2QtPtLP90uuE7ynZRBY+KWktBYt275klxJrDQSjx3EOCl2w=
X-Received: by 2002:a25:20a:0:b0:645:74e4:8cc9 with SMTP id
 10-20020a25020a000000b0064574e48cc9mr21733176ybc.518.1652254608456; Wed, 11
 May 2022 00:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
In-Reply-To: <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 11 May 2022 17:36:37 +1000
Message-ID: <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 5:07 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 11 May 2022 at 03:31, Daniil Lunev <dlunev@chromium.org> wrote:
> >
> > Force unmount of fuse severes the connection between FUSE driver and its
> > userspace counterpart.
>
> Why is forced umount being used in the first place?

To correctly suspend-resume. We have been using this force unmount historically
to circumvent the suspend-resume issues which periodically occur with fuse.
We observe FUSE rejecting to remount the device because of the issue this
patchset attempts to address after the resume if there are still open
file handles
holding old super blocks. I am not sure if fuse's interaction with suspend is
something that has been resolved systematically (we are also trying to
figure that
out). Regardless of that, doing force unmount of a mount point is a legitimate
operation, and with FUSE it may leave the system in a state that is returning
errors for other legitimate operations.

Thanks,
Daniil
