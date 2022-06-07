Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21953F7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiFGHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiFGHzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D919FCC157
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654588518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCabSttjyR7JTvbvQVMcJUlNQoTjNGH5eBfRKJdu02I=;
        b=XgKqw3AgEN98m1jepgCFtnIajcVF7jdl48q4enVt+SGAcoWrS4U9fxcaX7nMfp7oD8ERfn
        TeIDW2GXjCQOYS70QwOBOXlkLvE8VF59GtIO00fzugGPPwYbUmti5u+b2TGGXGTy2J8VFw
        rOelCZ/M1QP6Dr+lpw23kqGJcUZ2Vds=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-Rt-pZ7UcP1eKO6w2LgCVvw-1; Tue, 07 Jun 2022 03:55:17 -0400
X-MC-Unique: Rt-pZ7UcP1eKO6w2LgCVvw-1
Received: by mail-ej1-f70.google.com with SMTP id n2-20020a170906724200b006fed87ccbb8so7368010ejk.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 00:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yCabSttjyR7JTvbvQVMcJUlNQoTjNGH5eBfRKJdu02I=;
        b=Tj0J3Re+Mtb81lvJvf+NTCQepWPJYIghbhxZjr1+FbDahD5mRxNC8W8Vd1TWYc96zQ
         KgxUInCRnZy+kBNJjMKXYIVKhYVktTU36wcwI4Je9gb4dZ4kJCb9oBsJxJaPBXWaRGGO
         aKPNhb6KAHlG0Oy05werS+HkCjsQwTsbENzqlWVPo46DiMH3RaUAICn8rFpoChEWht8N
         FxWSrLUI14n8vYcNq76ijFCgPWMub1mUT7/tSRSxwybhZHv6Vrd/PNK9ThYHLGfRSE+q
         XsIpRbk66EwXIO5l1Xp/aeQ0f7dxvIMEDiHCrpmxRXlsIdMHW5sezcx9z/k22xrV3x4X
         dtHA==
X-Gm-Message-State: AOAM531tt2HB/XSQJjtJdbovVnQLwkLdUGKE6t1jV3IVhB3Mf3VLUKeS
        5pjWo4m0HVHl3IfCmmZD48ZwetKla0vFkrP2YSb5TEc3mei/PnokCqGHEDESfWmn9Y8cmZOLF0N
        3ir0Q0m8a0gGxBvHgpuY4toEh
X-Received: by 2002:a17:906:4e89:b0:711:c64d:ca4a with SMTP id v9-20020a1709064e8900b00711c64dca4amr10915422eju.203.1654588516363;
        Tue, 07 Jun 2022 00:55:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8PEgdZ8DCZU07IawtFbSgA7EGHzFOQEd+bX7JiF7kkI/rlPxHPBgy0LR+G+9hqwNXmf5mHQ==
X-Received: by 2002:a17:906:4e89:b0:711:c64d:ca4a with SMTP id v9-20020a1709064e8900b00711c64dca4amr10915406eju.203.1654588516130;
        Tue, 07 Jun 2022 00:55:16 -0700 (PDT)
Received: from [192.168.0.198] (host-95-248-229-226.retail.telecomitalia.it. [95.248.229.226])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906248d00b006fee7b5dff2sm7325258ejb.143.2022.06.07.00.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 00:55:15 -0700 (PDT)
Message-ID: <46b7ca44-a338-e1c1-e005-326e89576211@redhat.com>
Date:   Tue, 7 Jun 2022 09:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] sched/deadline: Use proc_douintvec_minmax() limit minimum
 value
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, bsegall@google.com, vschneid@redhat.com,
        rostedt@goodmis.org, mgorman@suse.de, vincent.guittot@linaro.org
References: <20220513024109.648471-1-yajun.deng@linux.dev>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220513024109.648471-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun

On 5/13/22 04:41, Yajun Deng wrote:
> proc_dointvec() is not applicable for unsigned integer, use
> proc_douintvec_minmax() limit minimum value.

I understand your patch, but your log message is somehow incomplete.

Could you expand on that, showing the problem using an example, and then how you
see it fixed?

Also, could you please add the Fixes: tag so this patch can land on stable trees?

-- Daniel

