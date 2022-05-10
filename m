Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD5520CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiEJEcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbiEJEbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:31:19 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D661D8661
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:22:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b32so11146275ljf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zoEuUNsSlASJkELQDVjOkHOErXZlwArgTvgzzDIC9n0=;
        b=gmW6F2GnDKFqhfw4ydsqrHtImdNG0vq/A9SMKKxqTihVL6+9LHIjjj/Vxi50uf4lGN
         5xVUs3QHYdEsWLGEBkSAE/HPkENUvkywBsUuE69A6thZJVD6JfEjo0IRCGl+bhVzTLnF
         W3cUyJnsn90QYF65Np8+ojp1xyqETEP3nNNXcSLCPK3nG21knJOePFONJTDQRRC1XhWh
         4rYfbw2TkPm4m4TEP2wYE2GVevLcTjDolRQJs4oMOfxm392QMSg7Z+p2lSSWhyRVY9BQ
         UeC6g4gc+k0t/wZtqaesomF2i4O0sHfreOyxeMfaP+YgNYsTLyf5bI4JkqXRmIaT5/r7
         J8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zoEuUNsSlASJkELQDVjOkHOErXZlwArgTvgzzDIC9n0=;
        b=wfzsbevO3LleWHUxh92bqni/4DotN92Etg3pWYjzS+K39XGCBNqhd5LJ82X4EXUlUj
         Ol/Qt7+StdeviXNJcV/Q65lrCNXa+3ErDFSzfXvLTt4T3Afw/8ViLQU960mtlsZyTOv+
         GEp7tnTVesZs0lKfg7j96KH96sn6bJENT1f6pDdgC3oHej1mqNePRiQ4HEX5q64PX16S
         Vfl5Xs9+beRHFYLs/5sKopo+28/5WyxDUHKkNZbQ2usIG+BMIE3OsOng+KUeT9J4SyoZ
         m7+23mxxUMTUIVSu3CPtEsZd8m7YOqe9P6tGyym5DDap2o78OhZNhtdVQxtzuBhQh07W
         eVQw==
X-Gm-Message-State: AOAM531+OLGXjAFplWuWdo6r656B3ed5lQy8bdm04YI0phWCxF1PBc+9
        n3RW67c/k9nQubmq5Zhrycn7Cw==
X-Google-Smtp-Source: ABdhPJzgZQwqVNv2i2+kGeKypm+wWSntUY2fJ5HKKPISPMIFnX7zxN8Vw/4Y93BZbLKxPXbWKEq4Cg==
X-Received: by 2002:a2e:84c8:0:b0:24b:50bb:de7d with SMTP id q8-20020a2e84c8000000b0024b50bbde7dmr12512503ljh.40.1652156523717;
        Mon, 09 May 2022 21:22:03 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id p14-20020a2e9ace000000b0024f3d1daed0sm1775545ljj.88.2022.05.09.21.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 21:22:03 -0700 (PDT)
Message-ID: <6e68298c-7cdd-9984-215e-7e6fb3d03fe8@openvz.org>
Date:   Tue, 10 May 2022 07:22:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu event trace
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@redhat.com>,
        kbuild-all@lists.01.org, Shakeel Butt <shakeelb@google.com>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
References: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
 <202205070420.aAhuqpYk-lkp@intel.com>
 <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
 <20220509170605.2eb7637e@gandalf.local.home>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220509170605.2eb7637e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 00:06, Steven Rostedt wrote:
> I'm curious as to where the gfp_t to unsigned long is happening in the
> macros?

original ___GFP_* flags are usual defines

/* Plain integer GFP bitmasks. Do not use this directly. */
#define ___GFP_DMA              0x01u
#define ___GFP_HIGHMEM          0x02u
#define ___GFP_DMA32            0x04u

... but __GFP_* flags used elsewhere are declared as 'forced to gfp_t'

#define __GFP_DMA       ((__force gfp_t)___GFP_DMA)
#define __GFP_HIGHMEM   ((__force gfp_t)___GFP_HIGHMEM)
#define __GFP_DMA32     ((__force gfp_t)___GFP_DMA32)
...
#define GFP_DMA         __GFP_DMA
#define GFP_DMA32       __GFP_DMA32

... and when  __def_gfpflag_names() traslates them to unsigned long

       {(unsigned long)GFP_DMA,                "GFP_DMA"},             \
       {(unsigned long)__GFP_HIGHMEM,          "__GFP_HIGHMEM"},       \
       {(unsigned long)GFP_DMA32,              "GFP_DMA32"},           \

... it leads to sparse warnings bacuse type gfp_t was declared as 'bitwise'
From mas sparse

       -Wbitwise
              Warn about unsupported operations or type mismatches with
              restricted integer types.

               Sparse supports an extended attribute,
              __attribute__((bitwise)), which creates a new restricted
              integer type from a base integer type, distinct from the
              base integer type and from any other restricted integer
              type not declared in the same declaration or typedef.

             __bitwise is for *unique types* that cannot be mixed with
              other types, and that you'd never want to just use as a
              random integer (the integer 0 is special, though, and gets
              silently accepted iirc - it's kind of like "NULL" for
              pointers). So "gfp_t" or the "safe endianness" types would
              be __bitwise: you can only operate on them by doing
              specific operations that know about *that* particular
              type.

              Sparse issues these warnings by default.

Thank you,
	Vasily Averin
