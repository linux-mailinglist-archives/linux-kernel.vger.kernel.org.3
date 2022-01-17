Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E3C4911AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiAQWUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiAQWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:20:42 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14642C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:20:42 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q186so25657404oih.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xhr/8PyjF82playpsZgDwn7GZ3zk/pxys25m7YWmU/8=;
        b=G/FZBWn/6nacx9MKONmB44KAKpK06JvnT6PA3mnA4URLwtFFRbidb4sFIgLTe5uzdz
         kofrM1qeA89dfv94hoSveCD+adff1/Fi0WSxxHz84zfw2qutyIzySwWOo+u/rsa7cKlV
         eojQ5dlYfUqX0tHEdvYUKjUlBKve9UOpKixmBJwp0O1QGkIq408omGDLFv4uOdBPjUeY
         ueZkUSccCNtxzBxdgn+67OBl3rVX7AbiIHLyi9Mp0xT/AkYouPaoPCIsXrNuFjWH7FVW
         3lHZuQhvWFXnIHOmv1jsnFsI2oKQlosXbgwOe3eMe3GJaFGggN3RGJAOuq95G6vZNMLg
         yUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xhr/8PyjF82playpsZgDwn7GZ3zk/pxys25m7YWmU/8=;
        b=FUMXk6hGWb/UO8QE6RvylzT53UV6k5+ehnoCxLwwXFFOfsenPqIFw8OVvdQD6H/WZI
         uxxGxlVL44oF/OwRV1CwN3XKtdOn6b8ZgiwvTExWWwuV5AGtMFT8ypXA4YXPfJ4YtE2z
         DccifYA5t3XRGg37FaRI5FuyDlfboKrBUXEGMvS8cQCLoLr5xou1J9z0K/tDa9o25z6E
         Q6dC/zdvINOcomYKOlZ6k7hO4lN64okTmI+WCvtFpZAVmX5Llw0U4sG0CLglMdegaEtb
         r/0fLJiMZQ4KG5fO2XZEFLCq8yc5BuExU5OZPKokrFCDd4WhPWlpgTIXnH/Zo/6H5SRc
         2DVw==
X-Gm-Message-State: AOAM5320Y1nMd3Zib2Co5H9Ql/WhEVF1AFx9IY01/s52FDW1NjanvSDq
        07biChN0D8dCLIpeRRR9xyreUvi++AjYNg==
X-Google-Smtp-Source: ABdhPJy/GoE19ffhi1guWHFtKQBoh6FhV0xuxaGd79tXyqyoq+uTAvG91zjYU29gXo/yrDv9mWnCWg==
X-Received: by 2002:a05:6808:aa7:: with SMTP id r7mr8584981oij.47.1642458041421;
        Mon, 17 Jan 2022 14:20:41 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i22sm1454643ood.36.2022.01.17.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 14:20:40 -0800 (PST)
Date:   Mon, 17 Jan 2022 16:20:38 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Query on moving Recovery remoteproc work to a separate wq
 instead of system freezable wq
Message-ID: <YeXrtuQglDwhNvLm@builder.lan>
References: <ea64436c-3d9b-9ac1-d4e8-38f15142a764@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea64436c-3d9b-9ac1-d4e8-38f15142a764@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Jan 09:09 CST 2022, Mukesh Ojha wrote:

> Hi,
> 
> There could be a situation there is too much load(of tasks which is affined

As in "it's theoretically possible" or "we run into this issue all the
time"?

> to particular core) on a core on which  rproc
> recovery thread will not get a chance to run with no reason but the load. If
> we make this queue unbound, then this work
> can run on any core.
> 
> Kindly Let me if i can post a proper patch for this like below.
> 
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,
> 
>  /* Unique indices for remoteproc devices */
>  static DEFINE_IDA(rproc_dev_index);
> +static struct workqueue_struct *rproc_recovery_wq;
> 
>  static const char * const rproc_crash_names[] = {
>         [RPROC_MMUFAULT]        = "mmufault",
> @@ -2487,7 +2488,7 @@ void rproc_report_crash(struct rproc *rproc, enum
> rproc_crash_type type)
>                 rproc->name, rproc_crash_to_string(type));
> 
>         /* Have a worker handle the error; ensure system is not suspended */
> -       queue_work(system_freezable_wq, &rproc->crash_handler);
> +       queue_work(rproc_recovery_wq, &rproc->crash_handler);
>  }
>  EXPORT_SYMBOL(rproc_report_crash);
> 
> @@ -2532,6 +2533,12 @@ static void __exit rproc_exit_panic(void)
> 
>  static int __init remoteproc_init(void)
>  {
> +       rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq", WQ_UNBOUND
> |
> +                               WQ_HIGHPRI | WQ_FREEZABLE |
> WQ_CPU_INTENSIVE, 0);

Afaict this is not only a separate work queue, but a high priority, "cpu
intensive" work queue. Does that really represent the urgency of getting
the recovery under way?

Regards,
Bjorn

> +       if (!rproc_recovery_wq) {
> +               pr_err("creation of rproc_recovery_wq failed\n");
> +       }
> +
> 
> Thanks,
> Mukesh
