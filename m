Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC374F5207
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849254AbiDFCeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449299AbiDEWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:24:40 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC486E1F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:21:20 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2e5e9025c20so5913347b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05ESTLKuRKureM3diZOwIcKgKT6b+0avzQkzpMlIWl0=;
        b=F4+e721tNcbr4VyIH/v5IIZ9tP+O6JaNPcwsW2WnYFsjKwz+f51Jekl18A+rixt41J
         JOzuclwfSn8f5JdJQKTfJQNWNBFIdf0s995f8zlspLYdTtyXifztXr3SnJ52b5VLUVyc
         F47A1nlECQW6jmuo8criSUTu4sFzdp6DBZ36wOGQjOX3qBgox8zG3vFmBkWaEq7xRL/J
         8AssrUOlC7k5WTeV0oelsqfOT2PekmM12laoDKCx+Sik6VVl9ObsaNZITN/dIW6WZc35
         F3UUxaRXpwVu/a0lL7rew3B56UOopKkIXrdSFC/sHS6huWzOU7/u57GZ9ZN9n8CPrK6Y
         fAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05ESTLKuRKureM3diZOwIcKgKT6b+0avzQkzpMlIWl0=;
        b=zeUSW4UbyXSgpM9K6Chp73xABSlOZbs4iN0FcmkuXdghjiapTOYv7l4XClTYSZ/Wk1
         iZewwfP/WJPiU5zdce62xq4h5u9BysPJm3hJbUUeFXgGpcTpQoTb/ZoKWnBsb+XjEWLh
         d6ojoPUU4g9g/pTWtpO5ETN0AMuo+62+OsVqTChh7f8cI+zUtevysrysgsf2KuXRTOTC
         NDjU0JjnCbvp4psQzfkfTwHK93CKVNkvvcnBV5FADEwEQR5CE4j9inCqCKCNzZirXN3N
         tzBZjg+ijpoUzlRQLH36DEm6MZRWd3If9e5v9sZiyum1n2wYP/dKWgZjUCnMWR+lrzkv
         hqUg==
X-Gm-Message-State: AOAM533QrXhRocinLl8cGybSa6itV1KEoZKzwLs+GEV6GMwZRHMof6W4
        ILWol9KjhvqKFXTDwx1h/VjmhjW8t58hH9sC2q8qBQ==
X-Google-Smtp-Source: ABdhPJwEINNWKQDaea3+TJzBVTdGEUBx+YlA8z0uH9ht1nC2kDVLVG1VUZvrKbQB9SHESxmVI/MOBKOBSGZVxnZp0I0=
X-Received: by 2002:a81:d542:0:b0:2e5:c060:a0ac with SMTP id
 l2-20020a81d542000000b002e5c060a0acmr4410118ywj.118.1649193679956; Tue, 05
 Apr 2022 14:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220329132732.628474-1-paul.kocialkowski@bootlin.com>
In-Reply-To: <20220329132732.628474-1-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Apr 2022 23:21:08 +0200
Message-ID: <CACRpkdbcoRBS=mDqMfseKDWQLZu-ohtXf1jo0nL_S+AagewRBA@mail.gmail.com>
Subject: Re: [PATCH v3] drm: of: Properly try all possible cases for
 bridge/panel detection
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 3:27 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> While bridge/panel detection was initially relying on the usual
> port/ports-based of graph detection, it was recently changed to
> perform the lookup on any child node that is not port/ports
> instead when such a node is available, with no fallback on the
> usual way.
>
> This results in breaking detection when a child node is present
> but does not contain any panel or bridge node, even when the
> usual port/ports-based of graph is there.
>
> In order to support both situations properly, this commit reworks
> the logic to try both options and not just one of the two: it will
> only return -EPROBE_DEFER when both have failed.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Fixes: 80253168dbfd ("drm: of: Lookup if child node has panel or bridge")

This patch fixes the problems I have on the Ux500 MCDE with DPI
panels such as Janice, so:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
