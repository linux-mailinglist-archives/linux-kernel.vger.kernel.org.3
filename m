Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902865807E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiGYXB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiGYXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:01:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909DB248EA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 16:01:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso11579160pjk.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=46K29R/jzyxgb2qSaTV9iMS7TQPCalfZVfhX2Tr92gY=;
        b=CIaHQMCs5XgyB1WYNkmfhOi7jd/IYdCWke0DlBatUWbzMxBkNArtPdRWi90eBcE7ZU
         0A3WCdfrALjJymKpX2+4qoQPsEBAFPScYl1wc3JX/2inncWIeim2M9vQfGq/mSMmsR4s
         4VBdu25E76ZR5QBIY56alMfW32wkuhV7upB2bR8mxKHr6Om2UIS3PXjlqPW63w/rVrgj
         ECwWTQwLuY0vRiUOYwiL5eMXB7GocuUkYUrhIVS2s6x+jKgqV5Spct4v/TMT7T11BLHs
         G2zR8WjA5GdOWE1f6z3j6uX+rfC8aILXhoEf+C5M1y48Tk/Gsod7vXBNUuaq3MNF/8aT
         Nlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=46K29R/jzyxgb2qSaTV9iMS7TQPCalfZVfhX2Tr92gY=;
        b=tQ5Hcrg5JJqiWsb+9+Fuogu1KFbbQzmKNDummcQmX+yVwYb8YJPaQFNcabKvneXnbR
         UCKKxhXIdOQToT7ljyVOIRAfP5mDCDPXE/WHYBygjc+XbRwZ8iP7uX/+sx9x91rslu7+
         bAtjjP9+M1k00s1xuFgIxjnzIB8+/GfR40RSQEXd0EAYKOrfpACu/wwekfFC32BxA1v1
         D+lT1/qt6C0oGCCo/O5R0FWtCznPRxiJzsxJwSxnVSvstNGQOqiDb7Yadq/MMzJkcnCC
         QgreXyMTwroJLk7YbG8aiFOqJnb1lNfFCfFTseKS7wPcGW1cCautbg/ky0k6IijIgEYY
         BDmQ==
X-Gm-Message-State: AJIora87Ba2eeLeUgrZJnmSAVkNh5AmD0WZH6dEBvqNbpFgPfmAXtWKB
        Ki3oIKNqG2YSsDByLu/dwK5djw==
X-Google-Smtp-Source: AGRyM1sBYRQJfc/HWpmo8/5mg+wOFnvP9N5PLTvA5O8z4Xakspc4+PQVo+SumV5LXkcdWrBeMwfdQQ==
X-Received: by 2002:a17:902:778c:b0:16d:9d4d:51f9 with SMTP id o12-20020a170902778c00b0016d9d4d51f9mr498919pll.19.1658790113013;
        Mon, 25 Jul 2022 16:01:53 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b0016d2f0b67e0sm9648333plg.309.2022.07.25.16.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:01:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     houtao1@huawei.com, yukuai1@huaweicloud.com, josef@toxicpanda.com,
        yukuai3@huawei.com, joe@perches.com
Cc:     nbd@other.debian.org, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
References: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] nbd: add missing definition of pr_fmt
Message-Id: <165879011117.1265523.8426782568331317022.b4-ty@kernel.dk>
Date:   Mon, 25 Jul 2022 17:01:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 16:24:27 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
> to define pr_fmt and use short pr_err() to output error message,
> however, the definition is missed.
> 
> This patch also remove existing "nbd:" inside pr_err().
> 
> [...]

Applied, thanks!

[1/1] nbd: add missing definition of pr_fmt
      commit: b182198426ac3130f3543b1ad67855a84c4c5af2

Best regards,
-- 
Jens Axboe


