Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3672B528745
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbiEPOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244674AbiEPOlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:41:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB552CCB7;
        Mon, 16 May 2022 07:41:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 674151F42330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652712069;
        bh=8BYTLgL7DNJMJHGxPDAPccqtEpDPhR7Z3zFk1UgBjIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsXq9RO5eqw/T8yDtZ9lIbJ1TmFcfGOYBVOnvXCQYo0FpkwjkzWr5K+eQFZnBaOml
         fCBWcoMOeljiNkSas8UyyJqbj9Vz4AXbYnjHK4NwYb5+78oRZ08JyAVGl7QauMJhrU
         IgX+OQu/IdZFaguIkyeI51Ze64t86HjO4TtIScPoxQMA7fzBFejhchi6hmCthMzN9I
         Qfv3Zp8wjs2O+E4uYet8U58e1c4I/HZowCndnSyi2NyVXe2RAfZA8FEHinx9g55Ayd
         h7sA3v5xQYcifDGKTfi9yXTQdqcF8tkMoAFWlG8uAYxFsL9PL5dENowgbelKhL5X2j
         TzGD5vVwGGNtw==
Date:   Mon, 16 May 2022 10:41:04 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg
 exclusive to mt819x
Message-ID: <20220516144104.yvy2a2lncdcgznu6@notapiano>
References: <20220511195452.871897-1-nfraprado@collabora.com>
 <20220511195452.871897-2-nfraprado@collabora.com>
 <30978e5a-18ef-3ea2-8df3-3ced50f44bfc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30978e5a-18ef-3ea2-8df3-3ced50f44bfc@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 10:15:51AM +0200, Krzysztof Kozlowski wrote:
> On 11/05/2022 21:54, Nícolas F. R. A. Prado wrote:
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> >  
> > -if:
> > -  properties:
> > -    compatible:
> > -      enum:
> > -        - mediatek,mt8183-scp
> > -        - mediatek,mt8192-scp
> > -then:
> > -  required:
> > -    - clocks
> > -    - clock-names
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - mediatek,mt8183-scp
> > +            - mediatek,mt8192-scp
> > +    then:
> > +      required:
> > +        - clocks
> > +        - clock-names
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - mediatek,mt8183-scp
> > +            - mediatek,mt8186-scp
> > +    then:
> > +      properties:
> > +        reg:
> > +          maxItems: 2
> > +        reg-names:
> > +          maxItems: 2
> 
> Isn't l1tcm required on mt819x? Now it is left optional.

Hi Krzysztof,

actually l1tcm is optional for mt819x, as commented by Tzung-Bi on v4 [1]. So
that change was intended.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/CA+Px+wXQjys8xvTSSJkLXoGp4yQnANbKWBtfuxiYi0UX6DH0jw@mail.gmail.com/

> 
> 
> Best regards,
> Krzysztof
