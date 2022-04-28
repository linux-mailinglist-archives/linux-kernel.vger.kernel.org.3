Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435835136E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbiD1Oc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348377AbiD1OcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:32:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4168E18B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:29:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r11-20020a05600c35cb00b0039409c1111bso2181341wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dVispo4pExieFIRpZv+TTvYPHYnQEg3ZSO24r5MG9HI=;
        b=XOGh55ExQa+tofFCzqAGnXzAnxRtFuFbXMauBFYn4C8d5jAFFKNLF1bPK707nqOghq
         KknIBsABhTu2gShNJhMsd8kVuNuB86W6ZJ4iiLclp2Sb8zJ3/SOWkCODef0DqaTi/B88
         WEMPV8Xd3PYNdTOndRnVZdCG1/niL0tU/Pi74KVZkcW1gzdEvOEe3BsIxA4Jh9eDFKSd
         PXLgPRfcRJa0Ud8DqsOT3qwK6rgiyED7CDLDW9ffUj7SaDvLR3CA1agyzSTXXGT8eT1x
         qzDavcoSdK39sDKZ/cwgTC6tqW3Qc7QMkPnKzkcDEuAq+tfHhZXV1/KACHsnlIzNvX40
         rW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dVispo4pExieFIRpZv+TTvYPHYnQEg3ZSO24r5MG9HI=;
        b=ETdzQIg/05Np8GgZNXf5rI7jQoIypUuoJikALcfhNVQFEMk4ZMrblv0GozachZj8V3
         noIo/g1WLqf55wVuh1vZWyE+odI0NdjGMuPIAeBvsako/B9GOwIecbDlmtA2JCRdmHGG
         kOySHjKkkFBY/WNzGWtm29ZTF1WZXbknfgrBYfXCqb5ySz/1UaR6sUTBPNxIKTANwHd8
         ICDZPFhMdfHj6isw68xbjAlHKs7ghQH1x6B6lsnflUkq1NQWcAaM3YTFj+E47+9nmM33
         OYYvWRmkQrN4oMF8irK7eF6i+6STDEop0JwbxBkGLqETWJXuaAlVdY31u8gtcxZkWYIy
         ey7A==
X-Gm-Message-State: AOAM530UU2/NLVGR3dfoxch1NVJRAxi4J+PoW8ncrUl+Xu39LBxd/teV
        Bir1qLA89LDGhuEW/tvEw/LfZmzxD+cyDsim
X-Google-Smtp-Source: ABdhPJznWuJwk+EOYl5jsLHjb72Oqs8o0ksUJ6DBPP2VSQlw2fgQYnjSfMfqTwudzTMXYdd8eh3NYg==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id c4-20020a7bc844000000b0037bb9867726mr32455609wml.160.1651156147203;
        Thu, 28 Apr 2022 07:29:07 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id bs14-20020a056000070e00b0020af0a49c3bsm12585wrb.75.2022.04.28.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:29:06 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:29:05 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org, maz@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: vm-wdt: Add qemu,vm-watchdog
 compatible
Message-ID: <Ymqksfth+sj5JOWo@google.com>
References: <20220425134204.149042-1-sebastianene@google.com>
 <20220425134204.149042-2-sebastianene@google.com>
 <YmbonypWxzZJbjQ1@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmbonypWxzZJbjQ1@robh.at.kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:29:51PM -0500, Rob Herring wrote:
> On Mon, Apr 25, 2022 at 01:42:05PM +0000, Sebastian Ene wrote:
> > The stall detection mechanism allows to configure the expiration
> > duration and the internal counter clock frequency measured in Hz.
> > Add these properties in the schema.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  .../devicetree/bindings/misc/vm-wdt.yaml      | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/vm-wdt.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/vm-wdt.yaml b/Documentation/devicetree/bindings/misc/vm-wdt.yaml
> > new file mode 100644
> > index 000000000000..cb7665a0c5af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/vm-wdt.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/vm-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: VM watchdog
> > +
> > +description: |
> > +  This binding describes a CPU stall detector mechanism for virtual cpus.
> > +
> > +maintainers:
> > +  - Sebastian Ene <sebastianene@google.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qemu,vm-watchdog
> > +  clock:

Hi,

> 
> 'clocks' is already a defined property and 'clock' is too close. It's 
> also ambiguous what it is. 'clock-frequency' instead perhaps.
> 

Yes, I think 'clock-frequency' is a better name. I will update it.

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The watchdog internal clock measure in Hz used to decrement the
> > +      watchdog counter register on each tick.
> > +      Defaults to 10 if unset.
> > +  timeout-sec:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The watchdog expiration timeout measured in seconds.
> > +      Defaults to 8 if unset.
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    watchdog {
> > +      compatible = "qemu,vm-watchdog";
> > +      clock = <10>;
> > +      timeout-sec = <8>;
> 
> How does one access this 'hardware'?
> 

This is a MMIO device.

> Why does this need to be in DT?
> 
> We have DT because h/w designers are incapable of making h/w 
> discoverable. Why repeat that problem with s/w interfaces?
> 

We need to have this one in the DT because in a secure VM we only load
trusted DT components. 

> Rob

Thanks,
Sebastian
