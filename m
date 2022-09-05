Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA94D5AD892
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbiIERqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiIERp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:45:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB732EE5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:45:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so3522132pjm.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=58KaHAIQ7GfBOiArHKs+0ShzEtYLXcS4y6pqYYkkBMQ=;
        b=a9urQmLZ+862YBlddc6AZfvIeyDw+1sHyHJo9Jj9bmO2JC23wJF/R87N6Dl/PPUo9j
         PbGZC39VnmF2hCQHg3t74WV2d4z8eYPNcbKqks3d//WjepcNJ3YhRi94gagbpz9UyHMG
         Ho9WqOvrmVacTRAEVdeJfkA5mHCRkQKCQkIb8fZVH0HZYLUXEzXlEiW8IyPalrurCbKS
         dL8304Ylim5lXNB9DzjQm1GdNHDm6P67OxVoQLX4bHC5FJDVdbBg2/AJ5Zlfq+AXbfir
         57cUHC0Jy+aKxFHTAR1u4CI2W3aMePYT40SdKHrTBWY5mkefkz0HEIapbPTS4je4ldRc
         58Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=58KaHAIQ7GfBOiArHKs+0ShzEtYLXcS4y6pqYYkkBMQ=;
        b=SylW6Ar4oFDDnYDoB+YHLuvvcaVF4Shyl10V3lRR14PqNiTFMQn4PsH9zVR7duAFh3
         DcST+r4qxG6LKrWCqde3XGFrXqjIImadfb2GIT2AWDtFL4k68d2aib+kORqR8p+6azAM
         8Nnhxgb3pSSvS+IU3kSZuthA5lfNbquGbOlYYssHeYfl2u/Yo1UDClTlFjQV2ikoQLcj
         55wyhfemx2hbRJ69EaJXbrT+7Pb5Mu+r5ducJ5Y77vP1ME6O0CW/vjFmCnR3ndz5XPzk
         bnuPv0C8iPVG//aZBiZoKxU1AUdsjvzgsPLq8xNOGLnKYTslydOMY/56oR6ALADYZpEN
         ap1g==
X-Gm-Message-State: ACgBeo2Gq7BSMkXWyGa/+sJOrCf8U/AJC9FTIX9LbFx8Z3LKM+x+NHaH
        LhK0q8QUWcYBdXqcRYA++OsWQOTgdvxiFQ==
X-Google-Smtp-Source: AA6agR6Od9xmHI4utAHVcJa+b3OCpawVPNFOS0w/d8sbYbzaP7A0FxhdQHzWiiU/5kxI008Y37UL1A==
X-Received: by 2002:a17:903:2696:b0:175:42e9:aef with SMTP id jf22-20020a170903269600b0017542e90aefmr27890140plb.109.1662399958318;
        Mon, 05 Sep 2022 10:45:58 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r22-20020a63ce56000000b0041d95d805d6sm6797619pgi.57.2022.09.05.10.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:45:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220905102754.1942-1-linmiaohe@huawei.com>
References: <20220905102754.1942-1-linmiaohe@huawei.com>
Subject: Re: [PATCH] block: remove unneeded return value of bio_check_ro()
Message-Id: <166239995757.375005.16927061177164167140.b4-ty@kernel.dk>
Date:   Mon, 05 Sep 2022 11:45:57 -0600
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

On Mon, 5 Sep 2022 18:27:54 +0800, Miaohe Lin wrote:
> bio_check_ro() always return false now. Remove this unneeded return value
> and cleanup the sole caller. No functional change intended.
> 
> 

Applied, thanks!

[1/1] block: remove unneeded return value of bio_check_ro()
      commit: bdb7d420c6f6d2618d4c907cd7742c3195c425e2

Best regards,
-- 
Jens Axboe


