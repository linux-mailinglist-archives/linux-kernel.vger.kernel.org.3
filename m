Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4535B533A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiEYJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiEYJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71C2915A21
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653472115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eronJ4hRlUNWVDCtpOVAUyBZNdAastySwvm71R1fwYM=;
        b=H8qtX8uDeDAMnWoc93R7YWk4TahUxvbmFqcZzzVq0VKho58cVz9rQDmEm4Cj/faPnT24Jm
        gglYYgIuK/KDDSMLtHe8vjOn5V4ZSSlzWWF7e9/p7Nz/O+3lC/NwIiDlAR2Fh1urkNBEWR
        qTkxgNjcplsJklIMm8bAM+k0f4DCOsI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-wwprK7fqNCmFyMzI69-qzw-1; Wed, 25 May 2022 05:48:34 -0400
X-MC-Unique: wwprK7fqNCmFyMzI69-qzw-1
Received: by mail-wm1-f70.google.com with SMTP id m31-20020a05600c3b1f00b003973a563605so5300201wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eronJ4hRlUNWVDCtpOVAUyBZNdAastySwvm71R1fwYM=;
        b=efJFibzZaXiDBb/vEjMBO4p/3HAre0kpq0DtfflOVfxGPlUEcBALHsg6OEXBoGqzbI
         +Hw/bynhHVufYQ3xiytLoELp/0d+x5ckcXk0pxd//Zss2+acXVsyd/O2h5hgs7+ps/F5
         F3SRhT44945wr8OgAG05gNScaSBJnf+uqzYRAO/d5kcEOsmdGtLq27Iis3S81728a/Wf
         +WLbryw48kRq593D6FLw8VEmACNvvUivdBFMr99gtGHLZpHbVDly/wtZWj3UovZKYN3k
         Vs38pPa+NGJdoiJDKM6FpQqu0I3m+ZC5muEOAOsnYHix4flgAwxGTd5Zs24TX9o6dQ7A
         HXxw==
X-Gm-Message-State: AOAM532O+vgPEocQegfqo3yJas81dHKw0XxuZbGHeEEYv5ShV1aCsQz3
        gXCXOR1CcCi88zLjHcN8cJ/XR3WDOdN14f1u2Tbm0M3Anf3ygm20ycZc1WoPiZ1vpTZudDk90Uk
        NVe4/AWOlGPwjSoQjRmTwjQXh
X-Received: by 2002:a5d:6da7:0:b0:20f:eb44:f3c3 with SMTP id u7-20020a5d6da7000000b0020feb44f3c3mr8496801wrs.621.1653472112940;
        Wed, 25 May 2022 02:48:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHqFUAYUTFp0aEXjKCMMTHR2HBwM3CPxoY+iLEBdAdUZ/keEF2bjRaSBD9lzGpTfRMzh3OyQ==
X-Received: by 2002:a5d:6da7:0:b0:20f:eb44:f3c3 with SMTP id u7-20020a5d6da7000000b0020feb44f3c3mr8496782wrs.621.1653472112720;
        Wed, 25 May 2022 02:48:32 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m8-20020a056000024800b0020fdc90aeabsm1646875wrz.82.2022.05.25.02.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 02:48:32 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuhp: make target_store() a nop when target == state
In-Reply-To: <Yo0KRVpfhUb8Ta4N@lorien.usersys.redhat.com>
References: <20220523144728.32414-1-pauld@redhat.com>
 <xhsmh35gzj77s.mognet@vschneid.remote.csb>
 <Yo0KRVpfhUb8Ta4N@lorien.usersys.redhat.com>
Date:   Wed, 25 May 2022 10:48:31 +0100
Message-ID: <xhsmhy1yqhrio.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/22 12:39, Phil Auld wrote:
> On Tue, May 24, 2022 at 04:11:51PM +0100 Valentin Schneider wrote:
>
>>
>> _cpu_up() has:
>>
>>      /*
>>       * The caller of cpu_up() might have raced with another
>>       * caller. Nothing to do.
>>       */
>>      if (st->state >= target)
>>              goto out;
>>
>> Looks like we want an equivalent in _cpu_down(), what do you think?
>
> Maybe. I still think that
>
>> >         if (st->state < target)
>> >                 ret = cpu_up(dev->id, target);
>> >         else
>> >                 ret = cpu_down(dev->id, target);
>
> is not correct. If we catch the == case earlier then this makes
> sense as is.
>
> I suppose "if (st->state <= target)" would work too since __cpu_up()
> already checks. Catching this sooner seems better to me though.
>

Yeah it would be neater to not even enter cpu_{up, down}(), but my paranoia
makes me think we need the comparison to happen with at least the
cpu_add_remove_lock held to make sure st->state isn't moving under our
feet, otherwise we may still end up with target == state in _cpu_down() and
hit the bug you're describing.

>>
>> >    ret = lock_device_hotplug_sysfs();
>> >    if (ret)
>> >            return ret;
>> > --
>> > 2.18.0
>>
>
>
> Cheers,
> Phil
>
> --

