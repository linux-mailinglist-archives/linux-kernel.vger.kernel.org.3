Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730E7523352
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbiEKMqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiEKMpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:45:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805560E9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:45:48 -0700 (PDT)
Received: from mail-yw1-f176.google.com ([209.85.128.176]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfHxt-1oGPQn1lSV-00gmH2 for <linux-kernel@vger.kernel.org>; Wed, 11 May
 2022 14:45:46 +0200
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ec42eae76bso19290347b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:45:46 -0700 (PDT)
X-Gm-Message-State: AOAM531pw4Yohh69kTGhSFC9Dp8dVUsb+EafmObVxvFp5Z0SRiuViWZu
        IfqMv00c1A2LTW43+HnIR0OBTmdeGhyG2gcNt88=
X-Google-Smtp-Source: ABdhPJx3Ihw5QbrjrUJNtEnDPy1YE8V5pGBK1eKDY9+khgcuFjVHkPcQYepldwk6qvTDv1OeLAY9J9sthBKYcvLYTfU=
X-Received: by 2002:a81:1697:0:b0:2fa:32f9:78c8 with SMTP id
 145-20020a811697000000b002fa32f978c8mr24808585yww.135.1652273145231; Wed, 11
 May 2022 05:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220506192957.24889-1-nick.hawkins@hpe.com> <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com> <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
 <20220510141124.GB28104@willie-the-truck> <PH0PR84MB171830414ADC0DD69BD4116788C89@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB171830414ADC0DD69BD4116788C89@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 May 2022 14:45:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1AG5RXW74LbskwMh1yJzXUjrzdL=iqaVz_7W2hExVuGw@mail.gmail.com>
Message-ID: <CAK8P3a1AG5RXW74LbskwMh1yJzXUjrzdL=iqaVz_7W2hExVuGw@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yrdzM//bITs5hQm7/2i0ucQko3AO17UBHIHsGVobMQ6loezfm/5
 KY+AM39OtSjmg2g3rRhDb5kevg8ZMsirZRnJTWbXcVu+NFMWM0FtVsWH4yswr5pZkyKbhAP
 Ljodherz3pn30NuzW7BnfgpAhR/TUZ2vLXg/VX7xHqBLAkEhRFA18FiUWQTJJzN26Cizum+
 YWR8Q+nEhCMIMRThsrIVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CX2RcqScdgU=:VDOXx2kH9Vxl6pscUv4XLv
 QSfBfk9kecU/iL3c4vtVIxREPeRHTzmmTVNH+hDuROmRabnVnfM9Wssmo8K8QYKKyIFfgFr97
 HbGNQGGVl9pr9lla/2eH9gjzKMA8Tu/2STzrkIHAzC7n3qF8/6IQyLeYIkDYgq1McN2T3SAO6
 OgOwr6WBhNprS3PliJxCeK3J1FkxG8YRi2AjYGzNDjFmNVRpLqcaZ3lNEuXQ4catQQKpaceSE
 Z31wp+COnnr4XDKwZ7YfsGThEI5jkHQIPS26Fh9aLIC52tuokx2ou35OjiDvA7GhB/2i8Xzs5
 ys5N+20lyLOK6rlDXXoe1oLfRNxUUz3svdPflip6vetQgFb1rpgOZe+gOcUnsm9nsIcxQZv1H
 Xz2FJwVgy4JqHGaMaeH33b3v26rTNly1nu9+HSelMgJTtLRYO82kvR6qLZICYtwU/r+jjfAFS
 msRVo8CUyisPqica6VXyvVwuuxqaJ8OBmxUlqGApd7RPD054hZgeM5oNp8uoFE9gevUn/el/e
 ZSWrtJRHdfG1tI0wQolzoh5YWUrz2FHwasiBhR+KNTKFrJJ6rp6SffdA6twACQ0WRBBPD6Jp7
 QhEXM0LkmaAW+Upc64ZDP9xxEkL5BQOgcwnkKyj99WsdxgkOR/ImuLxewz9XbPyY/oSu1FfFB
 F4zooS2Ynma4K2LRK+wttubkAtwJz2xo4mxiMGax9rreC4qWTfpvhc1qsHmNIXfjIFJs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 2:23 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> On Tue, May 10, 2022 at 03:01:26PM +0200, Arnd Bergmann wrote:
> > > On Tue, May 10, 2022 at 1:53 PM Verdun, Jean-Marie <verdun@hpe.com> wrote:
> > >
> > > I got a little lost trying to find where the breakpoint instruction
> > > comes from that gets trapped here, but I would guess that they had to
> > > do this using an undef_hook because the ex_table approach does not
> > > work there for some reason.
> > >
> > > I would still pick the ex_table method here if that works.
>
> > IIRC, the ex_table handlers are called only for data aborts and are intended to be used to handle cases where we take a fault on a memory access (e.g.
> translation fault). In this case, we're taking an undefined instruction exception on a cp14 access and so the undef_hook is the right thing to use.
>
> Given Will's input would you like me to still use the ex_table method?

If it doesn't work, then there is no point trying. You could try
changing the exception
handling so it searches the ex_table for Undefined Instruction
exceptions as well,
but that's probably more complicated.

       Arnd
