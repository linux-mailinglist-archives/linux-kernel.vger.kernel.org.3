Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128EF487675
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347100AbiAGL1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiAGL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:27:02 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715C2C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 03:27:02 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g26so14390026lfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 03:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RxWUtBRyBuu8CzF10hutvoPzGTvhxAChpkFfMOfJmvE=;
        b=GA0Mf+iffPTAJnINy4M8AAt9tQbBULAZNoe8zLYeTstHuqComujV6aSKbEHJldF3gZ
         +SirHlsCed9J1FeMafhn04vYGrqEHzujD7KmEp1E3sLfuiFPfFLQnkOyk/xApF+taYCP
         sX9kYvcGx/npGKYFo6Fh5HSKuMIGEhgTOupbFE4bEFdZkZ31ckdVKz1kn4IStozwGaAV
         AbrlpHtxYmAhKypfQq0Uld+lgYiu657i+3EPsAVt/Y7/AK8VoT/fnkpRp9zOF6tjN8xX
         T6HZ4DZTKdgRQ9SmL2M+Q9hQFbgahgWswsEtv+zJ5vLQLdvZVgIiG4ZVeuJWaNzqa/YY
         JaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RxWUtBRyBuu8CzF10hutvoPzGTvhxAChpkFfMOfJmvE=;
        b=LrRcev4mfW6N+rUFiQOKRLH066W6z1iP2uRqtDkphtypLXKwYZ89AvkKMi5nCBaDv/
         ZSwbib/V4CDr7oiHEahbNVpzXGbVjtzPWMOHsCUEKTRtbyeg96a2A741AKQZQf1m/JFU
         v1+O+bnSzdXCY1FZJYtNHoFnLIv88ag+bwMCC4SFfQBjvnB0dKsBdq9WZOQ4WiOyvi+J
         qhd082Nw/WHHTPVWu2njVACpUchkl0KiEgGawOGoSVwPtGKdDu1TQBeg8ZrT6aFC1lBb
         HbIwkEuYULO3ANNmk5CFTv6AMKdUmPaayJGgRSL55XL/XKtN+EHeNxHxF2Wb5fNmVSjD
         O1cQ==
X-Gm-Message-State: AOAM531e5kKXsMswk7GP/isyaBt76cHke1ti4chpgJlMwm/s0wwjciDh
        JA9xgDm7yMANkv0NzV/Jkjs=
X-Google-Smtp-Source: ABdhPJww9MRxbZpc0vn18WhW4VAK3hqhxh0WUsSaZY9VC/I3EJvcyZ+NUMJLAxDRTD3ZBd4oo2HE5Q==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr55038059lfr.59.1641554820683;
        Fri, 07 Jan 2022 03:27:00 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.67])
        by smtp.gmail.com with ESMTPSA id z10sm541947lfd.220.2022.01.07.03.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 03:27:00 -0800 (PST)
Message-ID: <2a79a17c-5cfd-9aec-cf44-b44fb382eb6c@gmail.com>
Date:   Fri, 7 Jan 2022 14:26:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 03/19] staging: r8188eu: release_firmware is not called if
 allocation fails
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220107103620.15648-1-straube.linux@gmail.com>
 <20220107103620.15648-4-straube.linux@gmail.com>
 <ca0548c0-b36c-98dc-3e49-b629b3d3fb6a@gmail.com> <YdgjJRwLjIBWVQvU@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YdgjJRwLjIBWVQvU@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 1/7/22 14:25, Greg KH wrote:
>> Or, maybe, Greg knows some magic that will help here, we can wait him before
>> you resend 20 patch series :)
> 
> It's just not worth it for this staging driver, and for an allocation
> failure, to be backported here.  Allocation failures almost never happen
> in real-world situations, and if they do, they are not alone, so this
> would be the least of the problems happening here.
> 
> So no need to care about it, I can take this as-is.
> 

Got it, thanks.


With regards,
Pavel Skripkin
