Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A40477029
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhLPL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhLPL0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:26:40 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B762C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:26:40 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso1461074wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/iZFXBIyAByjsB3GJFOohpxukrwP21FfjWMfhDCvudw=;
        b=HIFde9vm8ylWeo3wONyehTRk81AyUekFbi0/8yqHcpmod9HnZdEpAT/FBJji59SFX8
         5e5GEUQIRNkhnazvrypRzsK+RAOoeiQYmhp+ZiYTpV6w0LIr1Gcs3NeFUMauAIoclYzv
         deXwqUJdxLOXuo37MFxpUrmTvJPXXTDL0fZgUCsuH65oYC86R7pgwBYiPjFO6Y9gw8eI
         9y5cgTai9OwH3lIO6k/EF/2XTRAmgcmilhvufm946Kc6Fasc5pFO2BvILQg8+S0qdzqg
         dt1J8hEqCz4JyKOrCeWbn3lBgdW3asfPdLB21m5bzScu4ne46qzh+tnIFaVLsSUyUh6X
         HPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/iZFXBIyAByjsB3GJFOohpxukrwP21FfjWMfhDCvudw=;
        b=NrpBS//6p/b146PSwQD5kB+WAGK53IEk9e17fKceUtpEvWDx45j6MC8/TWEqfxCh02
         rmrpPVwJrn+kiuv36Cs9DbLE8etEcVTlrSTYpQ5DL5+lT2hbfeD0DbhQZwmBBh4FPmVe
         PGj1itmzKSiCkTQG5DmKM9qD9lGT7Okwd+YSk0JNeovKodZGgwRwI4UYAoGtc0wFuCNq
         mZbLojGTVbFkpGnfNIQN42aNrjUvNBP2ZBrsADtYrjOI0Qc5tvBzTzRi88R5X2miuE1O
         zmZWwk7ThftL3fPCuIiRX9O8gONAiX3E62YANRHCEa4NtgjJdTXQLU/fIBSpD45GPLFo
         wvMA==
X-Gm-Message-State: AOAM5323L4FxKTOouGTQ12Z+YrJ4OND+sQV2maHY8wiOXsPLEXjHHMYs
        LKYU9EyqzgiSzXwcgLXBq9X0pA==
X-Google-Smtp-Source: ABdhPJyEEeE1TqtnVLg81N0gyic0nRs4xMnRuM+qr9PJEpB2NxSYCH941BHZDvSdtA4etPTPyi7APg==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr4589806wmb.174.1639653998664;
        Thu, 16 Dec 2021 03:26:38 -0800 (PST)
Received: from localhost ([2a02:8070:41c8:c700:3d3f:77af:d3f0:b7f0])
        by smtp.gmail.com with ESMTPSA id l26sm1510161wrz.44.2021.12.16.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:26:38 -0800 (PST)
Date:   Thu, 16 Dec 2021 12:26:36 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/memcg: Use struct_size() helper in kzalloc()
Message-ID: <YbsibBdUFhWGzojj@cmpxchg.org>
References: <20211216022024.127375-1-wangweiyang2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216022024.127375-1-wangweiyang2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:20:24AM +0800, Wang Weiyang wrote:
> Make use of the struct_size() helper instead of an open-coded version, in
> order to avoid any potential type mistakes or integer overflows that, in
> the worst scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
