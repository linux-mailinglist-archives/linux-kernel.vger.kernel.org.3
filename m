Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F482484828
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiADS52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235913AbiADS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641322646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5/oRp09czNHRuOEhgWyRyTW+iAZaeWjdUNct+kTpW0=;
        b=c/Qp+koVhxTf7l39ky/kn7CoMEpTEJqN8RJpniK4v81MYgF7Kr454fSPNuKxLZnmFxgck6
        56UGhY5hebxup1hBfPX69Edv9jtqBUEKhfWrQO2pcTIPCW6ZZnotoouv9MOlbtSqXuA7Mu
        vKpr5F64dVxyYmec4gv0zCMnVkp7UKU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-E8TnPCdyMWS7tA1L4qqfRg-1; Tue, 04 Jan 2022 13:57:25 -0500
X-MC-Unique: E8TnPCdyMWS7tA1L4qqfRg-1
Received: by mail-qk1-f199.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso21565558qkl.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5/oRp09czNHRuOEhgWyRyTW+iAZaeWjdUNct+kTpW0=;
        b=356ZnZ1jD17mQWCp08pb503WYWtL9XmKndO7yK/sJOtkbZFlzwd/9SZIzZI5SIUj8k
         +nDPWfwB+a0rgrjl+RDgYwkGCstLv2NiUMfAx29AJCFuGooU05GHeVYXkHq3zkIcgUgX
         LU04ezUIKp0PYwmGvi5l/us4FLbsGL1LCyOswdlt9ceA2bYnYjsOSZkmgcAXTZYmnHBm
         gsjwZRhxjK7HzCoejOhH5Sg64KmgduqTxqG3yHQMl9XN0XHNJD8WUtJsi7tilabSQHmr
         5eXgo1NAySOkC9ef8790WaLEMvUx4VMqLuUgAMI5ofeZ2ND9euiu35A3luoHEn+1sB8W
         7ZpQ==
X-Gm-Message-State: AOAM532ssE5SfAbOa7uh3lJCW0L8kEJcHAG9d5MiBDWVu25qUhI5llsD
        cHdZMz4xPWWI+bDDoLrUMQ1f4a3qxqEIOyLvQNAhrAKE0Y4LD5hekm70IIMpD2gu/vaaRbk1I50
        3z5hOt3QO+etr2HqWfqZ1/ZrSzP7KKP9zeiHFJAYR
X-Received: by 2002:ac8:4a0e:: with SMTP id x14mr46061151qtq.345.1641322644540;
        Tue, 04 Jan 2022 10:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY5Jb8OM0ChHLxAtBitQbRhduI6iTYF7RWU97ZON70BVaBcUtDPP4ln05Ykg45Jk6Z3AEJnPL9BvW00sROAkI=
X-Received: by 2002:ac8:4a0e:: with SMTP id x14mr46061135qtq.345.1641322644295;
 Tue, 04 Jan 2022 10:57:24 -0800 (PST)
MIME-Version: 1.0
References: <e8e73fcc-b902-4972-6001-84671361146d@datenfreihafen.org> <20220104182806.7188-1-paskripkin@gmail.com>
In-Reply-To: <20220104182806.7188-1-paskripkin@gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 4 Jan 2022 13:57:13 -0500
Message-ID: <CAK-6q+jkQqZ-Mog2Bwq2EGWFYv-vYtSYRJMqJUARm=C+Cd+uRA@mail.gmail.com>
Subject: Re: [PATCH v3] ieee802154: atusb: fix uninit value in atusb_set_extended_addr
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     stefan@datenfreihafen.org, alex.aring@gmail.com,
        davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
        linux-wpan@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 4, 2022 at 1:28 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Alexander reported a use of uninitialized value in
> atusb_set_extended_addr(), that is caused by reading 0 bytes via
> usb_control_msg().
>
> Fix it by validating if the number of bytes transferred is actually
> correct, since usb_control_msg() may read less bytes, than was requested
> by caller.
>
> Fail log:
>
> BUG: KASAN: uninit-cmp in ieee802154_is_valid_extended_unicast_addr include/linux/ieee802154.h:310 [inline]
> BUG: KASAN: uninit-cmp in atusb_set_extended_addr drivers/net/ieee802154/atusb.c:1000 [inline]
> BUG: KASAN: uninit-cmp in atusb_probe.cold+0x29f/0x14db drivers/net/ieee802154/atusb.c:1056
> Uninit value used in comparison: 311daa649a2003bd stack handle: 000000009a2003bd
>  ieee802154_is_valid_extended_unicast_addr include/linux/ieee802154.h:310 [inline]
>  atusb_set_extended_addr drivers/net/ieee802154/atusb.c:1000 [inline]
>  atusb_probe.cold+0x29f/0x14db drivers/net/ieee802154/atusb.c:1056
>  usb_probe_interface+0x314/0x7f0 drivers/usb/core/driver.c:396
>
> Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
> Reported-by: Alexander Potapenko <glider@google.com>
> Acked-by: Alexander Aring <aahringo@redhat.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>
> Changes in v3:
>         - Changed atusb_control_msg() to usb_control_msg() in
>           atusb_get_and_show_build(), since request there may read various length
>           data
>

Thanks for catching this.

- Alex

