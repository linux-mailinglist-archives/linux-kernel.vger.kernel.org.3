Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275AF477613
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbhLPPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhLPPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:39:07 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D378C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:39:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g13so687752pfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=+Vwl2VuN2bp39NkxFN8aGMkD07b3hpM4lr4d12Vh0D0=;
        b=CLwAP4mRl1xBhLqZcRVmr4R5ZlFamfspwsKfVAhDQvPIgGdR/Xr4jbV9UVIzg2pu9Z
         hZnt5n0o3cP+GAz9XUxG/NdZlF8KcvKX4iU1Xh9sMbIOp5K9e/RPfIfDinKhV7w8ikQF
         447sI06TA5IiFox571D8cIxSNM3fV639M5bFXp+w4gZiEY1PMFkCs1heuHm/DiVUx4ZJ
         MFMfIZ7evyKvB1qjMxSIdvSB+hWRrmLVToiyz+bfI+75QVv+3QgTGb4n7coqMkJUgmJe
         MJGtW8Paeimm8+Uu+NSPu6YI5LvV6/W3lilLiArjs9b43aUOnxXmgVsSqprw+EUM9YWZ
         FNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+Vwl2VuN2bp39NkxFN8aGMkD07b3hpM4lr4d12Vh0D0=;
        b=4U6MHQEfmQtDgW1Fh68Rny6LEYiiAci5isesIaGlR1MbUUeQeCmU28JYSRZ0SRQCZ2
         FetaoS/KQUKqL9YWPkZXICmeAHhzarVABDzyWmsOLrDo1w8v7CtDzNJiyaShH/GMUzfr
         BximtlNK2JqDIAA/slVQKXcbo/1SKDOskz8x/SE/jzpPr+Hsb1PHf8LAOdBJ9eSuJN3n
         tPsQi58+NFFN9uxWoS+Avx9wSEMvG15e+wb4Fv4y06goLBh0ZrHrvkbq7EWEnkWS7Do9
         vdVDICCzhZkdqXZ4QDIUtRizYtXYEwsvKNJF7oRHcFn/7bVTk0ghjaM97jw9d2HromH8
         q3Yw==
X-Gm-Message-State: AOAM531YeSpNp3Yj7+79ygB8J+/YA2btANiIRrFQtjBYraKO8pq0Da09
        MFbeogDeS0IzbtyzaE4U+x6heA==
X-Google-Smtp-Source: ABdhPJyp5Vb9UsoM15zW5+BF06ShnxN2GgK0qd+xRnWXXyohw509+jh0I+zuuWDD6hhJ4HC22U1ZLA==
X-Received: by 2002:aa7:88d6:0:b0:49f:dd4b:ddbc with SMTP id k22-20020aa788d6000000b0049fdd4bddbcmr14490299pff.31.1639669146958;
        Thu, 16 Dec 2021 07:39:06 -0800 (PST)
Received: from [10.255.28.103] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id m6sm6006401pfh.87.2021.12.16.07.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:39:06 -0800 (PST)
Message-ID: <10a38fe0-d609-0e25-4a79-a5d23a83600b@bytedance.com>
Date:   Thu, 16 Dec 2021 23:39:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] mm: reimplement si_mem_available()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, rafael@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
 <20211216124655.32247-3-zhengqi.arch@bytedance.com>
 <Ybs8WBHt+5TklFe8@kroah.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Ybs8WBHt+5TklFe8@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/21 9:17 PM, Greg KH wrote:
> On Thu, Dec 16, 2021 at 08:46:55PM +0800, Qi Zheng wrote:
>> Reimplement si_mem_available() by reusing si_mem_available_node().
> 
> That says what you did, but not why.  Why are you doing this?

Oh, sorry, I will add that.

> 
> And what does it have to do with patch 1/2?

With [PATCH 1/2], we can simply sum the MemAvailable of each node
to get the gobal MemAvailable. Essentially this is a cleanup, no
functional changes.

Thanks,
Qi

> 
> thanks,
> 
> greg k-h
> 

-- 
Thanks,
Qi
