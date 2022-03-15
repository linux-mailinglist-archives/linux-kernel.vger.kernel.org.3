Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDD4D9A04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbiCOLKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbiCOLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63A4F434B7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647342567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTOrlBxUc3YGJVn5Ljs85Co05t+OCsyiEfp7PBlz6N4=;
        b=OB3ZNgy0mSYi4+cDvkdLNUVobCgaJ3fCYu6ZPbZNL58CtRcQ1z8RwtaarqfB4hshwE3/FT
        rBlfV/RlAu6BDJxSL5UGQ6pT5NHfL2dOom9z16n+Ug4N/AZdIWMfvAKW1BqXzVrXlPyGiD
        KQgwnr6lYfuPFU8nVEee1SquQNsWn7c=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-H8YVrxBVNHyswWI__smmKQ-1; Tue, 15 Mar 2022 07:09:25 -0400
X-MC-Unique: H8YVrxBVNHyswWI__smmKQ-1
Received: by mail-oo1-f71.google.com with SMTP id r63-20020a4a3742000000b00320d9025595so15277491oor.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HTOrlBxUc3YGJVn5Ljs85Co05t+OCsyiEfp7PBlz6N4=;
        b=TLoqK9VT555DmBYpqCaG6s3Kdc3uhWiKJB328YVS8Sa08LUdJvwCOyXBCec1WMrO4c
         O5AWHHWW01gvv2aKWuvI7D1u0UIipXuN3c6DHKuBz++ErVok9afo1+9WRlsJ1hUUFsah
         1EVTkX+YJwwzZ69QczcdEAZa+X4/E6tWv6489PayuYCQYBXJ2GB1P99Oajiz+xzWHZHy
         omDliPXgNSR4/RrE/nn4BytkYzXTTzudw7tfJN4l8+ZKd0TVB2EXQFoKdgIprOdQqOKZ
         xFGqbvaWE21cYtneyyQ87VOeXl/hgZYfVs9gVr2ezxua/aXPkNzk/m7WLV+aiPb99WOH
         xDsA==
X-Gm-Message-State: AOAM531ReYIYPbawt537n/KDApKDNN/Gzm/P/rpY7zk3Nufqdx2e0quy
        Rvm3Zy2sGwpeG4NhJuB1mjX4tMTAVYCmONYdVp2TTTEyR+0vzh7tnNuQDqw3oWmTieErpFX6IsO
        KA+V5LhtKSMuaakZxgJtFVJ9b
X-Received: by 2002:a05:6830:3193:b0:5b2:2c08:e3a3 with SMTP id p19-20020a056830319300b005b22c08e3a3mr12384915ots.88.1647342565043;
        Tue, 15 Mar 2022 04:09:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDFl+lhHVzIiwQlpvdXQz2MzYXPAVXVyT3EMo54gHkYKTq4HtG7cVgd+r2WdsWc/7swgUCTg==
X-Received: by 2002:a05:6830:3193:b0:5b2:2c08:e3a3 with SMTP id p19-20020a056830319300b005b22c08e3a3mr12384910ots.88.1647342564812;
        Tue, 15 Mar 2022 04:09:24 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id e4-20020a056808148400b002d9be41b179sm9615711oiw.50.2022.03.15.04.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 04:09:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] MAINTAINERS: add a git repo for the Stratix10 Service
 driver
To:     Dinh Nguyen <dinguyen@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20220223144908.399522-1-dinguyen@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4d443650-1db3-fced-3167-e3476b6e20aa@redhat.com>
Date:   Tue, 15 Mar 2022 04:09:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220223144908.399522-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/22 6:49 AM, Dinh Nguyen wrote:
> Add a git repo entry for the Stratix10 Service driver.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..5752236bea80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9890,6 +9890,7 @@ F:	drivers/firmware/stratix10-rsu.c
>   F:	drivers/firmware/stratix10-svc.c
>   F:	include/linux/firmware/intel/stratix10-smc.h
>   F:	include/linux/firmware/intel/stratix10-svc-client.h
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git

Can you check if your tree is ok ?

Tom


 > git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git

Cloning into 'linux'...
remote: Enumerating objects: 185, done.
remote: Counting objects: 100% (185/185), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 8723742 (delta 182), reused 181 (delta 181), pack-reused 
8723557
Receiving objects: 100% (8723742/8723742), 2.41 GiB | 2.78 MiB/s, done.
Resolving deltas: 100% (7135708/7135708), done.
warning: remote HEAD refers to nonexistent ref, unable to checkout.

>   
>   INTEL TELEMETRY DRIVER
>   M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>

