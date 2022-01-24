Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982EB49A239
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 02:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1844445AbiAXXik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:38:40 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44659 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842011AbiAXXAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:00:38 -0500
Received: by mail-lf1-f54.google.com with SMTP id u14so22099497lfo.11;
        Mon, 24 Jan 2022 15:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TonNysDZMx9C4Dgz002yU+hZtY7UFn20FRBn7HwXRao=;
        b=zJeZXL4lEtXd51yhNP4Dt8NLrpOgKtwtkuVhFgMcSeY3lJUm/fx6E5JHiyV0IGv5Bh
         6JZ1PiIh06FdTyZ1LD8xsguOBmpG7eVO+VNBWGPR0wQZ7/8nvrulNgKd9EH6NypN016B
         k49qrM7qWUsvn4fDiGduiMdmg4ED37TNTErJljOjdwxsi6DVhhigpDHLe0xhrNvLFzzU
         s+8YHebAxzDyw0RuRGz3dTeX5bg+6ETw0sDXXU6kJyhbIzaQkIUvSClOhzitqa+x/hI0
         tlcvnpY38RPzZQviZy8rDWekcfQ96DuF2BM/bf6yfxon95iGdlxCuKSskC5qKoZmmYr5
         H9Kw==
X-Gm-Message-State: AOAM533JDGhIvNv7AG2xKTnwbPGy/uUEqAp9TolZi7e3ELRz44tjdTdu
        eIoEyGsmCFTQ4zTqAIvXec8BBHH1+XwCJIDgRoX7g+kjEf3wfQ==
X-Google-Smtp-Source: ABdhPJwUnhDVJOnLtC1IiX8E70tZTGNmcoWs3IFq1spDSkVkBLWmAMy/FESSLlhmgEkEjLfuy96nEV5Lp6wBMpR5v3o=
X-Received: by 2002:a05:6512:6c1:: with SMTP id u1mr14221835lff.9.1643065235474;
 Mon, 24 Jan 2022 15:00:35 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNb22JCJ4AyR1sYqFtF4QUnvM3B2zQcc1svcm2mquWxoA@mail.gmail.com>
 <YeUvvIaVJnJrrpYe@kuha.fi.intel.com> <CABXGCsO5PYBuZ11YR16NLLa0H07Jom1JQhWHFuETfotfBfzkMw@mail.gmail.com>
 <YeVQsRp7aDMcQKs7@kuha.fi.intel.com> <CABXGCsMWXFFQY3L8ixK9K-gYX41_gTjqHRBXNp6gDpUgdnvFfg@mail.gmail.com>
 <YeVfYOhxGTgg8VpZ@kuha.fi.intel.com> <CABXGCsOwsP7NJ67oyK3HPs2EarSJKLB9EVW7oEh+8bAFihSa8g@mail.gmail.com>
 <Yea8p1b/sZYKNGaB@kuha.fi.intel.com> <YebBq/WDeYCIvwYw@kuha.fi.intel.com> <CANcMJZDrs418aUoVS4CijQFqgAW3pCbfm_NUCmx+T7HNoiMVnQ@mail.gmail.com>
In-Reply-To: <CANcMJZDrs418aUoVS4CijQFqgAW3pCbfm_NUCmx+T7HNoiMVnQ@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 Jan 2022 18:00:24 -0500
Message-ID: <CAJvTdKnMKdQ6KJe63phZ87kJz2SjeQoNTHqajSfv4RJo6+Y6jw@mail.gmail.com>
Subject: Re: [Bug][5.17-rc0] Between commits daadb3bd0e8d and 455e73a07f6e,
 the kernel stops loading on my devices.
To:     John Stultz <john.stultz@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, linux-usb@vger.kernel.org,
        YongQin Liu <yongqin.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Len Brown <len.brown@intelcom>

The typec_link_ports crash goes away w/ the 2nd patch.

https://bugzilla.kernel.org/show_bug.cgi?id=215529

On Fri, Jan 21, 2022 at 4:33 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Jan 20, 2022 at 3:27 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > On Tue, Jan 18, 2022 at 03:12:10PM +0200, Heikki Krogerus wrote:
> > > I can reproduce this one by simply not creating the component list in
> > > the code. That function - component_master_add_with_match() - can't
> > > handle situation where the list is empty. I'll prepare the fix.
> >
> > I'm again attaching the proposed fix, just to see if it also gets
> > corrupted. Can you test does it fix this issue?
> > You need to apply it on top of the previous one.
>
> We've been hitting the null pointer crash from
> component_master_add_with_match() regression as well on the hikey960
> board.
>
> The patch you attached resolves the issue. It would be great to see it
> merged upstream soon!
>
> Tested-by: John Stultz <john.stultz@linaro.org>
>
> thanks
> -john



-- 
Len Brown, Intel Open Source Technology Center
