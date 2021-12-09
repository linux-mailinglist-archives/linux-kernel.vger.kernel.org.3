Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB4D46EA5A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbhLIOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhLIOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:53:58 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE6C061746;
        Thu,  9 Dec 2021 06:50:25 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 137so5303260pgg.3;
        Thu, 09 Dec 2021 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7vWihmr59C13m9Ozt+hiMYmUMWdYzIoFqzd7V9RXcfM=;
        b=MC4uL5S1+WqFCH29RaCtS/l/zRAoxHchDRRw/aOYWFkr2oCxqF827rcEAgmaTLhu6v
         w+TOtAociGo9cL0rhYINObhIZBlWAjvzJqwx+L63SCRU2Jg+clQ4M31K8/FedTJJn96t
         KPxfzplPTmCfqMLpRE4N65t3DNa3C/gs7zsWD/iK51T9e2tczH2Vcz8PJsZnxmxsTMIJ
         yzO/zkJMJUCtq5NBD4cBG6SJqE1Kop2j/Foxw/i0GO7jjHcBCm78cP80RKg1gDbQFlfK
         0JP+fUuPhO18QXyXhz6/JKC4gIkYOA3QLay2GvLkJfLI5jHN7YVq4nbG4nuFeoaUEec+
         AQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7vWihmr59C13m9Ozt+hiMYmUMWdYzIoFqzd7V9RXcfM=;
        b=bWpds9wESnxf9EUSX8tpwTq7m+Ebk0+n6t/bfu8ePlCbCkdUMslphpdesytt9Ijh1A
         HqAFB96gUhABblIFCf56N53zqWV62K3YhJ1Q4PNXNzvI4B+1YwrdPc0sBOjuYoZYrX0G
         6RmZPbDyLoZA0d7hmcdsUmBumR5WSdLy8tf43AMEqQiPKh1DWLgw8VaY11pNQQrlEKxY
         uivfN5YcoP7RDNZrEpuvIgFkj407743LATVIE/GcPDH5QkxXh2gYcHn7QhRl/ZLrkYig
         mIDATT7PYjsVuOyfUA3lySvHR4NfCE13T0oJYI/5gV0AOAFrTLLZ20KnKpsKIt4d2BcS
         7meg==
X-Gm-Message-State: AOAM5337IyXNcSeNnTREMJhqAyCG3YsT2Km7nqyS6sliGSqyvODNK6v3
        0zXS6hiIGyosDKFaV63l4Ok=
X-Google-Smtp-Source: ABdhPJxciT4mvoW+5yfsk7BvgzflK7lvRpqZXJjRVcqs7xAjuCaRpJXEHyV7OyjU7Uz51nkcWt0iSA==
X-Received: by 2002:a63:481d:: with SMTP id v29mr34833070pga.209.1639061424824;
        Thu, 09 Dec 2021 06:50:24 -0800 (PST)
Received: from [192.168.1.26] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id h3sm9556499pjz.43.2021.12.09.06.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 06:50:24 -0800 (PST)
Message-ID: <d2988e81-64ec-9a56-b8a8-2d2d328d2590@gmail.com>
Date:   Thu, 9 Dec 2021 06:50:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] scsi: lpfc: Use struct_group to isolate cast to larger
 object
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        James Smart <james.smart@broadcom.com>
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20211203223351.107323-1-keescook@chromium.org>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211203223351.107323-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/2021 2:33 PM, Kees Cook wrote:
> When building under -Warray-bounds, a warning is generated when casting
> a u32 into MAILBOX_t (which is larger). This warning is conservative, but
> it's not an unreasonable change to make to improve future robustness. Use
> a tagged struct_group that can refer to either the specific fields or
> the first u32 separately, silencing this warning:
> 
> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_reset_barrier':
> drivers/scsi/lpfc/lpfc_sli.c:4787:29: error: array subscript 'MAILBOX_t[0]' is partly outside array bounds of 'volatile uint32_t[1]' {aka 'volatile unsigned int[1]'} [-Werror=array-bounds]
>   4787 |         ((MAILBOX_t *)&mbox)->mbxCommand = MBX_KILL_BOARD;
>        |                             ^~
> drivers/scsi/lpfc/lpfc_sli.c:4752:27: note: while referencing 'mbox'
>   4752 |         volatile uint32_t mbox;
>        |                           ^~~~
> 
> There is no change to the resulting executable instruction code.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

looks fine.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


