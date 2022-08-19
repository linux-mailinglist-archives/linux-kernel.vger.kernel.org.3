Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E159A741
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352135AbiHSU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351912AbiHSU43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:56:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F9AAE51
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:56:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k14so5340072pfh.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=TspGg8RA/kX2lN4CLyM+oSg5D5K9Xh9asKYi5WRBw6w=;
        b=X87kIQd8Sws8VbhM7n5p21HC31jo4SDuDpDg5OwtuAnZa42ul9ZQWg5tqhSmY30pjE
         DozzYKzs9qHc1wBZccv9dp2Hctqi0WadF+WbhNgyX7kYwY6RGLQ6rRONOkZFlqWzv8UI
         CckAUSrWKZpRug5gIYtapbXDR6z+c5vT24DGJPaNHRNfyeYp+W/xT9P8kc9pZIQ8PM5h
         D8YpyFWfd353kmYfGC+UKN5HkEtgYNGl7GzP1iysuqb6SB357D2NpAW5gRPUYDlz6FI4
         Ikr1G1g3LF4OlEPEcXmxn0QLLv9vErFUm9FwCRacf1GiimbxnM19yiff8Y+n06v2bguJ
         jH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TspGg8RA/kX2lN4CLyM+oSg5D5K9Xh9asKYi5WRBw6w=;
        b=LeBZMw3i1P0xOP1plFom+UV8VYh+WIl0QFYCOG973qGPaw4L5Lnnguri0Cn5UG1wWc
         hBFUyWWhaSWaFZUMpOqIaUADqAgcP1X0/t+7kZEC4I8PLyzGUalIbGnQHMsaoHvANfvg
         gEVgdiCnZOiPfttkyHOHeVZumC6S7iyjz/D0DY0LfSekP426YX9qbAWLRUeg5iboPraQ
         J9hnMbQDQeuGLnm54hWAFDd671yG/CB3UO05RJBXh9cgZhwDZls9yYFxv7A3D8kED1Vd
         KQ0roK79sCF7oeh744zl6vvfbeSalcHCIhpFZKBZmPJJaO22O9SolfYzdfMFWBuanXvN
         guFg==
X-Gm-Message-State: ACgBeo28oL6SIW+hcUEtumB0JpEx2R8yd7Z3FstuRtDi5nNrSuj7MrRP
        BkXJbRWpnyNLmt7R86bSprEkUA==
X-Google-Smtp-Source: AA6agR4a5OF37r5jyqc82vTCCrG8wkZAv8zc3qGleDMcdb02QZe6RUYCze4JDt3weaFJwDCGJ9IIvA==
X-Received: by 2002:a63:82c6:0:b0:41c:d253:a446 with SMTP id w189-20020a6382c6000000b0041cd253a446mr7504564pgd.125.1660942588405;
        Fri, 19 Aug 2022 13:56:28 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b0016bffc59718sm3639768plh.58.2022.08.19.13.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:56:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, paolo.valente@linaro.org, yukuai1@huaweicloud.com
Cc:     yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20220816015631.1323948-1-yukuai1@huaweicloud.com>
References: <20220816015631.1323948-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next 0/3] bfq simple cleanups
Message-Id: <166094258743.37480.10341600482798936132.b4-ty@kernel.dk>
Date:   Fri, 19 Aug 2022 20:56:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 09:56:28 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Yu Kuai (3):
>   block: bfq: remove unused functions
>   block, bfq: remove useless checking in bfq_put_queue()
>   block, bfq: remove useless parameter for bfq_add/del_bfqq_busy()
> 
> [...]

Applied, thanks!

[1/3] block, bfq: remove unused functions
      commit: 83501be67dbabc4a19ca7cf0f7406cc200272880
[2/3] block, bfq: remove useless checking in bfq_put_queue()
      commit: bf2c5a1d2aa31faf3cae0158da2a301acfa0c9fd
[3/3] block, bfq: remove useless parameter for bfq_add/del_bfqq_busy()
      commit: f5f9d71bc15eaa72f70cd49aa507b0809a0325ae

Best regards,
-- 
Jens Axboe


