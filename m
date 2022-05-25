Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149F55346E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 01:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbiEYXHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 19:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiEYXHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 19:07:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8D266ADA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:07:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so31456668ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhZHhPtlN8R7i0B/YpUEdtpRE1Mi/VoabZq2hM6NjXc=;
        b=bVsV616n58twV6qsTo0cPivFx66Vcij9oJRcp2WH1X5FqI/MZDHKuyhjdX5C6ec689
         sjIkBbCkPRBJfJcC29/ryFx96LBch0w/XUKGov4IHTlIVeMLQ8TjfzfI5fWoJ3pg6Y9S
         5u4MuYVRSOFInddt6Aqu6XCXrnqbOEbHeuiNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhZHhPtlN8R7i0B/YpUEdtpRE1Mi/VoabZq2hM6NjXc=;
        b=tP3apZHQ3m/2ZE8S8CCuqGQtDYcnyUbXtOKJywd70TqJX8KEL7qfXdDCxKKP7bL2f+
         TYdvgE6MW/nVsmfsta0jnQKN7BCsGEKFAhSvk2+qfjqOAeWLP8y+3dSypN9csRfvA05P
         n+sYoGL8hOaakn10JVrTy+34Qxwbt/zR58ts5wggy8fe3InzkCE700h+sDAWUh8s4MXI
         9RVQDIhW4yQ7ccpGTkU7PXabRtJPvgKH7WlYURC4vSkeHwgm8b96v8C82esjLKk73+p4
         LMlkG7bYsd+zponbNNDNvrtJkQXPSa7EnH9tiobPiDD2sGcI2PYIJC8YZbP8OKLPfs/S
         Ue4w==
X-Gm-Message-State: AOAM533O0iLsBNDzw24erg2mj9dYnkRLBL8Ap2IwWT7fqJxMwkC3uGGt
        9vQ1BaMBHGvmhPa0oBWP/KIPV+4bwM3CcMRMJ6A=
X-Google-Smtp-Source: ABdhPJynCwkaT0Mj8rx9s8gQWd/5q9EVN/xZtpEzxtwlZTMrlhNbUrWeYNYlKeNcF2bfgk4P6CRmmg==
X-Received: by 2002:a17:907:7e84:b0:6fe:cded:7d1f with SMTP id qb4-20020a1709077e8400b006fecded7d1fmr17865447ejc.35.1653520062114;
        Wed, 25 May 2022 16:07:42 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id c18-20020a1709063f1200b006fe8b456672sm8189175ejj.3.2022.05.25.16.07.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 16:07:41 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id x12so67741wrg.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:07:41 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr26524571wrr.442.1653520060789; Wed, 25
 May 2022 16:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <8062f61e-5a4d-00a5-be1a-7921d3277e9d@suse.cz> <CAHk-=wiztQWhEw4tLiH3t5gw=gKB7XtoTXC=S2bhxBxoxOVZLw@mail.gmail.com>
 <6cdbe746-2c6f-f698-11d4-9f86d2c4e5cc@suse.cz> <CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com>
 <af059855-959f-95b8-afc4-fad97e52cb46@suse.cz>
In-Reply-To: <af059855-959f-95b8-afc4-fad97e52cb46@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 16:07:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDNR5MxVXk17FjXJApUY5e7GWZGUe7t4e98RJALooXDA@mail.gmail.com>
Message-ID: <CAHk-=wjDNR5MxVXk17FjXJApUY5e7GWZGUe7t4e98RJALooXDA@mail.gmail.com>
Subject: Re: [GIT PULL] slab for 5.19
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 3:01 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Yes, running rcutorture will trigger that stackdepot allocation, but as
> that's in RCU debugging part of config, I considered it in the same
> category as enabling slub debugging.

Yeah, I don't think rcutorture is a problem per se, it was more an
example of a random interaction that doesn't actually seem to make
much sense.

As far as I can tell, there is nothing in rcutorture that actually
wants that stack trace, and it seems to be doing just a test of the
object dumping working.

So it was more the oddity and randomness of it that made me go
"Whaah?" There might be others hiding elsewhere, that rcutorture use
just  happened to use the flag explicitly.

             Linus
