Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E730746F2FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbhLIS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLIS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:28:42 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3697C061746;
        Thu,  9 Dec 2021 10:25:08 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m25so6093470qtq.13;
        Thu, 09 Dec 2021 10:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tY3Uj57fP/HW8NzRsCUcgjaQafL0bIk8XDbY/Pd7ACE=;
        b=QryBhz3Xqfd4fQ0HZA1L9YeanmPSAQPQQccArGMyyDF2W+7UyhDWjPiK7yky70y0cW
         VqPV9XOFn+DD26ZOViHGxYHFnnRUuZDodtNlNyyRh15siVli3AzUdrcuL1z9UC6jdgIv
         bUoHyL6IuVd94gjcpa0KWRm8QZEb79P/+S1rOG7wmzugvZjyNSd6+uflDF0gRVe617tT
         XwaBmoTwvmii51heLs05d7KTSELlQ4MkK4QGkWDyG0toEXLTWRZwztoUAX4JokN7yamI
         cNwuDC8DDYgrHvQqdKjv2WILMCmzQofK//+a/lkwFu1WOvDMTSb6nrNVx+9bC6l+p7GG
         H+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tY3Uj57fP/HW8NzRsCUcgjaQafL0bIk8XDbY/Pd7ACE=;
        b=w+2nAaY1P0+QZhw3F9vqgolIg/hDnxG2cOlOrk8urQ9/h2bQR8L230QMrmO8r0+3F7
         KmPdPZlnoeWzLSCTc37+L58pgUyeQvSkFQWPKQQRFftiorNIr9/0tl35/pUEvs/G4bxj
         Q2bPRo7p5J816VDEnsu0Y3Zx5GwSadFVc9a4pv+RNgeaxeZjTkc+r8I71PHD/5Lf1TaT
         PQHjmUxYpfqjva1ntJs7XL7MNVXMkYKdIMAR8y8H+izmrSfCWSAtar8GVhc8q+o05AXm
         1UmmL+qkXUl2mfm7NAr7o1XYClroM5iIEXWAftwnJkB84G2L2TdpOTxW0S6QoHypZwB+
         9TJQ==
X-Gm-Message-State: AOAM533tEpGcZMWELovV3K5agHe7AbWdC1Sq95OA6izjWZAQ6yUEFxOf
        EgM8QIflayKd0xvDr9yUCzU=
X-Google-Smtp-Source: ABdhPJw9rRcXu4b7ubdzWIhDayDhLG2/5CbNs1jDNpnbUQyq3/1A3IHPJP1WWUvPycpWEFqW1fwa0g==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr19589500qta.437.1639074307876;
        Thu, 09 Dec 2021 10:25:07 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id m9sm309862qtn.73.2021.12.09.10.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 10:25:07 -0800 (PST)
Date:   Thu, 9 Dec 2021 13:25:01 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        mdudek@internships.antmicro.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mateusz Holenko <mholenko@antmicro.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Message-ID: <YbJJ/UqCeFJa5HGF@errol.ini.cmu.edu>
References: <20211208132042.3226275-1-gsomlo@gmail.com>
 <20211208132042.3226275-3-gsomlo@gmail.com>
 <1639004806.166681.596177.nullmailer@robh.at.kernel.org>
 <YbFXERe0K3rfzZem@glsvmlin.ini.cmu.edu>
 <CAMuHMdVJZdzRMedn9L_Jb=0MYB_Bxs90v+iH7UaDBzup-qzp8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVJZdzRMedn9L_Jb=0MYB_Bxs90v+iH7UaDBzup-qzp8A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:37:27AM +0100, Geert Uytterhoeven wrote:
> Hi Gabriel,
> 
> On Thu, Dec 9, 2021 at 2:08 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > ... which took care of the bulk of the error messages reported. However,
> > I'm still getting the one below, whether or not I leave the `maxItems 1`
> > line there under `clocks:`
> >
> > $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-  dt_binding_check
> >   LINT    Documentation/devicetree/bindings
> >   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > /home/somlo/linux/Documentation/devicetree/bindings/clock/litex,clock.yaml: properties:clock-output-names: {'description': 'List of strings of clock output signal names indexed by the first cell in the clock specifier.', 'minItems': 1, 'maxItems': 7, 'items': [{'const': 'CLKOUT0'}, {'const': 'CLKOUT1'}, {'const': 'CLKOUT2'}, {'const': 'CLKOUT3'}, {'const': 'CLKOUT4'}, {'const': 'CLKOUT5'}, {'const': 'CLKOUT6'}]} should not be valid under {'required': ['maxItems']}
> >         hint: "maxItems" is not needed with an "items" list
> >         from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > /home/somlo/linux/Documentation/devicetree/bindings/clock/litex,clock.yaml: ignoring, error in schema: properties: clock-output-names
> > warning: no schema found in file: ./Documentation/devicetree/bindings/clock/litex,clock.yaml
> >   DTEX    Documentation/devicetree/bindings/mmc/litex,mmc.example.dts
> >   DTEX    Documentation/devicetree/bindings/media/renesas,imr.example.dts
> >   ...
> 
> --- a/Documentation/devicetree/bindings/clock/litex,clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/litex,clock.yaml
> @@ -45,7 +45,6 @@ properties:
>        List of strings of clock output signal names indexed
>        by the first cell in the clock specifier.
>      minItems: 1
> -    maxItems: 7
>      items:
>        - const: CLKOUT0
>        - const: CLKOUT1
> 
> I have that in my local tree, but hadn't sent it to you yet, because
> litex,clock definitely need more work.
> 
> > It appears as though `make dt_binding_check` is trying to read from
> > `Documentation/devicetree/bindings/clock/litex,clock.yaml`, which
> > does not exist. The clock reference I'm talking about could be *any*
> 
> Oh, it does exist in your tree ;-)
> To check the examples, it has to apply all other binding files that
> might apply, hence some checks are always run.
> 
> You can avoid some (but not all) such checks by adding
> 
>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/path/to/binding.yaml
> 
> > clock elsewhere in the dts!
> >
> > This wasn't part of the originally reported errors, not sure why I'm
> > seeing it now. Also, not sure what (if anything) I still need to do
> > about it, any advice much appreciated!
> 
> Of course, as Rob doesn't have that file in his tree.

Oh, I'm working on the `litex-rebase` branch, which does have the
litex,clock file. Running the check on the Linus master with litex_mmc
v4 on top now passes the check without any errors or warnings. I'll
incorporate the fixes pointed out by Rob when I publish v4.

Sorry for the misunderstanding, thanks Geert for pointing out the
source of my confusion -- I think all's well now on the dt-bindings
front w.r.t. litex_mmc... :)

Cheers,
--Gabriel
