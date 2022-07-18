Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267B578DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiGRW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiGRW7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:21 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355A2AC6B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:20 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10cf9f5b500so26725081fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NV4dJf06JpETuYEa97f8Es6YEFSzPZEdSxUhK7T8gPY=;
        b=gPzrCbF/R4aQCEbz26PodRSoEiKvAeWc04hPzE9RyiN1WMIcOjYTmF0gQXFQ6xuWxZ
         ej7u7SINT0nm+xJ3/zPHbwH3Rz6Qi+XAoi6N50Wcz91jLrsQCo06n/as8djohNYQjlJh
         579MV676S+LYuvIp3gep9qjC9J0uONFB7qXpwbp4XWYVNQlvaYsKwIkh2O1gK9lHVkLM
         YDTZFK/f4FW4t2HESTneTypMI/rf39Cn8iSCDclCZE90Nh9aSgb2UMZ5XQiOHUkJ8J6j
         Hf9X9SEQiegkx7HhkrlWCkxqHzeHV/veOlT77PjRluKAXWHCz3Dd3TJZ/ias7QU7IVlY
         19zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NV4dJf06JpETuYEa97f8Es6YEFSzPZEdSxUhK7T8gPY=;
        b=epQCKsBBVTP1uUN7UXvajBGC3hGFTpykPSj2Gj2O8fE0As28/XOLvMggFptx6KyKzL
         h4TTeO41NLYvlcpM93aUOVcJo1DTuz7fiiA6XHQXZiw8aYx2DL0DyzkY1Q7bsYwkMnUS
         9Krn99K5wCkrqDj3SkmJX+JhxjtgXaCjrHbvhESRZQCBWUBXFSCdcPHAM7fDKuk2hB04
         1BWmP8HGgQ3CmCFK5LFf2/frdoLGVFAQg/elWFHSzBfZpKv9sNSkbh/j2YR/7GJeLTWg
         0BL3F7yZKiLdvYegC7ZAAJ9mFe38OQ7c5Kah+2jgpcthV44Nog8RJ5mGwua/SeFwe3WT
         5LVg==
X-Gm-Message-State: AJIora8sC7GYrdGvY43I12IcYpm90EoN12x6rROm+QRGecqkdj+DRM/D
        XIjA16MNe9UvpVZ3x+uM+t7+zg==
X-Google-Smtp-Source: AGRyM1vgx6CtiMspHJBNgKe/N241+t6rCwdY0gCPfz8aB0tXcuvxtoONpVe8nImPqBXA/YO9JvT0ew==
X-Received: by 2002:a05:6808:f02:b0:33a:59a3:3a12 with SMTP id m2-20020a0568080f0200b0033a59a33a12mr7727380oiw.181.1658185159331;
        Mon, 18 Jul 2022 15:59:19 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: (subset) [PATCH] remoteproc: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Jul 2022 17:59:04 -0500
Message-Id: <165817634387.1905814.7963009931516641488.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220411013656.2517150-1-chi.minghao@zte.com.cn>
References: <20220411013656.2517150-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 01:36:56 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied, thanks!

[1/1] remoteproc: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 3ebebb9a2d9a5c2d2b866739b50838dc152727fc

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
