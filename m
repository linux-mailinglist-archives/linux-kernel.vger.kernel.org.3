Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DEE524083
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348986AbiEKXGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348992AbiEKXGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:06:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F7029C84
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:06:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 31so3025533pgp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=wp2EX9vjKBERiNLVm2YqE4Qazcs+sBTSt8gG1hLKc48=;
        b=0lEWBFfhsdG9IId5GVveiAnldtVBmoSpEs2i4HsAWqt/iB4StaKi6DfEsruofQfLWx
         uw7e1Ed0i836DvAtDxkr6W+u1IWP9ZhseUwzVXuybeGQYSFDJNv2tgH3y0P8/67FWFp2
         AE9kjICIrnDNadxbQ0Lp/eE9JYnq6jncO37WK/GNovN/vfTq1esy1hVTDR61tXpJDylM
         4AAnmAZIag4R7SrUZFtJP+zMFinnk9CGJP2y2wmA9GqSJYrHkRbGYXHVppR7NOAQW2Ix
         NtCtiqwIlMg6v6IOa74j1UPcctBQ+/gtJWUXar86UvPyQd5X+qoJz683pUA+eYOEbJcW
         P90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=wp2EX9vjKBERiNLVm2YqE4Qazcs+sBTSt8gG1hLKc48=;
        b=QIUuvOt7LnoahJd5kwT6kRqPbjNJ3nd6Axw4UB8S1urr0BaStipXcbeQKJqtA99L5L
         0rAkaY60+grEe/PSMXTvBrWsijd79qxOLLwIUhlfgYGDveAvD/NmWUGbEIp3AOOA4yX9
         FOVqeQtUy4MxyIonRl24QfasIovdphgdVCCr5CKqGg6FkjOnPB8B0h4dI12Piu2G5XtT
         a3G8cX3qARWghoJhcc0GPKjUap8c4yw7y4LaCR609hq2g3l+Gu4sJnqDAJCLoZkyDSKu
         crcQDFL15cYRAIoAnOHPK7VptiYScNiZiwE5KO9Dfr4PjFAkR9I+Z5UtRlQvvEEgPeAy
         3nuQ==
X-Gm-Message-State: AOAM533nIV7kk4Q/wtMyAk2uKnmBaaQpdvaVY+OwIoVDBTab6AT9pC8j
        TDdPQ8NjjNA9MrPnzzwY+dr564bHRth57Q==
X-Google-Smtp-Source: ABdhPJwZ2VgQYwg6fjILGazTAqXGaVFmsdZbwOX3wddLlrT+rWFgzZMa1pmGwGV6SQeR8dw81bnIhQ==
X-Received: by 2002:a63:515:0:b0:3ab:84c3:3f37 with SMTP id 21-20020a630515000000b003ab84c33f37mr23152360pgf.110.1652310376457;
        Wed, 11 May 2022 16:06:16 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f34a00b0015e8d4eb1d8sm2387443ple.34.2022.05.11.16.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:06:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, zhouchengming@bytedance.com
Cc:     duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220510034757.21761-1-zhouchengming@bytedance.com>
References: <20220510034757.21761-1-zhouchengming@bytedance.com>
Subject: Re: [PATCH] blk-iocost: combine local_stat and desc_stat to stat
Message-Id: <165231037549.15699.13051976092288865949.b4-ty@kernel.dk>
Date:   Wed, 11 May 2022 17:06:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 11:47:57 +0800, Chengming Zhou wrote:
> When we flush usage, wait, indebt stat in iocg_flush_stat(), we use
> local_stat and desc_stat, which has no point since the leaf iocg
> only has local_stat and the inner iocg only has desc_stat. Also
> we don't need to flush percpu abs_vusage for these inner iocgs.
> 
> This patch combine local_stat and desc_stat to stat, only flush
> percpu abs_vusage for active leaf iocgs, then build inner walk
> list to propagate.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: combine local_stat and desc_stat to stat
      commit: 2a371f7d5fa575010b915e325c5d20b9ad0d5d5a

Best regards,
-- 
Jens Axboe


