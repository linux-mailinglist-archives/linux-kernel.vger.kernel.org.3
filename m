Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF65B55F0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiF1V7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiF1V7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:59:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1225E2251A;
        Tue, 28 Jun 2022 14:59:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q6so28450836eji.13;
        Tue, 28 Jun 2022 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2rpwnPjlltrxBnhTO6X3iXYjEJte1aFjs9YX4vq4uj0=;
        b=AY2ZtgJ+zx20TDaoSF0ooOu97YXXajZ22O4cf9ZA2B9z2f9vJ/aeB7v+c07qUEk1M5
         vc31W2mpxCw4NmqfBVU3P/g3nlKgLEph4qUbSlL+bWAuRX6fKV+HiPNROnATM+CDSgI3
         KA/4gGsMhWNjh3tuE8OL9eh3fLe+SszqeHS24odRQ9xVXHpOFs0EIiqpjunqsulLK8vn
         Mx55h2+ZijNvLnT2jaehOXm9yI54ObK1wXP9Up0W6QMMOtotrGU5xLMkqqA4qXhL9nYv
         4NCiNvcjhv7J98sjaaghu76BYrKgnrgNwy2D3szboGry+j0yPmqQqYzE9f9xhWfTLoQm
         t8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2rpwnPjlltrxBnhTO6X3iXYjEJte1aFjs9YX4vq4uj0=;
        b=3zpL6JB294+0471SQWswTF0XzQiO/e09XjodOBFByIwuft0Ej3yZrKaO54auBmqg1n
         PS0lixvaQ4Mi87rJCyWJgPZXZu+5BjWpf3GIS9nSXJn+ZZ6yZq0+IE9FKGULCQ6SFnHI
         4X1D6g71GyTT86LubkkpbYACjqiTDmR64aTKiaQmA8HPomc7P2C7CJ99ev0BwJvdD21L
         MPhMhT98TIuwbX4DluzuG2cwbH4pbW+MIp6gHpiMTPpIRDPAo4J6RC3q9aRoZ+YDScxW
         T9M2CSBNSXxgyNCBXE4QBZgDbMGe6T+s1cGzpwSPzifL5Vd/ueoAsi2xS3QZLPUSIaNk
         LoTA==
X-Gm-Message-State: AJIora+F9LbQTJtpk16qlsRnNIMy6LIhW40GuU0He/hMvxDjQw6I2Z3L
        m9lP9jPA8a20caamkmQONOU=
X-Google-Smtp-Source: AGRyM1sIiE0XB74Yp+H8Xw9TMex5dt4RM0hniaSZS/9XDRh/Vgs1J6yF3FDW1qlimWYlo6pSVgRBeA==
X-Received: by 2002:a17:907:9620:b0:726:9316:54b7 with SMTP id gb32-20020a170907962000b00726931654b7mr221324ejc.73.1656453557501;
        Tue, 28 Jun 2022 14:59:17 -0700 (PDT)
Received: from skbuf ([188.25.231.135])
        by smtp.gmail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm6901859ejd.69.2022.06.28.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:59:16 -0700 (PDT)
Date:   Wed, 29 Jun 2022 00:59:13 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Message-ID: <20220628215913.d3oicaa6qkkgpdph@skbuf>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
 <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
 <2f2d7685e0e43194270a310034004970@walle.cc>
 <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
 <9e58f421c27121977d11381530757a6e@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e58f421c27121977d11381530757a6e@walle.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:47:59PM +0200, Michael Walle wrote:
> Horatiu, can we determine the actual number of ports (or maybe
> determine if its a LAN9668 or a LAN9662) from the hardware itself
> in an easy way? That way we wouldn't need a new compatible string,
> but could use the generic "lan966x" one.

Never seen a lan966x switch, but if it's anything like the Ocelot-1
family, you should be able to determine the port count by reading the
out-of-reset value of any register that contains a port mask which has
all ones by default (any of the PGIDs in the multicast/flooding
destinations range, or the VLAN table port masks for any VLAN ID).

Or you can read the size of the packet buffer and infer from that which
switch model it is, based on a driver hardcoded lookup table. I fully
expect a switch with fewer ports to have smaller packet buffer. See
ocelot_detect_features() for an example of registers I am talking about.
Maybe lan966x has something similar.

Of course these are just band aids and it would still be good to modify
the device trees with the proper
	compatible = "microchip,lan9668-switch", "microchip,lan966x-switch";
rather than rely on educated guesswork (which is still guesswork, after all).
