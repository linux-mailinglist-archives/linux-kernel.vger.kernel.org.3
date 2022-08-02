Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2383D587B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiHBLCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiHBLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:02:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B872AB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:02:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m13so13488175wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9f72dYH7EcyVDv+LBnMsCnVkZlmCOPJR1dVC+vHmlQ=;
        b=PbIRsQ5mLbKfXHTSx44sIJ7Gd4sv9wPPE+08+maGOObDZIERZSne9y+IJCHxiRBpzx
         fmOh62MqqURQDpy8ukvI91oKY8lX34tW5hQAj2D5LVcdVVesrsQn76XAzrrVMTNCspf3
         xWJf8A7P9u3/054DS6MXNZNuyK03gSseguO6b+X/3Ihwtji3ab+KvS5gozcaUHrmSGll
         JeHTUHxa4bMHjlkAfoUFmdsVb0Y+OvT1cviJwKv2T7j7LzTzrLLHOkmtdsmjMEo08Ngm
         U+Obc+emsSXq1Lv1stUAf7YIcfGRvqEWeXCPTngvkFYA3Cnnkw4trTzKRdOlLR6rkhX5
         Sydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9f72dYH7EcyVDv+LBnMsCnVkZlmCOPJR1dVC+vHmlQ=;
        b=hS15jePsGV1ndJ8+xeY7Yt6jNKhVz8o5+ZZbFRbYkPGHywtQMf5MD7tpKXthiSLvH9
         wIPOQoqxRQ+bdIAmlXKrXDhDwFVZO1K7wFhOacGhOvHHhbDVEUEDL6GfmS6mZCERs0qS
         8vXLnO1U6XrMHtYmv63oVA96tn60LKqSTj4wUAN/kcKP5WV6a36pACdlc/oa6lsFTnpR
         usgM/GrBE8tKirMc9cIwpz+XBGc5FcFtcT8u8kf67eHAFYCZeB1km/6QnTiB/9AW8/cH
         iSCbHk4CWp6RNHhRWfcentXTRi0yNQF6WhnDNHZMyo67oDIVE87Av8Asmk0awiNMfbpW
         91lA==
X-Gm-Message-State: ACgBeo1plclhAl64lFlU2ef3fbly07EyO2momlBeybgCg+O9QXDlJ1ay
        mlC+pN35KPJgmoGFFXVqdNU=
X-Google-Smtp-Source: AA6agR6n0fiwI6OBO7K3lIW3MDPSt9E3HBA1Pv5i8qmZaUp+fqN9wXf1IAashZzOuQ8JYMX2xYt0jg==
X-Received: by 2002:a5d:5a9a:0:b0:220:6309:5c87 with SMTP id bp26-20020a5d5a9a000000b0022063095c87mr5428877wrb.107.1659438147957;
        Tue, 02 Aug 2022 04:02:27 -0700 (PDT)
Received: from opensuse.localnet (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id q12-20020a056000136c00b0021e47fb24a2sm14511127wrz.19.2022.08.02.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 04:02:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Date:   Tue, 02 Aug 2022 13:02:25 +0200
Message-ID: <5847084.alqRGMn8q6@opensuse>
In-Reply-To: <YujTHv0xVG8DirkW@MiWiFi-R3L-srv>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com> <1923146.PYKUYFuaPT@opensuse> <YujTHv0xVG8DirkW@MiWiFi-R3L-srv>
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

On marted=C3=AC 2 agosto 2022 09:32:46 CEST Baoquan He wrote:
> On 08/02/22 at 08:20am, Fabio M. De Francesco wrote:
> > On marted=C3=AC 2 agosto 2022 05:06:54 CEST Baoquan He wrote:
> > > On 07/08/22 at 01:15am, Fabio M. De Francesco wrote:
> > > > The use of kmap() and kmap_atomic() are being deprecated in favor=20
of
> > > > kmap_local_page().
> > > >=20
> > > > With kmap_local_page(), the mappings are per thread, CPU local and=
=20
not
> > > > globally visible. Furthermore, the mappings can be acquired from=20
any
> > > > context (including interrupts).
> > > >=20
> > > > Therefore, use kmap_local_page() in kexec_core.c because these=20
mappings=20
> > are
> > > > per thread, CPU local, and not globally visible.
> > > >=20
> > > > Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
> > > > enabled.
> > >=20
> > > Wondering what arch you tested with.
> >=20
> > I'm sorry, I forgot to say that I use x86_32 with 4GB to 6GB RAM.
> > This is usually an information that I add in the commit messages of all=
=20
the=20
> > recent conversions I'm working on across the entire kernel.
> >=20
> > Another important information (overlooked again this time) is that (1)=
=20
> > kmap() comes with an overhead as mapping space is restricted and=20
protected=20
> > by a global lock for synchronization and (2) it also requires global=20
TLB=20
> > invalidation when the kmap=E2=80=99s pool wraps and it might block when=
 the=20
mapping=20
> > space is fully utilized until a slot becomes available.
>=20
> Thanks a lot for update with more details, Fabio.

You're welcome.

> Maybe these can be
> added into log with v3 if you think they are worth adding, and with my
> Ack since no code change related. You decide.

=46or weeks I've been thinking that these details were not necessary in the=
=20
commit message of these conversions. Later I realized that a fair number of=
=20
maintainers weren't aware of why we should change something that had been=20
working "properly" for years. Perhaps they thought that we would face too=20
many risks of breaking things versus little rewards.

After discussing with Greg K-H (who was initially not fond of these changes=
=20
to core parts of firmware loading mechanism), he suggested that a proper=20
commit log with the necessary information could have helped himself and the=
=20
other maintainers who may not yet had time to deepen this topics.

This patch to "kexec" slipped in with no such additions.

Therefore, I agree with you in full: I'll add these information and send a=
=20
new version ASAP.

> Thanks again for the effort.

Thanks so much for the "Acked-by:" tag from you.

=46abio =20

[snip]


