Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931FD48F854
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiAORWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:22:55 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34516 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiAORWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:22:47 -0500
Received: by mail-oi1-f171.google.com with SMTP id r131so17077005oig.1;
        Sat, 15 Jan 2022 09:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=D9KUhQV6nwKiCBSkUr0wqIeB2WR6mroATQn2jKF4UxE=;
        b=Sfsh0tSk/v5njWLOW7cmzXDMKu9o6e1f8d5fWSGSx49YkLUad2PiwF84si1PeQqhLu
         87Xi7GuquyWFek08EZg+eUE8jk75GQLjEhZcYlJf17/P1CqWCm31eED1SpqDzcYmQ3Uh
         eWoJl5HKSse6AKaGyzPSGApiO3z/qU5HlcULkx+GAMi+a1uvBo+vcG0TrxFIB30/ozXk
         np1txjdiBIt/InEmtuE878NUCHpC40mDIZz4qT6zmGar2dCtm1sn2IacCCTVorbiiNZX
         4Bkkpg/46FLVThSvJw2wXyi3yt1++to8YEs+HsHGYEpkIBd8BwUB32TexhCJjLUDrjr4
         SEuQ==
X-Gm-Message-State: AOAM533InUg/akWLpxLICZ+m4GL1YFbLveG82BQ8//BHIxc47ssZyqOb
        xXNMNyhiUEvNKl+x6ZBglg==
X-Google-Smtp-Source: ABdhPJxOoG4k9FRod8uJApGwVpA3HZfYGEPxP6WWT0ZeH98SGk/oSFiVXje2uXnwcnaifRMr6S0+Dw==
X-Received: by 2002:a05:6808:22a2:: with SMTP id bo34mr11628503oib.119.1642267365914;
        Sat, 15 Jan 2022 09:22:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a6sm3724294oil.6.2022.01.15.09.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 09:22:44 -0800 (PST)
Received: (nullmailer pid 119894 invoked by uid 1000);
        Sat, 15 Jan 2022 17:22:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
In-Reply-To: <20220114170941.800068-2-sean.anderson@seco.com>
References: <20220114170941.800068-1-sean.anderson@seco.com> <20220114170941.800068-2-sean.anderson@seco.com>
Subject: Re: [PATCH 1/4] dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
Date:   Sat, 15 Jan 2022 11:22:30 -0600
Message-Id: <1642267350.947198.119893.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 12:09:38 -0500, Sean Anderson wrote:
> The vbus-regulator property was never actually read from the device tree.
> Introduce a new property vbus-supply to represent the regulator powering
> the VBUS when acting as an A-Device. This supply will be enabled and
> disabled as necessary. Note that this is different from vbus-regulator,
> which represented the available current available to draw from VBUS in
> B-Device mode. Because no one was using vbus-regulator, remove it.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml:37:15: [error] empty value in block mapping (empty-values)
./Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml:40:9: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/usb-nop-xceiv.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 46, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: mapping values are not allowed in this context
  in "<unicode string>", line 40, column 9
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/usb/usb-nop-xceiv.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 40, column 9
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml: ignoring, error parsing file
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1580217

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

