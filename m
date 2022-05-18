Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0452B1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiERErC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiEREqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:46:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C3727FE2;
        Tue, 17 May 2022 21:46:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso939804pjg.0;
        Tue, 17 May 2022 21:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lh4QMEy0OYa/w9VsWX5Dd9zfgcDyoyYIzCZd6cD6mMk=;
        b=k0WF2lHm6tKfnP37cQJzLYSNbraqLzHmDa8jDHPYIyE7djMLYvBzPT7tacbBhqQRi+
         7BcRdzKM/sn6eFiexTnXji1VZby9f4xy7GQzeRa4sQMcD1MM+QeXFVN4iTAMGDjvlk3T
         aW5c0OfVQUSoznfDG1C+PCMMZjBoCIfnRMmYnK3IYmqTojCIcu9zRsDit0iyNy7zrlys
         DTDzPdx99wjQa+C0yxgE16TC6QLzPSWfZtwUXrN+l3U3tL1kpkFciObgCDcw3qwo/2CH
         IppRUQINh4l9aEoM475GDDCOsMPEy7F2BnF1ugJWFc3J2LDj18zWQs5/9ds+f2e88Pke
         +2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lh4QMEy0OYa/w9VsWX5Dd9zfgcDyoyYIzCZd6cD6mMk=;
        b=IFuO2UpyLkCmlYKRGPc8w4vN8q9UQkJOUfrGxu3tkwpD/RslOJKfSTvS2ib2Q3264B
         8dacsxvlzBog1cJQcjIuAsI4UfM0U5wQ5JEIMdHt1Q6RlaxgsAfGEbd93m/59Be0a6zt
         HyhsJsh67/pj7IfmlQqt7Lvy+qe3Mq5jrEcOYfcfuhB1qjMmqj/mM/IXK0v78kASeHLl
         EMjs4/29UQBYaYHXOSuvOtdxfNih2wCWRKXiuNyhX8ZN6yftiugImELFIEWjpcEJAFUv
         eIkqUDFDT5ygaftT1OUUZxwkJUOn+xw36e5scWlRVCCpi9OBo71lrxQsMLwQa1B8WIcH
         fFdA==
X-Gm-Message-State: AOAM530S8oqhAilkxw6AsRnIFGG6Ia5yNv1d/rquEmNQqyd+O5xlYILu
        ShrFpSKYhlQd4faEwHs6PbOC4VlAmBE=
X-Google-Smtp-Source: ABdhPJwACyIGzYZX2CTl///3kAuULdPIzgssDNaZ9f52Hh9IG0S2/PD3RUL93C728N/EEGYNVJcXaw==
X-Received: by 2002:a17:903:124b:b0:15e:84d0:ded6 with SMTP id u11-20020a170903124b00b0015e84d0ded6mr24919023plh.141.1652849212005;
        Tue, 17 May 2022 21:46:52 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:556b:348:b181:320f])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ab9000b0016191b843e2sm477040plr.235.2022.05.17.21.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 21:46:50 -0700 (PDT)
Date:   Tue, 17 May 2022 21:46:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: gpio-keys - Cancel delayed work only in case of
 GPIO
Message-ID: <YoR6N2ACf3TZr1P5@google.com>
References: <20220513132500.32395-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513132500.32395-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

On Fri, May 13, 2022 at 02:25:00PM +0100, Lad Prabhakar wrote:
> gpio_keys module can either accept gpios or interrupts. The module
> initializes delayed work in case of gpios only and not for interrupts,
> so make sure cancel_delayed_work_sync() is called only when bdata->gpiod
> is true.
...
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index d75a8b179a8a..ec9d50ddda42 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -133,7 +133,7 @@ static void gpio_keys_quiesce_key(void *data)
>  		hrtimer_cancel(&bdata->release_timer);
>  	if (bdata->debounce_use_hrtimer)
>  		hrtimer_cancel(&bdata->debounce_timer);
> -	else
> +	else if (bdata->gpiod)
>  		cancel_delayed_work_sync(&bdata->work);

We already have a check for bdata->gpiod a couple lines above. I think
the chunk should look like this:

	if (!bdata->gpiod)
		hrtimer_cancel(&bdata->release_timer);
	else if (bdata->debounce_use_hrtimer)
		hrtimer_cancel(&bdata->debounce_timer);
	else
		cancel_delayed_work_sync(&bdata->work);

since we use debounce timer/work only when we deal with gpio-backed
keys.

Thanks.

-- 
Dmitry
