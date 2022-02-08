Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694D4AD3E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiBHIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351821AbiBHIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:44:25 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65392C03FEC7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:44:22 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id m8so6795054ilg.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Lker2+Uo8UhianHSMBGKA4jgSJ53TnoXXawYMAybIpQ=;
        b=inNoanZN2Rt09wIpOdvGFFnihAY0clMiz0/jcty75GOYZgZPC4gcvH9kBYSKBfD88y
         s+DnKZK8oJ9Hlymo5Ef8YFhQ7WZ1LjWUhS2h+yWzgHW6K5YFjDAlOTSSWa/lCRJdXFk+
         obvXcQucOJwyDODiBADQfccHr1CHabOzg8XD2akiAv86jz2POoL9eVCdIOqmWQleCmWg
         CKImx2dy4UvYJe7KvmME9K12wSZZtvsOowZoGN09g2iR+rZL9mgl5C7o1ULHuU3hwxPe
         v3gVcatYK6Iavvn11SM34ScpS8PAwNE5kyv7lHpgPZMn3ILADORD3ot6QuxchDDst/SJ
         SG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Lker2+Uo8UhianHSMBGKA4jgSJ53TnoXXawYMAybIpQ=;
        b=IER3DC/t064FQj6Za2ggUNzrUmnb+jClydL/TkRUwxmrUKs5UNGjMTh6mrWUXIQymV
         Fl2NctODwzeO4AwFn1NBk0tJaOaHPjzvvvyhwSxkVTbL9mvhCcGMFgKE9LReNPMkSALL
         yZe9lq07sf6Q1errwho+C5jJ/pExkEzPOaxu8Hapn3SvSBtZgMlFO1CTbjOZ2uV2TVfx
         zOE32R6DZ2Rl5/wYGjeBn9rzrPs8Pw3yAmBSglt4mzK5lOPX9dmhf/0krmb04ZPmdp6R
         5DOYN/fEt2UBgH+la7cfOoJNkwszGOdInuwmngMsmRbqOjxRA5MujLEiqGrOnsRlJ9vv
         5sYQ==
X-Gm-Message-State: AOAM530euun3G+ePN8nuuiqCstgkpEoT1uMIRwlv8iToM1YQQepAFtEy
        KtX3At/9TsVEgBcm34ZUJLcaMg==
X-Google-Smtp-Source: ABdhPJzy4PN1v9Ym56RqiLYKvfIGSfRqZ6U0AFJo4Ax8JsSXHMSyO+uLmPwv+PMfAgagxvT0qsNs+g==
X-Received: by 2002:a92:ca0c:: with SMTP id j12mr1599235ils.176.1644309861600;
        Tue, 08 Feb 2022 00:44:21 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
        by smtp.gmail.com with ESMTPSA id c13sm3355533ilr.55.2022.02.08.00.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:44:21 -0800 (PST)
Date:   Tue, 8 Feb 2022 01:44:16 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 12/12] mm: multigenerational LRU: documentation
Message-ID: <YgItYKpxJRRQj3RD@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-13-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208081902.3550911-13-yuzhao@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:19:02AM -0700, Yu Zhao wrote:
> Add a design doc and an admin guide.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> ---
>  Documentation/admin-guide/mm/index.rst        |   1 +
>  Documentation/admin-guide/mm/multigen_lru.rst | 121 ++++++++++++++
>  Documentation/vm/index.rst                    |   1 +
>  Documentation/vm/multigen_lru.rst             | 152 ++++++++++++++++++
>  4 files changed, 275 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
>  create mode 100644 Documentation/vm/multigen_lru.rst

Refactored the doc into a separate patch as requested here:
https://lore.kernel.org/linux-mm/Yd73pDkMOMVHhXzu@kernel.org/

Reworked the doc as requested here:
https://lore.kernel.org/linux-mm/YdwKB3SfF7hkB9Xv@kernel.org/

<snipped>
