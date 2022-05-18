Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92952BF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbiERPjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiERPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:39:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929F163F66
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:39:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so3304276wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=va36wAAbe1qwf1LlQtJWUtJ487aIheuZ8ahX4EnVGY0=;
        b=rrxMp0leGCqtFXpUL693a8d5Zr9B6GTX+dmMnYmV9qdB1BT8cEuMtwd/q2LYEtdRJY
         DPAgL5NJXZe5w32S4SOcjFTA8LOBYyksdsQcnu1/SwPHEgEkGIXjXg3pBBq4+C0sfhye
         C2JS1HeYsa8OyqyqnxLnNduo9bSn4ut8vaM4w7cMl3DLq7/VcojkwDk5a4Gjs4m3yBog
         vush9wqkzsTJ/oD7gwWnYLvG/UR59JQFTKR8JylNRy0vh2AtZok+OHJpVppVl3FLTuG7
         DsoFoAXnDuRmp4XY4BJgD/HYwIhnXssaCxtpm0b45AM4XLs/bHiS6BxQ6WzdOJu0F4AG
         Ke2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=va36wAAbe1qwf1LlQtJWUtJ487aIheuZ8ahX4EnVGY0=;
        b=nx5UJN9u0WFc2dDyIDsSESYOIBZR+E5zn5+2Gzbo/xVwcAFWJ8rW0sjR0Hut2ps/li
         iKg4HDl8JZna2sjXrTovsR0Ke/EawMKnAoMQ+0b04EaoLZMSTJXoHmkrrwHNW65auckU
         go8Ri+oeNmmbth2R2YejYoppJYXsC1jC3anlHcNHpxbUkmu5lJdgrfcAHZhniWAwaQGM
         kRcDFWPZAOo4B7zMhFMsBWZfKuJJKSNvSzed3jXSraocl3YaSyVguCFpGM8sEPG5G1PS
         vURhjXoF8NyrK0C8WGdmv2odBWv5/MuSiPqlVzBuGw32PbkIC8+iOa2pjuzmzY8oiavP
         QG4Q==
X-Gm-Message-State: AOAM533CB1TG7mzplWTyZ5QGOZYB4CZS1nD8D0yGOJjVc22s0JqN3K8w
        /wTElm5HI5cSQSm1eV7JVhAe1g==
X-Google-Smtp-Source: ABdhPJwMG6FJWeSOQTwckjRdnUHx9eOJsaj47hUtiMwXKtMQbP/1AmLji7q7DsvO5phgtWq467uhog==
X-Received: by 2002:a5d:5309:0:b0:20d:124:90b1 with SMTP id e9-20020a5d5309000000b0020d012490b1mr245670wrv.21.1652888383499;
        Wed, 18 May 2022 08:39:43 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b0020c5253d8f3sm2869082wrs.63.2022.05.18.08.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:39:42 -0700 (PDT)
Date:   Wed, 18 May 2022 16:39:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REPORT] Use-after-free Read in __fdget_raw in v5.10.y
Message-ID: <YoUTPIVOhLlnIO04@google.com>
References: <YoOW2+ov8KF1YcYF@google.com>
 <3d271554-9ddc-07ad-3ff8-30aba31f8bf2@kernel.dk>
 <YoOcYR15Jhkw2XwL@google.com>
 <f34c85cc-71a5-59d4-dd7a-cc07e2af536c@kernel.dk>
 <YoTrmjuct3ctvFim@google.com>
 <b7dc2992-e2d6-8e76-f089-b33561f8471f@kernel.dk>
 <f821d544-78d5-a227-1370-b5f0895fb184@kernel.dk>
 <06710b30-fec8-b593-3af4-1318515b41d8@kernel.dk>
 <YoUNQlzU0W4ShA85@google.com>
 <49609b89-f2f0-44b3-d732-dfcb4f73cee1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49609b89-f2f0-44b3-d732-dfcb4f73cee1@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022, Jens Axboe wrote:

