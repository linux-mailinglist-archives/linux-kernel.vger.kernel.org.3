Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1F5AD889
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiIERmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiIERmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:42:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7228704
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:42:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x23so9062331pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=rk1xIdlDNKhP9l6j42SzgPHQVRQjVoccTZ6QkSsI3f8=;
        b=odnhHJ1ZQuTW6h0+C0dSvy2zECycCOilBBRq8hUnljIMntRnokKCTu7VkvS/ywRj+Z
         5ldwqbJYAB5o511wsx18hjb57aY4QQzXcQ9ipeYXx5Xiy43D3yZntDYDeHcSNF9JqmgK
         mSYQfVIeFnqkyngCW9DjnLOqzKmLhK1Wyeh5TvETa95DcvxnEZoBaK6+bUNk+Fc+OPmy
         +PXGIvzmXOj/zCir5skUNnwo0NEu28Io6v4SfMoEBZHQ5yrO3uqetFqUF+hOTov3LO+T
         s1WrW6K0MSTBhCdYRMbRqD3nFIn5SlO7oG3nqY5sC/H/b5+OQJAb4sExkOz2iRvk+ZCg
         2euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rk1xIdlDNKhP9l6j42SzgPHQVRQjVoccTZ6QkSsI3f8=;
        b=qje3mkO/p18PkT0YjWIEb9AORur0nWCATPshDHzFGqlL4q7b9mCqL+k1FCWzNz1pqA
         gl4A64a4iJDZ9ziYuPkGVwmxpvWhP7cdV9oV7fEwoFX7pB9MEeJkISJ4X/J1kWnyMYZT
         E+I2LqXIzJIsBgVxBsVBznJwJlPTI9VFAPsA9tJ9LrwCSt3Z+Dh67tQy/b/ov91FUJ8a
         Vp3cTXWuPGV5CQSG4j+nuMikWdwV2ZbLROAK0xGpNwfYa+f31kWbU7mGnbBPSAohJUmR
         wu9VW8BMLxG1aMFnz2MbvwOiwZt6A8Ue/uJLZlO8nyOhHX77Ml0nb2xGmBwJJT2HSITv
         Mh2g==
X-Gm-Message-State: ACgBeo2V/CBazggY6llq/6+88kT/1uFyHhn/3f9eWDiw2e1bz14KqUQP
        cFg+dy0HSXJXyyDDe4A07fAvgA==
X-Google-Smtp-Source: AA6agR7L6IWNxD3apKBqzeJd2S3iyK3xAjAcxbIE/kBW9r7eNKq8DQgFYFD91z8Hpe7oCNXvKemSAw==
X-Received: by 2002:a17:902:d482:b0:176:ca6b:ea8e with SMTP id c2-20020a170902d48200b00176ca6bea8emr598761plg.26.1662399772119;
        Mon, 05 Sep 2022 10:42:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b0017286f83fadsm7910276plh.135.2022.09.05.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:42:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, asml.silence@gmail.com,
        Abaci Robot <abaci@linux.alibaba.com>, io-uring@vger.kernel.org
In-Reply-To: <20220905020436.51894-1-jiapeng.chong@linux.alibaba.com>
References: <20220905020436.51894-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] io_uring/notif: Remove the unused function io_notif_complete()
Message-Id: <166239977130.373346.18092502016932557951.b4-ty@kernel.dk>
Date:   Mon, 05 Sep 2022 11:42:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 10:04:36 +0800, Jiapeng Chong wrote:
> The function io_notif_complete() is defined in the notif.c file, but not
> called elsewhere, so delete this unused function.
> 
> io_uring/notif.c:24:20: warning: unused function 'io_notif_complete' [-Wunused-function].
> 
> 

Applied, thanks!

[1/1] io_uring/notif: Remove the unused function io_notif_complete()
      commit: 4fa07edbb7eacfb56b3aa64f590e9f38e7f1042c

Best regards,
-- 
Jens Axboe


