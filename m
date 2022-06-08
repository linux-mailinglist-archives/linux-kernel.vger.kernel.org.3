Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24B542F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiFHMB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbiFHMB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B69BE24DE4B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654689714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/naVlH4VbKoVbZ8W2O6t93AKCSiORy4mCDQBAFpizU=;
        b=OF/vOiW1z58wOHD4fyqGQiVI0VQmh+DhQfumPaJ7kKj2u9qCUYRPepsXrw8fYJm1U+Meh2
        6/EOokg/r5DPx4piQ4pcUWpibRnJVfS6oSCs7MhKVAEqqckiggUqrdREv7xlie7H25t3ul
        PCIcSqPP+V1glNBPVqQR8a/TlbV0fIk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-1WMpe9l4OyKLP4aBWS64lA-1; Wed, 08 Jun 2022 08:01:53 -0400
X-MC-Unique: 1WMpe9l4OyKLP4aBWS64lA-1
Received: by mail-ej1-f72.google.com with SMTP id p10-20020a170906b20a00b0070c21a6d378so7245796ejz.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 05:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8/naVlH4VbKoVbZ8W2O6t93AKCSiORy4mCDQBAFpizU=;
        b=l/6CJqqZ+5bEeAnR/F2bm3+vWeFcKT7pKPROsZJkJNzimWnUn/DAHlZn8CjINGDR7y
         09bWiaAD4eMiz9YldSULGtr9HxtUIC3YOgzp+JWgQOThac1/HIsemxk1xCd99Z3PGsGo
         CG6xTzfRZKF0GbRDS8mwpfaPWdLW7yoaQolMYeIf0w/1/wLeOJXyqV3AT+WTtjeHrEBl
         2bPGGuLXf1Fpevjd7OOEQoNC+/wjinVodivKzmbkYqrqFXABSWb9fjvNMK/67Fl2WVFO
         Pei7pN5elkPCdpz0TptNDwZrCnS/sQPCzfXY0v3i6BJocPdKPO32Rzbjj2CJwvzg+pUo
         cxWg==
X-Gm-Message-State: AOAM532W9tfdvWCWSDJst7bFMCJSP90sxKfYdq7m25H3IQqb0oBNOre2
        QpwUT3B4ASo1RqGJ4tLqqBJW9vRLIEiG6gHbJNMsJdWOoUK126hDFF0SVe1WH+os12sUh+H1SBd
        TxFhgH2/ou8uaM7WZ84+TJaz8
X-Received: by 2002:a05:6402:51c7:b0:42d:f4ea:c09 with SMTP id r7-20020a05640251c700b0042df4ea0c09mr38544745edd.319.1654689711926;
        Wed, 08 Jun 2022 05:01:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrq6avk9jacZToIb6RC8rRztVQpYBB5zll+1FWxzgko3nsoNgqgNSYfvMF6z4IWld9NTcu8w==
X-Received: by 2002:a05:6402:51c7:b0:42d:f4ea:c09 with SMTP id r7-20020a05640251c700b0042df4ea0c09mr38544707edd.319.1654689711640;
        Wed, 08 Jun 2022 05:01:51 -0700 (PDT)
Received: from [192.168.0.198] (host-95-248-229-226.retail.telecomitalia.it. [95.248.229.226])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090636c200b00705fa7087bbsm9235569ejc.142.2022.06.08.05.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 05:01:51 -0700 (PDT)
Message-ID: <2a55de85-13fd-f501-b942-37bd2df2c616@redhat.com>
Date:   Wed, 8 Jun 2022 14:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] sched/deadline: Use proc_douintvec_minmax() limit
 minimum value
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220607101807.249965-1-yajun.deng@linux.dev>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220607101807.249965-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 12:18, Yajun Deng wrote:
> sysctl_sched_dl_period_max and sysctl_sched_dl_period_min are unsigned
> integer, but proc_dointvec() wouldn't return error even if we set a
> negative number.
> 
> Use proc_douintvec_minmax() instead of proc_dointvec(). Add extra1 for
> sysctl_sched_dl_period_max and extra2 for sysctl_sched_dl_period_min.
> 
> It's just an optimization for match data and proc_handler in struct
> ctl_table. The 'if (period < min || period > max)' in __checkparam_dl()
> will work fine even if there hasn't this patch.
> 
> v2:
>  - update the log message.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
-- Daniel

