Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159F24B9268
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiBPUe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:34:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiBPUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:34:53 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729172A417C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:34:39 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q132so3115614pgq.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=34foyzQgH1WJK6GDE5OU+q5UkwqrR0OjV9oJltEHxZ8=;
        b=aLEwSzUXsbHpjpEbePXetqBJCK4mTyMypKirkaRKMEIJxOo32byNWjOdNhSj/8uD2a
         3NOBFqO/DEwyTQOCCwXkOozXzVsnNwapuTJJgqkgFnqWssFy5spfqxO7k1X8Jv7HmB3F
         g0Fj4Iu3e14KFwBmtuO6nVr+jZNAw1rSkPFiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=34foyzQgH1WJK6GDE5OU+q5UkwqrR0OjV9oJltEHxZ8=;
        b=wsCyCiRlx1H84mu1PIla3fC6z/JdsMNs/TXBJJPQI0BBTFXc+oiwvDrrt3CgLdauev
         7g/qW9KfQO1JXBgIk/4XFh6/w1l8KH0BAQJQB/EBI59Ub+kg5CLk+WET+6Fl/xEbCr/h
         hnB7B0EulAoDWoSqafroEamMpZbJI++bIcBdw/6pAPDtKEN6yo3MJbPzNpTDsIPSzekW
         p5VgmAX0WxIO84FB3iqV+KbHWDNcsYqdNWV6NMaV+JnPJ3f8pi/XgQesMf0l9ewx9UFv
         cOrAHuH1M2J8XQh0fJsr4NZ0Gs4Zy9Lj73QMhFdT6jiwx5JFMny25b+XpwxTNMiwM7k7
         IMQg==
X-Gm-Message-State: AOAM530GCp/mb8KsmbqgIjSCkY/F7IDAHym5mtTHg+R0umhTJR9g/h4r
        4rj3afGmkzNQPo1IYy6LBR5FzA==
X-Google-Smtp-Source: ABdhPJznIfmcDoGkWc9lXrl3Y/k3eI/Gzm5CrHU0WAf7yVBSM4pE0rhp0jVMulgBcFjnnnVwf+OaRQ==
X-Received: by 2002:a05:6a00:15c7:b0:4e1:5aa5:1dd7 with SMTP id o7-20020a056a0015c700b004e15aa51dd7mr5121282pfu.60.1645043678639;
        Wed, 16 Feb 2022 12:34:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lx4sm20562299pjb.1.2022.02.16.12.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:34:38 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:34:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161234.FCBA0EE18@keescook>
References: <20220216194915.GA904081@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194915.GA904081@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:49:15PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
