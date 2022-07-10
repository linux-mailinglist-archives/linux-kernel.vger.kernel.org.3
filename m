Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D556CEB9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGJLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 07:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJLSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 07:18:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE33B26E3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 04:18:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d16so3694131wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 04:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCa/6cUl4x0Al0xZAXztC/4Ul7lLICxLV8hh0EZptP0=;
        b=YJWhHqw3cwQoa5WWMzDxekfcQc0f5xozNbBlkKsLEITfcCHd8jTuX0QJl5P/KW5Ikf
         arKQkewDJ/St7PKTzQc7o85OJX6XKpNCq5eruYuUDR1j5wl5iwSZL2vdRsCjHoYusxDd
         aE5gsVXlDzaH+2S8OQnHm0eD57pbVUiluF1A8bb1kUIfJJ00LV1HGjtcqdEaL/z9oqAR
         2iultm4mv08Rgz3wFtyGbaC2GAbCoMiZez7sNDZhVcbPV5HfrOau3hjT92932mJtJOrX
         Gv2wXm6ZALBjaJ5wCbVUIN22w8TgMbSAxkiRPcLoUU55GswPqjT1z+i7dGne+tP4l/Ao
         KFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCa/6cUl4x0Al0xZAXztC/4Ul7lLICxLV8hh0EZptP0=;
        b=lFrwiaY0495AdJ3aSi1ccoOu+qxf6083rSg9sc4bPRhivqzSV9UOzx63Te40rSDmSx
         tjSeBnXNc6TN/eZQqPQFSwIaL0BdH69ZCh1rT7Ow+Sb8EqSjOn+1P6ACCqeNBYZR7x9w
         z+/Q+bIMtUNMMuGZ7Uj61QoL6ZPwIa7O9KFjqvr4r3rXWfhio1+8p2cabyHFzNoie3TM
         dwMsGSeK4aRUosfbg7dSJL6mb43jmyTLrMtfLEoRHumN04zcf8fEcdgq1MqH2lxVrVu2
         2lRAYU17G86mrDRqVOJ8qS0VxuWentAEFcZmz2767vvR/dVnpggtN5PIbPMAY2Q/IC0Y
         k5Tg==
X-Gm-Message-State: AJIora+NtUkUjEtBuf5UL0y+6VU0nvYvRn8PFETWmlsaoNW4XSj9OQAV
        iYhqt22EUhpVilkKKFCq1sa9Vj48KmY=
X-Google-Smtp-Source: AGRyM1vqW3C78TKnbargDU5e4wYY9FGtrKne+F8vReV3HFbFpm6G85p5gQauz7GvwJcnq+JGEOfQcQ==
X-Received: by 2002:a05:6000:114e:b0:21d:6cd1:695d with SMTP id d14-20020a056000114e00b0021d6cd1695dmr12446244wrx.474.1657451899142;
        Sun, 10 Jul 2022 04:18:19 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600011c200b0021d68a504cbsm3328786wrx.94.2022.07.10.04.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 04:18:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] firmware_loader: Replace kmap() with kmap_local_page()
Date:   Sun, 10 Jul 2022 13:18:16 +0200
Message-ID: <1891319.taCxCBeP46@opensuse>
In-Reply-To: <Ysqo6RjF/njUcOor@kroah.com>
References: <20220710101156.26139-1-fmdefrancesco@gmail.com> <Ysqo6RjF/njUcOor@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 10 luglio 2022 12:24:41 CEST Greg Kroah-Hartman wrote:
> On Sun, Jul 10, 2022 at 12:11:56PM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().
> >=20
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
>=20
> But that is not the case here for this kmap() instance?

I'm not 100% sure to get what you are asking here :-)
Probably you mean that kmap() can work here and you don't see reason for=20
converting? Am I understanding correctly?

OK, then...

kmap() is being deprecated in favor of kmap_local_page(). Please see=20
highmem.rst which I have updated weeks ago (https://docs.kernel.org/vm/
highmem.html).

Two main problems with kmap(): (1) It comes with an overhead as mapping=20
space is restricted and protected by a global lock for synchronization and=
=20
(2) kmap() also requires global TLB invalidation when the kmap=E2=80=99s po=
ol wraps=20
and it might block when the mapping space is fully utilized until a slot=20
becomes available.

kmap_local_page() should be preferred, where feasible, over all the others.

=46urthermore, current work in progress to use PKS to protect PMEM from str=
ay=20
writes does not support the kmap()/kunmap() calls. Probably this is why=20
I've been asked to (mechanically) convert all kmap() call sites (where=20
feasible) or refactor the code and then convert them where it is not (for=20
example wherever kmapped pages are reused in different contexts).=20

Unless I'm missing your point, I cannot see any reason here which prevents=
=20
these conversions. Can you please tell me if I'm overlooking anything?=20

> If this is a
> simple search/replace, why is this not just done once and be done with
> it?

No, this job needs code inspection. After more than 25 conversions I can=20
say that no more than 30% have been simple search and replace.

> > Call kmap_local_page() in firmware_loader wherever kmap() is currently
> > used. In firmware_rw() use the copy_{from,to}_page() helpers instead of
> > open coding the local mappings plus memcpy().
>=20
> Isn't that just a different cleanup than the kmap() change?  Or is that
> tied to the fact that the other buffer is now allocated with
> kmap_local_page() instead of kmap()?

This kinds of changes have never been considered clean-ups by other=20
maintainers (for an example please see commit e88a6a8fece9 ("binder: Use=20
memcpy_{to,from}_page() in binder_alloc_do_buffer_copy()").=20

Using helpers has always been considered part of the conversions themselves=
=20
and nobody has ever requested further patches for these.

> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/base/firmware_loader/main.c  | 4 ++--
> >  drivers/base/firmware_loader/sysfs.c | 9 ++++-----
> >  2 files changed, 6 insertions(+), 7 deletions(-)
>=20
> Did you run this through the firmware test framework?

No, sorry. I assumed (wrongly?) that this is one of those cases which don't=
=20
need any tests. However I have nothing against testing. I've done them=20
where they were absolutely needed for Btrfs conversions and kexec.

Do you see anything which may break the rules of use of kmap_local_page()=20
here? If you confirm you are concerned it could not work, I'll happily=20
research how to test these changes :-)

> thanks,
>=20
> greg k-h
>=20

Thanks for your comments,

=46abio


