Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FC053E7AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiFFKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiFFKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:46:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EADDD19C0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:46:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s12so20896490ejx.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GPYQ+AuyiK9k5AoDNUEqPMRN9dkEbEVU3yU8yAlgQoU=;
        b=BEv/JTxRgpGr7BGlfYF0U0qsD54SzLKZzQkeX5W/aGHpqjBXxHNmd0E4Gj5UVWAJyX
         BDYIhO/7JRo43hEmkPXy/6XwVNk/Jb7jJx8KkBtEiyqGRjrDacUR1ZMjjSDd50K+1rHo
         hM7ihbV1mYd3vwkKEMGEvuLCMeAIGPNrND5jrOwTgOsT3XzOLqql8lOVC1kUi4bAgVgF
         NQQuzxXQzxDeAQqgAZuS8Vw1TDlqpI4/F3Yje1H0tUCsxRKr2tNfMGSk+7TN/hZbVByV
         WAv15G7nbkKPF0Uu3oGPvIamY+2p8Ek6iCmbOoyzbS7svPnnVHsdgwjPE6neMlakC+tz
         Np1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GPYQ+AuyiK9k5AoDNUEqPMRN9dkEbEVU3yU8yAlgQoU=;
        b=k8qfs9utJ+ok/y/t7JYQ8kpJwIjPj9nG6M/dp9tC/1RLMkrd0QEPbpZMSRp7iUvrmZ
         biQo5GCJULQhFnwLaYAyz5AJ9dNagz7uzEuD1Dg6f4T1olNeyPdSFY0smHXpcs9/JUbY
         JC6tGSUVUL8CG06IS7uwROAPOpE2PzPeXQEFDXJHBh7qb10O2VXMLqfQYIfbfxy8IT8R
         SCZpfYH/Qh6pTgROrLCn+a4/NFjoVKhjfiVVy+7DVoL2UGivI0JTJU22VnqtNeYLMId2
         +aS+FfBfamyJIf/ssjZTFaGxizP1z4CV9ImFvm1ADYif8ytZyooGG7iEt4YYjwqRzX2V
         4nIg==
X-Gm-Message-State: AOAM533o2j+9JFa3C3DpyvDvR1ylPXG++OCdBOD7+/UAqoNO6WDz3HfI
        M7i/31Nrn5PUNsDl+FZ9+w1grA==
X-Google-Smtp-Source: ABdhPJw3Gcs+m6/c2jbbElb142U1e3voZcEH6hO7Gp5nRMsTCw9B4WCDP0CMjSTAGUBINsW4ooXnqw==
X-Received: by 2002:a17:907:60d4:b0:708:850:bc91 with SMTP id hv20-20020a17090760d400b007080850bc91mr21580631ejc.102.1654512369943;
        Mon, 06 Jun 2022 03:46:09 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c24-20020a056402159800b0042617ba63c2sm8422723edv.76.2022.06.06.03.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 03:46:09 -0700 (PDT)
Message-ID: <80637186-e3ef-14c1-78e5-bfa6deec595a@linaro.org>
Date:   Mon, 6 Jun 2022 12:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] nfc: nfcmrvl: Fix memory leak in
 nfcmrvl_play_deferred
Content-Language: en-US
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220605081455.34610-1-ruc_zhangxiaohui@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220605081455.34610-1-ruc_zhangxiaohui@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2022 10:14, Xiaohui Zhang wrote:
> From: xiaohuizhang98 <ruc_zhangxiaohui@163.com>
> 
> We detected a suspected bug with our code clone detection tool.
> 
> Similar to the handling of play_deferred in commit 19cfe912c37b
> ("Bluetooth: btusb: Fix memory leak in play_deferred"), we thought
> a patch might be needed here as well.
> 
> Currently usb_submit_urb is called directly to submit deferred tx
> urbs after unanchor them.
> 
> So the usb_giveback_urb_bh would failed to unref it in usb_unanchor_urb
> and cause memory leak.
> 
> Put those urbs in tx_anchor to avoid the leak, and also fix the error
> handling.
> 
> Signed-off-by: xiaohuizhang98 <ruc_zhangxiaohui@163.com>

This name still does not match your name used in email.

Best regards,
Krzysztof
