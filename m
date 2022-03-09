Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11D24D3D18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiCIWiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiCIWhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:37:54 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6958F122201
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:36:55 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e2so3210788pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NkJ80xBT0ib31wckUFxWwGpu2ympA41Nowl9Of9jprA=;
        b=B2z1aALg3HDOlBGV362QpNTrfOf2qGycJt9vCC6bSw4lUVyaKT84HXh00sOGAxM1Sm
         e/1ckdrHY+8PFN6qg1DWRWVy5sIuxad7BeDGv0KsNjw2KyVeSFphiZmsL0S66rqCKYIl
         0amscOfdT0yTBh0GuViMSmwvkd67Fs2FU6AmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NkJ80xBT0ib31wckUFxWwGpu2ympA41Nowl9Of9jprA=;
        b=taF/EHxNdnbEmZ/wTBIoxXzhAdI4IoM55pOzulmHUFKh5DT/Vi4S0GzbqTG8LJDlE3
         KK4Qu8q9w4Nfm88qBGR36FF7oIDpbTLXrKeSMqaevM80rX+fl3wNONp3vshZTZ/IVtNk
         iJLBBx0RRDw1aLGhgDN+4DLHnJnslVm0WrZjrgioDhu3ZCP6Bg7iQASH5+YJY4r8XjaD
         n+D9TIZKA6TtruG7XH8gUcnPYvK9FVwWNIN3+WXuLFzmeXASDpiTR/N9lBU87+LVlkXf
         v7I0UlDlpwq3lrcDOGyQ1p28C4wjVQvKN1gxXus/JqR8Ppamn0epqgS0TGDWHY/LiUpe
         idNA==
X-Gm-Message-State: AOAM531E9eheZvokbABHKMw/syM2RKYNvd+RiKrQeyR8qaHoK/tIpFbN
        JCHa/Jjnki9KpmiA02AwueZmDg==
X-Google-Smtp-Source: ABdhPJzI9BCHCqMjuPeg8SyX5s+zOkEEZcMVzjtL3LoJVV/W8nFLK6Et18b5K6l3VsAlTQ8LR7/QMQ==
X-Received: by 2002:a17:90a:950b:b0:1bc:a78a:8f20 with SMTP id t11-20020a17090a950b00b001bca78a8f20mr12797369pjo.42.1646865414929;
        Wed, 09 Mar 2022 14:36:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090a510700b001bf5f79a770sm3721917pjh.15.2022.03.09.14.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:36:54 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:36:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 10/13] signal: Move set_notify_signal and
 clear_notify_signal into sched/signal.h
Message-ID: <202203091436.8E21CBE210@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-10-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:51AM -0600, Eric W. Biederman wrote:
> The header tracehook.h is no place for code to live.  The functions
> set_notify_signal and clear_notify_signal are not about signals.  They
> are about interruptions that act like signals.  The fundamental signal
> primitives wind up calling set_notify_signal and clear_notify_signal.
> Which means they need to be maintained with the signal code.
> 
> Since set_notify_signal and clear_notify_signal must be maintained
> with the signal subsystem move them into sched/signal.h and claim them
> as part of the signal subsystem.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
