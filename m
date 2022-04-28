Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ECB512C35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiD1HII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244758AbiD1HIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:08:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38E198F50;
        Thu, 28 Apr 2022 00:04:52 -0700 (PDT)
Received: from mail-yb1-f182.google.com ([209.85.219.182]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N0WPK-1o7FkU34K4-00wX9v; Thu, 28 Apr 2022 09:04:50 +0200
Received: by mail-yb1-f182.google.com with SMTP id y2so7372840ybi.7;
        Thu, 28 Apr 2022 00:04:50 -0700 (PDT)
X-Gm-Message-State: AOAM530vjkLCXyIvoodzRGwear/VE6c7tM7g9B3NAhLZfPZ6JoKPA+xk
        qCgzEPALvV2UsJvvCM+sj0IbSkxy+RaLQCTdyhQ=
X-Google-Smtp-Source: ABdhPJxPFdoAK53KrDUJDvXZZBNItrxVRstFggJZqPSzN1hTf5QMiOJMiJirNLjAI0bMczN8kVmmcLMEGUTHnXYsKxk=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr29428750ybx.472.1651129489342; Thu, 28
 Apr 2022 00:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com> <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
 <20220408133246.fyw5554lgli4olvg@maple.lan> <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
 <YlBE6hZHmLo9/wrU@kroah.com> <CAK8P3a3v4+AO5avGoxeZSyNTOWqk8YS95xQLWSBZ=yV_3DKggg@mail.gmail.com>
 <20220408150202.yhn3qppqwm7wzmo3@maple.lan> <OSZPR01MB7050BE18BC9E8DA05C00F478EBF29@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <OSZPR01MB70504BD8347355EB51F7CCB8EBFD9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB70504BD8347355EB51F7CCB8EBFD9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Apr 2022 09:04:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2aHBxRJbOcXBGM7gjAqpErBAeaG3NmfgBTn4TNYscSgw@mail.gmail.com>
Message-ID: <CAK8P3a2aHBxRJbOcXBGM7gjAqpErBAeaG3NmfgBTn4TNYscSgw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
To:     "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Travis <mike.travis@hpe.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eIi0QbvKv2J0kpPkGcSMwAc+VFulHu30u8L3LD5xEyxQRXD4+MR
 yMm0vea/KEYXxg8xMkBqgukd81d0BPir5c6lTNko7Wcv07wAopU0JZKjTwula3N1XlGIrNa
 U1rrhzfPBh1C16f51QH+cYVVBKYOlhqDhZYt9xWbbvG2Y6F3hWu6fnChuXvtPLFYLDHhHwv
 gIrZkdC/zxsi6ePsBQMug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+xxvt5P/Pug=:ZGNlrUHFBRGNMS8HB1c/gy
 taDKegWhqm0r641SGlzyJnXOlW30bB/OwjM2W2dkUSfdGK2r1nKdNcR7aOV0DSjNmlQqf0lu9
 BMLWpia4NUlHYOJ6ttmjkNgDylDgww9ISZZ9nVu4SIHDI6NCajAehT+/DisUz16Uba8bhVdjL
 GnK2ZBXiI66zfHnBJBxEbpeb9g1MCuVOElAD+FtiZnvISvryRDJtEn+dpT01zgqQA4thPLdHy
 b8NdSQzQCRGV8SfTFIEU76Buw/PPvdACEYRbXYa2IDOSm9nRiCFUZYKvoUEWE63iunNiXalUe
 M3bDyKf5hZxs0i/oNCtHeQMdKVIZuOTViiVqhGIKcUgxm4Aspl4rv312IplmmCpJyumX1yjTP
 TPxA52LoMoPazBlyL3/6K2Jkfm/fcNQaMdHUI3OuFWRTCUzKe5BUMEkdubr9xiqAahblyJd0F
 datbraVHPGh7g3zyci9Prw9ZoBKnv2p2jP54TatuCd4iFs4Jb3G3VZJhla5A1tIu6Ku5AEh4q
 18Q6x0v2gOKqMZQliAlJf2XUQ3wtvwYUnjVzYxO85Nl249KaP+YVJr6HANtEiNCmwsFQTYcT5
 srtcPKBavApU8swqK8pZJNKtc8zKTiab8NiQAlX76rylUY9lg9JfWLIa+SfsmGFYEQ9TbuICx
 DfSQLU93sB/Rnm6eswu5588BTxunVdFRMp3uFSMsUVNYxRzUoSzQb7R3fW3Rg/jdBuHgnm97e
 axjkTI/nlo03qpDmbUha3qo9f9y2944+qO9Vwti45XF6qKuaOxe1W6ODfHTN1mpRAxRESAvsx
 f/O9YIscOif2N7B7bADg6p7XB7pDoaAMgshs7WuE/LqeJ2riAM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 4:15 AM hasegawa-hitomi@fujitsu.com
<hasegawa-hitomi@fujitsu.com> wrote:
>
> Hi Greg, Arnd, and Daniel,
>
> > I understand that it is not appropriate to hardcode c.
> > How about using __setup() to add a new kernel parameter and allow the admin
> > to specify the sysrq command when booting?
>
> I have received a lot of advice regarding sysrq, but after some consideration,
> I would like to change to calling panic() directly as in v1 instead of sysrq.
>
> If the administrator wants to request a diagnostic, I think they usually
> expect crash with NMI like x86 and take a dump the kernel. It's not common
> to handle diagnostic interrupts with sysrq now, so I don't think
> it's necessary to make this driver extensible at this time.

Ok, fair enough. Matching x86 behavior sounds like a reasonable outcome.
If we want to make this configurable in the future, that can still be done then,
and it should work the same across architectures but adding the logic
in nmi_panic() directly.

        Arnd
