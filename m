Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5288D578B90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiGRUNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiGRUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:13:05 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84F29C9D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:13:04 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id n16-20020a4a9550000000b0043568f1343bso2508825ooi.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b12VQvmMnRuczR7vsiOnnqJ9IYxQ2j6Uskl9KHtzH74=;
        b=ED5cPuZ5ZpUK4tIyvYn/KsjabfMdhC+COgAFRv1mZ0FJmr3Q/Qgmo9ZTWJsnP9e64x
         7BF/LnVuT8/ejVu2S4VUR5xIwDQTdubjq8suLiSGCSj/ZaguEk1VO5rkUzkHipGnqMXb
         nZcvvXrjh9eSXZh4Jn38YXKmpUKVdrstPJhGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b12VQvmMnRuczR7vsiOnnqJ9IYxQ2j6Uskl9KHtzH74=;
        b=wwd1tiDJgyVHUsfD6XBxqhIH8AT5uD+QpJU2V5EkjbNHi14KRFC2PVU30X/7vRhkxE
         3rBADYBKcAl4MXXVPHz5uFpmRIILt+h9Ig9TWM4TqLzwy5MYa9YAj3HxLUJHrsUZMT6Q
         4XmAdet9S2xLt29dHYwCcsS63/33FuFXbeZYK788ku1mqlrk2/lzdYbKlWBIRpUlrUfg
         Akh5DbOdLIcXFDqmCFBEKlzXXaaB1PNfJ0dUOb0Ub9IIeQWkwNmDJMX2bp65g1gHYisH
         xlwZ/8+2vLJwuH4uS/jtNb1Tppba06Md4Q0Zy6AomYodZsIRfshgDdcit0UlJEIxiTGn
         1B3g==
X-Gm-Message-State: AJIora9VlUfdUOdjoZGrwpPiA22JWYMeKi/v9KDVj8Vs8Bo7HBcQtSkm
        Oebb1lw5xOzHAG13QS8KsWfYbLsP5HwPiNmza0rZ3A==
X-Google-Smtp-Source: AGRyM1tcrQ1+dkTysyokYiSJtQRvDLcR87Wjh4u4AM+2MPXR3BrEGpOhmPS3mjfwt+U8y6s880h50g==
X-Received: by 2002:a4a:d552:0:b0:435:81c5:43ab with SMTP id q18-20020a4ad552000000b0043581c543abmr5647458oos.9.1658175184016;
        Mon, 18 Jul 2022 13:13:04 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id w7-20020a056870a2c700b000f342d078fasm6680644oak.52.2022.07.18.13.13.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 13:13:03 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-f2a4c51c45so26794280fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:13:03 -0700 (PDT)
X-Received: by 2002:a05:6870:c1c1:b0:ee:5c83:7be7 with SMTP id
 i1-20020a056870c1c100b000ee5c837be7mr15568709oad.53.1658175183146; Mon, 18
 Jul 2022 13:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
 <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com> <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
 <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
In-Reply-To: <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 13:12:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
Message-ID: <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:28 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> So this is a bug in the kernel part of fuse, that doesn't catch and
> convert ENOSYS in case of the ioctl request.

Ahh, even better. No need to worry about external issues.

            Linus
