Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F564D4186
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbiCJHIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbiCJHHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:07:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EF1301A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:06:52 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 683F03F2FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646896005;
        bh=pjDcjqvWwdimhut7heTvSMtYMfEdm4Tu45ZKmgOV7iM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=RhVTvH9KLD/Y+x7KXSDvVQh4vO7NPStI2ontMyWFhAHBLk0YasV1ihwz8LomKoeJ9
         n5RNCcbej8MIrr/CXDdPPC2FolOAw4szhrYWjL4+8rzD7G110lgMvwfn80YSW45TS0
         KIGAPPiCuOdovneWDNUYRv3GmlN3/XaqEUNH5pLJCioi2TrX7QqNLlDYyLHftMdRdo
         +2w0WDW/LNZfDkZOLZf2lWlML7Q4OYI2U1BeAKotr1X1L1G0t+AAiJQA18yu79rvd4
         2hoTqNObqVG9z9kIT86AUWTIU75MAcnfZm8+43nsgQX9j3Tvxnjsc1j7MlKwj/cMqC
         l9mWBvhsjM1Uw==
Received: by mail-ej1-f72.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so2607116ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pjDcjqvWwdimhut7heTvSMtYMfEdm4Tu45ZKmgOV7iM=;
        b=w+uDSYS6hoyST1T3gV9brx/vipykX3TszXEhmcfWCRLYFkrpFmRlJ9Rk9TIeOg3WTL
         nRB97fvIwlm1bKykcSEN+Bn5tiWqXD/mcR7LddilyGcwhxfcYpBrUY948g1Yrc+lwsiy
         K6jeQQwjAAczi3dqX+CGi0KI5XyrhaMZz3JVv7bDSR2TTg05l2R6qFf310x2Prz6rF0J
         xkCcyKE8MvW71TtrADgcJz+gH5IEGb8dYO4fje2YzHEvAbj5n7kvrq/GQQT3uo9sj6zI
         NM1XTZ5QFjAeACgCimsqexjmMZtVZKLTi9Nyu0rrlZQhqV7zFBGsSezt577cVAYyHBWz
         Yj7w==
X-Gm-Message-State: AOAM532co0LrG+zcaQ9TUBYvZ4zqVS9Twn9KvKpSpSLQBH+C5+dAQRdQ
        VsQoq01z2zOvjDqDMjo8X0SROSFW6ebplrJ0w8DsjsQMy58Y4tfwLIt7F0W6N+Wgw9V6lZ59C6A
        1JZkJ/o61N+ngYDvbSuNWkcnxGvvCJRVI+IYvrLjNOA==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr2975156eds.100.1646896003288;
        Wed, 09 Mar 2022 23:06:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYlrNfPdQVnGvzey4MCLdIxRsL5wg+KaBPH40tvaqpWz00KbkDX2/VWP4tuc0tLXFyHzkXtA==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr2975146eds.100.1646896003137;
        Wed, 09 Mar 2022 23:06:43 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm1482181ejt.108.2022.03.09.23.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 23:06:42 -0800 (PST)
Message-ID: <4cd1b54c-f51a-b013-2683-533e4ea31f76@canonical.com>
Date:   Thu, 10 Mar 2022 08:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] Add support for artpec8 to samsung tmu
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220310013140.127026-1-hypmean.kim@samsung.com>
 <CGME20220310013127epcas3p3f1b7ab9549b1d6d9da65c73adda5c514@epcms2p6>
 <20220310015302epcms2p6ba3fd122f7ebfb9121924109a85801d2@epcms2p6>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310015302epcms2p6ba3fd122f7ebfb9121924109a85801d2@epcms2p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 02:53, Sang Min Kim wrote:
> These patches are to add thermal management uint to artpec8 SoC.
> 
> The tmu of artpec8 is derived from the tmu of exynos, but it includes settings
> 
> specialized for artpec8 SoC, such as supporting multiple remote sensors.
> 

Do not send emails in HTML. The patchset was partially rejected by
mailing list, so you need to resend.


Best regards,
Krzysztof
