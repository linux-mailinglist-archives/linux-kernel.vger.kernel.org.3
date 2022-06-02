Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB3853B8F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiFBMW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiFBMWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:22:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F82192;
        Thu,  2 Jun 2022 05:22:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s6so7506893lfo.13;
        Thu, 02 Jun 2022 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VOQZA0pHYqK4XdbW9GaYy4EgHWG2TtOSiKjo+AkEHcM=;
        b=UnE1Rplcr6LJMmwXyiL8ub39B1DsH07ftzTp2OVzdHGbBuxHegfEbgNiYk0LTgRA8Q
         52K0TR54JuB4WxHpGvQ8tl2RYold0dDK00bsLnJbq8Yg+lCaOSCQFasYxpY0dLfInTgs
         7gQ19qYW1M6D6Z3e4mL14Y9+XIwN3YOm/MtYtG/Wv7bJJs9vyp/VNaV0eQM3FEhoyMIi
         3x7yA+IhqxRTNkOak9X+TW13moVPwvJqYCv4jKAf/TucWy6yL6+bZaHiQjnbCqwEN+ih
         cDn2R3aLAl1xQWUM+KA8AFT23ALZPYKaRyK6YHf/zAkApYAkW0pA3x1pXfoJQkUNTFDv
         g2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VOQZA0pHYqK4XdbW9GaYy4EgHWG2TtOSiKjo+AkEHcM=;
        b=URF+7EYcfLXv9ffDV1OeuEof9+z6Yb++7NZmwMeVKfD3DVvoNayx7RiPr1+6c073Ls
         TPaUnTwGPqxesLxhvdfHMXMJx3lf2mlmpDsRjLd+123OxSYXzxfoHoieAaKQGELFjiii
         9bKCnRsBgSGZ4a8d8YSIWrQzGbrEkLUZylxRME3UK929ELFQQZyijsY6O1UlTCEqJs+E
         tAYwq6P1Gqv74KKxRO3/CiTKd63+5YfVxQWyq3sSFkiXFD+noRfehZbfXtbKhDTz0LMh
         mORzg4C4wz2TAOAejaj8L1B3DougDa+yPK9LZGe0zR6aX4w2vx5pzQMMFnVKCJdXWEIJ
         hP5g==
X-Gm-Message-State: AOAM532s0L9mtqhEHQ4llkuarSSHLcbRn50uFXS440wuvKdMjbftzMCh
        vA4aPc5AjtYUBpCI2BoZHwXpXZkQK34MnbhscuY=
X-Google-Smtp-Source: ABdhPJyVvZ/uTNq8sMKoJG6ijdTCL0j2WKweW33CgjPbnGda+c3G9nCqp0xIzgTsfNiXS+BPfYkG1BIjTPHHQt2wSv4=
X-Received: by 2002:a05:6512:b17:b0:478:d66d:f747 with SMTP id
 w23-20020a0565120b1700b00478d66df747mr17038767lfu.447.1654172571822; Thu, 02
 Jun 2022 05:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220601195341.28581-1-jandryuk@gmail.com> <YphSYfdzy8kekhTZ@infradead.org>
In-Reply-To: <YphSYfdzy8kekhTZ@infradead.org>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 2 Jun 2022 08:22:40 -0400
Message-ID: <CAKf6xpsbgyvJjdRGrE3ru114iuXv98rumf8nVvKu5WmErf+zTA@mail.gmail.com>
Subject: Re: [PATCH] xen-blkfront: Handle NULL gendisk
To:     Christoph Hellwig <hch@infradead.org>
Cc:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-block@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
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

On Thu, Jun 2, 2022 at 2:02 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jun 01, 2022 at 03:53:41PM -0400, Jason Andryuk wrote:
> > When a VBD is not fully created and then closed, the kernel can have a
> > NULL pointer dereference:
> >

> >
> > info->rq and info->gd are only set in blkfront_connect(), which is
> > called for state 4 (XenbusStateConnected).  Guard against using NULL
> > variables in blkfront_closing() to avoid the issue.
> >
> > The rest of blkfront_closing looks okay.  If info->nr_rings is 0, then
> > for_each_rinfo won't do anything.
> >
> > blkfront_remove also needs to check for non-NULL pointers before
> > cleaning up the gendisk and request queue.
> >
> > Fixes: 05d69d950d9d "xen-blkfront: sanitize the removal state machine"
> > Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
>
> Tis looks ok, but do we have anything that prevents races between
> blkfront_connect, blkfront_closing and blkfront_remove?

Thanks for taking a look, Christoph.

blkfront_connect and blkfront_closing are called by the state machine
in blkback_changed.  blkback_changed is the xenbus_driver
.otherend_changed callback.  The xenwatch kthread calls callbacks
synchronously and one at a time, so that seems okay today.

blkfront_remove is the xenbus_driver .remove callback, so it is tied
to the life cycle of the device.  It's called after the
otherend_changed callback is unregistered, so those won't run when
blkfront_remove is running.

Given that, I think it's okay.

Regards,
Jason