> On 5/18/22 9:14 AM, Lee Jones wrote:
> > On Wed, 18 May 2022, Jens Axboe wrote:
> > 
> >> On 5/18/22 6:54 AM, Jens Axboe wrote:
> >>> On 5/18/22 6:52 AM, Jens Axboe wrote:
> >>>> On 5/18/22 6:50 AM, Lee Jones wrote:
> >>>>> On Tue, 17 May 2022, Jens Axboe wrote:
> >>>>>
> >>>>>> On 5/17/22 7:00 AM, Lee Jones wrote:
> >>>>>>> On Tue, 17 May 2022, Jens Axboe wrote:
> >>>>>>>
> >>>>>>>> On 5/17/22 6:36 AM, Lee Jones wrote:
> >>>>>>>>> On Tue, 17 May 2022, Jens Axboe wrote:
> >>>>>>>>>
> >>>>>>>>>> On 5/17/22 6:24 AM, Lee Jones wrote:
> >>>>>>>>>>> On Tue, 17 May 2022, Jens Axboe wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>> On 5/17/22 5:41 AM, Lee Jones wrote:
> >>>>>>>>>>>>> Good afternoon Jens, Pavel, et al.,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Not sure if you are presently aware, but there appears to be a
> >>>>>>>>>>>>> use-after-free issue affecting the io_uring worker driver (fs/io-wq.c)
> >>>>>>>>>>>>> in Stable v5.10.y.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The full sysbot report can be seen below [0].
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The C-reproducer has been placed below that [1].
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I had great success running this reproducer in an infinite loop.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> My colleague reverse-bisected the fixing commit to:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>   commit fb3a1f6c745ccd896afadf6e2d6f073e871d38ba
> >>>>>>>>>>>>>   Author: Jens Axboe <axboe@kernel.dk>
> >>>>>>>>>>>>>   Date:   Fri Feb 26 09:47:20 2021 -0700
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>        io-wq: have manager wait for all workers to exit
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>        Instead of having to wait separately on workers and manager, just have
> >>>>>>>>>>>>>        the manager wait on the workers. We use an atomic_t for the reference
> >>>>>>>>>>>>>        here, as we need to start at 0 and allow increment from that. Since the
> >>>>>>>>>>>>>        number of workers is naturally capped by the allowed nr of processes,
> >>>>>>>>>>>>>        and that uses an int, there is no risk of overflow.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>        Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>     fs/io-wq.c | 30 ++++++++++++++++++++++--------
> >>>>>>>>>>>>>     1 file changed, 22 insertions(+), 8 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> Does this fix it:
> >>>>>>>>>>>>
> >>>>>>>>>>>> commit 886d0137f104a440d9dfa1d16efc1db06c9a2c02
> >>>>>>>>>>>> Author: Jens Axboe <axboe@kernel.dk>
> >>>>>>>>>>>> Date:   Fri Mar 5 12:59:30 2021 -0700
> >>>>>>>>>>>>
> >>>>>>>>>>>>     io-wq: fix race in freeing 'wq' and worker access
> >>>>>>>>>>>>
> >>>>>>>>>>>> Looks like it didn't make it into 5.10-stable, but we can certainly
> >>>>>>>>>>>> rectify that.
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks for your quick response Jens.
> >>>>>>>>>>>
> >>>>>>>>>>> This patch doesn't apply cleanly to v5.10.y.
> >>>>>>>>>>
> >>>>>>>>>> This is probably why it never made it into 5.10-stable :-/
> >>>>>>>>>
> >>>>>>>>> Right.  It doesn't apply at all unfortunately.
> >>>>>>>>>
> >>>>>>>>>>> I'll have a go at back-porting it.  Please bear with me.
> >>>>>>>>>>
> >>>>>>>>>> Let me know if you into issues with that and I can help out.
> >>>>>>>>>
> >>>>>>>>> I think the dependency list is too big.
> >>>>>>>>>
> >>>>>>>>> Too much has changed that was never back-ported.
> >>>>>>>>>
> >>>>>>>>> Actually the list of patches pertaining to fs/io-wq.c alone isn't so
> >>>>>>>>> bad, I did start to back-port them all but some of the big ones have
> >>>>>>>>> fs/io_uring.c changes incorporated and that list is huge (256 patches
> >>>>>>>>> from v5.10 to the fixing patch mentioned above).
> >>>>>>>>
> >>>>>>>> The problem is that 5.12 went to the new worker setup, and this patch
> >>>>>>>> landed after that even though it also applies to the pre-native workers.
> >>>>>>>> Hence the dependency chain isn't really as long as it seems, probably
> >>>>>>>> just a few patches backporting the change references and completions.
> >>>>>>>>
> >>>>>>>> I'll take a look this afternoon.
> >>>>>>>
> >>>>>>> Thanks Jens.  I really appreciate it.
> >>>>>>
> >>>>>> Can you see if this helps? Untested...
> >>>>>
> >>>>> What base does this apply against please?
> >>>>>
> >>>>> I tried Mainline and v5.10.116 and both failed.
> >>>>
> >>>> It's against 5.10.116, so that's puzzling. Let me double check I sent
> >>>> the right one...
> >>>
> >>> Looks like I sent the one from the wrong directory, sorry about that.
> >>> This one should be better:
> >>
> >> Nope, both are the right one. Maybe your mailer is mangling the patch?
> >> I'll attach it gzip'ed here in case that helps.
> > 
> > Okay, that applied, thanks.
> > 
> > Unfortunately, I am still able to crash the kernel in the same way.
> 
> Alright, maybe it's not enough. I can't get your reproducer to crash,
> unfortunately. I'll try on a different box.

You need to have fuzzing and kasan enabled.

Here's the .config I'm using: https://termbin.com/3lvp

Pop the invocation in a while loop:

  while true; do ./repro; done

This has a 100% success rate for me.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
