Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0A65AE502
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiIFKHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiIFKHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:07:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376123BF4;
        Tue,  6 Sep 2022 03:07:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b19so11701103ljf.8;
        Tue, 06 Sep 2022 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VkmV4Mbbakibw1YvOFS3OF9fAcQ2su7P2rixwdKsjEY=;
        b=q3V5/J5f7c4axYAYccSfJ3we12lZbBEBnYkWxbyb5cml0xXtlNPfKOHvP3jYJjp7Pf
         t7mxomOPI12/IWn8CmvRjtNIexK8awZXBXvs+n8l52BHJqyvUeyRvE8SqSKWiQ9+8S87
         6WNp3T4oK3JO+BjhdFxR3OLoFsyi1+K8IY0ccDzdVUso8mfEDdnFWH6M5aeJ2xr9WXJT
         /XVXKdW3jeB/Vuw5/XW6hMg+MJt34GyFaOwhEuNmba4J6JclQ7OSfUpdJADQ+OjqTG6w
         OeDhyaXQN2stl2aEVoxl0UOeZ7TNuHoxj5Gbkeo0v7Jlb3uLhGOBtLSQIZ6a4+8FrQoa
         8xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VkmV4Mbbakibw1YvOFS3OF9fAcQ2su7P2rixwdKsjEY=;
        b=XjrSb4WTdmb5fs6+duP7mfbWiEnXpXcplejI2gJB1+e2T25qNkQQEKYsiyksKzANKe
         zbekg/VXCO2m3BvA63c+yFAcVGJ2EkUHLBtrCokngefsSbLYVIRB0bze4IB/A0l5f0V1
         9PcOvhWXzOO9f/4d9ZGEd6vGQcUEJuuYrRQ80QWN3nBzkJ8QUOias4B4Qc8LZrBJ5WIs
         Yx7Qj/5P/sActJwCvo8MYbH3mbbYWCrCu/l535lpF1ql6saK/l3GNaV2a6bz9MVkd0Go
         sFL1UwWgVRUGAb0hKVze8e2+zZ4z15UFYNFFLL/XBB/c8wxW1YZ7mdpkOIl0NtpmkLGW
         C6Xg==
X-Gm-Message-State: ACgBeo05yVS5GMcm3RY9JyL+JzyJMvIgfx1tvhfHItFtd/j5mWeiRyp+
        zcFJp8sxBlFx0+L5D5RbTc11ktJC2GDlHQ==
X-Google-Smtp-Source: AA6agR65QbEfb31NvTuL5YMee3ygqPMXMYaDRosDOXZNcMOpmKgIPQC1Xex1ZykSacZcnv9DKGSjbw==
X-Received: by 2002:a05:651c:2205:b0:25f:dda5:1e65 with SMTP id y5-20020a05651c220500b0025fdda51e65mr17074691ljq.240.1662458862279;
        Tue, 06 Sep 2022 03:07:42 -0700 (PDT)
Received: from ubuntu.armcompdev.pub.tds.tieto.com ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id c16-20020ac25f70000000b00492e10b1723sm1640514lfc.139.2022.09.06.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:07:41 -0700 (PDT)
Date:   Tue, 6 Sep 2022 10:07:35 +0000
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of/fdt: Don't calculate initrd_start from the DT if
 'linux,initrd-end' is 0
Message-ID: <20220906100735.7a226942@ubuntu.armcompdev.pub.tds.tieto.com>
In-Reply-To: <20220830153500.49206b5a@ubuntu.armcompdev.pub.tds.tieto.com>
References: <20220826220017.188066-1-marek.bykowski@gmail.com>
        <CAL_JsqKGgZOSdWQ2ithipvrRAYwt-vOL1z9-RM++-_h6pA=C_Q@mail.gmail.com>
        <20220830153500.49206b5a@ubuntu.armcompdev.pub.tds.tieto.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 15:35:00 +0000
Marek Bykowski <marek.bykowski@gmail.com> wrote:

> On Sun, 28 Aug 2022 20:12:41 -0500
> Rob Herring <robh+dt@kernel.org> wrote:
> 
> > 
> > Shouldn't we just check that start < end?
> > 
> > Can we check this somewhere not DT specific (and also not arch
> > specific)? Then we don't have to worry if any other method of
> > setting initrd could have the same error.
> 
> Yes, we can switch from checking on the end being 0 to that proposed:
> - if (!end)
> -     return;
> + if (start >= end)
> +     return;
> 
> Then the check would even go further as would also catch cases where
> end < start.
> 
> My taking is early_init_dt_scan_chosen() that sets initrd size
> incorrectly is DT specific but generic/arch agnostic. So that if
> the error got introduced by a bootloader/U-Boot through the DT
> chosen node, we should catch it in DT and react.
> 
> ARM64, for example, before going down for mapping for the incorrect
> address (some extra large address resulting from the negative to
> positive value conversion), has a check after DT parsing if
> phys_initrd_size is other than 0 to proceed, and it is so that it
> passes or in other words it doesn't catch the error.
> 
> Marek

Hello Rob and others,

Any updates on it?

Marek
