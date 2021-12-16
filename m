Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6FC477D67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhLPUVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233586AbhLPUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639686113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jNVvkqs0Rpz1daVHHfDUsDlVwoDvruQypySygjyOd8=;
        b=PZrRqMrrRLLKE9wCFTsLEmZaq8G262bV1KP+5vzEtGV0lFR2ZiiqSJc0QZQtPMEJ6timNt
        JI94rq8Uv50ocEWttK2ZthtUyKkP8TGfICor7G2WxZ+Zjy19RYJ7DQ3xsbVZtQtGUvGeDd
        O6pUQFvpWedabl25DviQIIiHXFOBMwo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-zzJ3WoY5PE-9AlO7xkopnA-1; Thu, 16 Dec 2021 15:21:51 -0500
X-MC-Unique: zzJ3WoY5PE-9AlO7xkopnA-1
Received: by mail-ed1-f72.google.com with SMTP id w4-20020aa7cb44000000b003e7c0f7cfffso24302218edt.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 12:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4jNVvkqs0Rpz1daVHHfDUsDlVwoDvruQypySygjyOd8=;
        b=THwApSub+Lg6iXXgsCMWnMWuJWvpGQUJupA6prO1YX2mv/yET54ZPAT4FEQZsSl3nm
         sW+mnGMhrOQUad+8+c9+e/mhUq5MgOEoKWPJ2S2WrkCRjiZm20y5o5ao6fM5s6ImMhUt
         9Ani6LyK8pQUq0gKlNesgZdKY4IwoDWTj0kx49vqK8qGwxwLFkSxkBXknuwLtR0Mk/tT
         EbJaM6nRZtzTl276o7aOvjhRLDnaJzSmS2GqsLEQlqVsrTPimDsqJWDMbX558ufrxorg
         ccaJFM5ll2OcnmG6hz5DXXQcKI/+e1EZ8Xzii0K5B1eIuQmiFDBo5RCTzXwPhdMWjVBX
         GF9A==
X-Gm-Message-State: AOAM5327POsg7YXKuCYePgWI9ovpMcqiaIsVy2OZALhSXS0R69V0oJUp
        O/ZDOsIXyW5RC6cNPnvms/U4orRtrS9tKR3U8lgFwD2T+A/szz3OdmLi+tICyDLfIMJgaAHZHh+
        8Sd2W4qGwr/0olYDorDG69AHxFd0kFqeqv2nwCUR9
X-Received: by 2002:a17:906:d54e:: with SMTP id cr14mr4585123ejc.724.1639686110604;
        Thu, 16 Dec 2021 12:21:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5TrBQDhec5S8MpqrzjB+uugBOSGONH0FwNYWw86mCaVHMpLi8Qk2TWqknosMRVZK6sy//lsKyzlgelaA3h2k=
X-Received: by 2002:a17:906:d54e:: with SMTP id cr14mr4585114ejc.724.1639686110406;
 Thu, 16 Dec 2021 12:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20211213123737.9147-1-wander@redhat.com> <20211213123737.9147-3-wander@redhat.com>
 <YbohEio+66fyFo6D@linutronix.de> <20211215123116.622da7ef@gandalf.local.home> <2f3300ba-0879-ad7d-8d44-bb8d8b17d7e2@kernel.dk>
In-Reply-To: <2f3300ba-0879-ad7d-8d44-bb8d8b17d7e2@kernel.dk>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 16 Dec 2021 17:21:39 -0300
Message-ID: <CAAq0SUn=j3bQoDLO6muGs776seGwhugf=OU7rEMRM2vFK6djpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blktrace: switch trace spinlock to a raw spinlock
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 4:34 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/15/21 10:31 AM, Steven Rostedt wrote:
> > On Wed, 15 Dec 2021 18:08:34 +0100
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >
> >> On 2021-12-13 09:37:37 [-0300], Wander Lairson Costa wrote:
> >> =E2=80=A6
> >>> To avoid this bug, we switch the trace lock to a raw spinlock.
> >>
> >> Steven, do you think this is a good idea?
> >>
> >
> > blktrace is actually maintained by Jens.
>
> Looks like there are two patches, and none were CC'ed linux-block.
> Please resend.
>
Ok, I am going to do it, thanks.

> --
> Jens Axboe
>

