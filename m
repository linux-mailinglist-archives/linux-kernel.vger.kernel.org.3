Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5157D322
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiGUSRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGUSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:17:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC666EEB6;
        Thu, 21 Jul 2022 11:17:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u5so3423538wrm.4;
        Thu, 21 Jul 2022 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yxx1e89atLUMVwn1S4GxaEg7bWzejrusn7MtGiRpjkk=;
        b=altUeCfXn6znAXVOq+Xo/Ndd7+GQ7/rHphbh1JD8QMizp1uPvxUMF5DdFdLBHa7YBQ
         KSsleK/rQKWGlJixFMG+6WzvjvZ06KEohHjf9/2pliECBjNTPWXjHxbJ5IFlOpS+Z6Fw
         +mu+5HWwUWDi7sl+oXohhOLCquYePnijRRwCcQgTVqs0rWaTAazIa2gu3VXi1T00wS/t
         076aL7nFI3RDVEI1k5kmdXG5Gs1vhcmLRYYDDhT0U1vjs7+psJu2hUHyuY+b+UBBi/6s
         56W2cz0qLEdXTxYE/ZCHgdmjoDStI1WAuwAWWVEzPob80g9hSjpryRjr18OS6Ysvs7kR
         sNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yxx1e89atLUMVwn1S4GxaEg7bWzejrusn7MtGiRpjkk=;
        b=nzaKDcO72jbvFK2rkD4S4UUELHotRZkoI+hp0ekUbxery6EHLLsKCQhTNOpu8lxIpa
         CLoNqPSJXvztuVQxkSq4pbeGQFItLopSGkot8PXrYRHXz7O3WIa1GM4CGPIukdDT/zgt
         whlIYItIeSp+SXoI0d6HVyNJGGYBX+NYukTeKoz0n/FM0pOaZJRtip1ojiLHRYsQDXI8
         V2aL63T40Xe/gjD2itPHEdg2QAnsWF2wWeKS//0CYbNg6I0vlXVexFnoSB5y8NjweGxb
         TRBg/stkKmiERCWUQ07jWsLrZv7MSomNrrWKgALbMiiWSo1799BKzsw42D8pp7czKHtW
         8MNQ==
X-Gm-Message-State: AJIora/2736KNE8dWUwp2EHiqil3DGbrcaoUakUVwJwTNgAR70MxOSfE
        nBUZhEr/j7Vvto4uFRgmwC4=
X-Google-Smtp-Source: AGRyM1tOnLZ284hQJDfPeDNtJYVslip/xjS8cgczTs07jGoDS76bGyhePnvElvGVpddPaGrO1t5C8Q==
X-Received: by 2002:a5d:4889:0:b0:21d:eab7:f798 with SMTP id g9-20020a5d4889000000b0021deab7f798mr23275267wrq.96.1658427424145;
        Thu, 21 Jul 2022 11:17:04 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id f9-20020adfb609000000b0021e519eba9bsm2518843wre.42.2022.07.21.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 11:17:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller-bugs@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        syzkaller-bugs@googlegroups.com, rydberg@bitmath.org,
        syzbot <syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, ira.weiny@intel.com
