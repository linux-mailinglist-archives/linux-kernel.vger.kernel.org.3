Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE8552BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346883AbiFUHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346857AbiFUHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:20:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1322509
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:19:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d19so14353778lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5BtOB1xQhN3Ha4LlKucv6D1ctcTjHBCQ1Tbc7a6of4E=;
        b=TKmlBWKSf8Jf8np6blHHUe6nVaX0uPVSfRFhasrZwmd39FDSNZl4XaFeCsICHLe4pe
         3iOJppArYeaDr2n/QMIizqb+wkXnDzvlBOu764SDa08phIvvR0BisPlPrIGCXIVdWjaF
         9hJOf3de+mMSi/wW2M72YQSCDX6/H5o3mF1TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5BtOB1xQhN3Ha4LlKucv6D1ctcTjHBCQ1Tbc7a6of4E=;
        b=JC+rh/vWz4Uehtgu4BU9HIZ0bSBVszfXLOiIiAdx8NGULiBShZHg2602OXP8eoJbDe
         J1rhIYvkkRmWIAUAWvH1eAm3ukBx3vibToenXbkIkFqNsEzqW9hC2Xs5erbv4OAJLgEG
         JoDOvQvj4Vu1ecjgLNl4TUDw2vs8yv3tmJUsLce0Yq3Zt8ArYKXh721zfvecRObrJBa2
         eM56IJ2Xx/JvPEWW7nEIQDWuEIiBfsMzwRQ4RoyHcg8NXQ0FDXbCfH96HFiODow0w7+/
         HLTJstRGdmp2oZRV8y96JGKH2ZFbtGEIRiLevA9+CdgXI0yzTBUhN835XqCdPvgW+sKb
         Hcng==
X-Gm-Message-State: AJIora/tFFsRVwENe0iTeMdYqmWcaTO3bTquxiyxloct8ZKQBXxnsBRQ
        KYFhRMcP+gS0jzlQTi0rZuw7+A==
X-Google-Smtp-Source: AGRyM1t8lAzm2G9gBIAvQgEqwiF6CQ9GPFlZ198nRDR3H852J1Ff4TQnDKakZTc6DG+MeGM/mzTzAg==
X-Received: by 2002:a2e:99c5:0:b0:255:7dc1:3b1 with SMTP id l5-20020a2e99c5000000b002557dc103b1mr13775416ljj.277.1655795998108;
        Tue, 21 Jun 2022 00:19:58 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 13-20020ac25f4d000000b0047f4291a10esm2062922lfz.163.2022.06.21.00.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:19:57 -0700 (PDT)
Message-ID: <ef7276bd-c5ce-af98-bd49-051e24528426@rasmusvillemoes.dk>
Date:   Tue, 21 Jun 2022 09:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 13/34] test_printf: Drop requirement that sprintf not
 write past nul
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-14-kent.overstreet@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220620004233.3805-14-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 02.42, Kent Overstreet wrote:
> The current test code checks that sprintf never writes past the
> terminating nul. This is a rather strange requirement, completely
> separate from writing past the end of the buffer, which of course we
> can't do

And which of course you don't check anymore. So any statement about "all
tests passing after these patches" is not worth much.

So NAK in this form, but perhaps if/when my year-old patch gets picked
up (or you could include it in the series) we can talk about eliminating
the check for past-nul-before-end-of-buffer writes.

Rasmus
