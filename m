Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D55B2B42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIIA5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIIA5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:57:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7826DAE23D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:57:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso53433pjd.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 17:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+SlLUIC6Td+IyqLvmVnsvBlH0ov77z8o1knu1Vxc0Sc=;
        b=inhjNnnNiKmW3OVOd4hGLWb8BepBDe2ZtRPV3siNtX73JDSKOMJ+dTNWZRBealskxJ
         7IKRCTT02kLy3aLKJb4BTOvv2+kBlg7mnfXa+HpAT6CMxGO3g+Zl2sEfjKG/My+4+ZNL
         GDAEERRrAOAp7K7l6NtGm4I6gmj7W+AV5zVho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+SlLUIC6Td+IyqLvmVnsvBlH0ov77z8o1knu1Vxc0Sc=;
        b=XQ0ucrVFlR4YICv7xkHe4+T6x/y0LNa47lsdj2+gg+UvIT9DzbqxPJFjGMa9ZQQmW1
         /0fKDMJo4a7FKfwp+0JvMYGmx4YcZ+R/Nhzcco7YCuhcQT52so+7cSXikDpttgM+vmKY
         UuUpbcjTMsym5LvLM8AHNr3vvHfnHktn8tkXVgA9/RID875gYuiSYdGjS6grv5qqQyvx
         bIw+/qH1/Aqqu8Ng+x3zd/C+8BvfsPhMQzLDZeSoJ0SWktWDO/sNBId1hm+hvOKdHy93
         ieYxxuybx6uPB4JDkVNdGc4jOVMOJjK0Isof43RgBQ1fGuOpr7Bzhj6uY3KCOdvyo5cq
         Jk+A==
X-Gm-Message-State: ACgBeo001d6N4w3m5s59sLB4KoXyQU8XN+GRk/wf4LSo9W8EvuuTLgRW
        l22H6iiON8vQ9zZgNWLZL5CMmA==
X-Google-Smtp-Source: AA6agR7HsiGVvJGOSTcG3tFxZ+OryuMeInlRWIYlBRjHWVsdD9Ao2vqjZEaa0feYEBRP8OrVBvkvoQ==
X-Received: by 2002:a17:902:ced0:b0:172:e189:f709 with SMTP id d16-20020a170902ced000b00172e189f709mr10867294plg.63.1662685033898;
        Thu, 08 Sep 2022 17:57:13 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:da1a:c731:7561:7e5b])
        by smtp.gmail.com with ESMTPSA id s18-20020a656912000000b0042c0ffa0e62sm93468pgq.47.2022.09.08.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 17:57:13 -0700 (PDT)
Date:   Thu, 8 Sep 2022 17:57:11 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <YxqPZ4Yfus+an0Lg@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
 <YxDWlgulBijTzj3y@kroah.com>
 <YxEy8mTO1nZ1sxHV@google.com>
 <YxGYepQlLZTE84HB@kroah.com>
 <YxqF0bWoJPK4KFHb@google.com>
 <20220908204332.0cbd850c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908204332.0cbd850c@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:43:32PM -0400, Steven Rostedt wrote:
> On Thu, 8 Sep 2022 17:16:17 -0700
> Instead of doing an LTP test, could you just write a script that could test
> it in the kernel selftests?
> 
> See tools/testing/selftests/...
> 
> in the kernel repository.

I honestly don't know why both LTP and kselftests exist. But I *did*
specifically ask about LTP and got a "yes" from both you and Greg.

I suppose I can go back and remove all the LTP niceties that I just
added to my bare script (setup, cleanup, clean handling of individual
test cases, unified reporting stats; does selftests have any of
that?)... But that'll have to be next week, if I can find the time at
all.

> If you create a tracefs one, it could go into the ftrace directory.

Since the tests cases are so similar, my current script tests both
debugfs and tracefs. So I probably won't create two separate buckets for
this.

Brian
