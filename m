Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F24B50DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353767AbiBNM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:57:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353738AbiBNM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:57:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 243EA4BFF1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644843459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXbXKwNefXUMxjvIv7PZR4ufdZvetqDxpNnWNZX3Q9w=;
        b=Cnt0Bq9sos2VKs4n7o3qVXMk5dcas0z612GkrnDAFWUoijRK9EPo5fZGOg4TXDYgjQ54p8
        nnIDfdSLG0cL0hzXrKl0xnIMsqBOApABM8+Jw+YI9jgBzp2/Qz9zl+n21Plafu4He1KjlT
        DOqSfr4ahfbE3l2BQ/5VnpzryZROhvQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-GE7DH0D4PVahpTZdWSM__g-1; Mon, 14 Feb 2022 07:57:38 -0500
X-MC-Unique: GE7DH0D4PVahpTZdWSM__g-1
Received: by mail-ej1-f72.google.com with SMTP id v2-20020a170906292200b006a94a27f903so5821888ejd.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oXbXKwNefXUMxjvIv7PZR4ufdZvetqDxpNnWNZX3Q9w=;
        b=TjGD2mq/75+2tgU8kQ5yFSuqga6iHnOfUgCt22NxoisOOCT4++RD60tMbw/fjpRsGn
         8Rv4qSBgcW+Qj+ALUcX/KmOyl6DbI9lyzEiRAWw4YIS2MtZm+7jPvZTaQ9csxGAFBfTX
         xnTfqzkBvi9tC9r33LLjyMUVOsil5MQFn2GZUZC8REn3Mp6FNKkV+mLdYMo7ldLS3RO4
         ME+el6mUgicii8655wR00WxCQahfzJBjfWvSgz+/V4pOTfu6xhwd+r0XrhtYIUpNH4Vx
         yk8OK18o09Zqp4M8STbjxlzDAxVzVsO/la7yOA283pv7Qv+tmQwJtezoILyOv1XDMM2g
         Drww==
X-Gm-Message-State: AOAM530RcqGBmxbTcHW/By/ThPog/mP0RpS4JWyIcfRW1kVZ4BNl/TWX
        2FKvg7pve0YKFi/IGNk3clj0N9enqjjaFF77lOXXssb10ABS3agJxPHlSmPUc0daeLcXyshzX5N
        Ch2OT/u2I9MObpskCeuSc9juA
X-Received: by 2002:a05:6402:3489:: with SMTP id v9mr15115245edc.249.1644843456846;
        Mon, 14 Feb 2022 04:57:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyU5DkSABeMnnwGxALr4cUufpghJY/IkWE1R3VTtIBjGPU4fKsIkDZmUYsm4G8pEfV5YGtv9A==
X-Received: by 2002:a05:6402:3489:: with SMTP id v9mr15115232edc.249.1644843456718;
        Mon, 14 Feb 2022 04:57:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id p5sm8932228ejr.105.2022.02.14.04.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 04:57:36 -0800 (PST)
Message-ID: <a3008754-86a8-88d6-df7f-a2770b0a2c93@redhat.com>
Date:   Mon, 14 Feb 2022 13:57:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] KVM: SEV: Allow SEV intra-host migration of VM with
 mirrors
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>, linux-kernel@vger.kernel.org
References: <20220211193634.3183388-1-pgonda@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220211193634.3183388-1-pgonda@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 20:36, Peter Gonda wrote:
> +	list_cut_before(&dst->mirror_vms, &src->mirror_vms, &src->mirror_vms);
> +	list_for_each_entry_safe(mirror, tmp, &dst->mirror_vms,
> +				 mirror_entry) {

Is list_for_each_entry_safe actually necessary here?  (It would be if 
you used list_add/list_del instead of list_cut_before).

> +		kvm_get_kvm(dst_kvm);
> +		kvm_put_kvm(src_kvm);
> +		mirror->enc_context_owner = dst_kvm;
> +	}

Thanks,

Paolo

