Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE665246F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351020AbiELH2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351073AbiELH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:28:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB513FA0F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:28:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so5279780pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qL4PQ9qn9lMBINssvVeNkH0tYWr93CxXJds6Yc5S7R4=;
        b=JI45+O6JYosov4MpvPi9i0QIUkiQvfOTh3ojcwBbNZLO4wxg72RmNAoj7e392HhBtT
         s7WQXRZ8b70gIFTB0AqEMqZMMmxwQ5tMDDnvbHPbB0bEVWGvRwGOwj9wDoglgATJENyO
         vjT7zNgJRUdUXssiXbXVvRgklU5Svtf1hveyWKOIJpsJ8qgZ7x0M7kWtUnh94YLI3k3a
         GmHaF+dE9/gX3em7Rz1zrK81/YpMSGjoWdBjugJaWXbLXagIj9OBVLDE4hyyKWmZ7WWh
         XYHaMYW7hHMk5fTKqAT6ue/8PomkI3wTJVU+JQnqoRFWeG6egwUEpppxMoTydhqFv8pr
         zh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qL4PQ9qn9lMBINssvVeNkH0tYWr93CxXJds6Yc5S7R4=;
        b=rVsyNT2dAo3Yf90MTCUYPChx9gfgcDTmfU7lKMkaTJzpOAtJNmT8WEJPCf4p0hZC5Y
         41pKxsa0RGMLRR7DJl6UygxNhEQkDfaK5BvX+kbrHtinpB+IHx1vyZiRY/wbc7dT8rA+
         5XL0dQ368+msh4koZ12AELEXh6BJNkcZuiOyiswg43028INbxu3LTAyVX37WA6KkMRIj
         oqOk7sIdwUAO4BwrOWfvMl4M+gMC8punAqKIbW0JUkxqQ8tI2S4hgBjLTXIIWj1dp5cD
         9ZtQ5SBqzumYQoCh01Ssz84XOx3Y2zzoZ7GZVAnamuecaqlj3pycbtxdfIcA/FPUobaY
         I9cQ==
X-Gm-Message-State: AOAM532xU2+mtd+pUhO/5+Ln7UUvEwViLOjT0CA8CFHQDfMv5tCvgx1W
        vUzcGnloLe89YibY4jIEpM3kpg==
X-Google-Smtp-Source: ABdhPJxdedzyCXvhh167lQ0t8fbpoDGXVUGoB2Y2eie9T0L5lwaKBowjgWb8svo60AecZmAdrXVRlA==
X-Received: by 2002:a17:903:4111:b0:15f:3eb3:9666 with SMTP id r17-20020a170903411100b0015f3eb39666mr3507440pld.29.1652340492242;
        Thu, 12 May 2022 00:28:12 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090add4500b001d92e2e5694sm1199945pjv.1.2022.05.12.00.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:28:11 -0700 (PDT)
Date:   Thu, 12 May 2022 12:58:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] cpufreq: Split cpufreq_offline()
Message-ID: <20220512072809.aztba67eummh2amf@vireshk-i7>
References: <5585781.DvuYhMxLoT@kreacher>
 <2258373.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2258373.ElGaqSPkdT@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-22, 17:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Split the "core" part running under the policy rwsem out of
> cpufreq_offline() to allow the locking in cpufreq_remove_dev() to be
> rearranged more easily.
> 
> As a side-effect this eliminates the unlock label that's not needed
> any more.
> 
> No expected functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
