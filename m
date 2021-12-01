Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB746516E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350831AbhLAPZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhLAPZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:25:45 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127ADC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:22:25 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id a24so21956486qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HDqCPpobM83tXVgFzXu135kGrAKDsGLh1A7JfYk9Ohk=;
        b=2w34QKJXSkv9LcB21xtpDh5ZqzlK8f+U0DZpE2xvWoT8dTgP0rxFIfyutNsTfJoCbc
         koPVdelxJVUFlce1hCYSHdCryLDmwxf1sMAFCyLJS9YoTTA0oS9Ui1EtS6rBaNAHb7br
         V7kR50yNMxaUOGaoHAf4QI9Sp9GRdWTscSDh8CtNrxGYVkOFmji34hlJd9vCEnK/AIHF
         1s/F5R4Tjbt88ynp7/mZsJoIhvlEOeSd/MukiZYfMdLoZimNG4YKH/pzZSG15csP0Zb5
         x84d89v81kx0oMMpNrFAOCHO2BP5jGbDJmgjb1llzwZWnOIQ+78R59bQvSIbqCuDHR5X
         eL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HDqCPpobM83tXVgFzXu135kGrAKDsGLh1A7JfYk9Ohk=;
        b=wJfEC47aXcFwlFeQTwrjvsZz6squSnPgKOsgXgBnaeBZFSKUJQr/6Ko+SnkBltU27l
         OSho7CqmjDZYGJYSoLmNJDfu9KlGSU+LHBuGMPiV53/FEMxc8AyHX+stevcGaleIIMpr
         Jjhh3l4YV0tuju+SaPpBJZ+dsTidJXqmY01xYH6WW8Pe2/CYkBlDo/6HDq4r9E2elVr4
         g/q4IiAW3KybMD6A2DV/PAY9Pm20wCWmTuRwVzHDT3m5oANK7xEz+PPaCSmQWKV5wf2b
         9gLLBoOpQwM+B77AyloIPjxiRTbM4q8CMT1cv/Vy0lPT27O8KnWFtV0WeFAPyfS5t0Yg
         cQzA==
X-Gm-Message-State: AOAM530vB8QuMHQL5NXxJGtKvBcXUXZGLzAYyL20TbOfd8cokCZ3IPD+
        +jGpxa1LccbFZFQBoYZb+qr1nQ==
X-Google-Smtp-Source: ABdhPJxuEO/I1DIWzqF8VYwTCz53fyp55aok0O4YGZbmsjUVzCMEDe+8yruXstQYnro1i2PJOhysFA==
X-Received: by 2002:ad4:4b26:: with SMTP id s6mr7588352qvw.60.1638372143761;
        Wed, 01 Dec 2021 07:22:23 -0800 (PST)
Received: from [192.168.0.104] ([66.199.72.44])
        by smtp.gmail.com with ESMTPSA id h11sm58689qko.18.2021.12.01.07.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 07:22:23 -0800 (PST)
Subject: Re: [PATCH v5] include: linux: Reorganize timekeeping and ktime
 headers
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        corbet@lwn.net, rdunlap@infradead.org, mchehab+huawei@kernel.org
References: <b5d4536f-a096-b259-1385-3c1d32754dbf@vt.edu>
 <095645cd-ce53-a803-cb99-522545a409b8@vt.edu> <YSJP18Z72t0X+xsp@kroah.com>
 <1c156aca-d0ad-e7e8-2238-5c3d904d171c@vt.edu>
 <327f5c2f-b996-8aa1-cbbf-3354e01ee1f3@vt.edu>
 <fb66b935-b498-723a-1f05-f02648f8f580@vt.edu> <YYN78YlFrV0vFPq9@kroah.com>
 <ce75dfa1-b51d-1988-9371-ca90ab5e1535@vt.edu>
 <18f2afb6-7c42-fff1-2c79-ea473ae2b72a@vt.edu>
Message-ID: <0ec6b0b3-0d59-ff68-13b3-c9798f3ac6c6@vt.edu>
Date:   Wed, 1 Dec 2021 10:22:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <18f2afb6-7c42-fff1-2c79-ea473ae2b72a@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 5:11 PM, Carlos Bilbao wrote:
> Reorganize and separate the headers by making ktime.h take care of the 
> ktime_get() family of functions, and reserve timekeeping.h for the actual 
> timekeeping. This also helps to avoid implicit function errors and strengthens
> the header dependencies, since timekeeping.h was using ktime_to_ns(), a static 
> function defined in a header it does no include, ktime.h. Include the header 
> timekeeping.h wherever it is necessary for a successful compilation after the 
> header code reorganization.
> 
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

Someone, look at me! What a lonely and solitary patch I am...
