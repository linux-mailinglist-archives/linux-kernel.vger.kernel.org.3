Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A974B4AFFC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiBIWBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:01:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiBIWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:01:06 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C435DF8E3FF;
        Wed,  9 Feb 2022 14:01:05 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id u3so3950326oiv.12;
        Wed, 09 Feb 2022 14:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ph17us2VYP151+oagxeJOEGgmWDg7hvLO4GbsmqrUTk=;
        b=6yICeb7G1p1FtEbKEu4zBtRgke6vmP4jp+w9w7Tey1Ymo13xvEy0BwEmWgpIJgvhwU
         nNb2V0NHbdPTyx38+XoHKKRzTr1EzGdDhD5UT5uE4eXlFTRSgck/5w8yFmwF0yvy+yEp
         m9rCgJ4qhc1lAe5orL6nKk/i4OzgbTKxkVOjcN2BHNniLbVLqUHtPXTW8hI5OmhGV7u5
         MQqPZdYLMhNARbrYJhMC866CIXugHVDxXFTW/1Iig8FYcuQ3TvhD6V99zs2CXponruuQ
         RR0pvmme+GGhR8nEo1LXT5sgXALzFwLj+spmYXcPx3ozwwdPPYQdRaUBzdAIFDb6KBWT
         hfmQ==
X-Gm-Message-State: AOAM531bG0EXaMWRSrYQgcCr3fZOtAjFyq88a1hWld5Y1Hze+LhMt8Ws
        tKiq1i1VOnDy7BriPIPapw==
X-Google-Smtp-Source: ABdhPJw1Q8wxmJWgC1W5LJv4r1904ASF7Q897ixVqzlgOVnzH4Uml8NnR8gpAalstpD1jK7m6IdoWg==
X-Received: by 2002:a05:6808:1719:: with SMTP id bc25mr2567838oib.323.1644444064633;
        Wed, 09 Feb 2022 14:01:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj8sm7592435oib.20.2022.02.09.14.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:01:03 -0800 (PST)
Received: (nullmailer pid 1005143 invoked by uid 1000);
        Wed, 09 Feb 2022 22:01:02 -0000
Date:   Wed, 9 Feb 2022 16:01:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCHv2] dt-bindings: clock: Add binding for TI clksel
Message-ID: <YgQ5no/7cEW4yRrM@robh.at.kernel.org>
References: <20220203073929.59296-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203073929.59296-1-tony@atomide.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2022 09:39:29 +0200, Tony Lindgren wrote:
> In order to prepare for fixing lots of devicetree unique_unit_address
> warnings for the TI clock nodes, let's add a binding for the TI clksel
> clocks. This allows us to move the overlapping reg properties for the
> component clocks to be children of the related clksel nodes. And with
> that we need the reg property only for the parent clksel node making
> the reg property unique like it should be.
> 
> We want to set #clock-cells = <2> in case we ever start parsing ranges
> of clkcsel instances directly using a clksel driver rather than using the
> existing component clock drivers and child nodes.
> 
> And before the devicetree files can be updated, we need to update the
> TI clock drivers to get the IO address from the parent clksel node.
> 
> Cc: Tero Kristo <kristo@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since V1:
> 
> - Set additionalProperties to type object as suggested by Rob
> 
> - Changed #clock-cells to 2 for parsing ranges of clksel instances
> 
> - Updated patch description for more info on why this is needed
> 
>  .../bindings/clock/ti/ti,clksel.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
> 

Applied, thanks!
