Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DED44FF3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiDMJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiDMJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:42:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC4E34BBE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:39:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z12so1671371edl.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=KhtSZr2c56r54K7IpY0qcNj65rBp4GOZJk8SwvpS20Q=;
        b=A1UR9raaChW76TEYQ6W7rbeQLFclE3Ev4UXUC48a3qNoNBpbUBpm3RwMBHLxEDTjRp
         urD+qi7Ny4fEyRtFuBtz8khDO4UlxKcgQg91Wah1DGrop6eqbEnoL5jZcHvFzzRluE6q
         PVpql2/AhUhT3insWejQuTozd2Wy5sc8NaZbRk0xNHxUA4MQtQheUODGiwxY3zJfVG+q
         HYN0ba4JvT0P6fbTLjBOdcjwiQ2PZB3nZM3I58D2zKiX9/2BhjObbHglbxQ+R+Be8w1E
         WBEtNfBU3KWskGvqMu+Z96tygaDFrQvFZksYOTjfDKqjUsCvegxDnesXjUS2FknsjQAs
         fS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KhtSZr2c56r54K7IpY0qcNj65rBp4GOZJk8SwvpS20Q=;
        b=SKYfr9QV9G1NhiY9KzdVU8ZScLu/PhOpnSDQMTT/qon7R/MCzOHnfOkEvgs2Z3Jrwx
         EdQj0OrzfGy6LINBT4fjl36Dg5gAG17KLSnJqcyM3TAfGISTBr/7WLWpu0s+TO90t1mQ
         9/a0qc4JbIC0uClrh9DbztaUDKERmmpix/126cV16MagIJLigvp96A5XmhDm0t9VNNVf
         jA/A6E9D+MWNKymseAqgdGy7Q8HgkGAQ7BZ+O5bwW8DKlRjVXC6qe2dW+o0GcRivH9v1
         XO9zEYcjoKZcbekUTuk4hg/y5gxQahru+kqs4Id1LtFm/V1n7DTYu0nWZRJVTsMWrnDA
         25eQ==
X-Gm-Message-State: AOAM532f6kV0K07Al/OQZd0y7G4zM1ELxcxxVWwWgX5CLRlLqt9UD9Dj
        9+jyJnHmWF5KvpLKNfg0V5qkyg==
X-Google-Smtp-Source: ABdhPJyuyhJH8cXmwjKUDWtoY4iM+tiNhiA1k/YC0JYrpYM1DsovaxG6C6wKC4F8SHD8/LjC92kMQQ==
X-Received: by 2002:a05:6402:2794:b0:419:2ea9:7de3 with SMTP id b20-20020a056402279400b004192ea97de3mr43060432ede.169.1649842791323;
        Wed, 13 Apr 2022 02:39:51 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090630c500b006e8044fa76bsm9711375ejb.143.2022.04.13.02.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:39:50 -0700 (PDT)
Message-ID: <aaa7960e-11cb-e5aa-d1c3-499c3353133d@linaro.org>
Date:   Wed, 13 Apr 2022 11:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] NFC: NULL out the dev->rfkill to prevent UAF
Content-Language: en-US
To:     Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220412053208.28681-1-linma@zju.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412053208.28681-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 07:32, Lin Ma wrote:
> Commit 3e3b5dfcd16a ("NFC: reorder the logic in nfc_{un,}register_device") 
> assumes the device_is_registered() in function nfc_dev_up() will help
> to check when the rfkill is unregistered. However, this check only 
> take effect when device_del(&dev->dev) is done in nfc_unregister_device().
> Hence, the rfkill object is still possible be dereferenced.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
