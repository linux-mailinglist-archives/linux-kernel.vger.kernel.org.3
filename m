Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA4E4D4184
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiCJHIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiCJHIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:08:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8516013112F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:07:16 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 179253F222
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646896035;
        bh=6p/D+Bc/qqmeMKK+FRdwTSZQdroM/n8bZhOT25VprHM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XbV8zWV9qJpG+7aItlKbTcv+BYgARY4Hx16Z5QxZ1Vq6E7LTk4xBItldPHkwUJB8H
         tziGEcLKGOX/ClFB6NsHd6G0A3nG6rzP8utcfKiCHkTGnD+V/BfwUOHLz3KuxF7qKD
         GN5cAArsQFE+ZpB7OWpe2ztST3AA1VBCrlfxE2Uf+cwkkHxj3Tz+6RwS7Sccl+oEwG
         onQvTZveo1gZ5diOammmBNpapJjYa/LI13fpkjDOsUXd6FHpDVxZWVT0IDolQIL+Sc
         XHaw4BmivVnvDDdMcBiRB4F5p1MuelyE5EyjG1hOkpF3rQFF+AzoVI1hcVUPaWOS12
         FHfFvLHOaINAQ==
Received: by mail-ed1-f69.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so2581027edq.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6p/D+Bc/qqmeMKK+FRdwTSZQdroM/n8bZhOT25VprHM=;
        b=dSuVush4v5VCG4mnyAfKE+nTtIKgSw/DFNkYiKbCCGUWxuAfi3TxHPaujeNBEF2zOi
         9gSEX8L0X9fkraqUgqkrROZfnQgJ6SMmLXOs/aIxEYVc06aaJlTXlccejmdFLLCcbO8h
         iwOW/d7l1QRnviLrxRzfac0+k096NzKCZNthJQtkk9Z6YJD42WJeURKe7LinK4XGj+mj
         hZSH4GTHdVnXEfZ+EYeYS8hUJjw6SDHfpaNd3NwtCBkdIYhtoAJseVRKwqQcNgakn9DM
         pp1mHQDKU28G46+gcHcohDsiuaOGNCrPc95sr1oq5j/+2V4rbqS/N0YtNHO5QRnU5w3v
         KqPQ==
X-Gm-Message-State: AOAM531+5bPxu4IkRVPzHZ8Gvr4cJ42R0LM1nO6kcHvnK+Ofb20IRa1m
        e1iLKbwQpkLN++hheBOhN4iG6mxK2v/+YmXJxi+P0QtwkfG7RcPQiuhL0r6fILNMtYDlRzeQ6/o
        Hxqe6n4Pi8mvXrGpehCLVvpMUWz2P2tfxQmqcIV0axw==
X-Received: by 2002:a17:906:2a92:b0:6cd:4349:dc1a with SMTP id l18-20020a1709062a9200b006cd4349dc1amr2935074eje.648.1646896034810;
        Wed, 09 Mar 2022 23:07:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZQqV4+JLCJnqqzlEYSJJui8mweQhJgkoLXyXvqcczf2LMXmsaFlGI/RYma6UcVMLsfxt9MQ==
X-Received: by 2002:a17:906:2a92:b0:6cd:4349:dc1a with SMTP id l18-20020a1709062a9200b006cd4349dc1amr2935064eje.648.1646896034627;
        Wed, 09 Mar 2022 23:07:14 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm1505876ejd.118.2022.03.09.23.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 23:07:14 -0800 (PST)
Message-ID: <7a5f8296-be69-6dac-fed2-45dc2b85e1d6@canonical.com>
Date:   Thu, 10 Mar 2022 08:07:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add artpec8 compatible string
 for exynos-thermal
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220310013140.127026-2-hypmean.kim@samsung.com>
 <20220310013140.127026-1-hypmean.kim@samsung.com>
 <CGME20220310013129epcas3p1110cbdfbd3d72ade45b8d98433ca0aac@epcms2p4>
 <20220310015318epcms2p42622831ee212753057763d946282bef7@epcms2p4>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310015318epcms2p42622831ee212753057763d946282bef7@epcms2p4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 02:53, Sang Min Kim wrote:
>  
> 
> Extend the exynos-thermal dt bindings document to include compatible
> 
> string supporting artpec8 SoC.
> 

Please resend without HTML. Use git to create and send patches.


Best regards,
Krzysztof
