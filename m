Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955355047EA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiDQNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbiDQNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 09:30:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F063FD45
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:27:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q3so10506452plg.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2lsv0ntY4n+MI/Hd3e+PEhNvyJ29+Oq+Iyeq2UXcg+Q=;
        b=yELFNctQNh8f9kq818ppMkx1U+LhZFvvzoNJBrgFCYj8wM16rEoGsJERr95ZJLzq67
         1ppvMprwsyYqIMq88GVAAKx+l9cXpeWFkYNrgJACHo738WLr9MvgBrqaMXoAtKaHVAv/
         IIyG/vuxcQOAdSnKZoCqCyU4HC/+W9exGvPxAg4/zv1MuxwWTzbuvFoC27VrsGqbz4io
         LWmnXaHFVLtxgb10txwAhlwxqQ2vbbG62p8UDzHtDUyM2Ib21uY7g/BJaTbY4AC3ilSW
         RoSvsasdkeYR0KwSisIFoIz2a1/yPOF9Vd20W6/9YgWyaABfpGDhr5mCu/lBrZfcPkpv
         gwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2lsv0ntY4n+MI/Hd3e+PEhNvyJ29+Oq+Iyeq2UXcg+Q=;
        b=3gXJDcEOObCnOqpsIUlE9PXdOwmj29C6C/ezYzwrG5VsPM5dBe6QoKOzJurD8JzvBG
         Ufa/LT6cKN/Mj3v4NmzmzHm0ismq1wlFa5nCJZYCs5vmNuy/OMIjCyGsIt4sIkthMPBu
         2ZKAQpf4UOGatBMiIak7RMDqDRe8lDB9vebbOI6DdmFHOLveHtB/5CNPnzQnOtB4hqRq
         MuEJBhvYVU1pklxxfMwPzS4o+gvqDA7L66VGqGr79ps85WaP0ooJIDdJLNWSoBafvobe
         Bacd35yvJAnNx6KGwNxbUF3TR0+7mfGUYn5c/wUaXF5S8O5G3bHRWP5eSRvPxCDlUiQm
         UVXA==
X-Gm-Message-State: AOAM531wRhapLB9bHI7HA8xZktd0YmpDMZh+UgoB8jTXJeYLDLUnJQjT
        6K1tuoOR6TnTFJrMOoPzy68XhagkzhC1ecru
X-Google-Smtp-Source: ABdhPJw1y3DOoUi6NRe3MQxj9rsC0yTa3f5ata6PXmG6W714zzk2jMCcR08ZklwR9kHaadkF/2yXWQ==
X-Received: by 2002:a17:902:8698:b0:158:99d4:6256 with SMTP id g24-20020a170902869800b0015899d46256mr7144705plo.104.1650202044452;
        Sun, 17 Apr 2022 06:27:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s35-20020a17090a2f2600b001cd67e544e4sm10193811pjd.2.2022.04.17.06.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 06:27:23 -0700 (PDT)
Message-ID: <6ab618f8-f88b-0771-a739-04cd9cdc1a3c@kernel.dk>
Date:   Sun, 17 Apr 2022 07:27:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [syzbot] memory leak in iovec_from_user
Content-Language: en-US
To:     syzbot <syzbot+96b43810dfe9c3bb95ed@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000951a1505dccf8b73@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000951a1505dccf8b73@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block io_uring-5.18

-- 
Jens Axboe

