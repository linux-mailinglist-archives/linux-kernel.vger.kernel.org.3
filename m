Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6474C6EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiB1N7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiB1N7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:59:41 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220C52E7F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:59:02 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 27so11411095pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FzjJyXn/bqOXd4ZYAkke0bU4g6qSzR3Mr9gnRy2DvTg=;
        b=emMjftZwGqnvQ1Csf6dPnjraA5SYoxWJ4upPlVDyELTS1MxrD52sQOVyQQfZHHud9E
         n4PiZrOVHuD1p30t04u/zokGLZu2h9LHxx06ku9OYQHMky9qrusGrUMoG+0r7qF7dDxQ
         xvjzoabzSEE01OIot3iNZ2TId9Tc7TmAMm8j4Dnu+EAIg9EnGg1mgrv+ZiCA5xHXoS8l
         yBkiyjAG9xlxqSDQ/g/I1eEGDJ3N8fQ0fS2Ism64Kf1sIv0Duiwy2zAHnzBr3TU7gei8
         O9bA0FehEHNomNs22oJW4kYYQ6Wu7+tQSBrBRU/s55JtsxcErBW2udeVpERkYth/+Gdu
         HmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FzjJyXn/bqOXd4ZYAkke0bU4g6qSzR3Mr9gnRy2DvTg=;
        b=mI8VD50tMsujAy6OsCZ9Vvv5zCKT087NU7WNGYe2JddFDwsvWZX4swvUtD9J53UGIw
         /Ux5G8iD5ncajJx9nBbA7nrGrbL2lYyISomY/BtiSPG3g+3HdusNFwbzfzhF7mTXIpp5
         qMQW4OH51ennLNKB32rhx0KCviBIzXaCFt+0dFILooUGXfslt5+z6d8q/tz65rKSR7DP
         MItP4hUoSv1A/8vpz8VTjVBmAH7HauoZO1MrbMR5GcuVserEm9Xy3HMEF0OAbbf1wFc6
         DvXMaXZ8t3JeGn7FMIIOseFKg1hDza0LImRIsvb3NjuXEHZSBtihDJB6JPkCVMjAPNSq
         jPSA==
X-Gm-Message-State: AOAM532tcZEKTTzr0Vqc998vlk9awAvnRlyvdoKKYQHq4BtgLVag6uyG
        bgqMLEVFf8p95JSi9NdlpdqvVA==
X-Google-Smtp-Source: ABdhPJzClDcESKk8VbFJpCZhSD/v69impDvOr5RcvpSjNZ/GD5HaNMYGmPul8QPhtciskytT/yiiXw==
X-Received: by 2002:a05:6a00:1692:b0:4df:c6b0:2f02 with SMTP id k18-20020a056a00169200b004dfc6b02f02mr21648679pfc.50.1646056741739;
        Mon, 28 Feb 2022 05:59:01 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j8-20020a056a00174800b004f26d3f5b03sm14287785pfc.39.2022.02.28.05.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 05:59:01 -0800 (PST)
Message-ID: <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
Date:   Mon, 28 Feb 2022 06:58:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org
References: <20220227234258.24619-1-ematsumiya@suse.de>
 <20220228092215.GA8549@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220228092215.GA8549@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 2:22 AM, Christoph Hellwig wrote:
> I don't think we should add code to the absolutel fast path for
> blinkenlights.

Agree. It'd be a lot better to put the cost on the led trigger
side, and not need anything in the fast path for block devices.
Monitor disk stats, or something like that.

-- 
Jens Axboe

