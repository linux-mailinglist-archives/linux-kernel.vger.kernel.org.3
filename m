Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C104CD572
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiCDNtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCDNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:49:41 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298663BD9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:48:53 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id u3so16952895ybh.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxkq6fSmSidI5jxQNF6F1Isey3naDKJl+wbEQVSsuM4=;
        b=YkmvT2pYJSwLyqzxe7ZiuTgqTHehcij3OgfSQMM1G9wKC+pGj+nepQnxvLkJD3xQbe
         GwRpzcXG3WQeIjAoaLcRTIw8psD18ZufUgk9tX5LH2aIAQuNR0Cahu4/McJ8wd6gZzvi
         luZDPBLLHlJnleHkPPudXkxeVQHWd0AC3onqha/ThPA5u8Kkh/J8/GgbbiPu7y/IkQCD
         SvEngsty4bE46BGPqb3wW85zP0D+WOf83towpFjc7pAVb0Zri9B0Vy50CFtpkwgVhhTi
         V+J0mQ0Uxj8DwCYfay7aW3eGcsiLKNEuNAKmnBtxXIiBo6RkPNSF3yk9DURTmdy12gIx
         b8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxkq6fSmSidI5jxQNF6F1Isey3naDKJl+wbEQVSsuM4=;
        b=6SQyHuJ3uvi6uCAlAoqOq6VQpWSIfdbbmfCft1fxbJR6wrTsm2W2gTEe/mtz7n2Tsu
         kG5VBnnnfJhm0UlflmFTHppFCwinfilsjJD/T9q7UFP9Rpft8ShvdlnC/598CHU3+AZq
         IYnf3gDKjNmQyYTdDWIChQI20qnodz9qvtvIMME7Ww2fgiWnhIsHfbAk0Zrs1PvJRcNp
         X8d5waFj/4CHzNxaN2UX9o6jhw9BknYUz01PlwIk7DDqUyN0PiSctoWib2/IE77oSQCv
         jFV2x7RDe5eBBOh/MvqXb1di6AIvhQox/09ktFt3HvDnzvwHXzRD+NRlYXwUheub/yFK
         b4/g==
X-Gm-Message-State: AOAM5326lTwssWvPTfLczFIaGu9fXijUb9ElRb37lT0balRjCerTbzT5
        xsL0Jg14nhjCnPZlE8Tau08/ClazzBSZi0NneAno4g==
X-Google-Smtp-Source: ABdhPJxKuAiqNr7UyPfzts+HCa+Uluo7ia6UGSm/CWm+KUhmQlIvDFPwusld7YQhjESeDq8Q2ncG3s8yTNqILxMlLFA=
X-Received: by 2002:a25:3d47:0:b0:624:7b42:9f0f with SMTP id
 k68-20020a253d47000000b006247b429f0fmr38966576yba.254.1646401732585; Fri, 04
 Mar 2022 05:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20220304093409.25829-1-linmiaohe@huawei.com> <20220304093409.25829-2-linmiaohe@huawei.com>
In-Reply-To: <20220304093409.25829-2-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Mar 2022 21:48:05 +0800
Message-ID: <CAMZfGtWH5_tbQwiw0P=e2OuEuMX0BusDevN5WyOTzEC5_cVhtw@mail.gmail.com>
Subject: Re: [PATCH 01/16] mm/migration: remove unneeded local variable mapping_locked
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        ave.hansen@linux.intel.com, o451686892@gmail.com,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Michal Hocko <mhocko@suse.com>,
        riel@redhat.com, Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 5:35 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> When mapping_locked is true, TTU_RMAP_LOCKED is always set to ttu. We can
> check ttu instead so mapping_locked can be removed. And ttu is either 0
> or TTU_RMAP_LOCKED now. Change '|=' to '=' to reflect this.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
