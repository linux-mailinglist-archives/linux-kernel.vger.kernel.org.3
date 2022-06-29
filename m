Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC14755F42B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiF2Dfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiF2Df3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:35:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9804217AA3;
        Tue, 28 Jun 2022 20:35:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so14724143pjz.1;
        Tue, 28 Jun 2022 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D2aFA+bFpPxEe5bMLJ1ZIo9L1RS+fG1ZBQyRCUa2ETo=;
        b=ZBIhBP1zYl4okzoyzm4jWVCrgC3CwdER63YQbkjxLRAXCB/YC82E0EEEJAS1Zuf8lU
         H635lhJojzKQHO5wG8CrqQcELemBj4SPxAjFXR1yauX8desaJq3O4YFcU6copsbJJStl
         mt1nh50u75y/frWjCOUzxkbWD1L0fEdKCLVdvnKp0ChSrR2bNtc7gF2LjuQV9AKNzNpl
         VLOkkzY0+qsinMCamE+/PjT1DOQWnVUZxS/MTRcr9UQOpg2lwqqvwAmBFiNX1buMwLdc
         zpzCbfSlmkdTzVW35wn9M8BKc1kcedHmDL+SBBG3pIrYxBVdyKwr37sCEBDWeo4BksSV
         NERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D2aFA+bFpPxEe5bMLJ1ZIo9L1RS+fG1ZBQyRCUa2ETo=;
        b=cSB/3FFRXD1K/RveQ3HsY9M7jV5iJEhggl/4H4j/2JTp6o2JOjAtgWsRk412dSmetq
         GBIl5K/wpE18KTFrZItfHlKt0hAjR5re6lksMepi84lcj0ACARXmDwSK+oXMrnoI/sFw
         Dw28yU3syGVV4352Q0ZpVaFQiBaYG1Rc6DFYJRVHAofJsteLP1pDm1RwS/Qk1hJmti3D
         j8sbX4TZkJEuZEiwZk2c+AsokpsPpdRcPszG7h3oVdyavPWAJSLhxJ8k+JyKY9Q1IflI
         zQUFjZWoZd4zvPoChnA2J77HylFFGLbuBGPhEhBcdJ/yEGbQyAwrY6vzvvF4FR0MVUQY
         7khQ==
X-Gm-Message-State: AJIora/sju4F+UVgPZTY17ksW+hdjbw4tuYUoFYIeF7U0+vNgCrMWo6s
        2TKP7LRm6cvcP4qiKVJ1anE=
X-Google-Smtp-Source: AGRyM1u1TR/TpQ2WRWTmqoGhP82YyvnC1kKRqjw8xfSzHzCSqyJD4mZQfqFBCG1BWhafj69+/wb+vA==
X-Received: by 2002:a17:90b:3a8d:b0:1ef:7d4:6a5f with SMTP id om13-20020a17090b3a8d00b001ef07d46a5fmr1430047pjb.139.1656473728111;
        Tue, 28 Jun 2022 20:35:28 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b00163f5028fd6sm10145937plj.5.2022.06.28.20.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 20:35:27 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9E615102CC5; Wed, 29 Jun 2022 10:35:24 +0700 (WIB)
Date:   Wed, 29 Jun 2022 10:35:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 14/20] Documentation/rv: Add a basic documentation
Message-ID: <YrvIfPPvV7yXrpCf@debian.me>
References: <cover.1655368610.git.bristot@kernel.org>
 <575554f7bebc0278dd3dfad056d4438c2fbab7b3.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <575554f7bebc0278dd3dfad056d4438c2fbab7b3.1655368610.git.bristot@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 10:44:56AM +0200, Daniel Bristot de Oliveira wrote:
> +For further information about the principles of runtime verification and
> +RV applied to Linux:
> +
> +  BARTOCCI, Ezio, et al. *Introduction to runtime verification.* In: Lectures on
> +  Runtime Verification. Springer, Cham, 2018. p. 1-33.
> +
> +  FALCONE, Ylies, et al. *A taxonomy for classifying runtime verification tools.*
> +  In: International Conference on Runtime Verification. Springer, Cham, 2018. p.
> +  241-262.
> +
> +  DE OLIVEIRA, Daniel Bristot, et al. *Automata-based formal analysis and
> +  verification of the real-time Linux kernel.* Ph.D. Thesis, 2020.
> +

Shouldn't these references be formatted citations reference syntax?


> +For example::
> +
> +   [root@f32 rv]# cat available_monitors
> +   wip
> +   wwnr
> +

I think the prompt should be just `#` (without username and host).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
