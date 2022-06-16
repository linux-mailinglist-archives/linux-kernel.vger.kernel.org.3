Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103DF54EA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiFPULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiFPULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:11:32 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7AA54013
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:11:31 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1014b2752c1so3165529fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0/2lPHK5UfMEdeldVC+LjacfATEIIqbuMlENszuskS0=;
        b=JwDFrcRmWvi+UwEVyuoBAsqo+8IdDLtYFOwFHc7++2OSwhHq+EACTUHG5Hg+ixpX4X
         bAeZlxYrzmld3IwoVXRU/HT86ix0ILdxcRDSGb84Qnl52BMEXFcTUKVQckkiT3k8UaeU
         Aa/eR9q9rnjc4IhOjXS9O3yEIqCByr97EzbwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0/2lPHK5UfMEdeldVC+LjacfATEIIqbuMlENszuskS0=;
        b=FtB2xZrAjO9ySCyHWTHJLcvH/amUwhrt/ToWdOQD89xw9QnWjiR8oXlXIXk3IvqHgm
         YiCUMVWm0KTqLRz+JlOLaVDxusE54xHMGCVLSaEU7Ze9i6DPWRPS0VUYsSVstPSCFr2K
         BlwwpInU0HZ+VRGzhl8aFu6nUB6KBnthxs9AXm+E52bR03tSgW2dXIQn55pESqiJb9yX
         47/lZwMmBwD5BYIBEonKKy8iEyyPm4eu2DtRa2baldodnKSC7ynKek7GfQxZP/DwiwyH
         52xexv7BCpaBIyotePvOpu4GvqA2KDG8o2bPQ6+6VGN6X6/eey3dSpdnmvdzpFmLQS21
         zmyw==
X-Gm-Message-State: AJIora+dJLxheDfQKcwmiXOR03bhNH8VDkssGTDN/6QO9Howrr5dtYHn
        LF9XP3IDFZ+abvmxcSv6k01Hhg==
X-Google-Smtp-Source: AGRyM1vyJmHOFQtbOM/acSJRad/rfUJiqXcPsrBXxyNgySY37Cs61TI15mO3VeigBig5WXFiFiU//g==
X-Received: by 2002:a05:6870:ec93:b0:f3:3856:f573 with SMTP id eo19-20020a056870ec9300b000f33856f573mr3644633oab.17.1655410291205;
        Thu, 16 Jun 2022 13:11:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bh2-20020a056808180200b0032ed4543c36sm1314067oib.36.2022.06.16.13.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 13:11:31 -0700 (PDT)
Subject: Re: [PATCH] selftests: vm: Fix resource leak when return error
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220615093629.1330809-1-dingxiang@cmss.chinamobile.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <29be48c7-7178-6f25-c99b-0d11eb967539@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 14:11:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220615093629.1330809-1-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 3:36 AM, Ding Xiang wrote:
> When return on an error path, file handle need to be closed
> to prevent resource leak
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/vm/ksm_tests.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
> index 2fcf24312da8..f5e4e0bbd081 100644
> --- a/tools/testing/selftests/vm/ksm_tests.c
> +++ b/tools/testing/selftests/vm/ksm_tests.c
> @@ -54,6 +54,7 @@ static int ksm_write_sysfs(const char *file_path, unsigned long val)
>   	}
>   	if (fprintf(f, "%lu", val) < 0) {
>   		perror("fprintf");
> +		fclose(f);
>   		return 1;
>   	}
>   	fclose(f);
> @@ -72,6 +73,7 @@ static int ksm_read_sysfs(const char *file_path, unsigned long *val)
>   	}
>   	if (fscanf(f, "%lu", val) != 1) {
>   		perror("fscanf");
> +		fclose(f);
>   		return 1;
>   	}
>   	fclose(f);
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
