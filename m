Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414844668CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359298AbhLBRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348007AbhLBRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:07:33 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDFFC06174A;
        Thu,  2 Dec 2021 09:04:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id o4so375042oia.10;
        Thu, 02 Dec 2021 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a+ZMxgWaDs72S9/RaqRmm6O/RoDhwTRlXJky4RmwPBQ=;
        b=izwvQZjwgCdFypNx1ZK8HWp/QX5hAPFPe3lO5NwsUZIDrivTHroJiRGBlY8zANJ3JW
         KUB7vEezexCBzhsXvL17/R6eocWqzw0kxQrHQpkTMsy9Wnl7h9/brKEa+hsrwVDIfh/C
         hjONag0mUBZklevnqgaihy9uf0hM0ZYwY0GsNQXykI6X2uS1qmp33rxj/gfqTxYar2ad
         LT66PDtwnJvDrfgueFjkuevpLAz2TSNRxU43m7rx7mWDFGawFClMrqDtDeHWeQlgXW4Q
         JHx3jbNq9RYjYZAww2Ehv13cziPGdVcjB7kFI+mFR2Iv/vWagOBfHFvtUBL1SStlv8eo
         epUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a+ZMxgWaDs72S9/RaqRmm6O/RoDhwTRlXJky4RmwPBQ=;
        b=OjLzcIjG7s/PGuvYLVkVxwhzjt/YAdeOcvz0/N/hXhCYXtJHUcn88H6VIvN3bTn1K4
         Re3+scTyfJYGYmPeObfqeYHQuw2+jfne+36+nN7GeUXVMqPOjbbAdb5QiEUwNEWHFLEQ
         mwtxoySs1cpKnW7rea1mdg0EpOCyLhHnt+SnbjgSgh9PAO0WQTdkNiBQu5tx+2+VL0j2
         muTekPB2MCWwusvO1b/CTFbj7yseUQRqeW7gVyTHuf3/J5LqShAB5ffaEWx+UcI2n4Qx
         bfr6hoGdrMPvn+bCE0v+V8hn5Nzi6IOCWQakPOIuTJBnA1azIHzaBObONMBlgFqQpC3f
         QkEg==
X-Gm-Message-State: AOAM531k+3RAQYjA+4oJiyDoEnutL82lNssdc4Nl21SexmFvJeA59P9y
        eQmW+8N/cw/+xBUsymyE7FEW9TsnBM4=
X-Google-Smtp-Source: ABdhPJznOCqy5+LmfVtV2nRQ7Y6jsVGYCEO0oLMI14Y43iu20z9mjNM7G2OTVZd0uPVDgoDx/0RzyA==
X-Received: by 2002:a05:6808:53:: with SMTP id v19mr5412430oic.8.1638464649984;
        Thu, 02 Dec 2021 09:04:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t14sm130055otr.23.2021.12.02.09.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:04:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 0/3] hwmon: (nct6775) Support lock by ACPI mutex
To:     Olli Asikainen <olli.asikainen@gmail.com>, pauk.denis@gmail.com
Cc:     andy.shevchenko@gmail.com, eugene.shalygin@gmail.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <CAK9yiZAJRL9_Hj1zuuEEM4ngM7GVCgx56m1E5h_QzzXV255NGw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2a06e8de-d0ce-a2f4-d250-1cdf5f74f6c7@roeck-us.net>
Date:   Thu, 2 Dec 2021 09:04:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK9yiZAJRL9_Hj1zuuEEM4ngM7GVCgx56m1E5h_QzzXV255NGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/2/21 7:04 AM, Olli Asikainen wrote:
> I have tested the patch on my ASUS MAXIMUS VII HERO and it works, as
> far as I can tell.
> 

from a maintainer perspective, I would suggest to provide formal
"Tested-by:" tags to have a record as part of the commit log.

Thanks,
Guenter
