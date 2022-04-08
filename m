Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66B4F9677
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiDHNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiDHNNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BA4253E01
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649423406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6zQPUV2PlrHGRSviwyJlofSDRUyDcipHnyWs+t/Z1c=;
        b=bPMGwiyTmEfo8C8vQRRJfRym39Zfbhgf4+FhnAiCogPHHpDTmj2jHCxmekyOQPJzTkaLbc
        rj9fb+AqsOc8pbvFM7+5BKYJDD2XWXFdBT9xWJy4OX492Jp/rPFAFuq47OzMkz86i0TAgH
        GtVihh0D/xuPmVjHjCJpqxav6rrSfkY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-uAmucHkMNCGhPvdxOxmBtw-1; Fri, 08 Apr 2022 09:10:05 -0400
X-MC-Unique: uAmucHkMNCGhPvdxOxmBtw-1
Received: by mail-ej1-f70.google.com with SMTP id gn14-20020a1709070d0e00b006e84581e345so1690021ejc.19
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F6zQPUV2PlrHGRSviwyJlofSDRUyDcipHnyWs+t/Z1c=;
        b=SZVg76DawxZsS6yEcEb3zpEn/KDXdNJwTR00xXWWKX5O4RvbnpZUDtNCeXFYitsw92
         ca/NkqS447BZ0e+YrQK/kUFHvA5P8FZN/RR86AvfBg89A76O7LwtqsuKDTQkjJiyGTy0
         oJsAiu7nnDC4Ax2rRLddwYvydWmnBq23zyk0iUCNpQJFj3RRabFgUp6T5GHzy87d+4Z6
         Ofezcl5k9pMIAH3z7XYk4FZQ4AfXw+Jrs1QhaoVrA8ITb1YThxRILqoJXmlIg+4Ujp5q
         41UWaTG8maFe3wqJaZwLv4kVmxWukqmF/wIkRhip53qNpsrZJ/HgicdoFXJY5P4cmIHN
         YQOw==
X-Gm-Message-State: AOAM533Y5ELjYEZPipw+rY0OVrNaLr+sE1fsnCRZE8nsqc27DQ8gZyHJ
        +V2rZ5q9g7/+p+C187lNOpYjBnq1Rz7r6N+f/MGuvK/7yPZf1FHoaZVfL4i24Xls6+QwAVVRVuP
        8jbsfTo3iPmZzi7ppzz9etrIR
X-Received: by 2002:a05:6402:1811:b0:41c:d21a:4096 with SMTP id g17-20020a056402181100b0041cd21a4096mr19328844edy.389.1649423404236;
        Fri, 08 Apr 2022 06:10:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn7MP9IA7yyDw5LXL1ocCfgDAs6gLE3DYeEm4wur52ay4RHHoQP9A+hUSUwLYwXmMU7zcaow==
X-Received: by 2002:a05:6402:1811:b0:41c:d21a:4096 with SMTP id g17-20020a056402181100b0041cd21a4096mr19328820edy.389.1649423403995;
        Fri, 08 Apr 2022 06:10:03 -0700 (PDT)
Received: from [10.0.0.45] (host-95-245-33-130.retail.telecomitalia.it. [95.245.33.130])
        by smtp.gmail.com with ESMTPSA id gv55-20020a1709072bf700b006e82ef9b910sm1880289ejc.70.2022.04.08.06.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 06:10:03 -0700 (PDT)
Message-ID: <24f79a7c-0146-ad0a-988a-608edd402faa@redhat.com>
Date:   Fri, 8 Apr 2022 15:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] rtla: Minor fix to grammar in README.txt
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220402043939.6962-1-jkacur@redhat.com>
 <20220402043939.6962-2-jkacur@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220402043939.6962-2-jkacur@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 06:39, John Kacur wrote:
> "The rtla" doesn't make sense, change it to "The rtla tool"
> This is better than removing the word "The" since some packaging tools
> need the description to start with a capital letter.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  tools/tracing/rtla/README.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
> index 6c88446f7e74..3b809eeff5f9 100644
> --- a/tools/tracing/rtla/README.txt
> +++ b/tools/tracing/rtla/README.txt
> @@ -1,6 +1,6 @@
>  RTLA: Real-Time Linux Analysis tools
>  
> -The rtla is a meta-tool that includes a set of commands that
> +The rtla tool is a meta-tool that includes a set of commands that

I do not like bike-shedding but 'the rtla tool is a meta-tool" sounds repetitive.

Does:

The rtla meta-tool includes a set of commands...

sound good for you?

-- Daniel

