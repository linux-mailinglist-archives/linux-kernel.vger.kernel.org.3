Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C514B95FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiBQClJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:41:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiBQClI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:41:08 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEBB29E97C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:40:55 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f8so3755783pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=uEu84vd8TmkAxZao4BNYy6EI6z+jXGSiGQhrfQti2o4=;
        b=F4DMHsoAXJL2NeHlRqTVFTSguPw7L+m7DkfJjpB6/uCTHsl0IlpibgAJIqPKdn8AYB
         khM08WBjWYcusmcv4LbgB/QnQb9amsno604PWN2pa9QJRBJv0BXTQrXniZUDDqMr4p8u
         crPkrbOv3RPiTv0VJGu6kjesBzd0hYCK0P2UTZoP2j+D4r+A9hpNCZ6IyvT9b7u6Jp5z
         MzKRuja8Z43glBvqLqiFbFckn+hWwQQnKmkYcuRykPThnSfLmzS2usyGZZyU9DbkKGfb
         bOXYA/fmy6bqJihTsjHYamOLyvhHUeMa/2wsrrTZD4oPrhEaKBOWVVsAeIgxXepRo865
         IkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=uEu84vd8TmkAxZao4BNYy6EI6z+jXGSiGQhrfQti2o4=;
        b=PwX/TphunIWl7U7cSFrxCXDTpxCph0qCUmphzxNf5MUF7dteEbseDbzeICNuo7nZFe
         F5T4JmHvAYh7ifndPxZTxblxUbWTGQk5uew+BUVrJD+3pHWTT8cZPJyy8s1BWdNz4Np1
         c5oWFttA+VKGaDwMb/EFe8/rOg0zwq2xjukxKXKAdceJF58kYPAdFpKS32jjwJrYFmMV
         kSAvt3YGAldMC3XBsRsc/qxaws6cdTyJQKy+FrB0A/OMkvQ9mNAI9cpffteIqa8KP/3k
         QgtZO6hP47vWiu/QlQIXcYW1hU1QVlvs5BziTI5M/+aAai2p3xDhEQ8PoBgW5mroYmQY
         3Y3w==
X-Gm-Message-State: AOAM531Hlj+wYLyLoStaxgQA+jG5CJlQ7/9Edb5QOETYSR1wIKGVvpQO
        BI/aRFQA8dZBYlpT/d8bLRkLJPz6qeUD7A==
X-Google-Smtp-Source: ABdhPJw0eqoPfnZL+fw7o6TyFi/ZvF+zMH9ypGaO75c05vUwYa0ZsMLnIjEXYollLMkWau0aXSuvVQ==
X-Received: by 2002:a62:e917:0:b0:4e0:1646:3b82 with SMTP id j23-20020a62e917000000b004e016463b82mr1028645pfh.57.1645065654788;
        Wed, 16 Feb 2022 18:40:54 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id pc18sm377882pjb.9.2022.02.16.18.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:40:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220216113212.83000-1-jianchao.wan9@gmail.com>
References: <20220216113212.83000-1-jianchao.wan9@gmail.com>
Subject: Re: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Message-Id: <164506565364.46958.8617668035793567580.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:40:53 -0700
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

On Wed, 16 Feb 2022 19:32:12 +0800, Wang Jianchao (Kuaishou) wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> When __alloc_disk_node() failed, there will not not del_gendisk()
> any more, then resource in rqos policies is leaked. Add rq_qos_exit()
> into blk_cleanup_queue(). rqos is removed from the list, so needn't
> to worry .exit is called twice.
> 
> [...]

Applied, thanks!

[1/1] blk: do rq_qos_exit in blk_cleanup_queue
      commit: 20d41d9e993735b996175d087148d9de1fc94ac0

Best regards,
-- 
Jens Axboe


