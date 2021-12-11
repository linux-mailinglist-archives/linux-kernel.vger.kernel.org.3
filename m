Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0709B471439
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 15:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhLKOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 09:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhLKOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 09:21:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4193C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 06:21:32 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x5so11076342pfr.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FekVagPR4dXcdP7uCFP0bvB/Z8TAk+0KsA2Qc/XbD5o=;
        b=sfPz8A52lShEbmglLHjKdvUCMiUMbzRltBUE1sFRStCWOsJvUxFSDvYfisK6eNaknF
         kGfBp0iV6g0jhJNvGFnicM0yEcIIW4DQm7IAubr3a6Q4zZU2qzzAJDWPpE/ya8r+hBmf
         3OYDCEtNLbut33y8RBHEuOEoipKBXbca4Qar7aPvrYnDh9DCsMWyKFh+bT69QAauQBu1
         zk/AsnW6cYsnOzSDuQilPoMYZAVTz0i3M16NnX+fijdl3aL+HT49GPcCWjoobyNdHURV
         sK7yjc0y00Z8+2uqEykaVj27RUUOOYB/cvFBBRaO4wN5us0BJbrG7DslZ2yVi+xhSK8n
         EI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FekVagPR4dXcdP7uCFP0bvB/Z8TAk+0KsA2Qc/XbD5o=;
        b=7JQCcal6skeUiqGCQ3+VMo9lCsFSf2FoaWhUkifGwMhMKnAyCmlJhKdMuVe1lwVHIt
         07CwPWKEys/YyLjipnW2agcv5yZya36BqcqDhPQUUY8iJWiW8TOfXQ0GsWpYiwzFS203
         R6SoR220m4jxGvI7/hBneqwiaj58y+zZ14zz0u6uuk2cXYuciZhDFsspAxp907F8JG8W
         MSKV6LDPFZAqMeo1g8xiqhF+PIFbU0zxTxJuHEdzJxT4IsJSJ5Oh0rJpXhLTzPFjgRlu
         qhM7lUVPcb81Knd8m1gMQ0QJka15r/fFJ7dfLtvsR8LBRnRK6ocYQOJkY3A6OZNiisJe
         LEqg==
X-Gm-Message-State: AOAM532wmJFLYLyIh+PAKt/lgLfS6rhmPddzCqcMSzc6YyvuiNdNDSGQ
        7Y/6jRbjUrJJb5iQmMekTBGQREbdxEkDkQ==
X-Google-Smtp-Source: ABdhPJwixsbfy1EcS7D11sG6Xm/+t6AUFl1VNzSPMMVewBfh8zL/+dyGLuyG6f/vL4/zQWBciSC5Fg==
X-Received: by 2002:a63:5a18:: with SMTP id o24mr43568267pgb.459.1639232491977;
        Sat, 11 Dec 2021 06:21:31 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id q17sm7628946pfu.117.2021.12.11.06.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 06:21:31 -0800 (PST)
Subject: Re: Random high CPU utilization in blk-mq with the none scheduler
To:     Dexuan Cui <decui@microsoft.com>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
Cc:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <c5c8f95e-f430-6655-bab5-d2a2948ab81d@kernel.dk>
 <BYAPR21MB127011609EBF6567126EBF83BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270B53CFDDFD52AD942B3AEBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4350274-7219-1d1f-7a39-3f445c081fd1@kernel.dk>
Date:   Sat, 11 Dec 2021 07:21:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB1270B53CFDDFD52AD942B3AEBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 12:09 AM, Dexuan Cui wrote:
>> From: Dexuan Cui
>> Sent: Friday, December 10, 2021 7:45 PM
>>
>>> From: Jens Axboe <axboe@kernel.dk>
>>>
>>> Just out of curiosity, can you do:
>>>
>>> # perf record -a -g -- sleep 3
>>>
>>> when you see the excessive CPU usage, then attach the output of
>>>
>>> # perf report -g
>>>
>>> to a reply?
> 
> I realized you only asked for the output of "pref report -g", which
> is much smaller. Please see the attachment for it. 
> try_to_grab_pending() is the hottest function, e.g. see line 2479.

Sorry, can you do:

# perf report -g --no-children

instead?

-- 
Jens Axboe

