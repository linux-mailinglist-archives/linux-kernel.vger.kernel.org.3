Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2074F524B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444927AbiDFClt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575956AbiDEXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:09:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13623A5D6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:40:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso3899693pjz.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/v6MKITyj/7SAzMcTXcAwa1zUE4C9+wVBGJFdG8EEDE=;
        b=dMZUydk4BKA2ZeYjg1PSrdz2fBoVyivYvhTiBoIV9Mr2TlcJDNYVyntFb40XA1gQYB
         eM+njiTLhPUe5RcXcs5RnVyiBlIFBeUe6tcbTu83MTGNM4XE375eEkP2Jvw8ohfpY3XM
         kvwgJxX1VtRaQsPeBaN1LozUCYLkXHpchiKzCw/sK1o9GdOvYl1s0hoC61wST+pSs6kn
         DtH1bIaqUuFEmKskIBaWDJOGR8tXtZfKAHe/N5YjK3NqzLbVCjfrxW6mOEAVjc9VuZYt
         WnHG0LZOTnGEDjMHEeK2zQ13LuYSsjHhUUUM30Jj4bqc3YJ7mhAQkGpW1q6F0hgYSCTd
         q9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/v6MKITyj/7SAzMcTXcAwa1zUE4C9+wVBGJFdG8EEDE=;
        b=6A5/azqVUoNPAska/yPGaRnDQv4xyK3jgSgvPxtdWQtM9YrTMvbQBOBfmXNKo2YneB
         7WRYFuInQP3gX0vlJ4wkHCeUk6QtPdOKL5pmSwNo3GkAxm/iUkDJoo9VVzHPJMOukNcP
         g4NkV1gPhe0tbk/u45EGP5JuyjPlWrvpQ0Pm1RkmEeR16Z7s4jd/P4sxgm0tS1RJcsOg
         OQV8veUsblJLNgdNVNYF7bfZ9MeKzQvm5G5+1xu/BAdqdCU3dhcI/wb9tqDCUmJ94kmp
         gMOdt1qrfX08re0rm9rmFZ1oairJYc/P4eznQm2xJCzp4vEvlDrK8b9IAjxfth0tCXpm
         RbtA==
X-Gm-Message-State: AOAM531VCxp8shFS+cIC9W3VX9uAy7lxyjiRAjFH0GQMfioQifIGNtFZ
        iaWaCx5Ca7/27Ta9Uu2emrLezA==
X-Google-Smtp-Source: ABdhPJxJC/R0lJ9hIIlMX047W4yaxdR92GjHCZrTF7CLNQHhTZByKUAE/BPyRg7wZqj8mUY+XULNIg==
X-Received: by 2002:a17:90b:3802:b0:1c6:905c:af2e with SMTP id mq2-20020a17090b380200b001c6905caf2emr6287692pjb.236.1649194822900;
        Tue, 05 Apr 2022 14:40:22 -0700 (PDT)
Received: from [2620:15c:29:204:be3e:5e1c:99cc:513f] ([2620:15c:29:204:be3e:5e1c:99cc:513f])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b004fe3d6c1731sm3693466pfo.175.2022.04.05.14.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:40:22 -0700 (PDT)
Date:   Tue, 5 Apr 2022 14:40:21 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH v3 5/6] mm/slub: sort debugfs output by frequency of
 stack traces
In-Reply-To: <20220404164112.18372-6-vbabka@suse.cz>
Message-ID: <cb22b4b-4ec-90da-6820-f62e431791a@google.com>
References: <20220404164112.18372-1-vbabka@suse.cz> <20220404164112.18372-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022, Vlastimil Babka wrote:

> From: Oliver Glitta <glittao@gmail.com>
> 
> Sort the output of debugfs alloc_traces and free_traces by the frequency
> of allocation/freeing stack traces. Most frequently used stack traces
> will be printed first, e.g. for easier memory leak debugging.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
