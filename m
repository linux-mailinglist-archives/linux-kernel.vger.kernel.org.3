Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAAB4F6A20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiDFTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiDFTks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:40:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B872619531F;
        Wed,  6 Apr 2022 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649268823; x=1680804823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BXJ0GIop+UGWRaFV2rjdj0GKaXIQVFtY0SlM5haDrWY=;
  b=E8Zv7mLGURkFsCxLUiVXMQOxCUZxhxhLbe++Uwipe7x3cWscrzswCZ07
   L3h/rzg0PO+MfuxZt0dnen+2RNZReJcT6rw8cWsMRGw74H7gPRN1IaDc7
   i1Zr3SiOTI8GZIJ6wKWXKg+GFA/M0yU9sC0JNOAR3kXtD87vzBqQjXhVF
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 Apr 2022 11:13:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:13:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 11:13:20 -0700
Received: from [10.110.72.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 11:13:19 -0700
Message-ID: <960102bb-2944-4be0-ab09-7cd2eb0c2cf9@quicinc.com>
Date:   Wed, 6 Apr 2022 11:13:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/7] kbuild: read *.mod to get objects passed to $(LD) or
 $(AR)
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        <linux-kbuild@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220406153023.500847-1-masahiroy@kernel.org>
 <20220406153023.500847-8-masahiroy@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220406153023.500847-8-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/2022 8:30 AM, Masahiro Yamada wrote:
> ld and ar support @file, which command-line options are read from.
> 
> Now that *.mod lists the member objects in the correct order, without
> duplication, it is ready to be passed to ld and ar.
> 
> By using the @file syntax, people will not be worried about the pitfall
> described in the NOTE.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   scripts/Makefile.build | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 3da731cf6978..f6a506318795 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -450,22 +450,18 @@ quiet_cmd_ar_lib = AR      $@
>   $(obj)/lib.a: $(lib-y) FORCE
>   	$(call if_changed,ar_lib)
>   
> -# NOTE:
> -# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
> -# module is turned into a multi object module, $^ will contain header file
> -# dependencies recorded in the .*.cmd file.
>   ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
>   quiet_cmd_link_multi-m = AR [M]  $@
>   cmd_link_multi-m =						\
>   	$(cmd_update_lto_symversions);				\
>   	rm -f $@; 						\
> -	$(AR) cDPrsT $@ $(filter %.o,$^)
> +	$(AR) cDPrsT $@ @$(patsubst %.o,%.mod,$@)
>   else
>   quiet_cmd_link_multi-m = LD [M]  $@
> -      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
> +      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@)
>   endif
>   
> -$(multi-obj-m): FORCE
> +$(multi-obj-m): %.o: %.mod FORCE
>   	$(call if_changed,link_multi-m)
>   $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
>   

Looks like this also addresses the out-of-tree issue described in 
<https://lore.kernel.org/linux-kbuild/1610500731-30960-2-git-send-email-jjohnson@codeaurora.org/>

:)

/jeff
