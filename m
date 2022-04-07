Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252284F8191
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbiDGO2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiDGO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:28:06 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94518DA9A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:25:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g11so1183881qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SFCu5OPfr2u719QHLQmAFOOnrZqifL8kEuqIFWPJZfw=;
        b=nkVklxuWxxl1JFd86S9ghjBHOJvTmapWl7hhrYXdo946L+xXZ59GFWXfXDC6rxS/95
         8G3WeOIB/AdwIz+EAAdHoo33AbOz6KiqL+WKZMCXBMWeyQ2KAq0MdYMB8BjH3lSuCvjR
         f79Aap2K+dCWRekmqt0Evl5jKtmk4UvK07fbaICwfSjmBXGuSfnbQ1ihrGNejys6XF5F
         9vPwbPXIIQu1CMnjzyu0XENj6rQUAZy7uHtFwuMIPZrQ2U7qLj1tjq8uGYsd1mLXjlXv
         sY96j02kjbUOqVrgs2TukSHSytmAchK8qTurOx7GHHe6ehdRj7x8/TIKFn4c+7iNpc8J
         +iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SFCu5OPfr2u719QHLQmAFOOnrZqifL8kEuqIFWPJZfw=;
        b=P+FHduVw0RONgRxiYYwUylafcCPsc9esWKk/tQGjeo791uF86Q7knQfpOntIn0cos2
         IuznjfO9Q/lSz8NP7sEVePf3EdWWC3peXVillrnXqCXvO1+wQ9D/XO3giwBqMch7+dGX
         nU2k+cplDPmjDVVsYzTKSUngwXW/DMwWQlpqgGSU1Q4NQFQr+BFIN6y9OWPNDXGL/5XT
         GKDgvDx+xYWbbgnBXXZJrBZDaqRYbZh6FKg1D43eFlAn710hEsq7V9WxBq/amwQVEbqU
         miDmy95w4kbZmwTpOq1GvOMaLR5MwZxQCzKjAf0JuiGcZlqU7a/gwIMF+kDtuMiFu5MZ
         HebA==
X-Gm-Message-State: AOAM533Ym3YDKFYyfwMzISanEFt8ekNwqGuqjcrpGti2SlPKeUfn1x6h
        DmqMacb/5jGROUjjp+mP6heZDTgkvwQ32A==
X-Google-Smtp-Source: ABdhPJyoDvpsbtXc4mfn920OWQuGw8iLgBJ+mS0m+1UtIn9V7+msI3aLvZeekwcERfCqF6qVgniHBg==
X-Received: by 2002:a05:620a:178f:b0:699:90a7:ffdf with SMTP id ay15-20020a05620a178f00b0069990a7ffdfmr8978417qkb.523.1649341528353;
        Thu, 07 Apr 2022 07:25:28 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm13059428qki.49.2022.04.07.07.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:25:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ncT4g-00EF4I-LL; Thu, 07 Apr 2022 11:25:26 -0300
Date:   Thu, 7 Apr 2022 11:25:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, =robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        p.rosenberger@kunbus.com, lukas@wunner.de
Subject: Re: [PATCH 1/5] tpm: add functions to set and unset the tpm chips
 reset state
Message-ID: <20220407142526.GW64706@ziepe.ca>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
 <20220407111849.5676-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407111849.5676-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 01:18:45PM +0200, Lino Sanfilippo wrote:
> Currently it is not possible to set the tpm chips reset state from within
> the driver. This is problematic if the chip is still in reset after the
> system comes up. This may e.g. happen if the reset line is pulled into
> reset state by a pin configuration in the device tree.

This kind of system is badly misdesigned.

TPM PCRs fundementally cannot work if the TPM reset line is under
software control.

Jason
