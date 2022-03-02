Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A034CAEC0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiCBTci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbiCBTce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:32:34 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60750D64FA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:31:51 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so3083116oos.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=0LF1wYKgHjGezYmNOW2QKX7lPQ0zB+QPf5su1bUaiQI=;
        b=dHUN7IUYd5ZKWsU6tvYnSadpSOPeeS4Ah84ibEIrlidRvozYI0kzmW45Bj63WhCJm6
         wN2VyOhRY64li/FXVFny9db5k/YHZR5vLJz35QXV1BuyrGtA+0BsysroIa4cUGRQ7GIv
         6rqiTwhkIt3gwF9PqbWfKXf09QfLDYEjYMoXgMTurIP9Fm6iRNoj3KcaUv4cspf2rTie
         AcxY0FfuqhTKcpxU05NCpqwfwBqXRaXrr+FTNHx7sQRpZKyfqYOkK0T0jYyQ3FhJG5Um
         tg22kzO3qJ0uFMyin92iIm6ucQI1oGM0k7SI6VKyUbQqEqjy8+1wnt0UfxI0dfoaadi7
         Rong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=0LF1wYKgHjGezYmNOW2QKX7lPQ0zB+QPf5su1bUaiQI=;
        b=57UVPGCF4XU6BXSHvrm+qHFMuothwU79SpgT/7CqqAcmEGF/u+VMZGtMDEXQcCDDTp
         Q4kT8v1ldo/ayEkM8xYwYbtEainKiX3SF3sdfMiCA4SjZAAejMzJyV7SSTCI/F6z5/GQ
         KOZ9TQBnibJUQLh+njuQT/JbxYgBac0lwRGOYx69ELsRhSjOmisjIFU6R0y/z9r224mm
         IbUiqccQXGC6oepB4M0wrd96mTzgPHwgbdod8p3a5+SKUEl2hPNobyIWAjXn06y28BbF
         UHnutCIbRqJRYTpYOmi7cnAAgHp4d7smM1RjKJfNyZ0d8XiE84vD2qJRl309N63vTQ3T
         ILwQ==
X-Gm-Message-State: AOAM532K8lBu2k/z99gDzkOKqUWpko3j9Vz3nas9bX20wHj5a0znkPfr
        o800sTH0t/n+vl+npRh6FAP/tQ==
X-Google-Smtp-Source: ABdhPJwIcbIU1qsS/27zriIq/FggmYAL9ikNBq4S6mZN1NZqoaDKIJ1JXVm5UAQ3G+wKESLcAdt20A==
X-Received: by 2002:a05:6870:5825:b0:d6:d4fc:aca0 with SMTP id r37-20020a056870582500b000d6d4fcaca0mr1114065oap.73.1646249510547;
        Wed, 02 Mar 2022 11:31:50 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r9-20020a056870e8c900b000d7133a15b3sm4942149oan.20.2022.03.02.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:31:49 -0800 (PST)
Date:   Wed, 2 Mar 2022 11:31:38 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, cgel.zte@gmail.com,
        naoya.horiguchi@nec.com, mhocko@kernel.org, minchan@kernel.org,
        hannes@cmpxchg.org, rogerq@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guo.ziliang@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH linux-next] mm: swap: get rid of deadloop in swapin
 readahead
In-Reply-To: <20220301163243.33e8fc82e567512e54a78560@linux-foundation.org>
Message-ID: <295e8d2-5bef-195f-88ba-abaebd45118@google.com>
References: <20220221111749.1928222-1-cgel.zte@gmail.com> <20220225172440.ec62edf97b405d32061bcb37@linux-foundation.org> <b2715e40-dc61-1589-de19-ea4c3bd3f674@google.com> <20220301163243.33e8fc82e567512e54a78560@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022, Andrew Morton wrote:
> 
> Using msleep() seems pretty pointless so I plan to go ahead with patch
> as-is, with a cc:stable.  None of it is pretty, but it's better than
> what we have now, yes?

Yes, I've no objection to that.

Hugh
