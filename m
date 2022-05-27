Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627C3535D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbiE0Jil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350599AbiE0Jid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FBBA4BFC2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653644309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWBfsIbPUgPp+IdgwSvqqfPkbnVArM00S/JeXJWx878=;
        b=LuvCXkhgvSY7SimrhUg58SDKzMZz+5qKUZgrX/cBYO8KZjUnkyKUpZh9pbq8w2Nqa4ByIg
        J5deOFId5F/IReV/d6sEOmR3NPeAfwkYrZ1xfpZQnWlt/Fds+7f5jXbCMmgSjrxvkGOoA1
        mkDIRwPiMQDTPGzEyNRPXfgxBf2Q42E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-bU2VpNFFNLul-I8BdqfU-A-1; Fri, 27 May 2022 05:38:28 -0400
X-MC-Unique: bU2VpNFFNLul-I8BdqfU-A-1
Received: by mail-wr1-f72.google.com with SMTP id w17-20020adf8bd1000000b0020fc99aee61so695890wra.18
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jWBfsIbPUgPp+IdgwSvqqfPkbnVArM00S/JeXJWx878=;
        b=ERaZBc2VrJ2EJvS1sdcXioE5NVMo5buuVzCc8vTXSn+tWnkquICZD45hLkbd0t0kiK
         9adTFJTto4ySrcLgPh1hmRVNI91lmSFHDiKY+SsmXLZJdv2bfC71A/qUnfDDmQ8Hb6nk
         +SexoDaXbmrcfV6skYp0RNBlwIcS4S2PeOk+gHlubySoeTs8F687cDX6wnZxUF4ZqZs8
         oIKf6qO+IhTHfW96OVFDWPK7DLu/JLhcLrcqcR5/ipsydkfIY7rs/B6mSFwck2rW1fk2
         ed55GBrvz9EuzrdBldzEEwuYUD5X66oK3IQV+A1FA/GukKUJ1kwpQY9NsUAV66L3X5Fh
         vUOw==
X-Gm-Message-State: AOAM533EHGgF0UDhPCwJIk3abSyJcBcPdgKK+YlaRUM6xLWBgeyC90g2
        vlsFwmECg0J1rtor4c7TF9ArQrgfBjssaueIrbSGIkHiNkN+MgT1gbfYSOXAvTFMXWIvL2UDgik
        dZCXZQ5gn4hm9Z3K6a2qteaaB
X-Received: by 2002:a5d:525b:0:b0:20c:e010:b9f3 with SMTP id k27-20020a5d525b000000b0020ce010b9f3mr33297156wrc.291.1653644306389;
        Fri, 27 May 2022 02:38:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9dc/h6KnzcMF+c7w6r1D7Te0EsYMnDtoc3WdL3pOVVx8wuoMD5Yc1AuMYCRF28+tQg0N+pg==
X-Received: by 2002:a5d:525b:0:b0:20c:e010:b9f3 with SMTP id k27-20020a5d525b000000b0020ce010b9f3mr33297141wrc.291.1653644306042;
        Fri, 27 May 2022 02:38:26 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b00397393419e3sm1815525wmq.28.2022.05.27.02.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:38:25 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] cpuhp: make target_store() a nop when target ==
 state
In-Reply-To: <20220526160615.7976-2-pauld@redhat.com>
References: <20220526160615.7976-1-pauld@redhat.com>
 <20220526160615.7976-2-pauld@redhat.com>
Date:   Fri, 27 May 2022 10:38:24 +0100
Message-ID: <xhsmhy1ynl3hr.mognet@vschneid.remote.csb>
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

On 26/05/22 12:06, Phil Auld wrote:
> writing the current state back in hotplug/target calls cpu_down()
> which will set cpu dying even when it isn't and then nothing will
> ever clear it. A stress test that reads values and writes them back
> for all cpu device files in sysfs will trigger the BUG() in
> select_fallback_rq once all cpus are marked as dying.
>
> kernel/cpu.c::target_store()
> 	...
>         if (st->state < target)
>                 ret = cpu_up(dev->id, target);
>         else
>                 ret = cpu_down(dev->id, target);
>
> cpu_down() -> cpu_set_state()
> 	 bool bringup = st->state < target;
> 	 ...
> 	 if (cpu_dying(cpu) != !bringup)
> 		set_cpu_dying(cpu, !bringup);
>
> Fix this by letting state==target fall through in the target_store()
> conditional.
>

To go back on my data race paranoia: writes to both cpu$x/online and
cpu$x/hotplug/target are serialized by device_hotplug_lock, and so are the
exported kernel hotplug functions ({add, remove}_cpu()).

That's not cpu_add_remove_lock as I was looking for, but that's still all
under one lock, so I think we're good. Sorry for that!

> Signed-off-by: Phil Auld <pauld@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index d0a9aa0b42e8..cdb6ac10ad94 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2315,7 +2315,7 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
>  
>  	if (st->state < target)
>  		ret = cpu_up(dev->id, target);
> -	else
> +	else if (st->state > target)
>  		ret = cpu_down(dev->id, target);
>  out:
>  	unlock_device_hotplug();
> -- 
> 2.18.0

