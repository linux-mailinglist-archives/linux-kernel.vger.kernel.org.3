Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F954C06F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiBWBgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiBWBgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:36:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B34A93B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:36:05 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g1so13861358pfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rqGrmy6lbtN8CiyKUgUga48hRbH1yOq0jwvMOL2mylw=;
        b=CeAFQh4zL40mHQRpMM4poJnfaYnjJ/3vwjsyaR/T7gdO3wW/MyqDi56j/tQxq9F/4m
         YpufggfH2s8FqmVgBe2AxuB29WOeGgvEKqALHKgLVcI7lT9kcOfLhYttfmxmv183KDE3
         D2SefRWEOrrDAHI8yRN8j31+ZgUJV5oH5hnps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rqGrmy6lbtN8CiyKUgUga48hRbH1yOq0jwvMOL2mylw=;
        b=6SI+IApeCCcyuF/BjnUi2OCi46UVoHw5gSHyWMOSoNdRjd3oRI+9I9yv6cqFQdho+V
         +Xg/9CXzeFpc4ArWx4PuHsr9K3HKVK7Dc5wqQ6vHzlf46/+KiTraErCKrhvWJA7FNnRk
         KDFXyvkRMmNCOJu2+BVOhjhLHJtcO8X3/2r5qeTsJTDcOe+y9OMMr5gJogrQryvP/jfL
         62kvwXkkfmv2/LBAuEkRsoNJFGx0v8OM8DHmI0tv4ahMapngCsQe0jglGgZLawT3wirT
         H33uvWJ5/jC3bLv6Vu4UyC+IONIjUtWMhVtJKs1BZiftHsQTvEmj1GWQ9P4yH/WClNB4
         cj6g==
X-Gm-Message-State: AOAM532ziGijYTumCWLU7DkQS+8T+/O+bgwl8S5mWVpExB8WLki78Ur7
        gy7yGezVd9Smr0XGXjmZU0xHcw==
X-Google-Smtp-Source: ABdhPJzKAAFb7l7hq3G+BT9glTw7pgjLkfm6ugzus+sPF1ddbDZvDFLbifY6Fme/KsZEhzc9jvMU1Q==
X-Received: by 2002:a63:4d10:0:b0:36c:dcd6:46d7 with SMTP id a16-20020a634d10000000b0036cdcd646d7mr21700493pgb.207.1645580164896;
        Tue, 22 Feb 2022 17:36:04 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d2bd:9913:3c85:9aca])
        by smtp.gmail.com with ESMTPSA id z15sm896340pjf.31.2022.02.22.17.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 17:36:04 -0800 (PST)
Date:   Wed, 23 Feb 2022 01:35:58 +0000
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>, bhe@redhat.com,
        pmladek@suse.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhWPfqPlllm5XXHh@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRAOQbH15E7y9s8@google.com>
 <7702bdc2-78ce-00f5-d5a4-c06527c3ae72@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7702bdc2-78ce-00f5-d5a4-c06527c3ae72@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/22 11:08), Guilherme G. Piccoli wrote:
> Hi Sergey, thanks for your feedback. So, personally I prefer having the
> flag - for me it's clear, it's just a matter of reading the prototype -
> either we print the info _or_ we console_flush.
> 
> But let's see if others have a preference - if the preference is to use
> the bitmask as you suggest, we can do it in a next version.

Sounds good to me, thanks.
