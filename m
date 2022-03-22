Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18DD4E3C56
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiCVKVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiCVKV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C4D98020C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647944400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m4GF+9cHV53cr1b1xAXRydH38vqCGfAi4QbQEVblHtE=;
        b=BQhZW6MVsBl251ir19Ogtfga8/SAVjGOzNkIeS0vbMmi0Jb0FH9Pao9zqh2mm98pH/sOGP
        6Leo9K0gwEldCYNhW5ITG3eqogYGr5M0UM4bCw1oCXRosIBS/9eRZKEyE8Vs1rYZOcyVkx
        Buo2a0iGRpRAjushsTRRPGO/tZYG0Po=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-Jwj5IhKkMQWdb2SVZLdupA-1; Tue, 22 Mar 2022 06:19:59 -0400
X-MC-Unique: Jwj5IhKkMQWdb2SVZLdupA-1
Received: by mail-yb1-f198.google.com with SMTP id j6-20020a25ec06000000b00633c6f3e072so7602690ybh.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4GF+9cHV53cr1b1xAXRydH38vqCGfAi4QbQEVblHtE=;
        b=YHE0L7eh/BHWSxuGpjODq+wztr0KnC6Id/5pQ4D+ShMeX88A3Lm2LEr3hhFhHxZAfH
         r81YOLOSfwII+xew881C0hdOtP/vSs62dluLUyJO0zCDhZ/kq3q6kJ2vr7wCzyDUTmuE
         GY4WRCUIlj4RZeLwHzJ/MUmDnE3Ee0KfkfjJOiYlsNU+7flQBDunJxXsVzYgMxRMoaAj
         dJK2574yAGTOuu0S7kSHEBRyomBhhS/ucUuFMEbCbfhEB1X7Ns4vOCwdQ3lmoKb0AQSK
         pKbX2IeoQ6YNwtttc/+9s6YC5XjD/ip5qhV8XWv1N1YSYurOol8GyqKa1rufFOoqDEQk
         lblQ==
X-Gm-Message-State: AOAM5301IAROg1D7BN2VS85t79NdPSRY7cErT4Jpq/dvHDpKftS2Dqyv
        i5lfaA/ngeYVqGSZWza+WL5Mw2tccalQP79cw8Ej9iwrOmV3IDErlh5LJBIXj4cR3oriEeQC3NN
        be89b4jetUQ3RIW0Paq5YIerR6AYTdQ0gXzz+ENAo
X-Received: by 2002:a81:79d5:0:b0:2e5:9d33:82ab with SMTP id u204-20020a8179d5000000b002e59d3382abmr28322736ywc.460.1647944398074;
        Tue, 22 Mar 2022 03:19:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1s+XqKJwWIkv18BmjfiRSu7eZCg2W9vokwL7Up2nCK/iOM0QMoUFKZUpNL1cAHqgyWIPdVSoun3BcuCKTC8A=
X-Received: by 2002:a81:79d5:0:b0:2e5:9d33:82ab with SMTP id
 u204-20020a8179d5000000b002e59d3382abmr28322720ywc.460.1647944397874; Tue, 22
 Mar 2022 03:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGDZr_4wzRn2___eDYRtmdPaGGJdzu_LCSkJYuY9BEO3cw@mail.gmail.com>
 <CAE4VaGDKXnQJKdayeNsAD5RcqsKu5XG2UeweLvgZoFO-pn-t9Q@mail.gmail.com> <Yjl26QqwU1L2XWoh@kroah.com>
In-Reply-To: <Yjl26QqwU1L2XWoh@kroah.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Tue, 22 Mar 2022 11:19:46 +0100
Message-ID: <CAE4VaGBRcwPEO3JZtSesvE0bFTQ_P62mC7MmZ5Rc9VQey+=L_w@mail.gmail.com>
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you use 'git bisect' to track down the kernel commit that caused
> this problem?

Yes, I will try that and report the back the findings.

On Tue, Mar 22, 2022 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 22, 2022 at 12:37:37AM +0100, Jirka Hladky wrote:
> > Cc: regressions@lists.linux.dev stable@vger.kernel.org
> >
> > On Tue, Mar 22, 2022 at 12:29 AM Jirka Hladky <jhladky@redhat.com> wrote:
> > >
> > > Starting from kernel 5.17 (tested with rc2, rc4, rc7, rc8) we
> > > experience kernel oops on Intel Xeon Gold dual-socket servers (2x Xeon
> > > Gold 6126 CPU)
> > >
> > > Bellow is a backtrace and the dmesg log.
> > >
> > > I have trouble creating a simple reproducer - it happens at random
> > > places when preparing the NAS benchmark to be run. The script creates
> > > a bunch of directories, compiles the benchmark a start trial runs.
> > >
> > > Could you please help to narrow down the problem?
>
> Can you use 'git bisect' to track down the kernel commit that caused
> this problem?
>
> thanks,
>
> greg k-h
>


-- 
-Jirka

