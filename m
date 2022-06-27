Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EAC55E330
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiF0OaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiF0OaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:30:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAE8B53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:30:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z21so16910729lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eFEE88CccHR5CkwS+vurL0zrLbEnGdsXJjb2ZKJiUh0=;
        b=JlDAoSXgRYC30V5DWW1Nd3hA7tf0emWM47e+Fbz8ds0PPHa12/9nYfrJ/0oDDYu4/w
         LQ9ju9Mmo1FHbnLcprAf8/1EhhzU/RI9bIO2Fb1XtVyQ62GubZ2Rub2BPE4e7fW4/w96
         y76ZGCOCPXael+3OrQ6Cc/D4KI9VfyjUSAqNXkGgF/OVDp3xoN4/IfOsaVzhSBmQjKpH
         D8642wM3M7f69ZEj+8hCW5AeWzT3VXyM9xF/4PfblDq6txuFWHzG2Bgz8qHDf7GoIl5E
         XCgUyLrxrcK6dzVR9eqTdkZ3v0T5PeIpsnaEsl8EguQWdCYXY2/hpWd/EksRCpURBVv5
         Xgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eFEE88CccHR5CkwS+vurL0zrLbEnGdsXJjb2ZKJiUh0=;
        b=5ljd/v6NoVXaM/DYvB5RKowRpPjGqhBkVqrKYlKdSNYTvccwVYu+8w91udEPIF5jay
         0UQodNYiTYsEZlQ/U1PjWo7zBAb9iA6vNdBpdA9ylqPgU5ScLyjfsvPBJjiJhPOJ/0Q1
         inhqD4BKmQyM6ok/p9NZiX9yXs4imssWvXncDufPBCofY8QqrV0A1JxpdGyhfBfWZRBT
         QyC9Tii3NbHF1Zbva7JzY26S0sgbBxcqAHeP/3Rvxg/yiK//PEueJPsTKmTNujGGTay3
         7yUB3SqjZgnKd+uWRrKd9+z45lIhSFPRpe4wAw0oXrjrUE3ALRBQsLhVYLle7wV831Rm
         n17Q==
X-Gm-Message-State: AJIora8dRqJ1v27Kua3QXgRSVV1tRPyCEJWi4b2AhhEllCbs+mboNT1n
        I3ZyRLmu+MitU9rKnlAJ/og=
X-Google-Smtp-Source: AGRyM1tlgDmoI90ileKuTGzEu97gjy2yQONAwLjp124FI0Hi2sUwTDptZ1dcnH1Ao5NguSNyj8jnnA==
X-Received: by 2002:a05:6512:32c5:b0:481:1822:c41f with SMTP id f5-20020a05651232c500b004811822c41fmr4601636lfg.373.1656340207490;
        Mon, 27 Jun 2022 07:30:07 -0700 (PDT)
Received: from ?IPV6:2a02:6b8:0:107:3e85:844d:5b1d:60a? ([2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by smtp.gmail.com with ESMTPSA id q10-20020a056512210a00b00477a287438csm1837713lfr.2.2022.06.27.07.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:30:06 -0700 (PDT)
Message-ID: <dddd7c7e-3c60-f916-2947-4ee00a765574@gmail.com>
Date:   Mon, 27 Jun 2022 17:30:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mm/kasan: Fix null pointer dereference warning in
 qlink_to_cache()
Content-Language: en-US
To:     Gautam Menghani <gautammenghani201@gmail.com>, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20220626170355.198913-1-gautammenghani201@gmail.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20220626170355.198913-1-gautammenghani201@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/22 20:03, Gautam Menghani wrote:
> The function virt_to_slab() declared in slab.h can return NULL if the
> address does not belong to a slab. This case is not handled in the
> function qlink_to_cache() in the file quarantine.c, which can cause a
> NULL pointer dereference in "virt_to_slab(qlink)->slab_cache". 

qlink is always slab address, so I don't think this patch makes sense.
NAK. 
