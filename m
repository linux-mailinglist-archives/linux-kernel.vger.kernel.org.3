Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F360543A22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiFHRU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiFHRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:20:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255B44B979
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:08:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u2so18876217pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WF0RJla2oohMUn0MJv8rKYykIuR4lAmipthSFfnmiVU=;
        b=ljLJW0sL8NMXgQOt9f+zRCmJO50/PXowFcD4/QA46kqBPGof6uWEKlImxcs74TyV6z
         ugR7xf1sjKW23f+3OUb+SNoGJLZb/n2XEgdiJ85CN9nWx+EbNzqFJv7V+jBeIY5drPjC
         DOQsGx5dB3xTghvaIYzNBgRb/ogigexSYAx34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WF0RJla2oohMUn0MJv8rKYykIuR4lAmipthSFfnmiVU=;
        b=XwFeR7IVOsoiI4qmBXSnD18QvS+49pPj2R7MKviGJgZTi9vA08Nmi4qDBhW6x0jxv6
         xVm/s8/3wVMpES8RfvlxV1emz8hAI8rcUrkEXIYfXMwv54hh8y68tQ38H2lTv36ahIGO
         Lm3d6MtkvxCWELfPsTjPRptvNTckpFYLMU09sPHWtEtq4wd9eV1nYT9FezbRj11wnIZl
         NWAl6L86zYlFos1g3m+4k0kDfhE5yv+OUqsJ3C7FP37y16TOX/ySKeHzpBQS+bDQmzQI
         /zf7j3EuN/Igr+6jjmJenxhxlvH+9ga5MvtcFk2Vz+tCLFle9X9nNVDYkOdw37zdCvkE
         WQkQ==
X-Gm-Message-State: AOAM530AHSnZvcSr7Q83iHU2HiqQNumtqNuEbYNMkL+BnKLEhlIx/H0w
        67WKRrhi0pxNvVpgq7qQuDguVw==
X-Google-Smtp-Source: ABdhPJy/e3J9zrHD59CzKJz+zzlVENMog9HQc2BMCmxEhETwD0FomiEyVUlscJH5sJcpsdfkzRRVfw==
X-Received: by 2002:a63:f14a:0:b0:3fd:d2aa:6b30 with SMTP id o10-20020a63f14a000000b003fdd2aa6b30mr12839836pgk.348.1654708095078;
        Wed, 08 Jun 2022 10:08:15 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d2-20020a630e02000000b003fa95b940bdsm15361474pgl.88.2022.06.08.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 10:08:14 -0700 (PDT)
Date:   Wed, 8 Jun 2022 17:08:12 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH 4/7] dt-bindings: drm/bridge: anx7625: Add mode-switch
 support
Message-ID: <YqDXfGa9bugnLFGH@chromium.org>
References: <20220607190131.1647511-1-pmalani@chromium.org>
 <20220607190131.1647511-5-pmalani@chromium.org>
 <fbc48d41-b2cc-86f6-5f1c-7cfcbdb41e46@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc48d41-b2cc-86f6-5f1c-7cfcbdb41e46@linaro.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for looking at the patch.

On Jun 08 11:24, Krzysztof Kozlowski wrote:
> On 07/06/2022 21:00, Prashant Malani wrote:
> > Analogix 7625 can be used in systems to switch USB Type-C DisplayPort
> > alternate mode lane traffic between 2 Type-C ports.
> > 
> > Update the binding to accommodate this usage by introducing a switch
> > property.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  .../display/bridge/analogix,anx7625.yaml      | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > index 35a48515836e..7e1f655ddfcc 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > @@ -105,6 +105,26 @@ properties:
> >        - port@0
> >        - port@1
> >  
> > +  switches:
> > +    type: object
> > +    description: Set of switches controlling DisplayPort traffic on
> > +      outgoing RX/TX lanes to Type C ports.
> > +
> > +    properties:
> > +      switch:
> 
> You allow only one switch with such schema, so no need for "switches"...

See below comment (summary: we'd like to allow 1 or 2 switches).
> 
> > +        $ref: /schemas/usb/typec-switch.yaml#
> > +        maxItems: 2
> 
> Are you sure this works? what are you limiting here with maxItems? I
> think you wanted patternProperties...

Yeah, I might not have used the DT syntax correctly here.
What I'm aiming for is:
"switches" should can contain 1 or 2 "switch" nodes.
2 is the maximum (limitation of the hardware).

> 
> > +
> > +        properties:
> > +          reg:
> > +            maxItems: 1
> > +
> > +        required:
> > +          - reg
> > +
> > +    required:
> > +      - switch@0
> 
> This does not match the property.
> 
> You also need unevaluatedProperties:false

Ack, will update this in the next version.

> 
> 
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -167,5 +187,41 @@ examples:
> >                      };
> >                  };
> >              };
> > +            switches {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +                switch@0 {
> > +                    compatible = "typec-switch";
> > +                    reg = <0>;
> > +                    mode-switch;
> > +
> > +                    ports {
> > +                        #address-cells = <1>;
> > +                        #size-cells = <0>;
> > +                        port@0 {
> > +                            reg = <0>;
> > +                            anx_typec0: endpoint {
> > +                              remote-endpoint = <&typec_port0>;
> 
> Messed up indentation. Your previous patch should also switch to 4-space
> as recommended by schema coding style.

Sorry about that, will fix up the indentation in the next version.

> 
> > +                            };
> > +                        };
> > +                    };
> > +                };
> > +                switch@1 {
> > +                    compatible = "typec-switch";
> > +                    reg = <1>;
> > +                    mode-switch;
> > +
> > +                    ports {
> > +                        #address-cells = <1>;
> > +                        #size-cells = <0>;
> > +                        port@0 {
> > +                            reg = <0>;
> > +                            anx_typec1: endpoint {
> > +                              remote-endpoint = <&typec_port1>;
> 
> Ditto.
> 
> > +                            };
> > +                        };
> > +                    };
> > +                };
> > +            };
> >          };
> >      };
> 
> 
> Best regards,
> Krzysztof
