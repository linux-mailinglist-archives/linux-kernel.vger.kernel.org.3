Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CCE4D3D53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiCIWza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiCIWz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:55:28 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF060CCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:54:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n15so3272890plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1MszqRk2G+4KKmA8wgw2AQz/51eiDVapPKJSRNjw8Yo=;
        b=TacQl2G57W8Sv/vDRS/gmUxVy+OGWidNJjNNyYaGyK4Yz4T0vThNRqAWxU0K3Ji50P
         AsgaU/UPjLnONO5BCYiFyI2H+WFj6gAOZ/FvZ5X9jfZgQuCUID0+c0FyM4CHKrY9XzIQ
         X2Bn2EYpwj89akeEZ/DG/Fp1iK02skEMgnYDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MszqRk2G+4KKmA8wgw2AQz/51eiDVapPKJSRNjw8Yo=;
        b=NPY5oQFveXwyCLRKdA8nCBPc4QZYkE3RDgPyghebi+VVoaqRK2Z/XLOlige4+vmdbt
         FtlN/okY2QVai6d3gsl6r6C+hwyHQbvU/m3qCZW+PBD0HIDiupzqfk9DlnbrsmS9h/qU
         AI61HKS45XjGWs1YooMjVuHpgVgbfxQYQn6cpNzFpYZzOCqB4OOCKi5fY3S9uK5F0hMF
         a8FpwgDHf8X/awzcCKENZUNIbaYJCcOvZWqN+qD75K5slARQaZRpeqY+5gsOM0gqz1q2
         WnH+7ibptkhT56yRtWKmOKJNnMrPiobH1daZixcyroii/LzwP6+NI8bI0zZWbzAYCGIz
         ZXJg==
X-Gm-Message-State: AOAM530jWmSDX2m7W+Qhsu33xVcGTVLoqBQZpkcG+ELDIYgdHkeVdzhC
        MMcfoHuDhSCVOVJ1rCioTQbCrQ==
X-Google-Smtp-Source: ABdhPJwSEz/Hev0yyASHWF6jwZhDuo0NyNUEZNZyq+YYBPmkVqUbSkP2N900gAJgkUjfBYb84HLcKQ==
X-Received: by 2002:a17:902:dacc:b0:151:c216:2772 with SMTP id q12-20020a170902dacc00b00151c2162772mr1806651plx.107.1646866468344;
        Wed, 09 Mar 2022 14:54:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c7-20020aa78e07000000b004f6e4d8ccc8sm4190269pfr.163.2022.03.09.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:54:28 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:54:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 12/13] resume_user_mode: Move to resume_user_mode.h
Message-ID: <202203091454.91E946DA49@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-12-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-12-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:53AM -0600, Eric W. Biederman wrote:
> Move set_notify_resume and tracehook_notify_resume into resume_user_mode.h.
> While doing that rename tracehook_notify_resume to resume_user_mode_work.
> 
> Update all of the places that included tracehook.h for these functions to
> include resume_user_mode.h instead.
> 
> Update all of the callers of tracehook_notify_resume to call
> resume_user_mode_work.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
