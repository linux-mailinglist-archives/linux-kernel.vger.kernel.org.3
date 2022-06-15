Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FACF54C466
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347905AbiFOJPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347678AbiFOJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:14:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615EE38DAC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:14:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so9897891plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U5W+u2socUdfvA7Xut56xq8m0f3VViU7LDQmKDKAFUw=;
        b=AuhzgNxfF4Wt8XjnPKCHtvnPTDkBF9j9nHeM3JacQLlyl4UesOejhMt+G6sv5jOza1
         Ip1smplzqEW9tti/ZgM8KZ7wQq6oJO5Wd3QSQ6S2+pDFFvqFx+AqWLdAOO63jkSE5gZI
         EKRXzrTPC61QKv/gkS+anhA9Ev6a9cfxgUdwD43YtoqPukJuA5Hq4wIXfzGtFke1zo5L
         ZqazuW56GgUg4Elsv7veM5cpyfsKta6gqLyTuhM1PtMC8XNaO+r1TANLyJ6xD90goJmy
         h1EHqcBvkgkeekeF9sIMqYr9Go8bpOcLDgiiqq6on37PuuWeRUZiMlYnIRLyninwm8Or
         ATtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U5W+u2socUdfvA7Xut56xq8m0f3VViU7LDQmKDKAFUw=;
        b=keXnCZ8JJ27st0o56YhBGsmkx89Vl9vznW3IUWpfwUSpD6sWjMKT+7fYyIjFN2VYD6
         0lMTqDwThDdiIwgP7dwDlGwNtJZIh3ZWlHuMTj+IlCpjTyLjWJtIlbfn+TdT1deOwT/K
         v/bTnlHvQhy1GFB3UM9aXUZmBTxdWMYPQ9ztx6EunB35pdqUIvd7erQZaG4ATNWWE2i9
         RqlJWZ8F2DRrDO3xpO4hDfvKE5Aof3woIcKpVE6Oe4IJpJAGiYrsKJgiB8uLnwyyPYzg
         sUT009LndxecmpZMhFTOfkg9stC6+PFTIER05egx6v0kdMXXHZUFhJjg3dYKfxB/nrJQ
         HDpg==
X-Gm-Message-State: AJIora+LdKOxMyiJFSlW84s8G+jmsxWM3JNpi8z4ZLGYISt19MAu9azF
        sNyXsxsTCUCWZs/x/5jqT/KW5w==
X-Google-Smtp-Source: AGRyM1t/aeseBSMJUh1pB4pBXT7wadG652+Zr21QtvXUxfp40vVCbCLIM4o3ACzHMUvDYa13RC/Tgw==
X-Received: by 2002:a17:902:6901:b0:168:9bb4:7adb with SMTP id j1-20020a170902690100b001689bb47adbmr8392907plk.147.1655284456709;
        Wed, 15 Jun 2022 02:14:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f2cb00b00163aba9a2a5sm8717942plc.106.2022.06.15.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:14:15 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:14:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 2/3] perf test: Shell - only run .sh shell files to skip
 other files
Message-ID: <20220615091406.GB121786@leoy-ThinkPad-X240s>
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220309122859.31487-2-carsten.haitzler@foss.arm.com>
 <20220410022846.GB14326@leoy-ThinkPad-X240s>
 <9ab780aa-7e78-b0f9-21ed-cf30f41f8fab@foss.arm.com>
 <20220526101423.GB795802@leoy-ThinkPad-X240s>
 <ae8bdc2c-a444-74c1-70d5-c97d27b22ec5@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8bdc2c-a444-74c1-70d5-c97d27b22ec5@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:08:30PM +0100, Carsten Haitzler wrote:

[...]

> > If the condition checking gets complex, seems to me it is reasonable to
> > use a static function (or a macro?) to encapsulate the logics.
> 
> Well normally my rule i s - if it gets re-used then do it, otherwise it just
> involves more indirection to follow. :) But regardless of that, given some
> other things you ask for that kind of makes this discussion moot as it
> requires much bigger wholesale changes to the test infra which will make
> these patches a lot more work. I'll get to that later in mails.

Your mentioned rule makes sense to me.

> > > But one catch... it really should be is_non_hidden_exe_shell_script() as
> > > it's checking that it's not a hidden file AND is a shell script. Or do I
> > > keep the hidden file test outside of the function in the if? If we're nit
> > > picking then I need to know exactly what you want here as your suggested
> > > name is actually incorrect.
> > 
> > I personally prefer to use the condition:
> > 
> >    if (is_exe_shell_script() && ent->d_name[0] != '.')
> >        do_something...
> > 
> > The reason is the function is_exe_shell_script() is more common and we
> > use it easily in wider scope.
> 
> As above - will probably have to redo a lot of the test infra involving the
> shell tests to handle some of your other requests, but if we don't go that
> way, I have got where you want to go and I can do this.

To be honest, I am not sure if this patch is related with refactoring
test infrastructure or not.  You could reconsider when you spin for next
patch set (as you said, might refactor test infra).

In case you still want to keep this patch as it is, it would be fine for
me and you could add my reviewed tag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks,
Leo
