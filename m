Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECC04CC748
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiCCUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiCCUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:49:15 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A63C4B1;
        Thu,  3 Mar 2022 12:48:29 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id gb21so5671521pjb.5;
        Thu, 03 Mar 2022 12:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W427vGVOP9COvIncLQi5lkNxw4mE4Ce/dWUY7QiH0Xg=;
        b=EXXEnNfottz8Z1Qrv11P9yiQgtbmEr+FfoBTpyP12pGZHDbxc19LEj0Q3tS9wRli+g
         5Crmf1LVbz4LCGTUUE3Sj9OwhWu8WWFQwEDJkmw0EGDoLWQh+zbewakjQe2xy72vlsmE
         DxekIdZeOMDzRJ6sb5Zkb1gUTBdw2y8gtIplVBYDwcYxqWgNDNkLjow2wBcEGJphomoD
         AoO5LOXzdHc1iKP2sGmwI31ei4CZxNWUgco6L9mRVZxvenW1WaBlRoyqz0hjz1TJzn98
         ko39dXZUSulVHdTPpKiG0wQ0LUmgplUraMlZuF/0uodSUunTPLHQY8PpFgTdBNwwAS7d
         GJ2g==
X-Gm-Message-State: AOAM530p0YoZPvMwdWIeF9HmMltMQc2uh/Q3k21wKg0XdTSgFt5yvshf
        XA25CMm0BnQyAClfi+FIDxY=
X-Google-Smtp-Source: ABdhPJxfF/clBtd6VN69ha8tFxwXtqt3Q8ovp5PNA9jYR15BiWZSha6oKrI3dpXe9dRFfVNKHE22iA==
X-Received: by 2002:a17:90b:789:b0:1bc:293c:1445 with SMTP id l9-20020a17090b078900b001bc293c1445mr7232867pjz.111.1646340509303;
        Thu, 03 Mar 2022 12:48:29 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id lx7-20020a17090b4b0700b001b7d5b6d10asm2782399pjb.48.2022.03.03.12.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 12:48:28 -0800 (PST)
Message-ID: <52af105a-8b89-518f-7663-84163788f66b@acm.org>
Date:   Thu, 3 Mar 2022 12:48:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv4 4/8] linux/kernel: introduce lower_48_bits function
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-5-kbusch@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220303201312.3255347-5-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 12:13, Keith Busch wrote:
> Recent data integrity field enhancements allow reference tags to be up
> to 48 bits. Introduce an inline helper function since this will be a
> repeated operation.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
