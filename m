Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E941149C398
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiAZG3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiAZG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:29:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C4C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:29:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so2566700pjy.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=f8frVsVREroL3Vl0pIdy9j6ct69/Sw7kT8s/BIn1OP0=;
        b=gy5tGnViW/Q6q8SpmvwPsZUbEzrCa2iw8BwV+Kr4swwgu1E6FOCgAuJmkdStBznndg
         9cjW4qvwSkTsmGt0KtXmdyu1dCO04aWArje9PMSy/oq7zV2ucYXI9j68aM84xAvGCbTo
         zcsRf1WDSZSv2shyzfX/GGDWkshjlW8hPBNBla4pRVRsz2IhqE8nQrdZnQ1ME5Ce0Jec
         IHy6WYuQCKY3QEZpQMVBC8YfvDpGVxYeRIgK5K/Hih56TRQParsBGng7Lk5mzhpvD06p
         xOpgMwAUDztxP5zUB1GOUNbaS47FqViQysx1Xohj7LbAuCa1xZdVsx2TBS2RcjvePdG8
         hPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=f8frVsVREroL3Vl0pIdy9j6ct69/Sw7kT8s/BIn1OP0=;
        b=RTSwFhhMLQi3hhaRzJaGKg5rZtpfGjSC3jYGJfkZcRY4pTOHuVsTahbO5b3m+Vomf8
         CdTArvEWBJNI3fMuLzGHMTm4AZNHpgVkfA3G9Kg3Y9RzpRfcL5HXv0REtj30FIQvUdC8
         o7iHeJJXz2nRosjY5n3S0wJNAMlP6O16dFVLO33o5ag5I4MinJxJUFWZBCwG00Tpxvb0
         uvJZC+nkXZmoOuAIybPz5GOl/dJ8ITvi905fkFe+WsC3uX82jpOTAI1JLo6gzWrrmzIF
         M5s2ztcwQnHU1Ue6AauwK28Jik+OYFjoRhs69aA/6jWNdqA38nSoYuJv2bYo1muTffPJ
         oqxg==
X-Gm-Message-State: AOAM532xLqEctvjZRXL+ToZs/1ov2udKdHJeAkZZAyzKv6z8WnDwSh3E
        Zy0AuMOMBpphmwFHXetddc1Ern03NG6jgw==
X-Google-Smtp-Source: ABdhPJzY3OgX15h2i/8uaHpXMIoN0rhfEE21wgImuXokndNRSLyyzAsTE9pd6eFD/b/jNH0mn8hjRg==
X-Received: by 2002:a17:902:be18:b0:14a:aef3:af2a with SMTP id r24-20020a170902be1800b0014aaef3af2amr21354312pls.25.1643178587225;
        Tue, 25 Jan 2022 22:29:47 -0800 (PST)
Received: from [2620:15c:29:204:6f7a:fc02:d37c:a8b0] ([2620:15c:29:204:6f7a:fc02:d37c:a8b0])
        by smtp.gmail.com with ESMTPSA id t3sm929149pfg.28.2022.01.25.22.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:29:46 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:29:45 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, will@kernel.org,
        rppt@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v3 2/4] mm/page_table_check: use unsigned long for page
 counters and cleanup
In-Reply-To: <20220126060514.1574935-3-pasha.tatashin@soleen.com>
Message-ID: <3554d255-dc76-c4a1-e2a1-f110f1e2c7b5@google.com>
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com> <20220126060514.1574935-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022, Pasha Tatashin wrote:

> For the consistency, use "unsigned long" for all page counters.
> 
> Also, reduce code duplication by calling
> __page_table_check_*_clear() from __page_table_check_*_set() functions.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Wei Xu <weixugc@google.com>

Acked-by: David Rientjes <rientjes@google.com>
