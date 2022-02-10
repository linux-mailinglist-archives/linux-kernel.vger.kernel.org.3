Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD784B173A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbiBJUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:51:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244417AbiBJUvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:51:54 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB98E109E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:51:53 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m185so8953894iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F9qniLIYcSNNaXLHE81e7mp2h4IikxqVN02UR2NIgyw=;
        b=O3ZElN5OWacZz6PGS67NsgFT4wvqisX8gaXrN1xZO2NsTd4P44FsUcBRjYk80v6D+S
         f9Q972fiMjiprSwd3i0aQh1nUFPE/Go+MhjEuFl5aDDpl7l/WuTiVl3cFzfuB1m6clVD
         MsQZ1f8sPwFKhkGsfC3r8eGrAulY69spphNDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F9qniLIYcSNNaXLHE81e7mp2h4IikxqVN02UR2NIgyw=;
        b=dmcajTvZZP+ebqtBPpgnNkwz7QLvodWwjF0Eli72z2txJxfhBLUp7TTjOR6EW+3j76
         QcYqG45S0pPXUtW8Cbcmh+2fW/jkOG2fuMTuEnK9hfZ7JTatKgETOHvKtqB2UlOpLwNQ
         Qyjimyo0wTpdzwxZMBG/aCBqgH5XeWCzsQMZXm0IslGsMlummKcJgcDGkIdvnq/avdr+
         FxzaX/A2ciSEAi5277hb6BhJZKlOeoHjBNPkowyR8wG+4YzMIAPwWFCiMAKPmeAeHTiL
         szanhevOHHvpgNaUst2vqXOFGJ0xfs+LyKCT2kI3H31+hqDTTfWgQBPoScIHmRBdsOjA
         N61g==
X-Gm-Message-State: AOAM530PJ03P0fsqSnKnaet42wcOVaVFVm76bTNeoDN49lLVUu8EGJmy
        SnJhY3vlAxqnD37pQInB8fXoFQ==
X-Google-Smtp-Source: ABdhPJybGUI9jtrldcDCWU9EAnrcgBPe7Sk5sHt/4O/BY7R/7gAO/Zj2K79iJueTpQW0VMkR0bbICw==
X-Received: by 2002:a5d:9d1a:: with SMTP id j26mr4716221ioj.20.1644526313011;
        Thu, 10 Feb 2022 12:51:53 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id ay35sm12104735iob.3.2022.02.10.12.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 12:51:52 -0800 (PST)
Subject: Re: [PATCH 1/2] selftests: x86: allow expansion of $(CC)
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>
References: <20220210190642.1477814-1-usama.anjum@collabora.com>
 <20220210190642.1477814-2-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a34f2fc8-f4aa-fef4-d1dd-f3fdb5114f72@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 13:51:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220210190642.1477814-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 12:06 PM, Muhammad Usama Anjum wrote:
> CC can have multiple sub-strings like "ccache gcc". Erorr pops up if
> it is treated as single string and double quote are used around it.
> This can be fixed by removing the quotes and not treating CC a single
> string.
> 
> Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture detection")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/x86/check_cc.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/check_cc.sh b/tools/testing/selftests/x86/check_cc.sh
> index 3e2089c8cf549..aff2c15018b53 100755
> --- a/tools/testing/selftests/x86/check_cc.sh
> +++ b/tools/testing/selftests/x86/check_cc.sh
> @@ -7,7 +7,7 @@ CC="$1"
>   TESTPROG="$2"
>   shift 2
>   
> -if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
> +if $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>       echo 1
>   else
>       echo 0
> 

The intent is testing if $CC is set. Does this change work when
$CC is not set?

thanks,
-- Shuah


