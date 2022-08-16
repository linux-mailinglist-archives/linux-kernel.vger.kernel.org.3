Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A591596242
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiHPSRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiHPSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:16:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B586049
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:16:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy5so20448578ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7PdK+76CgeP/Gc9KmgEuj475nMl0LQ3s7k+RPWfVvDo=;
        b=TJY8PR+LQVJUgFtLgN7mTp09jD5JJVUyvYLk14WrtdVZUrNPOj1nHSqrJS179Kn50D
         80rn/1lHDi1XMbdudx8EnTtTvxf+cpTL7fVgGD8x6UGpPzv3QJh07AQuKv22PoZoApmm
         G+P2MDVze1HYqY6DSgN7RkM1KaCCZptS6fIIp87H85FmdmVRD5ZFNWF3FBFsTTxhOD7q
         Kvs1YgFHKPhRAubO+tezp2NSzo6DbxeU8iQ01AFN/nKb+WcjvDc/WHbdIkzIeJUYqsrS
         TEXvHsUenMihV7H5IU7L5Zpif7HGs2v3ViknrLJOqkl7flgyPQlASVN9gd59ig44h7Pz
         grbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7PdK+76CgeP/Gc9KmgEuj475nMl0LQ3s7k+RPWfVvDo=;
        b=8EXHhnaga2gglQMtF5gekU59QsmUHj8hyQGYu+DERaQJ41fZm8119fFYDSt8cqKE4y
         zFtD4UleCi1hL2l3Sps3Uj+wFehuzYzGGS+AVfYxFtFXBOX2PrV97HhSppwg0WlBkTsi
         8zY9F3f5HAnJsEQ6Cb4h/34Z2WN3nkuK6dPenTVSfI9wSGFLJb+z1eMShAhh7M1NzKO/
         7R3Bn3YGf+P+VlwYOBxBztu7Kdqw+h+R5TFIbFX3tYbI2RU+IwFD/pucdhJ1R2db7P7R
         lOF5PpS/GrAWRqcdYMw7M2L2xw0ixfn1JmFlLkGHTWaiSWXiQrPx5+D62goOuFHfttI7
         SIZg==
X-Gm-Message-State: ACgBeo13NOs1NVJzpfwmNGF+k9MhiwiVYSvzb2UFkPgg3QOR3qeVn2qu
        GiwrSsfipN/ZdWYSvqdqu8k=
X-Google-Smtp-Source: AA6agR5n3HhHLtvuM7ETFfNMWqolUi1sy8SDZzikP91LI+r/gmPvtO/0/s7h9YUIIcVEkeagzEiP6A==
X-Received: by 2002:a17:906:cc15:b0:731:6cc2:7a85 with SMTP id ml21-20020a170906cc1500b007316cc27a85mr13994397ejb.512.1660673817331;
        Tue, 16 Aug 2022 11:16:57 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709063c0e00b007313a2575d2sm5529543ejg.104.2022.08.16.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:16:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ira Weiny <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date:   Tue, 16 Aug 2022 20:16:54 +0200
Message-ID: <8992226.CDJkKcVGEf@opensuse>
In-Reply-To: <3e8a0bb1-4c69-93d2-71f9-81bb8466cb14@nvidia.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com> <3e8a0bb1-4c69-93d2-71f9-81bb8466cb14@nvidia.com>
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

On marted=C3=AC 16 agosto 2022 15:12:08 CEST Chaitanya Kulkarni wrote:
> Fabio,
>=20
> On 8/16/22 02:18, Fabio M. De Francesco wrote:
>=20
> > kmap() is being deprecated in favor of kmap_local_page().
> >=20
> > There are two main problems with kmap(): (1) It comes with an overhead =
as
> > mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when t=
he
> > kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> > utilized until a slot becomes available.
> > =20
>=20
> so I believe this should give us better performance under heavy
> workload ?
>

Yes, correct. Can you please take a look at the highmem official documentat=
ion=20
(highmem.rst)? I reworked and extended it with two series of patches.=20
Everything about the deprecation of kmap() is explained there and in a patc=
h=20
from Ira: "checkpatch: Add kmap and kmap_atomic to the deprecated list" whi=
ch=20
you reviewed at https://lore.kernel.org/all/91f708ed-f456-dc83-281e-fc18a0b=
4b981@nvidia.com/
=20
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, t=
he
> > kernel virtual addresses are restored and are still valid.
> >=20
> > However, there is a huge constraint which might block some conversions
> > to kmap_local_page(): the kernel virtual address cannot be handed across
> > different threads. Ira made me notice that the kmap() and kunmap() in t=
his
> > driver happen in two different workqueues. Therefore, kunmap_local() wi=
ll
> > try to unmap an invalid address.
> >=20
> > Let me explain why I'm sending an RFC. When I hit the above mentioned
> > issues I tried to refactor the code in ways where mapping and unmapping
> > happen in a single thread (to not break the rules of threads locality).
> >=20
> > However, while reading this code again I think I noticed an important
> > prerequisite which may lead to a simpler solution... If I'm not wrong, =
it
> > looks like the pages are allocated in nvmet_tcp_map_data(), using the
> > GFP_KERNEL flag.
> >=20
> > This would assure that those pages _cannot_ come from HIGHMEM. If I'm n=
ot
> > missing something (again!), a plain page_address() could replace the=20
kmap()
> > of sg_page(sg); furthermore, we shouldn't need the un-mappings any long=
er.
> >=20
> > Unfortunately, I don't know this protocol and I'm not so experienced wi=
th
> > kernel development to be able to understand this code properly.
> >=20
> > Therefore, I have two questions: am I right about thinking that the pag=
es
> > mapped in nvmet_tcp_map_pdu_iovec() are allocated with GFP_KERNEL? If s=
o,
> > can anyone with more knowledge than mine please say if my changes make =
any
> > sense?
> >=20
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
>=20
> Thanks a lot for detailed explanation.

You are welcome!

> Quick question what kind of performance benefits you have seen with
> this change ? we need to document the performance numbers since commit
> log mentions here that kmap_local_page() is faster than kmap().

OK, but kmap_local_page() was discarded because not applicable here without=
=20
heavy refactoring.=20

> In case you are not aware please have a look at the blktests to create
> a simple loopback setup with nvme-loop transport.

I have nothing against learning how blktests works and running this tool.
I'll do as you requested.

However, please read the implementation of kmap():

#ifdef CONFIG_HIGHMEM

static inline void *kmap(struct page *page)
{
	void *addr;

	might_sleep();
	if (!PageHighMem(page))
		addr =3D page_address(page);
	else
		addr =3D kmap_high(page);
	kmap_flush_tlb((unsigned long)addr);
	return addr;
}

If page is not from HIGHMEM it is a simple page_address(), like it is in my=
=20
RFC patch.

#else /* CONFIG_HIGHMEM */

static inline void *kmap(struct page *page)
{
	might_sleep();
	return page_address(page);
}

Again, a plain page_address().
=46urthermore, with a simple page_address() we avoid the calls to kunmap().

I think it implicitly say all we need to know about why we should prefer=20
page_address() whenever we are _sure_ that pages cannot come from HIGHMEM.

Thanks for your comments and questions,

=46abio

> -ck
>


