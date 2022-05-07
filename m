Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFA51E304
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 03:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445177AbiEGBdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 21:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEGBdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 21:33:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBC870921
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 18:29:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k27so10463085edk.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 18:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIQWyqXvIIq9sD3XM20r5zKTpkRZMWgEiouQek1gd3Y=;
        b=WWj4C6F5RGEX4dE9POSrNe1/+NzxSscKgUQs1Ognjq4KCxFMsJ79jg9aA4P06w11FB
         FAkIfigQsxdvYcy3m3SYCvCSjdxQ9r8ueIyShwc+abHKYixmQfeTIAzFn28gw4rVP6L4
         t0YsPGj8OaZmJH7AlnWtt8zx3jBW6RYg0HozpmjIekMlUlX8P8cxRohm+j3ZY9nGhP9d
         MZY96nbatPhomFTvuibWDU6Ewstm3GT6IeVZyzaKPSLM4RUSfZzHo4WZbHjX3QKzgdeV
         twR3yOgbRebFZ9qemBLaNMELrRP5rSyqQ1AMj2rC+Fiw+bvYIRes+fMMjTES908RseeI
         bS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIQWyqXvIIq9sD3XM20r5zKTpkRZMWgEiouQek1gd3Y=;
        b=f5C9VxJazX5c7RHDgXWs9G43dPhUQfZaFLKm3pfmYppuHvyksT9ENfhl5v2XtkhUMh
         4LTtfaICR+rqyVH1LLTzLkWw+m9yEH9PppaDskbogDfmwKVewyEhE+cEWtMnjuC35tAu
         m30txH/v7yjLDSAgo3+1pgYhwchP4VY926Mo1SewpkaXCykZAzKEsxOJ91EO61UwPuJL
         w57LRxmqsQmPfeSj75GdgF6z0Deg/Bq0M+SWnoCZ8pQbEOc6KEXDmP3EUKFn9O6j1YeT
         u29GbV0hJDcoZG8ePoBLslIk0nAb/jWWv1o82/sasdU95tjAjli3fZoYZ5WUccWlScyB
         syFA==
X-Gm-Message-State: AOAM533RjPRJQpgvh8Mc9jmpzlPwg9LLocgI3JWtzJ5LFrLb9lrszPxD
        xBoRF/DLrz6/Ypj4o+Uv38vQTkk2XvnFLywi0IA=
X-Google-Smtp-Source: ABdhPJxewcFKx/5BeXVX+Cw6jCPiZRBRVEdISYOJYZ3Nd965a3XYEqXB16ComSJHpGQePEqxplDjlHJXbKLNkwaa/nA=
X-Received: by 2002:a05:6402:1d48:b0:427:e039:9262 with SMTP id
 dz8-20020a0564021d4800b00427e0399262mr6564374edb.148.1651886964565; Fri, 06
 May 2022 18:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <2fb2bc4e857848c83cfa96483e4b25b23d46be49.1651516951.git.jpoimboe@redhat.com>
 <CAPDLWs_aOi-f801SAhA1X2YH4XE_r5P3AfPV1uhQWA10bKKffg@mail.gmail.com> <20220506152601.z4f3bachnyfeqgzf@treble>
In-Reply-To: <20220506152601.z4f3bachnyfeqgzf@treble>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Sat, 7 May 2022 06:59:08 +0530
Message-ID: <CAPDLWs8+=z_h8or4Yz_3aJUp7M=5O=SodjEgTyau6XQkRcW8yQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/faddr2line: Only use text symbols to calculate
 function size
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 8:56 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Fri, May 06, 2022 at 11:34:00AM +0530, Kaiwan N Billimoria wrote:
> > Hi Josh,
> >
> > Unfortunately, it didn't work with my test case (as before):
> > $ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x124
> > bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> > $
> >
> > What _did_ work was the earlier (much longer) patch you'd sent (your
> > email dt 20 Jan 2022),
> > Could you pl recheck...
> > (As before, i have the test case module here:
> > https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2
>
> Sorry, I totally managed to forget that I rewrote the whole script:
>
>   https://lkml.kernel.org/lkml/20220120171751.gibauc4zovoskjns@treble
>
> IIRC, that was the one that fixed your issue.  Let me go clean that one
> up...
Yup ! that's the one

>
> --
> Josh
