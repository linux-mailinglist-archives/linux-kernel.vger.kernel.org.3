Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1654C44AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiBYMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiBYMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:35:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD84BBAC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:35:18 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3E5A33F1D9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645792511;
        bh=kj5U5fkBa015WRsJi4/ZTy6gKQaYWdbrzOgN/5tyN+w=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DW7t3VhWg5/ugGdWk5K7k3PYP+NDICuEISlkmMLV5nnSMVAGGaqk93IUV3V/q2GIx
         UMGNrketEux8GJQGmiWQSMuobRLn7p4k6MsNiVSp03zwoF6chQZ0/RXtH1p74/xecA
         24pciDaaO7aEChiOu4GSVGxYl5jGwSzDK5t8TqOvDgUlVs8Zpz6ghZ6VZy/mSRKY6I
         IYSS3Knc2Z0XWPXiveZVOj1XqUlfaiP3qiXCOm5/yYajRbYOIr0G//VJDGzAllvdHQ
         WuMjPjLJ8vI8ENg+r0qbMCet9JCmSr8ldD7tyiZlh9teF76hP1qVA7cnpcuwD9l0ZW
         lDYp8xUnH1BFQ==
Received: by mail-ed1-f69.google.com with SMTP id l24-20020a056402231800b00410f19a3103so2276348eda.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kj5U5fkBa015WRsJi4/ZTy6gKQaYWdbrzOgN/5tyN+w=;
        b=GaZ8Qel93rSBOSmYFpBmtWtmJw/wXjGcNIiBM0dmsqVgO4dg1ziBnpmWk3qpNg826B
         Luxm3RcZmf9mXIsHSo6xak7QytW+P612PtvIDWmq5WWn7jakQ5PdEekpe06OiJ8zq33L
         SS8UP2PuHecSfKX52IVu6T02zpEJ85GYFZ2GkF6hWmo7FhCt9VL6s60ccRLCbvubfiot
         uuTAfkr+Rlw1pzHmZmzQghwXNvK9JKvxYJ3elqAeU6UW4AOhO5abGkEfqYEkkVjI/b8f
         rnhwpxaLoq//dvG88fTIGr40WrMdEsjvNgog3cTuNP56XrCWJqp+uz6vOIouDIz/gzX3
         YqEw==
X-Gm-Message-State: AOAM531AWtXKcrLPNKJn2mbp2o5Xhodh2RwHSC3EDky3YsTU49Ua78ab
        mtQsiNH6R10FOeFRg7cvoh9Vw5FMXGkq+RWHy3reR0r9cntNUlswBDGx7b5YIJ/VuTs2l9LB952
        El84jk9MtE7rvzKyFf5dC8aW0E7uw7bQBdYaPifExmw==
X-Received: by 2002:a50:aa8c:0:b0:410:801c:4e2f with SMTP id q12-20020a50aa8c000000b00410801c4e2fmr6808267edc.179.1645792510953;
        Fri, 25 Feb 2022 04:35:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweKXuvfitHJhFWzhqh8DOejFV1J82DLN1fCGJARGMBKSJTL2Hqf4fPS4QpPMtvIeZZX69hRA==
X-Received: by 2002:a50:aa8c:0:b0:410:801c:4e2f with SMTP id q12-20020a50aa8c000000b00410801c4e2fmr6808257edc.179.1645792510798;
        Fri, 25 Feb 2022 04:35:10 -0800 (PST)
Received: from [192.168.0.130] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s2-20020a056402014200b0041285556b7csm1306820edu.72.2022.02.25.04.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 04:35:09 -0800 (PST)
Message-ID: <d108cf41-35cf-4351-3327-1fed3009da1c@canonical.com>
Date:   Fri, 25 Feb 2022 13:35:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] dt-bindings: memory: lpddr2: Adjust revision ID
 property to match lpddr3
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224003421.3440124-1-jwerner@chromium.org>
 <20220224003421.3440124-2-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220224003421.3440124-2-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 01:34, Julius Werner wrote:
> Commit 3539a2 (dt-bindings: memory: lpddr2: Add revision-id properties)

Please run checkpatch on your commits.

Fixed this time.


Best regards,
Krzysztof
