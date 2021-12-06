Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B546A55B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348253AbhLFTKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348248AbhLFTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:10:30 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE871C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:07:01 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z18so14171561iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PgabJr+9sQV3frT98YiWueANGFug5mWF8hI/4tdX/WU=;
        b=fgZTcqiYTmB4gaLnuBVCnHo3L+VXWP9HTGhaU4u/h6rvZ6iRHC/8CGQSXrVhFQbLSD
         DEu9fGCRts9tFoVknIvvnfYAPgF3mF0L9mufeRlnMiwMcuyydsb2zUvmmvKn2Be5tUCA
         4tWtAXd15Hv/72rOb5L/xSTCtVo8++aPVCYOzjY7OG5T25OJpsd19b88fMYnFogvoDBB
         GgpJATPGOjKchXyvpGkZdq3T1FlTv+k+jU2aoPwHaYUT3egFrsUS07Tuo67oU2oFRnv0
         SFvwYL/a5aByVlkHihnMPbq7Z831x+tevE5+zi9xHRQPkHK3m/BLhAzbNOYfoVa4zKis
         lENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PgabJr+9sQV3frT98YiWueANGFug5mWF8hI/4tdX/WU=;
        b=fp3J4DMMk3Is2fRaoaCspMxJteeidfQORoFVAzTkP/sB/skiwR8N7rWWLrLEiupmSD
         CJPFUtBk888TrWobfuY7z1yuaCYrAqWHuUDDMUMmJYARzbZG+mk2J+sLyw7MLJ7j45X+
         e+qYgwNiNUB14oD4MKk6hF5GLyRszmoQIwESwP6KL9/GzEaaulUVCUX/VllLZ3+P5EYA
         Ptwc4TnOwq7MrSW+VHTT8LmrsVv7H3XO6xxk1en1gf4NeQeDaCRe9YUFBwRisaSmSbRY
         PE680fJ6GFgLIISfzA/tJxhWPTNfkivuMeKKJNyewsQTfw66pYx5VywFqHUydwIWtmhU
         QoNw==
X-Gm-Message-State: AOAM530L1xqLos8WMMM0esneEsUEQ1U+F91gImy4JL6Rr9kuAxaRF/zw
        SEvOKDPkrueTbKTD3+EWaKzioQ==
X-Google-Smtp-Source: ABdhPJxaW1h9zQyIDIf0F1W8mfLJ3gtZw+ioJ5q7+4tZJGbuRXBMaRAHT1JC1hD3s1ZK2iylr5tgPQ==
X-Received: by 2002:a6b:7a0c:: with SMTP id h12mr1716474iom.176.1638817621226;
        Mon, 06 Dec 2021 11:07:01 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j6sm4875132ilc.8.2021.12.06.11.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:07:00 -0800 (PST)
Subject: Re: [PATCH v2 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, kashyap.desai@broadcom.com, hare@suse.de
References: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <67feacc8-3da7-90de-cc0c-f8b529f84297@kernel.dk>
Date:   Mon, 6 Dec 2021 12:07:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 5:49 AM, John Garry wrote:
> In [0] Kashyap reports high CPU usage for blk_mq_queue_tag_busy_iter()
> and callees for shared tags.
> 
> Indeed blk_mq_queue_tag_busy_iter() would be less optimum for moving to
> shared tags, but it was not optimum previously.
> 
> This series optimises by having only a single iter (per regular and resv
> tags) for the shared tags, instead of an iter per HW queue.
> 
> [0] https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/

The patch(es) are missing Fixes tags.

-- 
Jens Axboe

