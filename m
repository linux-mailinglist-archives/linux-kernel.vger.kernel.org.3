Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1157E69F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiGVSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 987FF7B1EB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658514938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4xFwLeu27SOsLoPyGfh0+QpaXnP2y9e0sTNZTVE09g=;
        b=ZSU8m/Ws891r1KZ0KoaIblS3igaqLx51KwqHrT6rTuHspFFqn/uS7d9eaMuH1p6buJ+bxU
        gSnPI4YXXNu2wkHubeqtjo9WLR2d485JkLimYbNTWVref7gDcNTR0C6ZX8bRJv/cFMWZuc
        vj3kHzCnDlVC52lE6W4HurWllpe4VJs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-qZ3zDxriNZe4EAkXl5rUpw-1; Fri, 22 Jul 2022 14:35:37 -0400
X-MC-Unique: qZ3zDxriNZe4EAkXl5rUpw-1
Received: by mail-wm1-f69.google.com with SMTP id v132-20020a1cac8a000000b003a34081050bso1340666wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x4xFwLeu27SOsLoPyGfh0+QpaXnP2y9e0sTNZTVE09g=;
        b=QoW4xOAZMGSV9dPb4tMN7lgJUonJ9nim5dDUiF8Sw3WEHFXWRzxgtSyT6PMAGqp+yy
         ZWHPThRodjha5RrVRMdU34UpbiNAgqkorTISJyEEFAfkVkaKq8UCI9AHvFWlsQTabkT1
         VIVJhKL+usGoT1WocrWygyw404zToJjS7YXyS25TqiOI78BJifNUd1P78Nx1ZmUC9f69
         D2WURhImwfBwranWjtDQJDTiWUB4jfSN/xdvaGEBTJeS4FY/H00jJq38IO5rZKOmLM0l
         UWHKgWyGQBqH85+ycxJ6xABuGRaOE+NiKR9pRgh6F24O/c2HAvOwgmp1JlvSih6CKMxr
         iiMQ==
X-Gm-Message-State: AJIora8vxuRGVJb0G8G+XTIudd4DhQo/eGjd516YsS0HUCFy7JdJFXUC
        w+ERqmcWUdGsoqIbkh/4uhwJTPFktOhdApM2CJf3HtFcKaDuLno2yfty1MwojamTqmw1sBb6r7u
        ACcJObLbZvN2vrADcmJcxMcEw
X-Received: by 2002:a5d:6e88:0:b0:21a:3403:9aa0 with SMTP id k8-20020a5d6e88000000b0021a34039aa0mr809577wrz.379.1658514936405;
        Fri, 22 Jul 2022 11:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vj3VxCK5vYPoOQFZdp4W63WksitPvwbHwibhhULkPD/K1TdE+Y0eqLKIjUkVErAiw7A0taIA==
X-Received: by 2002:a5d:6e88:0:b0:21a:3403:9aa0 with SMTP id k8-20020a5d6e88000000b0021a34039aa0mr809570wrz.379.1658514936151;
        Fri, 22 Jul 2022 11:35:36 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003a33227e49bsm5594126wms.4.2022.07.22.11.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:35:35 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        kernel-team@android.com, Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v4] cpu/hotplug: Do not bail-out in DYING/STARTING sections
In-Reply-To: <YtbSP21k1hTKGlqv@google.com>
References: <20220704131346.2650163-1-vdonnefort@google.com>
 <xhsmhfsix6ssc.mognet@vschneid.remote.csb> <YtbSP21k1hTKGlqv@google.com>
Date:   Fri, 22 Jul 2022 19:35:34 +0100
Message-ID: <xhsmhilnpf11l.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/22 16:48, Vincent Donnefort wrote:
> On Tue, Jul 19, 2022 at 04:12:03PM +0100, Valentin Schneider wrote:
>> On 04/07/22 14:13, Vincent Donnefort wrote:
>> > +static int _cpuhp_invoke_callback_range(bool bringup,
>> > +					unsigned int cpu,
>> > +					struct cpuhp_cpu_state *st,
>> > +					enum cpuhp_state target,
>> > +					bool nofail)
>> [...]
>> > +		if (nofail) {
>> > +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
>> > +				cpu, bringup ? "UP" : "DOWN",
>> > +				cpuhp_get_step(st->state)->name,
>> > +				st->state, err);
>> > +			ret = -1;
>>
>> On a single failure we'll get two warns (WARN_ON_ONCE() + pr_warn(), and
>> then subsequently just the pr_warn()), is that intended?
>
> It does, this is to keep the backtrace that used to be here... but now, giving
> a second thought, we can probably get rid of it and just keep the pr_warn()?
>
>>
>> Also, why not have ret = err here?
>
> If two states fail, the ret wouldn't mean much, hence a default "-1" just for
> the WARN_ONCE.

Right

> But if we drop the latter, that would simplify the problem of
> knowing which error code to return.
>

We need to drop one of the two, the pr_warn() will probably be more useful
if/when we need to debug this, so go for it.

