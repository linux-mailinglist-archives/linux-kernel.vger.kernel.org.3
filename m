Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBCA4CC745
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiCCUsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiCCUsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:48:38 -0500
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058162DD5B;
        Thu,  3 Mar 2022 12:47:52 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id s11so5735433pfu.13;
        Thu, 03 Mar 2022 12:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2sMm3zKjFn7LlHJVewiz0XZSHIpv45FgabOoDcCOG2Q=;
        b=zu3/6HqOmiGGB9xKRY2Vvxsx21HiF2W85f5W+NRbHJjVRnci14VqWqaUjQ8IbbMDIU
         SfXUg1FWAEqahxCVKxdCzjA8RPF3wh8ULbLAoX2zE4riZ+O819wUZ7T1erAjr6i8AVtK
         Iscz9L01fkZA+UMUiKOyQypHRq2v9QYRnt229Rv7umJBxq00aWEHxWfK3IV1RLoxazkL
         YAhiMILurs0tT0JILopugGEH/B2S+DT0d68SQKv3T08tNbwiS5Oj5ho6K+TaX7FE33jV
         n0pjgSrsK1iP5kBLm1jpAhIm8qRzFVuzJuZHZq807DDOfp90fgx3pBfm6CsYgFyYDbN7
         97tQ==
X-Gm-Message-State: AOAM531nkmZlLGeA/K+lZ31X7fakOYh7SiqiDeFQV0s+pny90fQI/D/3
        JKprPD6X56HSUOmVSfg2ysI=
X-Google-Smtp-Source: ABdhPJx69LPAUR7oygj04wdfE1hMPOo9j+ay8mVCgE6nTUZhfmcZ0TUOUMGoZwbD8HVR7CUIdnA/+w==
X-Received: by 2002:a63:445c:0:b0:375:9c0c:c360 with SMTP id t28-20020a63445c000000b003759c0cc360mr30120816pgk.588.1646340471388;
        Thu, 03 Mar 2022 12:47:51 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090ad59600b001b7deb42251sm8622898pju.15.2022.03.03.12.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 12:47:50 -0800 (PST)
Message-ID: <c5329139-1680-7170-0dee-7ed4b6ccbd30@acm.org>
Date:   Thu, 3 Mar 2022 12:47:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-4-kbusch@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220303201312.3255347-4-kbusch@kernel.org>
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
> The NVMe protocol extended the data integrity fields with unaligned
> 48-bit reference tags. Provide some helper accessors in
> preparation for these.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
