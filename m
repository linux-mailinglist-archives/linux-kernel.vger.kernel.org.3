Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067754EE27B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiCaUS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbiCaUS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:18:27 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372592405AA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:16:39 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q129so708775oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k0peIhnp5nrxzT0mki9dkE6JPfkhILZ3FZWvVw0XaFE=;
        b=JyEXVPV/Ldr2HhMUsiH1V8u0fxr+Em+jIleOKWHd2J6ZnmFcWYfbSgkHnyWPaFi3fh
         8OdZ+QzQuFpPKRZBVpT+Mco1upya8Qil0XQuHyO3QvT+TxPDHJpqvqCJHISXOBo1fFtV
         05fYKFcU35sdDrotr1pdQnvf1b7EkdCeFx+kFzObt6aKGJaY3TtER+qApYX5AWw/Yfw/
         xdqdc+rOnjVeHP/I0z6QNl99pUnQ6/k8Olux6M8RZxcalZZibJIa9LygCC+nz76eR2Bl
         jtlbXpL/NwOqgdS02miJRJLLVmSZ3ksxsupUqPXA9L2W/nE9ljPQICGd5ETSnXJzu+iZ
         ZFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k0peIhnp5nrxzT0mki9dkE6JPfkhILZ3FZWvVw0XaFE=;
        b=vSPpgfJJdhjZQPrlFIHZ1Hgf44lef1sJyfqIg+Bap8rvj3bfZbcQTvDSmnG3GHd/w9
         xsgfuzVIYFrbjGMsyeEdqv7sZK5D2+Fv3uHRuIMlYAmvhyB2Q9Hlibs41+M9fxJssj2x
         0JQwkH/GaM9VX9TgsNC30eqG5Pc9X/7whctolZ3s5OgjOFoKjpRuZL6mGWIHJmdNIgCy
         WwSgTPJ7xCydv6ECOcQLk31vmH74e1/HHM2v23b46SCwAjPzp4t6Wvy9+MuSxlG3HV+z
         aeDmxmk6YiOI5fyCVynqJ/FCloOprWTQLqRqwxfknm5p1sH1wps8AzToQTqe1P5ZhE2A
         EnTQ==
X-Gm-Message-State: AOAM5325rZbTIX383RTOotGUTWZ9kgOKOZltGthQVkLpXWnpqnBLsMzN
        eFaPZnwJHISUS/dS17MrmBK4BnXLzS+z27UuSdE=
X-Google-Smtp-Source: ABdhPJw6oTyqIIGq0k3E4uaf0BlQE3Wg0K0s/e/H3A1URFqlU4jF+x9EEplrSwa5vFzVYKV5jIiy/ZL7uJLtfCnzugI=
X-Received: by 2002:a05:6808:2223:b0:2d9:ca75:8ee8 with SMTP id
 bd35-20020a056808222300b002d9ca758ee8mr3538598oib.110.1648757799195; Thu, 31
 Mar 2022 13:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220331112416.GA1002@raspberrypi> <YkWnHbCA1v4nCSTl@shell.armlinux.org.uk>
In-Reply-To: <YkWnHbCA1v4nCSTl@shell.armlinux.org.uk>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Fri, 1 Apr 2022 05:16:29 +0900
Message-ID: <CADLLry7zKFaGUdZ473m1iJVE4NLppFNfOE-pXau5bB-RXFrGbg@mail.gmail.com>
Subject: Re: [PATCH v2] arm: kdump: add invalid input check for 'crashkernel=0'
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>,
        Paran Lee <p4ranlee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 3=EC=9B=94 31=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:05, =
Russell King (Oracle) <linux@armlinux.org.uk>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Thu, Mar 31, 2022 at 12:24:16PM +0100, Austin Kim wrote:
> > From: Austin Kim <austin.kim@lge.com>
> >
> > Add invalid input check expression when 'crashkernel=3D0' is specified
> > running kdump.
> >
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
>
> Thanks, this looks fine. Please send it to the patch system, link
> in my signature below. Thanks.

Will send it to the patch
system(https://www.armlinux.org.uk/developer/patches/),
thanks!

BR,
Austin Kim

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
