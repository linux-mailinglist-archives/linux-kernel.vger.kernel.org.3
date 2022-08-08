Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF79158C853
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiHHM1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242315AbiHHM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:26:57 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C248DEC4;
        Mon,  8 Aug 2022 05:26:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10bd4812c29so10292026fac.11;
        Mon, 08 Aug 2022 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc;
        bh=lsnBErhuU0r6TlMRuprIA+8yllP/XwwhzP1dc85oLRo=;
        b=X6XEAuWxtEVncbUVnM4LteJBd0Dc1i8ZXlHAd1Db9JERJMXK+jn6zh8haWzEIuTpvJ
         e/9/5EnD48wz+guGpkQRTgeoenkEyewYZArRr/c7jrvN1dcARmCLjrh4q/3i65j5ecMl
         4t8TF1kiziTLb8j/fmXYCP0A0hcZz8qBPzuMYdGGJbkOEXhCMXTmyH6nxZMv9x8qFdMX
         9pKfdk1mcDa4qdfycOqjp/NJrRbF5ydbVaDE/8lS6PRBApv3xypLwonIMevUMHieOeWF
         VVO7h5QdmzvdUbKZ4sSxTO5wr3dsgYJA5TDsNHXuRO3PkcuFs/xSFxLw93tZLRvY0W2e
         M9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc;
        bh=lsnBErhuU0r6TlMRuprIA+8yllP/XwwhzP1dc85oLRo=;
        b=ZVtWLkrThjjd1JMQSjlKEKN52h8yfEeOc3q7HvrQt6OfDNcLVouGfiKdjU44DYfQPE
         HZ03YfhFkkLFLgWY60G6DL+D3oRgEepfuRTppFwehAb+wFRJiSBL8NqVL6e0hKGbzKCv
         5v/E1FclDCgTt5hZX2sSNc3o2SgMUgO+U4xpFnW7O8oyo7XLpyE/JFZLgWEvkgewXYpw
         5xJV7Cng0J0zlobT0VCkYUEx0CkpXWhnOIqNmGKsu9Zck4nxDjIb3lICHoOp80ODqR5L
         ZKEB7tOfOMVTyqDiCBTPsk6WucwjHGxOM3U+ZGhenBNJoAPW43YthhX/1MVSI5Wfchj/
         Cf3w==
X-Gm-Message-State: ACgBeo3hPapme2CSkchK+4cYyPYe/ybTxWaMiFuUAvanHrbKp8EedhMV
        bxjQjJ/lntY3/lAQKgBIAw==
X-Google-Smtp-Source: AA6agR50jq+nfiCg6C40xQ7OLmWG0uCJ0WEwg5bSHfc4fFU87YwMbz6vkTdnumtoDH5wUQXXhydsnA==
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id ba22-20020a056870c59600b001016409ae62mr11777265oab.112.1659961615326;
        Mon, 08 Aug 2022 05:26:55 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id p84-20020acaf157000000b00342df642fd3sm916967oih.48.2022.08.08.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:26:54 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:3153:e085:df0f:abc2])
        by serve.minyard.net (Postfix) with ESMTPSA id A861A1800FA;
        Mon,  8 Aug 2022 12:26:53 +0000 (UTC)
Date:   Mon, 8 Aug 2022 07:26:52 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        openbmc@lists.ozlabs.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-binding: ipmi: add fallback to npcm845 compatible
Message-ID: <20220808122652.GO3834@minyard.net>
Reply-To: minyard@acm.org
References: <20220808075452.115907-1-tmaimon77@gmail.com>
 <da83671e-08b9-2d68-e5d3-d9b09c105bb4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da83671e-08b9-2d68-e5d3-d9b09c105bb4@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 11:11:16AM +0300, Krzysztof Kozlowski wrote:
> On 08/08/2022 09:54, Tomer Maimon wrote:
> > Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> > string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> > 
> > Fixes: 84261749e58a ("dt-bindings: ipmi: Add npcm845 compatible")
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Ok, I think I understand how this is supposed to work.  It's not
altogether clear from the device tree documentation.  It says in
Documentation/devicetree/bindings/writing-bindings.rst:

- DO make 'compatible' properties specific. DON'T use wildcards in compatible
  strings. DO use fallback compatibles when devices are the same as or a subset
  of prior implementations. DO add new compatibles in case there are new
  features or bugs.

AFAICT, there are no new features or bugs, just a new SOC with the same
device.  In general usage I have seen, you would just use the same
compatible.  However, if I understand this, that last sentence should say:

  DO add new compatibles in case there is a new version of hardware with
  the possibility of new features and/or bugs.

Also, the term "specific" is, ironically, vague.  Specific to what?

It would be nice to have something added to "Typical cases and caveats"
that says:

- If you are writing a binding for a new device that is the same as, or
  a superset of another existing device, add a new specific compatible
  for the new device followed by a compatible for the existing device.
  That way, if the device has new bugs or new specific features are
  added, you can add workarounds without modifying the device tree.

Anyway, I have added this to my tree with your ack.

-corey

> 
> 
> Best regards,
> Krzysztof
