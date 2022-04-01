Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB14EEEDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbiDAOKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbiDAOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:10:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93495E76F;
        Fri,  1 Apr 2022 07:08:28 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1pfy-1ncUs63R2u-002CaI; Fri, 01 Apr 2022 16:08:26 +0200
Received: by mail-wr1-f53.google.com with SMTP id u16so4455159wru.4;
        Fri, 01 Apr 2022 07:08:26 -0700 (PDT)
X-Gm-Message-State: AOAM53308P+I1g1RVY6Dxv2b/ayNNmdXiS+6XHPE2J/allHD5v7hICcQ
        5NgaMMfA2accpEcQE2rslZ9SOg7OMKGBRma6b64=
X-Google-Smtp-Source: ABdhPJzQDr+Ev2rOkNJ6HmiZl7h44p304n4e4eF9V8C/+5wOh6QPM5NAog2ZBHar+vrcy6HRg1QWm7dpliXLyiIf6l8=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr7757069wrw.12.1648822106460; Fri, 01
 Apr 2022 07:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
In-Reply-To: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Apr 2022 16:08:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2AMqSyUPFqMC=cytLqBAM2Ugo6f1tph5je1NCVS=DkcQ@mail.gmail.com>
Message-ID: <CAK8P3a2AMqSyUPFqMC=cytLqBAM2Ugo6f1tph5je1NCVS=DkcQ@mail.gmail.com>
Subject: Re: [PATCH] Add Altera hardware mutex driver
To:     niravkumar.l.rabara@intel.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:K8YBfl2zUyBcuoMXWgX0o5NYaEVhLB6LwnKUAY/ZgPB9bATmvPF
 QPiORRLw51+SKftTsJ6zBx9aXshKXORNoQPUJ18YsJfFySs6+g2hX5w+e64xn0L0784rMnA
 JsCXGewzZGeVozgDGiy+oEUkiX1YGXiON+gWSspCIRRqIi9yrFOFY9fOOm2cWlm9wBr3Qw9
 Q8roYLX3HPVCWf2ZfAw6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T4TYvQhVzGc=:58EK2y0QuIAJnj/gDPQUH5
 UvP5YlvoRkMWpCPK5177MN2uOgm+VAogjKbTNsPWoop30DmPXUellxp5Lr7iPBQZFXUVTFwKm
 0EAJqLQ40Cvwbs1Btv2BlMxL7X94FcFQe+ZkknNqIWxDEcrhpxsnXqyS3BeuQhiBNRkkljgXe
 mugxQfp9jBZAk1y/YYexh4Lw9sTIZStuQKXkf9DkxW9LhSRLfasXeUZ1/jgLUCBEwDJjmKFcq
 6cUsC3L8j51O5bw85GYVpD1XFUP4WgTGRsa+ZoZwgg3YrBUYp1M4QrRbpshFbtTv5PyEGbWek
 jleE//YNAQFiYT1gG0ZqMulaXGGFL8tgo9Px12nbYVcIFDYbKQCYgqXV+jMeL7YoE1Gfl8PyC
 sSp6bfkbIJQH7XTh37CCUshmnufxeJULq9FxaRWUvD+dAMdmX03hYujZk0jJ6rzPq4DM9CNxg
 nf5avgtQrV+FnIqOvDIkjgIzozJalFlzKdrg7EeIlQJ2OvIlIY/XqKg+OKRNNsPaLYr8Xn/U5
 hHeqNISaXL6F/ox5FgEu078maawOFMRyBzcnJ1fRv3qsjD8ESjGmverpsrHcfC96AM9n4Hn0+
 IxvPVfgHFClQ10KbWRrrMq3/1Vx5OAmuzyLCKXFsLVR0iO2XPP5quICL4Oihe4UscvYtwr4o8
 QkqdhD1upiDYVjPrCzI8pf/ELdq8SC3yDIJLNjUowHktDnuDXiomVp5DeLN11Se305FU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:49 PM <niravkumar.l.rabara@intel.com> wrote:
>
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>
> Altera hardware mutex soft IP provides hardware assistance for
> synchronization and mutual exclusion between processors in
> asymmetric/symmetric multiprocessing (AMP/SMP) system or
> multi processes/threads in uniprocessor system.
>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  .../bindings/misc/altera-hwmutex.yaml         |  47 +++
>  drivers/misc/Kconfig                          |   6 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/altera_hwmutex.c                 | 321 ++++++++++++++++++
>  include/linux/altera_hwmutex.h                |  42 +++

Why does this use a custom interface rather than the generic drivers/hwspinlock/
subsystem?

        Arnd
