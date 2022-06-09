Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A686E545658
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiFIVND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbiFIVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:12:55 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722E26D8AD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:12:54 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g17-20020a9d6491000000b0060c0f0101ffso6005334otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+w8VVwED6Dp8wTgVB+vZ7Un8RsUPAYrcjHRsKAD4xYo=;
        b=InsJbxZvLSkW6zLt3p6dpNfxY2n8892EJhnqGHT9ypiLAMtlGyFQTSMqKwKgDgDjV5
         iXKFqQTPl1XJHrEeBYg0+0rGmHZiRgZK/mMTrd5PdOWXVoLP8FtsG/q8peJpbJ2BcYy1
         7vOUIrm7WI+Mwr66LkywqKxeM8wRrdIToCRaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+w8VVwED6Dp8wTgVB+vZ7Un8RsUPAYrcjHRsKAD4xYo=;
        b=X217SyJZFD83itx0hRK8nWqXkLPGJcdgRG7GdsWNUpMEwP2RtHw7San9mYlcdhaOh7
         ZpqXcCTbW1D8gEQp2RzVG6f51e3oHs7hplsXhGIXF1YVlTjZTFAnvaZxIZlFot5aGqlx
         gtIPB2J3+wKRODN5er5QuJk6WQsKoI6jbSzg+ZC/OmpM39g6UNG54h/lMSU+Vk5YseFY
         fKZX/ecDNOz8vtESfcmuJkpepUpY7o+zAg3krZzdOoKp9Aqcgi41v0zwzdBh2wBVS2xo
         8SNc5wPPHk0hJDbGurIHGPPvsDMTM3XTgp75LbQFOJ3CYh5ke2/iajp4TpuNvuhkzzQ4
         IA9w==
X-Gm-Message-State: AOAM530hL9aKHGnOHmAd3eEjko9BT3h3HHT2P4IPVLYfLGPjkpVY2yxX
        ZsXzY7IygvyOic+Kq4Mp6uG1bhSLOvXQPA==
X-Google-Smtp-Source: ABdhPJyNQ0HXAQ4Z6PJBiKgrnpq9DxaLq1ka8Z5MjlwseLsdKqrTZSLQJ3UbUlYFLUJPgSLmW/zZDQ==
X-Received: by 2002:a05:6830:1e89:b0:60c:1c6d:476b with SMTP id n9-20020a0568301e8900b0060c1c6d476bmr3975832otr.288.1654809173354;
        Thu, 09 Jun 2022 14:12:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id lc15-20020a056871418f00b000f5eb6b409bsm10939453oab.45.2022.06.09.14.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 14:12:52 -0700 (PDT)
Subject: Re: [PATCH] selftests: make use of GUP_TEST_FILE macro
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Nico Pache <npache@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220609203217.3206247-1-jsavitz@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cd8ca757-b041-cc3b-75af-eef20df65019@linuxfoundation.org>
Date:   Thu, 9 Jun 2022 15:12:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220609203217.3206247-1-jsavitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 2:32 PM, Joel Savitz wrote:
> Commit 17de1e559cf1 ("selftests: clarify common error when running
> gup_test") had most of its hunks dropped due to a conflict with another
> patch accepted into Linux around the same time that implemented the same
> behavior as a subset of other changes.
> 
> However, the remaining hunk defines the GUP_TEST_FILE macro without
> making use of it. This patch makes use of the macro in the two relevant
> places.
> 
> Furthermore, the above mentioned commit's log message erroneously describes
> the changes that were dropped from the patch.
> 
> This patch corrects the record.
> 
> Fixes: 17de1e559cf1 ("selftests: clarify common error when running gup_test")
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>   tools/testing/selftests/vm/gup_test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> index 6bb36ca71cb5..a309876d832f 100644
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -209,7 +209,7 @@ int main(int argc, char **argv)
>   	if (write)
>   		gup.gup_flags |= FOLL_WRITE;
>   
> -	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
> +	gup_fd = open(GUP_TEST_FILE, O_RDWR);
>   	if (gup_fd == -1) {
>   		switch (errno) {
>   		case EACCES:
> @@ -224,7 +224,7 @@ int main(int argc, char **argv)
>   			printf("check if CONFIG_GUP_TEST is enabled in kernel config\n");
>   			break;
>   		default:
> -			perror("failed to open /sys/kernel/debug/gup_test");
> +			perror("failed to open " GUP_TEST_FILE);
>   			break;
>   		}
>   		exit(KSFT_SKIP);
> 

Thank you for finding and fixing the problem.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
