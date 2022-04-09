Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB94FA75D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiDILtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiDILtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 296F06151
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649504826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kANSNeeGkYUwvJRcfY0adJcFfGrYgDXHkzIykiPCPSc=;
        b=OpCPNb6Cj+m4Kud3K/b8sMYMj/7AFECdfPqSZobEHB18zbRsVkMu98scayhr4bIUx0R4WJ
        BKXbWpjr+PfIFho2tX5x51LWL6+KWffYmMtHkdwx+zJtAmiMN2i1UISynZnaxUXXGvdMh1
        /yV/gJmjRsSww3MsJbOiza30XoZ0/ew=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-mD8NfHuCNsWIkr7O2LXJ-Q-1; Sat, 09 Apr 2022 07:47:04 -0400
X-MC-Unique: mD8NfHuCNsWIkr7O2LXJ-Q-1
Received: by mail-qt1-f198.google.com with SMTP id h16-20020ac85850000000b002ebdd31dca9so4333745qth.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 04:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kANSNeeGkYUwvJRcfY0adJcFfGrYgDXHkzIykiPCPSc=;
        b=P15JUi8dmqduTN3cJKWxp9SkScnut7q+nlUwkBkNvbnCRTgRZlSxRsMQ0hka+v4fOn
         54LB6n/fIo+M1qxoZ0ydr5lResONTT9uDvEURpL8Sk9OVueFt5GJU3z1F1F+On9lX/dc
         kEP9y/ZizdfsJxKMn4U1iQalDNRHEH7SG6VrQQnM8OK9uzwVO1DDBmJnM70/V1MFn9/3
         EfZ/ijgWi9m9az1crGhN2zX958ijJJQhnrKuf9Vkuw99V+6lvYbRy+EzekVzMM6gPdYQ
         3fNsrYizvO7WG3MMDWTeydIhcTnoS0iWw55t8RmGe8K9H2B+q+piCLmfXvmILMLkNKiN
         Lzzw==
X-Gm-Message-State: AOAM5315ArBrCvLrUVoWodGuSVvr3SDbSuoEfhXNmTecgSEOZ6tOQn77
        0od8OgHErNEh9w+dU9E2Gu6xfH2BKJ48nNH8VrpXFeh8G422vENa8GBPD+oa2tpQENvsV7/bSbt
        06cm0bH5CeVQRysU8SmT8DBai
X-Received: by 2002:a05:620a:2585:b0:680:f1f5:23ac with SMTP id x5-20020a05620a258500b00680f1f523acmr15620534qko.656.1649504824306;
        Sat, 09 Apr 2022 04:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb4G+hNqZXEQrbF8SrxSFNhUARjC+5OVfwD5R6TULFJCq0gmkP0FgRnHG3hCOb+grIDHV9kQ==
X-Received: by 2002:a05:620a:2585:b0:680:f1f5:23ac with SMTP id x5-20020a05620a258500b00680f1f523acmr15620523qko.656.1649504824066;
        Sat, 09 Apr 2022 04:47:04 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a0b0100b0067d3ac00982sm14470312qkg.57.2022.04.09.04.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 04:47:03 -0700 (PDT)
Subject: Re: [PATCH] ipc/sem: Remove redundant assignments
To:     Michal Orzel <michalorzel.eng@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220409101933.207157-1-michalorzel.eng@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <30aa1413-de9c-ffb9-223f-b091b7990a85@redhat.com>
Date:   Sat, 9 Apr 2022 04:47:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220409101933.207157-1-michalorzel.eng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/9/22 3:19 AM, Michal Orzel wrote:
> Get rid of redundant assignments which end up in values not being
> read either because they are overwritten or the function ends.
>
> Reported by clang-tidy [deadcode.DeadStores]
>
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>   ipc/sem.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 0dbdb98fdf2d..38ef91a63edd 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -766,7 +766,6 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
>   	for (sop = sops; sop < sops + nsops; sop++) {
>   		curr = &sma->sems[sop->sem_num];
>   		sem_op = sop->sem_op;
> -		result = curr->semval;
>   
>   		if (sop->sem_flg & SEM_UNDO) {
>   			int undo = un->semadj[sop->sem_num] - sem_op;
> @@ -1430,7 +1429,6 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
>   	if (err)
>   		goto out_rcu_wakeup;
>   
> -	err = -EACCES;
>   	switch (cmd) {
>   	case GETALL:
>   	{

