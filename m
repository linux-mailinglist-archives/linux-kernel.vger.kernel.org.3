Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817350FAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349120AbiDZKgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349228AbiDZKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:36:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120E21B7A9;
        Tue, 26 Apr 2022 03:19:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so14684114ejo.12;
        Tue, 26 Apr 2022 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdKMYq1x4eFZR1761jMnOKfmipBzzsQvF9m6fKna6z4=;
        b=lDscyfKc/f26HqBYW5qPexzS57/2t5Fem/L8v0LNCuw3VArs/RHcMQrMTFpcDATVix
         Oxj3ZqfbTTcftOa/bvwgxeQwqYmqYMEvnZn1xFceiYAlXSzVwexcm028oXwPeHm5Cn5b
         dEki/D9koY1Vi4+3+idJLeArTzRzvb0LbS9P51sH8du51bsi2F2UzbaK5tlQunizK5D+
         N+Xui1PR8XJXTxpFL/dZZDYt0uIZ9XC+kXT7UyFLixcO+VIUTD23OHFX/VUuGHw1Srj1
         si8LK/h7EJuYJDyI5tSOwf0eLojJAtVXFae4YC/9MgFpXCmt6mOC864rcTVx8H0W4p1p
         xsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdKMYq1x4eFZR1761jMnOKfmipBzzsQvF9m6fKna6z4=;
        b=U65/fn08k3+jKExKJYdfZt46YNr8Xqd+bqMBDY0wYO7L4ovcSHjrE5v+RvLPMHb4ec
         irlEGNsq4Tjv53kq6VYMHXVI1kH2IW3qw9TxBiR1qFS+9AO32ebOLUVFpAjFbV9PMzLA
         SYk76gveM1aHJC/uPq4KN+sA/jDsNuG2FbBCGU+xYKhbSfekyephYh736VmMHCifSY0S
         ixZI4tbtUAMUUQn+M3kRgS8h6FmMPJ2kJaGmq9ubj5Vy4o8+wAZO1LrgMTcuJzK0lHZf
         CFiE3H5DnCmpOZMnKXNUI9z2TNWi1mjKHGTyZPnKp3U+UEpyFbSI0kqSwXogA5c4gzEW
         057w==
X-Gm-Message-State: AOAM532Muo7oBxkFcrIOWRuvj9DyUa7hSAXN2ymKiljAPJBGlVjViil0
        VNtL8+eYg7GmmlEuzncwZJxQNS/uiF7xiWf6fqhGpMDNSefSBUvZ
X-Google-Smtp-Source: ABdhPJy6Fr2BpVUt3mvcrY4bs3C/CkFzU6RtNNJwhEBMQKR0W447JOKmPFzBbOYfjrz+WVHPvs44GCfQnmXxiqqLsUI=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr20282272ejc.132.1650968343655; Tue, 26
 Apr 2022 03:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220425121340.1362-1-heikki.krogerus@linux.intel.com> <20220425121340.1362-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20220425121340.1362-2-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 12:18:24 +0200
Message-ID: <CAHp75Vdch3shuX6D6YU8=JrFLKq4h_WNYAQPd_bj-hmV6QoQkg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] usb: core: acpi: Use the sysdev pointer instead of
 controller device
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 3:41 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The controller device (hcd) does not always have the ACPI
> companion assigned to it at all. We can not rely on it when
> finding the ACPI companion for the root hub. Instead we need
> to use the sysdev pointer here.

...

>         if (!udev->parent) {
>                 /* root hub is only child (_ADR=0) under its parent, the HC */

I believe the comment can be amended now to point out that we use the
physical device representing the parent of this child, and not
(always) a direct parent of the device in terms of Linux device model.

> -               adev = ACPI_COMPANION(udev->dev.parent);
> +               adev = ACPI_COMPANION(udev->bus->sysdev);
>                 return acpi_find_child_device(adev, 0, false);
>         }


-- 
With Best Regards,
Andy Shevchenko