Subject: Re: [syzbot] INFO: task hung in __input_unregister_device (4)
Date:   Thu, 21 Jul 2022 20:16:59 +0200
Message-ID: <12027074.O9o76ZdvQC@opensuse>
In-Reply-To: <8095587.T7Z3S40VBb@opensuse>
References: <000000000000ed47a705e2cbd347@google.com> <2bcd5385-2423-2e8f-be01-9db93afaba43@I-love.SAKURA.ne.jp> <8095587.T7Z3S40VBb@opensuse>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 21 luglio 2022 18:53:27 CEST Fabio M. De Francesco wrote:
> On gioved=C3=AC 21 luglio 2022 17:06:26 CEST Tetsuo Handa wrote:
> > On 2022/07/21 23:45, Fabio M. De Francesco wrote:
> > > If it can be fixed, as you said, by a simple notification to=20
> > > wait_event_interruptible(), why not changing iforce_usb_disconnect()=
=20
> the=20
> > > following way?
> > >=20
> > > static void iforce_usb_disconnect(struct usb_interface *intf)
> > > {
> > >         struct iforce_usb *iforce_usb =3D usb_get_intfdata(intf);
> > >=20
> > >         usb_set_intfdata(intf, NULL);
> > >=20
> > >         __set_bit(IFORCE_XMIT_RUNNING, iforce_usb-
>iforce.xmit_flags);
> >=20
> > I assume you meant clear_bit() here, for
> >=20
> > 	wait_event_interruptible(iforce->wait,
> > 		!test_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags));
> >=20
> > waits until IFORCE_XMIT_RUNNING bit is cleared.
> >=20
>=20
> Sorry, yes you are correct. I didn't note that negation of test_bit().
> However, you understood what I was trying to convey :-)
>=20
> > However, clear_bit() is racy, for IFORCE_XMIT_RUNNING bit is set by
> > iforce_send_packet() at the previous line.
>=20
> Why not protecting with a mutex, I mean both in iforce_usb_disconnect()=20
and=20
> soon before calling iforce_send_packet() in iforce_close()?
>=20
> > >         wake_up(&iforce_usb->iforce.wait);
> > >=20
> > >         input_unregister_device(iforce_usb->iforce.dev);
> > >=20
> > >         usb_free_urb(iforce_usb->irq);
> > >         usb_free_urb(iforce_usb->out);
> > >=20
> > >         kfree(iforce_usb);
> > > }
> > >=20
> > > I am sorry if I'm overlooking anything, especially because I'm=20
entering=20
> > > this thread without reading the other messages and so without knowing=
=20
> the=20
> > > whole context. Furthermore I haven't even test-compiled these changes=
=20
> :-(
> >=20
> > So far, I asked syzbot to test
> >=20
> > --- a/drivers/input/joystick/iforce/iforce-usb.c
> > +++ b/drivers/input/joystick/iforce/iforce-usb.c
> > @@ -258,6 +258,9 @@ static void iforce_usb_disconnect(struct=20
> usb_interface *intf)
> > =20
> >  	usb_set_intfdata(intf, NULL);
> > =20
> > +	usb_poison_urb(iforce_usb->irq);
> > +	usb_poison_urb(iforce_usb->out);
> > +
> >  	input_unregister_device(iforce_usb->iforce.dev);
> > =20
> >  	usb_free_urb(iforce_usb->irq);
> >=20
> > which still triggered this problem, and
> >=20
> > --- a/drivers/input/joystick/iforce/iforce-main.c
> > +++ b/drivers/input/joystick/iforce/iforce-main.c
> > @@ -200,8 +200,10 @@ static void iforce_close(struct input_dev *dev)
> >  		/* Disable force feedback playback */
> >  		iforce_send_packet(iforce, FF_CMD_ENABLE, "\001");
> >  		/* Wait for the command to complete */
> > -		wait_event_interruptible(iforce->wait,
> > -			!test_bit(IFORCE_XMIT_RUNNING, iforce-
> >xmit_flags));
> > +		wait_event_interruptible_timeout
> > +			(iforce->wait,
> > +			 !test_bit(IFORCE_XMIT_RUNNING, iforce-
> >xmit_flags),
> > +			 5 * HZ);
> >  	}
> > =20
> >  	iforce->xport_ops->stop_io(iforce);
> >=20
> > which did not trigger this problem.
>=20
> It did not clear this problem because of _timeout(), I guess.

^^^^^ Sorry, "clear" -> "trigger" ^^^^^
However, I suppose it doesn't matter any longer.

Thanks,

=46abio

>=20
> If I recall correctly, this task hanged in wait_event_interruptible() and=
=20
> your problem was how to clear that bit and make the task return from=20
> wait_event_interruptible(). Correct?
>=20
> Now you changed this code to return after some time, despite that flag.
> Are you sure this is the better suited way to fix this bug?
>=20
> >=20
> > Since wait_event_interruptible() was used here, I think we can expect=20
> that
> > it is tolerable to continue without waiting for the command to=20
> complete...
>=20
> Ah, yes. Maybe you are right here but I wouldn't bet on what authors=20
> thought when they called wait_event_interruptible() :-)
>=20
> Thanks,
>=20
> Fabio
>=20
> > --=20
> > You received this message because you are subscribed to the Google=20
Groups=20
> "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send=
=20
an=20
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/
> msgid/syzkaller-bugs/2bcd5385-2423-2e8f-be01-9db93afaba43%40I-
> love.SAKURA.ne.jp.
> >=20
>=20
>=20
>=20
>=20
>=20




