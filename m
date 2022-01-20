Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAC549534C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiATRb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:31:29 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:47087 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiATRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:31:27 -0500
Received: by mail-oi1-f174.google.com with SMTP id w188so9823831oiw.13;
        Thu, 20 Jan 2022 09:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rtHj/3p1givutdmgN7dfHpHj4Sr+0GQQTmEECUsDQU8=;
        b=bCIedKnCbDPt0hwbo5Na7E6r+U4vCMqh2xGcTzrB/IXKkW9Y2rXg+D3kBuf9rP33j9
         ln+7xchKMEYKioHx7wEofy/JA/6HhaHMCGhMQwGJJW9jqhhcsQu0vJgUdXZq2woiHRDH
         O44MQ5xv9mksulhoPLxqBHuiptbhuW53MaEP6z7ehPxUN2UZMJTngfSAVd5qoPdow72i
         7VVuVEFa0XmSHK5RNMIQJYvBkhSuAbMbL43Uxw7qxMbXPFVIJgA7Mi6RCdRTtXlki25t
         hcx2A79xpOhRC/c1xmQE0UfoHvG3JrUEQo9UdAPy3qQy9XU4dZgJm/btmU275H2d4QWx
         P/VA==
X-Gm-Message-State: AOAM533yGz7QhiYsfHVwSGSbGKm5CuEFvAHurfx3kdEY9uNaUFhVlS8y
        uskEOnp3v5Hw4kCCuO32li3Wu5/EcQ==
X-Google-Smtp-Source: ABdhPJz0JrVrtv/SW1ltBRnOqrsXbV3PfB5TuV4nUvYOLOnOnHc+aEXebylUjJO/OUJECgNeRihxUw==
X-Received: by 2002:a05:6808:204:: with SMTP id l4mr8476896oie.96.1642699886883;
        Thu, 20 Jan 2022 09:31:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v15sm1618111ote.33.2022.01.20.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:31:26 -0800 (PST)
Received: (nullmailer pid 1641082 invoked by uid 1000);
        Thu, 20 Jan 2022 17:31:25 -0000
Date:   Thu, 20 Jan 2022 11:31:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Peter Chen <peter.chen@kernel.org>
Subject: Re: [PATCH] of: Check 'of_node_reused' flag on of_match_device()
Message-ID: <YemcbdZnrFevcPZI@robh.at.kernel.org>
References: <20220118173404.1891800-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118173404.1891800-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 11:34:04 -0600, Rob Herring wrote:
> Commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child
> device") caused the child device to match on the parent driver
> instead of the child's driver since the child's DT node pointer matched.
> The worst case result is a loop of the parent driver probing another
> instance and creating yet another child device eventually exhausting the
> stack. If the child driver happens to match first, then everything works
> fine.
> 
> A device sharing the DT node should never do DT based driver matching,
> so let's simply check of_node_reused in of_match_device() to prevent
> that.
> 
> Fixes: 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")
> Link: https://lore.kernel.org/all/20220114105620.GK18506@ediswmail.ad.cirrus.com/
> Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Peter Chen <peter.chen@nxp.com>
> Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
