Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153C446B1C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhLGERJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:17:09 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:42910 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhLGERI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:17:08 -0500
Received: by mail-pf1-f181.google.com with SMTP id u80so12188986pfc.9;
        Mon, 06 Dec 2021 20:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xgiSNZK4fLLZAoxoUS4UBNdFGugmbF9fVZrA6ihuE2w=;
        b=vLnNw1esR4wAAliYV1LrDgvGvPKrvPu0lY5i/uK2CthUqczbJCj1Mxfvkt9UTXipZU
         1AjYh4Foa2oW/g3r58hAKm8k4PXXUlpsjL36FHdTjp23bieX+h0b3RA5XhM0Ps5RpcOi
         VlEYmt9aWrzyFk2gixwW8j395b4lp2b0p6Hcg2As0hgJml64CnJo7dbAJsEz50jT4SAi
         +3hu889AOpehk6zyuuKYkCNJF0bSWNCeSdavTBokJEXGUjruSZQ2iVn69379sn4TJScG
         x0Ur1EyDhFuOpKISZjcaETcMqkUuikKqV5lCIV9iUBQXPT0D5Ds7ll68Zo1KlCKr6ohY
         0qIg==
X-Gm-Message-State: AOAM530B085OntyfSn/OIt8Ywkntq58gr7BDMFk0bmyfird8cDm9iBde
        qbS6DLyGEKmZdkUZZ9OXs5s=
X-Google-Smtp-Source: ABdhPJx9tRk3qrBo6fi4OR4zE7O3+gtUWDojC6gsjYougV5Pr5XYxCUT3TI7FBfQUyeJb1tldjkb7g==
X-Received: by 2002:a63:8348:: with SMTP id h69mr22840709pge.490.1638850418506;
        Mon, 06 Dec 2021 20:13:38 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id f5sm898282pju.15.2021.12.06.20.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 20:13:37 -0800 (PST)
Message-ID: <dc8d2a9d-69a7-c921-a995-d216e30ca2ee@acm.org>
Date:   Mon, 6 Dec 2021 20:13:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Part of Spinning up disk... ....ready logged on separate line and
 as warning (default level)
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "James E. J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <8fdeecc3-bcce-1f5c-9aac-656fb3464c27@molgen.mpg.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8fdeecc3-bcce-1f5c-9aac-656fb3464c27@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 06:48, Paul Menzel wrote:
> Also, there are four dots in `....ready`, but the log timestamps only 
> differ by one seconds.
> 
>      /* Wait 1 second for next try */
>      msleep(1000);
>      printk(KERN_CONT ".");
> 
> Any idea, how that can be?

Not sure what is going on. All I know is that KERN_CONT is considered
deprecated and that it should be avoided. From commit 45c55e92fcee 
("checkpatch: warn on logging continuations"):

     pr_cont(...) and printk(KERN_CONT ...) uses should be discouraged
     as their output can be interleaved by multiple logging processes.

Thanks,

Bart.

