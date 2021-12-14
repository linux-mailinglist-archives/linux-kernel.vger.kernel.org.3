Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9258647440E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhLNN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbhLNN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:59:13 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:59:13 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id s11so17559399ilv.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vkt27jyKBc5TiS5qbM/sF3Ng+qiD9oaD9dpLTZFgFPg=;
        b=kCqmAyxLCtc04xEUN622f2pBz4Sq5b3enBRS2WBkOfvzwPxyhZfT/xTcxVBQI7Ro+C
         GMxC6qdBC8qslybcmpMnhV9JUVcL51Fh7OCNrXxWx74ljsvFLlkSz7QJIy+GJywgQhPm
         80Mlb/xVqO6y2sKI/M6zY7QwlUAgX86e0LYpN4nA5qv6MdSl+8GvWKEGjpqPAWUNOnms
         CJyQ18nl+nT+h/Agh3i3iTcEcaTggSq8bBWQxkNCI/i+VETqWOtABVk1KJFop+hCr1t2
         gH7ytI82UxhJG7Qduh997UggOPKpEvGHdgDAKfbAULnmF+La/UaZDsCG/TlBqvenQVPj
         KJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vkt27jyKBc5TiS5qbM/sF3Ng+qiD9oaD9dpLTZFgFPg=;
        b=TFQZDwVpWcAFx7A+bTOFTSlGp1/9N3kGlGVlvp+xNvf3QR8gmHqTYa/XMm52exhu1m
         Cn1nsrJB3AGfgUa6iET6xiGnKPdearsWYqsmpm8tE/nEwDUoJ7Ia5nnB5WqcfK7ijmsV
         I5y7hZtB80VkOV4PyDFr32NI55MLpuAzW7r0f0pOUnvfDDmWLdYTqnMhw/HEel4ADU6T
         847WEwnR3vL8oX5qqLpuXVTWEjlBAi6/DypWv+n58e8HHGBZ7v1iz+h8EiprkemAQilh
         VPQSzDAnVekFKP7WgAiE7ARs5KHNRwCtxs+Fsy6kUghYAXE5Oy//9yWk9YenzNZ20cxJ
         cL6g==
X-Gm-Message-State: AOAM532l3P2XFLujp4Q18P6XHrB/yMiq2yL4A657pdretCF5himF/dQ+
        8rVVPUVOQBHCEUvsLuoxGXyz3A==
X-Google-Smtp-Source: ABdhPJyT+360tMyccVsA34sWxQ0fjtyqpQ95UeHJXv9okxV27P74TnPV2Qys2chTJBB++ikJ8jqMRw==
X-Received: by 2002:a05:6e02:1be5:: with SMTP id y5mr3679166ilv.156.1639490352892;
        Tue, 14 Dec 2021 05:59:12 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x7sm8894631ilq.86.2021.12.14.05.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 05:59:12 -0800 (PST)
Subject: Re: [PATCH v5 4/4] rsxx: Drop PCI legacy power management
To:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211208192449.146076-1-helgaas@kernel.org>
 <20211208192449.146076-5-helgaas@kernel.org> <YbhN69IhTbGhvVeD@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c856b61-6e16-1943-c816-3736b872aa06@kernel.dk>
Date:   Tue, 14 Dec 2021 06:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbhN69IhTbGhvVeD@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 12:55 AM, Christoph Hellwig wrote:
> Maybe it is time to just drop this driver?  It was never widly used,
> seems unmaintained and uses a cumbersome own queueing layer instead
> of blk-mq.

I think so, but let's do that independently of this series.

-- 
Jens Axboe

