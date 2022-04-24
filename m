Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7138250D0D8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiDXJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiDXJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:43:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3B13DC9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:40:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y21so7589121wmi.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qz6vTjL+ZLjDCvLC3HTP/ywXfPAN7n219hIaj+W2BdQ=;
        b=bHTHuQFHg7WZN1n9TW2PsAWwHbam1Mnxq/f3iZtppeQBT0YzXivAC1Lhk7ufFuquxQ
         nZgYawhbG9uQeZp7Jw+zgG5ZaYGyzIsD9Fm98BDmVxgcMJs0zIYe+T6RS37Z/UURuGW8
         g321F/fI0IJoK6PTWMWlaOU+wWiGwmV9AsW5R64roREHbyEjJdrqmuw5SXqROtSYZldg
         3hUzPCZrJb+qAfM0/KssA5Z7ekDPz3q7wCMln698rVLZ/fjGJ+j8YWtKsEK1wD41hv51
         i+DWj48Bpl+6dMnZtGYfVMrYuTYpVJO5XyyRl6kwJN8ByJ8gRnPQDlhzVeVKzCrB+DaO
         A2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qz6vTjL+ZLjDCvLC3HTP/ywXfPAN7n219hIaj+W2BdQ=;
        b=ffVHWrF884hBbkIsB4SY+RTMmJwmpo4XlywT2qCbeljOu7SfN+mSVgvSmDEIyw6bMI
         av53FGTSj3X6OJIlzbNsRJy7aY9QUVrpyOfeROW2n91HnD03HzT0lmVPXfWYUKyyL+og
         1bpwNCplizZTH44y/94h9SOWqrN9qP2Y2nbd9enKLZbz0CQk/29DxWNdeH5bV5O1Sw8v
         U3bMWgo8jRKI1HMeUQHj7ysv0+I+EEu0KafGLfU7UIcOOsL649zJbs/o/Sb2fxccjn3e
         NbT2+O7Wmg0l3uiDdqOQ+8mREqVwPUHcpEg6xLpkFgW1ZJqELmcgerB/JXE+XfDPUqXx
         5/2A==
X-Gm-Message-State: AOAM53033ca09Lga6w1OLJAmCKt4PWi0wXiqCKPAsfJdx+WNIqGO5Q5V
        DGCeJDaFnIL8LVCoWoEX8NE=
X-Google-Smtp-Source: ABdhPJx292c8madriUIRaMbjQpD0A7qvBRjwTyTvtbZY4UEMEve7BUjzQXUDGKihCJyFCPdCA11n3g==
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id l1-20020a7bc341000000b0037bed907dadmr11729936wmj.138.1650793200226;
        Sun, 24 Apr 2022 02:40:00 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d64e3000000b0020aaa0fea8bsm5943314wri.49.2022.04.24.02.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 02:39:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3] binder: Use kmap_local_page() in binder_alloc_get_page()
Date:   Sun, 24 Apr 2022 11:39:57 +0200
Message-ID: <2583087.X9hSmTKtgW@leap>
In-Reply-To: <fad918d3-6923-5bec-7830-5cddf7a725d6@wanadoo.fr>
References: <20220423102421.16869-1-fmdefrancesco@gmail.com> <20220423102421.16869-4-fmdefrancesco@gmail.com> <fad918d3-6923-5bec-7830-5cddf7a725d6@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sabato 23 aprile 2022 18:02:48 CEST Christophe JAILLET wrote:
> Hi,
>=20
> Le 23/04/2022 =C3=A0 12:24, Fabio M. De Francesco a =C3=A9crit :
> > The use of kmap_atomic() is being deprecated in favor of=20
kmap_local_page()
> > where it is feasible. Each call of kmap_atomic() in the kernel creates
> > a non-preemptible section and disable pagefaults. This could be a=20
source
> > of unwanted latency, so it should be only used if it is absolutely
> > required, otherwise kmap_local_page() should be preferred.
> >=20
> > With kmap_local_page(), the mapping is per thread, CPU local and not
> > globally visible. Furthermore, the mapping can be acquired from any=20
context
> > (including interrupts).
> >=20
> > Therefore, use kmap_local_page() / kunmap_local() in place of
> > kmap_atomic() / kunmap_atomic().
> >=20
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >   drivers/android/binder_alloc.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/
binder_alloc.c
> > index 0875c463c002..058595cc7ff0 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -1250,17 +1250,17 @@ static int binder_alloc_do_buffer_copy(struct=20
binder_alloc *alloc,
> >   		page =3D binder_alloc_get_page(alloc, buffer,
> >   					     buffer_offset,=20
&pgoff);
> >   		size =3D min_t(size_t, bytes, PAGE_SIZE - pgoff);
> > -		base_ptr =3D kmap_atomic(page);
> > +		base_ptr =3D kmap_local_page(page);
> >   		tmpptr =3D base_ptr + pgoff;
> >   		if (to_buffer)
> >   			memcpy(tmpptr, ptr, size);
> >   		else
> >   			memcpy(ptr, tmpptr, size);
>=20
> in the same spirit as patch 1/3, memcpy_to_page() and memcpy_from_page()=
=20
> looks good candidate to avoid code duplication.

Hello Christophe, Todd,

I had thought to use memcpy_to_page() and memcpy_from_page() (exactly as I=
=20
did in other conversions I have been working on during the latest couple of=
=20
weeks).=20

However, I decided to avoid to use them for I should also have deleted the=
=20
comment which is before "kunmap_local(base_ptr);".

I don't know how much Maintainers think it is necessary to make readers=20
notice that "kunmap_local() takes care of flushing the cache []" (exactly=20
as kunmap_atomic() does). Actually I'd delete that comment that looks=20
redundant and unnecessary to me, but I cannot know if Todd wants it to=20
remain there.

@Todd: Can you please say what you think about this topic? Should I leave=20
the patch as-is or I should use memcpy_{to,from}_page() and delete that=20
comment?

I won't send any v2 unless I have your confirmation.

Thanks,

=46abio

>=20
> Not checked in details, but looks mostly the same.
>=20
> Just my 2c.
>=20
> CJ
>=20
> >   		/*
> > -		 * kunmap_atomic() takes care of flushing the cache
> > +		 * kunmap_local() takes care of flushing the cache
> >   		 * if this device has VIVT cache arch
> >   		 */
> > -		kunmap_atomic(base_ptr);
> > +		kunmap_local(base_ptr);
> >   		bytes -=3D size;
> >   		pgoff =3D 0;
> >   		ptr =3D ptr + size;
>=20
>=20




