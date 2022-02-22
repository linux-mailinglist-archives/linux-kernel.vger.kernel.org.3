Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E964BFA11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiBVOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiBVOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:00:33 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AC4127D5F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:00:08 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z4so17069331pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OYGvkou6t6u8e1bfgXALw0P6fudskRCL4vAoBoZnxTs=;
        b=lZAXckA4EooRL6Vftdr9Vv5S6wLf249lTZyVXKcW/hSqGnwtbrQFqEtI9tZhqd67Eh
         uq2c7k1+c81sj40hO2f2TUz/AjSaLESe84gHk8HNJ5+AW/He/KS6Z8nwiFXS32Uwu6As
         CUwYUa+G6ySDZRHf0HJ8eHIp2F6J3BqWhSGkNVB3U0fG+mOa08aFFNrYM9+kOdEvIhRq
         Db73IA4CBk9ObWq10BHB+lEh/jQZJnkxzd5NxTVpN4E4/VQ1NzM8AcqeH265NEibjyZN
         UdwWQHUXMKoXgUoSZLGLDnQV22J5KYUraCkp8IvEO1Pb+lY+sJGkoiTdCtfuWfAVs/MS
         SQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OYGvkou6t6u8e1bfgXALw0P6fudskRCL4vAoBoZnxTs=;
        b=sbWLrRLkVIHjjz27J6OD2EBwsXV17oGIQwVCGo0AzbFoobwThtoZRkq2ddMmw1csJE
         gSSD8PT9Zd59Mmv/jwFCA8xF77yddsEvePezp/9wBexuY5FiRgG1f8I8v9WxJbX96XfH
         E20zecVjTxICG8ZLb/t9EFkvuRTRzZgGPY+VCo1ct7DjrRkHZHEAHL5HL8rPotjA2duO
         COV+nwrAkW/vLRNUHtTZgZrVXqj6VaGymJ3/rf8vIlOvTyDsxgOujvtEweo8F41nriDq
         JlCItsIed7zw2xX7JS17UbHyxORCuc2s3mGIPVCb7ZfW8aW7RpvfqlmgDhpjyyQgZVzM
         B1SQ==
X-Gm-Message-State: AOAM532IHfPV9LON2+0RmSTfFyPD19JRo6S5y/B9CGAOZFzKwjKeQCKi
        mSQr6y+xZGHUEysQbMg9HSPW+//aTMtUsg==
X-Google-Smtp-Source: ABdhPJwxUq4rYahW3uu0UEQDGfs1WW+/+oCdiiFWL56ktdrW6ecztEhsIAFjWsT40OJfk5UK7xhMkg==
X-Received: by 2002:a63:2f87:0:b0:374:4ebe:2048 with SMTP id v129-20020a632f87000000b003744ebe2048mr7265092pgv.157.1645538406837;
        Tue, 22 Feb 2022 06:00:06 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d18sm17641501pfv.204.2022.02.22.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:00:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220211090136.44471-1-sgarzare@redhat.com>
References: <20220211090136.44471-1-sgarzare@redhat.com>
Subject: Re: [PATCH] block: clear iocb->private in blkdev_bio_end_io_async()
Message-Id: <164553840592.21302.5942854488206786597.b4-ty@kernel.dk>
Date:   Tue, 22 Feb 2022 07:00:05 -0700
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

On Fri, 11 Feb 2022 10:01:36 +0100, Stefano Garzarella wrote:
> iocb_bio_iopoll() expects iocb->private to be cleared before
> releasing the bio.
> 
> We already do this in blkdev_bio_end_io(), but we forgot in the
> recently added blkdev_bio_end_io_async().
> 
> 
> [...]

Applied, thanks!

[1/1] block: clear iocb->private in blkdev_bio_end_io_async()
      commit: bb49c6fa8b845591b317b0d7afea4ae60ec7f3aa

Best regards,
-- 
Jens Axboe


