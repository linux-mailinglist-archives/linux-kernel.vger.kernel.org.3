Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4772149F585
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243304AbiA1Inh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbiA1Inh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:43:37 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A7C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:43:36 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id bi36so197721vkb.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ftcw1vD9z1Mq6YJKReviY0KJR4CI2yGzMz8ANHP/I3Q=;
        b=DaL++O/y2Y7K/mFSHLxd+/ipObnIwivSwqec5hzr+O7nR3IWz0+rgZjyoIuHnvruZH
         +XTJFg2x/QwMZI1XUYYGx6V46KVoc5rfTLvNEdzTs6Xt6ilTJIkCjgNfJLfsdoky77ym
         DRbltg/ujxUjNDTP7IOJul5WCs/DIrPbGxrT5Y7+HGBIk3jBxhQjnQ1Gg9wX41tJBjhO
         j+n5v/ascBEcd/+qPST8sdfk36/H0NjFdq1lMBXW6ajVNzh3n3ZgwRqswreYtoOpcv2R
         JhDE4eUUP5Yj/kbxf0OlD63UxtajK1C6FEiMIrgX0pSycEKCirDU4ibmbFs8TDqwMN9N
         /i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ftcw1vD9z1Mq6YJKReviY0KJR4CI2yGzMz8ANHP/I3Q=;
        b=bs+zRKo0KvHTSDU0nbWcLWQEwYkuooO1S9CQpi//l1qHrHSrOj7sIseRAnYLxsgRCi
         kNzl8U/rrpNbPjfHG8dtDPryR/YBbv2oGxedylMHlyu79vSZQsEMBEZXDKhihvsSX5+M
         /l5bAhIHld0C41AVM0a8OTkiC6nhZNGmW0bRAO+AlmLHNjdUprIVMDdoCIu03OP/6TN4
         FbmFIwEuA5GZrSIfJL/07K3Vt5CebILRz9MVrjlUGk9jjUjllCbxh2ekeSMQwj5FCduM
         O4QH2vM5nsCCWLa5bcEGWy12K11KkXForx/wxlvWPpS66THvqAAv6JvHY8DIxAQ+QvxZ
         ntJg==
X-Gm-Message-State: AOAM531pNanm4HmvvsPCW3du6JL4Z58iPmEqd0ca4k5FiethC3WVG2UW
        Hs2CxlKHHA0iSXv4ex2kisS6XLWiLrbwK5tfje7e9A==
X-Google-Smtp-Source: ABdhPJwmfhOAGP+BJwxRCZrzMfuOrJeVWS+4bKrkTmVCbPNw6FPwVvetSBth5KxLaOdV4nl10Dmlyn516F+PfW/83g8=
X-Received: by 2002:a05:6122:a26:: with SMTP id 38mr3325568vkn.23.1643359415840;
 Fri, 28 Jan 2022 00:43:35 -0800 (PST)
MIME-Version: 1.0
References: <CAE9iGoiCZZBkyX9ZWnhSDMjWmucOmybCOp=XTr6Hz5rN9GNyrw@mail.gmail.com>
 <20220128045522.3505336-1-zichar.zhang@linaro.org> <YfOUzZ4scTZAWnxl@kroah.com>
In-Reply-To: <YfOUzZ4scTZAWnxl@kroah.com>
From:   Zichar Zhang <zichar.zhang@linaro.org>
Date:   Fri, 28 Jan 2022 16:43:25 +0800
Message-ID: <CAE9iGohVRCPJeokpU97Hb5opKxUxHAVbKZp8t7Bhg30550Yfmg@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RFC] wakeup_reason: Add infrastructure to log and
 report why the system resumed from suspend.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     john.stultz@linaro.org, krossmo@google.com, lee.jones@linaro.org,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, nayakvij@google.com, pavel@ucw.cz,
        rafael@kernel.org, sumit.semwal@linaro.org, amit.pundir@linaro.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I'll do that and resend to this email thread.

On Fri, 28 Jan 2022 at 15:01, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 28, 2022 at 12:55:22PM +0800, Zichar Zhang wrote:
> >
> > Signed-off-by: Zichar Zhang <zichar.zhang@linaro.org>
> > Change-Id: Id70f3cbec15f24ea999d7f643e9589be9c047f2b
>
> Please always run checkpatch.pl on your submissions so that you do not
> get people asking you to run checkpatch.pl on your submissions.
>
> thanks,
>
> greg k-h
