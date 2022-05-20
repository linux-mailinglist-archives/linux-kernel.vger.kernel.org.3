Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4552EA87
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348369AbiETLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiETLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:11:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891A01C115
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:11:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j6so7465048pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uaa00xEzMAT264ixc/l0jbLyNQxuxXIt7JbL8gFbxGc=;
        b=NynBBm/2O7cP307yZ8aUc3cRrv+lrugZQcvavT85BAtZwbJtf8O/uKFCgcZQR5S8/n
         6E2veCYZjSwp7KX5Qg8ouCTG0OW3xS06pd8H7OEdUWxQgbDFXExFGJbVW9YjkSECmfwb
         2rvyRBj3nSAg+Qr7urXHzTahI8eoWwa+aKUH493eG1ObtBpX6smhb3kb2IGH2gG6ZOkk
         CSIdL78UDssFUUOTZaPd/2NrfXVdhFecgf6u10seQalAtJ28WbvtOUzpVYzgBnbA7HHf
         g7pPoHQkw+sL/weLf718gZfnYw13uTypUKmSSPSvISM0AtONvUWCB8DpJ/8opVOKTSOH
         KQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Uaa00xEzMAT264ixc/l0jbLyNQxuxXIt7JbL8gFbxGc=;
        b=xNNer+IGdqvRt700nfcuHJ+yOrm30m2FIYSs6155KmbYVCoch5lkyNBRUNZCvghjUV
         UNjdFvKnIGELHHQ+OuQT15hdVhCbITHb0Ty8KEv20aO36uR/7dymv6eEop4qEOX02Y0q
         HGZhWtku6wpKMiBpIKYgTp3xB+BTePHVxhu5RG7ryCt4I72aF8R7U0GvRh728lBGNMhz
         f+NR1OaWvs0cqCfo8XLUOI9q3rdmXy+vCzVlcvVb+yo7V526j8/wTvCe3uvRjUIggN/O
         utBd9dmWGfbPsQWtz9c+YZRgAM+8b7JBrCXkegyIoO+ELBtkRwYYROI9lJFVYas8YbzR
         WTtA==
X-Gm-Message-State: AOAM53383udT+QTTNj9IcHG+EdySkc1GDTwBUZrSEk7uORabk/xc/FKD
        hF2d/AhHW8vLOpSHuz63J5dNGj7SYhg=
X-Google-Smtp-Source: ABdhPJz+GT67ZQr2kr+MHQCAea0xiwvhAQs5MFjIww7Bjm3YNddJHnbBU5A3ZuzMCGCGOnCODI9Y0A==
X-Received: by 2002:a05:6a00:b56:b0:510:8107:5cf8 with SMTP id p22-20020a056a000b5600b0051081075cf8mr9396199pfo.2.1653045069441;
        Fri, 20 May 2022 04:11:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902714c00b0015f0dcd1579sm5285513plm.9.2022.05.20.04.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:11:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 20 May 2022 01:11:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Message-ID: <Yod3S8jmle+LYlES@slm.duckdns.org>
References: <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
 <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, May 20, 2022 at 06:51:12PM +0900, Tetsuo Handa wrote:
> On 2022/05/20 17:01, Tejun Heo wrote:
> >> +/*
> >> + * Detect attempt to flush system-wide workqueues at compile time when possible.
> >> + * See https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp for
> >> + * reasons and steps for converting system-wide workqueues into local workqueues.
> >> + */
> >> +#define flush_workqueue(wq)						\
> >> +({									\
> >> +	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_wq) &&	\
> >> +			 &(wq) == &system_wq,				\
> >> +			 "Please avoid flushing system_wq.");		\
> > 
> > It kinda bothers me that this causes a build failure. It'd be better if we
> > can trigger #warning instead. I'm not sure whether there'd be a clean way to
> > do it tho. Maybe just textual matching would provide similar coverage? How
> > did you test this?
> 
> This does not cause a build failure, for this wrapping happens only if
> flush_workqueue() appears between "#define flush_workqueue(wq)" and
> "#undef flush_workqueue". Only flush_scheduled_work() in include/linux/workqueue.h
> calls flush_workqueue(system_wq), and flush_scheduled_work() is defined
> before the "#define flush_workqueue(wq)" is defined.

What I mean is that if there's a file which didn't get tested or another
pull request which raced and that thing flushes one of the system_wq's,
it'll trigger a build error instead of a warning, which is a bit of an
overkill.

> And use of #warning directive breaks building with -Werror option.

If the user wants to fail build on warnings, sure. That's different from
kernel failing to build in a way which may require non-trivial changes to
fix.

> > Maybe rename the function to __flush_workqueue() instead of undef'ing the
> > macro?
> 
> I prefer not adding __ prefix, for flush_workqueue() is meant as a public function.
> For easier life of kernel message parsers, I don't feel reason to dare to rename.

You mean the WARN_ON messages? Given how they never trigger, I doubt there's
much to break. Maybe some kprobe users? But they can survive.

> But if you still prefer renaming, I will change flush_workqueue() as an inline function
> in include/linux/workqueue.h which calls __flush_workqueue() in kernel/workqueue.c.

Please just do something straight forward.

Thanks.

-- 
tejun
