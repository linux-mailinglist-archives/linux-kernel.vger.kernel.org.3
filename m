Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE654D7969
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiCNClk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiCNCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:41:30 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB2E205E0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:40:21 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s207so15899283oie.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=KRSZ9fAkZ9+khL23FiwcGxPfmyeYInX7tr5JzmTG8U8=;
        b=MsndYsoWrluuiKeCV3DQYcLlvem6pDqTGbAppvwE9u8DlhBWcGPN0rCo5SdVFtvySW
         Ek8+Dp/d70wInRnoZuOUGgaraSoEUHbIFaxdGgH+0d980KgQ42KGxlYGC8t2gEGUFIKF
         frDl4WhWKdZ7V4Fe8JORLglkoCOH7vgLTmXEDbkDaKb1JcSYmBk8bednIlfagc8rmqAR
         DL01bDnpMWinrsTyhuU+9q0OA6JKgiyXAHiEwxLgjV+gOJXDNbNYgwgyTweYYfdlTXPg
         PW7X9kgyLlfvOpD9djf5Y2mpbEQQ12xSrWjsCkzn57GmORZ3Xy8f6Z/ivwgbHxIqul0U
         IwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=KRSZ9fAkZ9+khL23FiwcGxPfmyeYInX7tr5JzmTG8U8=;
        b=QTGxtOS3c0fPaTIZVG9M8wg9DFJNxIAx30FdTJD+eu/mTdJ92+3tKdt14/H4XSxrgZ
         cFtFpPHoAqUnlzATP9tSnW0jLfUXhkkft2DiqNZN6pgxPDhOO6Cue0obMzx2uHodsyAH
         PdTXFpz3CBbykNacfYC7O6JZb6/vykCt3xiT2Noj3heWqft8OPaan7DYh9EXgfiWjlN7
         kKFarHOOREax45mo70ECkghSKW9+nAPJ9Ail2O6443gi2agZb8FZqF+/gKa1hFrwrZEx
         yMkyjGd0YMxOsyWlqxaQXPlYIgLf+xEbliGPt0bgsyzd4Cif3Mq4wHR0FjctfeA5Mf27
         1QfA==
X-Gm-Message-State: AOAM531gDr9clR+xiLcfzci0XwsOPfQebbQkuDtwvKVo9IMm6X10KNac
        iXHAZ1J1MFg22W9bb+bgYa4FLYyeSdak0g==
X-Google-Smtp-Source: ABdhPJygtiUvnnpLH2CXHwWsVzHmAOm+dLzcz6lIHCweHCHqGdezh44LTVMNucUyHdzrF8/JtdXlcQ==
X-Received: by 2002:a05:6808:2189:b0:2da:b59:3acb with SMTP id be9-20020a056808218900b002da0b593acbmr19899022oib.112.1647225620516;
        Sun, 13 Mar 2022 19:40:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d710b000000b005af4ceeaac1sm6905945otj.37.2022.03.13.19.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 19:40:19 -0700 (PDT)
Date:   Sun, 13 Mar 2022 19:40:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, Herbert.van.den.Bergh@oracle.com,
        chris.mason@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mlock: fix potential imbalanced rlimit ucounts
 adjustment
In-Reply-To: <20220310132417.41189-1-linmiaohe@huawei.com>
Message-ID: <268b3146-2963-15b6-6d6-95a96853314@google.com>
References: <20220310132417.41189-1-linmiaohe@huawei.com>
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

On Thu, 10 Mar 2022, Miaohe Lin wrote:

> user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
> the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
> this by resetting allowed to 0.
> 
> Fixes: 5ed44a401ddf ("do not limit locked memory when RLIMIT_MEMLOCK is RLIM_INFINITY")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

NAK.  user_shm_lock() remembers to declare "int allowed = 0" on entry.

> ---
>  mm/mlock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 29372c0eebe5..efd2dd2943de 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
>  	}
>  	if (!get_ucounts(ucounts)) {
>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
> +		allowed = 0;
>  		goto out;
>  	}
>  	allowed = 1;
> -- 
> 2.23.0
> 
> 
> 
