Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB519548055
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbiFMHTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiFMHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:18:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13911ADB0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:18:57 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f65so4799180pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xPA0qTYsardejCLURtUGE/wVHt8uBsPkFyhOmOmAXhQ=;
        b=4rbFoaqayPBu/p+OWmt7iorsXoj7HEvplTxbsxip36BIOteIamhPSUHJ5/yF9AZ9TS
         O5CzVRQXUbZMKkxs4iA9vkqETL9xIpAsPgJYwz6pHASuyREb3vRpkV8vuAlDIlZcFw8F
         V11aGZV1PCLHePU/02bn6pA36MqPhCc6mQKz08/lGsfgI22OiWhB68F41ft4fVcDCg9o
         BYFAdT6LEwPFSDz0dbXk5okIm8/TEfM9/EOuiFytwpRIbT8RqMHzfkthMfvYgxvOhNAE
         VRpKydA1KH+YkzvjrkBeiu0VFUq82JILQM0SWbnN01WG8qJ5e02oZjPceN6WMCYL3RM/
         xxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xPA0qTYsardejCLURtUGE/wVHt8uBsPkFyhOmOmAXhQ=;
        b=eu7bwhIIqJS1wLOtiDKRULwA1tFVW96x8LDIWkNEIkG4P4VinnnpULzkYRSxunTspC
         0/YNSSM9qPpBWvlxE0wuq8wNVkkNQA/Sdzvq9bn9qn8iOk7bfcUSWTSgz9ESCCeEFSlH
         CSSTq7IdhZ2BXXwcEbd83UAayGJOmuit4K3/Cu74yCtEjDmCqJLSIVP/qHYGMfyM9mM7
         CuIFz3cMbtUl9m5+42XkjhlqJaOH6WKIOQrhPK2drqaWO39icdSKyEPf760XYi2SnEcf
         5vn9U6T/b6N0MYPYwbC6CgPkv30cIuv02oHpA8ol+6izK9ENh6XrGklRQdANweicCIkz
         OkBw==
X-Gm-Message-State: AOAM531qFPBcHgruLEmX4LlHkXAh59TOFHFyna85CtpgDA2307HzAAA3
        lFzcu+i0hCyUvBfevsmOybPhBA==
X-Google-Smtp-Source: ABdhPJx1Q4qPyIWkzb42Kjru3kzF8UgorsU4tpVo5cVn5eCPqVpZxvzeYd4Td3JaOC8M/W46C14prg==
X-Received: by 2002:a05:6a00:148f:b0:51c:70f9:b62e with SMTP id v15-20020a056a00148f00b0051c70f9b62emr25834890pfu.84.1655104737201;
        Mon, 13 Jun 2022 00:18:57 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090a654100b001df51dd0c93sm17833387pjs.1.2022.06.13.00.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 00:18:56 -0700 (PDT)
Date:   Mon, 13 Jun 2022 15:18:53 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove unwanted initialization in
 vmemmap_populate_compound_pages()
Message-ID: <Yqbk3c8ifAKnMmMc@FVFYT0MHHV2J.usts.net>
References: <20220612182320.160651-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612182320.160651-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 11:23:20AM -0700, Gautam Menghani wrote:
> Remove unwanted initialization for the variable 'next'. This fixes the
> clang scan warning: Value stored to 'next' during its initialization is 
> never read [deadcode.DeadStores]
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
