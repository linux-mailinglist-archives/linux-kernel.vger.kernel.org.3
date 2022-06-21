Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45BC552ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbiFUGL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiFUGL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:11:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46015728
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:11:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w20so20591822lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/eWGanGXRvTxAEKEXyRihaY2pmewsuWfoiE7kWqZzJ0=;
        b=WVwPcq7Xs7ZNJvmdOwoL0VOQi8Mil0u7MwlIhaIoQcbaiMQUIm4+G94MZmxriqIY4j
         sV2HKZzyRbS6wVzIVm7eo1QgVhFOcaQyIx2eK+lNIVFRXHFowBHbJhOh1XLGsQIjRYEv
         KW2fQu5F2EqkKsoLxCiuG4vmvj3cnNFXD9yps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/eWGanGXRvTxAEKEXyRihaY2pmewsuWfoiE7kWqZzJ0=;
        b=nu0R4KN49urPjj7yYCrEFFSisQeEWQ0hfMyF28bt+oCIceDhfpXhju9H6v4ZTHtVrZ
         IXoi/fbv3Pe44B8Y49XF3MAUlnKGFvOiVeHZNoWnb17+yk8xA6/9+YsOba+LtQZxjLiG
         HWolFFul+JVgwfEvp0f2qQct3e9JOWqC6MmZfuGWu7PvsoTG6EAXFHwwJJ4wm8kmuaCq
         PJt5lyqSYyIZcb4NVrEZoX5kOgyZ6ojriuqyiUR+PguJC/bnEWJN9yY3NVcSCSnFyC9N
         TKaO4h9KNHTZoOqrYgGt8pWP2yQoIGTmpA3ynNBD/yq/h8Xh+rLS+E6/MGl3JwFfpulK
         SWjQ==
X-Gm-Message-State: AJIora9Nugobw1o/pVM2ABuAhUVC7Pi2OxU1zL6W48DZTZ5GBT07Sz2b
        vkJIgV6fg3Y346hKPQyscepd+w==
X-Google-Smtp-Source: AGRyM1tWCSbAFWcWkf2MV6dy2EN4XakvOogG8V/zDwtSKUO4DFfYU461zGuKRDDUF8c74V6lnOxmJw==
X-Received: by 2002:a05:6512:1307:b0:47f:67ab:4064 with SMTP id x7-20020a056512130700b0047f67ab4064mr6958436lfu.106.1655791912587;
        Mon, 20 Jun 2022 23:11:52 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z16-20020a056512371000b0047255d21173sm2042889lfr.162.2022.06.20.23.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 23:11:51 -0700 (PDT)
Message-ID: <46fcdf08-4646-afa0-c112-76d9335adb6c@rasmusvillemoes.dk>
Date:   Tue, 21 Jun 2022 08:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
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

On 20/06/2022 02.41, Kent Overstreet wrote:

>   Rasmus pointed out that -fno-strict-aliasing is going to cause gcc to generate
>   nasty code, and indeed it unfortunately does but according to worst case
>   scenario microbenchmarks it's not a problem for actual performance. 

Well, that's not how I interpreted those numbers, but, except if they
showed an improvement, how much is acceptable is of course always a
matter of judgment.

However, what's really annoying and somewhat dishonest is that you're
not including those numbers, nor the methodology, in either the cover
letter or commit itself.

Rasmus
