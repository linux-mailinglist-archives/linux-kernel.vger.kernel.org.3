Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F645774D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 09:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiGQHCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 03:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiGQHCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 03:02:04 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191213E93
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:02:02 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i206so15660982ybc.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2k/JR3F1DIpnnVtJSGtxlTMBCpRYAZf1oh0tWs8Csw=;
        b=Anlvgkcr3PBMA/4iJWZVfnHLySKkbvnlcoSLef0QtwPCUVZ0oByx6slzVKSNgQe2tP
         wRhFYGEVc9a3gPzGq4dkgszzMzpRh00OOWsgdv2walxOMJNLf4MLzqHiR4fRPtEevIBd
         mREq77SrkC/UNse+s98bOpM0BUuQVLY3oY4AMXB0Tm8v4j1pPucX15n5/kRhn0dFNcYq
         8KaG28Z2tAK3gGcebnC7owpeFgANVMgbtgofxU4AAZnRDPNMeaQu1x5Zm1E/g72tsiEp
         rsPUHBtYrBzWf4f6aNs44t3Bh3iclK9vjusFy4WEEA9xRg4smWR7BstBtLqYIxNssOAe
         N6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2k/JR3F1DIpnnVtJSGtxlTMBCpRYAZf1oh0tWs8Csw=;
        b=MTzSp5GcjvQIA9C7sIkyrDq5V9WPgQeCaUBFevBPT1d8T2UR1HhDslOyLKPFOdV4X6
         ZmoErR/SDb54WtQ+Qjpj22VbIPEWOTBW6bHvRmHmrOss7/eo+vJSwgN00NYhJeTg26ZX
         Gqp79ruuHfINhEJ4RRBp4ZV5pslvVz5Rsq7LO4PU7U7s83x115BLjV+xZSfwTnQFPxOI
         PicjhlZzN49s45Dbr+CAENBUs+Cby+r4JwN2dkRVXYH0yyObaulL0SMtOjGfhTYRSyxy
         IO52lDu++Yb/HZg44XjttD4KPqd39e5zmGewBDKFlcMEG/15miJK4PG1N0/xht9LkSvQ
         eMOg==
X-Gm-Message-State: AJIora/Pnhqn9uskG8yCw10B87hQB0BUGvwdg0zkcLsceBEJNojt7lj/
        kFdGjQ8spaZfaUJOVM/WL0F5Y/Y493/y3715ya0=
X-Google-Smtp-Source: AGRyM1sjplFK40itoMhjbZy2q+kcddH0mWzHjzm+zj6pO77K0jQjxh5kI8a3vwLcdZf4+SGyoUJ65JHt7y9rekNQdUs=
X-Received: by 2002:a05:6902:140d:b0:66e:ba97:77f6 with SMTP id
 z13-20020a056902140d00b0066eba9777f6mr22419233ybu.38.1658041322151; Sun, 17
 Jul 2022 00:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
In-Reply-To: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sun, 17 Jul 2022 00:01:51 -0700
Message-ID: <CAA5qM4B5NAGH1ewpo_cAStYj8cD4bKpcTingQiaGcF2sCo9cKQ@mail.gmail.com>
Subject: Re: [BUG] staging: rtl8192u: Found a bug when removing the module
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 5:16 AM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> Hello,
>
> I found a bug in the rtl8192u module.
>
> When removing the module, I got the following warning:
>
> [   20.407360] remove_proc_entry: removing non-empty directory
> 'net/rtl819xU', leaking at least 'wlan0'
> [   20.408609] WARNING: CPU: 4 PID: 451 at fs/proc/generic.c:718
> remove_proc_entry+0x2e1/0x3e0
> [   20.412316] RIP: 0010:remove_proc_entry+0x2e1/0x3e0
> [   20.420050] Call Trace:
> [   20.421178]  rtl8192_usb_module_exit+0x4a/0x63 [r8192u_usb]
>
> I think the problem is the misuse of the proc entry, but I'm not
> familiar with the driver, so I'm reporting the bug to you.
>
> regards,
>
> Zheyu Ma

Thanks for reporting. Looks like wlan0 is renamed to something else
later after proc fs files are created.
Could you test the following patch?
Thanks!
- Tong
