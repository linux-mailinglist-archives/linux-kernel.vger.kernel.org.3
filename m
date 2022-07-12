Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A7570F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiGLBVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGLBVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:21:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9761104;
        Mon, 11 Jul 2022 18:21:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p9so6279615pjd.3;
        Mon, 11 Jul 2022 18:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=TN/xzFsKJy/KrR3D1bB3jSCuV37Mh0yoh89Gfy+4Y04=;
        b=UuJ2ptTFwc5KV/f4BkJflvNQ2QS1YdV2qiGZM7RgpNhPHKkIKWbXr1x5anUVPj5DDQ
         5Lue1kQOrq9qDQDj/5OaOZW8/OLJym0ZNtsrbQ2CfUeRTj8E+wZFxF3W2uTfJd8lJdBE
         xa4qcKzU22Shu1Hdy/PcRGeSnAdL6JKgQuqcq6bGJVBJYaivikCE8O+4m27QPGD8NAZD
         CeBIEOqRLu9Z8dWqy6HprKt4alxHEYQHdamwxNjGuhNHicXpf214GdT4f1WHDAgfguEw
         MHCh49H4UFR89TSYfj6v+I7y+vz9q6UrIiui1NsrUzDrsjGX1oDYLId9lg5DgCAvmWlS
         Pcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=TN/xzFsKJy/KrR3D1bB3jSCuV37Mh0yoh89Gfy+4Y04=;
        b=jaATFFnx3ZWsAwhL0q2Yt1Y1wCn34fB7N/XB7QJ1zy07oo7C6F0OZIPXPlWYluBJZK
         7zKrQVU5eQ416kUfH7xTcDZvTo3DfJzMOSVCb1r643c+2pYpmrwPWhpv3d8HgWU3i8Mq
         yv74gxpyD/l/l+uSUk90iiWeX/h9OD0NChSULqhCJW7Kt602FV4dkvM+KnWxMXLZRFmY
         aIYttDSGZ5LvTW6fKU4hW2BiZIUKWNTJTIY75qnhNSNFrMjshhmNd8pjVnngFFuJT7ic
         PxXfjOkiSYXgQeEWSO16Leg7K4+3yti7wuXuP5KXR+s1/+lkwlhljbuYlxecvwB3RmXD
         EZ5g==
X-Gm-Message-State: AJIora+rKhLgfQ/1q6m8K4HxORpnjs0FQDdH697QqreC5/kI646RQsdp
        EAavwDxO0ybisUJuj5EQW6w=
X-Google-Smtp-Source: AGRyM1tRDSd4sEIVkkqteP1eS3o3wUOq1DPBZg07rmodSbbB85Hz/iemYQ7Yn+uxpJG/4+1oHjSFAQ==
X-Received: by 2002:a17:902:b488:b0:16a:7013:69f0 with SMTP id y8-20020a170902b48800b0016a701369f0mr21803286plr.118.1657588878144;
        Mon, 11 Jul 2022 18:21:18 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0016bdee4f24asm5412708plg.48.2022.07.11.18.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:21:17 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:21:12 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/4] Extending NMI watchdog during LPM
To:     benh@kernel.crashing.org, haren@linux.vnet.ibm.com,
        Laurent Dufour <ldufour@linux.ibm.com>, linux@roeck-us.net,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, paulus@samba.org,
        wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
In-Reply-To: <20220627135347.32624-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1657587920.49l4tue93d.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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

Excerpts from Laurent Dufour's message of June 27, 2022 11:53 pm:
> When a partition is transferred, once it arrives at the destination node,
> the partition is active but much of its memory must be transferred from t=
he
> start node.
>=20
> It depends on the activity in the partition, but the more CPU the partiti=
on
> has, the more memory to be transferred is likely to be. This causes laten=
cy
> when accessing pages that need to be transferred, and often, for large
> partitions, it triggers the NMI watchdog.

Importantly, it can require page in of code that runs with irqs=20
disabled, which is unlike a guest normally runs under PowerVM
(but it can under KVM) which is why we enabled the watchdog under
PowerVM but not KVM. So, okay it makes sense to mak an exception
for this case.

Thanks,
Nick

> The NMI watchdog causes the CPU stack to dump where it appears to be
> stuck. In this case, it does not bring much information since it can happ=
en
> during any memory access of the kernel.
>=20
> In addition, the NMI interrupt mechanism is not secure and can generate a
> dump system in the event that the interruption is taken while MSR[RI]=3D0=
.
>=20
> Depending on the LPAR size and load, it may be interesting to extend the
> NMI watchdog timer during the LPM.
>=20
> That's configurable through sysctl with the new introduced variable
> (specific to powerpc) nmi_watchdog_factor. This value represents the
> percentage added to watchdog_tresh to set the NMI watchdog timeout during=
 a
> LPM.
>=20
> Changes in v3:
>  - don't export watchdog_mutex
>  - fix a comment in mobilty.c, wait_for_vasi_session_completed()
>  - fix a build issue when !CONFIG_PPC_WATCHDOG
>  - rework some printk and rename the sysctl variable.
>=20
> v2:
> https://lore.kernel.org/all/20220614135414.37746-1-ldufour@linux.ibm.com/
>=20
> Laurent Dufour (4):
>   powerpc/mobility: wait for memory transfer to complete
>   watchdog: export lockup_detector_reconfigure
>   powerpc/watchdog: introduce a NMI watchdog's factor
>   pseries/mobility: set NMI watchdog factor during LPM
>=20
>  Documentation/admin-guide/sysctl/kernel.rst | 12 +++
>  arch/powerpc/include/asm/nmi.h              |  2 +
>  arch/powerpc/kernel/watchdog.c              | 21 ++++-
>  arch/powerpc/platforms/pseries/mobility.c   | 85 ++++++++++++++++++++-
>  include/linux/nmi.h                         |  2 +
>  kernel/watchdog.c                           | 21 +++--
>  6 files changed, 135 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.36.1
>=20
>=20
