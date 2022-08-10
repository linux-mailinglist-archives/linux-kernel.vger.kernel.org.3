Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224ED58F332
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiHJTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiHJTbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:31:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2975389
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:31:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l5so5566212qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dLpGkLIiz/54cVWJRgggdlnjUABVaQiLzQFQiAlQPGA=;
        b=ouc3/Q4QmYB1bJ51O5HBWOL3LY/GeDOT4Zl4M2lOTIvMyM5yOFAcxdjShv7m+mw7st
         NkJxfNCPxm1koPC2HWtD9C8QKkXudV/HjezWm4QGzfYIPpJ3aY57nxKXWyl7ZTXX0dCu
         csKga0oGb8iJrnLMCk58S/UU5GQoeTdVd/FYyRQbgND37OHxNQYFFgDEKL91yNzxqaOZ
         /SR7cBPnwo4HClujH5IJYvqKz/2fserwC/SR3p4cyq+SHsw483ZCWWXd8t1uCkCP1FcZ
         IIkZjutHyYx5zsUmxMMPC4Fq0TXxMzmjcCuvOl3vy7RbhavW8V0c0NerNvZswYH47SFF
         h4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dLpGkLIiz/54cVWJRgggdlnjUABVaQiLzQFQiAlQPGA=;
        b=kO3iCXuR+TETX1fkPaJJBkN2SPehCcjbjrMTbcd2paIM48WdbjMzMqCBAxNy6UuuNw
         34p84yAfRLn8AmrO153kGulDaL1EYZIzmPbwPVVKcdN/QI77Uow8sPnfG+nME+TSB2vr
         wfEuxrB/LoUiv5Ytiy2dxzdl8Do1TjBKG+OwTyrATOzgK7WvYSLC+QxqNjQC+zfJANo0
         AMnhdLBbotvCtIaPDfN49dpkCZui0TQlpJJZkK+E3Us0KxO1iPcUE3MvLgjxq/Oq9/t3
         uUmgGu1QplAlaEHmMqoV3OO4EekPT9rZUITTT1I7HoXuqUjPQQSyjNJ+zrZj93plVBAY
         aDRQ==
X-Gm-Message-State: ACgBeo1/TlqVWnqU9SZaU2G4H6SlCgPsk9U+4odg9MuvS9vch+kn6LAH
        K9jFX5ZpBV/XLqlJAF2VVNNBCv2t70QS1Q==
X-Google-Smtp-Source: AA6agR63H3khOeYEyAgxUArdGqdtq4HNQfyGWhenU0M9vtjj3U1R0WqUmrP9r2uH1h2GBlSYweiCeA==
X-Received: by 2002:a05:622a:190:b0:31f:3999:b949 with SMTP id s16-20020a05622a019000b0031f3999b949mr25242898qtw.444.1660159900306;
        Wed, 10 Aug 2022 12:31:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl35-20020a05620a1aa300b006b555509398sm397591qkb.136.2022.08.10.12.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 12:31:39 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:31:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: stalling IO regression in linux 5.12
Message-ID: <YvQHmjpmqfV55e8A@localhost.localdomain>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 02:42:40PM -0400, Chris Murphy wrote:
> 
> 
> On Wed, Aug 10, 2022, at 2:33 PM, Chris Murphy wrote:
> > On Wed, Aug 10, 2022, at 1:48 PM, Josef Bacik wrote:
> >
> >> To help narrow this down can you disable any IO controller you've got enabled
> >> and see if you can reproduce?  If you can sysrq+w is super helpful as it'll
> >> point us in the next direction to look.  Thanks,
> >
> > I'm not following, sorry. I can boot with 
> > systemd.unified_cgroup_hierarchy=0 to make sure it's all off, but we're 
> > not using an IO cgroup controllers specifically as far as I'm aware.
> 
> OK yeah that won't work because the workload requires cgroup2 or it won't run.
>

Oh no I don't want cgroups completley off, just disable the io controller, so
figure out which cgroup your thing is being run in, and then

echo "-io" > <parent dir>/cgroup.subtree_control

If you cat /sys/fs/cgroup/whatever/cgroup/cgroup.controllers and you see "io" in
there keep doing the above in the next highest parent directory until io is no
longer in there.  Thanks,

Josef 
