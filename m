Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1445AD890
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiIERqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiIERp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:45:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DEC3F1DE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:45:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so12743468pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=fN2poczNO4P13BKJaZtYSL/rwX/e6BTTCS2EzB4E0v8=;
        b=pHUaXaSQoL8jqLEKD/XWgSZnpuFr8VhQmSopIJV2aaC52GfIUkiLfCHYQqWzMbl4GC
         +HAlFVNSK8pNncKBIi1PWDuC6W2wBLxLXIjGF5JUwSQVQnvCtFT6n+V7Ezi/drU5yzZi
         URrTGL3JNeQbS2nXEvOHeH/EN8SEKoD/ykek0+7tn34LdRJm8A/emGoFpUl5bDA1IBgj
         2k55UVuU1iVfFIiCHdaRTjygJsPFMc1UqMJfUzEDgKB4kmCYCC/lAb+lDKhxIN/SfGKX
         u0OeWJmxEMSMJeMk39ZeMC7RDUKqYcMkJFDi3LAihErbxYzSjkUJ9PMmam2Hn8N4Huhj
         qhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fN2poczNO4P13BKJaZtYSL/rwX/e6BTTCS2EzB4E0v8=;
        b=ysynQgmL1FYolMDDRtlvqatKNnhhsMqReFin7L0X63npJ5v35jcl0B/+znFOO6jHRO
         RNU6CeK28r59W/sP/NeODnrSEpPGHsr6cozU8gs3BJ+PEvUXG5zgM9say+rJe6fUBzTp
         ofQJQbPQhOUBjh2ME+BXX+PgadbYiIvZa1QAQ8N/PL0KTsT00dtC7m4qTqdyTuxwf/Zn
         b2UrZYEocBF9Do++nruG8FMeaSelPoKeknkrdtu1HUCX5oHx83Q/qgeXmxdt6xvkCYRD
         8hBEWUy24ZPzxSDQwAAJqNZTby70oGVlkE1qJaqa//sr5tP4JcA9w+4LldyjcvDdtAyX
         4Q+A==
X-Gm-Message-State: ACgBeo3JdCrjgyYLfYIf3i6tL8bh3xCJ8E8601Ldn/U6Y4HUZK2N4L/o
        Ui6Urz4phLyLZXlpTixlUgB99Q==
X-Google-Smtp-Source: AA6agR6SjOCWjsQrJQXiTpx9Bwg3YbtybxReMeVWCNzMQ2FnK/gnc6ZukdOds0OdLdWCeNBP1oyGbA==
X-Received: by 2002:a17:90a:6305:b0:1fd:bef9:d49 with SMTP id e5-20020a17090a630500b001fdbef90d49mr20200421pjj.221.1662399955645;
        Mon, 05 Sep 2022 10:45:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902710c00b0016ee4b0bd60sm7797272pll.166.2022.09.05.10.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:45:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220905101950.4606-1-linmiaohe@huawei.com>
References: <20220905101950.4606-1-linmiaohe@huawei.com>
Subject: Re: [PATCH] blk-mq: remove unneeded needs_restart check
Message-Id: <166239995485.374909.15044704517203408.b4-ty@kernel.dk>
Date:   Mon, 05 Sep 2022 11:45:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 18:19:50 +0800, Miaohe Lin wrote:
> If code reaches here, needs_restart must be true. Remove this unneeded
> needs_restart check. No functional change intended.
> 
> 

Applied, thanks!

[1/1] blk-mq: remove unneeded needs_restart check
      commit: 6d5e8d21e8997b0efa409e46db22a27b5cbba6aa

Best regards,
-- 
Jens Axboe


