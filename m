Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620924D3CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiCIWas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiCIWap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:30:45 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79204120F6F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:29:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h5so1844586plf.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=an98V/AtD70mmakLBSFdzl5jNVO5y6gUhFCcF21+EEY=;
        b=hkaigC8u1dOWV+Y/5WrTIaGgDw4SwziAkNwHjOw8BmC31/Ct8FXN5F8ZhWAfCZ6uzD
         OktEgyyX9trBlsz3TDvRCHXCTwP52EEadSYoQHbmAvslrJHY2aX+WoYHjAnSXrBDTiIk
         xroa7D2C4E/Co3wqm/f/619kWbsiafU9NMdx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=an98V/AtD70mmakLBSFdzl5jNVO5y6gUhFCcF21+EEY=;
        b=aZh+m3D2xT7d4bBg6vCmvTsOWvBA/je30e+YTrlLdg5+IgzXrgk8TeFdVDUiQ4hJtj
         nJptnoBCPO29F24l9p52oAsT2LNxFGARYnAOTCuQt1FMy/AzNSm+2hxgN0X+qR00vmAG
         t1DMIfjMFHR6aD7xkZAmr7scgcwvrXvDmxQwXRdIfL+aPmZyhNqWoic+WgDv6k6t33Rc
         0kHqn55d/zV5iwDkoS7IouJYhVa2gr0/DCb52EHdN4sT09CVOTGpru4q8XwzJC3Uwl/8
         K3c1G46EgKID8PFdVmkpP3MuFLrxxl2C9QyQcGKId029OXXYFvURqJZdN2mrZi4zFcf+
         MmXQ==
X-Gm-Message-State: AOAM532e/3HMwv3mgK6SZOWvxtHZ3L1Vfu59LiNNAUgn0c4rDh7VjTsS
        jGeCRpXVBBLgTdkcHDq/6Wey4w==
X-Google-Smtp-Source: ABdhPJztl1peMd3dcFt3FvVQqY678bzJcvCTCaLSavI4wBbgg1t2K21AogCHqUBk1esXy+D8+QBgIQ==
X-Received: by 2002:a17:90b:4f43:b0:1bf:4f89:1270 with SMTP id pj3-20020a17090b4f4300b001bf4f891270mr1783872pjb.202.1646864986044;
        Wed, 09 Mar 2022 14:29:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004f70be86728sm4303064pfc.214.2022.03.09.14.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:29:45 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:29:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 05/13] ptrace: Remove tracehook_signal_handler
Message-ID: <202203091429.08136CF@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-5-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:46AM -0600, Eric W. Biederman wrote:
> The two line function tracehook_signal_handler is only called from
> signal_delivered.  Expand it inline in signal_delivered and remove it.
> Just to make it easier to understand what is going on.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
