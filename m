Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8D4F6612
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiDFQyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiDFQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0688945CFC1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649254705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODOVaz/edmhBMoEaKgg2w+ntcwg87Ta6yU5ilJ/7uSY=;
        b=hAJblArK92wXhIjvmcbOlhTB6zUXxNJdaR0/p3Kz9ZCXCMKbBGAVMMCWsusvz8qK7luAAL
        v1S1RXlC0S646SVRqHGYamDwMNKZfW9EzcPVpn2PI6nd0yZq+4M2BNNqU2QyKXF4hEf6RK
        E4/Lok9hgN0tBcTA/rouZ9aGfenmkiY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-vj0khCuwOVaN4szukj7f8A-1; Wed, 06 Apr 2022 10:18:24 -0400
X-MC-Unique: vj0khCuwOVaN4szukj7f8A-1
Received: by mail-qv1-f69.google.com with SMTP id im8-20020a056214246800b00443d3d3956dso3574338qvb.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ODOVaz/edmhBMoEaKgg2w+ntcwg87Ta6yU5ilJ/7uSY=;
        b=6B/SFyQdbJYU35TA1G8AvLMKa/Xhk8gy/J2XPqLfXFSauSdEkLPCEpM9Spj4RoAwNV
         ZMtcoHJs6Na6DrCJqh2Bqsbhhr1vr7NzsUd41b0o49Qrz2VOl2w8VeDuGpakDETC71/r
         6E+1L1tzSJcAtUElLytFsZRphBve05OUoD9sfOwbSYcmkCBpFW2f0OsdOnQ+1jjrmzjo
         LFMNU3/iDtNfezS8D5FyWNR4CQk+ogQ9cdFU//MAvPK2RqGxlH8MB9DKjDerT/N6Ggo6
         CjZWctBx0ocFI7gXTiqIlrytGQAKqWxWq1GN+JV3GG74XUxbA0vVIZgRD4R87dxCtuh+
         dp7g==
X-Gm-Message-State: AOAM530WIWzI4KuMKKiDkHn4H90sy8z/vNR9I9YXG9gavkOd8hFPJmKP
        xLJeACPXOuRBrwwToGhK38I6MEMq5B+/pp2dpMVD+v2fqiB9eE21yR+NW09ItOgS/EmKI0Bundd
        uvOVKHggMVnS2kShK0bcSblr1XHqYLrdRHp8+vb4g/l47VELE8UCp3H9ckJbaNFj6PHu4Tas=
X-Received: by 2002:ad4:5b8f:0:b0:443:5663:12ad with SMTP id 15-20020ad45b8f000000b00443566312admr7625119qvp.93.1649254703934;
        Wed, 06 Apr 2022 07:18:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5Ek+S4hfi61dB9TIY5eREbgIsa4+FJaeRcA2oPQoc6YVwJZraRCwA7foiQ+eI3V9hRLSlOQ==
X-Received: by 2002:ad4:5b8f:0:b0:443:5663:12ad with SMTP id 15-20020ad45b8f000000b00443566312admr7625091qvp.93.1649254703704;
        Wed, 06 Apr 2022 07:18:23 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id a6-20020ae9e806000000b0067ba5a8a2a7sm9427968qkg.134.2022.04.06.07.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 07:18:23 -0700 (PDT)
Subject: Re: [PATCH] fpga: altera-pr-ip: fix unsigned comparison with less
 than zero
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220405185349.220607-1-marpagan@redhat.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d39cdc4c-0dc5-f929-17fa-ffbaf9e767c7@redhat.com>
Date:   Wed, 6 Apr 2022 07:18:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220405185349.220607-1-marpagan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/22 11:53 AM, Marco Pagani wrote:
> Fix the "comparison with less than zero" warning reported by
> cppcheck for the unsigned (size_t) parameter "count" of the
> "alt_pr_fpga_write()" function.
>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>   drivers/fpga/altera-pr-ip-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index be0667968d33..2ff3d8e46a0c 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
>   	u32 *buffer_32 = (u32 *)buf;
>   	size_t i = 0;
>   
> -	if (count <= 0)
> +	if (count == 0)
>   		return -EINVAL;

Reviewed-by: Tom Rix <trix@redhat.com>

>   
>   	/* Write out the complete 32-bit chunks */

