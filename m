Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFC4C1A56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiBWR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbiBWR60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:58:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812433D4B7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:57:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so1867890wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rcek9usknWwZHGRAFeM4pdUMbTDnc3p5b/Y1EIktamQ=;
        b=gaS84+x207AGFih23pahC7EOQRSJeQSHsBUg+VhpCqTt0HZ8v15C18k866b5C4N0q3
         K/Gl65R7ESpzW1BkvwFsM7TqJOX0yZKdNhjOGjwXWZos6j3BBh0wX/rNq20MPHdA6Zcr
         UeW1xyl1bStcLSzxzAS/WipBX69LhKjh79EG1dLDSVtwnLV4L+SBvKdpwN2Wb3QNB5nn
         UhS8+pkAwMee9jBZuZKgu2XQf1gHAAlJYZ6ZjLN6Ags3TGyf42a0tc1fQRvlF6aBKccM
         DgV5/qYpbCTyPrR7m4O/LpncMJ4/SQuTYYaSepcL5bK7uYqDK3rC1lA4yAPJqheTe9ck
         jBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rcek9usknWwZHGRAFeM4pdUMbTDnc3p5b/Y1EIktamQ=;
        b=VuF4RzFnZAa1JBtqeXpQXWOTS1tCc5GI7jS1ZJaOoqkzKUfeMSY1RzildQXYLo7fUT
         TjQtvaQHw5yEVcGXYTuGDz4ov+ysJLDbohp7l+knOXp7alqO67oVr92iLFei5s4eNrP5
         dv6czmWj6s6U/qPPDRb2SBCjKayJpbjKbAR8iFXM2nUlrYk7Azt506edTN/B6MfB0NrA
         vm783smbPkUUTszT786pcbmKh0rJLoHr43NOC4gBpoMLuA6Vs2W0/u0fm/zHG7zfGf2/
         bw0BBNVNkNebVGHp0QzlUYBtaERpZkCREKGI2e/9EYwM33HVCsiEqgItCUutPQSOXOMO
         Js0w==
X-Gm-Message-State: AOAM531uhVAx1xzBLrKeEEl4eWG82lsCJVatHoIiRGnZD5MfiFwlNXKn
        DpdXD4ftcCx7Z40HFIgVg7gt+QQCUD6LWg==
X-Google-Smtp-Source: ABdhPJzKg1U2OcMlWgGfciBmnTokMUe3EpxKmY38J1XDFStCj6ofKBWaJ5MKyFhcuQC6JNchDI84YA==
X-Received: by 2002:a05:600c:4107:b0:381:1c3:5d3 with SMTP id j7-20020a05600c410700b0038101c305d3mr338944wmi.107.1645639076892;
        Wed, 23 Feb 2022 09:57:56 -0800 (PST)
Received: from ?IPV6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id w4sm198966wre.102.2022.02.23.09.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:57:56 -0800 (PST)
Message-ID: <85d66f1d-0ae3-6608-4c54-7697295d5671@arista.com>
Date:   Wed, 23 Feb 2022 17:57:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] net/tcp: Merge TCP-MD5 inbound callbacks
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20220223121746.421327-1-dima@arista.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <20220223121746.421327-1-dima@arista.com>
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

On 2/23/22 12:17, Dmitry Safonov wrote:
> The functions do essentially the same work to verify TCP-MD5 sign.
> Code can be merged into one family-independent function in order to
> reduce copy'n'paste and generated code.
> Later with TCP-AO option added, this will allow to create one function
> that's responsible for segment verification, that will have all the
> different checks for MD5/AO/non-signed packets, which in turn will help
> to see checks for all corner-cases in one function, rather than spread
> around different families and functions.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
> v2: Rebased on net-next

On rebase I didn't check !CONFIG_TCP_MD5, and managed to forget to
change the function declaration for the stub. Duh!
I've sent version3.

Thanks, sorry for the noise,
          Dmitry
