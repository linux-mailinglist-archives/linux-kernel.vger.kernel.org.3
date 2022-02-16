Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19084B8651
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiBPK6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:58:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiBPK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:58:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55FB2251A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:58:19 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8813B3F328
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645009098;
        bh=APDj2JQowla5VN9wgYQvqEBkeDwB1AQlKi39bfuox6w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fd5QC5V+cESXhKdtBRnGjOxYs20VglPL1pDLyYUP9lm0u8bZeMq4dXrPhHE+OqAmP
         EcPEI4jjAm8HiRnnCDG92wjAPQ14VZQPBeB6t+4C2F4AdQ2vGWH3xb5HiZdL/1kXYo
         d6MCwTp5LWtPBlOgt198cFRZ8Dtlp6fY3iVdeOVZeb1xjxVJj0wTQiV6nzwC+8b579
         AFzRla9L8jwSz4j0fklCcBSq8tHrVqQZQNVjYRpT9nstAQlSlxkiz1ybsO8Y9FbPrP
         +WiKvD1HyukpehHl3aTKNAm2YTAZFjq9/+Y/JMwgO0pZWJpG8mKvH/ADhZBBUMEPA1
         CHkbGU4LsuPIw==
Received: by mail-ej1-f69.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so655251ejk.16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APDj2JQowla5VN9wgYQvqEBkeDwB1AQlKi39bfuox6w=;
        b=qUD0KOKnAavkHBSWslPW5dvPCkW1Cib3KriYYFqM1EgjRrFTj79YXD35fONUBoCTIT
         Tan3qaN0VRuNH1kq6BQyqVqoHAXZoR66NgYieM33ps0atMCqS25izeeNlcRjI7JLvVLV
         TOCc8/DgG0uUYCI1Uq3vsHuxmlQ2kYjv8f3CzAbo3CDk+gR3yD3e8lHZOXSbskRKysVG
         WEDclyL14POyZ3gkybYyGVIfyUBWWsCOqT4n4hYH6ZkY4mS2zfZHwc7OssPvKL4XMR2Y
         sllA6uznJHhA3zQooRXldmMWYAvgmLqMLRh5P0g11TW9AftEGc2BSlEpS5XxEWh332kH
         Gn2A==
X-Gm-Message-State: AOAM532Ie3zhSlhU3uQaAj8PoSNNAS8H0l9WRpVOzGOuT4DrKpoe3CDp
        UjOWxNGDYOUXH9khkCHljOKg79RyowA4f1V/bYheDuJjCQf0a7AaD46hu6/T2bodSDzt1lor06H
        VTo3eEAtmITuTyP7LHyIcNXK0/T7FFikC8c6vJiLYMhyUzsVAp8JatSJIBQ==
X-Received: by 2002:a17:906:d8dc:b0:6cf:d1d1:db25 with SMTP id re28-20020a170906d8dc00b006cfd1d1db25mr1808015ejb.285.1645009098277;
        Wed, 16 Feb 2022 02:58:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5GVqeYDxf8KFG6ucnyHvzLbGYzH9A2TyOYd9tau6dRiSUPrlEWjw70ZXBEh1BoDUDDU1MjaUHZ/lMRXjFl3s=
X-Received: by 2002:a17:906:d8dc:b0:6cf:d1d1:db25 with SMTP id
 re28-20020a170906d8dc00b006cfd1d1db25mr1808003ejb.285.1645009098094; Wed, 16
 Feb 2022 02:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20220216092240.26464-1-mkumard@nvidia.com> <20220216092240.26464-6-mkumard@nvidia.com>
 <2249cf46-5c54-2e59-f247-5a22f2e6e5b9@canonical.com> <DM6PR12MB4435ABC8098A6C3EB2357B47C1359@DM6PR12MB4435.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4435ABC8098A6C3EB2357B47C1359@DM6PR12MB4435.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Wed, 16 Feb 2022 11:58:07 +0100
Message-ID: <CA+Eumj6UU-WqNckYrE8YMJaSVS_E2KFydPs4B-Q=ESiVZw=QDQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: Document Tegra234 HDA support
To:     Mohan Kumar D <mkumard@nvidia.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 11:54, Mohan Kumar D <mkumard@nvidia.com> wrote:
>
> Hi Krzysztof Kozlowski,
> The current order is intentional to reflect the new->old chip, the top entry is newer chip. If needed we can add comment to reflect this info.
>

Hm, okay, such ordering sounds good as well. :)

Thanks!

Best regards,
Krzysztof
