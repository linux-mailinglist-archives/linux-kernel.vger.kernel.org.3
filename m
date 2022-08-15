Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857D592C96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiHOJIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbiHOJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:08:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EDF21827;
        Mon, 15 Aug 2022 02:08:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 13so5846496plo.12;
        Mon, 15 Aug 2022 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=c6YV89sLzCfE6GiVUft/eb1igCCifwtvh3OftDxp/M4=;
        b=pR+mrvNHK07iKBkK6VYshAHOltu3tNxxDzv9RbKgbEbWjquwfYsYkHOhKUmG72rt7x
         V/kKEjsc7mPZBDvmdgkzX/drCZ12BoCWCNIkgsDnxM5FIPrefx8Hn9oPsV52KVpZeNUH
         KzGgs7WEEPmj+mgiMt9lTs9KAYsyttNAMlJuFNASSgXMdLoIKX2smD+7sA2y75xaRq8U
         si1M999tzKGzW/XXEqN4lwm9bO0d6KB6qCwo697vt2TWKzZ/mKIZ6bVP26zTqpcrnW5T
         wkjDBJ+z9hW87pVHW05kJjcdvphkEn/YZlxvlUDl/a8DqYEeFtgetg44jZQX9OaDr2G1
         CyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=c6YV89sLzCfE6GiVUft/eb1igCCifwtvh3OftDxp/M4=;
        b=o66oMPJPh3chRQov500VpzSDr7d5nKlo/OVbtfRYNuNBuK2JJTmwW3uvlspJvzNpz+
         d5Si+RQG8DTWU6vr2OFv5/aQ/ZMV2WuGFqWcdKdn1PA89Uxl47MWCLRfGjz6/NL/KBRH
         ksfxtzI6bIMWQXX3ZTyo1j2Wrfe+8sxcW+In7Bsqczdm80P0NOQZhrcvxoWtHMiTZGO8
         O2XaLzmd74Lqc0lVEhXYyIoVMR0xDWjdmIyBGDGb5OJDxNIVGp5h2VramN2srJWB4yiJ
         uHIdTTe5lxgwCCc7I+ZoPc5rnQze9chGuwkgATAnQhl2C2QIdgbuOD0pS6IKREVrIZ/L
         wvyQ==
X-Gm-Message-State: ACgBeo35+P5TwPKx8hjqBYDA+Lpp9k+jgLiyd992UZq8AcisJ7Zb+p7w
        urq6EC7ooa0uS0QJBASHAEQ=
X-Google-Smtp-Source: AA6agR6qU/u99YdT68C2E4GPc86lUJPytuIbHi+2sPqXMMCLpbyqQ+XecSHWABVbwgHFsvGNearNGA==
X-Received: by 2002:a17:90a:fb4b:b0:1f3:1cbb:8912 with SMTP id iq11-20020a17090afb4b00b001f31cbb8912mr26922119pjb.239.1660554480499;
        Mon, 15 Aug 2022 02:08:00 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-81.three.co.id. [180.214.233.81])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b0016c9e5f290esm6642204plg.10.2022.08.15.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:08:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7DF81103C03; Mon, 15 Aug 2022 16:07:57 +0700 (WIB)
Date:   Mon, 15 Aug 2022 16:07:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 14/14] mm: multi-gen LRU: design doc
Message-ID: <YvoM7e62p3HpTDcu@debian.me>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-15-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220815071332.627393-15-yuzhao@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 01:13:33AM -0600, Yu Zhao wrote:
> Add a design doc.
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
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>

LGTM to me (no new warnings).

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
