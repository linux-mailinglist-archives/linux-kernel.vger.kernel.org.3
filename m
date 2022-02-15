Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6418C4B7AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbiBOW7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:59:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiBOW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:59:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C85E3891;
        Tue, 15 Feb 2022 14:59:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k60-20020a17090a4cc200b001b932781f3eso3056814pjh.0;
        Tue, 15 Feb 2022 14:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ydg/QaEHk+YtzGHqWPzjDmBjfyy2f1JmjiAxPzP8crc=;
        b=neA8UZ+ztvqI+c9Y0GhuINKiFZbH9bwEKDbDdCj/aBEOg8Je4KJR2FY7wqhQqcBAYk
         3Wy+WGL8h5hMZhHiRrJnELKEzNVne+rWwRiNSK+LaaB40t3gKAMZ5iPl6SH4z0sCF1sK
         WeebZKAyrtHxpGEBt52RHDKoImWcRYibqiE5YdJSrERCh5ErepkYhiOc7Yw8VRa7JtSJ
         adEHSUdt8ZETIXkSrLoXpm9wbvKFejNQ1Fv3M/q0bRnt69wRrVeApz/eynGg7QDAnCzT
         uJF8lE/RahbG4H9xVfC7Tm4Wgh1nT1vyrj+ukgd4F45LFSngNGYO0nz3bd1+0RfzB/uo
         Q/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ydg/QaEHk+YtzGHqWPzjDmBjfyy2f1JmjiAxPzP8crc=;
        b=jcyxnoN6sH1LNSWvMVODjrCi1Ms/7ihCiQuLNAMrFzQBcpH/78A0aGGgxNLLgFLTFW
         WrusZ2fOr9fBta4oykkLyMkUveNo2imJ4f6cbXXPB0XFGhZfh0IbcbZXGAQuk7PIqduF
         91hPNb5oSKYlfSZysWanByackIqS5vJHMFRjIQP63i4EnO7nJ8059jALZfCxi8AB4I/5
         gYH7pPleib3Aa008mRWxzzXgO88LhREpfTn+FV5tUnKLWGRtPVlh5++9HQqyb+ryY3VC
         IP0M/b0m+4C/QfcXd9ucaK/N8LMSlCjuFa6dKZGrQYPKw/tS66KVQ+gLVAkzwrdqTFjS
         Q83w==
X-Gm-Message-State: AOAM533xqME4mPEYcYWb4rBukVPdwafCX+GxdAzGg6QAtQaa2ylA5Lw+
        XR7gFu+igA3JZzd5jbbo3gw=
X-Google-Smtp-Source: ABdhPJzD5VTWuMUJjUi6d0x1rXiN3okRfTcvfy3+tsDIIsH6bfb6SZ+FiyUr2n1wCBp6WTu5fGOOUA==
X-Received: by 2002:a17:902:f686:: with SMTP id l6mr1079179plg.7.1644965965923;
        Tue, 15 Feb 2022 14:59:25 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id n85sm10430319pfd.142.2022.02.15.14.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:59:25 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:59:21 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH V3 6/13] input: serio: use time_is_before_jiffies()
 instead of open coding it
Message-ID: <YgwwSUlZVakiYF8j@google.com>
References: <1644890154-64915-1-git-send-email-wangqing@vivo.com>
 <1644890154-64915-7-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644890154-64915-7-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On Mon, Feb 14, 2022 at 05:55:43PM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Use the helper function time_is_{before,after}_jiffies() to improve
> code readability.

I applied changes by Danilo Krummrich converting the driver to use
ktime_t (see https://lore.kernel.org/r/20220215160208.34826-3-danilokrummrich@dk-develop.de)
which makes this change not applicable.

Thanks.

-- 
Dmitry
