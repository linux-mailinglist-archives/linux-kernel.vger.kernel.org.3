Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7B47C077
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhLUNJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUNJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:09:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91EDC061574;
        Tue, 21 Dec 2021 05:09:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so23255926edd.8;
        Tue, 21 Dec 2021 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=Uq8IV/vR053QBD6hYLBqEnUX85fdvDITWbIvV01Indk=;
        b=KSskiG/TN40r3LzDh/BZL4qMm1a3z/3ndHN3ze3ustQ5WWgOK2tbgySD1MiAijy8Wh
         2srwpc/XRQ3Ue5i/jM1HNbuhCiOCI9PoGvREo4RuG0w7UOQZ0Viq3bhQ3GsTNoODGlN/
         NUf6E+vOycJOY7/3x3oO+tnYJ+8D3sA/RAU81h91yVajkLkiC6Pnhz94RDS1LJ3Yxlhs
         5qZztcqABOLQezEmrPBIrW3QJI6b6iNgdgj0EL7tsEawuXSzuCZu7sSDlukHFsfMkdOk
         QVxARiQfrxsUreURdrjV/DqSGPIV8v+QLv/TWYtRSexmmpdXKQfDtSY4g4rZwhy4sg8k
         baMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=Uq8IV/vR053QBD6hYLBqEnUX85fdvDITWbIvV01Indk=;
        b=eEub3XzHrv64yomtETaj4mSBGyS2dyYlm3CleVPM25U4u5uNrFcLKkDuIn/m1byJw8
         zX1ZEvvlHPdAKkR9DMOcms/rLFJ9VvWUhaxoGGWB7H63+p7XIMOqCt81pwBzYYcOo+iW
         lh800m2DXnopKz8WtTf/DKRJ3LRsCWYGn2dfqBqkMNLHVgBqCstjrFXP7kL0cT2Nq0j6
         kGXpOEXOjjALtifBAGJzBMdpYX33mmkFvfXgwWE2nlptkJszZXB3St08OInaigugPQiH
         vkwzdcGsEt4Op2bpFMe9QQLINoUtwTBSceAzk8cglbPzKwEDyLykrxapIUfhdU2Lfz6L
         MO6Q==
X-Gm-Message-State: AOAM530GCE0c6DhJXxs+Iba5SLMr9zyUWCn44neTSOxA82sy6USgU57d
        tihlN2tU697f1QUPRt6quUo=
X-Google-Smtp-Source: ABdhPJxRB094bKfPUHHe9F1mJhyX59qTuR7H7HSdqBWHRA01P8YuRgAyG1AEpJsrJKlHhfQVkGw+DQ==
X-Received: by 2002:a17:907:96a6:: with SMTP id hd38mr2577069ejc.479.1640092166420;
        Tue, 21 Dec 2021 05:09:26 -0800 (PST)
Received: from [192.168.123.240] (static.235.156.203.116.clients.your-server.de. [116.203.156.235])
        by smtp.gmail.com with ESMTPSA id a18sm8283525eds.42.2021.12.21.05.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 05:09:25 -0800 (PST)
Message-ID: <c7ee3d19-3365-9aa0-c3ae-762108060cb2@gmail.com>
Date:   Tue, 21 Dec 2021 21:09:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v2 0/4] page table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, corbet@lwn.net,
        will@kernel.org, rppt@kernel.org, keescook@chromium.org,
        tglx@linutronix.de, peterz@infradead.org, masahiroy@kernel.org,
        samitolvanen@google.com, dave.hansen@linux.intel.com,
        x86@kernel.org, frederic@kernel.org, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com
From:   Fusion Future <qydwhotmail@gmail.com>
In-Reply-To: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm this patch resolved my issue. My system has been running 
three days with page table check enabled and is very stable.

Thank you very much!
