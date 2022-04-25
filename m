Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D333050E959
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244889AbiDYTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiDYTUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:20:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBF992D3A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:17:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p6so794254pjm.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dBJVxT2oQQKuTmNqO746HArxprk0i5OOxyDSI22NCDM=;
        b=S5hCr2r8dSdLX7LojMvfZCiuELMGIzpE16tCfuLV+niqkLCNloOVHl8rfWXGxMz/RX
         /uJQeo3CdHZHmOYvDrf9U5VYZnpMd7Se8qzctwcUB8msXmPxwTbqS17Yzb+bEAQGjEui
         nhFVrlENVGbWGTP0Uo26WNZiuKvHpMPJ+Z/wI0KMOLtzXP16rklqjH5mGGPu19luqczc
         QadckueHU9DRU+yH4VNbE8IMBAogntAzhSJXQJPtEJbL8SFmZ9ypBs99Rebm9dPjIFBY
         7Q/4tAe0VsPh34z+ZAK0xYHwGSJjNzVpvc3PF3dKhIZLj+0Rpv858GdIDBAb/kNvM/wK
         nUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=dBJVxT2oQQKuTmNqO746HArxprk0i5OOxyDSI22NCDM=;
        b=zVlJn61oPGrAaYwWLtSFoN1LbEseHAFGMM0ZgrqPVNsQ/xAczp3n9LygP/93ombbP9
         lIBeKhJ0Sy+gDmLTGATLo2FI0swSs6kTp6OyjO2WX6ptpSDddwCOnxMdCRSAJ3nmsfkt
         TWeNsr4pgTjqcrymJAl8Sukwd7evkGYjcObhgDvzndJlILlmroI1AxxOCzZYajoaYvFu
         TiSt4jljitsul5YzbsfRVnBVEvN2WjPjfdaUTllKB2hmd3fe9CoZ27ojgQXDoKD19++A
         6LtmfeVsXnx2Y2NIvDgNUI4sOvfET+fMaubzUuiUaDaHxjt3OfI6qUFfsp3Eeggd/PpU
         y2Og==
X-Gm-Message-State: AOAM530/EB8ZV+puP2MXh+PtyP4zVONjiJ5g5BQcrZMTs4WcpYvzPNlB
        GnOhJgn1S8ecqbxsQJvR/KiOVw==
X-Google-Smtp-Source: ABdhPJwegg1ZVtvJWdZISaAZfuEHL2yovHoZcVRerWAaWqJBC8aaKMs8ZIcNrjgGbuQO8/Cx9M0MIQ==
X-Received: by 2002:a17:902:d545:b0:15d:4a7:d3c1 with SMTP id z5-20020a170902d54500b0015d04a7d3c1mr8631515plf.52.1650914260912;
        Mon, 25 Apr 2022 12:17:40 -0700 (PDT)
Received: from [2620:15c:29:204:185b:8dcc:84d4:fb71] ([2620:15c:29:204:185b:8dcc:84d4:fb71])
        by smtp.gmail.com with ESMTPSA id 130-20020a621488000000b00505e6092973sm11814391pfu.68.2022.04.25.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:17:40 -0700 (PDT)
Date:   Mon, 25 Apr 2022 12:17:39 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 2/4] selftests: cgroup: return -errno from
 cg_read()/cg_write() on failure
In-Reply-To: <20220425190040.2475377-3-yosryahmed@google.com>
Message-ID: <f089fcc2-68d6-2b5a-6d29-f492d6414cf@google.com>
References: <20220425190040.2475377-1-yosryahmed@google.com> <20220425190040.2475377-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022, Yosry Ahmed wrote:

> Currently, cg_read()/cg_write() returns 0 on success and -1 on failure.
> Modify them to return the -errno on failure.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Acked-by: David Rientjes <rientjes@google.com>
