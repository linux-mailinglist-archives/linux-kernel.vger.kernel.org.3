Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CA7577F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiGRKKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGRKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:10:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75316EE1B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:10:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j1so11830059wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V0Up84QcSxidoOLER6+f0HHJOz7kslEDF3Bka2NBftY=;
        b=jVZ2q33IUhoiETY5C+ok3PsFxD0p9m2B2Vqf9Aq2bfjwzWYavSG5cuKIg1JtmVp09v
         pI0Z9plKrR7g9Oif1bNCSWqSWAc+dFncmx3HOCNUqi99Kd2iWYStCc/oyPH6Chr2IlYQ
         aOS7DToaDQ7PYERWfso2iuwqKSw9T854up6zJwxAQwPIGn2gurijbR+TqMMZmkz4u2oB
         6WIUIf9AU59MhuQkGtjcKzjZHBIkMvc5o+7bo1qIXM1SwlJPBjgBe5fINl6mvHqi0jGh
         Y2ARezUdE6uCVEGHQi/x0d5M91F98AdyHR47QjwzEnv2wm0wyAWKv5ayhT8+xoMl1i41
         Yb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V0Up84QcSxidoOLER6+f0HHJOz7kslEDF3Bka2NBftY=;
        b=Am+gTIeR1+/HKFghegBdc6aI/rAm81wIaejB5WLlnxc4pRr3mPgaE16PNhTqXXPYHB
         vHgCNHakgjg4LUYdngsio/Zi8j3Jl3jYRAv8L802Bo855U1fdnlKbbZQjKUaK1WfAS7b
         bEl4q6jEspdGaPq+hXwYnc6xm5+6RKSAGZ3IX07Qx/h3JQ86h8HnvMx0nilys6MhZzR6
         Bc3eOJbHjT64G5za5Y007FxAWsGZcwLd+vAOt9yDBh4ZNizwXXQZks4Hg/l1Mr39ZxxE
         I5qgstVZcEqRY9jroNstsFh4DVaZkUFepEcjL0VojHd+iCyA/DzqEYK4xMiezojmtdKq
         TioA==
X-Gm-Message-State: AJIora/W4UcJlvo8P/ud63tGAtrSWdqc3/iPfq6aDwV/UByN78eGwIK7
        coX3fMoQnBl1lUCd/4RB7fB0Fg==
X-Google-Smtp-Source: AGRyM1vye9FdKpzNyDN73lxjv/5FP4i0RATVh5IDQLmILpyIEgvMXve2IqwEKG56GPBT8x7ENSPZZg==
X-Received: by 2002:a5d:6d0e:0:b0:21d:6d4c:e0e4 with SMTP id e14-20020a5d6d0e000000b0021d6d4ce0e4mr23052805wrq.355.1658139010992;
        Mon, 18 Jul 2022 03:10:10 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc30f000000b0039c54bb28f2sm14489511wmj.36.2022.07.18.03.10.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:10:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] ovl: Handle ENOSYS when fileattr support is missing in
 lower/upper fs
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
Date:   Mon, 18 Jul 2022 12:10:09 +0200
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com>
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 18.07.2022 um 11:14 schrieb Miklos Szeredi <miklos@szeredi.hu>:
>=20
> On Mon, 4 Jul 2022 at 20:36, Christian Kohlsch=C3=BCtter
> <christian@kohlschutter.com> wrote:
>>=20
>> overlayfs may fail to complete updates when a filesystem lacks
>> fileattr/xattr syscall support and responds with an ENOSYS error =
code,
>> resulting in an unexpected "Function not implemented" error.
>=20
> Issue seems to be with fuse: nothing should be returning ENOSYS to
> userspace except the syscall lookup code itself.  ENOSYS means that
> the syscall does not exist.
>=20
> Fuse uses ENOSYS in the protocol to indicate that the filesystem does
> not support that operation, but that's not the value that the
> filesystem should be returning to userspace.
>=20
> The getxattr/setxattr implementations already translate ENOSYS to
> EOPNOTSUPP, but ioctl doesn't.
>=20
> The attached patch (untested) should do this.   Can you please give it =
a try?
>=20
> Thanks,
> Miklos
> <fuse-ioctl-translate-enosys.patch>

Yes, that change basically has the same effect for the demo use case,.

However: it will change (and potentially) break assumptions in user =
space. We should never break user space.

Example: lsattr /test/lower
Currently, fuse returns ENOSYS, e.g.
> lsattr: reading ./lost+found: Function not implemented
With your change, it would return ENOTTY
> lsattr: reading ./lost+found: Not a tty


I also tried the setup (without patches) on a very old 4.4.176 system, =
and everything works fine. ovl introduced the regression, so it should =
also be fixed there.
It may affect other filing systems as well (I see some other fs also =
return ENOSYS on occasion).

It's safe to say that adding the ENOSYS to the ovl code is probably the =
best move. Besides, you already have a workaround for ntfs-3g there as =
well.

Best,
Christian

