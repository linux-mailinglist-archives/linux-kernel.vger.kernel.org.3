Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0283447C2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbhLUP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbhLUP02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:26:28 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:26:28 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c3so18175180iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nZILDGyMZn168Emcyzk++2f/Rxpp3GQ0Ij4K620L9B4=;
        b=MKBZNm0hWnEn7qYZ4x7FWmHRYwk9fslrDCmJBv0r9OtKsFVqhoOtZZcsm9n8O7MUQV
         Kbw/QV7UHf3vfPjOf+kL9HXilXAY2rZUE985M0BXCc+/3YYrR0QlF7fCe8UpUpcjkiah
         BJaGKmKK6U7VBashSyencxtwVMn1QZxXCaY49Rk0UxbKSutrU0alxChsUfhWgylLinHz
         PMn5O4mY9TDwPga3rD2zQ+IYz+FiVzgpBvn5xeDwB27HRtYERIi3dr57QtVCs3pRgDm/
         r1VzKMaGoXHcgoGD+Q6Te9Qf9MjIpx49O3zIruBfjpV5Ht51AxinJH/HYX2qBdlXFAAc
         KveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nZILDGyMZn168Emcyzk++2f/Rxpp3GQ0Ij4K620L9B4=;
        b=RHS1yKvNv5xaEaDjdDeUohgP+0M1z1/7fMd+14YOnNx8gcTPRdQfxwSXCSpiG1QbEl
         DzZ+YdmgNxiLL0uoDExK/aVVeOcp3SdVWYkdlHcjiiQ8Hmo1Mp9jkBY6gvHz/p+3B7qA
         Ml8eaqd3pvZkyOR6o2NZbiZZrxRB+ITOwmRZmYKTNbSYlv+q1sE0qBT+B/9poe+AGi7L
         xGFg1ysJFserp16d02+Ebxg5RiEOf5yAc8IEjrNM3Jo5HxJ4pcOteKAl/a48y7SMmin9
         1EVV+HOi0wFYz1s0yZ3aJAuLzvG4cf8RJStuglIqM/gRbD8+NwpJdnDE6ITqAd7Gq247
         DgyQ==
X-Gm-Message-State: AOAM532lRX8IyygaZu3iA6wYEkKYQm+VFBEaDIcbzSYBmvVeYNSxbrba
        WLcWBbbnSsuOQWkICauPTSB1fgtfTxo8Kg==
X-Google-Smtp-Source: ABdhPJxdVHY0PUTJGPMz/oRE6wOT68T7PuJXZZkJJJfTdXirqq9Q0cmRmzyoSnOETyIUeyYo7RPxog==
X-Received: by 2002:a05:6602:1686:: with SMTP id s6mr1945968iow.186.1640100387475;
        Tue, 21 Dec 2021 07:26:27 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f16sm11728148iov.33.2021.12.21.07.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:26:27 -0800 (PST)
Subject: Re: [PATCH] block/elevator: handle possible null pointer
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221081042.78799-1-flyingpeng@tencent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b848910-0972-dfa7-e056-4467e5484a6e@kernel.dk>
Date:   Tue, 21 Dec 2021 08:26:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211221081042.78799-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 1:10 AM, Peng Hao wrote:
> There is a check for q->tag_set in the front of elevator_get_default,
> and there should be a check here too.

I always get suspicious when I see patches like that. Is the other check
valid? Why does it need to get checked? There's really no meat on the
bone in this commit message.

-- 
Jens Axboe

