Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BFA489CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbiAJPzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:55:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236627AbiAJPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641830105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpYeQhiPDirU0G/PVNqCRwCNkTCrk6kfnonmEcbmwc0=;
        b=E/yBzizbMv7rbMQZGRgL0VvkVvQzrvafPxs6f+N5xUvzlHgz3XqToId7Gh118y3bCmYsqa
        Q/LotjiJESAzjb16kxaiPyn8p2WG88CM57exGTtVsqFX5r6As0WIdmkMc16lHpFwSyqQQV
        kDDZVe/mtc+cillgpCzd3pZXk2/K3gM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-8axmZRznMheJy1_FMJsaMw-1; Mon, 10 Jan 2022 10:55:04 -0500
X-MC-Unique: 8axmZRznMheJy1_FMJsaMw-1
Received: by mail-ed1-f70.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso2476846ede.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XpYeQhiPDirU0G/PVNqCRwCNkTCrk6kfnonmEcbmwc0=;
        b=MpcAMxM1SIXu/VaSmcK0nH9GtOQ6L9ra1V3rQS7QOZ+JY8sajjADDvy5GlX8eimpxJ
         R/71VXnSMDSR0hEVWT85ECPbFSbDeQLJXQdh0VaQ5mYmXHqjpbbuhOJkziUAIdRR0sVJ
         6uhlUtKgDlkiJ4Ecs52/C3RSMluOOhp7+tdL8e1d13KwkSxjgOufm0tjFHKrkzl3VQF9
         hX0G2+UnSj+bzuqibIIBR64pa4VWEcTBp05rqIi8hTNgWPgp4LnO81Mx+/q32lJmAgp/
         0q1Fawr0aqot4HsbSC8j7jdY2OCSsqoXu7jC5JrrYfgOC/WueeV8WHl6a7sCn85LetSX
         O8zg==
X-Gm-Message-State: AOAM532pmgPUCR4bRvfYyqofsnyfozD+ht0VDioi19zvzQXC+8ZK3kXh
        1SqW6gMjbdJRn4uKX90YWHiDbnam7TLnZUD/jCpvz1roX5QXGq1lQ6mgKYpA5lTXALRbnNPDfM1
        lOI1fb3f3jlSMf++ERUgfH+81
X-Received: by 2002:a17:906:2559:: with SMTP id j25mr309160ejb.416.1641830103369;
        Mon, 10 Jan 2022 07:55:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7T5q1x9hsc3bVzo1lfPD24rVEwbE8/18ZOdEUfUvWPhR6gTWcqSFxJrCNFXChTF5aB6OI2A==
X-Received: by 2002:a17:906:2559:: with SMTP id j25mr309144ejb.416.1641830103124;
        Mon, 10 Jan 2022 07:55:03 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id he35sm2582404ejc.135.2022.01.10.07.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:55:02 -0800 (PST)
Message-ID: <7994877a-0c46-07a5-eab0-0a8dd6244e9a@redhat.com>
Date:   Mon, 10 Jan 2022 16:55:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6 05/21] x86/fpu: Make XFD initialization in
 __fpstate_reset() a function argument
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
References: <20220107185512.25321-1-pbonzini@redhat.com>
 <20220107185512.25321-6-pbonzini@redhat.com> <YdiX5y4KxQ7GY7xn@zn.tnic>
 <BN9PR11MB527688406C0BDCF093C718858C509@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Ydvz0g+Bdys5JyS9@zn.tnic> <761a554a-d13f-f1fb-4faf-ca7ed28d4d3a@redhat.com>
 <YdxP0FVWEJa/vrPk@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YdxP0FVWEJa/vrPk@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 16:25, Borislav Petkov wrote:
> "Standard sign-off procedure applies, i.e. the ordering of
> Signed-off-by: tags should reflect the chronological history of
> the patch insofar as possible, regardless of whether the author
> is attributed via From: or Co-developed-by:. Notably, the last
> Signed-off-by: must always be that of the developer submitting the
> patch."

So this means that "the author must be the first SoB" is not an absolute 
rule.  In the case of this patch we had:

From: Jing Liu <jing2.liu@intel.com>
...
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>


and the possibilities could be:

1) have two SoB lines for Jing (before and after Thomas)

2) add a Co-developed-by for Thomas as the first line

3) do exactly what the gang did ("remain practical and do only an SOB 
chain")

Paolo

