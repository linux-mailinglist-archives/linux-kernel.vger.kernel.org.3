Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183715910E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiHLMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiHLMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:42:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C5ABF21
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:42:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 17so695723pli.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=gREmAxN8l8RxNVEKTsm8QkZuwPXI/lgjrFZm1KwVciI=;
        b=bjpA1ThKzQJ4OcV1ZdfRYLTWMBxY63BD6LTsegwran4BATMStJ9qkdhLiwfXeTVLv7
         lvJbD80YD1xrpeMeyhsEXMA9Wk95PWMyq/lPaHobw2gO8m4SRtZ0UEzzSz0IjQ+IQpRd
         3+m3uwHNpzuIDTJaPTWnbkYFmCMtinOXZbkeWbykaF067OeAUg+giocGTTQhVD2Y5JzQ
         7KaysSI+i8zQwtzOw9JzHeiZYEn1lFouhsyEztAbFG68zg0uhylP3xgEZM1qHYDtR72n
         0rX39lkRQ9ANuL8hO1ol8fXQGKbrMISMzhjUlrCJ//yciPHDh6oyiPFhmmzgEwyTYDn4
         Ufmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gREmAxN8l8RxNVEKTsm8QkZuwPXI/lgjrFZm1KwVciI=;
        b=tI8GFHwMLtCywhPzPwmTZk4Sa42QElbVQni2GLta8j6BvsGlktxW7IFwXjZuE5l8sk
         GfrzElnsEv5Em5c1vjvCQ1vcAYrB9Y2tYx02MVtlAXyVwtL+ptB3R8ALuNMASGb+jcDQ
         AJ1UlxjSSBJbv6NTHWbIAigkqVnmcen0rhfmoozucfKvy3tSTG3+pjCC8cAjiV0YqyTg
         Nl7Flbzg633P9e7nRaVFKdWYdhUnIO9exdzcdFtLTwA1HVL6tolPkVubbPUzYhGeBami
         Ajn56i4pPHKbcDA6/kl7tCgS7K0T3a1dPouzdS0V5byoJcq6BlXqLyrowK+eCZ76hGok
         vCHQ==
X-Gm-Message-State: ACgBeo369Eb8krVurv8G4uDVTMu7w7mLaS5jj9SHaE/qXuhgYDeu1H1b
        MNUTryoG+TW1q1bopeEBlySZkA==
X-Google-Smtp-Source: AA6agR6DorRRxtWFW9ndhm9eJlKetkO2UVcyM8ashb/2RipaEBOE4pKOtR24EoyB/rA2kGchKIfjJg==
X-Received: by 2002:a17:902:9005:b0:16d:1ffd:cf56 with SMTP id a5-20020a170902900500b0016d1ffdcf56mr3737918plp.119.1660308132956;
        Fri, 12 Aug 2022 05:42:12 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001708b189c4asm1623980plg.137.2022.08.12.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 05:42:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     rafaelmendsr@gmail.com, hare@suse.de
Cc:     linux-block@vger.kernel.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org,
        syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com
In-Reply-To: <20220811232338.254673-1-rafaelmendsr@gmail.com>
References: <20220811232338.254673-1-rafaelmendsr@gmail.com>
Subject: Re: [PATCH] block: Do not call blk_put_queue() if gendisk allocation fails
Message-Id: <166030813180.891934.12259200339444300073.b4-ty@kernel.dk>
Date:   Fri, 12 Aug 2022 06:42:11 -0600
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

On Thu, 11 Aug 2022 20:23:37 -0300, Rafael Mendonca wrote:
> Commit 6f8191fdf41d ("block: simplify disk shutdown") removed the call
> to blk_get_queue() during gendisk allocation but missed to remove the
> corresponding cleanup code blk_put_queue() for it. Thus, if the gendisk
> allocation fails, the request_queue refcount gets decremented and
> reaches 0, causing blk_mq_release() to be called with a hctx still
> alive. That triggers a WARNING report, as found by syzkaller:
> 
> [...]

Applied, thanks!

[1/1] block: Do not call blk_put_queue() if gendisk allocation fails
      commit: aa0c680c3aa96a5f9f160d90dd95402ad578e2b0

Best regards,
-- 
Jens Axboe


