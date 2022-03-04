Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1054CDBC8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbiCDSGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbiCDSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:06:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270FC1C4B07
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:06:02 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q17so11789855edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScIINym/s1zYwdre28Fn9pTUeIcuABEqsfOfpBejDew=;
        b=gTDLuJI8Mi9+ftvhMPpwI3xkvmlECcV27R9BSVD6hXT0HmVBRR0FwwoLXYb6N1Al2i
         bK/j3t1B1Ljjq+Fc5+0SWeynkJdvwuff3j4suXxefwL460DXjznAMYUx8jShSKhXaT81
         LAKUCxOZsJQtuiy2ZURKJeOVgZdTpa69HCVI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScIINym/s1zYwdre28Fn9pTUeIcuABEqsfOfpBejDew=;
        b=PAuDFvDOuqSNLDEuOM/aamS0Pr64zhZbB6cCoOB1TlgdHcZgu9hE6+lBDOe6wizopD
         4E61TxMdtxF80+U+wibQXDL0ah7pwVbSJa6TMDtNY4fyhSnLUC41RQvxXz6J2+zNaTeA
         5km4N91U9YibcO7b50ytarE2A00XThADvZncxnRDSQ10XiPuhlsNZseP9QktZHH8SgJo
         6JcMjrOhbvlsH8jwsHtW6mgz0wr96GhNY4j51P6NTwPMjAUuyzLa1vS8KFeDNWEeOGBo
         QSvUaLpU4o68fYRs95koWzymZSK9Rvj2nBZCT/M1kRXrPOVo1ay24hk33m3UAAYP/E9a
         bMyg==
X-Gm-Message-State: AOAM532yxfujjnJz0kUq8SyBfqQx54ay3fA8ha37chvDEwch7EO4p0MP
        zK4xf10bMSzPYKCa5Xa4KiFVaRioCMBgH/0w
X-Google-Smtp-Source: ABdhPJy/ghy3P1W4sXvxPna/Jk8qVujqHuoDP2qFM6JpRaCr4dVNMv8bOUDeQcu1PhafCvbMtLFFaA==
X-Received: by 2002:aa7:d543:0:b0:416:13eb:6fec with SMTP id u3-20020aa7d543000000b0041613eb6fecmr1807467edr.348.1646417160241;
        Fri, 04 Mar 2022 10:06:00 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id u19-20020a17090617d300b006cea86ca384sm2012805eje.40.2022.03.04.10.05.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 10:05:59 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id j26so3469773wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:05:58 -0800 (PST)
X-Received: by 2002:a5d:64ed:0:b0:1f0:6672:f10c with SMTP id
 g13-20020a5d64ed000000b001f06672f10cmr4171901wri.679.1646417158156; Fri, 04
 Mar 2022 10:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20220304064324.331217-1-hasegawa-hitomi@fujitsu.com> <20220304064324.331217-2-hasegawa-hitomi@fujitsu.com>
In-Reply-To: <20220304064324.331217-2-hasegawa-hitomi@fujitsu.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Mar 2022 10:05:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Udf=MzyPa_o=vz=nc7ZVXBuuVNqw-VOSfrShuv0hN64Q@mail.gmail.com>
Message-ID: <CAD=FV=Udf=MzyPa_o=vz=nc7ZVXBuuVNqw-VOSfrShuv0hN64Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tty/sysrq: Make sysrq handler NMI aware
To:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>, linux-serial@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 3, 2022 at 10:45 PM Hitomi Hasegawa
<hasegawa-hitomi@fujitsu.com> wrote:
>
>  void __handle_sysrq(int key, bool check_mask)
>  {
>         const struct sysrq_key_op *op_p;
> @@ -573,6 +606,10 @@ void __handle_sysrq(int key, bool check_mask)
>         int orig_suppress_printk;
>         int i;
>
> +       /* Skip sysrq handling if one already in progress */
> +       if (sysrq_nmi_key != -1)
> +               return;

Should this give a warning?

Also, can you remind me why this is safe if two CPUs both call
handle_sysrq() at the same time? Can't both of them make it past this?
That doesn't seem so great.


> @@ -596,7 +633,13 @@ void __handle_sysrq(int key, bool check_mask)
>                 if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
>                         pr_info("%s\n", op_p->action_msg);
>                         console_loglevel = orig_log_level;
> -                       op_p->handler(key);
> +
> +                       if (in_nmi() && !op_p->nmi_safe) {
> +                               sysrq_nmi_key = key;
> +                               irq_work_queue(&sysrq_irq_work);

It looks like irq_work_queue() returns false if it fails to queue.
Maybe it's worth checking and setting "sysrq_nmi_key" back to -1 if it
fails?

-Doug
