Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D937574197
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiGNCya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNCy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:54:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D722BC2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:54:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso5289869pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OlqAKJ2OOvEdEHn6Z9YZOvfjiijpNyf4M3TtfyEfPX8=;
        b=BTfUUfzEQLPWuMrNiXQCTKZI1uPD/SlU0g5/+PHUve9TLtrNjbLyBl9AcCM4T3y7cj
         wAyX/UAjYxCF8ucD2wRn2Y+hGmrFRQJfZfI7JynanW6fEgoU6EVmZDQccj1wyn4jH/TK
         I36hqOgO2oPNXAfbnnJS8xt9vqFinzA2lX1Xl8Ce55NA06DOt/1lelBl2TB1ivqkzQpO
         Y8QhPwkSWf5ItMh3dcioxl7tHczGj2qS8b153yXekA02M9NVED3nio+YXeY8wq19jzfn
         uxpSPTsDuXgAuZjlzua8quxhLoYLpaumvh/VM7/wDPHBrzyj+1idTRBdKMmodmodxHUR
         JpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OlqAKJ2OOvEdEHn6Z9YZOvfjiijpNyf4M3TtfyEfPX8=;
        b=iAUnK+PtnIO+HP7eXRjayqWAFk+GjjmkFg9aej+rCy/AwffR1ZPsQgF3q3BJpLu579
         v8asabCM4MmJtfo0gg7MEb4yvq0ji94xijxUE4UjSU8GrELLS6kilKwfTOCLEvpCL03i
         3IPWGlAmEmP37OiQz8rP5zxMNC+Nu7q76hU2TO3pksdfiSfU72kCIqRtGwBS+K7dKK7Z
         R2B3HJuPXxT6NMUCcWyEpTAPPksscPEjliLVIdVdL3GbaWAPDaoapunmQ+kpV2WoJ+hZ
         uOZo3g8gTnyLyxdj7OR3HChniEss9HYe0QkrzhxpqUn6iOGWi4h6qPf+se6JnA9Gjc3r
         sePQ==
X-Gm-Message-State: AJIora9A3gqf7zSzz/QkRY5bTN4gnAQ8naB2cJATOuM9A1VpXPmtr2wa
        fo4Ud1zPtaXN787OfiRGH6rbfA==
X-Google-Smtp-Source: AGRyM1vmFdFTlbK79UwrQC3H5ZQyg40BxmKYVkhWVhz45Cz235tde/woxi1OZqmzXH7sIDtA6gaxFA==
X-Received: by 2002:a17:90b:3890:b0:1f0:2abb:e7d1 with SMTP id mu16-20020a17090b389000b001f02abbe7d1mr13802714pjb.158.1657767266525;
        Wed, 13 Jul 2022 19:54:26 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902d65500b0016c19417495sm142813plh.239.2022.07.13.19.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 19:54:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     xiaoguang.wang@linux.alibaba.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, ZiyangZhang@linux.alibaba.com,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org
In-Reply-To: <20220713140711.97356-1-ming.lei@redhat.com>
References: <20220713140711.97356-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5 0/2] ublk: add io_uring based userspace block driver
Message-Id: <165776726553.191960.9080753662485430796.b4-ty@kernel.dk>
Date:   Wed, 13 Jul 2022 20:54:25 -0600
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

On Wed, 13 Jul 2022 22:07:09 +0800, Ming Lei wrote:
> ublk driver is one kernel driver for implementing generic userspace block
> device/driver, which delivers io request from ublk block device(/dev/ublkbN) into
> ublk server[1] which is the userspace part of ublk for communicating
> with ublk driver and handling specific io logic by its target module.
> 
> Another thing ublk driver handles is to copy data between user space buffer
> and request/bio's pages, or take zero copy if mm is ready for support it in
> future. ublk driver doesn't handle any IO logic of the specific driver, so
> it is small/simple, and all io logics are done by the target code in ublkserver.
> 
> [...]

Applied, thanks!

[1/2] ublk_drv: add io_uring based userspace block driver
      commit: 3fee8d7599e17fe17ef6c1b96e2237babe8b68ea
[2/2] ublk_drv: support to complete io command via task_work_add
      commit: 664ff52d6f338a9afcabee535e8dedf04659f0d6

Best regards,
-- 
Jens Axboe


