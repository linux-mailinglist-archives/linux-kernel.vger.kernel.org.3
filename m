Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD5477CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbhLPTtT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Dec 2021 14:49:19 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37554 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbhLPTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:49:18 -0500
Received: by mail-oi1-f175.google.com with SMTP id bj13so442934oib.4;
        Thu, 16 Dec 2021 11:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K9YSig+dSH4wLkJkl1f3TD0qsdd765YDc+vqhCt6/IA=;
        b=IlxemNFQZneKAOxvFi4+BvdnnM962XjF7LV+R+TaMBjBCrfXKxERHGtGobv4bbmPL8
         nPXw7rfAy9wMbC8j/bDAOG34/q4EQfjzxN4HpdKC88Ld9OyPz8eegQCKljNktHAWL7Vb
         /2gnqKaiMM8Qj5zQFHTDxn/QKE5ugCQhigywuLz7iJ2HnsA3LO0J1En6ub67iHmQoySg
         s4JCjjipFjDxVnVUgshNcERL6o8TJYD461uYA7uMVml1nj4soRS3uzUc4NnxmwEdFOHb
         KNhpiJ/VkLYQoUmfcc/hHRqacNTh0SO1N8bfX3Pa+wE+49gvlNpKlCobtHIpfYLwPKoO
         MFVw==
X-Gm-Message-State: AOAM5321DqQKiDqi9R8VV5MjjPpPAPsUFHTGn9jjmXZ8TutA0GffrRYW
        H2obUHdpgJR7Td5/rjpGekdGPh+r6RrGl99d8Y8=
X-Google-Smtp-Source: ABdhPJylmJtuBFAfte6BXy9loWt6kt1insGu4s4RTJz4lr0j03s/TjeCqwB3oNwKq1FuMpV80rjGXzr3g5OS66RLx+0=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr5394026oih.51.1639684157589;
 Thu, 16 Dec 2021 11:49:17 -0800 (PST)
MIME-Version: 1.0
References: <4717160.31r3eYUQgx@kreacher> <b9d06e6378a7c3b0e0b2561ab2a971c8fa1ff3e9.camel@linux.intel.com>
In-Reply-To: <b9d06e6378a7c3b0e0b2561ab2a971c8fa1ff3e9.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Dec 2021 20:49:06 +0100
Message-ID: <CAJZ5v0ha5oimVv6i-yW=Dt8Fzf07+06V4b7xUyN3mY45yBvVbQ@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Fix error handling in dpm_prepare()
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 8:44 PM Thomas Hellström
<thomas.hellstrom@linux.intel.com> wrote:
>
> On Thu, 2021-12-16 at 20:30 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 2aa36604e824 ("PM: sleep: Avoid calling put_device() under
> > dpm_list_mtx") forgot to update the while () loop termination
> > condition to also break the loop if error is nonzero, which
> > causes the loop to become infinite if device_prepare() returns
> > an error for one device.
> >
> > Add the missing !error check.
> >
> > Fixes: 2aa36604e824 ("PM: sleep: Avoid calling put_device() under
> > dpm_list_mtx")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
> Was this meant to be a Reported-by:?

Yes, it was, sorry.

> Also Cc stable? IIRC 2aa36604e824 was.

That gets added later and -stable can figure it out.

> In any case,
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Thanks!

> > ---
> >  drivers/base/power/main.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/base/power/main.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/main.c
> > +++ linux-pm/drivers/base/power/main.c
> > @@ -1902,7 +1902,7 @@ int dpm_prepare(pm_message_t state)
> >         device_block_probing();
> >
> >         mutex_lock(&dpm_list_mtx);
> > -       while (!list_empty(&dpm_list)) {
> > +       while (!list_empty(&dpm_list) && !error) {
> >                 struct device *dev = to_device(dpm_list.next);
> >
> >                 get_device(dev);
> >
> >
> >
>
>
