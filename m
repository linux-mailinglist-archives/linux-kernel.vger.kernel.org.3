Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB69B470734
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhLJRdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:33:20 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:44975 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbhLJRdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:33:19 -0500
Received: by mail-pf1-f178.google.com with SMTP id k64so9019740pfd.11;
        Fri, 10 Dec 2021 09:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C29RQmhBlCkkPpuJ/eOeU2rF+9gMdwncIV/icJVqVFM=;
        b=xTnMw339uMefKqhiBXs0Qbm3Kd3pv1pRZKdlLMegA7b4eEYwG3cJs8aFi/bv4/F6+L
         Oq0m80eB+ewsVeisNImKuVlZrvrGaOC5+raxl9xmnOT4vUmAQAV5O2IoLrgKUV0Jg+W6
         zgtY9L5sbMqJg3W82kj4zpwDUCoXSNoTf+CXJ8KO1Qi0eh8jABUJtuntITmh53t2INpI
         8wFJKxpkSpw4r73k4azz7ENLHftM2IYwpQ7nQGtb08GIYk41uXidVOcHwJLxlorrOpui
         NwFsvdbf0TUiaBxzJuSBipMfCG/JyMmn1NMUMH0PRHrnMN+Kx7uA8Op2Il2Xt68485A2
         tn8w==
X-Gm-Message-State: AOAM533/MRJEJ7V4lGMysqLyb+auggbAG8h+wktGpcXpQl20JdmiJZd/
        VEVucS80rysxVOfs+tmY5x8=
X-Google-Smtp-Source: ABdhPJxnPaA1x86sHWiX3QwNKGliVcR0m6wJyrK4PSHjfL6CnHM332Nci95Wz2p6qphK0zmUz2YIAw==
X-Received: by 2002:a63:5c5f:: with SMTP id n31mr40214965pgm.348.1639157383889;
        Fri, 10 Dec 2021 09:29:43 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:85ed:ea0b:339:7b11? ([2620:0:1000:2514:85ed:ea0b:339:7b11])
        by smtp.gmail.com with ESMTPSA id c3sm3926878pfv.67.2021.12.10.09.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:29:43 -0800 (PST)
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain> <YbL2uUqV0GWFOitE@kroah.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cb29756b-8b21-5b4d-f107-b5573945d7ab@acm.org>
Date:   Fri, 10 Dec 2021 09:29:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbL2uUqV0GWFOitE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:42 PM, Greg Kroah-Hartman wrote:
> A single hex value makes sense to me.

Hi Greg,

I'm not enthusiast about this approach because:
(a) A single hex value can be confused with a number. Reporting a bitfield in
     hex format is not sufficient to prevent confusion with a number.
(b) No other block layer sysfs attribute follows this encoding scheme.
(c) This encoding enforces the restriction that data unit sizes are a power of
     two. Is there anything fundamental in encryption that restricts data unit
     sizes to a power of two? I don't know the answer myself.

Thanks,

Bart.
