Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DE34D05EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244643AbiCGSGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbiCGSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:06:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ADA7DE1C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:05:51 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B37F3F5FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646676350;
        bh=Xrzjqgd/gsl48ny3tXE+vznfcNU58djyNkJpGir9KQM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SrMz0L+DGu7LtMCVoOEdsxsSbnTbbMPBdwRBqg3kelLbm2bZQOdX/mOQ6ZjQlbajF
         b3vI5UfvkmJvER7BKINzdGlPgUcJEqMeIu5Kh0E0DHUSlFE0lBQldu+gX6qWNt54+o
         GBvPovAB4oxd+V7KqLWLa9W0Sf7TzfQU51yKR1ltylxYaftNowAqlF4Q3ihkIR6sXW
         Qe47LxEjV+Fo+dJC+wYGT3mMjHFWlyREZ7ocTDdxJvDpWhnx7fpFPeBtthX9yNayoi
         pqOSxvUrbsTd1NjBpHfqV7OwkRXbXLKxs+UbkpnwF5KBWq+YgwXb5xRrUHvwb53V/f
         Ii9jh/AFVpkJA==
Received: by mail-ed1-f70.google.com with SMTP id h17-20020a05640250d100b004133863d836so9119291edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xrzjqgd/gsl48ny3tXE+vznfcNU58djyNkJpGir9KQM=;
        b=E4YU7klTS3SB5f6Gz53uGIrNR488zZmDl57ECu1vJ1UvxetCYDGLUU+eYC528uem1S
         SrUJhAQZV6Li0Qj/YrBUkMgn2mvi+4cKM0o+5yjbRdNPCgoLhZYXhkIx/BBbQi92f51P
         S5moNJrORhaHobo4PpRDFwLgjwd/pChj920Lp/ohE0fOTRVP7TNJJ4bqNSZiTy5jj1D1
         ar1sCW7lkmZUNAIL5X+e39qOiFpUm+IUdPZyPBL458MXpiFksAy3SwgCdgpemGW8tyaB
         vEa1o2sKD8T2x0HL2ZQMGqJixoqWZshYqlDLN6BEhiV32R70uI7YWm2YWZHtUgm/Wwpg
         c22g==
X-Gm-Message-State: AOAM533eZ02O9ZDC9KhrM7e3nwMRYVBbvsMfi8no33aIrFgbML/0Erwy
        pJeGazYGAB0F2g56CCBs86puV5KkFTJde0vV88EeuRd8Xb+bchjfHLJ5HZAVAVOUjc5+7Z+XXzk
        9tWOILotSlJsAPUoceN+lfPZKwwnBx82YMB23/NsgGA==
X-Received: by 2002:a17:906:3cb1:b0:6ce:2a97:5ade with SMTP id b17-20020a1709063cb100b006ce2a975ademr9760141ejh.728.1646676349692;
        Mon, 07 Mar 2022 10:05:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwe67Q+swcXzSKOn48eStmQdS6VNlblylpGjl5p/IJ03rs754mXnx2sOAo7MoENuJ8rlIpWlw==
X-Received: by 2002:a17:906:3cb1:b0:6ce:2a97:5ade with SMTP id b17-20020a1709063cb100b006ce2a975ademr9760126ejh.728.1646676349499;
        Mon, 07 Mar 2022 10:05:49 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id yy18-20020a170906dc1200b006d6e5c75029sm5039499ejb.187.2022.03.07.10.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:05:47 -0800 (PST)
Message-ID: <9cb70402-432d-0f45-37aa-c9d613c0a284@canonical.com>
Date:   Mon, 7 Mar 2022 19:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MAINTAINERS: dt-bindings: update Krzysztof Kozlowski's
 email
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220307172901.156929-1-krzysztof.kozlowski@canonical.com>
 <CAL_Jsq+ufttuegvW_STJ7yjDY_5TRAuLNqfAAxR9gjrqtbMP8w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAL_Jsq+ufttuegvW_STJ7yjDY_5TRAuLNqfAAxR9gjrqtbMP8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 19:03, Rob Herring wrote:
> On Mon, Mar 7, 2022 at 11:29 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Use Krzysztof Kozlowski's @kernel.org account in dt-bindings maintainer
>> entry.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> Hi Rob,
>>
>> Could you take this one directly (optionally squash with the patch
>> adding me as maintainer)?
>>
>> My email address also appears in the bindings. For now mailmap will
>> handle it (see my other commit). I will change it after merge window,
>> because some of the bindings are in separate for-next branches.
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4e88b4e17e35..48b0cf606be0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14604,7 +14604,7 @@ F:      scripts/dtc/
>>
>>  OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
>>  M:     Rob Herring <robh+dt@kernel.org>
>> -M:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +M:     Krzysztof Kozlowski <krzk+dt@kernel.org>
> 
> FWIW, the +dt never really worked that well for me. I've concluded
> that anything that relies on submitters getting things right doesn't
> work.

I was afraid of this. :) Still this is the high-volume maintainership,
so I need to try to organize it.


Best regards,
Krzysztof
