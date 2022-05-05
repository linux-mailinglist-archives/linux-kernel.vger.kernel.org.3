Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144EC51C583
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382315AbiEERBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354735AbiEERBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FBB5C84C;
        Thu,  5 May 2022 09:57:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 202so4060920pgc.9;
        Thu, 05 May 2022 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gLSrukFuN1JT85xjZBxcJ9Q6yUhYQqPZheqHwdhEg7U=;
        b=EKhBGUnGBYw2xmGFpRKZDvm+Gh13g3mCjpWQiTZSpTPei0JV5ZgCBH9Oxvyji5VBuU
         PqYXCDhWkvHLFMxZ/Ni2Kkub8AuPe4eyJaqzw4RvqWU7r3BqkE1kAD6OMsTO9vdurJKK
         WyVB4xrkHIrnfDp43sbRELj93B3KdGhyoxHZ/jvQbbMaT57d0BEhNiCly7IQUbLdXeWO
         psSrNSQyfu6EmEIqqjyaMVI8aSciM/mz7sVYxATpQ8S1ujE2qIpMALTJqL70cYML2Yj7
         +ivv0MOzSpe/EwSDFcbJOumobB0gM+MX8/GF+jMfkGx5UuO8t85s6l1fA+jkLUfex2g/
         fJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gLSrukFuN1JT85xjZBxcJ9Q6yUhYQqPZheqHwdhEg7U=;
        b=kiQWUAKBTG3JgWXOPKOHIg4Mke5aooRTNNrpr2yj1ZIB9cBHRZMl4Q47k12kv1auUT
         XGHgqKOLwve2XduP8WMvnU2X1KlbtzQtqh43ljK3JT2AdJDsXhsH50O68eyAGXLQDrdY
         c8XiPlAGBo3ehNmw5H47EgvOd2NqevTpnTuly6Ozv0A9a8fUvOlHQssmiUk1R0oq4BRF
         gYwPhVwtAKEc1jn3V766NpbfFUxO43xXUW/MkWwl0E82tZu6P12xXtA61RMzp527SHtj
         TEI7JvuNJRujjoYOKqmSAiApAYZPeHnXwPVWfbnG6aDzbVJI36S8dRV/8KWTvJteyYgC
         SdHQ==
X-Gm-Message-State: AOAM531qy/MkNP2j75ZYvdpeZgdkIwFcFjbCCXCizockQPHenh/jn5M6
        afVjZpm+o6QsgXXrLEsTqiU=
X-Google-Smtp-Source: ABdhPJy9XDrGdVUvOftS6Oi4+mMdvrkbx3+EWJx/3U1/ctK7WY72JKO4bqE965kTvk+ZECHhQ2ARuw==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id p15-20020a056a0026cf00b004f6fc527b6amr26567624pfw.39.1651769824001;
        Thu, 05 May 2022 09:57:04 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:1c0c:8050:e4d3:12f5])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ccd200b0015e8d4eb221sm1751056ple.107.2022.05.05.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 09:57:03 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 5 May 2022 09:57:01 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     akpm@linux-foundation.org, ngupta@vflare.org,
        senozhatsky@chromium.org, linux-block@vger.kernel.org,
        axboe@chromium.org, kernel@sberdevices.ru,
        linux-kernel@vger.kernel.org, mnitenko@gmail.com,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v5] zram: remove double compression logic
Message-ID: <YnQB3X2wy7lEku+y@google.com>
References: <20220505094443.11728-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505094443.11728-1-avromanov@sberdevices.ru>
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

On Thu, May 05, 2022 at 12:44:43PM +0300, Alexey Romanov wrote:
> The 2nd trial allocation under per-cpu presumption has been used to
> prevent regression of allocation failure. However, it makes trouble
> for maintenance without significant benefit. The slowpath branch is
> executed extremely rarely: getting there is problematic. Therefore,
> we delete this branch.
> 
> Since b09ab054b69b, zram has used QUEUE_FLAG_STABLE_WRITES to prevent
> buffer change between 1st and 2nd memory allocations. Since we remove
> second trial memory allocation logic, we could remove the STABLE_WRITES
> flag because there is no change buffer to be modified under us.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Acked-by: Minchan Kim <minchan@kernel.org>
