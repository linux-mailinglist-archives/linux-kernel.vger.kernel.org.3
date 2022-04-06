Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90B64F6974
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiDFS4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiDFSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:52:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346041B8FCB;
        Wed,  6 Apr 2022 11:36:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m12so4423393ljp.8;
        Wed, 06 Apr 2022 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTXXhBg+FTagJspmijIFe2Eoza61RgpH2nZKIaqAxBo=;
        b=m5KfhJDcvYaZq+SMyHRlozyi4aK9XzE9sGY198GkLb5v0PHpiaIk1+SFOo3D3yLQCT
         LGKZZjXZiWBSa+8vgBE3XjAeDeOVkwkIKVL6qT63eW1fsmC7nSik2rfsiG+m5j5bWIFV
         X5r6kO4k7AqSmfPO04I0epjb+8K1pdtxEir3HlPjfXNboaA3aUMpiPSn+FD4e8/2vzWn
         0Qg9oK/GyV5mvCAWVB2UEd261/NYvDuic1Aw258anORoZ34JXgQN6AD2BnXPozV71egt
         hsP3KxmrY98y+Eot9qn+ImfP+yIuXeq80iwWFCbCHEKc6CsQtwYOqihgP2hFCpPPcwGE
         pqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTXXhBg+FTagJspmijIFe2Eoza61RgpH2nZKIaqAxBo=;
        b=XSvIQ3lNS4cbaEhDLvRYzATRXqaIDNO3CKyDN2iHehJEu2BzQzYWgAKfHcAbpwQR1S
         7YEOF7e+L4QO1xKGVXsymZRAbE8A0A80WnM+plhWldJNN5mWpHIGOYX3SMdGinJDDB5U
         M+YlJI0QI6/YCX8MdToP5yqk4ZeusVxUnNu9DzOmj9vnW0yNibqdWceVFkT7s0nSOWp1
         KybZMxXm3j88ojS7SmkubVtLGUkzCxJOuStgD2Dswsy7H3DquX1gxL57T0JYTH028Nwa
         6/Ur93WBawWpKPnO5fDPGClcYPeh+MhjJtGFNwynYHY/ygt3ZxTR8G8sAkudXkq95AjD
         Ntuw==
X-Gm-Message-State: AOAM533kM1HnxGBnuz76gJuiNXV8odvNhhWrmLnXRfkr+XY1baH2GsY6
        0dmdl36IaDNA2DuOrzoyUyI=
X-Google-Smtp-Source: ABdhPJw7qDfUNjQQxm/7WkFnUA2kpGQV5Yz1O7JPZNHsIhiQxnUF4d7sPtt0/vvICgEyb+rAdyWSJg==
X-Received: by 2002:a2e:9e19:0:b0:247:deb7:cd9f with SMTP id e25-20020a2e9e19000000b00247deb7cd9fmr5998897ljk.261.1649270197298;
        Wed, 06 Apr 2022 11:36:37 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id t17-20020a192d51000000b0044a5a9960f9sm1907346lft.236.2022.04.06.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:36:35 -0700 (PDT)
Date:   Wed, 6 Apr 2022 21:36:34 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <20220406213634.104cae45@reki>
In-Reply-To: <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
References: <20220406092445.215288-1-mdevaev@gmail.com>
        <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
        <20220406195234.4f63cb4a@reki>
        <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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

=D0=92 Wed, 6 Apr 2022 13:51:40 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, Apr 06, 2022 at 07:52:34PM +0300, Maxim Devaev wrote:
> > > It's not clear to me how breaking I/O operations allows you to do a=20
> > > "force eject".  It seems that what you would need is something like=20
> > > fsg_store_file() that omits the curlun->prevent_medium_removal check.
> > > Interrupting a lengthy I/O operation doesn't really have anything to =
do=20
> > > with this. =20
> >=20
> > Perhaps I chose the wrong path, it's just how my userspace code works n=
ow.
> > If the drive is connected to a Linux host, then in order to clear
> > the "file" and extract the image, I sent a SIGUSR1 signal to the "file-=
storage"
> > thread. This interrupted long IO operations, reset curlun->prevent_medi=
um_removal
> > and I got the ability to extract. =20
>=20
> Oh, I see.  That's kind of an unintended side effect of not calling=20
> raise_exception().
>=20
> And while it does interrupt long I/O operations, it does so in=20
> non-sanctioned way.  To the host it will appear as though the gadget's=20
> firmware has crashed, since the gadget will stop sending or receiving=20
> data.  Eventually the host will time out and reset the gadget.
>=20
> Maybe that's the sort of thing you want, but I rather doubt it.

It's hard to say how it actually should work in case of force removing.
At least the currect approach with SIGUSR1 is really working on thousands
systems and with Linux, Mac and Windows. I believe that the criterion
of the experiment is quite important here. I know of several other utilities
that use SIGUSR1 for similar purposes.

> > Will masking the curlun->prevent_medium_removal flag be enough? =20
>=20
> I think so.  But it will be blocked to some extent by long-running I/O=20
> operations, because those operations acquire the filesem rw-semaphore=20
> for reading.
>=20
> More precisely, each individual command holds the rw-semaphore.  But the=
=20
> semaphore is dropped between commands, and a long-running I/O operation=20
> typically consists of many separate commands.  So the blocking may be=20
> acceptable.

It is very important for KVM-over-IP to be able to command "turn it off imm=
ediately".
In this context, I would prefer "break_io" rather than "allow_force_remove".

> > > You should not call send_sig_info() directly; instead call=20
> > > raise_exception().  It already does the work you need (including some=
=20
> > > things you left out). =20
> >=20
> > raise_exception() assumes the setting of a new state, and I did not wan=
t to do this,
> > since the same does not happen when throwing a signal from userspace. =
=20
>=20
> Userspace isn't supposed to send the USR1 signal, only the INT, TERM, or=
=20
> KILL signals.  USR1 is supposed to be reserved for the driver's internal=
=20
> use.  Unfortunately, AFAIK there's no way to allow the driver to send a=20
> signal to itself without also allowing the signal to be sent by=20
> userspace.  :-(

It's funny that you actually helped me solve my problem thanks to this undo=
cumented
behavior. If it were not for the ability to send a signal, I would not be a=
ble to make
the necessary code, and my software would always be waiting for the complet=
ion of IO.

So here I am grateful to you - I didn't have to patch the kernel a few year=
s ago,
and now I just want to turn it into a clear feature :)

Given the needs of the userspace code, maybe the suggested "break_io"
would be the best choice?

> And sending the signal _does_ set a new state, whether you intended to=20
> or not.  Although in this case, the new state is always the same as the=20
> old state, i.e., FSG_STATE_NORMAL.

So I could call raise_exception(fsg->common, FSG_STATE_NORMAL) instead of s=
ending
the signal from break_io handler. There will be a slight difference
in exception_req_tag and exception_arg, but it does not seem to cause any s=
ide effects.
Please correct me if I'm wrong.

