Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1146689E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359692AbhLBQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359444AbhLBQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638463728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1q1RzJ+2t0CHGLzbZhstdiq3rb2yHdihH6eKJNd/eIc=;
        b=YlPuXTFzSDtfpMdw6dCsBiPX3pFzSVN6dsAXV3tHcfqCB4KS/0ISsqDieCn0m6+ZpzShgr
        R/f2NlP8exyUSCCANHe7/+y7cliPEYteJjL+7MYuOMN5Mo7Fz4xqr/HQdtQLIt1obv+G6x
        D1CU3BlRpk8VkaswwH8tEDSpfXdVlEU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-ipjgIlcbORKUzmuMMOgSwg-1; Thu, 02 Dec 2021 11:48:47 -0500
X-MC-Unique: ipjgIlcbORKUzmuMMOgSwg-1
Received: by mail-pl1-f200.google.com with SMTP id l3-20020a170902f68300b00142892d0a86so78954plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 08:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1q1RzJ+2t0CHGLzbZhstdiq3rb2yHdihH6eKJNd/eIc=;
        b=OAo7e6GyRLzBHzEik8qMNuI45GfFxljrC3HWYOEYPtKN+40jJQTNjj9AWcclqoKdGr
         ETlCJIR3vlFiq5r3feFmYw18u/j1hIAtxmp3WCGSm7Mak1YeRxQCXVmAT430I/G8C534
         YCDW/FSbehDapcJbcdQVPrK3D8sl14W9t+ct6hzOCYMtLAX6QyBDSP3FT4Kw+EuhtIQF
         IQps1gJJfz9Dz/XHGN+3NW1Mf9He3kuTljyWqLRQF37jVbn6v1jJX3z3xoALYJ1CyxuG
         3C9ZXsdf4D7Zci5kSglM6A6pczrFy+MdbfYCyNlkgIF9NNMDHUdOV3+GIZMoqpXIvsqa
         AtxQ==
X-Gm-Message-State: AOAM533Gn+v9sGfh7EZPBgGNGhaE3R1s0w46/3E+PsTGhEY0edd8Wabb
        PJBhgcJ5KZaIPNOhIigkcVUuI49ktkODcrhxic0FUCaHX++rKiExoktQsQ2XCFl239xGIM3KIEb
        N/q8FfjNhwZjl7zH4SEHQZdDtRZ9fMT8ihRQkp0W+
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr7254307pjb.173.1638463726616;
        Thu, 02 Dec 2021 08:48:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxihkDeddhgXH3xtiHhnyw1kUwlg/OjbbEA+77GtMBGAFVas/jDWzBFYJsI719V12l/7vWviDpGdt1TXgQoSsk=
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr7254279pjb.173.1638463726357;
 Thu, 02 Dec 2021 08:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20211202095334.14399-1-benjamin.tissoires@redhat.com> <YaiypPqBRtHDjmMs@kroah.com>
In-Reply-To: <YaiypPqBRtHDjmMs@kroah.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 2 Dec 2021 17:48:35 +0100
Message-ID: <CAO-hwJKOnC3EXQAH8w5gcmQijFs-=TXac2-ZgTx6zMBbrt=X4A@mail.gmail.com>
Subject: Re: [PATCH 0/4] HID: followup of uhid crashes, and couple of core
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 12:49 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 02, 2021 at 10:53:30AM +0100, Benjamin Tissoires wrote:
> > Hi,
> >
> > this is a followup of Greg's series[0].
> > hid-sony is having a wrong error path leading to unreleased
> > hidraw nodes, and bigbenff is having a crash when used with
> > a wrong report descriptor in uhid.
> >
> > Those 2 first patches should IMO go into 5.16.
> >
> > The 2 others are some core changes I had locally stacked and
> > which should be ready to go now. They can be scheduled for 5.16
> > or 5.17, there is no rush for them.
> >
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>

Patches 1 and 2 are applied to hid.git branch for-5.16/upstream-fixes
Patches 3 and 4 are applied to hid.git branch for-5.17/core

Cheers,
Benjamin

