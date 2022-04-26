Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AE7510206
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352448AbiDZPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352399AbiDZPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:38:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9BFD25
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:35:42 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i38so14636116ybj.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQZiXIxdmiSHbCLJF1D/j7DSaBPKECeHRKKl9HR5UoM=;
        b=gIVAOUhxi9y7Yo2xEP1k3yvfEjLLjCtl0ov47OXgb2YCXUDGXxTF49I30qX40KpVIm
         PWJB2dxCEcNfr6k05ghawsu1qtRmlx9cTvrJrx+rnVihvgKCMR8vBZPwk9e0VEt8q+4U
         NjXgq3Q2vrQYiUVZiAB7lOASwk5Zh83hQ9PxdcAVsBLhCV47LWDcuUvzbm7kXsdD1m3N
         W1lajCBO/M0wsQhg0lxIM7FhiARI0aiGYKWoHDYAFXy4fhJn5JRqpCiCJdeG8u2kO8cO
         cPEt+wBCbojy4fJI+skhC/N9MI11C5v1WHRb3WYHJ8jC8vP8TGcNI/J1Tbu79wD82rUH
         YAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQZiXIxdmiSHbCLJF1D/j7DSaBPKECeHRKKl9HR5UoM=;
        b=Y76oyG7ToUath5IpsUuxn/XPeMjxW9KsyiFDc4795l2jhrQjyFtYqG59mdTyalzKsA
         5Ed6feLFtbairEhLr3CTmKo+yw7m8O9YCpmv5Mz++lZqTXWoBYjVdM6M+N5EwogMlFwp
         sE8JK7YJCtkb2aK6CHSPRxwJL4WU44mWVjyxtLpFvZ9A23hAxasUG8Kf35cS7whr+bBl
         KdgdLQPTKSESyynz5WpjB9sUZq+KdNM0Ys+DvT5IoccuoD4pTlzQ2bHNbQFSgHkFXdK0
         Q38PhFSjV6JibNaRcdCxDCdTqoHtzaXN6xcDF69eAj/B4LrMFTNjgqps28BqJx/dC8lM
         rUmw==
X-Gm-Message-State: AOAM530hcmn7xXaXgwq1UD/KjIWNKeyb5UV7VqIO04sxylznyV5g65o8
        sVT+pPhkHbw5N09C/Kpy3aTlpRdU4MQRwneW9eAqhw==
X-Google-Smtp-Source: ABdhPJxfB1kY9NVGiRey7y5jAZNb0HTOXTxJRiyMxZf+112Opk8r9k1XvSYnyKCCkyl+dnyJaWo3Zer8qmQsHZmSOI4=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr8726230ybm.533.1650987341152; Tue, 26
 Apr 2022 08:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220423221623.1074556-1-huobean@gmail.com> <20220423221623.1074556-3-huobean@gmail.com>
 <CAPDyKFrksB_kgrnmcay+ub0nDfmPVZfw-zJihop5N8_6qUqrug@mail.gmail.com>
In-Reply-To: <CAPDyKFrksB_kgrnmcay+ub0nDfmPVZfw-zJihop5N8_6qUqrug@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Apr 2022 17:35:29 +0200
Message-ID: <CACRpkdb-snMG8Aabq_oa43_UQx1CVccQteRa8_Ur6OHDKFAc2g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: Allows to override the timeout value
 for ioctl() path
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <huobean@gmail.com>, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Sun, 24 Apr 2022 at 00:16, Bean Huo <huobean@gmail.com> wrote:
> >
> > From: Bean Huo <beanhuo@micron.com>
> >
> > Occasionally, user-land applications initiate longer timeout values for certain commands
> > through ioctl() system call. But so far we are still using a fixed timeout of 10 seconds
> > in mmc_poll_for_busy() on the ioctl() path, even if a custom timeout is specified in the
> > userspace application. This patch allows custom timeout values to override this default
> > timeout values on the ioctl path.
> >
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
>
> Applied for next, thanks!
>
> Linus, I interpreted your earlier reply as a reviewed-by tag, so I
> have added that. Please tell me, if you want me to drop it.

That's fine, sorry for being unclear!

Yours,
Linus Walleij
