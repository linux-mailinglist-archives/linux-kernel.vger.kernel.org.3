Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBF6479CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 21:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbhLRU6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 15:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhLRU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 15:58:53 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8549C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 12:58:52 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id l7so9111712lja.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 12:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gn8LJv7JTpUL1v6yuZFpAmH+5yz/07bstJ00rIQdQV0=;
        b=AIynQEuZX6hK4iCa+QOvii2tCyfq3a+MdGHfY3np4HyjvAZkeNCGwocKB6A6HFp0rr
         0hECi8fT11+me1vtchODQNYlJjcJBPM+Cv6QysfCLFDXW+Sf7eoCIy34MDR61vhk2nXN
         VOCM4sqq0SO5sKzeA8RPeFK3NTNIy4O4GycuBxloKy4Wj7KBCxsOiZNjhW9RTKFhvD8G
         +UVYAHwJJ5XfQBYG2c0JLZlrsBhnmzx9yYTK7/9FBrmsNR3UCHKpZTKcvtB2M36DpxIa
         Pym3AxELoVwxcOySUezCUVv3/4sJmfjH8/v2zuB6MviVed+sjsHc9+96jdi+kKfDWmKx
         o23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gn8LJv7JTpUL1v6yuZFpAmH+5yz/07bstJ00rIQdQV0=;
        b=ZItMqkNl63XVOuPCsNsrHvMjB7sqRNXMPhOAc1FgsqoaWBJWu5t0apFy2ytI/iPNA6
         BfYn2UD4KH13ngGteUGk7N5DNfK+kwINCLLbUFPTxvumD1MYDlMRdJ89OoPZcldaLKdQ
         Z/RS5RBkbvEHcc2mOG0PVnE+NlGyq+waUzDLswcDe3C4RRDoT6fioEP9FO1IS76qZ6p5
         CIjxkxP6ApFIFigHZEdrjIsDGbQ+zhxeUCIiaxJMt+dJBqD06iOfwo2KU73UmWEWh2y6
         ZrsI0DRadxvKT5P++uuLXyGRuvE94w8Uqa9LhnuKNJwJvcTVgbD1jBryFm4c08vUmkHK
         0fLA==
X-Gm-Message-State: AOAM533HjDDSFIxU85qhphjIPwS+1F7TXnJaBA5ALfQOMXqhu/LNDekT
        cA7tVf8D/eFzWgeMvZsbhf5/svDgp4x8Sg==
X-Google-Smtp-Source: ABdhPJz35ebU5vl/+epVPzIj4/sQdll1xVOINZIHBMz07xkug1F8dOcgVZ8yUVfOMhpKFwdubTW7bw==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr8245383ljp.498.1639861131085;
        Sat, 18 Dec 2021 12:58:51 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.239])
        by smtp.gmail.com with ESMTPSA id m9sm2113358ljg.80.2021.12.18.12.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 12:58:50 -0800 (PST)
Message-ID: <f4c7b099-2b9b-46d3-112b-c7c2ffd3ef80@gmail.com>
Date:   Sat, 18 Dec 2021 23:58:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] staging: rtl8712: Fix alignment checks with flipped
 condition
Content-Language: en-US
To:     Ismayil Mirzali <ismayilmirzeli@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, simon.fodin@gmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20211218202847.23086-1-ismayilmirzeli@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211218202847.23086-1-ismayilmirzeli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/21 23:28, Ismayil Mirzali wrote:
> From: Ngo Tak Fong <simon.fodin@gmail.com>
> 
> Fixed two CHECKs of Alignment should match open parenthesis and flipped
> a condition to pull the code in one tab.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ngo Tak Fong <simon.fodin@gmail.com>
> Link: https://lore.kernel.org/r/20211207212223.GA70594@simon-desktop
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

This one is already applied to staging-testing.
See commit d0df53d36cd51154463796bc6abdd11abdbc67c1

Looks like you have sent it by accident



With regards,
Pavel Skripkin
