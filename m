Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7F52C3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbiERTnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiERTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:43:31 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FD2205277
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:43:29 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id a22so2293191qkl.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWE/Csrg3TFZq52PFagCnd5ycCPpe2W/G6e1YggcD68=;
        b=ip1o1rYVna8KpPTA2V9/Iag8IVjYMirsqPSdJUZzm5So6VwV8NjmzGpKfbw9hLEp4g
         KodEo4wLPT+v8tDI+iLn6wS77bk8CQnvhk2LYXvlS9dohRd0Q3pdTk4/VG9H+6AUT303
         +WWAiO3aaP5zcKcfJybL23apCzUxB0M0Bry6vYceasu5v2NhquoZ1J0fK6tL60Nblu8O
         I6rY7pQ3Qr1kZz3wkq46Rrfmj6khb2Zg0EzCMB7sxLZmOgp8dzlZAwg7cqk7VK1VBWE2
         OlXz8Nwy2u+gw5rTZdoqbgyPL15ekoKh8et0a1PM4+tqlkA8cPuAFamR7WxABcpQBuWh
         zBRA==
X-Gm-Message-State: AOAM531pv6QuX1+UGklyARMWRttnOLtqBgvYEFQLbZmlFHvF9ghYyezu
        GQ66TIYeEKMbTY8di5qSLrKi
X-Google-Smtp-Source: ABdhPJxwDfvRn/dtBw/nu2UWuqr/QIeIsuEtWlURFwHEFgLeTC0TWbkdZvRu40tYPgyyOvUl6VbGrQ==
X-Received: by 2002:ae9:e90d:0:b0:6a3:28eb:1a4f with SMTP id x13-20020ae9e90d000000b006a328eb1a4fmr815862qkf.21.1652903009028;
        Wed, 18 May 2022 12:43:29 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b002f39b99f679sm83146qtn.19.2022.05.18.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:43:28 -0700 (PDT)
Date:   Wed, 18 May 2022 15:43:27 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <YoVMX4pDDIN1vmH8@redhat.com>
References: <20220517233457.1123309-1-mka@chromium.org>
 <202205181221.F02CF5A9D2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205181221.F02CF5A9D2@keescook>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18 2022 at  3:23P -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Tue, May 17, 2022 at 04:34:54PM -0700, Matthias Kaehlcke wrote:
> > As of now LoadPin restricts loading of kernel files to a single pinned
> > filesystem, typically the rootfs. This works for many systems, however it
> > can result in a bloated rootfs (and OTA updates) on platforms where
> > multiple boards with different hardware configurations use the same rootfs
> > image. Especially when 'optional' files are large it may be preferable to
> > download/install them only when they are actually needed by a given board.
> > Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
> > at runtime. As an example a DLC package could contain firmware for a
> > peripheral that is not present on all boards. DLCs use dm-verity [2] to
> > verify the integrity of the DLC content.
> 
> For the coming v5 (which will fix the 0-day reports), if I can get some
> Acks from the dm folks, I can carry this with other loadpin changes in
> my tree. Though I'm fine with this going via the dm tree, too:
> 
> Acked-by: Kees Cook <keescook@chromium.org>

I'll review it once it's posted.

But I'm going to reply to v4's 1/3 now.

