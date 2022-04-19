Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7042507BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357973AbiDSVXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355594AbiDSVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:23:14 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55484419B7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:20:31 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f17so33359080ybj.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDMzo26rD6fYXWY54f2zSMKCNkgnMROahNS4BdJnPfM=;
        b=Oi9IpFd6aL5BPH/1EG7lcfBwHK6vADKSshr8EgBuHyIkTbO1H01m2vBZJcVnl/FMkB
         5zjd97po9T0Fx3QsMqF4/VrK+qm0xv2GrS+nVUcAO3+tj/yA0Aqj7WF90vCbnImmw/Gx
         koIGsEslkl2aJ2wbwU3aYvQTiQOubfQ7v/aHOf0zqtV8jDbftI9h781m0OYQcNsHBGSz
         5UdmtVHu7g/1xwHXFw1A9/Vtss/M7PMiBftpIhSQbUyWXtCi38FOEaqtjZX2dySZku28
         C8/tc5M+6nmEyzTs2XzAqi7x3X2myWUbdFgKh7a9+KQTlOjCk2YZ6v3+LL6kUcvKx4Ex
         o+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDMzo26rD6fYXWY54f2zSMKCNkgnMROahNS4BdJnPfM=;
        b=vVO1aqMMkJvGaiOUvm2PtXK4ReFksonT3cxWF7hfpnG1jK8UVsz1WYPjNvJdFj5p/M
         +5UmkJpj4eiDCkvBJjdg8MWFrzbAIlmwaWUZRjyGymM1GVZKGfdEYtr57SdxVIRvP+TZ
         XeovQi74IjWwsjd3X/bn49YbZs4bTIdHL62UflbjvBqcjF6rZGQd7YnTHw5Nz8HXRvFL
         zW56GeFrVCbwjwpCvz7qkpOxkU7icxufI2yKdEbxTTfm2K40vl5IyMt8eqAWkGXRTc8f
         s4Z5FnYjLvVAEihYj43zJD7bMrRoaN71t6VQJmjvXlPsio3PWOZAEY0xaslIsSWQeUdy
         cu0g==
X-Gm-Message-State: AOAM531Fs7voDsu1uitwglE7o+5zkmHR4WuofbFMizIw2242Qdh7oxg4
        55H47aCwt9Q0p8PqC7+B5KbCufH0RIpdVs8aqEnxBQ==
X-Google-Smtp-Source: ABdhPJy0Pe3/+istHJyTLVgpPsb/YVL2KkaWy5BRycz4N4ev9x9nbNSMwfvigObD8BNUB2sah5hxeyrbLUQM+omSUD8=
X-Received: by 2002:a05:6902:1109:b0:645:58e:a373 with SMTP id
 o9-20020a056902110900b00645058ea373mr12213472ybu.231.1650403230312; Tue, 19
 Apr 2022 14:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iL+CHRi1HJ6Mp4u=ECnfAXV2qxXZj_BsQuv+uwheAfDDw@mail.gmail.com>
 <87ee1svmdy.ffs@tglx>
In-Reply-To: <87ee1svmdy.ffs@tglx>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 19 Apr 2022 14:20:19 -0700
Message-ID: <CANn89iJX6ff0g7HC7bGXY_iyLSshiNf=ui7h6PsdnY2jZj5DaQ@mail.gmail.com>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 1:39 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/amperf
>

Excellent, things look fine to me.

Before:
# grep MHz /proc/cpuinfo | sort | uniq -c
    255 cpu MHz : 2249.998
      1 cpu MHz : 3297.719

# grep MHz /proc/cpuinfo | sort|uniq -c
      1 cpu MHz : 1590.400
      1 cpu MHz : 1684.772
      1 cpu MHz : 1693.890
      1 cpu MHz : 1780.072
      1 cpu MHz : 1784.513
      1 cpu MHz : 1831.106
      1 cpu MHz : 1880.344
      1 cpu MHz : 1953.481
      1 cpu MHz : 1980.636
      1 cpu MHz : 2013.620
      1 cpu MHz : 2219.617
    240 cpu MHz : 2250.173
      1 cpu MHz : 3292.206
      1 cpu MHz : 3294.956
      1 cpu MHz : 3297.653
      1 cpu MHz : 3298.385
      1 cpu MHz : 3300.197

Tested-by: Eric Dumazet <edumazet@google.com>
