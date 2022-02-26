Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E184C55B3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiBZLuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 06:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBZLuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 06:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8737026CD76
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 03:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645876200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucjDW47jJy5hMtO1zxvfxRH+AVlmUE0quU5++HXppF4=;
        b=VdqVe/vPXDOfbOPx2AMXqa3eHpuizTVw6ymhMFe8IzIkuXsboyzrIJxt7MYyf/oIoVBRIl
        kGZmc9zjEVqMWTVm5psHMTl5ha2BvfsYXO1UF8y05vhFuTWEjk4MafSxMDOVyBJDbU1+xL
        RFMUq2Xc9xF8DLw2xIsGBeUqozO2RdY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-3KxZ0qaPMMewvonsy7STlA-1; Sat, 26 Feb 2022 06:49:58 -0500
X-MC-Unique: 3KxZ0qaPMMewvonsy7STlA-1
Received: by mail-lj1-f200.google.com with SMTP id q21-20020a2eb4b5000000b002463ddac45bso3545855ljm.19
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 03:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucjDW47jJy5hMtO1zxvfxRH+AVlmUE0quU5++HXppF4=;
        b=FZ+SW9a75bzVmtpxySDQNx2wBBnC2vcTCk8MGz5HnOolQ5PeKLdLJWspSh1hFkxikz
         6Lir065jwsEaja1d33FAF7t/o6fGEaDiflyB5Vt7xiK/2Ws7v6lqafsCw4WD/Nn+vz1N
         Ro8ewiZ+s0lizPs66Zz+1QYqFmOO9PRaEsj2cikoPtQQ44IWQNznooKjq0wKL0Lng1b3
         xfehfB2q4Qk1cRqbINXXDRmqTszxaFu/ITodjDMjVgJooIbYsol4YfEleW14Lzh5kpYQ
         sk6644h4/us635Au22gZVBUzCLKdjk0q1of/vGfIAxM1JcfjLZvQ19wI/wvbg94pz0kW
         c6UQ==
X-Gm-Message-State: AOAM531jxiZSg1vpuyx+M27eyqiOVWiVNoXqtVffCracq9ZgeIhvoJL3
        3Z7tdtlKJwpSZj+AyisYOXgMlBXkbKoR0AVdj0BON5/M39aab2pYlW4orumePOJjci+DoWy+i5v
        o3JX9qEAjzNM+8TrywYD4sqVw9BsljUVvKFwgwr2m
X-Received: by 2002:a2e:504:0:b0:246:3a57:331f with SMTP id 4-20020a2e0504000000b002463a57331fmr8208579ljf.45.1645876197248;
        Sat, 26 Feb 2022 03:49:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwza/x0fQ5yla8LQ/Tpu7vra8WAQ8UBmHxTkAiVmx541AmlENjtMrnAlCLeMXobCd4OlzFAwHlKHlkeWgcGzPk=
X-Received: by 2002:a2e:504:0:b0:246:3a57:331f with SMTP id
 4-20020a2e0504000000b002463a57331fmr8208568ljf.45.1645876197033; Sat, 26 Feb
 2022 03:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20220224230035.36547137@gandalf.local.home> <Yhhh730RX1HpdXp2@google.com>
 <Yhhj9MLZTrhjSWUE@google.com> <20220225083209.24bafe2c@gandalf.local.home>
 <20220225084256.071dcf82@gandalf.local.home> <YhmOifZcbbxVHPr9@google.com>
In-Reply-To: <YhmOifZcbbxVHPr9@google.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Sat, 26 Feb 2022 08:49:45 -0300
Message-ID: <CAAq0SUkUAMyCoLt=n9X7+QH93zZ00ZpXNjG-gv7xUzL3YGtaPQ@mail.gmail.com>
Subject: Re: Strange output on the console
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Willy Tarreau <w@1wt.eu>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve and Sergey,

Could you please tell the serial controllers in your hardware?

On Fri, Feb 25, 2022 at 11:21 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/02/25 08:42), Steven Rostedt wrote:
> > On Fri, 25 Feb 2022 08:32:09 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Fri, 25 Feb 2022 14:07:00 +0900
> > > Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > >
> > > > > Steven, did you notice this recently?
> > > > > May I perhaps suggest git bisect? (sorry)
> > > >
> > > > On the off chance - do you have this revert in your kernel?
> > > >
> > > > commit 6a7b9f002eca6788d346c16a6ff0c218b41f8d1d
> > > > Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Date:   Wed Jan 26 14:33:58 2022 +0100
> > > >
> > > >     Revert "tty: serial: Use fifo in 8250 console driver"
> > > >
> > > >     This reverts commit 5021d709b31b8a14317998a33cbc78be0de9ab30.
> > > >
> > > >     The patch is still a bit buggy, and this breaks some other hardware
> > > >     types.  It needs to be resubmitted in a non-buggy way, and make sure the
> > > >     other hardware types also continue to work properly.
> > >
> > > My tree does not have this.
> > >
> > > I just applied it and I'm building now. I'll let you know if this fixes the
> > > issue or not.
> >
> > Mystery solved. Thanks Sergey!
>
> Awesome!
>

