Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED24CD41E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiCDMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiCDMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:18:23 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B922B2C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:17:34 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2dbd8777564so89530197b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GYenn+rgMznVgcu77L9eTvFUbKZ98vSsnayTEi/3mg=;
        b=zDewUWU4/9EvtfgumVR2lIuAPqJGxbcH3EorBfbMS4fIwHrlv1lpQPKZSYFHj8lSX/
         ywTuR3j24MGPFD1AoQuMKPsM+5bGRyxYbGEc/rOko2iF5FdROeiCj4ZT2sdZhIK89TQN
         My34qhOBFqgYJts0PV5FlBt1LvNCEe5fSlskyZ6Zq8Wq+oaHBxM2H3pOUBYCeaBP8bdo
         FUDPeXJu++62THA8/Cg6iaZWelLWi0LXvY6u70yQEMq7mWJKFwdB+fD007aOS1NfkUBb
         rLsvFqBWgL7bbvtAwjTfMBHHlq91KB4oozt5++aRfJeg3fFRnKGcD3v10TWDxPDxEMxF
         P5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GYenn+rgMznVgcu77L9eTvFUbKZ98vSsnayTEi/3mg=;
        b=E7GVz9Ckdi5tUqMEz5wmsMVyZ92INpXzgHnpUQ+cypOPBRt558jGXesBZh6utiB37e
         aOtFjWQ9Gy9tavy+QKIPP4c8SYsRt2veFhSRIfCGaG+QbFWs1c0BQn1gEro7J81NgVQN
         LQsM5H031RyjUigt82JhGGXXlYARP5bRBZoyf/K4rn/RhvfWsNIQzcLjtr7oGS9FNMNR
         /k+H4iZ1DSfJpjRs9QOrlXR9avUU/Mfz7CV7oX+uaaTJabQsFu2kzhALsi+7uaWNUFn+
         aPLoogP7g905fJTgfdylOyGIbWLnLfyJjgu+if7oeOcMJqfSI+fvaF/Y1jRfFDJJAq9Q
         xcPg==
X-Gm-Message-State: AOAM530EnAyX6w6fbEkttCr/QcZljpazPLCAEFCe3eqjofQFhBQLuVT5
        McKl6dREOKQlJDDbKkQT9MkYVUrr3SYce7EU4fb33Q==
X-Google-Smtp-Source: ABdhPJzSboXwnnS0/thmw7CuzyUHM03XYqiCBjMHIwhkm1SAQSPGnGM5ifsQTkbKP3ZO2Dj7lMNkZHnZs8mC6HOABM0=
X-Received: by 2002:a0d:f9c5:0:b0:2db:7a9a:b01a with SMTP id
 j188-20020a0df9c5000000b002db7a9ab01amr24767075ywf.458.1646396253728; Fri, 04
 Mar 2022 04:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20220304093409.25829-1-linmiaohe@huawei.com> <20220304093409.25829-5-linmiaohe@huawei.com>
In-Reply-To: <20220304093409.25829-5-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Mar 2022 20:16:46 +0800
Message-ID: <CAMZfGtUUG3KqMLWs32vL7fwUAVhgJuiE4OvW_B0K1zeR8oacVw@mail.gmail.com>
Subject: Re: [PATCH 04/16] mm/migration: reduce the rcu lock duration
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
> rcu_read_lock is required by grabbing the task refcount but it's not
> needed for ptrace_may_access. So we could release the rcu lock after
> task refcount is successfully grabbed to reduce the rcu holding time.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Also simple.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
