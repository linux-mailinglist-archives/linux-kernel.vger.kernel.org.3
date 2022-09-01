Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26C5A9768
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiIAMu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiIAMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1EC79632
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662036639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzJH/mFnhHzqFHe2QCKkbQOatunPBFjzCPFC0VNIipc=;
        b=XRRd/h06lhaOYIWtA5c1Q/OdyKjLFNUgFmNPSkjZZXWNYpMOLO4omKMGNu3kuFfel//eQE
        i5GOw6fT7OY7Mr15wfNyjuPdMBp3He3dEp8GOBEXWLVgtto5HYjvlieageQAy2Lym0qMvQ
        HGO9gloQpGuMJKf1qZurnsw7RLzC/eY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-XFFghBbIPHKM7FJT2bJRoQ-1; Thu, 01 Sep 2022 08:50:38 -0400
X-MC-Unique: XFFghBbIPHKM7FJT2bJRoQ-1
Received: by mail-ed1-f69.google.com with SMTP id w17-20020a056402269100b0043da2189b71so11464654edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jzJH/mFnhHzqFHe2QCKkbQOatunPBFjzCPFC0VNIipc=;
        b=HoyAJ7krVKB0D8X++5OLXdM4P1CR3fE4NIMVhtXzKawywHhx0EZzHx9ARjYtcDvupF
         0qxN0KCQVdFaR2CxbVodlHX5A9tzPjaFr8wp4yjAqUKKjMpopijQm8K8+FMZwpah2FFQ
         WFzEdF2JqBmEls+dIkwXCX0bubk3JYL3m8Ds2dGVYSvLWG36FinXUnkuRTgsLnXq1g7D
         9bA9Bh69rPFvJi/HLSsQzpLOaWY6fS9bWvSnFGCZjfL7lyKCXmNkZitexabXxrGzJqm+
         PRkMuzpBAFqG+LYbdGy369J1Gn+r433CIWSRbtEmbBu4ZYw1qcr9TNpEG5pwPIQZ5FJw
         RLvQ==
X-Gm-Message-State: ACgBeo3oqot/JmijiyIRerxM3VcFmc+dxooD+uABpdlgjs8yzSyMoVk/
        S/C+uKuxSJmgbxA3AaD2Gk9j+2RJcd7wI27uZ5ySZq9C90ZJXcbLHtq6sS6s/VAkpJJJPMrrpNe
        BL/8HnDMoA/B0hRRXyq5rwVs7
X-Received: by 2002:a05:6402:1909:b0:447:f0d3:a9b1 with SMTP id e9-20020a056402190900b00447f0d3a9b1mr24135158edz.100.1662036637540;
        Thu, 01 Sep 2022 05:50:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6+fKohXs2E7Q+sSvhx52Aj58JDBgSTfq5zaBn0bqfrs76ZEUkvx9l1CgzEdzGFMvMDzeU2Hw==
X-Received: by 2002:a05:6402:1909:b0:447:f0d3:a9b1 with SMTP id e9-20020a056402190900b00447f0d3a9b1mr24135150edz.100.1662036637371;
        Thu, 01 Sep 2022 05:50:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090632d500b007419b73bb8dsm5148750ejk.10.2022.09.01.05.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 05:50:36 -0700 (PDT)
Message-ID: <1e23900b-a1f4-b3b1-8ed5-2b1db6eeb519@redhat.com>
Date:   Thu, 1 Sep 2022 14:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/1] platform/x86: intel_cht_int33fe: Fix comment
 according to the code flow
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20220824152115.88012-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220824152115.88012-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/24/22 17:21, Andy Shevchenko wrote:
> We don't use software_node_register_nodes() in the code, fix the comment.
> 
> Fixes: 140355e5db8b ("platform/x86: intel_cht_int33fe: Convert software node array to group")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/intel/chtwc_int33fe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
> index c52ac23e2331..9448e2e67c3f 100644
> --- a/drivers/platform/x86/intel/chtwc_int33fe.c
> +++ b/drivers/platform/x86/intel/chtwc_int33fe.c
> @@ -219,7 +219,7 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>  
>  	/*
>  	 * Update node used in "usb-role-switch" property. Note that we
> -	 * rely on software_node_register_nodes() to use the original
> +	 * rely on software_node_register_node_group() to use the original
>  	 * instance of properties instead of copying them.
>  	 */
>  	fusb302_mux_refs[0].node = mux_ref_node;

