Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6D52E1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiETBLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbiETBLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:11:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664C41326
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:11:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i8so6147218plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=v1ZU4hxyuFEYotNFKxZoP0vu2J2n03rvGM7u4USTEoI=;
        b=L7lNJcWLiOkHHWDNrBLs9xbYtNU8N5udv+G1UDLTJOr0JDi6dWOi8yvAeW9ZYB5NM8
         NtoEfH6tXzlz6zKcZpIjA9KLaF237Ncj8tWvIIEZBnqc6mWCY6SGY35iObToB28hrTdN
         Rm0tAk57jNoIz/u4V8x78O6xHT5hQzeKj+T5tWPhJebnEcuHRvJ45AQA3EA292U/ipot
         wVLO+Ld5rqOQ6fXQjXgkP5JyG9LuYguur7qTuKTpWGwXjFp3YtJIHKAkWOaIDKDBpzIf
         YtG1Sk+MgzNQbRpb5rEDc5vjWs6pwqiYZ/+/b079qF93hb/QR8Yoo7trOHOsEeP4Rgbh
         ybTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v1ZU4hxyuFEYotNFKxZoP0vu2J2n03rvGM7u4USTEoI=;
        b=FcFo6mv3uIzfh9icvzNEdoaS8ZHSXgbsN9BUKahq7GqQZ2SsEDJYFtJCgtFouq1Xtt
         wIYEcTyBSVe2lheJ5LGKVYHMJTuHpGziFN3RFpadYfdOPh9FWHK1+dykhi4QQocJBHX3
         omDrhkFfTQAsONlhS1FykwkV4H8DwPIxMO7CfzivRVY6+/RMhK4F463oZ9dGA0uNNO91
         vugnLFgSYG552uFCb/Gh505KaZojb/u3OfoU643pe77eERYW/YqJWWC/gt7/qZirtHoO
         2JCg+26wnt4syN40TJwvC1s5G+IvdWVLzQU6jsF63MPung59S6TSx6kafE5bYxgv6+wm
         tMeg==
X-Gm-Message-State: AOAM532ZF8m++dh2QOpB9hFr4B27BUOqKkIuU2UJqboMaGQtWevGAbvy
        DTWiX1vVoEGzr26NmQEQ/dbMxoGq5uaH3w==
X-Google-Smtp-Source: ABdhPJwI8mLOtxQKsQA90/8+soj2RW/5G3aQFEHYqTxKAJ0ncuco7bcMu0hUKSTWdf0x+Qfz8drY9g==
X-Received: by 2002:a17:90b:4a08:b0:1dc:6cc1:3d24 with SMTP id kk8-20020a17090b4a0800b001dc6cc13d24mr8095748pjb.131.1653009099428;
        Thu, 19 May 2022 18:11:39 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p1-20020a056a0026c100b0051810d460adsm314966pfw.114.2022.05.19.18.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 18:11:38 -0700 (PDT)
Message-ID: <656e0873-8f8c-341e-b0ad-b793610eea3c@kernel.dk>
Date:   Thu, 19 May 2022 19:11:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] random: convert to using fops->read_iter()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220520004058.96691-1-Jason@zx2c4.com>
 <20220520004058.96691-2-Jason@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220520004058.96691-2-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 6:40 PM, Jason A. Donenfeld wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> This is a pre-requisite to writing up splice() again for the random
> and urandom drivers.

s/writing/wiring

Looks like I typo'ed that one.

-- 
Jens Axboe

