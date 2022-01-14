Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352048E291
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiANCid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:38:33 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54930
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236040AbiANCic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:38:32 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9FC933F175
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642127910;
        bh=x8E4rD8Rz/JKte0ZApLAtI01ZkoCv/YtSv05wruJE3I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SoPK+5wXGs1NBac9+bzNQzI8R8LJ0HgbOTRxCnvQ2h81s9TpLp6UsrxGh9jHXJUk9
         ilmGR5FZDAgPPeO3hIX0C53Or2ZTsecKdicsnUkf00L/2JTfBwvIB/CQZr1tktXvPE
         EwaYkwLOXRoLEJGw1AyrlIj3QdeTv11hFeOngUI0fe+yjxYe6SxoR7lh9gSmD33NeM
         vbYPIV9RSfk9srxql7uNUvgoGyd78vXPyhc0fQC32BYPEcKytfsyGdRt3PyG/A/lBv
         55zh+qLiHzKJc2JZrxyYMoQ2aaRQrqvBj8qC1k4FE8ZMi0V7as3wE8+8GqXMQQrYsN
         6/iNuy+EuGeDw==
Received: by mail-oo1-f71.google.com with SMTP id t26-20020a4ad0ba000000b002de9567955cso2652713oor.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 18:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8E4rD8Rz/JKte0ZApLAtI01ZkoCv/YtSv05wruJE3I=;
        b=3hbGsTmlnJ/zY/pEqKzRzDbJAAFBQ9wKLWxzPNt6kCWmqofPT7XIMP//W2Kw/A3BfN
         HxdTl9ehiTmHZxI5CvE4VlWttO5X7Hy4qN3LoaKKnbWrmm9b2ZfECy2Iny9RvLkMoqcc
         zflZhHQtYjJYEJA+MLb9bHCJaDcfGD8vAQ854okX2L/U1ArI9NnEB+QT3nfc2pLhZfQg
         fp58G+mrLYCGbFf6Y47GZnMyGe4yhuvvgslzCPDW1FfD/IWzDAitbn84Fjfa33EFV5s8
         huKl+n6mZgUYRiWdCl+grjnLg9VRZ1VYs149mVbVARKph1bcc7anLAh7VKyB4LXqsE5N
         +Vbg==
X-Gm-Message-State: AOAM531Wf4YhtVOR+IQoQgFEGrJdx1XaqiCF69TqX4K8Mct0jRO4mAzm
        mi1aCCwNyCDSXLDiZcYWHpyvEPm8UIXhBFNBkXklqj50bMDVR8zAinsuiURTbKkzf9O4R898KuW
        gh0eUVs0e2Rs1x2iZLzcwSNsQQ2qJAXh7j+ZliO9gFysrHCiJhslfnEl4jg==
X-Received: by 2002:a9d:7e84:: with SMTP id m4mr1875159otp.269.1642127909149;
        Thu, 13 Jan 2022 18:38:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvqAmlOvlR76bRJnqo/vJfDqUjOyrMMWBDWMbgWdZMnxcPeeLGWg2dW7qFpTsYBIpbombT5vHF7LsHoStuXYg=
X-Received: by 2002:a9d:7e84:: with SMTP id m4mr1875147otp.269.1642127908879;
 Thu, 13 Jan 2022 18:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
 <20220112071659.GA4502@lst.de> <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
 <20220112140304.GA27446@lst.de> <CAAd53p5Qo3+-sXMLLPxe3ckY4ySxRvaLZkv=0zgKc=EVun9uYg@mail.gmail.com>
 <20220113161204.GA3230285@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220113161204.GA3230285@dhcp-10-100-145-180.wdc.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 14 Jan 2022 10:38:16 +0800
Message-ID: <CAAd53p6X5otqff+LCe94qoG+QiqEofNmGM1p4q-fGfTU186gMg@mail.gmail.com>
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
        Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jan 13, 2022 at 02:39:02PM +0800, Kai-Heng Feng wrote:
> > On Wed, Jan 12, 2022 at 10:03 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 08:50:33PM +0800, Kai-Heng Feng wrote:
> > > > USB thumb drives also use this flag, so I am not sure why it's not
> > > > applicable to NVMe?
> > >
> > > They shouldn't report this flag and might need fixing.
> >
> > So what should we do? Introduce a different flag but with identical
> > usage for external USB and NVMe storages?
>
> What's the user visible result with this flag set? Does some rule
> automatically mount a 'removable' block device's filesystem partitions
> to something like /media/?

Udisks uses 'removable' to flag its 'HintAuto' attribute, and GNOME
Shell will automount the disk based on 'HintAuto'.

Kai-Heng
