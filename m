Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200434649D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbhLAIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:41:43 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35829 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhLAIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:41:40 -0500
Received: by mail-wr1-f50.google.com with SMTP id i5so50422780wrb.2;
        Wed, 01 Dec 2021 00:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=spAN/Hm6eyYQRpVZG0bxWXSe/+KMWx87QIzxMeC45pg=;
        b=tCorrFmZG71Rn5Sqk6ssEfUy6sWkvyP0BS0pAUxEIYo+hM1bHWApTUGh6glavjWMWz
         xNOlf155stDKikVci4gH3cYeAb77dfyGNVhhqlidkXaw5Ro/ARpMd9OgVTUKRPofM1PE
         3yCkg867i73HJlJI6aoxs3IncCFD2yR+EuE0DQiuUrKA6hK6KOWhH93GNCdzR8o0iwb/
         tXtii8YD99JcGqCF83bnGnZcL3Wf8fbfzy7a9XFfcB0K49cpDceFO/ab/aH+oWcXVmtk
         NO5vJDeOcAtw+KoEA0iocKQpfyOmzQFMoPY0oCOmcDwv97C7SYE9hBn+5CI6/OFPZ1j/
         om3g==
X-Gm-Message-State: AOAM530HaaXE2DpjvnNeXYLm0zQS7Fsh6342yM8exN2f3XbHM3SsUC+Y
        K3Gb3A1FkEPbNir9E132NVw=
X-Google-Smtp-Source: ABdhPJx22R0stTBem73oFqWNt/SE3yZ0IWIfzf02NhKlROqRQhHBNhMtD/P1c4bhO2ni4XDioecBIQ==
X-Received: by 2002:a05:6000:15c7:: with SMTP id y7mr5128929wry.424.1638347898932;
        Wed, 01 Dec 2021 00:38:18 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d15sm25530187wri.50.2021.12.01.00.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 00:38:18 -0800 (PST)
Message-ID: <37511fa2-baed-c387-150c-3fa6b5b1c64f@kernel.org>
Date:   Wed, 1 Dec 2021 09:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] mm: page table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, corbet@lwn.net,
        will@kernel.org, rppt@kernel.org, keescook@chromium.org,
        tglx@linutronix.de, peterz@infradead.org, masahiroy@kernel.org,
        samitolvanen@google.com, dave.hansen@linux.intel.com,
        x86@kernel.org, frederic@kernel.org, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-3-pasha.tatashin@soleen.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211123214814.3756047-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 11. 21, 22:48, Pasha Tatashin wrote:
> Check user page table entries at the time they are added and removed.
> 
> Allows to synchronously catch memory corruption issues related to
> double mapping.
> 
> When a pte for an anonymous page is added into page table, we verify
> that this pte does not already point to a file backed page, and vice
> versa if this is a file backed page that is being added we verify that
> this page does not have an anonymous mapping
> 
> We also enforce that read-only sharing for anonymous pages is allowed
> (i.e. cow after fork). All other sharing must be for file pages.
> 
> Page table check allows to protect and debug cases where "struct page"
> metadata became corrupted for some reason. For example, when refcnt or
> mapcount become invalid.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
...
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -62,6 +62,30 @@ config PAGE_OWNER
>   
>   	  If unsure, say N.
>   
> +config PAGE_TABLE_CHECK
> +	bool "Check for invalid mappings in user page tables"
> +	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
> +	select PAGE_EXTENSION
> +	help
> +	  Check that anonymous page is not being mapped twice with read write
> +	  permissions. Check that anonymous and file pages are not being
> +	  erroneously shared. Since the checking is performed at the time
> +	  entries are added and removed to user page tables, leaking, corruption
> +	  and double mapping problems are detected synchronously.
> +
> +	  If unsure say "n".
> +
> +config PAGE_TABLE_CHECK_ENFORCED
> +	bool "Enforce the page table checking by defauled"

s/defauled/default/

regards,
-- 
js
suse labs
