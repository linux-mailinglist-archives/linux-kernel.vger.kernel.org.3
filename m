Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1BC57A1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiGSOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbiGSOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE7896175
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658241255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZg2cZmf6hGrHSxOeYKPZO01j9dYhoqI1V9JbnPWjHs=;
        b=CbzoO0wcYEw3848Ytu8AfLGLPOGY4ja36skJaRlztc7aLi5EE26YX+KX+EENos3pZKVSuS
        Z4KKnMgRYr/RSQ2S/08oghRq8yfy+FSCIdk6jYQYHtBC43rOqko0yUQr7z6+AQwirwPpLH
        1oLHKlu/pvxI01QMaYM38ii604TeTxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-X8-ZaXc2PP2W0X1RxvbnlQ-1; Tue, 19 Jul 2022 10:34:07 -0400
X-MC-Unique: X8-ZaXc2PP2W0X1RxvbnlQ-1
Received: by mail-wr1-f70.google.com with SMTP id l17-20020adfc791000000b0021dc7dc268dso2315493wrg.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kZg2cZmf6hGrHSxOeYKPZO01j9dYhoqI1V9JbnPWjHs=;
        b=RU0Hlv03bnTpKV5g01RmYHzuPFh6w976mBLpbTwZrHYNzZvJMaf+VQbOS5Ba+iQZUu
         lL+S5bc02D9dldI2SfMA8979wXsfqGAPpSHMfJdhCmwRA5g4uKGG2KvioIm3b+cD2u5a
         Jvu2CfB4570PomvvJW0HGCq/7Pao1wjAcfaCVHIgPiq5MwYcfEWIZSsj3wXRIJKUdJgT
         wELsevmB1VlwaYQK0ES2YBEMbnYnOKPgSN5AjaWhJjLI/GrQ2GgCDnptzn/9gFTPJauy
         QPHaWNfTDbbD051D7CaURSKOTZ4P9HPaHgB/bpeepRRlROA1xfVcOmWYhArad7L83Mk8
         F7Hg==
X-Gm-Message-State: AJIora9XkwciHfhEM868eHqo8uorceHJcuYEhdxiGdkeDg/JJ+jvSp0f
        y3DmNuJP8DfSRiHbKCDPpwHo3snGRQshVhADpyDiIm92oqlf8tLFzJnQ9cIuiIQ1f1/pXTk7vwS
        zV5Y1kUHYq+UOv3VFirSG43bV
X-Received: by 2002:a05:600c:4eca:b0:3a1:9c39:ac20 with SMTP id g10-20020a05600c4eca00b003a19c39ac20mr37375620wmq.61.1658241245564;
        Tue, 19 Jul 2022 07:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vF2t4k1Dw5AmQrA+cG8EMbo7SySCI6IamIL1OhnNbMT7T4iiuU6S3lmVm/ECzG0GEwOTJC4w==
X-Received: by 2002:a05:600c:4eca:b0:3a1:9c39:ac20 with SMTP id g10-20020a05600c4eca00b003a19c39ac20mr37375600wmq.61.1658241245397;
        Tue, 19 Jul 2022 07:34:05 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c428a00b003a2fc754313sm18032475wmc.10.2022.07.19.07.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:34:04 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/2] cpuhp: make target_store() a nop when target ==
 state
In-Reply-To: <20220711211619.112854-2-pauld@redhat.com>
References: <20220711211619.112854-1-pauld@redhat.com>
 <20220711211619.112854-2-pauld@redhat.com>
Date:   Tue, 19 Jul 2022 15:34:03 +0100
Message-ID: <xhsmhk0896ujo.mognet@vschneid.remote.csb>
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

On 11/07/22 17:16, Phil Auld wrote:
> writing the current state back in hotplug/target calls cpu_down()
> which will set cpu dying even when it isn't and then nothing will
> ever clear it. A stress test that reads values and writes them back
> for all cpu device files in sysfs will trigger the BUG() in
> select_fallback_rq once all cpus are marked as dying.
>
> kernel/cpu.c::target_store()
>       ...
>         if (st->state < target)
>                 ret = cpu_up(dev->id, target);
>         else
>                 ret = cpu_down(dev->id, target);
>
> cpu_down() -> cpu_set_state()
>        bool bringup = st->state < target;
>        ...
>        if (cpu_dying(cpu) != !bringup)
>               set_cpu_dying(cpu, !bringup);
>
> Fix this by letting state==target fall through in the target_store()
> conditional. Also make sure st->target == target in that case.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>

One nit below, otherwise:
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bbad5e375d3b..305694a2ca26 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2326,8 +2326,10 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
>
>       if (st->state < target)
>               ret = cpu_up(dev->id, target);
> -	else
> +	else if (st->state > target)
>               ret = cpu_down(dev->id, target);
> +	else if (st->target != target)

Should we make this:

        else if (WARN(st->target != target))

> +		st->target = target;
>  out:
>       unlock_device_hotplug();
>       return ret ? ret : count;
> --
> 2.31.1

