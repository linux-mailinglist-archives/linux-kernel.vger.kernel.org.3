Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3733048C435
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353271AbiALMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:50:58 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36696
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232738AbiALMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:50:50 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 334293F175
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641991846;
        bh=D1KNKVI44z/PsvFst/TK173wi7+38whGq+x5398gON0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JopNeE47KEvoxm4NCN1RCmzwDftFfmdF37ZnIZEMUVjwC929IYfszBVbRSuFkQNhS
         gS5hH884G/xyEyzrKioPnz7I2+tH/hoOuqcU2AndlQoMmq+f9gfYmdXmxaSbQrrQ3L
         mwjVmDtjAeBbe1K/Kit4jnfeVREQlIepdEDTpMY3wBrT8C/lN+mOmOyyHzxaPsO4Ud
         RdfMVyiMvbDvDuAhQmX6Xbgyoo7XXXCaBBknXsRzy3p16c6aL1H0Kw2feVrRZhO9QG
         wUhC/P9C2UstQHIYvsOwSVKMfyhzfPWeOPEhT6forpKxejP6lvtafh6TgGjFJ5IqBq
         PHS44/jM5JeOQ==
Received: by mail-oi1-f199.google.com with SMTP id j125-20020aca3c83000000b002bc93dd9241so1634348oia.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1KNKVI44z/PsvFst/TK173wi7+38whGq+x5398gON0=;
        b=xswWYRN+ypIpkmCivhPIn+5DfO2xAhHqbvil0yaJEZZ716/TlIzSUW+BFFd2lx/h0r
         vQLyCQAvD7+0hCxcWsDI4bdX8tTNDtIojuUXImEnQa3GXWONfmIOW94mX2lpyL7bybdR
         L0hLyXon0S/0+ZmBNmb5MRiW1fqiqurktaT/H1GC5uUbZcCOt2N8WsIu1bnz1cMlUbPq
         p8zURpMWRSkTD5mnnQq4YamMn6NdShZSt9OgcBSImJ/sWuIvtI9B4l5LdpohVhYn0nqw
         0EakgGxf/156HrrOWPlcCW1cWP0+tRoca1ApQXZlSUNqsER7Gd4Y3rj06evZ5wC6jiyw
         6fwg==
X-Gm-Message-State: AOAM533K6/L3uePnOtZ+Ezi7NZDeeQZJOktvv1JK3iCZvhxM3x2zqzs3
        3fP5Giyvy4t4Yiu2jvtwB0B1xBAkMAd+QVZ41UmVMKj0RHaRbHLg2oS/AjO4XRmfo1RjxX+o5n3
        OaiHon9mLPJzVe7CljUHqdA6csPdSQyBnuTFm4KHYV4Ff2nHDNzyRBujXzg==
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr6458444ota.11.1641991845087;
        Wed, 12 Jan 2022 04:50:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM+H18459QT/pnZUF17RGyfujL4v5cngiYatRHZMiCD1d/ynvUX+jBq5rww/cWUEn6F5jL1h5ES8nPHbI6LoQ=
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr6458435ota.11.1641991844824;
 Wed, 12 Jan 2022 04:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com> <20220112071659.GA4502@lst.de>
In-Reply-To: <20220112071659.GA4502@lst.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 12 Jan 2022 20:50:33 +0800
Message-ID: <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 3:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 12, 2022 at 09:31:54AM +0800, Kai-Heng Feng wrote:
> > Commit c037b6c818c3 ("PCI: Add sysfs "removable" attribute") can mark
> > entire Thunderbolt hierarchy as removable, if system firmware provides
> > correct attribute.
> >
> > So apply GENHD_FL_REMOVABLE for NVMe if removable bit is set, to make
> > userspace daemon like Udisks knows it can be automount.
>
> GENHD_FL_REMOVABLE means removable media as in floppies or CD-ROMs,
> which does not apply to NVMe at all.

USB thumb drives also use this flag, so I am not sure why it's not
applicable to NVMe?

Kai-Heng
