Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32D4D50CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbiCJRpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiCJRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:45:53 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26D180D27
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:44:51 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id r13so13779423ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=17MWdnJm/ZtU5rlgn+dhHDvcPFAUwoVJySpzOZ59jis=;
        b=Qob3fh2A/QDMmO4XXN1pbyfQ9Br7w7EJdyi3yXis0tHQldNUvtQcY1q3VE1SU51lVf
         uY/GkPsYNK7jdjk9CGANqOan+1FOETyKsUAOAe6pWYVkAgmJxsQeghZEyxAqRxHLMDeg
         lu/P4iOPbd3Ejcd5bCFKH0mSyf+H/1sEQTbL9tmBPMiEDiYw+RzV3p8NKlG6rRC44edY
         WHxTgjNuow2CEMElQnelEgv/3al6qWn7s0HaJAdMt6PGfnJ9OtCB825ZpYSKILSiD/7U
         da0a6kue3JRErWI9NJzUdlboyBQolUSpt/vHkYsk+/vn9j9UMj67J/m7ehgoUUDn5I15
         EenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=17MWdnJm/ZtU5rlgn+dhHDvcPFAUwoVJySpzOZ59jis=;
        b=iHtWZ+88wG1m2uZFIwdSKWSFJ97tMUamADFHiJKe3wfRxihFevMfUJJ1uBKxwy5IYC
         FYNLiEbKeh0PhRVvUOeKKsu54IwaC71tSdudeRKssdxpO5+ddNFu5aFarCZ0DW7cFuut
         Lefw1m50lppH9QA1u4qJk7Xqlcpnb2N6qtK3Fa/2LyKeWgBiZzW6YkMgscRdQnHbr2IT
         lt0DNFcoUFhooYB8qHv9lcRqGItxLOAyR+5BSzWW+fdNnHyPcf5+0NF7EppJz7HRrcSi
         F8rIqlxGzXN27Jyy3ZTcmudhWMzV6BYh+cuzUKTuQ/1NIgc9PufsQfYTXekpB1YqO0eV
         Y4VQ==
X-Gm-Message-State: AOAM531V5nB4UPsH6rd7bvuIiGDec9wFEKv5MBfgVy+Hkf9e07m+D8EI
        dCVOfAg/8wuAeS11KKX10X0=
X-Google-Smtp-Source: ABdhPJyyGyTlUxk6xR6Ko+xxF1NQZmzCTsYGHiv+cBg7K7AkOgZnyoqml0y9dt/n3ZlRrEZ6zCY8Eg==
X-Received: by 2002:a17:906:d10c:b0:6cd:4aa2:cd62 with SMTP id b12-20020a170906d10c00b006cd4aa2cd62mr5348330ejz.229.1646934289797;
        Thu, 10 Mar 2022 09:44:49 -0800 (PST)
Received: from m4.home (tor-exit-9.zbau.f3netze.de. [185.220.100.248])
        by smtp.gmail.com with ESMTPSA id gs39-20020a1709072d2700b006d3ed4f51c6sm2154339ejc.0.2022.03.10.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:44:49 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.home with local (Exim 4.94.2)
        (envelope-from <cavok@localhost>)
        id 1nSMq1-00031m-6G; Thu, 10 Mar 2022 18:44:33 +0100
Date:   Thu, 10 Mar 2022 18:44:33 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc: add two-steps registration (opt-in)
Message-ID: <Yio5AY0KqohZkXOe@localhost>
References: <Yh4fdijvNXE7K88c@localhost>
 <202203100811.F2B43DD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203100811.F2B43DD@keescook>
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

On Thu, Mar 10, 2022 at 08:13:25AM -0800, Kees Cook wrote:
> On Tue, Mar 01, 2022 at 02:28:22PM +0100, Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > Experimenting with new interpreter configurations can lead to annoying
> > failures, when the system is left unable to load ELF binaries power
> > cycling is the only way to get it back operational.
> > 
> > This patch tries to mitigate such conditions by adding an opt-in
> > two-steps registration.
> > 
> > A new optional field is added to the configuration string, it's an
> > expiration interval for the newly added interpreter. If the user is
> > not able to confirm in time, possibly because the system is broken,
> > the new interpreter is automatically disabled.
> 
> Hi!

Hi!

> 
> As this both changes the userspace API and adds timers, I'd like the

Right but 1. it's backward compatible, 2. it fails on unsupporting
kernels.

Curiosity, I understand why API changes require care but what's so
special about the timers?

> change to be really well justified. Can you explain the conditions you
> get into that can't be escaped by just disabling the bad binfmt_misc
> entry?

It happened when I somehow messed up with the ELF loader of my system,
it was the very first time I tried to manually configure qemu-user-static
for a foreign architecture.

Suddenly I could not do anything, no ls, no cat. Did not realize that
my shell has built-in echo and that I could cut-and-paste the path for
disabling the bad interpreter.  I did not investigate what I did wrong
or what I could do better, I simply didn't do it again.

I just got a deeper understanding of the note in Debian's update-binfmts
manpage:

  If you're not careful, you can break your system with update-binfmts.
  An easy way to do this is to register an ELF binary as a handler for
  ELF, which will almost certainly cause your system to hang immediately;
  even if it doesn't, you won't be able to run update-binfmts to fix it.

I shot on my foot and I thought the API could be made a bit more friendly.

Thanks,
Dom

> 
> -Kees
> 
> -- 
> Kees Cook

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
