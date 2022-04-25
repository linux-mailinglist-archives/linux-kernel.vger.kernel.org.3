Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8150E9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiDYTxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbiDYTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:53:27 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC67219F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:50:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k29-20020a056830243d00b006040caa0988so11539128ots.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+Ynvk9k1i6GQRM+MV2+9dS2nsvFZOplFS8XjPwj2JY=;
        b=GPpJwnCA0IxWGmcqd1hVFKoiy5X3+AVVBOkwbZ/JEOUEubYt1lAPeL97pgFt/nzeFc
         wxnIjUzDR8+z/RBbbYsj0N5yJMPdrFRt0OqkYA844bieBt10LtJerxKhrvk/YDLbLJ0t
         s2oyhy/wqR0WZad03VhvPHIhR/GG6TEXSTSi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+Ynvk9k1i6GQRM+MV2+9dS2nsvFZOplFS8XjPwj2JY=;
        b=t6p+wGJjzcpkDt7mxFpDIKACBGVUFcOGtQBgGFo8G6hP/LriRw0BgVq+9DsULV5Xwo
         k4IBFXVrinauLBIc8SOZmrjv6Ql2i8H7d2LtRh9Fr6/vIEmwCaLR47TXWasUmQLU7gj1
         RLXiLisMeFWTOs3nSMze2DyDmgkKeaA//Gu1Fdfv9q/DHgJ0n17mK9ow0eCGgNf4f1gm
         z4uluezhAcoHDZVlHEbvSFD6o8nZv1E6SQGV4zH/uc8vZTvXTw++hXRrMF48FGTWNjIi
         VzIPeOlTnWNqOR3zjijCQ1C1U4i3EgfIpGgbUR4NwU1t/+j8hXi0PEuG9Q5rhzxANclH
         BcBg==
X-Gm-Message-State: AOAM5301QAV2vTr7kM6KCFV6MwyCPIktlbUFwD7SJzxhJlLIOKUi/NMQ
        Qjqa/Lb3g5hiVTZ2M9fIeXgXt4TtAuP71g==
X-Google-Smtp-Source: ABdhPJzTgZoKtLqoY7J9I5gpYl71byRdQ1d52bOYMiiAaw+SjxaTSA+6aWkNJpJtbdSDGr7PsZYj8w==
X-Received: by 2002:a9d:6283:0:b0:605:4ee4:6d56 with SMTP id x3-20020a9d6283000000b006054ee46d56mr7042496otk.89.1650916220282;
        Mon, 25 Apr 2022 12:50:20 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g11-20020a9d5f8b000000b00605bff9c2dbsm768166oti.42.2022.04.25.12.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 12:50:20 -0700 (PDT)
Subject: Re: [PATCH 5/5] selftests: firmware: Add ZSTD compressed file tests
To:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220421152908.4718-1-tiwai@suse.de>
 <20220421152908.4718-6-tiwai@suse.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e629df2a-93f2-8e82-31c5-ceb5b295f71b@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 13:50:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220421152908.4718-6-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 9:29 AM, Takashi Iwai wrote:
> It's similar like XZ compressed files.  For the simplicity, both XZ
> and ZSTD tests are done in a single function.  The format is specified
> via $COMPRESS_FORMAT and the compression function is pre-defined.
> 
> Link: https://lore.kernel.org/r/20210127154939.13288-5-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   .../selftests/firmware/fw_filesystem.sh       | 76 ++++++++++++++-----
>   tools/testing/selftests/firmware/fw_lib.sh    | 12 ++-
>   2 files changed, 65 insertions(+), 23 deletions(-)
> 

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
