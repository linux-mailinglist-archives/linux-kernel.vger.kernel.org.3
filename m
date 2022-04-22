Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801C150B735
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447452AbiDVM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447430AbiDVM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:28:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ABA527E9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:25:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s18so16171715ejr.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnaT88kKaWw6w1Cp0yt09+nLI76XyPMEYpLQ3b36fos=;
        b=bc3blIS5FEqV+MAK424O7VVp33TheOJpq/THYAUuOJe+Ko01w8Ijf6kp5bT+1sECaO
         2n0Y8PxwaGpC3+Q9KNHlucWEUk0/SyOWz2cYlZK2gfLLXVT6R4k5cUsHUqVDYCEU+M3h
         Di2peUMSr8imE70+d37zB1WYA3N/3wWyklumE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnaT88kKaWw6w1Cp0yt09+nLI76XyPMEYpLQ3b36fos=;
        b=E0FTkOTBhfVqRewXx5vmK35OhxjMC3Xh23UnhBlMi8xBiPmpWF9uqdGUSlR8sKnGT1
         g++kQ2/Ch7ltpw52RvlpeXWDfo3HFxLuMxChiT08PjW52VOjonAYhfURZs5+GkhRmrm0
         8ma/ACR4kcgb1unw/XGhIPf0MF5cvhB6FF+U19r69N0q6o32N2ens6BLoskxZ+IyH8JD
         ZAzi38viRcstkIcsRO2AxaLKxtKz7dHirpLtOkA5Qza2zDrC1rfqtC0WKuu80XnGm9g/
         MTl4tt6hmTKcrltF796idD3q0MQpZxQ4A2HBovhf65UBqBUVUidfgwD3xl25lhGEX4Xj
         aK+Q==
X-Gm-Message-State: AOAM53217NwGJsdk/o+ZwjJwBOcIc43I7uWprYKtDzyQydcignJ9S18u
        Tlsp5rpos0ShJTcqSKziEEjSYdYCxrb/VGpx9Fy6Pw==
X-Google-Smtp-Source: ABdhPJyRFXvXfR4mJ1SY1CRSxSk4eYn2ndQii4XAE/kU2VeiJvseyE0Djj4DDWg1hi2lVl/6ewK8lu/RsfG4OWc7Ry8=
X-Received: by 2002:a17:906:a05a:b0:6ef:a44d:2f46 with SMTP id
 bg26-20020a170906a05a00b006efa44d2f46mr4014433ejb.192.1650630323396; Fri, 22
 Apr 2022 05:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <6ba14287-336d-cdcd-0d39-680f288ca776@ddn.com>
In-Reply-To: <6ba14287-336d-cdcd-0d39-680f288ca776@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 22 Apr 2022 14:25:12 +0200
Message-ID: <CAJfpegt=KZJKExpxPgGXoBEzWpzepL9cyaqS=dwW5AN6y2up_Q@mail.gmail.com>
Subject: Re: RFC fuse waitq latency
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        Sagi Manole <sagim@netapp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 at 15:21, Bernd Schubert <bschubert@ddn.com> wrote:
>
> I would like to discuss the user thread wake up latency in
> fuse_dev_do_read(). Profiling fuse shows there is room for improvement
> regarding memory copies and splice. The basic profiling with flame graphs
> didn't reveal, though, why fuse is so much
> slower (with an overlay file system) than just accessing the underlying
> file system directly and also didn't reveal why a single threaded fuse
> uses less than 100% cpu, with the application on top of use also using
> less than 100% cpu (simple bonnie++ runs with 1B files).
> So I started to suspect the wait queues and indeed, keeping the thread
> that reads the fuse device for work running for some time gives quite
> some improvements.

Might be related: I experimented with wake_up_sync() that didn't meet
my expectations.  See this thread:

https://lore.kernel.org/all/1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com/#r

Possibly fuse needs some wake up tweaks due to its special scheduling
requirements.

Thanks,
Miklos
