Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6F47C7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhLUUAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhLUUAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:00:31 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:00:30 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f5so33287893edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03b8JEx7x7sVo+n9oab25EgRuWaarR+EsSqM8sOFrHw=;
        b=Sn5pOJcIZYwylNoW9QxLWWVoz1uz280iPGWpzGz9T05hU+ewx/kcEB19tv34VTkajb
         GVVpG/v0EULqU3rvDdaNkALTjq5MmetyvPH7TR+LgE78VGK2cqKxrVyPRFD3VDolWDAO
         jOG9En6q+L6QUe9OctpzUGij+CpPomiuH/PMiLE7q7MOq5vTcDjsTW0H33VzRLPBnTfg
         YPELbnXG80tswnJs6HvAlEND7idJhQVMsVtChnBpCyVtuo/a9tw2Faqo5N31IMnKQlEG
         sn0F7B1NttWzzF6KaYODHXaxq1mhw9IDglrFP/LxAxcSC0xK7pbTfjM3VgaEBMaerYke
         feQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03b8JEx7x7sVo+n9oab25EgRuWaarR+EsSqM8sOFrHw=;
        b=pKUxxtOhvI6SRX7AD+TcojqWdZc2NKq/Ostd8nFtjUD6r4ua4yYw+axQS/mGvKt8hC
         T1eKfOFJOlDjHmYh5DtDh12zhSjihL4GZTNDpaIhAlaf5anvjbKxD9xLOL89AwCKHIkM
         wjHGK0p/layF5EcOjqT0X4nM4JqiY+EXaPL0MD25MPmMGkhIAVfwIL8h5fjuGmWZVYtC
         /ytDrsxdDdfEj15aB0JOiuYPYvVHgEykuLz7lzIdha1HHBAJD+/oQP5k1lhHHX0N+Mep
         eOrKqifHO13RlYhkb2m0WMMUTj2wnGuf9s2lvM/t1x3eYQPuNcqQUp7o9VJ1QWEYWYg1
         gu5A==
X-Gm-Message-State: AOAM5321Sl8biGAOaiquuKOItXw5JL9qjaqrp/7/FVzNdiHSol6A3/Sz
        5JV/TOrw/kmHYZXF1hxBbzLsMIpzMnxFT1DRzLFi
X-Google-Smtp-Source: ABdhPJxaRocodz/N9B9AknrzN7Yy7OTYHb/7Jdw1fyvi4ZS/QZRCDo/wGPm87pvloX1I/aLKRyq2ag6UlZZa/8hF7EI=
X-Received: by 2002:aa7:ca17:: with SMTP id y23mr4738511eds.213.1640116829047;
 Tue, 21 Dec 2021 12:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20211210120359.394986-1-bernard@vivo.com>
In-Reply-To: <20211210120359.394986-1-bernard@vivo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Dec 2021 15:00:18 -0500
Message-ID: <CAHC9VhRq5P_Wd2VMW+eGx4_EYzmhW8DsnXdvhniyFGhjRA=Q-Q@mail.gmail.com>
Subject: Re: [PATCH v3] security/selinux: fix potential memleak in error branch
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 7:04 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch try to fix potential memleak in error branch.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Changes since V1:
> *make it to be simpler to do the "(!s)" check before the "(!opts)" check.
>
> Changes since v2:
> *add *mnt_opts = NULL after kfree(opt) to avoid double free risk.
> ---
>  security/selinux/hooks.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Hi Bernard,

I apologize for the late response, this was lost in my inbox for some
reason.  Regardless, this looks fine to me so I'm merging it into
selinux/next; thanks for your help.

However, Ondrej made a few good suggestions about further improvements
that could be made up at the LSM layer, I think it would be nice if
you could look into that too.

Thanks again for your help.

-- 
paul moore
www.paul-moore.com
