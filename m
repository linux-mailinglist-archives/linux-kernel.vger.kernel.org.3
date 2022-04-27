Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6DA5117D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiD0Lxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiD0Lxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFDE212EB78
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651060227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8PqE4iMUPFqCcEpgWE5Kb02oz8+U7so76j9i/Ng+DY=;
        b=JcJ0GTTC0PdKSeb4FV1XoHlcP6LTsML9BT2C1NUSG6IYe/k8g0PpuKa0V65j90sTGdY1Wg
        /+UMbxOCHgd8T5zoPi4zeFF6n+MVTbZ4hrXeeI00bLwcDz0V/v0e2qCmh6RBSYRgMMguh2
        Y0c3Bb9JWiHkGk+KG3IPzh6Xya7WkZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-fIUCw_7DNmi3VP8wvjY9_g-1; Wed, 27 Apr 2022 07:50:23 -0400
X-MC-Unique: fIUCw_7DNmi3VP8wvjY9_g-1
Received: by mail-wr1-f70.google.com with SMTP id o11-20020adfca0b000000b0020adc114131so661130wrh.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J8PqE4iMUPFqCcEpgWE5Kb02oz8+U7so76j9i/Ng+DY=;
        b=1O3hpQi2796mqUD4/wvPjgRtXdbA6TaOuV2FEOVdW33F86I3bSd6MouH1kBiUi+Yns
         OGQq0PEjgIcbT78BpCvxDvzLErEgcT7r8C++zuFlYssKThhXgHzHDqXfw+NstE+32bAk
         8x/byzmXuAHaahnm8tJ+053i9hIqIxAQIsJDAzUR5EoprH+bBk6siL9gccf1OhY/+3jB
         WnKS+7g20+NVTGpQO3m+LDaM85hiJ1cG/G6D1az80hvLxgGq26YUAzj9amCpMoFphDer
         hnIh4KjGGKTWZh7KUaoYr/QkXYReUPoJbFi6o5UnP6iJjylsDX2DWvmW65iZDhr8V9BE
         FlYQ==
X-Gm-Message-State: AOAM533VQoTrJitqiBfiz08dp9iOjDDO+bK0XgVTUt0DSrlzTVSdXzaD
        bnI5S1EyVOh7pAigdvop5H1fE5bv4XZ8gm2GIbrJsUVcO2kBUjmds3txGZB3NjKBmdSO7CPOH/I
        O3/3i8ffbX8ykQEX9LUhhpx8=
X-Received: by 2002:adf:d1ea:0:b0:20a:2823:9e22 with SMTP id g10-20020adfd1ea000000b0020a28239e22mr22270414wrd.332.1651060222725;
        Wed, 27 Apr 2022 04:50:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxruJAcFFnwCKM2VIWdU+E2VKz7/9vQJEA5ARsZEoZUTPcTbcsCslaRw0/qYREPWJUz4acTdQ==
X-Received: by 2002:adf:d1ea:0:b0:20a:2823:9e22 with SMTP id g10-20020adfd1ea000000b0020a28239e22mr22270403wrd.332.1651060222535;
        Wed, 27 Apr 2022 04:50:22 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f66-20020a1c3845000000b00393e84ea043sm1390797wma.44.2022.04.27.04.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 04:50:21 -0700 (PDT)
Date:   Wed, 27 Apr 2022 12:50:20 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@gentwo.de>, frederic@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220427115020.kyaxc5j67lq5zrfq@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
 <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
 <20220425132700.GK2731@worktop.programming.kicks-ass.net>
 <20220425141717.vw2jfnn3zp6c5ib2@ava.usersys.com>
 <Ymb018EaVlOUfx87@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ymb018EaVlOUfx87@fuller.cnet>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-04-25 16:21 -0300, Marcelo Tosatti wrote:
> > Hi Peter, Christoph,
> > 
> > Indeed. Which was why I decided, initially, against the general-purpose
> > case/or approach. Personally, I would prefer to keep this somewhat
> > restrictive to nohz.
> 
> Is there anything that prevents a nohz full CPU from running an
> application with short and frequent idling?

Hi Marcelo,

I'm not sure I understand the question; albeit, if I understand correctly,
yes: the scheduling-clock tick, if it was stopped.
Yet I believe this behaviour is correct. Consider the following example:

  When a CFS task is moved/or migrated to a nohz_full CPU that was
  previously idle and had its tick stopped, if its the only task on the
  run-queue then it is possible that the idle task may not restart the
  tick (see __tick_nohz_full_update_tick()).  Thus once the CFS task exits
  manual intervention i.e. a reschedule IPI to wake the idle task, would be
  required to run again, on the same CPU.



Kind regards,

-- 
Aaron Tomlin

