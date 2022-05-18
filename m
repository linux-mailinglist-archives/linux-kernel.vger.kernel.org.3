Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804BD52B748
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiERJns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiERJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:43:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F013275A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:42:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e28so1285169wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gQeDrLBWkTthIjKLMPftLueNJFyuc1zAuTQfNmleBh8=;
        b=YhQ42338sEPxyQWIPPpsfEgsH63XcEroBX/csmLaXpqSyPeUunLrRnEL40ild6uR7Y
         xT5zTjkzOyvJ0Z4QqhWop5dD1JqLRXSO95t8pGzTND97qGEJwifuOdsd95tC9ywkKuke
         wYRtuWIdZ87VUjWjIEqGrBIYUwpUVjaCXK43kO7LpeBjHfWykkXXm9vGN0s+C+3DtjZ5
         7qhGx9xI05dhgde69gPCMuxlgGSjkudx5ygNe7/YKjWeBuPQ2zLR+Gbe8vYWrZ+Q5SfP
         ReECSngKQ9+d59vSspRrH3xG5U7AFDZhF/KiJkAxdJX3AT9ByRAedLsUuImFHqfPkH3r
         4acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gQeDrLBWkTthIjKLMPftLueNJFyuc1zAuTQfNmleBh8=;
        b=sDvbwpBQGnc1u92qb9KD37wvvgFj0vsM49cfbQ+BKMOvMWTWg39Jvq5AC+2DzRHfUp
         cbXWWY108Sgf7fGsg8YWipdO8mHNtN8pHxvadXXqxlDTPbENGjA32NvPF1oYp89Gq7wg
         gp65+n8QKEVbeg1FWfA1oY9Z3b0rAS7sVLXiDUe57fRnlCZ8Km58uVuhUddgNogHCNmB
         D3oCEC2rW75ZpboPnqBT+SQIQNQDNlOS+Skd/gjlk17mhWkpml4dpVC5/6riCdbQzszg
         IzDAKDGeN2UL77PNGG+ADGykeMwOG31PW85FbxXV10pQdRZ4zSaPoaAggYEXUu84WiuJ
         loyQ==
X-Gm-Message-State: AOAM5307QxExJeRTAYgB+xfrWdLYoehQxez06Zq9qAgTZOXA4HKYv1WV
        yljdrEr+TzGi+EKLhsfmvd0vFA==
X-Google-Smtp-Source: ABdhPJx+qYdbNUGfgI+n6Dl/d8Yo4rdszaJhtt5MqE1x5NeYcp7yxPz7hQTDzoYkS0z1LmOVy4cTyg==
X-Received: by 2002:a5d:6041:0:b0:20d:8e4:7bb8 with SMTP id j1-20020a5d6041000000b0020d08e47bb8mr11908908wrt.652.1652866964698;
        Wed, 18 May 2022 02:42:44 -0700 (PDT)
Received: from localhost ([193.117.214.243])
        by smtp.gmail.com with ESMTPSA id y21-20020a7bcd95000000b0039489e1bbd6sm3808025wmj.47.2022.05.18.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 02:42:44 -0700 (PDT)
Date:   Wed, 18 May 2022 10:42:43 +0100
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        dietmar.eggemann@arm.com, sudeep.holla@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH v2 1/5] ACPI: CPPC: Check _OSC for flexible address space
Message-ID: <20220518094243.6oxbdmf226jvqoef@viresh-thinkpad>
References: <20220518090901.2724518-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518090901.2724518-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-22, 11:08, Pierre Gondois wrote:
> ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
>   Starting with ACPI Specification 6.2, all _CPC registers can be in
>   PCC, System Memory, System IO, or Functional Fixed Hardware address
>   spaces. OSPM support for this more flexible register space scheme is
>   indicated by the “Flexible Address Space for CPPC Registers” _OSC bit
> 
> Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
> - PCC or Functional Fixed Hardware address space if defined
> - SystemMemory address space (NULL register) if not defined
> 
> Add the corresponding _OSC bit and check it when parsing _CPC objects.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/bus.c       | 18 ++++++++++++++++++
>  drivers/acpi/cppc_acpi.c |  9 +++++++++
>  include/linux/acpi.h     |  2 ++
>  3 files changed, 29 insertions(+)

It would be much useful to get a cover letter for this series with
what you have changed since the previous version. It is almost
impossible to find that out otherwise.

-- 
viresh
