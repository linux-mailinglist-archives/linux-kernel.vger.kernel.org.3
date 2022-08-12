Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA0C5916B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiHLVYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHLVYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:24:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F8B275C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:24:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w19so4008093ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc;
        bh=6sLlVa5bv9fddso3aGZXeVZ815lIACQU4NMr1Arbw3I=;
        b=lEdQfwoArxfCfMAR18cTK/A5mRqpYXHouEGdAeFgaZHI5J+0clpLhoGdGjAV3iTOtY
         pI/d9J2GW9q06oUIU742rxvN0COvVArLEQfU00WEymfvyEYFWhCLLpDUevpr1yTrLPQg
         dYvD36O1VSE0SBj/iUEllEX8oLfVKDrj5XJxzVEBr7I2fbLYG6Xo7Q+IHXVPRg0r90ZR
         m+UPWB8qPo/Mp6HsDXvRIFwJ1Cdo3ULIa/++631BpCO2bmiWw18HCRktpM9Oznq2uuWT
         eVULc8Sm9tnqGhRfm7fvANvN/+RQqdVmvUAGbUQDZ7qwJUw5gz2pvsIIIR/3noHSGbDS
         JK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc;
        bh=6sLlVa5bv9fddso3aGZXeVZ815lIACQU4NMr1Arbw3I=;
        b=HDLlFzEQ0LUmMWMXrM9kSoGQZZEDPO0cD3NKxSnVl5VbjCGsZ2Cl65mTYgkFDOpsK2
         raWi7BR6NYqL3j3ceuK2TiE29Hr+QLyFepbZu4WAj8uW+Y/CVLQ/kxWjRfAUlJpjJj5y
         B8TcK74I1qJrzfS1jV0sFW5amZdbVUXigPo3Zxu6LZTOfbs++gX/RCLfq7tglB6qARQl
         3BOyCj7XNvOsxATJ8yYj8AVcwhOHAqaluhj83aRUhgRGGZuFutEcn+6gOh1b7UUH3Ycw
         7fHOiR5cWCSTY0NZE6VLXZMP0CUqemAkQ5OXS4az82BaJ/TD2ZGurqC96VYlro1QXKKm
         VTpQ==
X-Gm-Message-State: ACgBeo20J7oKEWb+QG+IIYXtvQY1ri0073y3P0Ww3GDZenngoW92OicM
        o0sIqWxrpMjS4p0vcDy5asnL7IjhGJA=
X-Google-Smtp-Source: AA6agR6FyVpEWJ9cff6A2kT9fDL3qtYQtOu1Nxl3xr2q87+yuRn8onOCdC3hdlK7y5iXl0qCa6rF3g==
X-Received: by 2002:a17:907:a068:b0:731:366a:6005 with SMTP id ia8-20020a170907a06800b00731366a6005mr3856039ejc.344.1660339452881;
        Fri, 12 Aug 2022 14:24:12 -0700 (PDT)
Received: from [192.168.11.137] (188-143-71-136.pool.digikabel.hu. [188.143.71.136])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b00730453877b1sm1176197ejc.217.2022.08.12.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:24:12 -0700 (PDT)
Message-ID: <4e478787ecbee62b8c2d420df895f5a8b531eb6b.camel@gmail.com>
Subject: Intel gpu memory corruption
From:   =?ISO-8859-1?Q?Baltaz=E1r?= Radics <baltazar.radics@gmail.com>
To:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Aug 2022 23:24:11 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

My laptop (ThinkPad T460) seems to have a memory corruption issue that
only occures when the gpu is in use (it has `Intel Corporation Skylake
GT2 [HD Graphics 520] (rev 07)` as reported by lspci).

I haven't been able to reproduce the corruption with standard memory
testing utilities like lenovo's builtin hardware diagnostic tool,
memtest86+, or even the user-space program memtester when it's the only
thing running.

However, running memtester alongside vkmark for example can reproduce
it quite consistently. It will always be a single address for a given
instance of memtester, but looking into /proc/[pid]/pagemap revealed
that seemingly it's always the same hardware address.

With this information, I think I managed to stop it from happening by
appending `memmap=3D4K$0x1F9D7C000` to my kernel commandline to stop that
address from being allocated. Since then I haven't been able to catch
it with memtester, but I did have a crash that kinda resembled the ones
I had earlier. Many processes segfaulted and I had some `Bad swap file
entry` errors in my dmesg.

I haven't been able to do testing on other OSes yet, but since none of
the regular memtests have found any issues, I'm fairly certain this is
not a hardware issue with my ram. Could still be a hardware issue with
the gpu itself, but for now I'm guessing this is a gpu driver bug.

Is there anything else I can test to confirm that this is i915's fault,
and if so, anything I can do to help track down the bug?

Thanks!
