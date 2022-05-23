Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C35531A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiEWTnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiEWTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:41:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D2B1084
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:35:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gi33so22450920ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LW25NSTQI4crBK2YwHHSQC3zzTXMP62tjU83/8uLCds=;
        b=UEFeXxCNbRpI46/QElKf5Oc+lGtL2Zq8b580qymrLS2hT1gN2x2k4YLnGaHhIflRda
         FTlC2aJa+Wf5tTV15adNd+RSH+3YiKMkzFSSFPLIjn0WHXuB8jmS+5Z0A7qT0dDpCM09
         9dtVDguxK+rz77qtO/pQkWy7NzRnvT6pLcNKCOYlSZxkU/FYbFHQXJiWxGWSUpCED+L0
         7DBFrie6eD34D34RZ8x+KAOfnOSfWHdtmvzRB46q7Giek85VU9jS8CrqNbWDNnO1qkGq
         hNWHt+E9Cdy+aL9nAdW54T7kWSFU3JZKfHOZ8r7OOx56cqxzfKT/EQznLJ041nE+cu7G
         Pl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LW25NSTQI4crBK2YwHHSQC3zzTXMP62tjU83/8uLCds=;
        b=x8KclGb+lamkVy8vujIssSylBpjkhRfLK0OTCHuCrSZHihXLGPNhPIyeDaBMB5/LWZ
         n1i3rs7K2fIH4U65AxWP/sQq3FeK2GV0r1li5lP4MreoSx0rEN0HuDpvU2pdbD/bQL+y
         R0rg+KxFOJFAwiPEAGjsO0SA2tDCxgbGFYz+/2krMw4CAJ4rJ9bTrWbHbsXikEOHGoTE
         cKg5TVpj+/pQtWc30ZENOiARwP4b1eOxuCbdhkM6uCpqMbrNnWGm2I4uISyq83gNlOis
         oOt7vCUQ9pQ/F+4CAGauOFKdBk/yozIKIPIkM/qN8a/XVnEPlc9/YAHfrWH69+lpY+Bo
         2UrA==
X-Gm-Message-State: AOAM5303cGq1WPdUxmzow3XAlHdGFOzgiQdfTwHdJvPcNVLP7KoHLv9E
        ycPb58xVQsNb68T2jQl5U0H3kV9NZYODLdEfArhCrzw7
X-Google-Smtp-Source: ABdhPJz/ho+Kaa4avSAR0bfqhdwldrIQfb0oR6uTFN8xWIOnG1xNe6bXn+MeClR+DbyZjaxZRIC1KOlwhMPdT4CTA0A=
X-Received: by 2002:a17:906:7f89:b0:6fe:8e6b:f16c with SMTP id
 f9-20020a1709067f8900b006fe8e6bf16cmr20874969ejr.390.1653334552777; Mon, 23
 May 2022 12:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220331070115.29421-1-bjorn.ardo@axis.com> <CABb+yY1zrHYLBjY_EoC7bkTsWcKOhzCjp-5vgvqP0HEAJicdXQ@mail.gmail.com>
 <c4aa28b2-5550-ed39-3869-556b451ff54b@axis.com> <CABb+yY1BNsdMq7CNOBDk3sn7uvpL4=-fT7eOcbuL-+Yjz+iqHw@mail.gmail.com>
 <487bbd00-d763-0a86-9984-1dfd957fbb38@axis.com> <e3abb8c0-a42c-4eea-993e-3c8fcce0ae64@axis.com>
In-Reply-To: <e3abb8c0-a42c-4eea-993e-3c8fcce0ae64@axis.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 23 May 2022 14:35:41 -0500
Message-ID: <CABb+yY2EXGFK-ayV=-VRmEv5YFQWO5X+Xu2=mgcVegkx8MDogg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: forward the hrtimer if not queued and under a lock
To:     Bjorn Ardo <bjorn.ardo@axis.com>
Cc:     kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, May 23, 2022 at 6:56 AM Bjorn Ardo <bjorn.ardo@axis.com> wrote:
>
> Hi again,
>
>
> On 4/20/22 10:28, Bjorn Ardo wrote:
> >
> >
> > Our current solution are using 4 different mailbox channels
> > asynchronously. The code is part of a larger system, but I can put
> > down some time and try and extract the relevant parts if you still
> > think this is a client issue? But with my current understanding of the
> > code, the race between msg_submit() and txdone_hrtimer() is quite
> > clear, and with my proposed patch that removes this race we have be
> > able to run for very long time without any problems (that is several
> > days). Without the fix we get the race after 5-10 min.
> >
> >
> >
>
> I do not know if you have had any time to review my comments yet, but we
> have created some examples to trigger the error.
>
Thanks, but your last explanation was enough. The logic seems fine.
I was hoping someone impacted by the commit may chime in with a tested/acke=
d by.
I think I'll pick it up now.

Thanks.




>
> With the attached testmodule mailbox-loadtest.c I can trigger the error
> by attaching it to the two sides of an mailbox with the following
> devicetree code:
>
>          mboxtest1 {
>                  compatible =3D "mailbox-loadtest";
>                  mbox-names =3D "ping", "pong";
>                  mboxes =3D <&mbox_loop_pri 0 &mbox_loop_pri 1>;
>          };
>
>          mboxtest2 {
>                  compatible =3D "mailbox-loadtest";
>                  mbox-names =3D "pong", "ping";
>                  mboxes =3D <&mbox_loop_scd 0 &mbox_loop_scd 1>;
>          };
>
>
> After that I create load on the mailbox by running (or respectively
> system) the following:
>
> while echo 1 > /sys/kernel/debug/mboxtest1/ping ; do
> usleep 1
> done
>
> while echo 1 > /sys/kernel/debug/mboxtest2/ping ; do
> usleep 50000
> done
>
> After a few minutes (normally 2-5) I get errors.
>
>
> Using the patch I sent earlier the errors goes away.
>
>
> We also have created a mailbox-loopback.c that is a loopback mailbox
> that can be used on the same system (to make testing easier on systems
> that does not have a hardware mailbox), it is also attached. This can be
> probed by the following devicetree code:
>
>          mbox_loop_pri: mailbox_loop_pri {
>                  compatible =3D "mailbox-loopback";
>                  #mbox-cells =3D <1>;
>                  side =3D <0>;
>          };
>          mbox_loop_scd: mailbox_loop_scd {
>                  compatible =3D "mailbox-loopback";
>                  #mbox-cells =3D <1>;
>                  side =3D <1>;
>          };
>
> And with this loopback mailbox we have also been able to reproduce the
> errors without the patch applied.
>
>
> Best Regards,
>
> Bj=C3=B6rn
>
