Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7424A6C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiBBIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:05:46 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:58139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbiBBIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:05:44 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1HuU-1nCPUa14Sw-002l5x; Wed, 02 Feb 2022 09:05:42 +0100
Received: by mail-ot1-f41.google.com with SMTP id p3-20020a0568301d4300b005a7a702f921so1881272oth.9;
        Wed, 02 Feb 2022 00:05:41 -0800 (PST)
X-Gm-Message-State: AOAM533jjMFSzHIsvhi0uyFVWS01m4DLw8JRk823ct6KHCqZrIv9YhkD
        daeFxj4QPvBuMJFsOSQk30H4+rP4J7XPMDkAgM8=
X-Google-Smtp-Source: ABdhPJyPZ8Lnp/iDBwEf4uMCVPdD5GV2v9mZTZcRfjsPKSiXiBJWlV5tI1/aMflbb0I2FbZvbctmakWelMGNuVMKNe0=
X-Received: by 2002:a9d:73da:: with SMTP id m26mr16800935otk.72.1643789140692;
 Wed, 02 Feb 2022 00:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20220201150339.1028032-1-arnd@kernel.org> <90333cef-9ad1-bbf5-5c46-86083c1f5b24@arm.com>
 <YflyZytGG49kbvV9@shell.armlinux.org.uk> <CAK8P3a0jFMhtajAA9L6u56fbFRxBXhhsfMrfGisHdoP8qCFKMg@mail.gmail.com>
In-Reply-To: <CAK8P3a0jFMhtajAA9L6u56fbFRxBXhhsfMrfGisHdoP8qCFKMg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Feb 2022 09:05:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1cnQ=uJ84tGxfPi8km_qmOY9=iUuV1NKBqKevTAbWVCg@mail.gmail.com>
Message-ID: <CAK8P3a1cnQ=uJ84tGxfPi8km_qmOY9=iUuV1NKBqKevTAbWVCg@mail.gmail.com>
Subject: Re: [RFC] ARM: sa1100/assabet: move dmabounce hack to ohci driver
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kP/3agi1q1OA7Saq6/DrmaYaXFuhQIyH2bQgd+lGOoVLL24Tv/L
 lFKXPzFiy0d9sBHAFeo1Th7IYHw/LCwgt5jkSA86RxMxzZLUQHrItd6tGToIcLHh70F18js
 ulIhJPx/HQUoWIcKlEi2fLjB0I+BWnCtFVgpyEHhtHybLwzzRy7n7u7ZPhs6w++AoaSiBe6
 1GP+T7sRAEDFLoigbxrqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3lE2vQWWzZY=:ng6IiwUP9F2JiaP8V8T6r9
 9u/uBcDPvvE6ughJeCIqHNXBEWN8Isu93sBbW77OJVRGImRR/wx58lrhOj090EmBpLA7WVzUM
 7iQoqc1flavgcHRB6KJ85lhgk7PbuXtkmlRmkD8AFzz4cMhbxAyenmbK+1Z2RDQcFr9z1HgIk
 jKhM0XFElX6VyntIshft7bubtAFPrrOtZGxj582CgzXs2iyCkBh4r7lGy597wtK4zQaQro+VC
 kbLVD11A1PvHq+3g4zTf36lZX6igVFFv4gOKxk9MzgeVzK2CifYVCcMEoZZSpXx4ArruH697n
 bx81c9UO+jt7UF9WkGuO/NmFeAFrm+N6T65jm0FSwXxa+fCSZhF3YW+XXUCCOAbNOQccpLMhZ
 oYvEWXPGcwYreCMvtMbKwYOcFOs29GwyJfCbTVx0bPR04Fh3/2qjMWcKFD4prA6XYm9hEm6Cf
 t49GRmpEqx5xH2UvLC+wAgL2W9/7vdZbmTqsCYnbH8P3RmoWfUsEh/PyMbB8yLXeapslNJFCT
 9MDDQ6O+hbskv7UFtizk0E0cExiHIborsyotRtcw8F/1XF8Pbkbykzmc9//tfqWUjBPO9Ge0/
 T/9OCeh7C99tya/k0ZFJ/UwNKliihDGXLOyLhR+T5wlh1nMhmjjwS/kYEdTnqd5gO+FsiGfTH
 nn1Vr1NFv4ZS7va2+3G9LRpRxjItFhFF3piDAPFlswRzy4ll8S0Ta9N2nI/gRB2287Q6bG6IH
 rz35XNAxBVqkrWtzYKjWfLVwus49hU+quJLFhriG+qpJhYKEmXR87j4Owu7x0hm6mQuF1bJNe
 bpZdi0SqQif28uAPce+pBQoIU1a4txI3piGKPiJ13/NkHi/ap4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 12:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> while this part would not work if dma_alloc_flags() ends up getting
> memory that is not accessible. At the minimum I need to drop the
> machine_is_assabet() check and always allocate a safe buffer to
> back hcd->local_mem regardless of the machine.

I double-checked this to ensure we don't have to check for sa1100
vs pxa instead, and I found that all three sa1100 platforms with sa1111
(assabet/neponset, badge4, jornada720) enable DMA, but the one
pxa machine (lubbock) has the DMA mask set to 0 and won't
be able to use OHCI anyway.

       Arnd
