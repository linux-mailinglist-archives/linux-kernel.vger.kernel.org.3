Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E05261C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380212AbiEMMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380170AbiEMMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B4872A1FC2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652444691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGylHDS/3fg5TrOKJP4cWNt11P3ZBc0gnKyFOChcypg=;
        b=HXCr4SEnWWpDdy/QjlzroM+33fmIQRTFDFuod0HNn/fCMdp/9zyztginhfpkfjszcRn0HG
        PZ/vFi+k1DG562dgIR5GN+ooICiGzVtAZrozRtM7vbyFcDJaSscKHIioAIJlo7yao4M7P8
        AbLnshJaxJp2qovNVW17Ihl75gHQ3rI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-q1HaNCKyPSeWDPTFL_D4Mg-1; Fri, 13 May 2022 08:24:50 -0400
X-MC-Unique: q1HaNCKyPSeWDPTFL_D4Mg-1
Received: by mail-wm1-f71.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso5913058wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=yGylHDS/3fg5TrOKJP4cWNt11P3ZBc0gnKyFOChcypg=;
        b=671e03s+OBCEYqro7b5eNWrKlSAO5EKlmEDWvtrKX3Lm8mJPxQL5f/E0n8/9Mdmqec
         2u/oenszDccblgnKygLdhP12dfwQCfJsMQkJxrk+WgpPqQ6X/dWsqz/5ELfBOeiSGjIJ
         Zls5bN2PwYG6pFnXI+frbFagvUsbo668StAlBSWb6d77q4sTnUNaevcwEjL01dzGWZrE
         2+0+Hl7Rys6y54Phg01KaecKAz2FJ2uVhuE8pK+UaVwh6oU9ExIYpaS15Xlx2y867rQl
         OclbzhFX5je+IP0tHlryxqGHNIyVk83WjvtlHuiBGOvjB2x/zb025u8v2Cq6IH1mXF6s
         /LqQ==
X-Gm-Message-State: AOAM531AmX2UnwNOPgUtKygyc8Q92EzkHP3LZzvT3scdtm8lGjvjAqn6
        Fe9RptTuRDT8/RciLKkwy8Jh9X6kJ0ALnPMWzwqq4ngzxLTs4wF8NKHXJ2JIG/Ejn0UzADdlRIH
        5pbfXGLkjb675yytcu4FMnL44
X-Received: by 2002:adf:ce09:0:b0:20c:bee9:b3b3 with SMTP id p9-20020adfce09000000b0020cbee9b3b3mr3763241wrn.72.1652444688987;
        Fri, 13 May 2022 05:24:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGpwj2LbflIxB6c/w1XdVK2531eXprkSVlVWibKbS8fwNFsrJx+2GGpeU7ISRVY+uVS+RS/w==
X-Received: by 2002:adf:ce09:0:b0:20c:bee9:b3b3 with SMTP id p9-20020adfce09000000b0020cbee9b3b3mr3763226wrn.72.1652444688771;
        Fri, 13 May 2022 05:24:48 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0? ([2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b0039482d95ab7sm2310670wmc.24.2022.05.13.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:24:48 -0700 (PDT)
Message-ID: <9b04479e3810dbbc3cb2ebd68a3ab3fd034e125e.camel@redhat.com>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Fri, 13 May 2022 14:24:47 +0200
In-Reply-To: <20220512085043.5234-1-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Thu, 2022-05-12 at 09:50 +0100, Mel Gorman wrote:
> Changelog since v2
> o More conversions from page->lru to page->[pcp_list|buddy_list]
> o Additional test results in changelogs
>=20
> Changelog since v1
> o Fix unsafe RT locking scheme
> o Use spin_trylock on UP PREEMPT_RT
>=20
> This series has the same intent as Nicolas' series "mm/page_alloc:
> Remote
> per-cpu lists drain support" -- avoid interference of a high priority
> task due to a workqueue item draining per-cpu page lists. While many
> workloads can tolerate a brief interruption, it may be cause a real-
> time
> task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> the draining in non-deterministic.
>=20
> Currently an IRQ-safe local_lock protects the page allocator per-cpu
> lists.
> The local_lock on its own prevents migration and the IRQ disabling
> protects
> from corruption due to an interrupt arriving while a page allocation
> is
> in progress. The locking is inherently unsafe for remote access
> unless
> the CPU is hot-removed.
>=20
> This series adjusts the locking. A spinlock is added to struct
> per_cpu_pages to protect the list contents while local_lock_irq
> continues
> to prevent migration and IRQ reentry. This allows a remote CPU to
> safely
> drain a remote per-cpu list.
>=20
> This series is a partial series. Follow-on work should allow the
> local_irq_save to be converted to a local_irq to avoid IRQs being
> disabled/enabled in most cases. Consequently, there are some TODO
> comments
> highlighting the places that would change if local_irq was used.
> However,
> there are enough corner cases that it deserves a series on its own
> separated by one kernel release and the priority right now is to
> avoid
> interference of high priority tasks.
>=20
> Patch 1 is a cosmetic patch to clarify when page->lru is storing
> buddy pages
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0and when it is storing pe=
r-cpu pages.
>=20
> Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly
> speaking
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0this is not necessary but=
 it avoids per_cpu_pages consuming
> another
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cache line.
>=20
> Patch 3 is a preparation patch to avoid code duplication.
>=20
> Patch 4 is a simple micro-optimisation that improves code flow
> necessary for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a later patch to avoid co=
de duplication.
>=20
> Patch 5 uses a spin_lock to protect the per_cpu_pages contents while
> still
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0relying on local_lock to =
prevent migration, stabilise the pcp
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lookup and prevent IRQ re=
entrancy.
>=20
> Patch 6 remote drains per-cpu pages directly instead of using a
> workqueue.
>=20
> =C2=A0include/linux/mm_types.h |=C2=A0=C2=A0 5 +
> =C2=A0include/linux/mmzone.h=C2=A0=C2=A0 |=C2=A0 12 +-
> =C2=A0mm/page_alloc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 348 +++++++++++++++++++++++++------------
> --

Thanks for the series!

I'm testing the series ATM, both with on vanilla and RT kernels. I'll have =
the
results by Monday.

Regards,

--=20
Nicol=C3=A1s S=C3=A1enz

