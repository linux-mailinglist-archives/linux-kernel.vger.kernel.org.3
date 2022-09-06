Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA45AF83B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIFXG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIFXGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:06:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D68285ABD;
        Tue,  6 Sep 2022 16:06:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso16437470pjh.5;
        Tue, 06 Sep 2022 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MmjTN2umMbTipMC2ywC8SfF6zMfKOmm31STCj40Urr8=;
        b=h0MW8YZ3af4vyBRPdWHoZvJVTDmJk+IeQCWw4O+ymMP9imoO49JCKRGm5SDKyvJJyX
         6vcAP1Ml6wnWq/ltoGqGAXIEkXtVFrh9kX1o4y2l0kkgC4QRXchbPiIWjDNbQXND8pMl
         jD7K2SIGx0VpK7ToU/z0UYe9IH1bppvRJaqimqX1YYA3l32zDhOz6HMQY5LcEl9mjldp
         hqNcCCDZrTNlug0DXa37ZfrIXiiVFnfK0rY/ORRfjypubjWHLRVLrmP/b6jjK0qj4MLd
         9Tpr7N/y7CPTPgZw83JwwEcyjsRNGVK8oK/VV0KUlPbUL17YMjcJPbkfecBFnX/fcJWK
         bbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MmjTN2umMbTipMC2ywC8SfF6zMfKOmm31STCj40Urr8=;
        b=1hDaekW9MbU45CJ8THf7gp1my/0VUpxjZ1juTewk2Y1rcWfte463vEAkAD3grWAVAi
         WSZWjnA3xqdep5fIhm06vwZ0V35DRd8aJZKBOYL9F4vAGuhBaXyLXjXUqtbf2vy9ZmQG
         +KWFTqrRJ8oFEG+qi6PmnIHzI5M9raptTrWlGyZcxljgvKQnBbrbUNAVBwP7V8rZXwsd
         mDQKNhqz6XDYprC9qu7BCXKE1N9RfKYqPzCYqb6d20aLpYVX5kPmIxpUJlqYJbJ+6vQy
         /mmsIAQCsmeoKMglO+Z2GNiugsRQ6d6XUlO4mlzxvX8I4wPGAvL1AZkj/Ly38dAXUa7n
         ESLQ==
X-Gm-Message-State: ACgBeo1qJBoLQYQ+zrb0XGiMR0mEfntl3j5pqz11YPMktqmugLy2WDDq
        mG2RI0BU2wlukXQVMYKwzvc=
X-Google-Smtp-Source: AA6agR5D2JrGrU7ucf2z4l+b25hQbtbvjiNMLlshQ82RsKrsYelSUBl0eIRvo+9u5Bo2TwKN83k/aw==
X-Received: by 2002:a17:902:e5c7:b0:174:e71e:30ef with SMTP id u7-20020a170902e5c700b00174e71e30efmr802328plf.30.1662505611411;
        Tue, 06 Sep 2022 16:06:51 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id b14-20020a621b0e000000b005377c74c409sm10879125pfb.4.2022.09.06.16.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 16:06:50 -0700 (PDT)
Date:   Tue, 6 Sep 2022 16:06:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        David Heidelberg <david@ixit.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: elants_i2c: Add
 eth3915n touchscreen chip
Message-ID: <YxfShztWKwErrxyt@google.com>
References: <20220902082843.1.I7da6ff6c8e8700624d61e51ff7d09e151bd83dcb@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902082843.1.I7da6ff6c8e8700624d61e51ff7d09e151bd83dcb@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:32:35AM +0000, Yunlong Jia wrote:
> Add an elan touch screen chip eth3915n.
> This chip requires more delay time than the eth3500.
> 
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>

Do you have company email (instead of Google partner domain account) by
chance?

> ---
> 
>  .../devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> index a9b53c2e6f0ab..d28625372f5ac 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - elan,ektf3624
>        - elan,ekth3500
> +      - elan,ekth3915
>  
>    reg:
>      maxItems: 1
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
