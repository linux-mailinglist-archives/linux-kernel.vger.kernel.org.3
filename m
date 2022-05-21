Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48C52FCDC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbiEUN2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiEUN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:27:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435869280
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:27:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so9932440pju.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tTAMJFDQpHMdUygoSr8l9LL9ZmzUy0NlMIpDEDNVmEA=;
        b=RQve9VSO2CNRazEOP/xBsKD+EcJ6OalAc8y7/3QfLEDNAmSvZrmwQ2JdYaZKWyXWEX
         jnDDaj+dUEr0VCWT4UTXh4ZA7YF1aQNwwF35Xw/hYSZE7fPDP7GSQHq73R0WnhiPvASA
         SUxEGnuugQJOzyuH3bj10bZ5FUZGJjesL5UWL7ybIDj9XMLGtg4eMb3vP6ezawxW3boB
         hwB1wZz/cxCKmj+Xp8QcFfpkKgvaxM02FAcZqFDDfTJw2FARCV+1EEznYMt0Ak+73953
         tjGzSLQ0jZ/QcSzCG3qBtPs99kVcfqveqA6VyamF1T4KyBNp9Q3ah2Ef+dzE65Hpnq+h
         FEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tTAMJFDQpHMdUygoSr8l9LL9ZmzUy0NlMIpDEDNVmEA=;
        b=xfjJ9DklqqDvDSD+DIcd21ZN6QHQqFgNxOo94STFNSm4EeylLaqTtN4+Wti316txtx
         dkTpAWrcom49E56BwLrMPdn3xLMhy6LKe3t8fS6ZYOpdUDNYoJOnrUw7me0N4DzB3o5d
         VxMewibUg/IFh5vswH9zDWSotJM/hFWed49UK5fV5CYol5Puqx2KJmFWKjEaRtPgN0qv
         w9xBpXY/OUoCkz2RGscBeSNvkYEcYfPqiDh7uEn23p829pkpYA9sULv4b3hMQD3RU9Ji
         EPJOQ9IdSNqpCwB1oUjXk/3vNguReKH6dLxlY5ahapTfiqeDSNyFs163aZOqQixj1d+7
         UPyA==
X-Gm-Message-State: AOAM5338hydqzPzl4VdHa3Ri64G/aIW8ve27CQLrmlwmDkPAk+/kOiLz
        B4ZLX+jpcSs0HgsvyDbBBLR3og==
X-Google-Smtp-Source: ABdhPJxnDIc8+VQ6EsT1L13Ll0t5vzpppz1c/gTEWcDnqFaixZmHi40zGzMXlyK5BWk/niQ8X5xQRw==
X-Received: by 2002:a17:902:c752:b0:161:7cb4:78b1 with SMTP id q18-20020a170902c75200b001617cb478b1mr14263360plq.166.1653139676486;
        Sat, 21 May 2022 06:27:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id 144-20020a621696000000b0050dc76281acsm3643655pfw.134.2022.05.21.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:27:55 -0700 (PDT)
Date:   Sat, 21 May 2022 21:27:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: Convert CoreSight CPU debug to DT
 schema
Message-ID: <20220521132750.GA711227@leoy-ThinkPad-X240s>
References: <20220520214416.302127-1-robh@kernel.org>
 <20220520214416.302127-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520214416.302127-3-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:44:16PM -0500, Rob Herring wrote:
> Convert the CoreSight CPU debug binding to DT schema format.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Compared line by line between old DT binding and new yaml file,
I found only one difference is in the new yaml file it doesn't
contain below info for constraints CPU power states:

  "using "cpuidle.off=1" or "nohlt" in the kernel command line or
   sysfs node ..."

IIUC, yaml file will be used not only for Linux kernel, thus it makes
sense to remove the Linux specific info.  Looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
