Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C45A6CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiH3TDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiH3TD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FF5925B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661886204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQby0NB5hpgQj+GqJHolGKDs4KWtRxqQy0UgooG1hoY=;
        b=f/HHc4kLQXh+fJnpWY5J9/9aYpA9Ucj6OHVhrlZp+/WGZguR6GpfhSX7HABmkKexO80bez
        8ebygiiKLnXj36UwjnHEJuxQPyn4eWhoXgeGWLWWdJbuZDXG7pTCYFMPxhrq7KUMU/gd1a
        dAY24iiPtTnO+Hyt+PPtxSINuwCEK+s=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-GF1RMg8tMRGpYtK1V0qONw-1; Tue, 30 Aug 2022 15:03:22 -0400
X-MC-Unique: GF1RMg8tMRGpYtK1V0qONw-1
Received: by mail-vs1-f71.google.com with SMTP id 63-20020a671942000000b0038c9055e83cso1644770vsz.22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=EQby0NB5hpgQj+GqJHolGKDs4KWtRxqQy0UgooG1hoY=;
        b=SAA6/JrM5Dgsn8/acJ8TsH7TwjjkJiUQLxRZOx7qS2sHKUnZx8TiAER4msKvuJfswY
         rJxtFgZq7cAaaKgTk11IW1XnJ4HoaIYEMOJED7lmrFywszyrJ0E5XShCXTcl5EvdI8ZG
         f8KHqxxhaWWvqw5vlTg2wp8gruiTo4ULFmUvX/ZtuZ38Y4ov75ZmDRisYjrW9jgwvDU2
         GHhK6brlLL9wfED64o+sPYNDZmEL5fRc6T3GTxtx3LicRll7aLZgY6ocOuKOi2+bo3Bp
         wdV6E1FmWZoGY0dvpo9pGvY++k825ftXgSLCv/GKZ+StRyNIs8K6xNMapUb/un4qlolI
         6vWg==
X-Gm-Message-State: ACgBeo3FH1nliPRbWgAk69m/2GvawcUFhTMXVHVv0NbXWGP0EfOp/lRF
        Pjq4Ae4YO5VfOavyiNamojbtTZBP9dRpGddriwIGeQljCZPwBHK8VCl1DPw0Y20IXbDO58VKa7a
        DsVsed/krTA71J/l6YMGWMZ6+4Al84ZD2bd1uHjfT
X-Received: by 2002:a67:ec82:0:b0:388:fefa:2467 with SMTP id h2-20020a67ec82000000b00388fefa2467mr5467641vsp.67.1661886202482;
        Tue, 30 Aug 2022 12:03:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6RgVEqcXOIimuk8fQ/2gBWAbahxY49CygHusFiJQnbLDynDaEIrKmkIS1JR9YNELmPJHISR6NTZtYKyO9VN0Y=
X-Received: by 2002:a67:ec82:0:b0:388:fefa:2467 with SMTP id
 h2-20020a67ec82000000b00388fefa2467mr5467632vsp.67.1661886202251; Tue, 30 Aug
 2022 12:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220829154805.1205507-1-mlombard@redhat.com> <Yw3lXaDTfvJcEM4Q@linutronix.de>
 <CAFL455=4SBhJ4LpiPQr+PmL2ShuTpR=bAo8JVfe-2x3cg85cbQ@mail.gmail.com> <Yw5eFGRreMA0I95S@linutronix.de>
In-Reply-To: <Yw5eFGRreMA0I95S@linutronix.de>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Tue, 30 Aug 2022 21:03:11 +0200
Message-ID: <CAFL455m-51-SmaiQoYhARVey-Ld0fR5tbQzsP41M+N+zVMqjuA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 30. 8. 2022 v 20:59 odes=C3=ADlatel Sebastian Andrzej Siewior
<bigeasy@linutronix.de> napsal:
>
> On 2022-08-30 17:48:06 [+0200], Maurizio Lombardi wrote:
> > Hmm, this is not good indeed. I guess I should have used for_each_onlin=
e_cpu()
> > instead of on_each_cpu_cond().
>
> But you must not invoked that function cross-CPU since the code expects
> to access the per-CPU variables always from the local-CPU.

Ok, thanks for the clarification.

>
> > >
> > > Couldn't we instead use a workqueue with that WQ_MEM_RECLAIM bit? It =
may
> > > reclaim memory after all ;)
> >
> > That should also fix it, do you think it would be ok to allocate a work=
queue in
> > in kmem_cache_init() ?
>
> I guess so. There is probably none that is already available.
>

Will test it and submit a patch soon.

Thanks,
Maurizio

