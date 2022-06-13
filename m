Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9AD54822B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbiFMIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiFMIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:45:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9D1EEF5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:45:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h19so6193484edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfmGJwskHmHAhCB8UZHmS2yFdhea4kPoHSuMHnO5k3I=;
        b=Jr7rk/jdznpRCtSmIXFZLDpBqEU6tFtAlG5tryZCnRA3ms47dOK8U8AAUvyt+zvQ7m
         sK3eLBFP8TGR6Zt7MS7vwyoqlsIOdj4wRS8Kraq+FXAnMsaKRnAGmZnoVT1wPs0EjV+m
         OeUW8b3fBFOivxW662zjwkk1hWoOTiXnodlX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfmGJwskHmHAhCB8UZHmS2yFdhea4kPoHSuMHnO5k3I=;
        b=IJicAr7qBilP3+PCkC2tu579USmexCrbHgyHrTfizjZgPJ5fOeXt9oXELSuLzt+uwB
         pKhgabqco4OVWSgukRaAQuNasw31WiXugBDHcUPqdq7QkvfwZP7oOyL2LEX9YKgnuPwd
         hmtVh/sKgsJoEAykzMQqffoCdcU+QMm3q4lzXO0tORANKVe8pfNJU1lXJE9ujkZXTmcZ
         hU/t8iEtHWZm2xFzvMy7NYCiXC7aoS9fFAcNB0OKLZmSaZnxkPWkqVPlBOjOkaWGoJgW
         jOR4fFxPTfQ7PzaQ9X484BL3ocz72q+tJXBshAIcG5rjol4N5e481Cf5qbEvghj2a1Z7
         NKFQ==
X-Gm-Message-State: AOAM531gtVGxQi4S9xcUFwi3KRirKvImfn+Hqn08xT/sPzKqP1DMekXi
        bzna2SMIaLXsl7ySAqQAT9A23SwDimYF0fkKccmEyg==
X-Google-Smtp-Source: ABdhPJzYFmZrht7WdbphT6MS8WcNj4pcWlxxJVuAPMot4z3u13BrvCurgfsHT4UdgMXqhReUPC4kPMZpIT71o7hAdVk=
X-Received: by 2002:a05:6402:524a:b0:431:51b3:bc7 with SMTP id
 t10-20020a056402524a00b0043151b30bc7mr45207130edd.5.1655109911441; Mon, 13
 Jun 2022 01:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210603125242.31699-1-chenguanyou@xiaomi.com>
 <CAJfpegsEkRnU26Vvo4BTQUmx89Hahp6=RTuyEcPm=rqz8icwUQ@mail.gmail.com>
 <1fabb91167a86990f4723e9036a0e006293518f4.camel@mediatek.com>
 <CAJfpegsOSWZpKHqDNE_B489dGCzLr-RVAhimVOsFkxJwMYmj9A@mail.gmail.com>
 <07c5f2f1e10671bc462f88717f84aae9ee1e4d2b.camel@mediatek.com>
 <CAJfpegvAJS=An+hyAshkNcTS8A2TM28V2UP4SYycXUw3awOR+g@mail.gmail.com>
 <YVMz8E1Lg/GZQcjw@miu.piliscsaba.redhat.com> <SI2PR03MB5545E0B76E54013678B9FEEC8BA99@SI2PR03MB5545.apcprd03.prod.outlook.com>
 <07ad7d51d15c7ffc708b55066ded653a4b2c5c98.camel@mediatek.com>
In-Reply-To: <07ad7d51d15c7ffc708b55066ded653a4b2c5c98.camel@mediatek.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jun 2022 10:45:00 +0200
Message-ID: <CAJfpegsw3NpH6oTU9nxJLPUYMJVmfWhAa6yB8vnDZctP9vHc0g@mail.gmail.com>
Subject: Re: [PATCH] [fuse] alloc_page nofs avoid deadlock
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenguanyou <chenguanyou9338@gmail.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WW9uZy14dWFuIFdhbmcgKOeOi+ipoOiQsSk=?= 
        <Yong-xuan.Wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 at 09:48, Ed Tsai <ed.tsai@mediatek.com> wrote:

> Recently, we get this deadlock issue again. fuse_flush_time_update()
> use sync_inode_metadata() and it only write the metadata, so the
> writeback worker could still be blocked becaused of file data.
>
> I try to use write_inode_now() instead of sync_inode_metadata() and the
> writeback thread will not be blocked anymore. I don't think this is a
> good solution, but this confirm that there is still a potential
> deadlock because of file data. WDYT.

I'm not sure how that happens.  Normally writeback doesn't block.  Can
you provide the stack traces of all related tasks in the deadlock?

Thanks,
Miklos
