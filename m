Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F035632A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiGALf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiGALfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8F3E814AB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656675320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05bIgefiv16EpC8Yc230xnK8NNecE7UZG2YT1DC4NvQ=;
        b=cu4q2mXOEj/UKQ7W0argdNiAdmGPbAvQhkQ6FXzLDSAv2MR40sCl6e8zpo5jmS3FKuIKP0
        nqFgVrr+fJ0wtcE5FTeFojF3t4wCW7jAqjnvLeAqLNRW1QBditCK0iT994BZptBI71SPaq
        Y6TjcV+lrjVRFp7gLPtRPSM+8+5rT/A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-SN2ZSiEfPLeRlSqp993Ajw-1; Fri, 01 Jul 2022 07:35:19 -0400
X-MC-Unique: SN2ZSiEfPLeRlSqp993Ajw-1
Received: by mail-qv1-f69.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso2397364qvb.15
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 04:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=05bIgefiv16EpC8Yc230xnK8NNecE7UZG2YT1DC4NvQ=;
        b=TMxwV2ufPKfUUPNavpXj4QjPbX75kQsxbD8V5Ptw36YxUjlAOCdjjUmFwInZSySS8U
         HRnfhkzJovAXgfUFX86tGC6qzp/mgEtamuCgzJ1ITY1uacxH3m4SDonLXMi3vpDqw1Hu
         sXNNhttVWZufKvxOKjwSOkm9IZu3gnFqiFWnTYS328SG43413zL7kktJPZErejbFumM2
         iCGVryou7QC1EzubsLekcLfkL/vU4mUaACwWxZ/F8NnrbvR6BLZiCjirvWp0STp2PSXR
         NweuOXliqCx12Xi1r5uB2HIYDfdqhPTWVIHPUMy6fGktDWxX6iCNYAyLcYp0M81FxS2B
         dsdw==
X-Gm-Message-State: AJIora/XKhO+RkI7BIqT3mp/XSaTHCE1V4ZmhRVV/yuVWWPrSih3SZGK
        J+DbJIuVcSHhqErpZHRKpk4MzuporV3yQgq88Y0Ggi6BqLJkR9qNE1pbsYMjTxUurAKg5CIFtTL
        VLMMMvqlwPTJ+/Nx8wNWi6wvH
X-Received: by 2002:ac8:7c43:0:b0:31d:34c1:4d85 with SMTP id o3-20020ac87c43000000b0031d34c14d85mr4310298qtv.613.1656675319316;
        Fri, 01 Jul 2022 04:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vlD+uM2f7dPzo7SzDDh0gELWUPres1PcCogeYqRFt6rZzEuBvqARCX+A0i+mJfuMqlRqD9dw==
X-Received: by 2002:ac8:7c43:0:b0:31d:34c1:4d85 with SMTP id o3-20020ac87c43000000b0031d34c14d85mr4310273qtv.613.1656675318994;
        Fri, 01 Jul 2022 04:35:18 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac? ([2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a400f00b006af147d4876sm15665068qko.30.2022.07.01.04.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 04:35:18 -0700 (PDT)
Message-ID: <238f23ab72d99c3d2737a1ef0b68aebe60de8f8a.camel@redhat.com>
Subject: Re: [PATCH] nohz/full, sched/rt: Fix missed tick-reenabling bug in
 dequeue_task_rt
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com
Cc:     bristot@redhat.com, cmetcalf@ezchip.com, mgorman@suse.de,
        bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, mtosatti@redhat.com
Date:   Fri, 01 Jul 2022 13:35:15 +0200
In-Reply-To: <xhsmhedz55b2v.mognet@vschneid.remote.csb>
References: <20220628092259.330171-1-nsaenzju@redhat.com>
         <xhsmhedz55b2v.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-01 at 12:25 +0100, Valentin Schneider wrote:
> On 28/06/22 11:22, Nicolas Saenz Julienne wrote:
> > dequeue_task_rt() only decrements 'rt_rq->rt_nr_running' after having
> > called sched_update_tick_dependency() preventing it from re-enabling th=
e
> > tick on systems that no longer have pending SCHED_RT tasks but have
> > multiple runnable SCHED_OTHER tasks:
> >=20
> >   dequeue_task_rt()
> >     dequeue_rt_entity()
> >       dequeue_rt_stack()
> >         dequeue_top_rt_rq()
> >         sub_nr_running()	// decrements rq->nr_running
> >           sched_update_tick_dependency()
> >             sched_can_stop_tick()	// checks rq->rt.rt_nr_running,
> >             ...
> >         __dequeue_rt_entity()
> >           dec_rt_tasks()	// decrements rq->rt.rt_nr_running
> >         ...
> >=20
> > Every other scheduler class performs the operation in the opposite
> > order, and sched_update_tick_dependency() expects the values to be
> > updated as such. So avoid the misbehaviour by inverting the order in
> > which the above operations are performed in the RT scheduler.
> >=20
>=20
> I can't see anything wrong with your approach, though I did have to spend
> some time re-learning RT_GROUP_SCHED. The designated Fixes: commit looks
> about right too.
>=20
> > Fixes: 76d92ac305f2 ("sched: Migrate sched to use new tick dependency m=
ask model")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
>=20
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks!

--=20
Nicol=C3=A1s S=C3=A1enz

