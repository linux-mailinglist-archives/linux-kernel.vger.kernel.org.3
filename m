Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1B52E0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiESXwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiESXw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:52:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A3C122B7E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:52:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h186so6356297pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=cGpb7ZGnZmolqlcodDS+4Xrnr2MP+JxaiTVWAeuRPq8=;
        b=7K50c7Qr3zfvvux1YsgYi0IeVwVi0vsOPEwdjD4VmEygxA0cAY9Qu+k/FAZg9egbRR
         cF3+ncwvI7jUd9+PYB1FhWc9MyS2bFcDJ6PTpTO6pyI2DDcOvsb7EJpjPhSEOJ57FM84
         earrT+0CjWsmMSVWHxuuIWTpvNYkkkf7p+wKCF2PT0dHiArhfB6DbPHGUuoa4Otq1Yur
         OgxboR1ThofnFMtAy4weNpGwJ0aoSoMADy1a+ZGJJlYER7mp8rSZdsDXTJ30uGnHPMeg
         QYs4Cc6gS6qbnp7ni3dmyNsrTwyfMQsqcMX+FbuNnMLQBXePuHFNuJPpnNQLKi2FaraC
         0xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=cGpb7ZGnZmolqlcodDS+4Xrnr2MP+JxaiTVWAeuRPq8=;
        b=dO54Pm7aBTv4N7/Fw/9U4eOv+bn16h0qedYhTnZRNt1NEKwlJvYin3EFJiXJEgt5zc
         r8HfFjyraBuyIMb87LqdriRqdb3gZxhUrqZYTnPkr2lapYkidkUu7KuvCfAp2h/t241H
         Qlt9MPY05FFuN7TPyjM7X4Z+AO+9rmgIsZIIxG+jJ2OQAS+0RSPILoaZ6fNsYj/GG2Rc
         kypNyUaQ0Lt1XHfhy9FCyMKDG+b118VhrDeKWYHyNbOLq/ijFW3rljwzi/9l/8qILTKq
         i5RMpf5EAhRXMnupRcZ+zhY6NzmJNt8HiLo/HLyjiVEH74HYsFqgJDBNTfg19/WU8mZw
         kDiw==
X-Gm-Message-State: AOAM5317ddmM5sbc/9/etwGlyhyUdDGTMh3kNVdd+y//tg5qsXHWzAr8
        bXs+7XpXiSHrjUIAaEqQdhirulL2+/nmOw==
X-Google-Smtp-Source: ABdhPJwrFUKQH6K/e/+BKe3g7XJw/azNCdfccjM3ECAUEP78BGgrOnFO9s7S1AJ229C2kfRGt1F/2A==
X-Received: by 2002:a63:4d02:0:b0:3f5:db92:60b7 with SMTP id a2-20020a634d02000000b003f5db9260b7mr6125338pgb.580.1653004328778;
        Thu, 19 May 2022 16:52:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i3-20020aa796e3000000b0050dc76281c8sm231664pfq.162.2022.05.19.16.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:52:08 -0700 (PDT)
Message-ID: <8492c79f-3ddf-3b26-db9a-ff0f42bab7d9@kernel.dk>
Date:   Thu, 19 May 2022 17:52:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] random: convert to using fops->write_iter()
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
In-Reply-To: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
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

On 5/19/22 5:43 PM, Jens Axboe wrote:
> Now that the read side has been converted to fix a regression with
> splice, convert the write side as well to have some symmetry in the
> interface used (and help deprecate ->write()).

Oh, and similarly to the other one, you can then add ->splice_write
as well with using iter_file_splice_write for that. If you want to add
that, please do.

-- 
Jens Axboe

