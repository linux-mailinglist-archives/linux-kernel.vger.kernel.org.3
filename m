Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649D64A6511
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiBATeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbiBATeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643744048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rP6p3c7eWRXO/WZG4n84i5dELoNm3qpE2agZPlJmCIQ=;
        b=gKkQ7EC59Y6PWtmzLn5E68tjdk5/ICq6pcIdHyaK6lwHz/om7bROsyhe+VDdOr2U0bzMCx
        n7fgvsnNYmaAWpPIc5d7crNQyFyNDM8WfGFrbOVO+Z1OdttRkkzn5xynIVrDBAGsThYMFL
        qKTw9tdrWynU4AdTZetgCM/L9i9AhZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-MU1fY_yiMcaPbl8FKvQ0Rg-1; Tue, 01 Feb 2022 14:34:05 -0500
X-MC-Unique: MU1fY_yiMcaPbl8FKvQ0Rg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA3F8A0C0A;
        Tue,  1 Feb 2022 19:34:03 +0000 (UTC)
Received: from [10.22.19.61] (unknown [10.22.19.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ECE419C59;
        Tue,  1 Feb 2022 19:34:02 +0000 (UTC)
Message-ID: <79022c90-674a-04d1-0de8-5738df5882b5@redhat.com>
Date:   Tue, 1 Feb 2022 14:34:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/sparsemem: Fix 'mem_section' will never be NULL gcc 12
 warning
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220201192924.672675-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220201192924.672675-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 14:29, Waiman Long wrote:
> The gcc 12 compiler reports a warning on the following code:
>
>      static inline struct mem_section *__nr_to_section(unsigned long nr)
>      {
>      #ifdef CONFIG_SPARSEMEM_EXTREME
>          if (!mem_section)
>                  return NULL;
>      #endif
>         :
>
> With CONFIG_SPARSEMEM_EXTREME on, the mem_section definition is
>
>      extern struct mem_section **mem_section;
>
> Obviously, mem_section cannot be NULL, but *mem_section can be if memory
> hasn't been allocated for the dynamic mem_section[] array yet. Fix this
> warning by checking for "!*mem_section" instead.
>
> Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")

Sorry, I forgot to add the line

Reported-by: Justin Forbes <jforbes@redhat.com>

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   include/linux/mmzone.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aed44e9b5d89..bd1b19925f3b 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1390,7 +1390,7 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
>   static inline struct mem_section *__nr_to_section(unsigned long nr)
>   {
>   #ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (!mem_section)
> +	if (!*mem_section)
>   		return NULL;
>   #endif
>   	if (!mem_section[SECTION_NR_TO_ROOT(nr)])

