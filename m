Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170A14BE3FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378966AbiBUPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:18:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiBUPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:18:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE471DA72
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:17:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D5A3B81216
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C579CC340E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:17:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F1zazOBT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645456658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQqwLIRqBF6IyJA8RF+kEDk7RrKOa7nHZ2TpMJ5iw60=;
        b=F1zazOBTR9OUFsDoxxY30c4zIb3qZv1Vjy7v9LeaDCE/HMYs8wqPshpfiJjNRm6cAtPDjZ
        mrbi7S9dQlRv9QpoXr5OnOK8MO4oTc40OwjanTk/pjpa3W5CnmosRCaZKxFHbH3qdAIHaw
        1ivICK0GZy3G7Fz21n/VhXc643lHawg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 886fdb3a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 15:17:38 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id j2so35201149ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:17:37 -0800 (PST)
X-Gm-Message-State: AOAM533vtrxrvdwdiPAbF4B91Qa1IOonmi8N6nYVT3hbdUSkL3C0bCRo
        AyN0Vo4/1Va8wbfLYt8AzWfCbm9C9xtrEHPbnsY=
X-Google-Smtp-Source: ABdhPJzIo6+FKcwGDk2ZOrmtcF/jiRF4YC5g4FCcZzIJGlJLhYRwRvX9Fn5wGM1AhBS61/W65/RGqHVGuIaiDv7zOZA=
X-Received: by 2002:a25:d116:0:b0:61d:e8c9:531e with SMTP id
 i22-20020a25d116000000b0061de8c9531emr19182794ybg.637.1645456657044; Mon, 21
 Feb 2022 07:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <20220212122318.623435-8-Jason@zx2c4.com>
 <YhMfhipo95HxVaFO@sol.localdomain>
In-Reply-To: <YhMfhipo95HxVaFO@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 16:17:26 +0100
X-Gmail-Original-Message-ID: <CAHmME9qs5gBFrGXGktB9kOx8oSdfow+-Tc=ie7b1J8aT5SfQ7Q@mail.gmail.com>
Message-ID: <CAHmME9qs5gBFrGXGktB9kOx8oSdfow+-Tc=ie7b1J8aT5SfQ7Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] random: group entropy collection functions
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 6:13 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sat, Feb 12, 2022 at 01:23:15PM +0100, Jason A. Donenfeld wrote:
> > +/**********************************************************************
> > + *
> > + * Entropy collection routines.
> > + *
> > + * The following exported functions are used for pushing entropy into
> > + * the above entropy accumulation routines:
> > + *
> > + *   void add_device_randomness(const void *buf, size_t size);
> > + *   void add_input_randomness(unsigned int type, unsigned int code,
> > + *                             unsigned int value);
> > + *   void add_interrupt_randomness(int irq);
> > + *   void add_disk_randomness(struct gendisk *disk);
> > + *   void add_hwgenerator_randomness(const void *buffer, size_t count,
> > + *                                   size_t entropy);
> > + *   void add_bootloader_randomness(const void *buf, size_t size);
> > + *
> > + * add_device_randomness() adds data to the input pool that
> > + * is likely to differ between two devices (or possibly even per boot).
> > + * This would be things like MAC addresses or serial numbers, or the
> > + * read-out of the RTC. This does *not* credit any actual entropy to
> > + * the pool, but it initializes the pool to different values for devices
> > + * that might otherwise be identical and have very little entropy
> > + * available to them (particularly common in the embedded world).
>
> Perhaps this comment should match the order in which these functions are defined
> in the file?

Sure. Will do
