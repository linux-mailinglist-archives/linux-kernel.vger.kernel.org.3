Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB71755EF17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiF1UQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiF1UPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:15:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7DF248E3;
        Tue, 28 Jun 2022 13:11:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i18so24222433lfu.8;
        Tue, 28 Jun 2022 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yP7z++hmLdln35/PWmu6kJvToesBwvqVRLcqwtfTqHw=;
        b=Wf4kJNvUbmGXAp0NKucvsRru3Al5eajFw/oZCCKXVRRSqAQeeg8pU5Ege0VPhodaH7
         IEvU3zGwXrbw+cRkIIQcjHHVhS8kZoOxWWZkL3cJEM0QeyptAEr7JYrzzIseoD7tWwNx
         GwEWmjo8AA9qQAOthsc9dxhRBtotQ5CWSpAy4Z5KA4HJNAOLWvmdl/DBy+mLSpTuwguG
         nXhqsIWc0WAhnJEKWESan3ugOFaug8LyIgmFKNvWHvMWfvOG2TncTre7680CDJF/DzZs
         wADgKv0PoqodHkVCeWuh9jF85+a3yot3LdR+4xBpltsfJhTaVVjqHbtImVNB8Digj3+w
         J20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yP7z++hmLdln35/PWmu6kJvToesBwvqVRLcqwtfTqHw=;
        b=4UVV9UFKDlF281gjmd9p4yoI8Tgz3SjoOxvsm78sh0ofi12zH1cF9eJulF430d8ceE
         j6lVukb4OcJPfcS4hcVD78Mw6u4c5sPjnWF6+RHhZPPTGvjeSUx+7g2jle5cjfp5shKO
         miyvt9psuiAJlimzgggbwnedjdHDjuTxqS4kEOT8cY1X4s2yG8hoJZV8cpQfnoLNZ1Et
         xbbffavW+U4wFTca2kYftT6XxfYKslaKUZ6iG+QIrKD2Pn8o6BxtgdkzJGAxDUrxXmms
         snbMPvesBFK8JlEOjWIO9ZTIvqoi0pcEDUssGoexvAHzPGX+v99nvDfw+Lqwi6Rg0qKM
         LWAA==
X-Gm-Message-State: AJIora+ImrJOuZOdNMyM3r1lG0l1B/eYd7nEJx3/PkbwXBpmd23YAw2a
        kb0JCGbhTv9VimHZXUC4nFY=
X-Google-Smtp-Source: AGRyM1s/SxLBCRJqtNijzYQhHtgDDNIM9SkW0fxBYF0tjMUjSiLBy70E08Gxvmb304uwHefJmXgTew==
X-Received: by 2002:a05:6512:128f:b0:480:fd23:6647 with SMTP id u15-20020a056512128f00b00480fd236647mr13566368lfs.136.1656447105293;
        Tue, 28 Jun 2022 13:11:45 -0700 (PDT)
Received: from pc638 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id v8-20020a05651203a800b0047f9fa2925csm2315627lfp.234.2022.06.28.13.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:11:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638>
Date:   Tue, 28 Jun 2022 22:11:37 +0200
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     paulmck@kernel.org, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        christian.koenig@amd.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>,
        rcu@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>, Theodore Ts'o <tytso@mit.edu>,
        uladzislau.rezki@sony.com, urezki@gmail.com,
        wireguard@lists.zx2c4.com, Xinhui.Pan@amd.com
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Message-ID: <YrtgeSmwLmpzN/zw@pc638>
References: <1656357116.rhe0mufk6a.none.ref@localhost>
 <1656357116.rhe0mufk6a.none@localhost>
 <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656379893.q9yb069erk.none@localhost>
 <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656421946.ic03168yc3.none@localhost>
 <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656443915.mdjoauhqe0.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656443915.mdjoauhqe0.none@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Excerpts from Paul E. McKenney's message of June 28, 2022 2:54 pm:
> > All you need to do to get the previous behavior is to add something like
> > this to your defconfig file:
> > 
> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=21000
> > 
> > Any reason why this will not work for you?
> 
> As far as I know, I do not require any particular RCU debugging features 
> intended for developers; as an individual user and distro maintainer, I 
> would like to select the option corresponding to "emit errors for 
> unexpected conditions which should be reported upstream", not "emit 
> debugging information for development purposes".
> 
Sorry but we need to apply some assumption, i.e. to me the CONFIG_ANDROID
indicates that a kernel runs on the Android wise device. When you enable
this option on you specific box it is supposed that some Android related
code are activated also on your device which may lead to some side effect.

>
> Therefore, I think 0 is a suitable setting for me and most ordinary 
> (not tightly controlled) distributions. My concern is that other users 
> and distro maintainers will also have confusion about what value to set 
> and whether the warnings are important, since the help text does not say 
> anything about Android, and "make oldconfig" does not indicate that the 
> default value is different for Android.
> 
<snip>
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 9b64e55d4f61..ced0d1f7c675 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -94,7 +94,8 @@ config RCU_EXP_CPU_STALL_TIMEOUT
          If the RCU grace period persists, additional CPU stall warnings
          are printed at more widely spaced intervals.  A value of zero
          says to use the RCU_CPU_STALL_TIMEOUT value converted from
-         seconds to milliseconds.
+         seconds to milliseconds. If CONFIG_ANDROID is set for non-Android
+         platform and you unsure, set the RCU_EXP_CPU_STALL_TIMEOUT to zero.

 config RCU_TRACE
        bool "Enable tracing for RCU"
<snip>

Will it work for you?

--
Uladzislau Rezki
