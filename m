Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C299B51B319
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379291AbiEDXLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385217AbiEDXIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:08:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED215713C;
        Wed,  4 May 2022 16:02:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so2390981pji.3;
        Wed, 04 May 2022 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Rr+WgHXJv8rOOI8pvpQMjOVULuqwXfp5l5Kbj5eI/U=;
        b=SJbLsdWh+UCFEXw+niLLiz84rSSbYf4dPLAlVoObpohxf7hMpHJwLy+enb5HNLi19L
         hikuHFoIhAekv5BaCwo2WYTlXgCn/q+Gupv5sEAiNrU6fjxuig/xYU0idZMXBF5h1Hq6
         0ZAvPgRKq7XnRajXONVgln3pi86ViAf0QWeeVNpvuMQwk27O2n4uc5ZPJsmAfPlWdxEN
         Id2clkYhIv+RqnaBOvtsNszjAuw7gtbk5xGUfg8DxG01lglnPfF+UcUOf2ozvPXDBqTz
         ASjbas5Lk98Aha7vA5lgZyP7XCn+zrPvJgO2EZGik0wJkBfO8AZnJxxolpUHi5vD+agU
         +NKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1Rr+WgHXJv8rOOI8pvpQMjOVULuqwXfp5l5Kbj5eI/U=;
        b=oifTj7VapLQ1nALggrpE3DnBUNKDsBKEpX6roSaaSf9Q+F/3Yh7xoD9xDo7jmnVaGF
         CtSQUC81IAyUYrPL6I/pGBWX2iVesNDf0OtT85kdOLcc6NxLI219VUTNb4s39d730SCe
         H5jPV6cc2SZoukpFFn+jEvbEMdYLPtpqc5QZQd0d3zEeMC3BNTBSvBsUIW1xlGTYjGMO
         yMEvAmZBNxdzIAH+MBcvk+vtHeaBV90NBk9hhlzf6skW6x/xak3JjkBIn3dK8dsEoHV0
         Fw3EeoHy0euz1j4aK8bA1SmliG6yLbtUEuRWCFq4KwKqcf1kaE2kzwM1Ct3K+GNuhoRx
         SjEA==
X-Gm-Message-State: AOAM531Wa3MeAXX0rOCA3a5H6xjdBDptOkkx3yl4ZGJi3j+/Kl1jewbL
        dwVpI6o/1+wNyMHjQ2Y3XLA=
X-Google-Smtp-Source: ABdhPJz5g1/ObcqQ/7zif9FdDIYAQu3KDWw5Ct7spx/oki1o3ZwqqFDirM0depnLfLZRUYIuN/T53w==
X-Received: by 2002:a17:90b:8d8:b0:1dc:932d:3108 with SMTP id ds24-20020a17090b08d800b001dc932d3108mr2306855pjb.132.1651705370641;
        Wed, 04 May 2022 16:02:50 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8435:b3e7:62fc:4dfa])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78394000000b0050dc76281a7sm8776540pfm.129.2022.05.04.16.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:02:50 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 4 May 2022 16:02:48 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     ngupta@vflare.org, senozhatsky@chromium.org,
        linux-block@vger.kernel.org, axboe@chromium.org,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        mnitenko@gmail.com, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v4] zram: remove double compression logic
Message-ID: <YnMGGMitdYg/5e4z@google.com>
References: <20220504121243.63407-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504121243.63407-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 03:12:43PM +0300, Alexey Romanov wrote:
> The 2nd trial allocation under per-cpu presumption has been
> used to prevent regression of allocation failure. However, it
> makes trouble for maintenance without significant benefit.
> The slowpath branch is executed extremely rarely: getting
> there is problematic. Therefore, we delete this branch.

Let's add about the stable_write, too in the description.


"Since b09ab054b69b, zram has used QUEUE_FLAG_STABLE_WRITES to prevent
buffer change between 1st and 2nd memory allocations. Since we remove
second trial memory allocation logic, we could remove the STABLE_WRITES
flag because there is no change buffer to be modified under us"

> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Other than that, looks good to me.

Acked-by: Minchan Kim <minchan@kernel.org>

Please send the updated patch again with To: Andrew Morton <akpm@linux-foundation.org>
with keeping Ccing.
